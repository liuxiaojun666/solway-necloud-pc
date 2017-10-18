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
				url : "${ctx}/BoxChange/deleteBatch.htm?"
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
			url : "${ctx}/BoxChange/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '',json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}
	
	app.controller('BoxChangeCtrl', function($scope, $http, $state) {
		$scope.showInformation = function(id,serialnumber,pstationid) {
			$state.go("app.BoxChangeDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		$scope.createBoxChange = function(id, name) {
			$state.go("app.addBoxChange", {
				InId : id
			});
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
			$http({
				method : "POST",
				url : "${ctx}/BoxChange/boxChangeList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					name : $scope.bcname,
					code : $scope.bccode,
					keyWords : $scope.keyWords,
					pstationid : $('#last_unfinish_bpowerstation_id').val()
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
	});
</script>
 <!-- 弹出层界面 -->     
<%-- <div id="boxChangeEdit" data-ng-include="'${ctx}/tpl/ledgerPage/boxChange/addBoxChange.jsp'"></div> --%>
<div ng-controller="BoxChangeCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">箱变管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm"> 
          <button class="btn btn-sm btn-info " ng-click="createBoxChange();"> 新增</button>
          <button class="btn btn-sm btn-default " onclick="deleteBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
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
					<th>所属电站</th>
				
					<th>产品型号</th>
					<th class="text-center">安装时间</th>
					<th>位置</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="vo in data ">
					<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="ids" id="ids" value="{{vo.id }}" />
					<i></i></label>
					</td>
					<td class="" ng-bind="vo.code"></td>
					<td ><a ng-bind="vo.name" class="href-blur " ng-click="showInformation({{ vo.id }});"></a></td>
					<td ng-bind="vo.pstationname "></td>
					<td class="" ng-bind="vo.productname"></td>
					<td class="text-center" ng-bind="vo.begindate|date:'yyyy-MM-dd'"></td>
					<td class="" ng-bind="vo.address"></td>
					<td>
						<a class="text-info"><i class="icon-note" ng-click="createBoxChange({{vo.id}});"></i></a>
						<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
						<a class="text-info" ng-click="viewInverter({{ vo.id }});"><i class="icon iconfont">&#xe606;</i></a>
					</td>
				</tr>
			</tbody>
		</table>
    </paging>
	</div>
	</div>
</div>
