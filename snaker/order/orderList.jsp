<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="orderListCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">流程实例</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
				<div class="row wrapper">
					<div class="col-sm-4 ">
						 &nbsp;
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
							<th>实例编号</th>
							<th>实例启动时间</th>
							<th>实例结束时间</th>
							<th>期望完成时间</th>
							<th>实例创建人</th>
							<th>实例状态</th>
							<th>操作</th>
						</tr>
						</thead>
						<tbody>
						<tr ng-repeat="item in data ">
							<td>{{item.processName}}</td>
							<td>{{item.orderNo}}</td>
							<td>{{item.createTime}}</td>
							<td>{{item.endTime}}</td>
							<td>{{item.expireTime}}</td>
							<td>{{item.creator}}</td>
							<td><span ng-if="item.orderState == 0">已结束</span><span ng-if="item.orderState == 1">运行中</span></td>
							<td>
								<%--<a href="${ctx}/snaker/process/display?processId=${item.processId }&orderId=${item.id} " class="btnPict" title="查看流程图">查看流程图</a>--%>
								<%--<a href="${ctx}/snaker/all?processId=${item.processId }&orderId=${item.id}&type=cc " class="btnView" title="查看">查看</a>--%>
								<a ng-click="processDisplay(item);" class="btnPict" title="查看流程图">查看流程图</a>
								<a ng-click="processDetail(item);" class="btnView" title="查看">查看</a>
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
	app.controller('orderListCtrl', function($scope, $http, $state) {
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "get",
				url : "${ctx}/snaker/flow/order/page.htm",
				params : {
					'pageNo' : page,
					'pageSize' : $scope.pageSizeSelect,
					'keyWords' : $scope.keyWords
				}
			}).success(function(result) {
				var obj = {};
				obj.data = result.data.result;
				obj.pageIndex = result.data.pageNo - 1;
				obj.total = result.data.totalCount;
				obj.totalPage = result.data.totalPages;
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

		<%--<a href="${ctx}/snaker/process/display?processId=${item.processId }&orderId=${item.id} " class="btnPict" title="查看流程图">查看流程图</a>--%>
		<%--<a href="${ctx}/snaker/all?processId=${item.processId }&orderId=${item.id}&type=cc " class="btnView" title="查看">查看</a>--%>

		$scope.processDetail = function (item) {
			$state.go("app.flowAccess", {
				processId : item.processId,
				orderId : item.orderId,
			});
		};

		$scope.processDisplay = function (item) {
			$state.go("app.processDisplay", {
				processId : item.processId,
				orderId : item.orderId,
			});
		};
	});
</script>