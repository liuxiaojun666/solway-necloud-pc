<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function goPage(pageIndex) {
		$("#searchBtn").trigger("click");
	}
	function deleteOtherBatch() {
		var conti = checkSelectMsg("otherids", "请至少选择一条记录!");
		if (conti) {
			conti = confirm("确定要删除这些记录吗?");
		}
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/OtherDevice/deleteBatch.htm?"
						+ $("input[name=otherids]:checked").serialize(),
				success : function(json) {
					promptObj('success', '', json.message);
					$("#searchOtherBtn").trigger("click");
				},
				error : function(json) {
					promptObj('error', '',"删除失败");
				}
			};
			$.ajax(options);
		}
	}
	

	function othersingledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/OtherDevice/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '', json.message);
				$("#searchOtherBtn").trigger("click");
			},
			error : function() {
				promptObj('error', '',"删除失败,请稍后重试!");
			}
		});
	}
	
	app.controller('OtherDeviceCtrl', function($scope, $http, $state,$stateParams) {
		$scope.broadcastSwitchStation = function () {
			$scope.onSelectPage(1);
		}
		$scope.$on("broadcastSwitchStation", $scope.broadcastSwitchStation);
		$scope.deleteOtherRow= function(id) {
			if (confirm("确定要删除这条数据吗？")) {
				othersingledel(id);
			}
		}
		$scope.toJunctionBoxMonitor = function(id,serialnumber,pstationid) {
			$state.go("app.otherDeviceDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
	$scope.editData = function(id,modalId) {
		initOtherData(id)
		$('#'+modalId).modal('show');
	}	
	$scope.addData=function(modalId){
		$("#otherpstationid").val($("#stationid").val());
		initOtherData();
		$('#'+modalId).modal('show');
	}
	$scope.createotherDevice = function(id, name) {
			$state.go("app.addOtherDevice", {
				InId : id
			});
		}
	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}
		
		var stid = $stateParams.inId;
		if(!stid){
			stid = $("#stationid").val();
			if(!stid) stid = -1;
		}
		
		$http({
			method : "POST",
			url : "${ctx}/OtherDevice/otherDeviceList.htm",
			params : {
				'pageIndex' : page - 1,
				'pageSize' : $scope.pageSizeSelect,
				name : $scope.odName,
				code : $scope.odCode,
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
<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStationView/otherDevice/addOtherDevice.jsp'"></div>
<div   ng-controller="OtherDeviceCtrl">
			<paging class="col-sm-12">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">  
          <button class="btn btn-sm btn-info" ng-click="addData('otherDeviceEdit');"> 新增</button>   
          <button class="btn btn-sm btn-default" onclick="deleteOtherBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        <div class="input-group p-r-sm">
          <input type="text" id="keyWords" ng-model="keyWords"  class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
           <button id="searchOtherBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
          </span>
        </div>
        </div>
      </div>
      <div class="col-sm-5 pull-right">
		<%@ include file="/common/pager.jsp"%></div>
    </div>
	    <table style="z-index: 2;" id="result_table" class="table-bordered table table-striped b-t b-light ">
			<thead>
				<tr>
					<th style="width: 20px;">
						<label class="i-checks m-b-none">
							<input type="checkbox" id="all" onclick="changeAll(this.checked,'otherids');" style="z-index: 1;"/><i></i>
						</label>
					</th>
					<th>编号</th>
					<th>设备名称</th>
					<th>所属电站</th>
					<th>产品型号</th>
					<th>位置</th>
					<th width="8%">操作</th>
				</tr>
			</thead>
			<tbody >
				<tr  ng-repeat="vo in data ">
					<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="otherids" id="otherids" value="{{vo.id}}" style="z-index: 1;"/>
					<i></i></label>
					</td>
					<td ng-bind="vo.code"></td>
					<td ng-if="vo.devicetype!='5'" ng-bind="vo.name">
					<td ng-if="vo.devicetype=='5'" ng-bind="vo.name" ng-click="" class="a-cur-poi href-blur">
					</td>
					<td ng-bind="vo.pstationname"></td>
					<td class="" ng-bind="vo.productname"></td>
					<td ng-bind="vo.address"></td>
					<td >
						<a class="text-info" style="z-index: 1;">
         					 <i class="icon-note" ng-click="editData({{vo.id}},'otherDeviceEdit');"></i></a>
						<a class="text-info" ng-click="deleteOtherRow({{vo.id}});"><i class="icon-trash"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
	</paging>
	</div>
