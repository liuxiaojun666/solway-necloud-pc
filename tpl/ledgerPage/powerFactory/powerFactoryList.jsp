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
			url : "${ctx}/PowerStation/deleteBatch.htm?"
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
		url : "${ctx}/PowerStation/delete.htm",
		data : {
			"id" : id
		},
		dataType : "json",
		success : function(json) {
			promptObj('success', '', json.message);
			goPage(0);
		},
		error : function() {
			promptObj('error', '',"删除失败");
		}
	});
}

app.controller('powerFactoryCr', function($scope, $http, $state) {
	$scope.createPowerStation = function(id, name) {
		$state.go("app.addpowerFactory", {
			psId : id
		});
	}

	$scope.deleteRow = function(id) {
		deleteRow(id);
	}

	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}
		$http({
			method : "POST",
			url : "${ctx}/PowerStation/powerStationList.htm",
			params : {
				'pageIndex' : page - 1,
				'pageSize' : $scope.pageSizeSelect,
				parentIsNull:0,
				stationname : $scope.psName,
				stationcode : $scope.psCode,
				keyWords : $scope.keyWords
			}
		}).success(function(result) {
			getTableData($scope,result);
		});
	};
	$scope.onSelectPage(1);
	
	//点击  Enter  键  查询
	document.onkeydown = function(e)
	{
	   var e = window.event   ?   window.event   :   e; 
	   if(e.keyCode == 13){
		   $scope.onSelectPage(1);
		}
	}	
});
</script>
 <!-- 弹出层界面 -->     
<%-- <div data-ng-include="'${ctx}/tpl/ledgerPage/powerStation/addPowerStationSkip.jsp'"></div> --%>
<div ng-controller="powerFactoryCr">
	<div class="wrapper-md bg-light b-b" >
		<span class="font-h3 blue-1 m-n " id="stationIdFlag">厂区信息管理
	</span>
	</div>
	<div class="wrapper-md ng-scope">

		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">     
          <button class="btn btn-sm btn-info" ng-click="createPowerStation();"> 新增</button>  
          <button class="btn btn-sm btn-default" onclick="deleteBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9 no-padder ">
        <div class="input-group p-r-sm">
          <input type="text" ng-model="keyWords" id="keyWords" class="input-sm form-control" placeholder="关键字">
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
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">编号</button>
          </span>
        <input type="text" ng-model="psCode" id="psCode" class="input-sm form-control">
        </div>
      </div>
       <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">名称</button>
          </span>
        <input type="text" ng-model="psName" id="psName" class="input-sm form-control"></div>
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
			<th>厂区名称</th>
			<th>所属电站</th>
			<th>负责人</th>
			<th>联系电话</th>
			<th>所属省份</th>
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
		<td  ng-bind="vo.stationcode"></td>
		<td  ng-bind="vo.stationname"></td>
		<td  ng-bind="vo.parentname"></td>
		<td  ng-bind="vo.managername"></td>
		<td  ng-bind="vo.stationtel"></td>
		<td  ng-bind="vo.province"></td>
		<td>
			<a class="text-info"><i class="icon-note" ng-click="createPowerStation({{ vo.id }});" ></i></a>
			<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
		</td>
	</tr>
	</tbody>
</table>
</paging>
</div>
</div>
</div>
