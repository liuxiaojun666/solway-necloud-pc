<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
    g rect.rectLayout{
        cursor: pointer;
    }
</style>
<div class="app-content-full-svg" ng-controller="DeviceLayoutViewCtrl" style="margin-top:50px;background-color: #f0f3f4">
    <div class="hbox " >
        <!-- column -->
        <div class="col">
            <!-- 头部布局 -->
            <div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
                <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;line-height: 50px;">{{currentDataName | companyInfoFilter:parentName}}</span>
                <span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
                <!-- <span ng-bind="pstationName" style="line-height: 50px;font-size: 16px;color: #333;margin-left: 30px;"></span>
                <span class="font-h3 blue-1 text-black" style="line-height: 50px;margin-left: 10px;">布局视图</span>-->

                <!-- nabar right -->
                <ul class="nav navbar-nav navbar-right m-r-xxl" name="selectDevStatusLegend">
                    <a id="legendICO0" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this, -1)">
                        <i class="fa fa-circle-o" style="display: none;"/>
                        <i class="fa fa-check-circle" style="color: #333"/> 全选
                        <input type="hidden" value="" name="all_deviceId_jqselect"/>
                    </a>
                    <a id="legendICO1" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this, 0)">
                        <i class="fa fa-circle-o" style="display: none;color: #3fad22;"/><i class="fa fa-check-circle-o" style="color: #3fad22;" /> 正常
                        <input type="hidden" value="" name="normal_deviceId_jqselect"/>
                    </a>
                    <a id="legendICO2" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this, 2)">
                        <i class="fa fa-circle-o" style="display: none;color: #db412f;"/><i class="fa fa-check-circle-o" style="color: #db412f;" /> 故障
                        <input type="hidden" value="" name="error_deviceId_jqselect"/>
                    </a>
                    <a id="legendICO3" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this, 3)">
                        <i class="fa fa-circle-o" style="display: none;color: #f90;"/><i class="fa fa-check-circle-o" style="color: #f90;" /> 报警
                        <input type="hidden" value="" name="alert_deviceId_jqselect"/>
                    </a>
                    <a id="legendICO4" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this, 1)">
                        <i class="fa fa-circle-o" style="display: none;color: #999;"/><i class="fa fa-check-circle-o" style="color: #999;" /> 中断
                        <input type="hidden" value="" name="break_deviceId_jqselect"/>
                    </a>
                    <a id="legendICO5" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this, 4)">
                        <i class="fa fa-circle" style="display: none;color: #ccc;"/><i class="fa fa-check-circle" style="color: #ccc;" /> 阴影遮挡
                        <input type="hidden" value="" name="shadow_deviceId_jqselect"/>
                    </a>
                </ul>
            </div>
            <!-- 主体布局 -->
            <div class="col-xs-12" id="deviceContent" style="overflow: auto;padding:0;">
                <div id="response_respStatus" style="display: none;"
                     class="alert alert-danger" role="alert">未接收到任何数据。请等待...</div>
                <div id="response_respStatusnull" style="display: none;"
                     class="alert alert-danger" role="alert">返回数据异常！</div>
                <div id="comm_interruptDev" style="display: none;"
                     class="alert alert-danger" role="alert">
                    通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于<span
                        ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
                </div>
                <div id="comm_initDev" style="display: none;" class="alert alert-info"
                     role="alert">设备初始化，未接收到任何数据。请等待...</div>
                <div class="row-row" style="padding: 0;" id="svgView"></div>
            </div>
        </div>
    </div>
    <div ng-include="showModelDiv1" ></div>
	<div ng-include="showModelDiv2" ></div>
	<div ng-include="showModelDiv3" ></div>
    <div ng-include="showModelDiv4" ></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript" src="${ctx}/theme/js/wp/svgUtils.js"></script>
