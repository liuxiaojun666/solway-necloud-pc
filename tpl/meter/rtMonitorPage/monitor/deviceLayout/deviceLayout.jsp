<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${ctx}/tpl/meter/rtMonitorPage/monitor/deviceLayout/css/draggSVGDevCore.css" rel="stylesheet">
<style>
	.loadingPage_bg > div {color: #fff !important;}
	#head-title{display: none;}
	.panel{background: transparent!important;border:transparent!important;}
	.app-aside-fixed .aside-wrap {background-color: #1c2b36;}
	.navbar-btn .fa {font-size: 18px;vertical-align: middle;}
	.app-content-full-map {background-color: transparent!important;}
</style>
<div class="app-content-full-map" ng-controller="meterDeviceLayoutCtrl" style="margin-top:50px;">
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
				</ul>
				<!-- / navbar right -->
			</div>
			<!-- 主体布局 -->
			<div class="col-xs-12" id="deviceContent" style="overflow: auto;padding:20px;">
			
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

				<div class="row-row" id="styleDiv">
					<p name="loading" style="margin-top: 100px;" class="text-center"><i class="fa fa-spinner fa-spin fa-2x"/></p>
					<p name="noDeviceData" style="margin-top: 100px; display : none" class="text-center">无设备数据</p>
					<div name="drawSvgHorizontalToggle" class="pull-right">
						<a class="btn btn-default btn-sm" ng-click="drawSvgHorizontalToggle()">视图切换</a>
					</div>
					<!-- 设备布局 S -->
					<div id="containment-wrapper">

					</div>
				</div>

			</div>
		</div>
		<!-- /column -->
	</div>
	<div ng-include="showModelDiv1" ></div>
	<div ng-include="showModelDiv2" ></div>
	<div ng-include="showModelDiv3" ></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script src="${ctx}/tpl/meter/rtMonitorPage/monitor/deviceLayout/js/draggSVGDevCore.js"></script>
<script type="text/javascript" src="${ctx}/theme/js/array.extend.js"></script>
<script type="text/javascript">

	var commonStatus = [0, 1, 2, 3];

	var deviceStatusData;
	var timer;
	app.controller('meterDeviceLayoutCtrl', function($scope, $timeout,$http, $state,$stateParams) {
		$scope.getCurrentDataName('00',0);
		$scope.$on('broadcastSwitchStation', function(event, data) {
			clearInterval(timer);
			$scope.commCount = 0;
			$scope.commnullCount = 0;
			$("#comm_interruptDev").hide();
			$("#comm_initDev").hide();
			$("#response_respStatus").hide();
			$("#response_respStatusnull").hide();
					
			$scope.currentDataName = data.dataName;
			$scope.powerStationId = data.dataId;
			$scope.parentId = data.dataId;
			$scope.getDeviceLayout($scope, $http, $scope.powerStationId);
		});

		$scope.$on('refreshViewDataForHead', function(event, data) {
			clearInterval(timer);
			$scope.layoutInitMethod();
			$scope.getDeviceLayout($scope, $http, $scope.powerStationId);
	    });

		$scope.showDeviceLayout=function(){
			$("#showDevice1").removeClass("navbar-active")
			$("#showDevice2").addClass("navbar-active")
			$('[name="selectDevStatusLegend"]').show()
			$('[name="selectDevStatusLegend_All"]').show()
		}
		$scope.showDeviceLayout()
		//判断电站状态
		$scope.commnullCount = 0;
		$scope.commCount = 0;
		$scope.getstaDayData=function(){
			$http({
				method : "POST",
				url : "./MobileRtmStationStatus/getRtmSingleStationComm.htm",
				timeout: 5000,
				params : {
					'dateString':new Date().Format("yyyy-MM-dd"),
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

		$scope.isDevice=0;
		$scope.deviceData;
		$scope.options;
		$scope.deviceDataFlag = true;
		/*设备信息 电能表*/
		$scope.getDeviceLayout=function($scope, $http, stationid) {

			$http({
				method : "POST",
				url : "${ctx}/MeterDeviceLayout/getDeviceLayout.htm",
				params : {
			 		'stid': stationid,
					'devicetype': '4'
				}
			}).success(function(result) {
				$("p[name=loading]").hide();
				if (result.code == 1) {
					$scope.deviceDataFlag = false;
					$("p[name=noDeviceData]").show();
					$("div[name=drawSvgHorizontalToggle]").hide();
					return;
				}
				$scope.deviceData = result.data;

				$scope.horizontalFlag = true;
				$scope.options = {
					templateUrl: 'tpl/meter/rtMonitorPage/monitor/deviceLayout/css/svg_template/Meter.svg',
					treeData: $scope.deviceData.treeData,
					maxDepth: $scope.deviceData.maxDepth,
					maxLevel: $scope.deviceData.maxLevel,
					virtualFlag: $scope.deviceData.virtualFlag,
					horizontalFlag: $scope.horizontalFlag
				}
				$scope.drawSvgHorizontalToggle();
			});
		}


		//获取设备静态数据信息
		$scope.getDeviceLayout($scope, $http, $scope.powerStationId);

		//横向|竖向显示
		$scope.drawSvgHorizontalToggle = function() {
			$('#containment-wrapper').drawSvg($scope.options);
			$scope.flushStatus();
			$scope.options.horizontalFlag = $scope.horizontalFlag = !$scope.horizontalFlag;
		};

		//根据状态着色
		$scope.flushStatus = function () {
			$http({
				method : "POST",
				url : "${ctx}/MeterDeviceLayout/getDeviceStatus.htm",
				params : {
					"meters": $scope.deviceData.deviceIds.join(",")
				}
			}).success(function (result) {
				if (result.key == 0){
					deviceStatusData = result.data;
					$('#containment-wrapper').drawSvgStatus({
						statusData: result.data
					});
					selectDrawSvgStatus();
				}
			});
		};
		var timerdlv = setInterval(function() {
			if ($scope.deviceDataFlag) {
				$scope.flushStatus();
			}
		}, 5000);

		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timerdlv);
		});

		//双击按钮事件
		 $scope.dblclick = function (pstationid,deviceid,deviceSerialNnumber,deviceType) {
			var res = {};
			res.deviceSerialNnumber = deviceSerialNnumber;
			res.deviceId = deviceid;
			res.pstationid = pstationid;
			res.deviceTypeNow = deviceType;
			$scope.deviceTypeNow = deviceType;
			if(deviceType == '3'){
				$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail3broad", res);
			}

	     }

	});
	function isAllSelect() {
		$("#legendICO0 i:eq(0)").show();
		$("#legendICO0 i:eq(1)").hide();
		if ($("ul[name='selectDevStatusLegend'] i:gt(1):odd:visible").length == $("ul[name='selectDevStatusLegend'] i:gt(1):odd").length){
			$("#legendICO0 i:eq(0)").hide();
			$("#legendICO0 i:eq(1)").show();
		}
	}
	//选择状态
	function selectDevStatusLegend(obj, v) {
		var _this = $(obj);
		if (v == -1){
			if (_this.find("i:eq(0)").is(":visible")){
				_this.parent("ul").find("i:even").hide();
				_this.parent("ul").find("i:odd").show();
				commonStatus = [0, 1, 2, 3];
			}else {
				_this.parent("ul").find("i:even").show();
				_this.parent("ul").find("i:odd").hide();
				commonStatus = [];
			}
			selectDrawSvgStatus();
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
		selectDrawSvgStatus();
	}
	//绘制显示状态设备
	function selectDrawSvgStatus(){
		$('#containment-wrapper').selectDrawSvgStatus({
			status: commonStatus,
			statusData: deviceStatusData
		});
	}

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
