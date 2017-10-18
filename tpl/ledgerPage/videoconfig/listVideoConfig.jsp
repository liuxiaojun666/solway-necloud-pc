<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    app.controller('ListVideoConfigCtrl', function($scope, $http, $state) {
        //切换电站
        $scope.$on('broadcastSwitchStation', function(event, data) {
            initTableConfig($scope);
            $scope.onSelectPage(1);
        });

        $scope.emptyToNull = function (str) {
            if (str == "" || str == " ")
                return null;
            return str;
        };

        initTableConfig($scope);
        $scope.onSelectPage = function(page) {
            if (page == 0) {
                page = 1;
            }
            $http({
                method : "POST",
                url : "${ctx}/PVideoConfig/queryPVideoConfigList.htm",
                params : {
                    'pageIndex': page - 1,
                    'pageSize': $scope.pageSizeSelect,
                    'stId': $scope.pstationid,
					'keyWords': $scope.emptyToNull($scope.keyWords),
					'monitorPointName': $scope.emptyToNull($scope.monitorPointName),
					'monitorPointIP': $scope.emptyToNull($scope.monitorPointIP)
                }
            }).success(function(result) {
                getTableData($scope, result);
            });
        };
        $scope.onSelectPage(1);

        $scope.addVedioConfig = function () {
            $scope.$broadcast("editDataEdit", {});
            $("#addVideoConfigForm input[type='text']").val("");
            $("#addVideoConfigModal").modal('show');
        };

        $scope.editVedioConfig = function (id) {
            $scope.$applyAsync();
            $http({
                method : "POST",
                url : "${ctx}/PVideoConfig/queryVideoConfigEdit.htm",
                params : {
                    'stId' : $scope.pstationid,
					'id': id
                }
            }).success(function(result) {
                if (result.key == 0){
                    $scope.$broadcast("editDataEdit", result.data);
                    $("#addVideoConfigModal").modal('show');
                    return;
				}
                promptObj("error", '',"查询失败");
            });
        };

        $scope.deleteVedioConfigSingle = function (id) {
			if (id == null) return;
			if (confirm("确定要删除此条数据吗？")){
                $scope.deleteVedioConfig([id]);
            }
        };

        $scope.deleteVedioConfigMult = function () {
            var ids = [];
			$("#result_table input[name='vedioConfigIds']:checked").each(function () {
				ids.push($(this).val());
            });
			if (ids.length == 0){
			    alert("请选择要删除的数据");
			    return;
            }
            if (confirm("确定要删除这些数据吗？")){
                $scope.deleteVedioConfig(ids);
            }
        };

        $scope.deleteVedioConfig = function (ids) {
			if (ids == null || ids.length == 0) return null;
            $http({
                method : "POST",
                url : "${ctx}/PVideoConfig/deleteVideoConfig.htm",
                params : {
                    'stId' : $scope.pstationid,
                    'ids': ids
                }
            }).success(function(result) {
                if (result.key == 0){
                    promptObj("success", '',"删除成功");
                    $scope.onSelectPage(1);
                    return;
                }
                promptObj("error", '',"删除失败");
            });
        };
    });
</script>
<div ng-controller="ListVideoConfigCtrl">
	<!-- 弹出层界面 -->
	<div data-ng-include="'${ctx}/tpl/ledgerPage/videoconfig/addVideoConfig.jsp'"></div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
				<div class="row wrapper">
					<div class="col-sm-4 m-b-xs w-sm p-r-sm">
						<button class="btn btn-sm btn-info " ng-click="addVedioConfig();"> 新增</button>
						<button class="btn btn-sm btn-default " ng-click="deleteVedioConfigMult();">批量删除</button>
					</div>
					<div class="col-sm-3 no-padder">
						<div class="col-sm-9  no-padder">
							<div class="input-group p-r-sm">
								<input type="text" name="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
								<span class="input-group-btn">
									<button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
								</span>
							</div>
						</div>
						<a class="col-sm-3 text-info no-padder cwsearch" onclick="showSearch()">
							<span class="searchTitle "><button class="btn btn-sm  btn-default"> 更多查询 </button></span>
						</a>
					</div>
					<div class="col-sm-5 pull-right">
						<%@ include file="/common/pager.jsp"%></div>
					</div>
				<div class="row hideSearchDiv wrapper">
					<div class="col-sm-3">
						<div class="input-group">
							<span class="input-group-btn">
								<button class="btn btn-sm btn-default" type="button">监控点名称</button>
							</span>
							<input type="text" name="monitorPointName"  ng-model="monitorPointName" class="input-sm form-control">
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<span class="input-group-btn">
								<button class="btn btn-sm btn-default" type="button">监控点IP</button>
							</span>
							<input type="text" name="monitorPointIP" ng-model="monitorPointIP" class="input-sm form-control col-sm-5"></div>
					</div>
					<div class="col-sm-1">
						<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
					</div>
				</div>
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th style="width: 20px;">
								<label class="i-checks m-b-none">
									<input type="checkbox" id="all" onclick="changeAll(this.checked,'vedioConfigIds');" /><i></i>
								</label>
							</th>
							<th class="text-center">电站名称</th>
							<th class="text-center">监控点名称</th>
							<th class="text-center">监控点编号</th>
							<th class="text-center">监控点IP</th>
							<th class="text-center">监控点源地址</th>
							<th class="text-center">监控点目标地址</th>
							<th class="text-center">监控点排序</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody >
						<tr ng-repeat="vo in data ">
							<td>
								<label class="i-checks m-b-none">
									<input type="checkbox" name="vedioConfigIds" value="{{vo.id}}" />
									<i></i></label>
							</td>
							<td ng-bind="vo.stName" class="text-left"></td>
							<td ng-bind="vo.monitorPointName" class="text-left"></td>
							<td ng-bind="vo.monitorPointNum" class="text-center"></td>
							<td ng-bind="vo.monitorPointIP" class="text-center"></td>
							<td ng-bind="vo.monitorPointSource" class="text-center"></td>
							<td ng-bind="vo.monitorPointDest" class="text-center"></td>
							<td ng-bind="vo.monitorPointSeq" class="text-center"></td>
							<td class="text-center">
								<a class="text-info"><i class="icon-note" ng-click="editVedioConfig({{vo.id}})"></i></a>
								<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteVedioConfigSingle({{vo.id}})"></i></a>
							</td>
						</tr>
					</tbody>
				</table>
			</paging>
		</div>
	</div>
</div>
