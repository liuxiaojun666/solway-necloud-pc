<%--
  User: GreenBook
  Date: 2017/5/18
  Time: 15:11
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
.con-tab{ cursor: pointer;margin-right: 15px;padding: 0;display: inline-block;background-color: transparent;border-radius:0;    font-size: 16px;}
.con-tab.con-active{border-bottom:2px solid #06BEBD;color: #06BEBD;background-color: transparent;border-radius:0;}
</style>
<div ng-controller="deviceLayoutTabCtrl">
    <div style="    padding: 15px 20px;">
        <a type="button" class="con-tab" ng-class="{true: 'con-active' }[item.active]" ng-repeat="item in layouts" ng-click="selectLayout($index)" ng-bind="item.title"></a>
    </div>
    <div ng-include="showDeviceLayoutDiv" class="clearfix"></div>
</div>
<script type="text/javascript">
    app.controller('deviceLayoutTabCtrl', function($scope) {

        $scope.layouts = [
            { title: '列表视图', template: 'tpl/rtMonitorPage/deviceLayout/deviceList.jsp', active: false},
            { title: '历史数据查询', template: 'tpl/rtMonitorPage/historyData/historyDataList.jsp', active: false},
            { title: '电站功率趋势图', template: 'tpl/rtMonitorPage/historyPowerLine/historyPowerLine.jsp', active: false},
            { title: '历史功率趋势图', template: 'tpl/rtMonitorPage/historyPowerLine/historyDeviceLine.jsp', active: false}
        ];

        $scope.selectLayout = function (v) {
            for(var i= 0, lng = $scope.layouts.length; i < lng; i++) {
                if (i == v) {
                    $scope.layouts[i].active = true;
                } else {
                    $scope.layouts[i].active = false;
                }
                if (v == 1) {
                }
            }
            $scope.showDeviceLayoutDiv = $scope.layouts[v].template;
        };
        $scope.selectLayout(0);
    });
</script>