<script type="text/javascript">
    var commonStatus = [0, 1, 2, 3], bunchStatus = [0, 1, 2, 3], bunchShadow = 1;
    var flushHlx, flushNbq, flushNbqHlx, flushXb, hlxData, nbqData, xbData, nbqhlxData;

    app.controller("DeviceLayoutViewCtrl", function ($scope, $timeout, $http, $interval) {
        $scope.getCurrentDataName('00',0);
        $scope.$on('broadcastSwitchStation', function(event, data) {
            $scope.currentDataName = data.dataName;
            $scope.powerStationId = data.dataId;
            $scope.parentId = data.dataId;
            if (SvgUtils.Hlx){
                SvgUtils.Hlx.collectionFlag = true;
                SvgUtils.Hlx.bunchFlag = true;
                SvgUtils.Nbq.collectionFlag = true;
                SvgUtils.Xb.collectionFlag = true;
            }
            $scope.getDeviceLayout($scope.powerStationId);
        });

		$scope.allDevice;
        $scope.$on('refreshViewDataForHead', function(event, data) {
            $scope.powerStationId = data.dataId;
            if (SvgUtils.Hlx){
                SvgUtils.Hlx.collectionFlag = true;
                SvgUtils.Hlx.bunchFlag = true;
                SvgUtils.Nbq.collectionFlag = true;
                SvgUtils.Xb.collectionFlag = true;
            }
            $scope.getDeviceLayout($scope.powerStationId);
        });

        $scope.hlxDids,$scope.hlxFlag;
        $scope.nbqDids,$scope.nbqFlag;
        $scope.nbqhlxDids,$scope.nbqhlxFlag;
        $scope.xbDids,$scope.xbFlag;
        $scope.videos,$scope.videoFlag;
        $scope.getDeviceLayout = function (stid) {
            $scope.hlxDids = []; $scope.hlxFlag = false;
            $scope.nbqDids = []; $scope.nbqFlag = false;
            $scope.nbqhlxDids = [];$scope.nbqhlxFlag = false;
            $scope.xbDids = []; $scope.xbFlag = false;
            $scope.videos = []; $scope.videoFlag = false;
            $http({
                method : "POST",
                url : "${ctx}/RtmDeviceLayout/getDeviceLayoutSvg.htm",
                params : {"stid": stid}
            }).success(function (result) {
                if (result.key == 0){
                	$scope.allDevice = result.allDevice;
                    $("#svgView").empty().html(result.data);
//                    $("#canvas_background").attr("fill","#F0F3F4");
                    $("#svgView g[type='HLX']").each(function () {
                        $scope.hlxDids.push($(this).attr("deviceId"));
                    });
                    $("#svgView g[type='NBQ']").each(function () {
                        $scope.nbqDids.push($(this).attr("deviceId"));
                    });
                    $("#svgView g[type='NBQHLX']").each(function () {
                        $scope.nbqhlxDids.push($(this).attr("deviceId"));
                    });
                    $("#svgView g[type='XB']").each(function () {
                        $scope.xbDids.push($(this).attr("deviceId"));
                    });
                    $("#svgView g[type='videoImage']").each(function () {
                        $scope.videos.push($(this).attr("deviceId"));
                    });
                    $scope.hlxFlag = $scope.hlxDids && $scope.hlxDids.length > 0;
                    $scope.nbqFlag = $scope.nbqDids && $scope.nbqDids.length > 0;
                    $scope.nbqhlxFlag = $scope.nbqhlxDids && $scope.nbqhlxDids.length > 0;
                    $scope.hlxFlag = $scope.xbDids && $scope.xbDids.length > 0;
                    $scope.videoFlag = $scope.videos && $scope.videos.length > 0;
                    $scope.getVideos();
                    $scope.flushStatus();
                    $scope.deviceEvent(); //添加监听事件
                    //tip组件
                    $.each($scope.allDevice, function(i, v){
                        var $device = $("#svgView").find("g[deviceid='" + v.serialNumber + "'][type!='videoImage']");
                        $device.attr('data-toggle', 'tooltip')
                                .attr('data-placement', 'right')
                                .attr('id', v.id)
                                .attr('title', v.name);
                    })
                    $("#svgView").find("g").tooltip({
                        'container': 'body'
                    });
                    return;
                }
                $("#svgView").empty().html("暂无数据");
            });
        };
        $scope.getDeviceLayout();

        var timerdlv = setInterval(function() {
        	$scope.flushStatus();
		}, 5000);
        
        $scope.$on('$stateChangeStart', function(event) {
			clearInterval(timerdlv);
		});

        $scope.getVideos = function () {
            if ($scope.videoFlag){
                $http({
                    method : "POST",
                    url : "${ctx}/DeviceLayout/getVideoNames.htm",
                    params : {
                        "ids": $scope.videos.join(","),
                    }
                }).success(function (result) {
                    if (result.code == 0) {
                        console.info(result.data);
                        $(result.data).each(function (i, v) {
                            $("#svgView g[type='videoImage'][deviceid='" + v.id + "']").attr('data-toggle', 'tooltip')
                                    .attr('data-placement', 'right')
                                    .attr('data-original-title', v.pointName).tooltip({
                                        'container': 'body'
                                    });;
                        });
                    }
                })
            }
        }


        $scope.flushStatus = function () {
            if ($scope.hlxFlag || $scope.nbqFlag || $scope.xbFlag || $scope.nbqhlxFlag){
                $http({
                    method : "POST",
                    url : "${ctx}/RtmDeviceLayout/getDeviceStatus.htm",
                    params : {
                        "hlxs": $scope.hlxDids.join(","),
                        "nbqs": $scope.nbqDids.join(","),
                        "nbqhlxs":$scope.nbqhlxDids.join(","),
                        "xbs": $scope.xbDids.join(",")
                    }
                }).success(function (result) {
                    if (result.key == 0){
                        if (SvgUtils.Hlx){
                            hlxData = result.hlx;
                            if (hlxData) {
                                $scope.flushHlx(hlxData);
                            }
                        }
                        if (SvgUtils.Nbq){
                            nbqData = result.nbq;
                            if (nbqData) {
                                $scope.flushNbq(nbqData);
                            }
                        }
                        if (SvgUtils.NbqHlx){
                            nbqhlxData = result.nbqhlx;
                            if (nbqhlxData) {
                                $scope.flushNbqHlx(nbqhlxData);
                            }
                        }
                        if (SvgUtils.Xb){
                            xbData = result.xb;
                            if (xbData) {
                                $scope.flushXb(xbData);
                            }
                        }
                    }
                });
            }
        };

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

        flushHlx = $scope.flushHlx = function (data) {
            SvgUtils.Hlx.flushHlx(data, null, function ($obj, data) {
                $obj.show();
                if ((!!commonStatus && commonStatus.length == 0) &&
                    (!!bunchStatus && bunchStatus.length == 0) && (bunchShadow == 0)){
                    $obj.hide();
                    return true;
                }

                if((!!commonStatus &&commonStatus.length > 0) && !$scope.contains(commonStatus, data.status)){
                    $obj.hide();
                    return true;
                }

                var len;
                if (data.bunch && (len = data.bunch.length) > 0){
                    for (var i=0;i<len;i++){
                        if (data.bunch[i].status == 3){
                            if (bunchShadow == 0){
                                if (data.bunch[i].shadow == 1){
                                    $obj.hide();
                                    return true;
                                }
                            }else {
                                if ((!!commonStatus && commonStatus.length == 0) &&
                                    (!!bunchStatus && bunchStatus.length == 0)){
                                    if (data.bunch[i].shadow == 0){
                                        $obj.hide();
                                        return true;
                                    }
                                }
                            }
                        }else {
                            if (!!bunchStatus && bunchStatus.length == 0) continue;
                            if (!$scope.contains(bunchStatus, data.bunch[i].status)){
                                $obj.hide();
                                return true;
                            }
                        }
                    }
                }
                return true;
            });
        };

        flushNbqHlx = $scope.flushNbqHlx = function (data) {
            SvgUtils.NbqHlx.flushNbqHlx(data, null, function ($obj, data) {
                $obj.show();
                if ((!!commonStatus && commonStatus.length == 0) &&
                        (!!bunchStatus && bunchStatus.length == 0) && (bunchShadow == 0)){
                    $obj.hide();
                    return true;
                }

                if((!!commonStatus &&commonStatus.length > 0) && !$scope.contains(commonStatus, data.status)){
                    $obj.hide();
                    return true;
                }

                var len;
                if (data.bunch && (len = data.bunch.length) > 0){
                    for (var i=0;i<len;i++){
                        if (data.bunch[i].status == 3){
                            if (bunchShadow == 0){
                                if (data.bunch[i].shadow == 1){
                                    $obj.hide();
                                    return true;
                                }
                            }else {
                                if ((!!commonStatus && commonStatus.length == 0) &&
                                        (!!bunchStatus && bunchStatus.length == 0)){
                                    if (data.bunch[i].shadow == 0){
                                        $obj.hide();
                                        return true;
                                    }
                                }
                            }
                        }else {
                            if (!!bunchStatus && bunchStatus.length == 0) continue;
                            if (!$scope.contains(bunchStatus, data.bunch[i].status)){
                                $obj.hide();
                                return true;
                            }
                        }
                    }
                }
                return true;
            });
        };

        flushNbq = $scope.flushNbq = function (data) {
            SvgUtils.Nbq.flushNbq(data, null, function ($obj, data) {
                $obj.show();
                if (!$scope.contains(commonStatus, data.status)){
                    $obj.hide();
                    return false;
                }
                return true;
            });
        };

        flushXb = $scope.flushXb = function (data) {
            SvgUtils.Xb.flushXb(data, null, function ($obj, data) {
                $obj.show();
                if (!$scope.contains(commonStatus, data.status)){
                    $obj.hide();
                    return false;
                }
                return true;
            });
        };

        $scope.contains = function (arr, dest) {
            return contains(arr, dest);
        };

        $scope.deviceEvent = function () {
            $("g rect.rectLayout").dblclick(function () {
                $scope.deviceEventDeal($(this).parents("g"), "dbclick");
            }).mousemove(function () {
                $scope.deviceEventDeal($(this).parents("g"), "mousemove");
            });
        };

        $scope.deviceEventDeal = function ($device, eventType) {
            var $parent = $(this).parents("g");
            var type = $device.attr("type");
            if(eventType == 'dbclick'){
                var deviceId = $device.attr("deviceId");
            	var id = $device.attr("id");
            	switch (type){
                    case "NBQHLX":
                        $scope.showHistoryData_byRTMDeviceLogId($scope.powerStationId,id,deviceId,"2","1");
                        break;
	                case "HLX":
	                	$scope.showHistoryData_byRTMDeviceLogId($scope.powerStationId,id,deviceId,"1");
//	                    console.log("event1:" + eventType + ", type:" + $device.attr("type") + ", deviceId:" + $device.attr("deviceId"));
	                    break;
	                case "NBQ":
	                	$scope.showHistoryData_byRTMDeviceLogId($scope.powerStationId,id,deviceId,"2","0");
	                    break;
	                case "XB":
	                	$scope.showHistoryData_byRTMDeviceLogId($scope.powerStationId,id,deviceId,"3");
	                    break;
	                case "videoImage":
                        $scope.showVideoLive($scope.powerStationId, id, deviceId);
//	                	console.log("event:" + eventType + ", type:" + $device.attr("type") + ", deviceId:" + $device.attr("deviceId"));
	                    break;
            	}	
            }
            
        };
        
      //双击按钮事件
		$scope.showHistoryData_byRTMDeviceLogId = function (pstationid,deviceid,deviceSerialNnumber,deviceType,hasJB) {
			var res = {};
			res.deviceSerialNnumber = deviceSerialNnumber;
			res.deviceId = deviceid;
			res.pstationid = pstationid;
			res.deviceTypeNow = deviceType;
			$scope.deviceTypeNow = deviceType;
			
			$scope.inverterType = hasJB;
			if(deviceType == '3'){
				$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});
				//$scope.$emit("showDeviceDetail3", res);
				$scope.$broadcast("showDeviceDetail3broad", res);
			}else if(deviceType == '2'){
				$('#taskList_historyData2').modal({backdrop: 'static', keyboard: false});
				//$scope.$emit("showDeviceDetail2", res);
				$scope.$broadcast("showDeviceDetail2broad", res);
			}else if(deviceType == '1'){
				$('#taskList_historyData1').modal({backdrop: 'static', keyboard: false});
				//$scope.$emit("showDeviceDetail1", res);
				$scope.$broadcast("showDeviceDetail1broad", res);
			}
			
			//$scope.showHistoryData_byRTMDeviceLogId(pstationid,deviceid,deviceSerialNnumber,deviceType);
        };
        $scope.showVideoLive = function (pstationid,deviceid,deviceSerialNnumber) {
            $http({
                method : "POST",
                url : "${ctx}/PowerStationMonitor/getVideo.htm",
                params: {
                    stid: pstationid,
                    deviceId: deviceSerialNnumber
                }
            }).success(function(result) {
                $('#liveVideoModal').modal({backdrop: 'static', keyboard: false});
                $scope.$broadcast("videoLiveItem", result);
            });
        }
        
      
		 /*查看设备运行数据*/ //单击按钮事件 关闭 "待加载链接地址"弹出页面
		$scope.closeHistoryData_byRTMDeviceLogId=function(msg){
			$scope.deviceTypeNow = "-1";
        }
		$scope.showModelDiv1="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp";
	    $scope.showModelDiv2="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData2.jsp";
	    $scope.showModelDiv3="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData3.jsp";
        $scope.showModelDiv4="${ctx}/tpl/rtMonitorPage/monitor/realistic2.jsp";
  
    });

    function isAllSelect() {
        $("#legendICO0 i:eq(0)").show();
        $("#legendICO0 i:eq(1)").hide();
        if ($("ul[name='selectDevStatusLegend'] i:gt(1):odd:visible").length
            == $("ul[name='selectDevStatusLegend'] i:gt(1):odd").length){
            $("#legendICO0 i:eq(0)").hide();
            $("#legendICO0 i:eq(1)").show();
        }
    }
    
    function selectDevStatusLegend(obj, arr) {
        var _this = $(obj);
        var allFlag = true;
        if (arr == -1){
            if (_this.find("i:eq(0)").is(":visible")){
                _this.parent("ul").find("i:even").hide();
                _this.parent("ul").find("i:odd").show();
                commonStatus = [0, 1, 2, 3];
                bunchStatus = [0, 1, 2, 3];
                bunchShadow = 1;
                allFlag = false;
            }else {
                _this.parent("ul").find("i:even").show();
                _this.parent("ul").find("i:odd").hide();
                commonStatus = [];
                bunchStatus = [];
                bunchShadow = 0;
                allFlag = true;
            }
            if (hlxData)
                flushHlx(hlxData, allFlag);
            if (nbqData)
                flushNbq(nbqData, allFlag);
            if (xbData)
                flushXb(xbData, allFlag);
            if (nbqhlxData)
                flushNbqHlx(nbqhlxData, allFlag);
            return;
        }

        if (_this.find("i:eq(0)").is(":visible")){
            _this.find("i:eq(0)").hide();
            _this.find("i:eq(1)").show();
            if (arr == 4){
                bunchShadow = 1;
            }else {
                commonStatus.push(arr);
                switch (arr){
                    case 0: // normal
                        bunchStatus.push(3);
                        break;
                    case 2: // error
                        bunchStatus.push(1);
                        break;
                    case 3: // alert
                        bunchStatus.push(2);
                        break;
                }
            }
        }else {
            _this.find("i:eq(0)").show();
            _this.find("i:eq(1)").hide();
            if (arr == 4){
                bunchShadow = 0;
            }else {
                commonStatus = deleteRemove(commonStatus, arr);
                switch (arr){
                    case 0:
                        bunchStatus = deleteRemove(bunchStatus, 3);
                        break;
                    case 2:
                        bunchStatus = deleteRemove(bunchStatus, 1);
                        break;
                    case 3:
                        bunchStatus = deleteRemove(bunchStatus, 2);
                        break;
                }
            }
        }
        isAllSelect();
        if (hlxData)
            flushHlx(hlxData);
        if (nbqData)
            flushNbq(nbqData);
        if (xbData)
            flushXb(xbData);
        if (nbqhlxData)
            flushNbqHlx(nbqhlxData);
    }

    function contains(arr, dest) {
        if (arr == null || arr.length == 0) return false;
        for (var i=0,ii=arr.length;i<ii;i++){
            if(arr[i] == dest){
                return true;
            }
        }
        return false
    }

    function deleteRemove(arr, dest) {
        if (arr == null) return arr;
        var tempArr = [];
        for (var i=0,ii=arr.length;i<ii;i++){
            if(arr[i] != dest){
                tempArr.push(arr[i]);
            }
        }
        return tempArr;
    }
</script>