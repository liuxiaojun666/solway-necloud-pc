<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function deleteInverterBatch() {
		var conti = checkSelectMsg("inverids", "请至少选择一条记录!");
		if (conti) {
			conti = confirm("确定要删除这些记录吗?");
		}
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/Inverter/deleteBatch.htm?"
						+ $("input[name=inverids]:checked").serialize(),
				success : function(json) {
					promptObj(json.type, '', json.message);
					$("#searchInverterBtn").trigger("click");
				},
				error : function(json) {
					promptObj('error', '',"操作失败，请稍后重试");
				}
			};
			$.ajax(options);
		}
	}
	
	function Invertersingledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/Inverter/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '', json.message);
				$("#searchInverterBtn").trigger("click");
			},
			error : function() {
				promptObj('error', '',"操作失败，请稍后重试");
			}
		});
	}
	 var boxChange
	app.controller('InverterCtrl', function($scope, $http, $state, $stateParams) {
		$scope.broadcastSwitchStation = function () {
			$scope.refreshData();
		}
		$scope.$on("broadcastSwitchStation", $scope.broadcastSwitchStation);
		$scope.createInverter = function(id, name) {
			$state.go("app.addInverter", {
				InId : id
			});
		}
		$scope.showBoxChange = function(id,serialnumber,pstationid) {
			$state.go("app.BoxChangeDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		$scope.showInformation = function(id,serialnumber,pstationid) {
			$state.go("app.inverterDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		$scope.deleteInverterRow = function(id) {
			if (confirm("确定要删除这条数据吗？")) {
				Invertersingledel(id);
			}
		}
		$scope.editData = function(id, modalId) {
			initInverterData(id);
			$('#'+modalId).modal('show');
		}
		$scope.addData=function(modalId){
			$("#inverterpstationid").val($("#stationid").val());
			initInverterData();
			$('#'+modalId).modal('show');
		}
		$scope.viewJunctionBox = function(id) {
			$state.go("app.junctionBox", {
				inverterId : id
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
				url : "${ctx}/Inverter/inverterList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					name : $scope.inName,
					code : $scope.inCode,
					keyWords : $scope.keyWords,
					boxchangeid:$('#bcId').val(),
					pstationid : stid
				}
			}).success(function(result) {
// 				alert(JSON.stringify(result));
				getTableData($scope,result);
			});
		};
		
		$scope.boxchgd = {};
    	$scope.bcList = null;
   	 	$scope.bcChange= function () {
	         $("#bcId").val( angular.copy($scope.boxchgd.selected.id));
		} 
		$scope.refreshData = function(){
			/**$http({method:"POST",url:"${ctx}/BoxChange/selectByStation.htm",params:{}})
			.success(function (result) {
				$scope.bcList = result;
				boxChange=$stateParams.boxChangeId
				if($stateParams.boxChangeId!=null&&$scope.bcList!=null&&$scope.bcList.length>0){
					for(var i=0,len=$scope.bcList.length;i<len;i++){
						if($scope.bcList[i].id == $stateParams.boxChangeId){
							$scope.boxchgd.selected= { name: $scope.bcList[i].name,id: $scope.bcList[i].id};
							$scope.bcChange();
							showSearch();
						}
					}
				}
				$scope.onSelectPage(1);
			}).error(function(response) {
				$scope.onSelectPage(1); 
			}); */
			$scope.onSelectPage(1);
		}
		$scope.refreshData();
	});
</script>
<!-- 弹出层界面 -->     
<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStationView/inverter/addInverterSkip.jsp'"></div>
<div ng-controller="InverterCtrl">
	<div class="wrapper-md ng-scope">
			<paging class="col-sm-12" style="z-index: 2;">
			<div class=" wrapper">
			<div class="col-sm-4 m-b-xs w-sm p-r-sm"> 
          <button class="btn btn-sm btn-info " ng-click="addData('inverterModal');"> 新增</button>
          <button class="btn btn-sm btn-default " onclick="deleteInverterBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
           	<button id="searchInverterBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
          </span>
        </div>
        </div>
      </div>
      <div class="col-sm-5 pull-right">
		<%@ include file="/common/pager.jsp"%></div>
    </div>
    
       <div class="row hideSearchDiv wrapper">
        <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">编号</button>
          </span>
        <input type="text" id="bccode"  ng-model="bccode" class="input-sm form-control">
        </div>
      </div>
       <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">名称</button>
          </span>
        <input type="text" id="bcname" ng-model="bcname" class="input-sm form-control"></div>
      </div>
      <div class="col-sm-1">
      	 <button class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
      </div>
    </div>
<table id="result_table" class="border_hide table-bordered table table-striped b-t b-light" style=" border:1px solid #dee5e7;">
	<thead>
		<tr>
			<th width="5%">
				<label class="i-checks m-b-none">
				<input type="checkbox" id="all"onclick="changeAll(this.checked,'inverids');" /><i></i>
				</label>
			</th>
			<th>编号</th>
			<th>设备名称</th>
			<th width="13%"  >所属箱变</th>
			<th>产品型号</th>
			<th>容量</th>
			<th width="12%">是否小逆</th>
			<th width="8%">操作</th>
		</tr>
	</thead>
	<tbody>
		<tr  ng-repeat="vo in data ">
			<td>
			<label class="i-checks m-b-none">
			<input type="checkbox" name="inverids" id="inverids" value="{{vo.id}}"/>
			<i></i></label>
			</td>
			<td  class="text-left" ng-bind="vo.code"></td>
			<td  class="text-left"><a ng-bind="vo.name"  ng-click="" class="href-blur"></a></td>
			<td  class="text-left href-blur a-cur-poi" ng-bind="vo.boxchangename" ng-click=""></td>
			<td class="" ng-bind="vo.productname"></td>
			<td  class="text-left" ng-bind="vo.realcapacity"></td>
			<td  class="text-center" ng-bind="vo.hasJB"></td>
			<td>
				<a class="text-info"><i class="icon-note" ng-click="editData({{vo.id}},'inverterModal');" ></i></a>
				<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteInverterRow({{vo.id}});"></i></a>
<!-- 				<a class="text-info" ng-click="viewJunctionBox({{ vo.id }});"> <i class="icon iconfont">&#xe607;</i></a> -->
			</td>
		</tr>
	</tbody>
</table>
</paging>
</div>
</div>
