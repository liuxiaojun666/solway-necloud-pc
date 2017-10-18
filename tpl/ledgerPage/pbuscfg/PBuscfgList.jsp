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
				url : "${ctx}/BusCfg/deleteBatch.htm?"
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
			url : "${ctx}/BusCfg/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '',json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',json.message);
			}
		});
	}

	app.controller('BusCfgCtrl', function($scope, $http, $state) {
		$scope.showInformation = function(id,serialnumber,pstationid) {
			$state.go("app.BoxChangeDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		$scope.addpbuscfg = function(id) {
			$state.go("app.addpbuscfg", {
				InId : id
			});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}

		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if (page == 0) {
				page = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/BusCfg/pbuscfgList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					'keyWords' : $scope.keyWords,
					'name'     : $scope.name,
					'version'  : $scope.version
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
	});
</script>
 <!-- 弹出层界面 -->
<div ng-controller="BusCfgCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h4 blue-1 m-n text-black">总线配置</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm"> 
          <button class="btn btn-sm btn-info " ng-click="addpbuscfg();"> 新增</button>
          <button class="btn btn-sm btn-default " onclick="deleteBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
           	<button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
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
            <button class="btn btn-sm btn-default" type="button">总线名称</button>
          </span>
        <input type="text" id="name"  ng-model="name" class="input-sm form-control">
        </div>
      </div>
       <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">版本</button>
          </span>
        <input type="text" id="version" ng-model="version" class="input-sm form-control"></div>
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
							<input type="checkbox" id="all" onclick="changeAll(this.checked,'ids');" /><i></i>
						</label>
					</th>
					<th>总线名称</th>
					<th>电站名称</th>
					<th>版本</th>
					<th>通讯地址</th> 
					<th>超时时间(ms)</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="vo in data ">
					<td>
						<label class="i-checks m-b-none">
							<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
						<i></i></label>
					</td>
					<td ng-bind="vo.name"></td>
					<td ng-bind="vo.pstationStr"></td>
					<td ng-bind="vo.version"></td>
					<td ng-bind="vo.hostaddr"></td>
					<td ng-bind="vo.timeout"></td>
					<td>
						<a class="text-info"><i class="icon-note" ng-click="addpbuscfg({{vo.id}});"></i></a>
						<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
    </paging>
	</div>
	</div>
</div>
