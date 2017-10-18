<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div ng-controller="DeviceLayoutCtrl">
<div data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/statisticalData.jsp'"></div>
	<%-- <div class="bg-light lter b-b wrapper" style="height: 70px; padding-top: 10px; padding-bottom: 10px">
		<div style="width: 72%; height: 50px; float: left;">
			<font style="font-size: 18px; color: #1e3e50; margin-left: 15px">设备分布图</font><br> 
			<font style="font-size: 14px; color: #1e3e50; margin-left: 15px">汇流箱</font>
			<font style="font-size: 14px; color: #676662;">故障数</font>
			<font style="font-size: 14px; color: #CB2823;" ng-bind="stationFault.junctionBoxFault"></font>&nbsp;&nbsp;
			<font style="font-size: 14px; color: #1e3e50;">逆变器</font> 
			<font style="font-size: 14px; color: #676662;">故障数</font>
			<font style="font-size: 14px; color: #CB2823;" ng-bind="stationFault.inverterFault"></font>&nbsp;&nbsp;
			<font style="font-size: 14px; color: #1e3e50;">箱变</font>
			<font style="font-size: 14px; color: #676662;">故障数</font>
			<font style="font-size: 14px; color: #CB2823;" ng-bind="stationFault.boxChangeFault"></font>
		</div>
		
		<div style="width: 28%; height: 50px; float: left; text-align: right;">
			<font style="font-size: 14px; color: #1e3e50;">
				<span ng-bind="stationFault.week"></span>
				<span class="m-l-xs">多云转晴</span>
			</font><br>
			<div data-ng-include="'${ctx}/tpl/rtMonitorPage/deviceLayout/weather.jsp'"></div>
			<a data-toggle="modal" data-target="#weatherModal" class="href-blur" ng-click="getWeatherData()"> 气象仪 </a>
		</div>
	</div> --%>
		<div class="wrapper-md no-border-xs col-sm-12">
			<tabset class="nav-tabs-alt nav-tabs-power2" justified="true" no>
				
				<!-- 故障发生开始 --> 
				<tab ng-repeat="vo in boxChanges ">
				<tab-heading>
					<span class="wrapper-sm white-1 a-cur-poi " ng-bind="vo.name" ng-click="getInverterList({{vo.id}},$index);"></span>
				</tab-heading>
				
				<div class="col-sm-6 text-center m-t"></div>
				
				<div class="col-sm-12 wrapper b-a panel border-none">
					<div ng-click="toboxChange({{vo.id}})">
					<font ng-bind="vo.name" class="font-h3 black-1"></font>&nbsp;&nbsp;
					<img id="boxChangeImg{{vo.id}}" alt="" src="${ctx}/theme/images/equipLayOut/boxChangeRun.png">
					<font class="font-h3 blue-3" ng-bind="vo.status"></font>&nbsp;&nbsp;&nbsp;&nbsp;
					<!-- <font class="font-h4 blue-3">查看箱变详情></font> -->
					</div>
				</div>
				<div ng-repeat="inv in vo.inverter" class="col-sm-60 wrapper b-a panel border-none" style="float: left; margin-right: 1%">
					<img alt="" src="${ctx}/theme/images/equipLayOut/inverterIcon.png">&nbsp;&nbsp;
					<font class="font-h3 black-1" ng-bind="inv.name"></font>&nbsp;&nbsp;
					<font class="font-h3 blue-3" ng-bind="inv.status"></font>&nbsp;&nbsp;&nbsp;&nbsp;
					<img alt="" src="${ctx}/theme/images/equipLayOut/junctionBoxIcon.png">&nbsp;&nbsp;<br>
					
					<div class="col-sm-12">
						<div ng-click="toInverterMonitor({{inv.id}})" style="float: left; width: 20%; text-align: center; margin-top: 10px; vertical-align: middle; height: 100%; cursor: pointer;">
							<img id="invImg{{inv.id}}" alt="" src="${ctx}/theme/images/equipLayOut/inverterRun.png" style="transform: scale(0.8);"> <br>
							<p ng-bind="inv.name" class="black-1 font-h4"></p>
							<p class="blue-4 font-h4" ng-bind="inv.status"></p>
						</div>
						
						<div style="float: left; width: 80%; margin-top: 10px">
							<div ng-repeat="jun in inv.junctionBox" style="width: 20%; float: left; text-align: center; margin: 10px 0px 10px 0px">
								<div ng-if="inv.junctionBox.length>10" ng-click="toJunctionBoxMonitor({{jun.id}})" style="cursor: pointer;">
									<img id="junImg{{jun.id}}" alt="" src="${ctx}/theme/images/equipLayOut/{{jun.statusPic}}" style="transform: scale(0.8);">
									<p ng-bind="jun.name" class="black-2 font-h6"></p>
								</div>
								<div ng-if="inv.junctionBox.length<=10" ng-click="toJunctionBoxMonitor({{jun.id}})" style="cursor: pointer;">
									<img id="junImg{{jun.id}}" alt="" src="${ctx}/theme/images/equipLayOut/{{jun.statusPic}}" style="transform: scale(0.8);">
									<p ng-bind="jun.name" class="black-2 font-h6"></p>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				</tab>
					<!-- 	<tab >	
						<tab-heading> 
							<span class="text-md wrapper-sm" >更多</span>
					 	</tab-heading>
					 	<div class="col-sm-6 text-center m-t">
					 	</div>
					</tab> -->
			</tabset>
		</div>
	</div>
