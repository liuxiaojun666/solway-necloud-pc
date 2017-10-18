<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="SvgManagerCtrl">
    <div class="wrapper-md bg-light b-b" >
		<span class="font-h3 blue-1 m-n " id="stationIdFlag">svg管理
	</span>
    </div>
    <div class="wrapper-md ng-scope">
        <div class="panel panel-default">
            <paging class="col-sm-12 panel no-padder">
                <div class="row wrapper">
                    <div class="col-sm-4 m-b-xs w-sm p-r-sm">
                        <button class="btn btn-sm btn-info" ng-click="createSvg()"> 新增</button>
                        <button class="btn btn-sm btn-default" ng-click="deleteBatch();">批量删除</button>
                    </div>
                    <div class="col-sm-5 no-padder">
                        <div class="col-sm-7 no-padder ">
                            <div class="input-group p-r-sm">
                                <input type="text" ng-model="keyWords" id="keyWords" class="input-sm form-control" placeholder="关键字">
                                <span class="input-group-btn">
			                        <button class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
			                    </span>
                            </div>
                        </div>
                        <a class="col-sm-2 text-info no-padder cwsearch" onclick="showSearch()">
                            <span class="searchTitle "><button class="btn btn-sm  btn-default"> 更多查询 </button></span>
                        </a>
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
                            <input type="text" ng-model="psName" id="psName" class="input-sm form-control">
                        </div>
                    </div>
                    <div class="col-sm-1">
                        <button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
                    </div>
                </div>
                <table id="result_table" class="table table-striped b-t b-light">
                    <thead>
                    <tr>
                        <th width="5%">
                            <label class="i-checks m-b-none">
                                <input type="checkbox" id="all"
                                       onclick="changeAll(this.checked,'ids');" /><i></i>
                            </label>
                        </th>
                        <th width="5%" class="text-center">编号</th>
                        <th width="20%" class="text-center">名称</th>
                        <th width="15%" class="text-center">所属电站</th>
                        <th width="20%" class="text-center">底图</th>
                        <th width="10%" class="text-center">是否默认显示</th>
                        <th width="15%" class="text-center">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr  ng-repeat="vo in data ">
                        <td width="5%">
                            <label class="i-checks m-b-none">
                                <input type="checkbox" name="ids" value="{{vo.id}}" />
                                <i></i></label>
                        </td>
                        <td width="5%" ng-bind="vo.id" class="text-center"></td>
                        <td width="20%" ng-bind="vo.name" class="text-left"></td>
                        <td width="15%" ng-bind="vo.stationname" class="text-left"></td>
                        <td width="20%" ng-bind="vo.baseMap" class="text-center"></td>
                        <td width="10%" ng-bind="vo.isDisplay" class="text-center"></td>
                        <td width="15%" class="text-center">
                            <a class="text-info"><i class="icon-note" ng-click="createSvg(vo.id);" data-toggle="tooltip"></i></a>
                            <a class="text-info"><i class="icon-trash" ng-click="deleteSingleData({{vo.id}},'deletePowerStation');"></i></a>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </paging>
        </div>
    </div>
</div>
<script type="text/javascript">
    app.controller('SvgManagerCtrl', function($scope, $http, $state) {
        initTableConfig($scope);
        $scope.onSelectPage = function(page) {
            if(!page){
                page = 1;
                $scope.currentPage=1;
            }
            $http({
                method : "POST",
                url : "${ctx}/BLayoutConfig/queryBLayoutConfigByPage.htm",
                params : {
                    'pageIndex' : page - 1,
                    'pageSize' : $scope.pageSizeSelect
                }
            }).success(function(result) {
                getTableData($scope, result);
            });
        };
        $scope.onSelectPage(1);

        $scope.createSvg = function (id) {
            $state.go("app.svgCreate", {
                'id': id
            });
        };

        $scope.deleteSingleData = function (id) {
            if (confirm("您确定要删除此条数据？")){
                $scope.deleteData([id]);
            }
        };

        $scope.deleteBatch = function () {
            if (!confirm("您确定要删除这些数据？")){
                return;
            }
            var ids = [];
            $("input[name='ids']:checked").each(function () {
                ids.push($(this).val());
            });
            if (ids.length == 0){
                alert("请选择删除的数据");
                return;
            }
            $scope.deleteData(ids);
        };

        $scope.deleteData = function (ids) {
            $http({
                method : "POST",
                url : "${ctx}/BLayoutConfig/deleteBLayoutConfig.htm",
                params : {
                    'ids': ids
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
    });
</script>