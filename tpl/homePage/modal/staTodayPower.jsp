<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<div class="col-sm-12 no-padder"  ng-controller="staTodayCtrl" >
	<div class=""  id="distUserNav">
		<ul class="nav col-sm-12 no-padder nav-top b-b "  >
          <li class="col-sm-12 no-padder text-center h3">
          	<a class="">
          		<span ng-bind="todayTimeForTitle"></span>日发电量
          	</a>
           </li>
        </ul>
	</div>
<div class="col-sm-12 no-padder rollDiv"style="height: 550px;;overflow:auto" id="powerList">
	<center id="nodata" class="m-t-md hidden">暂无数据</center>
	<div class="col-sm-12 font-h2 no-padder bg-writer m-t-sm " ng-repeat="one in data.devList">
		<div class="col-sm-4 wrapper wrapper-l-r-md font-big" ng-bind="one.name"></div>
		<div class="col-sm-4 wrapper wrapper-l-r-md text-center col-d b-r-5">
			<span class="">发电量</span>
			<span class="white font-big" ng-bind="one.dayGeneratingPower[0]">-</span>
			<span class="m-l-xs font-big" ng-bind="one.dayGeneratingPower[1]">kWh</span>
		</div>
		<div class="col-sm-4 wrapper wrapper-l-r-md col-d text-center">
			<span class="">日收入</span>
			<span class="white font-big" ng-bind="one.dayGeneratingPowerIncome[0]">-</span>
			<span class="m-l-xs font-big" ng-bind="one.dayGeneratingPowerIncome[1]">￥</span>
		</div>
	</div>
</div>
</div>
<script>
	app.controller('staTodayCtrl',function($scope, $http, $state,$rootScope) {
		
		
		$scope.todayTimeForTitle=new Date().Format("yyyy年MM月dd日")
		CommonPerson.Base.LoadingPic.PartShow('powerList');
		if($scope.stationListId.length>1){
			//请求组的信息
			$http({
				method : "POST",
				url : "${ctx}/MobileRtmDeviceMonitor/getDayChartGeneratingPower.htm",
				params : {
					'dateString':new Date().Format("yyyy/MM/dd/"),
					'ids':$scope.stationListId,
					'idsType':"station"
					}
				})
			.success(function (msg) {
				partHide('powerList')
				if(msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden")
					return
				}
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
				return
			});
		}else {
			//请求电站的信息
			$http({
				method : "POST",
				url :"${ctx}/MobileRtmDeviceMonitor/getDayChartGeneratingPower.htm",
				params : {
					'dateString':new Date().Format("yyyy/MM/dd/"),
					'ids':$scope.stationListId,
					'idsType':"station_one"
					}
				})
			.success(function (msg) {
				partHide('powerList')
				if(msg==null||msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden")
					return
				}
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
				return
			});
			
		}
	});
</script>
		