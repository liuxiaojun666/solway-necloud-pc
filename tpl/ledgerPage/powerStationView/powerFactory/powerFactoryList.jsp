<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
function changeFactoryAll(value,ids){
	var objs = document.getElementsByName(ids);
	for(var i=0; i<objs.length; i++) {
	      	objs[i].checked = value;
  	}
}

function deleteBatchFactory() {
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
				$("#searchFactoryBtn").trigger("click");
			},
			error : function(json) {
				promptObj('error', '',"删除失败");
			}
		};
		$.ajax(options);
	}
}


//单条删除
function singledelFactory(id) {
	$.ajax({
		type : "post",
		url : "${ctx}/PowerStation/delete.htm",
		data : {
			"id" : id
		},
		dataType : "json",
		success : function(json) {
			promptObj(json.type, '', json.message);
			$("#searchFactoryBtn").trigger("click");
		},
		error : function() {
			promptObj('error', '',"删除失败");
		}
	});
}

app.controller('powerFactoryCtr', function($scope, $http, $state,$stateParams) {
	$scope.broadcastSwitchStation = function () {
		$scope.onSelectPage(1);
	}
	$scope.$on("broadcastSwitchStation", $scope.broadcastSwitchStation);

	$scope.createPowerStation = function(id, name) {
		$state.go("app.addpowerFactory", {
			psId : id
		});
	}
	$scope.deleteFactory = function(id,modalId) {
		if (confirm("确定要删除这条数据吗？")) {
			singledelFactory(id);
		}

	}
	$scope.editData = function(id, modalId) {
		initFactoryPageData(id);
		$('#'+modalId).modal('show');
	}
	$scope.addData = function(modalId) {
		$("#saveFactoryButton").button('reset');
		$("#facparentid").val($("#stationid").val());
		initFactoryPageData();
		$("#factorynotonly").addClass('hidden');
		$('#'+modalId).modal('show');
	}
	$scope.deleteRow = function(id) {
		$state.go("app.powerStationDetail", {
			psId : id
		});
// 		deleteRow(id);
	}

	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		var stId = $stateParams.inId;
		if(!stId){
			stId = $("#stationid").val();
		}
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
				parentid: stId,
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
<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStationView/powerFactory/addpowerFactorySkip.jsp'"></div>
<div ng-controller="powerFactoryCtr">
	<div class="ng-scope">
			<paging class="col-sm-12">
			<div class="wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">
          <button class="btn btn-sm btn-info" ng-click="addData('factoryModal');"> 新增</button>
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
      <div class="col-sm-1">
          <button id="searchFactoryBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
      </div>
    </div>
    <div class="col-sm-12">
    	<table id="result_table" class="col-sm-12 m-t table-bordered table table-striped" style="border:1px solid #dee5e7">
	<thead>
		<tr>
			<th style="width: 20px;">
				<label class="i-checks m-b-none">
					<input type="checkbox" id="all"
			onclick="changeFactoryAll(this.checked,'ids');" /><i></i>
			</label>
			</th>
			<th>厂区名称</th>
			<th>装机容量</th>
			<th>厂区负责人</th>
			<th>地址</th>
			<th width="8%">操作</th>
		</tr>
	</thead>
	<tbody>
	<tr  ng-repeat="vo in data ">
		<td>
		<label class="i-checks m-b-none">
		<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
		<i></i></label>
		</td>
		<td  ng-bind="vo.stationname"></td>
		<td  ng-bind="vo.buildcapacity"></td>
		<td  ng-bind="vo.managername"></td>
		<td  ng-bind="vo.addressall"></td>
		<td>
			<a class="text-info"><i class="icon-note" ng-click="editData({{vo.id}},'factoryModal');" ></i></a>
			<a class="text-info"><i class="icon-trash" ng-click="deleteFactory({{vo.id}});"></i></a>
		</td>
	</tr>
	</tbody>
</table>

    </div>

</paging>
</div>
</div>
