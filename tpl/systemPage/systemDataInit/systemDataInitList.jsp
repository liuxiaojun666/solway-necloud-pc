<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script type="text/javascript">
    function goPage(pageIndex) {
        $("#searchBtn").trigger("click");
    }

    function deleteRow(id) {
        if (confirm("确定要删除这条数据吗？")) {
            singledel(id);
        }
    }
    function singledel(id) {
        $.ajax({
            type : "post",
            url : "${ctx}/systemDataInit/delete.htm",
            data : {
                "id" : id
            },
            dataType : "json",
            success : function(json) {
                goPage(0);
            },
            error : function() {
                promptObj('error', '',"删除失败");
            }
        });
    }

    app.controller('systemDataInitCtrl', function($scope, $http, $state) {
        $scope.createManufacturer = function(id, name) {
            $state.go("app.addSystemDataInit", {
                manId : id
            });
        }
        $scope.deleteRow = function(id) {
            deleteRow(id);
        }
        $scope.deleteBatch = function () {

            var ids = [];
            $("input[name='ids']:checked").each(function () {
                ids.push($(this).val());
            });
            if (ids.length == 0) {
                alert("请选择数据");
                return;
            }
            if (!confirm("确定要删除这些数据吗？")) return;
            console.info(ids);
            $http({
                method : "POST",
                url : "${ctx}/systemDataInit/deleteBatch.htm",
                params : {
                    "ids": ids
                }
            }).success(function(result) {
                if (result.code == 0){
                    promptObj('success','','删除成功');
                    $scope.onSelectPage(1);
                    return;
                }
                promptObj('error','', '删除失败');
            });
        };
        $scope.editData = function(id,modalId) {
            editData(id,modalId);
        }
        $scope.viewData = function(id,modalId) {
            viewData(id,modalId);
        }
        initTableConfig($scope);
        $scope.onSelectPage = function(page) {
            if(!page){
                page = 1;
                $scope.currentPage=1;
            }
            $http({
                method : "POST",
                url : "${ctx}/systemDataInit/page.htm",
                params : {
                    'pageIndex' : page - 1,
                    'pageSize' : $scope.pageSizeSelect,
                    'keyWords' : $scope.keyWords
                }
            }).success(function(result) {
                getTableData($scope, result.data);
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
<div id="systemDataInitEdit" data-ng-include="'${ctx}/tpl/systemPage/systemDataInit/addSystemDataInit.jsp'"></div>
<div id="systemDataInitView" data-ng-include="'${ctx}/tpl/systemPage/systemDataInit/systemDataInitDetail.jsp'"></div>
<div ng-controller="systemDataInitCtrl">
    <div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">系统数据修改操作记录</span>
    </div>
    <div class="wrapper-md ng-scope">
        <div class="panel panel-default">
            <paging class="col-sm-12 panel no-padder">
                <div class="row wrapper">
                    <div class="col-sm-4 m-b-xs w-sm p-r-sm">
                        <button class="btn btn-sm btn-info m-r-xs" ng-click="addData('systemDataInitModal');">新增</button>
                        <button class="btn btn-sm btn-default m-r-xs" ng-click="deleteBatch();">批量删除</button>
                    </div>
                    <div class="col-sm-3 no-padder">
                        <div class="col-sm-9 no-padder">
                            <div class="input-group p-r-sm">
                                <input type="text" ng-model="keyWords" id="keyWords" class="input-sm form-control" placeholder="关键字">
                                <span class="input-group-btn">
								<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);" id="searchBtn" type="button">查询</button>
							</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <paging class="col-sm-12 panel no-padder">
                        <table id="result_table" class="table table-striped b-t b-light">
                            <thead>
                                <tr>
                                    <th style="width: 20px;">
                                        <label class="i-checks m-b-none">
                                            <input type="checkbox" id="all" onclick="changeAll(this.checked,'ids');" /><i></i>
                                        </label>
                                    </th>
                                    <th>公司名称</th>
                                    <th>电站名称</th>
                                    <th>设备名称</th>
                                    <th>开始时间</th>
                                    <th>结束时间</th>
                                    <th>任务生成时间</th>
                                    <th>任务执行时间</th>
                                    <th>类型</th>
                                    <th>任务执行情况</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="vo in data ">
                                    <td>
                                        <label class="i-checks m-b-none">
                                        <input type="checkbox" name="ids" id="ids" value="{{vo.id }}" /> <i></i>
                                        </label>
                                    </td>
                                    <td > <a class="href-blur" ng-bind="vo.companyName" ng-click="viewData({{ vo.id }}, 'systemDataInitViewModal');"></a></td>
                                    <td ng-bind="vo.stationName"></td>
                                    <td ng-bind="vo.deviceName"></td>
                                    <td ng-bind="vo.beginTime"></td>
                                    <td ng-bind="vo.endTime"></td>
                                    <td ng-bind="vo.createTime"></td>
                                    <td ng-bind="vo.executeTime"></td>
                                    <td ng-bind="vo.typeName"></td>
                                    <td ng-bind="vo.statusName"></td>
                                    <td>
                                        <a class="text-info"><i class="icon-note" ng-click="editData({{ vo.id }},'systemDataInitModal');" ></i></a>
                                        <a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </paging>
                </div>
            </paging>
        </div>
    </div>
</div>
