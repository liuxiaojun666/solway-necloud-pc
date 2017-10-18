<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${ctx}/theme/css/customAnimate.css" rel="stylesheet">
<style>
	.loadingPage_bg > div {color: #fff !important;}
	#head-title{display: none;}
	.panel{background: transparent!important;border:transparent!important;}
	.app-aside-fixed .aside-wrap {background-color: #1c2b36;}
	.navbar-btn .fa {font-size: 18px;vertical-align: middle;}
	.app-content-full-map {background-color: transparent!important;}
</style>
<div class="app-content-full-map" ng-controller="WpDeviceLayoutCtrl" style="margin-top:50px;">
	<div class="hbox " >
		<!-- column -->
		<div class="col">
			<!-- 头部布局 -->
			<div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;line-height: 50px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
				<!-- <span ng-bind="pstationName" style="line-height: 50px;font-size: 16px;color: #333;margin-left: 30px;"></span>
				<span class="font-h3 blue-1 text-black" style="line-height: 50px;margin-left: 10px;">布局视图</span>-->
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

				<div class="row-row" style="padding: 20px;" id="svgView" ></div>
			</div>
		</div>
		<!-- /column -->
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script src="${ctx}/theme/js/wp/svgUtils.js"></script>
<script src="${ctx}/theme/js/wp/rtMonitorPage/wpDeviceLayoutIndex.js"></script>
<script type="text/javascript">
	var timer;
	$("#deviceContent").css('height',document.body.clientHeight-105)
	app.controller('WpDeviceLayoutCtrl', function($scope, $http, $state, $stateParams, $interval) {
		$scope.getCurrentDataName('00', 0);
		$scope.$on('broadcastSwitchStation', function (event, data) {
			$scope.currentDataName = data.dataName;
			$scope.powerStationId = data.dataId;
			$scope.parentId = data.dataId;
			$scope.initPageData();
		});

		$scope.$on('refreshViewDataForHead', function (event, data) {
			$scope.layoutInitMethod();
			$scope.initPageData();
			$scope.initDeviceData();
		});

		$scope.initPageData = function () {
			$http({
				method: "POST",
				url: "${ctx}/BLayoutConfig/queryBLayoutSvgByPStationId.htm",
				params: {
					"pstationId": $stateParams.stationId
				}
			}).success(function (res) {
				if (res.key == 0){
					$scope.svgData = res.data;
//					$("#svgView").html(res.data.svg);
					$("#svgView").html(res.data);
//					$("#canvas_background").attr("fill","#F0F3F4");
					SvgUtils.init();
					//$scope.setDeviceProperty();
				}
			});
		};
		var wts;
		$scope.initDeviceData = function () {
			$http({
				method: "POST",
				url: "${ctx}/WpDeviceLayout/getWindTurbineList.htm",
			}).success(function (res) {
				wts = res;
				$scope.getStationFault($scope, $http);
			});
		};
		$scope.initPageData();
		$scope.initDeviceData();
		
		//当前非正常设备的信息
		$scope.allDevStatus = new MapDef();
		
		/*故障总数 3.2*/
		$scope.getStationFault=function($scope, $http) {
			$.ajax({
				type : "post",
				url : "${ctx}/WpDeviceLayout/getWpDeviceStatus.htm",
				data:{
					wtidString : wts
				},
				success : function(result) {
					//重绘故障设备//
					//reFlashDraggSVGDevCore(result,quickSelect);
					if(result){
						 $scope.allDevStatus = refreshDraggSVGDevCore(result,$scope.allDevStatus);
					}
				},
				error : function(json) {
				}
			});
		}
		
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
		
		//$scope.getstaDayData();
		
		var isTimer = false;
		if(!isTimer){
			timer = setInterval(function() {
				$scope.getStationFault($scope, $http);
				//$scope.getstaDayData();
			}, 5000);
			isTimer = true;
		}
		
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timer);
		});


		var id = 2;

		$scope.devicePropertyTimer = 0;
		$scope.setDeviceProperty = function () {
			if($("#styleDiv svg").length == 0){
				return;
			}
			$interval.cancel($scope.devicePropertyTimer);
			//$("g[type='windTower']").attr("class", "svgRotate0-360");
			$("g[type='windTurbine']").find("g").attr("class", "svgRotate0-360");
		};
	});
</script>
