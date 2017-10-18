<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="activityTaskListCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">{{taskType == 0? '待办' : '协办'}}任务</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
				<div class="row wrapper">
					<div class="col-sm-4"> &nbsp;
						<%--<button class="btn btn-sm btn-info m-r-xs" ng-click="addData('systemDataInitModal');">新增</button>--%>
						<%--<button class="btn btn-sm btn-default m-r-xs" ng-click="deleteBatch();">批量删除</button>--%>
					</div>
					<div class="col-sm-3 no-padder">
						<div class="col-sm-9 no-padder">
							<div class="input-group p-r-sm">
								<input type="text" ng-model="taskName" id="taskName" class="input-sm form-control" placeholder="任务名称">
                                <span class="input-group-btn">
								<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);" id="searchBtn" type="button">查询</button>
							</span>
							</div>
						</div>
					</div>
					<div class="col-sm-5">
						<%@ include file="/common/pager.jsp"%>
					</div>
				</div>

				<div>
					<table id="result_table" class="table table-striped b-t b-light">
						<thead>
						<tr>
							<th>流程名称</th>
							<th>流程编号</th>
							<th>流程启动时间</th>
							<th>任务名称</th>
							<th>任务创建时间</th>
							<th>操作</th>
						</tr>
						</thead>
						<tbody>
						<tr ng-repeat="item in data ">
							<td>{{item.processName}}</td>
							<td>{{item.orderNo}}</td>
							<td>{{item.orderCreateTime}}</td>
							<td>{{item.taskName}}</td>
							<td>{{item.taskCreateTime}}</td>
							<td>
								<a href="${ctx}/snaker/process/display.htm?processId={{item.processId }}&orderId={{item.orderId}} " target="display" title="查看流程图">查看流程图</a>
								<a ng-click="doApproval(item);" class="btnEdit" title="处理">处理</a>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
			</paging>
		</div>
	</div>
</div>

<script>
	app.controller('activityTaskListCtrl', function($scope, $http, $state) {
		$scope.taskType = 0;
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "get",
				url : "${ctx}/snaker/task/page.htm",
				params : {
					'pageNo' : page,
					'pageSize' : $scope.pageSizeSelect,
					'taskType' : $scope.taskType,
					'keyWords' : $scope.keyWords
				}
			}).success(function(result) {
				var obj = {};
				obj.data = result.data.pageData.result;
				obj.pageIndex = result.data.pageData.pageNo - 1;
				obj.total = result.data.pageData.totalCount;
				obj.totalPage = result.data.pageData.totalPages;
				getTableData($scope, obj);
			});
		};
		//get first page
		$scope.onSelectPage(1);

		//点击  Enter  键  查询
		document.onkeydown = function(e){
			var e = window.event ? window.event : e;
			if(e.keyCode == 13){
				$scope.onSelectPage(1);
			}
		};

		$scope.doApproval = function (item) {
			$state.go("app.flowAccess", {
				processId : item.processId,
				orderId : item.orderId,
				taskId : item.taskId,
				taskName : item.taskName,
				taskKey : item.taskKey
			});
		};
	});
</script>