<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${ctx}/tpl/rtMonitorPage/deviceLayout/css/draggSVGDevCore.css" rel="stylesheet">
<style>
	.loadingPage_bg > div {color: #fff !important;}
	#head-title{display: none;}
	.panel{background: transparent!important;border:transparent!important;}
	.app-aside-fixed .aside-wrap {background-color: #1c2b36;}
	.navbar-btn .fa {font-size: 18px;vertical-align: middle;}
	.app-content-full-map {background-color: transparent!important;}
</style>
<div class="app-content-full-map" ng-controller="DeviceLayoutCtrl" style="margin-top:50px;">
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
					<a id="legendICO1" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this,'normal')">
						<i class="fa fa-circle-o" style="display: none;color: #3fad22;"/><i class="fa fa-check-circle-o" style="color: #3fad22;" /> 正常
						<input type="hidden" value="" name="normal_deviceId_jqselect"/>
					</a>
					<a id="legendICO2" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this,'error')">
						<i class="fa fa-circle-o" style="display: none;color: #db412f;"/><i class="fa fa-check-circle-o" style="color: #db412f;" /> 故障
						<input type="hidden" value="" name="error_deviceId_jqselect"/>
					</a>
					<a id="legendICO3" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this,'alert')">
						<i class="fa fa-circle-o" style="display: none;color: #f90;"/><i class="fa fa-check-circle-o" style="color: #f90;" /> 报警
						<input type="hidden" value="" name="alert_deviceId_jqselect"/>
					</a>
					<a id="legendICO4" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this,'break')">
						<i class="fa fa-circle-o" style="display: none;color: #999;"/><i class="fa fa-check-circle-o" style="color: #999;" /> 中断
						<input type="hidden" value="" name="break_deviceId_jqselect"/>
					</a>
					<a id="legendICO5" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend(this,'shadow')">
						<i class="fa fa-circle" style="display: none;color: #ccc;"/><i class="fa fa-check-circle" style="color: #ccc;" /> 阴影遮挡
						<input type="hidden" value="" name="shadow_deviceId_jqselect"/>
					</a>
				</ul>
				<ul class="nav navbar-nav navbar-right m-r-xxl" name="selectDevStatusLegend_All">
					<i class="fa fa-hourglass-half" name="zuchuanLoading" style="display: none;"/>
					<a id="legendICO0" class="btn no-shadow navbar-btn" onclick="selectDevStatusLegend_All(this)">
						<i class="fa fa-circle-o" style="display: none;"/><i class="fa fa-check-circle" style="color: #333"/> 全选
						<input type="hidden" value="" name="all_deviceId_jqselect"/>
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
				
				<div class="row-row" style="padding: 20px;" id="styleDiv">
					 <div ng-include="showDeviceLayoutDiv" ></div>
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
<script src="${ctx}/tpl/rtMonitorPage/deviceLayout/js/draggSVGDevCore.js"></script>
<script src="${ctx}/tpl/rtMonitorPage/deviceLayout/js/deviceLayout.js"></script>
<script type="text/javascript">
	var timer;
	$("#deviceContent").css('height',document.body.clientHeight-105)
	app.controller('DeviceLayoutCtrl', function($scope, $timeout,$http, $state,$stateParams) {
		$scope.getCurrentDataName('00',0);
		$scope.$on('broadcastSwitchStation', function(event, data) {
			clearInterval(timer);
			$scope.commCount = 0;
			$scope.commnullCount = 0;
			$("#comm_interruptDev").hide();
			$("#comm_initDev").hide();
			$("#response_respStatus").hide();
			$("#response_respStatusnull").hide();
			$scope.abnormalDev = new Map();
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

		$scope.showDeviceLayout=function(flagDevice){
			if(flagDevice=='1'){
				$("#showDevice2").removeClass("navbar-active")
				$("#showDevice1").addClass("navbar-active");
				$scope.showDeviceLayoutDiv="${ctx}/tpl/rtMonitorPage/deviceStation/deviceStationIndex.jsp"
				$('[name="selectDevStatusLegend"]').hide()
				$('[name="selectDevStatusLegend_All"]').hide()
			}else{
				$("#showDevice1").removeClass("navbar-active")
				$("#showDevice2").addClass("navbar-active")
				$('[name="selectDevStatusLegend"]').show()
				$('[name="selectDevStatusLegend_All"]').show()
				$scope.showDeviceLayoutDiv="${ctx}/tpl/rtMonitorPage/deviceLayout/deviceLayoutContent.jsp"
			}
		}
		$scope.showDeviceLayout(2)
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
		/*跳转方法*/
		$scope.toboxChange=function(id){
			//$scope.showHistoryData_byRTMDeviceLogId(id);
			$state.go("app.BoxChangeDetail", {
				InId : id
			});
		}
		$scope.toInverterMonitor = function(id) {
			$state.go("app.inverterDetail", {
				InId : id
			});
		}
		$scope.toJunctionBoxMonitor = function(id) {
			$state.go("app.junctionBoxMonitor", {
				InId : id
			});
		}
		$scope.showStationMonitor1 = function(id) {
			$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
				stationId : id
			});
		}
		$scope.isDevice=0;
		var nbq;
		var xb;
		var hlx;
		/*设备信息 3.1*/
		$scope.getDeviceLayout=function($scope, $http, stationid) {
			$scope.boxChanges=null;
			$("p[name=nodevicedata]").hide();
			$("p[name=loading]").show();
			var d1 = new Date().getTime();
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
				nbq = result.invs;
				xb = result.bcs;
				hlx = result.sbs;
			});
		}
		$scope.goRTMonitor=function(){
			$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
				stationId : $scope.powerStationId
			});
		}
		/*故障总数 3.2*/
		$scope.getStationFault=function($scope, $http, stationid,quickSelect) {
			$("i[name=zuchuanLoading]").show();
			//var nbq = new Array(),hlx = new Array(),xb = new Array();
			//$(".necloud_nibianqi").attr("name",function(index,oldvalue){nbq.push(parseInt(oldvalue))});
			//$(".necloud_huiliuxiang").attr("name",function(index,oldvalue){hlx.push(parseInt(oldvalue))});
			//$(".necloud_xiangbian").attr("name",function(index,oldvalue){xb.push(parseInt(oldvalue))});
			var d1 = new Date().getTime();
			
			$.ajax({
				type : "post",
				url : "${ctx}/RtmDeviceLayout/getStationFaultData2.htm",
				data:{
					id : stationid,
					bidss : xb,
					iidss : nbq,
					jidss : hlx,
					quickSelect : quickSelect
					},
				success : function(result) {
					var d2 = new Date().getTime();
					$scope.stationFault = result;
					//重绘故障设备//
					//reFlashDraggSVGDevCore(result,quickSelect);
					 $scope.abnormalDev = reFlashDraggSVGDevCore2(result,quickSelect,$scope.abnormalDev);
					 selectDevStatusLegendForTask();
				},
				error : function(json) {
				}
			});
		}
		$scope.pstationName = $stateParams.pstationName;
		$scope.parentName = $stateParams.stationName;

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
		}
		$scope.layoutInitMethod();

		//获取设备静态数据信息
		$scope.getDeviceLayout($scope, $http, $scope.powerStationId);
		//当前非正常设备的信息
		$scope.abnormalDev = new Map();
		var isTimer = false;
		$scope.$on('ngRepeatFinished', function (ngRepeatFinishedEvent) {
			//渲染页面//
			initDraggSVGDevCore();
			$("p[name=loading]").hide();
			//当无设备显示无设备数据
			if($scope.isDevice == 0){
				$("p[name=nodevicedata]").show();
			}else{
				$("p[name=nodevicedata]").hide();
			}
			//获取设备实时故障信息
			$scope.getStationFault($scope, $http, $scope.powerStationId,false);
			timer = setInterval(function() {
				$scope.getStationFault($scope, $http, $scope.powerStationId,true);
				$scope.getstaDayData();
			}, 10000);
			isTimer = true;
		});
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timer);
		});

		//双击按钮事件
		 $scope.dblclick = function (pstationid,deviceid,deviceSerialNnumber,deviceType,hasJB) {
			var res = {};
			res.deviceSerialNnumber = deviceSerialNnumber;
			res.deviceId = deviceid;
			res.pstationid = pstationid;
			res.deviceTypeNow = deviceType;
			$scope.deviceTypeNow = deviceType;
			
			//测试-------------------------
			$scope.inverterType = hasJB;//点击逆变器，不同类型跳转不同样式页面（1->inverterDetailNew.jsp,2->inverterDetailNewType1.jsp）
			
			if(deviceType == '3'){
				$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});
				//$scope.$emit("showDeviceDetail3", res);
				$scope.$broadcast("showDeviceDetail3broad", res);
			}else if(deviceType == '2'){
				$('#taskList_historyData2').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail2broad", res);
				//$scope.$emit("showDeviceDetail2", res);
			}else if(deviceType == '1'){
				$('#taskList_historyData1').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail1broad", res);
				//$scope.$emit("showDeviceDetail1", res);
			}
			
			//$scope.showHistoryData_byRTMDeviceLogId(pstationid,deviceid,deviceSerialNnumber,deviceType);
	     }
		
		 /*查看设备运行数据*/ //单击按钮事件 关闭 "待加载链接地址"弹出页面
		 $scope.closeHistoryData_byRTMDeviceLogId=function(msg){
			$scope.deviceTypeNow = "-1";
		 }
		
		$scope.showDevInfoData=function(devType,devSN,thisobj){
			if(devType == 1){
				$http({
					method : "POST",
					url : "${ctx}/DeviceStation/getSingleRealDataBJunction.htm",
					params : {
						serialnumber : devSN
					}
				}).success(function(result) {
					
				});
			}
			
		}
		$scope.showModelDiv1="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp";
		$scope.showModelDiv2="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData2.jsp";
		$scope.showModelDiv3="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData3.jsp";
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