<script type="text/javascript">
	// //箱变状态图片
	// var boxChangeStatusArray=new Array("boxChangeRun.png","boxChangeFault.png","boxChangeStop.png");
	// //逆变器状态图片
	// var inverterStatusArray=new Array("inverterRun.png","inverterStop.png","inverterStop.png");
	// //汇流箱状态图片（大）
	// var jbStatusBigArray=new Array("junctionBoxBigRun.png","junctionBoxBigFault.png","junctionBoxBigStop.png");
	// //汇流箱状态图片（小）
	// var jbStatusSmallArray=new Array("junctionBoxSmallRun.png","junctionBoxSmallFault.png","junctionBoxSmallStop.png");
	var timer1;
	app.controller('DeviceLayoutCtrl', function($scope, $http, $state,$stateParams) {
		//获取天气信息
		$scope.getWeatherData = function(flag) {
			
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
		$scope.toboxChange=function(id){
			$state.go("app.BoxChangeDetail", {
				InId : id
			});
		}
		if ($stateParams.stationId) {
			$scope.powerStationId = $stateParams.stationId;
			$scope.parentId = $stateParams.stationId;
			$scope.pstationName = $stateParams.pstationName;
			$scope.parentName = $stateParams.stationName;
			getStationFault($scope, $http, $scope.powerStationId);
			getDeviceLayout($scope, $http, $scope.powerStationId);
			getStatisticalData($http, $scope);
			$scope.getWeatherData();
			getRtData($http, $scope);
			//showGoBackFlag();
		} else {
			//hideGoBackFlag();
			$http.get("${ctx}/Login/getLoginUser.htm").success(
					function(result) {
						$scope.powerStationId = result.pstationid;
						$scope.parentId = result.stationId;
						$scope.pstationName = $stateParams.pstationName;
						$scope.parentName = $stateParams.stationName;
						getStationFault($scope, $http, $scope.powerStationId);
						getDeviceLayout($scope, $http, $scope.powerStationId);
						getStatisticalData($http, $scope);
						$scope.getWeatherData();
						getRtData($http, $scope);
					}).error(function(response) {
			});
		}
		
		$scope.getInverterList = function(bcId, index) {
			$scope.bcId = bcId;
			$scope.index = index;
			getDeviceLayoutTab($scope, $http, $scope.powerStationId);
		}
		
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timer1);
			//hideGoBackFlag();
		});
		timer1 = setInterval(function() {
			getDeviceLayoutTab($scope, $http, $scope.powerStationId);
			getStationFault($scope, $http, $scope.powerStationId);
			getRtData($http, $scope);
			$scope.getWeatherData();
		}, 5000);
		
		//TODO：优化启动顺序
		setTimeout(function() {
			$('.wrapper-sm')[0].click();
		}, 300);
	});
	
	//故障数
	function getStationFault($scope, $http, stationid) {
		$http({
			method : "POST",
			url : "${ctx}/DeviceLayout/getStationFaultData.htm",
			params : {
				id : stationid
			}
		}).success(function(result) {
			$scope.stationFault = result;
		});
	}
	//箱变信息
	function getDeviceLayout($scope, $http, stationid) {
		$http({
			method : "POST",
			url : "${ctx}/DeviceLayout/getDeviceLayout.htm",
			params : {
				id : stationid
			}
		}).success(function(result) {
			$scope.boxChanges = result.data;
			$scope.bcId = result.data[0].id;
			$scope.index = 0;
			getDeviceLayoutTab($scope, $http, stationid);
		});
	}
	//加载变箱下属设备
	function getDeviceLayoutTab($scope, $http, stationid) {
		//clearInterval(timer1);
		$http({
			method : "POST",
			url : "${ctx}/DeviceLayout/getOneBoxChangeDeviceLayout.htm",
			params : {
				id : stationid,
				bcId : $scope.bcId
			}
		}).success(function(result) {
			$scope.boxChanges[$scope.index].inverter = result.inverter;
		});
	}
	//装机统计数据
	function getStatisticalData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getPowerStationTotalData.htm",
						{
							params : {
								id : $scope.powerStationId
							}
						}).success(function(response) {
					$scope.totleData = response;
				}).error(function(response) {
	});
	}
	//功率等实时数据
	function getRtData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getPowerStationRtData.htm",
						{
							params : {
								id : $scope.powerStationId
							},timeout: 5000
						}).success(function(response) {
							if(response.respStatus==1){
								$scope.powerData = response;
								//$scope.stationLh = response.lh;
							}
				}).error(function(response) {
// 					if(response==null){
// 						promptObj('error','','请求累计发电量数据超时!');
// 					}else{
// 						promptObj('error','','请求累计发电量数据出错!');
// 					}
				});
	}
	//未来三天的气象数据
	function getNext3DayWeatherData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getNext3DayWeatherData.htm",
				{
					params : {
						id : $scope.powerStationId,
						cityName : $scope.cityName
					}
				}).success(function(response) {
					$scope.cityName = response.cityName;
					if(response.respStatus==1){
						$scope.next3DayWeatherData = response.weatherData;
					}
		}).error(function(response) {
		});
	}
</script>
