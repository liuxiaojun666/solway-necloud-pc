<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

	function deleteboxBatch() {
		var conti = checkSelectMsg("boxids", "请至少选择一条记录!");
		if (conti) {
			conti = confirm("确定要删除这些记录吗?");
		}
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/BoxChange/deleteBatch.htm?"
						+ $("input[name=boxids]:checked").serialize(),
				success : function(json) {
					promptObj(json.type, '', json.message);
					$("#searchboxBtn").trigger("click");
				},
				error : function(json) {
					promptObj('error', '',"删除失败");
				}
			};
			$.ajax(options);
		}
	}
	
	function deleteboxRow(id) {
		if (confirm("确定要删除这条数据吗？")) {
			boxsingledel(id);
		}
	}
	function boxsingledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/BoxChange/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '',json.message);
				$("#searchboxBtn").trigger("click");
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}
	
	app.controller('BoxChangeCtrl', function($scope, $http, $state,$stateParams) {
		$scope.broadcastSwitchStation = function () {
			$scope.onSelectPage(1);
		}
		$scope.$on("broadcastSwitchStation", $scope.broadcastSwitchStation);
		$scope.showInformation = function(id,serialnumber,pstationid) {
			$state.go("app.BoxChangeDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		$scope.deleteboxRow = function(id) {
			if (confirm("确定要删除这条数据吗？")) {
				boxsingledel(id);
			}
		}
		$scope.createBoxChange = function(id, name) {
			$state.go("app.addBoxChange", {
				InId : id
			});
		}
		$scope.editData = function(id, modalId) {
			initBoxPageData(id);
			$('#'+modalId).modal('show');
		}
		$scope.addData=function(modalId){
			$("#saveBoxButton").button('reset');
			$("#boxpstationid").val($("#stationid").val());
			initBoxPageData();
			$('#'+modalId).modal('show');
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.viewInverter = function(id) {
			$state.go("app.inverter", {
				boxChangeId : id
			});
		}
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if (page == 0) {
				page = 1;
			}
			var stid = $stateParams.inId;
			if(!stid){
				stid = $("#stationid").val();
				if(!stid) stid = -1;
			}
			$http({
				method : "POST",
				url : "${ctx}/BoxChange/boxChangeList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					name : $scope.bcname,
					code : $scope.bccode,
					keyWords : $scope.keyWords,
					pstationid : stid
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
	});
</script>
 <!-- 弹出层界面 -->     
<div id="boxChangeEdit" data-ng-include="'${ctx}/tpl/ledgerPage/powerStationView/boxChange/addBoxChange.jsp'"></div>   
<div ng-controller="BoxChangeCtrl">
	<div class="wrapper-md ng-scope">
			<paging class="col-sm-12">
			<div class="wrapper">
			<div class="col-sm-4 m-b-xs w-sm p-r-sm"> 
          <button class="btn btn-sm btn-info " ng-click="addData('boxChangeModal');"> 新增</button>
          <button class="btn btn-sm btn-default " onclick="deleteboxBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
           	<button id="searchboxBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
          </span>
        </div>
        </div>
      </div>
      <div class="col-sm-5 pull-right">
		<%@ include file="/common/pager.jsp"%></div>
    </div>
		    <table style="z-index: 2;" id="result_table" class="col-sm-12 table-bordered table table-striped">
			<thead>
				<tr>
					<th style="width: 20px;">
						<label class="i-checks m-b-none">
							<input type="checkbox" id="all"
					onclick="changeAll(this.checked,'boxids');"/><i></i>
						</label>
					</th>
					<th class="">编号</th>
					<th>设备名称</th>
					<th>产品型号</th>
					<th width="15%;">位置</th>
					<th width="8%">操作</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="vo in data ">
					<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="boxids" id="boxids" value="{{vo.id }}" />
					<i></i></label>
					</td>
					<td class="" ng-bind="vo.code"></td>
					<td ><a ng-bind="vo.name" class="href-blur " ng-click=""></a></td>
					<td class="" ng-bind="vo.productname"></td>
					<td class="" ng-bind="vo.address"></td>
					<td >
						<a  class="text-info"><i class="icon-note" ng-click="editData({{vo.id}},'boxChangeModal');"></i></a>
						<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteboxRow({{vo.id}});"></i></a>
<!-- 						<a class="text-info" ng-click="viewInverter({{ vo.id }});"><i class="icon iconfont">&#xe606;</i></a> -->
					</td>
				</tr>
			</tbody>
		</table>
    </paging>
	</div>
	</div>
