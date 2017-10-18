<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.weatherlis {line-height: 45px;margin-bottom: 0;}
</style>
<div ng-controller="staTodayCtrl" class="col-sm-12 no-padder">
	<div class=""  id="distUserNav">
		<ul class="nav col-sm-12 no-padder nav-top mt10"  >
		  <li class="col-sm-12 no-padder text-center h3">
			 <!-- <a data-dismiss="modal" ng-click="closeStatModal()" ></a> -->
			 <span ng-bind="todayTimeForTitle"></span>气象
		  </li>
		</ul>
	</div>
	<div class="col-sm-12 no-padder" style="margin-top:20px;" id="powerList">
		<div class="col-sm-6 no-padder">
			<center class="col-sm-12 no-padder" style="background: rgb(233, 182, 35);height: 250px;">
				<div class="col-sm-12 font-h1 mt20" style="color: #283640;">
					<span ng-bind="week"></span>
					<span ng-bind="todayTime" class="m-l-xs m-r-xs"></span>
					<span ng-show="data.weaterTag=='A'">晴</span>
					<span ng-show="data.weaterTag=='B'">阴</span>
					<span ng-show="data.weaterTag=='C'">雨</span>
					<span ng-show="data.weaterTag=='D'">雪</span>
					<span ng-show="data.weaterTag=='E'">霾</span>
					<span ng-show="data.weaterTag=='X'">其他</span>
				</div>
				<div class="col-sm-12 mt30 pb30" style="line-height: 1;">
					<!-- 木有图标？ -->
					<i class="ico-family ico-sun" style="font-size:143px;" ng-show="data.weaterTag=='A'"></i>
					<i class="ico-family ico-yin" style="font-size:143px;" ng-show="data.weaterTag=='B'"></i>
					<i class="ico-family ico-rain" style="font-size:143px;" ng-show="data.weaterTag=='C'"></i>
					<i class="ico-family ico-snow" style="font-size:143px;" ng-show="data.weaterTag=='D'"></i>
					<i class="ico-family ico-smog" style="font-size:143px;" ng-show="data.weaterTag=='E'"></i>
					<i class="ico-family ico-weatherelse" style="font-size:143px;" ng-show="data.weaterTag=='X'"></i>
				</div>
			</center>
		</div>
		<div class="col-sm-6 text-md no-padder" style="height: 250px;">
			<div class="col-sm-12 pt10 pb10" style="background-color: rgba(40, 54, 64, .85);height: 65px;">
				<div class="col-sm-12" >
						<div class="col-sm-4 text-center">
							<span class="col-d text-1-4x" style="font-size: 15px;color: rgba(255, 255, 255, .5);">
							<span ng-class="{'hidden':!dailyJt}">实时</span>
							<span ng-class="{'hidden':dailyJt}">最大</span>功率</span>
						</div>
						<div class="col-sm-4 text-center">
							<span style="font-size: 15px;color: rgba(255, 255, 255, .5);" class="col-d text-1-4x">装机</span>
						</div>
						<div class="col-sm-4 text-center">
							<span style="font-size: 15px;color: rgba(255, 255, 255, .5);" class="col-d text-1-4x">出力</span>
						</div>
				</div>
				<div class="col-sm-12" style="color: #fff;">
						<div class="col-sm-4 text-center">
							<span class="text-1-4x"  ng-bind="data.power[0]">-</span>
							<span class="text-1-4x"  ng-bind="data.power[1]">kW</span>
						</div>
						<div class="col-sm-4 text-center">
							<span class="text-1-4x"  ng-bind="data.installedCapacity[0]">-</span>
							<span class="text-1-4x"  ng-bind="data.installedCapacity[1]">kW</span>
						</div>
						<div class="col-sm-4 text-center">
							<span class="text-1-4x"  ng-bind="data.outputPowerRatio">-</span>
							<span class="text-1-4x" >%</span>
						</div>
				</div>
			</div>
			<div class="clearfix" id="data" ng-if="data.weatherInstrument!=null" style="background-color: #f5f5f5;">
				<div class="col-sm-12" style="border-top: 1px solid #ccc;height: 120px;">
					<div class="col-sm-4 text-center wrapper-md">
						<span class="col-d black-2"><span ng-class="{'hidden':dailyJt}">平均</span>风速</span>
						<p class="weatherlis" ><span style="transform: rotate(-90deg);display: inline-block;"><i class="ico-family font-big">&#xe612;</i></span></p>
						<div class=""><span ng-bind="data.weatherInstrument.windSpeed">-</span> m/s</div>
					</div>
					<div class="col-sm-4 text-center wrapper-md">
						<span class="col-d black-2"><span ng-class="{'hidden':dailyJt}">平均</span>温度</span>
						<p class="weatherlis" ><i class="ico-family ico-temperature font-big"></i></p>
						<div class=""><span ng-bind="data.weatherInstrument.temperature">-</span> ℃</div>
					</div>
					<div class="col-sm-4 text-center wrapper-md">
						<span class="col-d black-2"><span ng-class="{'hidden':dailyJt}">平均</span>湿度</span>
						<p class="weatherlis" $("#data").show();$("#nodata").hide();><i class="ico-family ico-humidity font-big"></i></p>
						<div class=""><span ng-bind="data.weatherInstrument.humidity">-</span> %RH</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script>
	app.controller('staTodayCtrl',function($scope, $http, $state, $rootScope) {
		//标题的时间
		//$scope.mapTimeDay1 = getNextDay($scope.mapTimeDay);
		//$scope.mapTimeDay2 = getNextDay($scope.mapTimeDay1);
		//$scope.mapTimeDay3 = getNextDay($scope.mapTimeDay2);
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日");
		//$scope.dayTimeForTitle1=new Date($scope.mapTimeDay1).Format("yyyy年MM月dd日");
		//$scope.dayTimeForTitle2=new Date($scope.mapTimeDay2).Format("yyyy年MM月dd日");
		//$scope.dayTimeForTitle3=new Date($scope.mapTimeDay3).Format("yyyy年MM月dd日");

		$scope.stationListId = $scope.powerStationId
		//$scope.mapTimeDay   当前时间
		var dayNames = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
		weekdays = new Date($scope.mapTimeDay);
		$scope.week=dayNames[weekdays.getDay()];

		//打开周边
		// $scope.showRim=function(){
		// 	$rootScope.statDataPage2="./tpl/statistics/modal/statDayModal/showRim.html"
		// 	$scope.openStatModal2();
		// }
		//当前日
		$scope.todayTime=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日")
			$http({
				method : "POST",
				url : "${ctx}/MobileHmDeviceMonitor/getStationWeater.htm",
				params : {
					//'powerStationId':$scope.stationListId,
					'dateString':new Date($scope.mapTimeDay).Format("yyyy-MM-dd")
					}
				})
			.success(function (msg) {
				if(msg==null){
					return
				}
				$scope.data=msg;
			}).error(function(msg){
				return
			});
			/*
			$http({
				method : "POST",
				url : "${ctx}/MobileRtmDeviceMonitor/getStationWeater.htm",
				params : {
					'powerStationId':$scope.stationListId,
					'dateString':new Date($scope.mapTimeDay1).Format("yyyy-MM-dd")
					}
				})
			.success(function (msg) {
				if(msg==null){
					return
				}
				$scope.data1=msg;
			}).error(function(msg){
				return
			});

			$http({
				method : "POST",
				url : "${ctx}/MobileRtmDeviceMonitor/getStationWeater.htm",
				params : {
					'powerStationId':$scope.stationListId,
					'dateString':new Date($scope.mapTimeDay2).Format("yyyy-MM-dd")
					}
				})
			.success(function (msg) {
				if(msg==null){
					return
				}
				$scope.data2=msg;
			}).error(function(msg){
				return
			});

			$http({
				method : "POST",
				url : "${ctx}/MobileRtmDeviceMonitor/getStationWeater.htm",
				params : {
					'powerStationId':$scope.stationListId,
					'dateString':new Date($scope.mapTimeDay3).Format("yyyy-MM-dd")
					}
				})
			.success(function (msg) {
				if(msg==null){
					return
				}
				$scope.data3=msg;
			}).error(function(msg){
				return
			});
			*/
	});
	/*
	function getNextDay(d){
        d = new Date(d);
        d = +d + 1000*60*60*24;
        d = new Date(d);
        //return d;
        //格式化
        return d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
    }
    */
</script>

