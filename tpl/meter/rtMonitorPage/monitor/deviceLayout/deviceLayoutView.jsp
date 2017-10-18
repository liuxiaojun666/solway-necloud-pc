<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
    g rect.rectLayout{
        cursor: pointer;
    }
</style>
<div class="app-content-full-svg" ng-controller="meterDeviceLayoutViewCtrl" style="margin-top:50px;background-color: #f0f3f4">
    <div class="hbox " >
        <!-- column -->
        <div class="col">
            <!-- 头部布局 -->
            <div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
                <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;line-height: 50px;">{{currentDataName | companyInfoFilter:parentName}}</span>
                <span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
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
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript" src="${ctx}/theme/js/array.extend.js"></script>
<script type="text/javascript" src="${ctx}/theme/js/powerMeter/svgUtils.js"></script>
<script type="text/javascript">
    var commonStatus = [0, 1, 2, 3];
    var flushMeter;

    app.controller("meterDeviceLayoutViewCtrl", function ($scope, $timeout, $http, $interval) {


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
                    if($scope.commnullCount > 3){
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


        $scope.getCurrentDataName('00',0);
        $scope.$on('broadcastSwitchStation', function(event, data) {
            $scope.currentDataName = data.dataName;
            $scope.powerStationId = data.dataId;
            $scope.parentId = data.dataId;
            $scope.getDeviceLayout($scope.powerStationId);
        });

		$scope.allDevice;
        $scope.$on('refreshViewDataForHead', function(event, data) {
            $scope.powerStationId = data.dataId;
            $scope.getDeviceLayout($scope.powerStationId);
        });

        $scope.meterDids,$scope.meterFlag;
        $scope.videos,$scope.videoFlag;
        $scope.getDeviceLayout = function (stid) {
            $scope.meterDids = []; $scope.meterFlag = false;
            $scope.videos = []; $scope.videoFlag = false;
            $http({
                method : "POST",
                url : "${ctx}/MeterDeviceLayout/getDeviceLayoutSvg.htm",
                params : {"stid": stid}
            }).success(function (result) {
                if (result.key == 0){
                	$scope.allDevice = result.allDevice;
                    $("#svgView").empty().html(result.data);
//                    $("#canvas_background").attr("fill","#F0F3F4");
                    $("#svgView g[type='Meter']").each(function () {
                        $scope.meterDids.push($(this).attr("deviceId"));
                    });
                    $("#svgView g[type='videoImage']").each(function () {
                        $scope.videos.push($(this).attr("deviceId"));
                    });
                    $scope.meterFlag = $scope.meterDids && $scope.meterDids.length > 0;
                    $scope.videoFlag = $scope.videos && $scope.videos.length > 0;
                    $scope.getVideos();
                    $scope.flushStatus();
                    //$scope.deviceEvent(); //添加监听事件

                    //tip组件
                    $.each($scope.allDevice, function(i, v){
                        var $meter = $("#svgView").find("g[type='Meter'][deviceid='" + v.serialNumber + "']");
                        $meter.attr('data-toggle', 'tooltip')
                            .attr('data-placement', 'right')
                            .attr('id', v.id)
                            .attr('title', v.name);
                    })
                    $("#svgView").find("g[type='Meter']").tooltip({
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
            if ($scope.meterFlag){
                $http({
                    method : "POST",
                    url : "${ctx}/MeterDeviceLayout/getDeviceStatus.htm",
                    params : {
                        "meters": $scope.meterDids.join(",")
                    }
                }).success(function (result) {
                    if (result.key == 0){
                        if (SvgUtils.Meter){
                            $scope.flushMeter(result.data);
                        }
                    }
                });
            }
        };

        flushMeter = $scope.flushMeter = function (data) {
            SvgUtils.Meter.flushMeter(data, function($obj, v){
                if(commonStatus.contains(v.status)) {
                    $obj.show();
                } else {
                    $obj.hide();
                }
            });
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
            	var id = $scope.allDevice[deviceId];
            	switch (type){
	                case "Meter":
	                	$scope.showHistoryData_byRTMDeviceLogId($scope.powerStationId,id,deviceId,"1");
	                    break;
            	}	
            }
            
        };
        
      //双击按钮事件
		 $scope.showHistoryData_byRTMDeviceLogId = function (pstationid,deviceid,deviceSerialNnumber,deviceType) {
			var res = {};
			res.deviceSerialNnumber = deviceSerialNnumber;
			res.deviceId = deviceid;
			res.pstationid = pstationid;
			res.deviceTypeNow = deviceType;
			
			$scope.deviceTypeNow = deviceType;
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
	     }
      
		 /*查看设备运行数据*/ //单击按钮事件 关闭 "待加载链接地址"弹出页面
		 $scope.closeHistoryData_byRTMDeviceLogId=function(msg){
			$scope.deviceTypeNow = "-1";
		 }
		 //$scope.showModelDiv1="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp";
	     //$scope.showModelDiv2="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData2.jsp";
	     //$scope.showModelDiv3="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData3.jsp";
  
    });

    function isAllSelect() {
        $("#legendICO0 i:eq(0)").show();
        $("#legendICO0 i:eq(1)").hide();
        if ($("ul[name='selectDevStatusLegend'] i:gt(1):odd:visible").length == $("ul[name='selectDevStatusLegend'] i:gt(1):odd").length){
            $("#legendICO0 i:eq(0)").hide();
            $("#legendICO0 i:eq(1)").show();
        }
    }
    
    function selectDevStatusLegend(obj, v) {
        var _this = $(obj);
        var allFlag = true;
        if (v == -1){
            if (_this.find("i:eq(0)").is(":visible")){
                _this.parent("ul").find("i:even").hide();
                _this.parent("ul").find("i:odd").show();
                commonStatus = [0, 1, 2, 3];
                allFlag = false;
            }else {
                _this.parent("ul").find("i:even").show();
                _this.parent("ul").find("i:odd").hide();
                commonStatus = [];
                allFlag = true;
            }
            SvgUtils.Meter.selectMeterStatus(commonStatus);
            return;
        }

        if (_this.find("i:eq(0)").is(":visible")){
            _this.find("i:eq(0)").hide();
            _this.find("i:eq(1)").show();
            if(!commonStatus.contains(v)) {
                commonStatus.push(v);
            }
        }else {
            _this.find("i:eq(0)").show();
            _this.find("i:eq(1)").hide();
            commonStatus.removeByValue(v)
        }
        isAllSelect();
        SvgUtils.Meter.selectMeterStatus(commonStatus);
    }

</script>