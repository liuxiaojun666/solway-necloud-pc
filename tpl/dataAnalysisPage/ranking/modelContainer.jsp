<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/css/dataAnalysisPage/ranking.css">
<div  ng-controller="rankingConCtrl" class="ranking-con">
	<div class="title-con">
		<span class="title">共{{prRank.length| dataNullFilter}}个电站</span>
	</div>
	<div class="clearfix">
		<div class="pull-left pr-con">
			<p class="item-header">PR排名</p>
			<ul style="padding: 0;height: 410px;overflow: hidden;">
				<li class="clearfix" ng-repeat="item in prRank" ng-class="{'bar-first':($index==0),'bar-second':($index==1),'bar-third':($index==2)}">
					<div class="pull-left pr-left" ng-show="$index == 0 || $index == 1 || $index == 2">
						<span class="serial-con span">
							<img src="./theme/images/dataAnalysis/ranking1.png" ng-show="{{item.order == 1}}">
							<img src="./theme/images/dataAnalysis/ranking2.png" ng-show="{{item.order == 2}}">
							<img src="./theme/images/dataAnalysis/ranking3.png" ng-show="{{item.order == 3}}">
							<span class="serial-num span">{{item.order| dataNullFilter}}</span>
						</span>
						<span class="span">{{item.generatingStationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order| dataNullFilter}}</span></span><span class="span">{{item.generatingStationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-center">{{item.percen| dataNullFilter}}%</div>
					<div class="pull-right pr-right"><div class="progressBar"><span class="bar-content span" style="width:{{item.percen| dataNullFilter}}%"></span></div></div>
				</li>
			</ul>
			<div class="more" ng-show="prRank.length>10"><a ng-click="showMorePR();">更多></a></div>
		</div>
		<div class="pull-right power-con">
			<p class="item-header">发电量排名</p>
			<ul style="padding: 0;height: 410px;overflow: hidden;">
				<li class="clearfix" ng-repeat="item in generatingPowerRank" ng-class="{'bar-first':($index==0),'bar-second':($index==1),'bar-third':($index==2)}">
					<div class="pull-left pr-left" ng-show="$index == 0 || $index == 1 || $index == 2">
						<span class="serial-con span">
							<img src="./theme/images/dataAnalysis/ranking1.png" ng-show="{{item.order == 1}}">
							<img src="./theme/images/dataAnalysis/ranking2.png" ng-show="{{item.order == 2}}">
							<img src="./theme/images/dataAnalysis/ranking3.png" ng-show="{{item.order == 3}}">
							<span class="serial-num span">{{item.order| dataNullFilter}}</span>
						</span>
						<span class="span">{{item.generatingStationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order| dataNullFilter}}</span></span><span class="span">{{item.generatingStationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-center">{{item.generatingPower[0]| dataNullFilter}}{{item.generatingPower[1]| dataNullFilter}}</div>
					<div class="pull-right pr-right"><div style="text-align:right;margin-right:24px;"><span>总装机</span><span>{{item.installedCapacity[0]| dataNullFilter}}{{item.installedCapacity[1]| dataNullFilter}}</span></div></div>
				</li>
			</ul>
			<div class="more"  ng-show="generatingPowerRank.length>10"><a ng-click="showMorePower();">更多></a></div>
		</div>
	</div>
	<div id="cover"></div>
	<div id="prMore" >
		<div class="window-center">
			<p class="item-header">PR排名</p>
			<ul style="padding: 0;height: 410px;overflow: auto;">
				<li class="clearfix" ng-repeat="item in prRank" ng-class="{'bar-first':($index==0),'bar-second':($index==1),'bar-third':($index==2)}">
					<div class="pull-left pr-left" ng-show="$index == 0 || $index == 1 || $index == 2">
						<span class="serial-con span">
							<img src="./theme/images/dataAnalysis/ranking1.png" ng-show="{{item.order == 1}}">
							<img src="./theme/images/dataAnalysis/ranking2.png" ng-show="{{item.order == 2}}">
							<img src="./theme/images/dataAnalysis/ranking3.png" ng-show="{{item.order == 3}}">
							<span class="serial-num span">{{item.order}}</span>
						</span>
						<span class="span">{{item.generatingStationName}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order}}</span></span><span class="span">{{item.generatingStationName}}</span>
					</div>
					<div class="pull-left pr-center">{{item.percen}}%</div>
					<div class="pull-right pr-right"><div class="progressBar"><span class="bar-content span" style="width:{{item.percen}}%"></span></div></div>
				</li>
			</ul>
		</div>
	</div>
	<div id="powerMore">
		<div class="window-center">
			<p class="item-header">发电量排名</p>
			<ul style="padding: 0;height: 410px;overflow: auto;">
				<li class="clearfix" ng-repeat="item in generatingPowerRank" ng-class="{'bar-first':($index==0),'bar-second':($index==1),'bar-third':($index==2)}">
					<div class="pull-left pr-left" ng-show="$index == 0 || $index == 1 || $index == 2">
						<span class="serial-con span">
							<img src="./theme/images/dataAnalysis/ranking1.png" ng-show="{{item.order == 1}}">
							<img src="./theme/images/dataAnalysis/ranking2.png" ng-show="{{item.order == 2}}">
							<img src="./theme/images/dataAnalysis/ranking3.png" ng-show="{{item.order == 3}}">
							<span class="serial-num span">{{item.order}}</span>
						</span>
						<span class="span">{{item.generatingStationName}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order}}</span></span><span class="span">{{item.generatingStationName}}</span>
					</div>
					<div class="pull-left pr-center">{{item.generatingPower[0]}}{{item.generatingPower[1]}}</div>
					<div class="pull-right pr-right"><div style="text-align:right;margin-right:24px;"><span>总装机</span><span>{{item.installedCapacity[0]}}{{item.installedCapacity[1]}}</span></div></div>
				</li>
			</ul>
		</div>
	</div>
</div>


<script>
app.controller('rankingConCtrl',function($scope, $http, $state, $stateParams) {
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	$scope.data = [$scope.dtime,$scope.dataType];
	$scope.$on('broadChangeDate', function(event, data) {
		$scope.data = data;
		if(data){
			$scope.dataType = data.dataType;
			$scope.dtime =data.dtime;
			switch($scope.dataType){
				case "day" :
					$scope.dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
					break;
				case "month" :
					$scope.dtime = new Date($scope.dtime).Format("yyyy-MM");
					break;
				case "year" :
					$scope.dtime = new Date($scope.dtime).Format("yyyy");
					break;
				case "total" :
					break;
			}
		}
		$scope.getStationId()
		
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationId()
    });
	//填充数据
	function renderData(msg){
		$scope.prRank = msg.prRank;
		$scope.generatingPowerRank = msg.generatingPowerRank;
	}
	//获取电站id($scope.stid)
	$scope.getStationId = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
			getModel();
		}).error(function(msg){
			return
		});
	}
	
	$scope.getStationId();
	function getModel(){
		switch($scope.dataType){
			case "day" : 
				getDayData();
				break;
			case "month" :
				getMonthData();
				break;
			case "year" :
				getYearData();
				break;
			case "total" :
				getTotalData();
				break;
		}
	}
	
	//月数据
	function getMonthData(){
		$http.get("./MobileHmDeviceMonitor/getStationRank.htm",{
			params : {
				dateString: new Date($scope.dtime).Format("yyyy-MM"),
				dateType:'M'
			}
		}).success(function(msg) {
			renderData(msg)
		}).error(function(response) {
		});
	}
	
	//年数据
	function getYearData(){
		$http.get("./MobileHmDeviceMonitor/getStationRank.htm",{
			params : {
				dateString: new Date($scope.dtime).Format("yyyy"),
				dateType:'Y'
			}
		}).success(function(msg) {
			renderData(msg)
		}).error(function(response) {
		});
	}

	//累计数据
	function getTotalData(){
		$http.get("./MobileHmDeviceMonitor/getStationRank.htm",{
			params : {
				dateType:'A'
			}
		}).success(function(msg) {
			renderData(msg)
		}).error(function(response) {
		});
	}
	
	$scope.showMorePR = function(){
        $("#cover").show();
        $("#prMore").show();
	}
	$scope.showMorePower = function(){
		$("#cover").show();
        $("#powerMore").show();
	}
	$("#prMore").click(function(){
		$("#cover").hide();
        $("#prMore").hide();
	});
	$("#powerMore").click(function(){
		$("#cover").hide();
        $("#powerMore").hide();
	});
});

</script>
