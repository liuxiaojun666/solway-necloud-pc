<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				url : "${ctx}/Inverter/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
					promptObj(json.type, '', json.message);
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
			url : "${ctx}/Inverter/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '', json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}
	 var boxChange
	app.controller('InverterCtrl', function($scope, $http, $state, $stateParams) {
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
		$scope.deleteRow = function(id) {
			deleteRow(id);
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
					pstationid : $('#last_unfinish_bpowerstation_id').val()
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
		$http({method:"POST",url:"${ctx}/BoxChange/selectByStation.htm",params:{}})
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
		}).error(function(response) {$scope.onSelectPage(1); 
		}); 
	});
</script>
<!-- 弹出层界面 -->     
<%-- <div data-ng-include="'${ctx}/tpl/ledgerPage/inverter/addInverterSkip.jsp'"></div> --%>
<div ng-controller="InverterCtrl">
	<div class="wrapper-md bg-light b-b">
	 	<span class="font-h3 blue-1 m-n text-black">逆变器管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
     <div class="col-sm-4 m-b-xs w-sm p-r-sm">    
          <button class="btn btn-sm btn-info " ng-click="createInverter();"> 新增</button>  
          <button class="btn btn-sm btn-default " onclick="deleteBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
		<div class="col-sm-9  no-padder">
			<div class="input-group p-r-sm">
         	 <input type="text" ng-model="keyWords" id="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
         	 <span class="input-group-btn">
            <button class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
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
<!--           <span class="input-group-btn"> -->
<!--             <button class="btn btn-sm btn-default" type="button">所属箱变</button> -->
<!--           </span> -->
        	<ui-select ng-model="boxchgd.selected" theme="bootstrap" ng-change="bcChange()">
		            <ui-select-match placeholder="请选择所属箱变..." ng-model="boxchgd.selected.name" >{{$select.selected.name}}</ui-select-match>
		            <ui-select-choices  repeat="item in bcList | filter: $select.search">
		              <div ng-bind-html="item.name | highlight: $select.search"></div>
		            </ui-select-choices>
		    </ui-select> 
		    <input type="hidden" value="" id="bcId" class="formData"/>
        </div>
      </div>
      <div class="col-sm-1">
      	 <button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
      </div>
    </div>
<table id="result_table" class="table table-striped b-t b-light">
	<thead>
		<tr>
			<th  width="5%">
				<label class="i-checks m-b-none">
				<input type="checkbox" id="all"onclick="changeAll(this.checked,'ids');" /><i></i>
				</label>
			</th>
			<th class="text-left"  width="5%">编号</th>
			<th class="text-left"  width="13%" >设备名称</th>
			<th class="text-left"   width="12%">所属箱变</th>
			<th class="text-left"   width="20%">产品型号</th>
			<th class="text-center" width="10%">安装时间</th>
			<th class="text-left"   width="10%">逆变器室</th>
			<th class="text-left"   width="15%">位置</th>
			<th width="10%">操作</th>
		</tr>
	</thead>
	<tbody>
		<tr  ng-repeat="vo in data ">
			<td >
			<label class="i-checks m-b-none">
			<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
			<i></i></label>
			</td>
			<td  class="text-left" ng-bind="vo.code"></td>
			<td  class="text-left"><a ng-bind="vo.name"  ng-click="showInformation(vo.id,vo.serialnumber,vo.pstationid );" class="href-blur"></a></td>
			<td  class="text-left href-blur a-cur-poi" ng-bind="vo.boxchangename" ng-click="showBoxChange(vo.boxchangeid);"></td>
			<td class="" ng-bind="vo.productname"></td>
			<td class="text-center" ng-bind="vo.begindate|date:'yyyy-MM-dd'"></td>
			<td class="text-left" ng-bind="vo.inverterroom"></td>
			<td  class="text-left" ng-bind="vo.address"></td>
			<td >
				<a class="text-info"><i class="icon-note" ng-click="createInverter({{ vo.id }});" ></i></a>
				<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
				<a class="text-info" ng-click="viewJunctionBox({{ vo.id }});"> <i class="icon iconfont">&#xe607;</i></a>
			</td>
		</tr>
	</tbody>
</table>
</paging>
</div>
</div>
</div>
