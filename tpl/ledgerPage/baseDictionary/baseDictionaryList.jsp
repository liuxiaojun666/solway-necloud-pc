<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var goPage = null;
	app.controller('BaseDictionaryCtrl', function($scope, $http, $state) {
		//列表相关数据初始化
		initTableConfig($scope);
		//查询方法
		goPage = $scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/Basedictionary/selectByPage.htm",
				params : {
					"pageIndex" : page - 1,
					"pageSize" : $scope.pageSizeSelect,
					"dictName": $scope.dictName,
					"dictCode": $scope.dictCode,
					"keyWords": $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};

		$scope.deleteSingleData = function (id) {
			if (!confirm("确定要删除这条数据吗？")) return;
			$scope.deleteData([id]);
		};
		
		//批量删除
	    $scope.deleteBatch=function(){
			var ids = [];
			$("input[name='ids']:checked").each(function () {
				ids.push($(this).val());
			});
			if (ids.length == 0) {
				alert("请选择数据");
				return;
			}
			if (!confirm("确定要删除这些数据吗？")) return;
			$scope.deleteData(ids);
		};

		$scope.deleteData = function (ids) {
			$http({
				method : "POST",
				url : "${ctx}/Basedictionary/deleteByPrimaryKeys.htm",
				params : {
					"ids": ids
				}
			}).success(function(result) {
				if (result.key == 0){
					promptObj('success','',result.msg);
					$scope.onSelectPage(1);
					return;
				}
				promptObj('error','',result.msg);
			});
		};

		//get first page
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
<div id="baseDictionaryEdit"
	data-ng-include="'${ctx}/tpl/ledgerPage/baseDictionary/addBaseDictionary.jsp'"></div>
<div ng-controller="BaseDictionaryCtrl">
	<div class="wrapper-md bg-light b-b">
	<span class="font-h3 blue-1 m-n text-black h4">字典管理
	</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-4 m-b-xs w-sm p-r-sm">
					<button class="btn btn-sm btn-info m-r-xs"
						ng-click="addData('baseDictionaryCtrlModal');">新增</button>
					<button class="btn btn-sm btn-default m-r-xs"
						ng-click="deleteBatch();">批量删除</button>
				</div>
				<div class="col-sm-3 no-padder">
					<div class="col-sm-9  no-padder">
						<div class="input-group p-r-sm">
							<input type="text" ng-model="keyWords" id="keyWords"
								class="input-sm form-control" placeholder="关键字"> <span
								class="input-group-btn">
								<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);"
									type="button">查询</button>
							</span>
						</div>
					</div>
					<a class="col-sm-3 text-info no-padder cwsearch"
						onclick="showSearch()"> <span class="searchTitle "><button
								class="btn btn-sm  btn-default">更多查询</button></span></a>
				</div>
				<div class="col-sm-5 pull-right">
				<%@ include file="/common/pager.jsp"%></div>
			</div>
			<div class="row hideSearchDiv wrapper">
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">字典名</button>
						</span> <input type="text" ng-model="dictName"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">字典编码</button>
						</span> <input type="text" ng-model="dictCode"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-1">
					<button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
				</div>
			</div>
			<div>
				<table id="result_table" class="table table table-striped b-t b-light">
					<thead>
						<tr>
							<th style="width: 20px;"><label class="i-checks m-b-none">
									<input type="checkbox" id="all"
									onclick="changeAll(this.checked,'ids');" /><i></i>
							</label></th>
							<th>编号</th>
							<th>字典类型</th>
							<th>字典名</th>
							<th>字典编码</th>
							<th>字典英文名</th>
							<th>描述</th>
							<th>字典值</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in data ">
							<td><label class="i-checks m-b-none"> <input
									type="checkbox" name="ids" value="{{vo.id }}" /> <i></i>
							</label></td>
							<td ng-bind="vo.id"></td>
							<td ng-bind="vo.dictType"></td>
							<td ng-bind="vo.dictName"></td>
							<td ng-bind="vo.dictCode"></td>
							<td ng-bind="vo.dictEnName"></td>
							<td ng-bind="vo.description"></td>
							<td ng-bind="vo.dictValue"></td>
							<td><a class="text-info"><i class="icon-note"
									ng-click="editData(vo.id ,'baseDictionaryCtrlModal');"></i></a> <!-- <a class="text-info"><i class="icon-note" ng-click="createManufacturer({{ vo.id }});"></i></a>  -->
								<a class="text-info"><i class="icon-trash"
									ng-click="deleteSingleData(vo.id);"></i></a></td>
						</tr>
					</tbody>
				</table>
				</div>
			</paging>
		</div>
	</div>
</div>
