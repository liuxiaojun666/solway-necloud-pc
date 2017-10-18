<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
    app.controller('SystemOperationLogCtrl', function($scope, $http, $state) {
        //列表相关数据初始化
        initTableConfig($scope);
        //查询方法
        $scope.onSelectPage = function(page) {
            if(!page){
                page = 1;
                $scope.currentPage=1;
            }
            $http({
                method : "POST",
                url : "${ctx}/SystemOperationLog/querySystemOperationLogByPage.htm",
                params : {
                    "pageIndex" : page - 1,
                    "pageSize" : $scope.pageSizeSelect,
                    "keyWords": $scope.keyWords,
                    "userName": $scope.userName,
                    "operationModule": $scope.operationModule,
                    "operation": $scope.operation
                }
            }).success(function(result) {
                getTableData($scope, result);
            });
        };
        $scope.onSelectPage(1);
    });
</script>

<!-- 弹出层界面 -->
<div id="SystemOperationLogDetail"
     data-ng-include="'${ctx}/tpl/systemPage/systemOperationLog/systemOperationLogDetail.jsp'"></div>
<div ng-controller="SystemOperationLogCtrl">
    <div class="wrapper-md bg-light b-b">
	<span class="font-h3 blue-1 m-n text-black h4">操作日志管理
	</span>
    </div>
    <div class="wrapper-md ng-scope">
        <div class="panel panel-default">
            <paging class="col-sm-12 panel no-padder">
                <div class="row wrapper">
                    <div class="col-sm-4">
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
							<button class="btn btn-sm btn-default" type="button">操作用户</button>
						</span> <input type="text" ng-model="userName"
                                       class="input-sm form-control">
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">操作模块</button>
						</span> <input type="text" ng-model="operationModule"
                                       class="input-sm form-control">
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">操作类型</button>
						</span> <input type="text" ng-model="operation"
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
                            <th>编号</th>
                            <th>操作用户</th>
                            <th>操作IP</th>
                            <th>操作模块</th>
                            <th>操作方法</th>
                            <th>操作时间</th>
                            <th>操作类型</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="vo in data ">
                            <td ng-bind="vo.id"></td>
                            <td ng-bind="vo.userName"></td>
                            <td ng-bind="vo.operationIP"></td>
                            <td ng-bind="vo.operationModule"></td>
                            <td ng-bind="vo.operationMethod"></td>
                            <td ng-bind="vo.operationTime"></td>
                            <td ng-bind="vo.operation"></td>
                            <td><a class="text-info" ng-click="editData(vo.id ,'DetailSystemOperationLogModal');">查看</a>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </paging>
        </div>
    </div>
</div>
