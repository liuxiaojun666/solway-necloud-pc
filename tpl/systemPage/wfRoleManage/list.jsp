<%--
  User: GreenBook
  Date: 2017/6/15
  Time: 16:44
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
--%>

<script type="text/javascript">
    /*
     */
    app.controller('wfRoleCtrl', function ($scope, $http, $state, $stateParams) {
        $scope.init = function () {
            $http({
                method: "get",
                url: "${ctx}/wfRole/getStations.htm",
                params: {
                    companyId: $stateParams.companyId
                }
            }).success(function (result) {
                if (result.code == 0) {
                    $scope.stationItems = result.data;
                    if ($scope.stationItems) {
                        $scope.getStation($scope.stationItems[0]);
                    }
                }
            });

        }
        $scope.init();

        $scope.getStation = function(item) {
            $('#all').attr("checked", false);
            $scope.currentStation = item;

            $http({
                method: "get",
                url: "${ctx}/wfRole/getWfRoles.htm",
                params: {
                    companyId: $scope.currentStation.companyid,
                    stationId: $scope.currentStation.id,
                }
            }).success(function (result) {
                if (result.code == 0) {
                    $scope.wfRoleItems = result.data;
                }
            });

        };
        $scope.getWfRoles = function(item) {
            $scope.currentWfRoleId = item.id;
        };
        $scope.userChange = function(roleId, user) {
            $('input[name="roleId"]').each(function(){
                if($(this).val() == roleId) {
                    user.roleId = roleId;
                    $(this).parents('tr').find('.text-danger').html('');
                }
            });
        };
        $scope.save = function() {
            var objArr = [];
            var checkFlag = false, count = 0;
            $('input[name="roleId"]:checked').each(function(i){
                checkFlag = true;
                var $tr = $(this).parents('tr');
                var userId = $tr.find('input[name="userId"]').val();
                if (userId == '' || userId == null) {
                    $tr.find('.text-danger').html('请选择用户');
                    count += 1;
                } else {
                    $tr.find('.text-danger').html('');
                    objArr.push({
                        roleId: $(this).val(),
                        companyId: $scope.currentStation.companyid,
                        stationId: $scope.currentStation.id,
                        userId: userId,
                        id: $tr.find('input[name="wfRoleUserId"]').val()
                    })
                }
            });
            if (!checkFlag) {
                $('#topErrMsg').html('请选择角色');
            } else {
                if (count == 0 && objArr.length < 2) {
                    $('#topErrMsg').html('至少选择两个角色');
                } else {
                    $('#topErrMsg').html('');
                }
            }
            if (!checkFlag || count > 0 || objArr.length < 2) {
                return;
            }
            $.ajax({
                url: "${ctx}/wfRole/update.htm",
                method: 'POST',
                data:{
                    vsStr: angular.toJson(objArr, true),
                    companyId: $scope.currentStation.companyid,
                    stationId: $scope.currentStation.id
                },
                dataType:'json',
                success:function(result){
                    if (result.code == 0) {
                        $scope.getStation($scope.currentStation);
                        promptObj('success', "","保存成功");
                    } else {
                        promptObj('error', '', result.message ? result.message: "保存失败");
                    }
                }
            });
        }
    });
</script>
<div ng-controller="wfRoleCtrl">
    <div class="wrapper-md bg-light b-b">
        <span class="font-h3 blue-1 m-n text-black">报表填报流程 角色和用户 管理</span>
    </div>
    <div class="wrapper-md ng-scope">
        <div class="col-sm-3 panel panel-default">
            <div class="panel no-padder" style="height:500px;overflow:auto;overflow-x:hidden;">
                <%--
                --%>
                <div class="wrapper">
                    <span class="font-h3 blue-1 m-n text-black">电站</span>
                </div>
                <ul class="list-group">
                    <li class="list-group-item" ng-repeat="vo in stationItems">
                        <a ng-click="getStation({{vo}})" class="{{currentStation.id == vo.id ? 'text-primary': ''}}">{{vo.stationname}}</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-sm-9 panel panel-default">
            <form id="dataFrom" name="dataForm" action="${ctx}/wfRole/update.htm">
            <div class="col-sm-12 panel no-padder">
                <div class="row wrapper">
                    <div class="col-sm-6">
                        <span class="font-h3 blue-1 m-n text-black">角色及用户</span>
                        <a class="btn btn-sm btn-info m-r-xs" ng-click="save();">保存</a>
                    </div>
                    <div class="col-sm-2 pull-right text-right">
                        <div class="text-danger" id="topErrMsg"></div>
                    </div>
                </div>

                <div>
                    <table id="result_table" class="table table-striped b-t b-light">
                        <thead>
                            <tr>
                                <th style="width: 20px;">
                                    <label class="i-checks m-b-none">
                                        <input type="checkbox" id="all" onclick="changeAll(this.checked,'roleId');" class="form-control formData"/><i></i>
                                    </label>
                                </th>
                                <th style="width: 60px;">序号</th>
                                <th style="width: 180px;">角色名称</th>
                                <th style="width: 180px;">角色别名</th>
                                <th>用户</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="vo in wfRoleItems">
                                <input type="hidden" name="wfRoleUserId" value="{{vo.user.id}}" class="form-control formData"/>
                                <td>
                                    <label class="i-checks m-b-none">
                                        <input type="checkbox" name="roleId" value="{{vo.id }}" ng-checked="vo.id == vo.user.roleId"/> <i></i>
                                    </label>
                                </td>
                                <td ng-bind="$index + 1"></td>
                                <td ng-bind="vo.name"></td>
                                <td ng-bind="vo.aliasName"></td>
                                <td>
                                    <ui-select ng-model="vo.user" theme="bootstrap" ng-change="userChange(vo.id, vo.user)">
                                        <ui-select-match placeholder="请输入关键字..." ng-model="vo.user.realName? vo.user.realName : vo.user.userName" >{{$select.selected.realName ? $select.selected.realName : $select.selected.userName}}</ui-select-match>
                                        <ui-select-choices  repeat="item in vo.users | filter: $select.search">
                                            <div ng-bind-html="item.realName? item.realName : item.userName | highlight: $select.search"></div>
                                        </ui-select-choices>
                                    </ui-select>
                                    <%--<input type="hidden" ng-model="vo.user.userId" name="userId" class="form-control formData">--%>
                                    <input type="hidden" value="{{vo.user.userId}}" name="userId" class="form-control formData">
                                    <div class="text-danger"></div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            </form>
        </div>
    </div>
</div>

