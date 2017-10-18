<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

var goPage = null;
	app.controller('ModelConfigCtrl', function($scope, $http, $state) {
		//列表相关数据初始化
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/modelConfig/modelConfigList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);


		//---------------------新增js---------------------------------
		$scope.modelStations = null;
		$scope.modelStationed = {};
		$scope.queryWaitBPowerStation = function () {
			//待选电站
			$http({
				method: "POST",
				url: "${ctx}/modelConfig/queryWaitBPowerStation.htm",
				params:{}
			})
			.success(function (res) {
				if (res.key == 0){
					$scope.modelStations = res.data;
					return;
				}
				alert("数据请求失败");
			});
		};

		$scope.models = null;
		$scope.modeled = {};
		$scope.queryModel = function (type) {
			if (type == "add") $scope.stationId = null;
			//模型
			$http({
				method: "POST",
				url: "${ctx}/modelConfig/queryModel.htm",
				params:{
					"stationId": $scope.stationId
				}
			})
			.success(function (res) {
				if (res.key == 0){
					$scope.models = res.data;
					for (var i=0,ii=$scope.models.length;i<ii;i++){
						if ($scope.models[i].flag == 1){
							$scope.modeled.selected = {"modelId": $scope.models[i].modelId, "modelName": $scope.models[i].modelName};
							break;
						}
					}
					return;
				}
				alert("数据请求失败");
			});
		};
		//新增
		$scope.createModelConfig = function () {
			$("#modelConfigModal").modal();
			$scope.modelStationed = {};
			$scope.modeled = {};
			$scope.queryWaitBPowerStation();
			$scope.queryModel("add");
		};

		$scope.stationId = null;
		$scope.modelStationChange = function () {
			$scope.stationId = angular.copy($scope.modelStationed.selected.stationId);
		};
		$scope.modelId = null;
		$scope.modelChange = function () {
			$scope.modelId = angular.copy($scope.modeled.selected.modelId);
		};

		$scope.saveModelData = function () {
			$scope.saveData("/modelConfig/insertModelConfig.htm", "modelConfigModal");
		};

		//---------------------编辑js---------------------------------
		$scope.editModelConfig = function (id, stationName, stationId) {
			$scope.configId = id;
			$scope.editStationName = stationName;
			$scope.stationId = stationId;
			$("#editModelConfigModal").modal();
			$scope.queryModel();
		};

		$scope.editSaveModelData = function () {
			$scope.saveData("/modelConfig/updateModelConfig.htm", "editModelConfigModal");
		};

		//---------------------删除js---------------------------------
		$scope.deleteOneData = function (id) {
			if (!confirm("您确定要删除此条数据？")) return;
			var ids = [];
			ids.push(id);
			$scope.deleteData(ids);
		};
		$scope.deleteMulitData = function () {
			if (!confirm("您确定要删除这些数据？")) return;
			var ids = [];
			$("input[name='ids']:checked").each(function(){
				ids.push($(this).val());
			});
			$scope.deleteData(ids);
		};
		$scope.deleteData = function (ids) {
			$http({
				method: "POST",
				url: "${ctx}/modelConfig/deleteModelConfig.htm",
				params:{
					"ids": ids
				}
			})
			.success(function (res) {
				if (res.key == 0){
					promptObj('success', '', res.msg);
					$scope.onSelectPage(1);
					return;
				}
				promptObj('error', '',res.msg);
			});
		};

		$scope.saveData = function(url, modalId){
			if (!/^[0-9]+$/.test($scope.stationId)){
				alert("请选择电站");
				return;
			}
			if (!/^[0-9]+$/.test($scope.modelId)){
				alert("请选择模型");
				return;
			}

			$http({
				method: "POST",
				url: "${ctx}" + url,
				params:{
					"stationId": $scope.stationId,
					"modelNo": $scope.modelId,
					"id": $scope.configId
				}
			})
			.success(function (res) {
				if (res.key == 0){
					promptObj('success', '', res.msg);
					hideModal(modalId);
					$scope.onSelectPage(1);
					return;
				}
				promptObj('error', '',res.msg);
			});
		}
	});
