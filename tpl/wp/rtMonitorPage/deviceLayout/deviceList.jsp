<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
    #head-title{display: none;}
    .panel{background: transparent!important;border:transparent!important;}
    /* #styleDiv .ngGrid {background: #1c2b36!important;} */
    #styleDiv .ngRow.even {background-color: #fff!important;color: #333!important;}
    #styleDiv .ngRow.odd {background-color: #fafbfd!important;color: #333!important;}
    .ngHeaderScroller {background-color: #f0f3f4 !important;}
    #styleDiv .ngRow {position: absolute;border-bottom: 1px solid transparent!important;padding: 5px 0;}
    #styleDiv .ngTopPanel {position: relative; z-index: 1; background-color: inherit!important;border-bottom: 1px solid transparent!important;height: 40px;}
    #styleDiv .ngTopPanel .ngHeaderContainer {border-bottom: 1px solid rgba(255, 255, 255,.2)!important;}
    .app-aside-fixed .aside-wrap {background-color: #1c2b36;}
    .navbar-btn .fa {font-size: 18px;vertical-align: middle;}
    .app-content-full-map {background-color: transparent!important;}
</style>
<div class="app-content-full-map" ng-controller="WpDeviceLayoutCtrl" style="margin-top:50px;">
    <div class="hbox " >
        <!-- column -->
        <div class="col">
            <!-- 主体布局 -->
            <div class="col-xs-12 no-padder" id="deviceContent" style="overflow: hidden;">
                <div>
                    <div ng-include="showDeviceLayoutDiv"></div>
                </div>
            </div>
        </div>
        <!-- /column -->
    </div>
    <div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData.jsp'"></div>
</div>
<div class="waterPlaceholder"></div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">
    var timer;
    app.controller('WpDeviceLayoutCtrl', function($scope, $http, $state,$stateParams) {
        $scope.getCurrentDataName('00',0);
        $scope.$on('broadcastSwitchStation', function(event, data) {
            $scope.currentDataName = data.dataName;
            $scope.layoutInitMethod();
            $scope.getDeviceLayout($scope, $http, $scope.powerStationId);
        });

        $scope.$on('refreshViewDataForHead', function(event, data) {
            $scope.layoutInitMethod();
            $scope.getDeviceLayout($scope, $http, $scope.powerStationId);
        });

        //选择电站
        $scope.stationId = $stateParams.stationId;
        $scope.stationName = $stateParams.stationName;
        $scope.layoutInitMethod=function(){
            //处理查询参数
            if ($stateParams.stationId) {
                $scope.powerStationId = $stateParams.stationId;
                $scope.parentId = $stateParams.stationId;
            } else {
                $http.get("${ctx}/UserAuthHandle/getCurrentInfo.htm").success(
                        function(result) {
                            $scope.powerStationId = result.currentSTID;
                            $scope.parentId = result.currentSTID;
                            $scope.pstationName = result.currentSTName;
                            $scope.parentName = result.currentSTName;
                            //选择电站
                            $scope.stationId = result.currentSTID;
                            $scope.stationName = result.currentSTName;
                        });
            }
        };
        $scope.layoutInitMethod();


        //判断电站状态
        $scope.commnullCount = 0;
        $scope.commCount = 0;
        $scope.getstaDayData=function(){
            $http({
                method : "POST",
                url : "./MobileRtmStationStatus/getRtmSingleStationComm.htm",
                timeout: 5000,
                params : {
                    'dateString':new Date().Format("yyyy-MM-dd")
                }
            }).success(function (msg) {
                $scope.statDayData=msg;
                if (msg.comm == 1) {
                    //通讯中断
                    $("#comm_interruptDev").show();
                    $("#comm_initDev").hide();
                    $("#response_respStatus").hide();
                    $("#response_respStatusnull").hide();
                    $scope.commCount = 0;
                    $scope.commnullCount = 0;
                } else if (msg.comm == 2) {
                    $("#comm_initDev").show();
                    $("#comm_interruptDev").hide();
                    $("#response_respStatus").hide();
                    $("#response_respStatusnull").hide();
                    $scope.commCount = 0;
                    $scope.commnullCount = 0;
                } else if (msg.comm == null) {
                    $scope.commCount = 0;
                    $scope.commnullCount++;
                    if(commnullCount > 3){
                        $("#comm_initDev").hide();
                        $("#comm_interruptDev").hide();
                        $("#response_respStatus").hide();
                        $("#response_respStatusnull").show();
                    }
                } else {
                    $scope.commCount = 0;
                    $scope.commnullCount = 0;
                    $("#comm_interruptDev").hide();
                    $("#comm_initDev").hide();
                    $("#response_respStatus").hide();
                    $("#response_respStatusnull").hide();
                }
            }).error(function(msg){
                $scope.commnullCount = 0;
                $scope.commCount++;
                if ($scope.commCount > 3){
                    $("#response_respStatus").show();
                    $("#comm_interruptDev").hide();
                    $("#comm_initDev").hide();
                    $("#response_respStatusnull").hide();
                }
            });
        };
        $scope.getstaDayData();

        $scope.showDeviceLayout=function(flagDevice){
            $scope.showDeviceLayoutDiv="${ctx}/tpl/wp/rtMonitorPage/deviceLayout/deviceStationIndex.jsp";
        };
        $scope.showDeviceLayout();

        $scope.showHistoryData_byRTMDeviceLogId = {};
        /**
         * 测风塔数据
         * @param id
         * @param serialnumber
         * @param pstationid
         */
        $scope.showWindTowerData = function (id, serialnumber, pstationid) {
            var msg={deviceType:"0", deviceSerialNnumber:"0", pstationid:"0", id:"0", dStartTime:""};
            msg.deviceType = '2';
            msg.deviceSerialNnumber = serialnumber;
            msg.deviceId = id;
            msg.pstationid = pstationid;
            msg.dStartTime = "";
            $scope.showHistoryData_byRTMDeviceLogId_incloud="${ctx}/tpl/wp/rtMonitorPage/windTower/windTowerDetail.jsp";
            //传递查询结果
            $scope.showHistoryData_byRTMDeviceLogId.msg = msg;
        };

        /**
         * 风电机组数据
         * @param id
         * @param serialnumber
         * @param pstationid
         */
        $scope.showWindTurbineData = function (id, serialnumber, pstationid) {
            var msg={deviceType:"0", deviceSerialNnumber:"0", pstationid:"0", id:"0", dStartTime:""};
            msg.deviceType = '1';
            msg.deviceSerialNnumber = serialnumber;
            msg.deviceId = id;
            msg.pstationid = pstationid;
            msg.dStartTime = "";
            $scope.showHistoryData_byRTMDeviceLogId_incloud="${ctx}/tpl/wp/rtMonitorPage/windTurbine/windTurbineDetail.jsp";
            //传递查询结果
            $scope.showHistoryData_byRTMDeviceLogId.msg = msg;
        };

        /*查看设备运行数据*/ //"待加载链接地址" 加载完毕
        $scope.showHistoryData_byRTMDeviceLogId_ready=function(msg){
            $('#taskList_historyData').on('shown.bs.modal', function(e) {
                $(window).trigger('resize');
            });
            var screenHeight=document.body.clientHeight;
            $scope.$broadcast('deviceStation_parameter',$scope.showHistoryData_byRTMDeviceLogId.msg ,2);
            $('#taskList_historyData').modal({backdrop: 'static', keyboard: false});
        };

        /*查看设备运行数据*/ //单击按钮事件 关闭 "待加载链接地址"弹出页面
        $scope.closeHistoryData_byRTMDeviceLogId=function(msg){
//            switch(msg.deviceType){
//                case "1":
//                    break;
//            }
            $scope.serialnumber = "";
            $scope.pstationid = "";
            $scope.InId = "";

            $stateParams.InId = "";
            $stateParams.pstationid = "";
            $stateParams.dstarttime = "";
            $scope.showHistoryData_byRTMDeviceLogId_incloud= "";
        };

        /*设备信息 3.1*/
        $scope.getDeviceLayout=function($scope, $http, stationid) {
            $scope.boxChanges=null;
            $("p[name=nodevicedata]").hide();
            $("p[name=loading]").show();
            $http({
                method : "POST",
                url : "${ctx}/RtmDeviceLayout/getDeviceLayout.htm",
                params : {
                    id : stationid
                }
            }).success(function(result) {
                $scope.boxChanges = result.data;
                //无设备数据
                $scope.isDevice=result.isDevice;
            });
        }
    });
    Date.prototype.Format = function(fmt) { //author: meizz
        var o = {
            "M+" : this.getMonth() + 1, //月份
            "d+" : this.getDate(), //日
            "h+" : this.getHours(), //小时
            "m+" : this.getMinutes(), //分
            "s+" : this.getSeconds(), //秒
            "q+" : Math.floor((this.getMonth() + 3) / 3), //季度
            "S" : this.getMilliseconds()
            //毫秒
        };
        if (/(y+)/.test(fmt))
            fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
                    .substr(4 - RegExp.$1.length));
        for ( var k in o)
            if (new RegExp("(" + k + ")").test(fmt))
                fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
                        : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
