<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
app.controller('ShareRepositoryCtrl', function($scope, $http, $state) {
	$scope.createShareRepository = function(id){
		$state.go("app.addShareRepos",{
			"id": id,
			"type": $("#watchType").val()
		});
	};

	$scope.createMaintainAdvise = function(){
		$state.go("app.addMaintainAdvise",{
			"type": $("#watchType").val()
		});
	};
	
	$scope.detailShareRepository = function(id){
		$state.go("app.detailShareRepos",{id: id});
	};
	
	$scope.deleteBatch = function(id){
		var ids = [];
		if(id){
			ids.push(id);
		}else{
			$("input[name='ids']:checked").each(function(){
				ids.push($(this).val());
			});
		}
		if(ids.length == 0){
			alert("请至少选择一条记录!");
			return;
		}
		if(confirm("确定要删除这些记录吗?")){
			$http({
				method : "GET",
				url : "${ctx}/shareRepository/delete.htm",
				params : {
					"ids": ids
				}
			}).success(function(result) {
				if(result.key != 0){
					promptObj("success", '', "删除成功");
					$scope.onSelectPage($scope.currentPage);
					return;
				}
				promptObj("error", '', "删除失败");
			});
		}
	};
});
</script>
<style type="text/css">
.table .t_center{text-align:center;}
.table .t_right{text-align:right;}
.table .t_left{text-align:left;}
</style>
 <!-- 弹出层界面 -->     
<%-- <div id="boxChangeEdit" data-ng-include="'${ctx}/tpl/ledgerPage/boxChange/addBoxChange.jsp'"></div> --%>
<div ng-controller="ShareRepositoryCtrl">
	<div class="panel panel-default"  style="margin-top: 50px">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs p-r-sm">
          <button class="btn btn-sm btn-info " ng-click="createShareRepository();"> 新增知识库</button>
		  <!-- <button class="btn btn-sm btn-info " ng-click="createMaintainAdvise();"> 新增维修建议</button> -->
          <button class="btn btn-sm btn-default " ng-click="deleteBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {onSelectPage(1);return false;}">
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
      	 <button class="btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
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
					<th class="t_center" width="10%">编号</th>
					<th class="t_center" width="40%">标题</th>
					<th class="t_center" width="15%">发布时间</th>
					<th class="t_center" width="15%">发布人</th>
					<th class="t_center" width="15%">操作</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="vo in data ">
					<td>
						<label class="i-checks m-b-none">
						<input type="checkbox" name="ids" class="ids" value="{{vo.id }}" />
						<i></i></label>
					</td>
					<td class="t_center" ng-bind="vo.id"></td>
					<td class="t_left"><a ng-bind="vo.title" class="href-blur " ng-click="detailShareRepository({{ vo.id }});"></a></td>
					<td class="t_center" ng-bind="vo.releasetime|date:'yyyy-MM-dd'"></td>
					<td class="t_center" ng-bind="vo.userName"></td>
					<td class="t_center">
						<a class="text-info"><i class="icon-note" ng-click="createShareRepository(vo.id);"></i></a>
						<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteBatch(vo.id);"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
    </paging>
	</div>
</div>
