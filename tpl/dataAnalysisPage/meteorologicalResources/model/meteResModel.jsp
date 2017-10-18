<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mete-con" ng-controller="meteResModelCtrl">
	<div class="clearfix">
		<div class="pull-left square">辐射总量 
			<span>{{weatherInstrument.grossRadiationIntensity[0]|dataNullFilter}}</span><span>{{weatherInstrument.grossRadiationIntensity[1]}}</span>
		</div>
		<div class="pull-left square">日最大光照度 
			<span>{{data.maxLuminousIntensity[0]|dataNullFilter}}</span>
			<span>{{data.maxLuminousIntensity[1]|dataNullFilter}}</span>
		</div>
		<div class="pull-left square">日照小时
			<span>{{data.real_hours|dataNullFilter}}h</span>
		</div>
		<div class="pull-left square">日最大光照时刻
			<span>{{data.maxLuminousIntensityTime|dataNullFilter}}</span>
		</div>
		<div class="pull-left square">
			<span style="margin-right:10px;"><img src="./theme/images/dataAnalysis/wind.png"> <span>{{weatherInstrument.windSpeed|dataNullFilter}}m/s</span></span>
			<span style="margin-right:10px;"><img src="./theme/images/dataAnalysis/temperature.png"> <span>{{weatherInstrument.temperature|dataNullFilter}} &#8451;</span></span>
			<span><img src="./theme/images/dataAnalysis/humidity.png"> <span>{{weatherInstrument.humidity|dataNullFilter}}%RH</span></span>
		</div>
	</div>
	<div class="clearfix" style="background:white;    margin-top: 15px;">
		<div ng-include="'${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/lineChart.jsp'"></div>
	</div>
</div>

<script>
app.controller('meteResModelCtrl',function($scope, $http, $state, $stateParams) {
	//$scope.dtime = new Date().Format("yyyy-MM-dd");
	$scope.$on('broadChangeDateToChild', function(event, data) {
		if(data){
			$scope.dtime =data[0];
		}
		$scope.getStationId();
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationId();
    });
	
	//页面数据填充
	function renderData(data){
		$scope.weatherInstrument = data.weatherInstrument;
		$scope.data = data;
	}
	//给曲线图页面传值
	function broadcastLineChart(data){
		$scope.$broadcast('broadLineData',data);
	}
	//获取电站id($scope.stid)
	$scope.getStationId = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
			init();
		}).error(function(msg){
			return
		});
	}
	
	function init(){
		$scope.dayData();
		$scope.dayChartData();
		
	}
	
	//数据（日）
	$scope.dayData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getStationWeater.htm",
			params : {
				'dateString':$scope.dtime,
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			renderData(msg);
		}).error(function(msg){
		}); 
	}
	
	
	//曲线（日）
	$scope.dayChartData = function(){
		$http({
			method : "POST",
			url : "./BDWeather/getStationListDayWeatherDay.htm",
			params : {
				'dateString':$scope.dtime,
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			broadcastLineChart(msg);
		}).error(function(msg){
		}); 
	}
	//初始化
	$scope.getStationId();
});

</script>
