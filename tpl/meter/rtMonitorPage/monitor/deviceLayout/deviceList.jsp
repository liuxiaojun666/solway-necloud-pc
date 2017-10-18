<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
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
<div class="app-content-full-map" ng-controller="meterDeviceLayoutCtrl" style="margin-top:50px;">
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
	<!-- <div ng-include="showModelDiv" ></div> -->
</div>
<div class="waterPlaceholder"></div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">
	var timer;
	app.controller('meterDeviceLayoutCtrl', function($scope, $timeout, $http, $state,$stateParams) {
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
		/* 点击，弹出层(类型为箱变)  */
		$scope.showBoxChangeData = function(id, serialnumber, pstationid) {

			$http({
				method : "POST",
				url : "${ctx}/BoxChange/selectByConditionMap.htm",
				params : {
					stid: pstationid,
					sn: serialnumber
				}
				}).success(function(result) {
					var msg={};
					msg.deviceSerialNnumber = serialnumber;
					msg.deviceId = result.id;
					msg.pstationid = pstationid;
					$scope.showHistoryData_byRTMDeviceLogId(pstationid,result.id,serialnumber,'3');
					
					/**$('#taskList_historyData2').on('shown.bs.modal', function(e) {
						$(window).trigger('resize');
					});
					bcfirstFlag = 0;
					$scope.$broadcast('deviceStation_parameter',msg ,2);
					$('#taskList_historyData2').modal({backdrop: 'static', keyboard: false});*/
				});
		
		}
		
		/* 点击，弹出层(类型为逆变器)  */
		$scope.showInformation = function(id,serialnumber,pstationid) {
			$http({
				method : "POST",
				url : "${ctx}/Inverter/selectByConditionMap.htm",
				params : {
					stid: pstationid,
					sn: serialnumber
				}
			}).success(function(result) {
				if(result){
					var msg={};
					msg.deviceSerialNnumber = serialnumber;
					msg.deviceId = result.id;
					msg.pstationid = pstationid;
					$scope.showHistoryData_byRTMDeviceLogId(pstationid,result.id,serialnumber,'2');
					/**$('#taskList_historyData3').on('shown.bs.modal', function(e) {
						$(window).trigger('resize');
					});
					invfirstFlag = 0;
					$scope.$broadcast('deviceStation_parameter',msg ,2);
					$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});*/
				}
				
			});
			
		};
		
		/* 点击，弹出层(类型为汇流箱)  */
		$scope.toJunctionBoxMonitor = function(id,serialnumber, pstationid) {
			
			$http({
				method : "POST",
				url : "${ctx}/JunctionBox/selectByConditionMap.htm",
				params : {
					stid: pstationid,
					sn: serialnumber
				}
				}).success(function(result) {
					if(result){
						var msg={};
						msg.deviceSerialNnumber = serialnumber;
						msg.deviceId = result.id;
						msg.pstationid = pstationid;
						
						$scope.showHistoryData_byRTMDeviceLogId(pstationid,result.id,serialnumber,'1');
						/**$('#taskList_historyData4').on('shown.bs.modal', function(e) {
							$(window).trigger('resize');
						});
						jbfirstFlag = 0;
						$scope.$broadcast('deviceStation_parameter',msg ,2);
						$('#taskList_historyData4').modal({backdrop: 'static', keyboard: false});*/
					}
					
				});
			
		}
		$scope.showDeviceLayout=function(flagDevice){
			if(flagDevice=='1'){
				$("#showDevice2").removeClass("navbar-active")
				$("#showDevice1").addClass("navbar-active")
				/* $("#boxChange-table").css("height", $(window).height() - 210);
				$("#boxChange-table").css("width", $("#deviceTabs").width()); */
				$scope.showDeviceLayoutDiv="${ctx}/tpl/meter/rtMonitorPage/monitor/deviceStation/deviceStationIndex.jsp"
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
		$scope.showDeviceLayout(1)
		/*跳转方法*/
		/* $scope.toboxChange=function(id){
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
		} */
		$scope.showStationMonitor1 = function(id) {
			$state.go("app.dashboard-v1", {
				stationId : id
			});
		}
		$scope.isDevice=0;
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
		$scope.goRTMonitor=function(){
			$state.go("app.dashboard-v1", {
				stationId: $scope.powerStationId
			});
		}
		/*故障总数 3.2*/
		$scope.getStationFault=function($scope, $http, stationid,quickSelect) {
			$("i[name=zuchuanLoading]").show();
			var nbq = new Array(),hlx = new Array(),xb = new Array();
			$(".necloud_nibianqi").attr("name",function(index,oldvalue){nbq.push(parseInt(oldvalue))});
			$(".necloud_huiliuxiang").attr("name",function(index,oldvalue){hlx.push(parseInt(oldvalue))});
			$(".necloud_xiangbian").attr("name",function(index,oldvalue){xb.push(parseInt(oldvalue))});
			$http({
				method : "POST",
				url : "${ctx}/RtmDeviceLayout/getStationFaultData.htm",
				params : {
					id : stationid,
					bids : xb,
					iids : nbq,
					jids : hlx,
					quickSelect : quickSelect
				}
			}).success(function(result) {
				$scope.stationFault = result;
				//重绘故障设备//
				reFlashDraggSVGDevCore(result,quickSelect);

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
			}, 5000);
		});
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timer);
			clearInterval(timer1);
		});
		timer1 = setInterval(function() {
			$scope.getstaDayData();
		}, 5000);
		
		
		//双击按钮事件
		 $scope.showHistoryData_byRTMDeviceLogId = function (pstationid,deviceid,deviceSerialNnumber,deviceType) {
			var res = {};
			res.deviceSerialNnumber = deviceSerialNnumber;
			res.deviceId = deviceid;
			res.pstationid = pstationid;
			res.defaultShowPage = '2';
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
		
		$scope.showModelDiv="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp";
		
		
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
