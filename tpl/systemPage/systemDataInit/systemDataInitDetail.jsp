<%--
  User: GreenBook
  Date: 2017/5/31
  Time: 9:05
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script type="text/javascript">
    $(function() {
        //初始化页面数据
        function initPageData(id) {
            if (id != "" && id != null) {
                getSelected(id);
            } else {
                getSelected(null);
            }
        }
    });


    var getSelected;
    app.controller('viewSystemDataInitCtrl', ['$http',  '$scope',  function($http,$scope){
        getSelected = $scope.getA = function(id){

                if(id != "" && id != null){
                    $http({
                        method:"get",
                        url:"${ctx}/systemDataInit/selectById.htm",
                        params:{
                            id: id
                        }
                    }).success(function (result) {
                        $scope.item = result.data;
                    });
                }
        }
    }]);
    function closeModal(){
        $('#systemDataInitViewModal').modal('hide')
    }
</script>
<div ng-controller="viewSystemDataInitCtrl"  class="modal fade" id="systemDataInitViewModal" tabindex="-1" right="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog row">
        <div class="modal-content ">
            <div class="modal-header">
                <button type="button" class="close" onclick="closeModal()">&times;</button>
                <h4 class="modal-title">系统数据修改操作记录</h4>
            </div>
            <div class="modal-body wrapper-lg">
                <div class="panel-body">
                    <table class="table table-bordered">
                        <tr>
                            <td class="col-lg-2">公司</td>
                            <td class="col-lg-4" ng-bind="item.companyName"></td>
                            <td class="col-lg-2">电站</td>
                            <td class="col-lg-4" ng-bind="item.stationName"></td>
                        </tr>
                        <tr>
                            <td class="col-lg-2">设备</td>
                            <td class="col-lg-4" ng-bind="item.deviceName"></td>
                            <td class="col-lg-2"></td>
                            <td class="col-lg-4"></td>
                        </tr>
                        <tr>
                            <td class="col-lg-2">开始时间</td>
                            <td class="col-lg-4" ng-bind="item.beginTime"></td>
                            <td class="col-lg-2">结束时间</td>
                            <td class="col-lg-4" ng-bind="item.endTime"></td>
                        </tr>
                        <tr>
                            <td class="col-lg-2">任务生成时间</td>
                            <td class="col-lg-4" ng-bind="item.createTime"></td>
                            <td class="col-lg-2">任务执行时间</td>
                            <td class="col-lg-4" ng-bind="item.executeTime"></td>
                        </tr>
                        <tr>
                            <td class="col-lg-2">类型</td>
                            <td class="col-lg-4" ng-bind="item.typeName"></td>
                            <td class="col-lg-2">任务执行情况</td>
                            <td class="col-lg-4" ng-bind="item.statusName"></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="modal-footer">
                <div class="form-group">
                    <div class="col-sm-12 text-center">
                        <button type="button" class="taskBtn btn w-xs" onclick="closeModal()">关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>