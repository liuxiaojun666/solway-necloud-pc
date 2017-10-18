<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 弹出层界面 -->     
<%-- <div data-ng-include="'${ctx}/tpl/ledgerPage/junctionBox/addJunctionBoxSkip.jsp'"></div> --%>
<div data-ng-include="'${ctx}/tpl/ledgerPage/junctionBox/junctionBoxThreshold.jsp'"></div>
<div ng-controller="JunctionBoxCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">汇流箱管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">     
          <button class="btn btn-sm btn-info" ng-click="createJunctionBox();"> 新增</button>  
          <button  class="btn btn-sm btn-default " onclick="deleteBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        <div class="input-group p-r-sm">
          <input type="text" ng-model="keyWords" id="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
         	<button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
          </span>
        </div>
        </div>
         <a class="col-sm-3 text-info no-padder cwsearch" onclick="showSearch()">
      	 <span class="searchTitle "><button class="btn btn-sm  btn-default"> 更多查询 </button></span></a>
      </div>
      <div class="col-sm-5 pull-right">
			<%@ include file="/common/pager.jsp"%>
		</div>
	</div>
      <div class="row hideSearchDiv wrapper">
        <div class="col-sm-2">
       <div class="input-group" style="width: 180px;">
         <ui-select ng-model="invd.selected" theme="bootstrap" ng-change="invChange()">
		            <ui-select-match placeholder="请选择所属逆变器..." ng-model="invd.selected.name" >{{$select.selected.name}}</ui-select-match>
		            <ui-select-choices  repeat="item in invList | filter: $select.search">
		              <div ng-bind-html="item.name | highlight: $select.search"></div>
		            </ui-select-choices>
		 </ui-select>
		 <input type="hidden" value="" id="invId" class="formData"/>
        </div>
      </div>
      <div class="col-sm-1">
      	 <button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
      </div>
    </div>
	<table id="result_table" class="table table-striped b-t b-light">
	<thead>
		<tr>
			<th style="width: 20px;">
				<label class="i-checks m-b-none">
					<input type="checkbox" id="all"
			onclick="changeAll(this.checked,'ids');" /><i></i>
				</label>
			</th>
			<th>编号</th>
			<th>设备名称</th>
<!-- 			<th>所属电站</th> -->
			<th>所属逆变器</th>
			<th>产品型号</th>
			<th class="text-center">安装时间</th>
			<th>位置</th>
			<th>操作</th>
		</tr>
	</thead>
	<tbody>
		<tr  ng-repeat="vo in data ">
			<td>
			<label class="i-checks m-b-none">
			<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
			<i></i></label>
			</td>
			<td  ng-bind="vo.code"></td>
			<td ng-bind="vo.name" ng-click="toJunctionBoxMonitor(vo.id ,vo.serialnumber,vo.pstationid);" class="a-cur-poi href-blur"></td>
<!-- 			<td ng-bind="vo.pstationname"></td> -->
			<td class="href-blur a-cur-poi" ng-bind="vo.invertername" ng-click="showInverter(vo.inverterid)"></td>
			<td class="" ng-bind="vo.productname"></td>
			<td class="text-center" ng-bind="vo.begindate|date:'yyyy-MM-dd'"></td>
			<td class="" ng-bind="vo.address"></td>
			<td>
				<a class="text-info"><i class="icon-note" ng-click="createJunctionBox({{ vo.id }});" ></i></a>
				<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
<!-- 				<a class="text-info"><i class="icon-speech" ng-click="editDataThreshold({{ vo.id }},'junctionBoxThreshold');" ></i></a> -->
			</td>
		</tr>
	</tbody>
</table>
</paging>
</div>
</div>
</div>
<script type="text/javascript">
	function goPage(pageIndex){
		$("#searchBtn").trigger("click");
	}
	function deleteBatch(){
		var conti= checkSelectMsg("ids","请至少选择一条记录!");
 		if(conti){
 			conti = confirm("确定要删除这些记录吗?");
 		}
 		if(conti){
 			var options = {
 					type:"post",
 					dataType:"json",
 					url : "${ctx}/JunctionBox/deleteBatch.htm?"+$("input[name=ids]:checked").serialize(),
 					success:function(json){
 						promptObj(json.type, '', json.message);
 						goPage(0);
 					},
 					error:function(json){
 						promptObj('error', '',"删除失败");
 					}
 				};
 				$.ajax(options);
 			}
	}
	
	function deleteRow(id){
		if(confirm("确定要删除这条数据吗？")){
			singledel(id);
		}
	}
	function singledel(id){
		$.ajax({
			type : "post",
			url : "${ctx}/JunctionBox/delete.htm",
			data:{"id":id},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '', json.message);
				goPage(0);
			},error:function(){
				promptObj('error', '',"删除失败");
			}
		});
	}
	
   var id
   var inverter;
   app.controller('JunctionBoxCtrl', function ($scope, $http,$state, $stateParams) {
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
			editData(id,modalId);
		}
// 		$scope.editDataThreshold = function(id,modalId) {
// 			editDataThreshold(id,modalId);
// 		}
		$scope.deleteRow = function(id){
			deleteRow(id);
		}
		initTableConfig($scope);
		
		$scope.onSelectPage = function(page) {
			if (page == 0) {
				page = 1;
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
					pstationid : $('#last_unfinish_bpowerstation_id').val()
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
		$http({method:"POST",url:"${ctx}/Inverter/selectByStation.htm",params:{}})
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
	}).error(function(response) {$scope.onSelectPage(1); 
	}); 
    });
</script>
