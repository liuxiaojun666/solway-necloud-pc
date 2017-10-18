<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	function goPage(pageIndex) {
		$("#searchBtn").trigger("click");
	}

	function deleteBatch() {
		var conti = checkSelectMsg("ids", "请至少选择一条记录!");
		if (conti) {
			conti = confirm("确定要删除这些记录吗?");
		}
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/OpEntrust/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
					promptObj('success', '', json.message);
					goPage(0);
				},
				error : function(json) {
					promptObj('error', '',"删除失败");
				}
			};
			$.ajax(options);
		}
	}

	function deleteRow(id) {
		if (confirm("确定要删除这条数据吗？")) {
			singledel(id);
		}
	}
	function singledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/OpEntrust/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '', json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '', "删除失败");
			}
		});
	}

	app.controller('opentrustCtrl', function($scope, $http, $state) {
		$scope.createData = function(comId){
			  $state.go("app.addOpentrust",{comId:comId});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.editAuthority = function(id, modalId) {
			initAuthorityPageData(id);
			showModal(modalId);
		}
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if (!page) {
				page = 1;
				$scope.currentPage = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/OpEntrust/opentrustList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					userType : $scope.userTypeS,
					userName : $scope.userNameS,
					pstationid : $scope.pstationidS,
					keyWords : $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope, result);
			});
		};
		$scope.onSelectPage(1);
	});
</script>
<style type="text/css">
.table .t_center {
	text-align: center;
}
.table .t_right {
	text-align: right;
}
.table .t_left {
	text-align: left;
}
</style>
<div ng-controller="opentrustCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">运维委托协议 </span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-4 m-b-xs p-r-sm" style="width: 300px;">
					<button class="btn btn-sm btn-info m-r-xs" ng-click="createData();">新增</button>
					<button class="btn btn-sm btn-default" onclick="deleteBatch('');">批量删除</button>
				</div>
				<div class="col-sm-3 no-padder">
					<div class="col-sm-9 no-padder ">
						<div class="input-group p-r-sm">
							<input type="text" ng-model="keyWords" id="keyWords"
								class="input-sm form-control" placeholder="关键字"> <span
								class="input-group-btn">
								<button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);"
									type="button">查询</button>
							</span>
						</div>
					</div>
				</div>
				<div class="col-sm-5 pull-right">
					<%@ include file="/common/pager.jsp"%></div>
			</div>
			<div>
				<paging class="col-sm-12 panel no-padder">
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th style="width: 20px;"><label class="i-checks m-b-none">
									<input type="checkbox" id="all" onclick="changeAll(this.checked,'ids');" /><i></i>
							</label></th>
							<th class="t_center">甲方</th>
							<th class="t_center">乙方</th>
							<th class="t_center">签订时间</th>
							<th class="t_center">服务开始日期</th>
							<th class="t_center">服务结束日期</th>
							<th class="t_center">甲方确认状态</th>
							<th class="t_center">乙方确认状态</th>
							<th class="t_center">记录状态</th>
							<th class="t_center">操作</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in data ">
							<td><label class="i-checks m-b-none"> 
							<input type="checkbox" name="ids" id="ids" value="{{vo.id }}" />
							<i></i></label></td>
							<td class="t_center" ng-bind="vo.jiafang"></td>
							<td class="t_center" ng-bind="vo.yifang"></td>
							<td class="t_center" ng-bind="vo.signdate|date:'yyyy-MM-dd'"></td>
							<td class="t_center" ng-bind="vo.startdate|date:'yyyy-MM-dd'"></td>
							<td class="t_center" ng-bind="vo.enddate|date:'yyyy-MM-dd'"></td>
							<td class="t_center"><span ng-if="vo.ownerconfirstatus=='00'">待确认</span><span ng-if="vo.ownerconfirstatus=='01'">通过</span><span ng-if="vo.ownerconfirstatus=='02'">拒绝</span></td>
							<td class="t_center"><span ng-if="vo.serviceconfirstatus=='00'">待确认</span><span ng-if="vo.serviceconfirstatus=='01'">通过</span><span ng-if="vo.serviceconfirstatus=='02'">拒绝</span></td>
							<td class="t_center"><span ng-if="vo.usestatus=='00'">临时</span><span ng-if="vo.usestatus=='01'">正式</span><span ng-if="vo.usestatus=='02'">作废</span></td>
							<td class="t_center">
								<a class="text-info"><i class="icon-note" ng-click="createData({{vo.id}});"></i></a>
								<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
							</td>
						</tr>
					</tbody>
				</table>
				</paging>
			</div>
			</paging>
		</div>
	</div>
</div>
