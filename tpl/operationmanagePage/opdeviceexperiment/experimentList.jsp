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
				url : "${ctx}/Experiment/deleteBatch.htm?"
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
			url : "${ctx}/Experiment/delete.htm",
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
	
	app.controller('InverterCtrl', function($scope, $http, $state) {
		$scope.createInverter = function(id, name) {
			$state.go("app.addexperiment", {
				InId : id
			});
		}
		$scope.showInformation = function(id) {
			$state.go("app.inverterDetail", {
				InId : id
			});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.editData = function(id, modalId) {
			editData(id, modalId);
		}
		initTableConfig($scope);
		//初始化数据
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/Experiment/experimentList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					'deviceid' : $scope.deviceid,
					'devicename' : $scope.deviceName,
					'keywords' : $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
			$scope.onSelectPage(1)
	});
</script>
 <!-- 弹出层界面 -->     
<div ng-controller="InverterCtrl">
	<div class="wrapper-md bg-light b-b">
	 	<span class="font-h3 blue-1 m-n text-black">设备技术监督</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
     <div class="col-sm-4 m-b-xs w-sm p-r-sm">    
          <button class="btn btn-sm btn-info m-r-xs" ng-click="createInverter();"> 新增</button>  
          <button class="btn btn-sm btn-default m-r-xs" onclick="deleteBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
		<div class="col-sm-9  no-padder">
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
            <button class="btn btn-sm btn-default" type="button">设备ID</button>
          </span>
        <input type="text" ng-model="deviceid" id="deviceid" class="input-sm form-control">
        </div>
      </div>
       <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">设备名称</button>
          </span>
        <input type="text" ng-model="deviceName" id="deviceName" class="input-sm form-control"></div>
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
				<input type="checkbox" id="all"onclick="changeAll(this.checked,'ids');" /><i></i>
				</label>
			</th>
			<th>电站名称</th>
			<th>设备名称</th>
			<th>监督项目</th>
			<th>监督厂商</th>
			<th>监督执行人 </th>
			<th>监督时间</th>
			<th>实验结果</th>
			<th>状态</th>
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
			<td ng-bind="vo.pstationname"></td>
			<td ng-bind="vo.devicename" ></td>
			<td ng-bind="vo.expericontent"></td>
			<td ng-bind="vo.experifact"></td>
			<td ng-bind="vo.operator"></td>
			<td ng-bind="vo.experidate |date: 'yyyy-MM-dd'"></td>
			<td ng-bind="vo.experiresult"></td>
			
			<td>
			<span  ng-if="vo.status=='00'">临时</span>
			<span  ng-if="vo.status=='01'">正式</span>
			<span  ng-if="vo.status=='02'">作废</span>
			</td>
			
			<td>
				<a class="text-info"><i class="icon-note" ng-click="createInverter({{ vo.id }});" ></i></a>
				<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
			</td>
		</tr>
	</tbody>
</table>
</paging>
</div>
</div>
</div>
