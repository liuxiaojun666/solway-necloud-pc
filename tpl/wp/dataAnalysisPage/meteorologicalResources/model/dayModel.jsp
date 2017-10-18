<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mete-con" ng-controller="mpMeteResModelCtrl">
	<div class="clearfix">
		<div class="pull-left square">平均风速 
			<span>{{dataUp.ws_avg|dataNullFilter}}</span><span>m/s</span>
		</div>
		<div class="pull-left square">最大风速
			<span>{{dataUp.ws_max|dataNullFilter}}</span>
			<span>m/s</span>
		</div>
		<div class="pull-left square">截尾平均风速
			<span>{{dataUp.cws_avg|dataNullFilter}}m/s</span>
		</div>
		<div class="pull-left square">有效平均风速
			<span>{{dataUp.ews_avg|dataNullFilter}}</span>
		</div>
		<div class="pull-left square">
			<span style="margin-right:10px;"><img src="./theme/images/dataAnalysis/wind.png"> <span>{{dataUp.density_avg|dataNullFilter}}kg/m³</span></span>
			<span style="margin-right:10px;"><img src="./theme/images/dataAnalysis/temperature.png"> <span>{{dataUp.ta_avg|dataNullFilter}} &#8451;</span></span>
			<span><img src="./theme/images/dataAnalysis/humidity.png"> <span>{{dataUp.h2o_avg|dataNullFilter}}%RH</span></span>
		</div>
	</div>
	<div class="graph clearfix">
		<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/lineChart.jsp'"></div>
	</div>
	<div class="radar clearfix">
		<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/radarDay.jsp'"></div>
		<%-- <div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/radar.jsp'"></div> --%>
	</div>
</div>

<script>
app.controller('mpMeteResModelCtrl',function($scope, $http) {
	$scope.$on('dayDate', function(event, data) {
		$scope.dtime = data;
		init();
	}); 
	
	var dataType;
	
	function init(){
		
		if($scope.dataType == 'day'){
			dataType = 'd'
		}
		dayDataUp();
		dayChartData();
		$scope.$broadcast("toPageRadarDay",dataType);
		//$scope.$broadcast("toPageRadar",dataType);
	}
	
	//数据（日）
	function dayDataUp(){
		$http({
			method : "POST",
			url : "./WPWeather/getStationWeatherWindSpeedInfo.htm",
			params : {
				'dtime':$scope.dtime,
				'model':dataType
			}
		})
		.success(function (msg) {
			$scope.dataUp = msg;
		}).error(function(msg){
		}); 
	}
	
	//曲线（日）
	function dayChartData(){
		$http({
			method : "POST",
			url : "./WPWeather/getStationWeatherWindSpeedChart.htm",
			params : {
				'dtime':$scope.dtime,
				'model':dataType
			}
		})
		.success(function (msg) {
			$scope.$broadcast('broadWpLineData',msg.windSpeedChartList);
		}).error(function(msg){
		}); 
	}
	
});

</script>
