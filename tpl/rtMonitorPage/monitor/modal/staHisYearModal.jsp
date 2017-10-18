<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder"  ng-controller="staYCtrl" >
	<div class="h3 text-center">
		<span ng-bind="todayTimeForTitle"></span>发电电站列表
	</div>
	<div class="col-sm-12 no-padder rollDiv"style="margin-top:50px;" id="powerList">
		<center id="nodata" class="mt30 hidden">暂无数据</center>
		<div class="col-sm-12 no-padder" ng-repeat="one in data.devList">
			<div class="col-sm-12 wrapper" ng-bind="one.name|dataNullFilter"></div>
			<div class="col-sm-6 wrapper text-center">
				<span class="">发电量</span>
				<span class="" ng-bind="one.electricityQuantity[0]|dataNullFilter">-</span>
				<span class="" ng-bind="one.electricityQuantity[1]|dataNullFilter">kWh</span>
			</div>
			<div class="col-sm-6 wrapper text-center">
				<span class="">发电小时数</span>
				<span class="" ng-bind="one.electricityQuantityHours|dataNullFilter">-</span>
				<span class="" >h</span>
			</div>
		</div>
	</div>
</div>
<script>
	app.controller('staYCtrl',function($scope, $http, $state,$rootScope) {
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy");
		$scope.getStationChartGeneratingPower = function(){
			//请求电站的信息
			$http({
				method : "POST",
				url : "${ctx}/MobileHmDeviceMonitor/getStationChartGeneratingPower.htm",
				params : {
					'dateString': $scope.todayTimeForTitle,
					'idsType': "station_one",
					'dateType': "Y"
				}
			}).success(function (msg) {
				if(msg==null||msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden");
					return;
				}
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
			});
		};
		$scope.getStationChartGeneratingPower();
	});
</script>
