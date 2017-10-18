<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function goPage(pageIndex){
		$("#searchBtn").trigger("click");
	}
	function deleteBatch(){
		var conti= checkSelectMsg("junctionids","请至少选择一条记录!");
 		if(conti){
 			conti = confirm("确定要删除这些记录吗?");
 		}
 		if(conti){
 			var options = {
 					type:"post",
 					dataType:"json",
 					url : "${ctx}/JunctionBox/deleteBatch.htm?"+$("input[name=junctionids]:checked").serialize(),
 					success:function(json){
 						promptObj(json.type, '', json.message);
 						$("#searchjunBtn").trigger("click");
 					},
 					error:function(json){
 						promptObj('error', '',"删除失败");
 					}
 				};
 				$.ajax(options);
 			}
	}
	
	function deletejunRow(id){
		if(confirm("确定要删除这条数据吗？")){
			junsingledel(id);
		}
	}
	function junsingledel(id){
		$.ajax({
			type : "post",
			url : "${ctx}/JunctionBox/delete.htm",
			data:{"id":id},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '', json.message);
				$("#searchjunBtn").trigger("click");
			},error:function(){
				promptObj('error', '',"删除失败");
			}
		});
	}
	
   var id
   var inverter;
   app.controller('JunctionBoxCtrl', function ($scope, $http,$state, $stateParams) {
		$scope.broadcastSwitchStation = function () {
			$scope.refreshData();
		}
		$scope.$on("broadcastSwitchStation", $scope.broadcastSwitchStation);
		
 		$scope.createJunctionBox = function(id,name){
			  $state.go("app.addJunctionBox",{JbId:id});
		}
	   //汇流箱监控
		$scope.toJunctionBoxMonitor = function(id,serialnumber,pstationid) {
		   $state.go("app.junctionBoxMonitor", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
	   //逆变器
		$scope.showInverter = function(id,serialnumber,pstationid) {
			$state.go("app.inverterDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		$scope.editData = function(id,modalId) {
			initJunctionData(id)
			$('#'+modalId).modal('show');
		}
		$scope.addData=function(modalId){
			$("#junpstationid").val($("#stationid").val());
			initJunctionData();
			$('#'+modalId).modal('show');
		}
		$scope.deletejunRow = function(id){
			if(confirm("确定要删除这条数据吗？")){
				junsingledel(id);
			}
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
				url : "${ctx}/JunctionBox/junctionBoxList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					inverterid:$("#invId").val(),
					name:$scope.jbName,
        			code:$scope.jbCode,
        			keyWords:$scope.keyWords,
        			pstationid :stid
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.invd = {};
    	$scope.invList = null;
    	$scope.invChange= function () {
	         $("#invId").val(angular.copy($scope.invd.selected.id));
		}
		$scope.refreshData = function(){
			/** $http({method:"POST",url:"${ctx}/Inverter/selectByStation.htm",params:{}})
			.success(function (result) {
				$scope.invList = result;
				inverter=$stateParams.inverterId
				if($stateParams.inverterId!=null&&$scope.invList!=null&&$scope.invList.length>0){
				for(var i=0,len=$scope.invList.length;i<len;i++){
						if($scope.invList[i].id==  $stateParams.inverterId){
							$scope.invd.selected= { name: $scope.invList[i].name,id:  $scope.invList[i].id};
							$scope.invChange();
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
<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStationView/junctionBox/addJunctionBoxSkip.jsp'"></div>
<div ng-controller="JunctionBoxCtrl">
	<div class="wrapper-md ng-scope">
			<paging class="col-sm-12" style="z-index: 2;">
			<div class="wrapper">
			<div class="col-sm-4 m-b-xs w-sm p-r-sm"> 
          <button class="btn btn-sm btn-info " ng-click="addData('junctionBoxModal');"> 新增</button>
          <button class="btn btn-sm btn-default " onclick="deleteBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
           	<button id="searchjunBtn" class="btn btn-sm btn-info"
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
      	 <button class="btn btn-sm btn-info" onclick="goPage(0)" type="button">查询</button>
      </div>
    </div>
	<table  id="result_table" class=" table-bordered table table-striped b-t b-light " style="border:1px solid #dee5e7;">
	<thead>
		<tr>
			<th style="width: 20px;">
				<label class="i-checks m-b-none">
					<input type="checkbox" id="all"
			onclick="changeAll(this.checked,'junctionids');" style="z-index: 1;"/><i></i>
				</label>
			</th>
			<th>编号</th>
			<th>设备名称</th>
			<th>所属逆变器</th>
			<th>产品型号</th>
			<th>组串数</th>
			<th>位置</th>
			<th width="8%">操作</th>
		</tr>
	</thead>
	<tbody>
		<tr  ng-repeat="vo in data ">
			<td>
			<label class="i-checks m-b-none">
			<input type="checkbox" name="junctionids" id="junctionids" value="{{vo.id}}" style="z-index: 1;"/>
			<i></i></label>
			</td>
			<td  ng-bind="vo.code"></td>
			<td ng-bind="vo.name" ng-click="" class="a-cur-poi href-blur"></td>
<!-- 			<td ng-bind="vo.pstationname"></td> -->
			<td class="href-blur a-cur-poi" ng-bind="vo.invertername" ng-click=""></td>
			<td class="" ng-bind="vo.productname"></td>
			<td class="text-center" ng-bind="vo.batterygcount"></td>
			<td class="" ng-bind="vo.address"></td>
			<td >
				<a style="z-index: 1;" class="text-info"><i class="icon-note" ng-click="editData({{vo.id}},'junctionBoxModal');" ></i></a>
				<a style="z-index: 1;" class="text-info m-r-xs"><i class="icon-trash" ng-click="deletejunRow({{vo.id}});"></i></a>
			</td>
		</tr>
	</tbody>
</table>
</paging>
</div>
</div>
