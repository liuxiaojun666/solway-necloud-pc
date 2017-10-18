<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript">
$('#disStartDateList').datetimepicker({
    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
   	autoclose: true
});
$('#disEndDateList').datetimepicker({
    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
   	autoclose: true
});
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
				url : "${ctx}/Optask/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
					promptObj('success', '',json.message);
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
	function cancelRow(id) {
		if (confirm("确定要作废这条数据吗？")) {
			singlecan(id);
		}
	}
	function singledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/Optask/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '',json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}

	function singlecan(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/Optask/cancel.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '',json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}
	//点击处理按钮，更新派工任务为处理中
	function tradio(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/Optask/updateStatus.htm",
			data : {
				"id" : id,
				"taskstatus" : 02
			},
			dataType : "json",
			success : function(json) {
			},
			error : function() {
				promptObj('error', '',"打开失败");
			}
		});
	}
	
	app.controller('taskSettlementCtrl', function($scope, $http, $state) {
		$scope.createManufacturer = function(id, name) {
			$state.go("app.addTaskSettlement", {
				manId : id
			});
		}
		$scope.viewTask = function(id,backUrl) {
			$state.go("app.viewTask", {
				InId : id,
				backUrl :backUrl
			});
		}
		//任务受理List
		$scope.taskRespManList = function(id,backUrl) {
			 tradio(id);
			$state.go("app.taskRespMan", {
				InId : id,
				backUrl :backUrl
			});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.cancelRow = function(id) {
			cancelRow(id);
		}
		$scope.editData = function(id,modalId) {
			editData(id,modalId);
		}
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			var disStartDate=null;
			var disEndDate=null;
			if($("#disStartDateList").val()!=null&&$("#disStartDateList").val()!=""){
				disStartDate	=$("#disStartDateList").val()+" 00:00" 
			}
			if($("#disEndDateList").val()!=null&&$("#disEndDateList").val()!=""){
				disEndDate	=$("#disEndDateList").val()+" 23:59" 
			}
			$http({
				method : "POST",
				url : "${ctx}/Optask/taskSettlementList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					pstationname : $scope.stationName,
					distStart :disStartDate,
					distEnd :disEndDate,
					keyWords : $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		//get first page
		$scope.onSelectPage(1);
	});
</script>
<!-- 弹出层界面 -->
<div id="taskSettlementEdit" data-ng-include="'${ctx}/tpl/maintenancePage/taskSettlement/addTaskSettlement.jsp'"></div>
<%-- <div id="taskSettlementEdit" data-ng-include="'${ctx}/tpl/maintenancePage/taskSettlement/addRespMan.jsp'"></div> --%>
<div ng-controller="taskSettlementCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">派工任务</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-4 m-b-xs w-sm p-r-sm">
					<!-- <button class="btn btn-sm btn-info" onclick="addData('taskSettlementModal');">新增</button> -->
					<button class="btn btn-sm btn-default"	onclick="deleteBatch('');">批量删除</button>
				</div>
				<div class="col-sm-3 no-padder">
					<div class="col-sm-9  no-padder">
						<div class="input-group p-r-sm">
							<input type="text" ng-model="keyWords" id="keyWords"
								class="input-sm form-control" placeholder="关键字"> <span
								class="input-group-btn">
								<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);"
									type="button">查询</button>
							</span>
						</div>
					</div>
					<a class="col-sm-3 text-info no-padder cwsearch"
						onclick="showSearch()"> <span class="searchTitle "><button
								class="btn btn-sm  btn-default">更多查询</button></span></a>
				</div>
				<div class="col-sm-5 pull-right">
				<%@ include file="/common/pager.jsp"%></div>
			</div>
			<div class="row hideSearchDiv wrapper">
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">电站名称</button>
						</span> <input type="text" ng-model="stationName" id="stationName"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">派工开始时间</button>
						</span> <input style="width: 90px" type="text" ng-model="disStartDateList" id="disStartDateList"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">派工结束时间</button>
						</span> <input type="text" style="width: 90px" ng-model="disEndDateList" id="disEndDateList"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-1">
					<button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
				</div>
			</div>
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th style="width: 20px;"><label class="i-checks m-b-none">
									<input type="checkbox" id="all"
									onclick="changeAll(this.checked,'ids');" /><i></i>
							</label></th>
							<th>任务单号</th>
							<th>电站名称</th>
							<th>派工时间</th>
							<th>派工人</th>
							<th>受理人</th>
							<th>任务状态</th>
<!-- 							<th>状态</th> 
							<th>操作</th>-->

						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in data ">
							<td><label ng-if="vo.taskstatus=='00'" class="i-checks m-b-none">
								<input type="checkbox" name="ids" id="ids" value="{{vo.id }}" /> <i></i>
							</label>
							</td>
							<td ng-bind="vo.taskno" class="href-blur a-cur-poi" ng-click="viewTask(vo.id,0)"></td>
							<td ng-bind="vo.pstationname"></td>
							<td ng-bind="vo.distdate | date:'yyyy-MM-dd HH:mm'"></td>
							<td ng-bind="vo.distManName"></td>
							<td ng-bind="vo.respManName"></td>
							<td>
							<span ng-if="vo.taskstatus=='00'">待受理</span>
							<span ng-if="vo.taskstatus=='01'">待处理</span>
							<span ng-if="vo.taskstatus=='02'">处理中</span>
							<span ng-if="vo.taskstatus=='03'">已完成</span>
							</td>
<!-- 							<td> -->
<!-- 							<span ng-if="vo.status=='00'">临时</span> -->
<!-- 							<span ng-if="vo.status=='01'">正式</span> -->
<!-- 							<span ng-if="vo.status=='02'">报废</span> -->
<!-- 							</td> -->
<!--							<td>
							<a ng-if="vo.taskstatus=='00'" class="text-info"><i class="icon-note" ng-click="editData({{ vo.id }},'taskSettlementModal');" ></i></a>
							<a ng-if="vo.taskstatus=='00'" class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
							<a ng-if="vo.taskstatus!='03' && vo.currentUserId==vo.respman" class="text-info"><i class="icon-wrench" ng-click="taskRespManList(vo.id,0);" ></i></a>
 							<a class="text-info"><i class="icon-pencil" ng-click="cancelRow({{vo.id}});"></i></a> 
							</td> -->
						</tr>
					</tbody>
				</table>
				</paging>
			</div>
		</div>
	</div>