</script>
<div ng-controller="ModelConfigCtrl">
	<div class="wrapper-md bg-light b-b">
	<span class="font-h3 blue-1 m-n text-black h4">模型配置
	</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-4 m-b-xs w-sm p-r-sm">
					<button class="btn btn-sm btn-info m-r-xs"
						ng-click="createModelConfig();">新增</button>
					<button class="btn btn-sm btn-default m-r-xs"
						ng-click="deleteMulitData();">批量删除</button>
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
							<button class="btn btn-sm btn-default" type="button">厂商编号</button>
						</span> <input type="text" ng-model="pmDictCode" id="pmDictCode"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">厂商名称</button>
						</span> <input type="text" ng-model="pmName" id="pmName"
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
							<th>电站名称</th>
							<th>模型名称</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in data ">
							<td><label class="i-checks m-b-none">
								<input type="checkbox" name="ids" value="{{vo.id}}" /> <i></i>
							</label></td>
							<td ng-bind="vo.id"></td>
							<td ng-bind="vo.stationName"></td>
							<td ng-bind="vo.modelName"></td>
							<td><a class="text-info"><i class="icon-note"
									ng-click="editModelConfig(vo.id, vo.stationName, vo.stationId);"></i></a>
								<a class="text-info"><i class="icon-trash"
									ng-click="deleteOneData(vo.id);"></i></a></td>
						</tr>
					</tbody>
				</table>
				</div>
			</paging>
		</div>
	</div>

	<!-- 新增弹出层开始 -->
	<div class="modal fade" id="modelConfigModal"
		 tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog row">
			<div class="modal-content ">
				<div>
					<div class="row" style="margin-top:25px;">
						<div class="form-group  col-sm-12">
							<label class="col-lg-2 control-label" style="padding-top: 10px;">电站</label>
							<div class="col-lg-5">
								<ui-select ng-model="modelStationed.selected" theme="bootstrap" ng-change="modelStationChange();">
									<ui-select-match placeholder="请输入关键字..." ng-model="modelStationed.selected.stationName">
										{{$select.selected.stationName}}
									</ui-select-match>
									<ui-select-choices repeat="item in modelStations | filter: $select.search">
										<div ng-bind-html="item.stationName | highlight: $select.search"></div>
									</ui-select-choices>
								</ui-select>
							</div >
							<input type="hidden" ng-model="stationId" />
						</div>
					</div>
					<div class="row">
						<div class="form-group  col-sm-12">
							<label class="col-lg-2 control-label" style="padding-top: 10px;">模型</label>
							<div class="col-lg-5">
								<ui-select ng-model="modeled.selected" theme="bootstrap" ng-change="modelChange();">
									<ui-select-match placeholder="请输入关键字..." ng-model="modeled.selected.modelName">
										{{$select.selected.modelName}}
									</ui-select-match>
									<ui-select-choices repeat="item in models | filter: $select.search">
										<div ng-bind-html="item.modelName | highlight: $select.search"></div>
									</ui-select-choices>
								</ui-select>
							</div >
							<input type="hidden" ng-model="modelId" />
						</div>
					</div>
					<div class="row">
						<div class="col-lg-8" style="margin-top:25px;margin-bottom:25px;">
							<button type="button"  id="cancelBtn" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
							<button type="button" ng-click="saveModelData();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 新增弹出层结束 -->

	<!-- 编辑弹出层开始 -->
	<div class="modal fade" id="editModelConfigModal"
		 tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog row">
			<div class="modal-content ">
				<div>
					<div class="row" style="margin-top:25px;">
						<div class="form-group  col-sm-12">
							<label class="col-lg-2 control-label" style="padding-top: 10px;">电站</label>
							<div class="col-lg-5">
								<input maxlength="100" ng-model="editStationName" disabled class="form-control formData" type="text">
							</div >
							<input type="hidden" ng-model="stationId" />
						</div>
					</div>
					<div class="row">
						<div class="form-group  col-sm-12">
							<label class="col-lg-2 control-label" style="padding-top: 10px;">模型</label>
							<div class="col-lg-5">
								<ui-select ng-model="modeled.selected" theme="bootstrap" ng-change="modelChange();">
									<ui-select-match placeholder="请输入关键字..." ng-model="modeled.selected.modelName">
										{{$select.selected.modelName}}
									</ui-select-match>
									<ui-select-choices repeat="item in models | filter: $select.search">
										<div ng-bind-html="item.modelName | highlight: $select.search"></div>
									</ui-select-choices>
								</ui-select>
							</div >
							<input type="hidden" ng-model="modelId" />
						</div>
					</div>
					<div class="row">
						<div class="col-lg-8" style="margin-top:25px;margin-bottom:25px;">
							<button type="button"  class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
							<button type="button" ng-click="editSaveModelData();" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 编辑弹出层结束 -->
</div>
