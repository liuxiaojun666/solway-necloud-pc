<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/css/wp/dataAnalysisPage/ranking.css">
<div  ng-controller="wpRankingConCtrl" class="ranking-con">
	<div class="title-con">
		<span class="title">共{{prRank.length| dataNullFilter}}个电站</span>
	</div>
	<div class="clearfix">
		<div class="pull-left pr-con">
			<p class="item-header">PBA排名</p>
			<ul style="padding: 0;height: 410px;overflow: hidden;">
				<li class="clearfix" ng-repeat="item in prRank" ng-class="{'bar-first':($index==0),'bar-second':($index==1),'bar-third':($index==2)}">
					<div class="pull-left pr-left" ng-show="$index == 0 || $index == 1 || $index == 2">
						<span class="serial-con span">
							<img src="./theme/images/dataAnalysis/ranking1.png" ng-show="{{item.order == 1}}">
							<img src="./theme/images/dataAnalysis/ranking2.png" ng-show="{{item.order == 2}}">
							<img src="./theme/images/dataAnalysis/ranking3.png" ng-show="{{item.order == 3}}">
							<span class="serial-num span">{{item.order| dataNullFilter}}</span>
						</span>
						<span class="span">{{item.stationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order| dataNullFilter}}</span></span><span class="span">{{item.stationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-center">{{item.pba_score| dataNullFilter}}%</div>
					<div class="pull-right pr-right"><div class="progressBar"><span class="bar-content span" style="width:{{item.pba_score>100?100:item.pba_score}}%"></span></div></div>
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
						<span class="span">{{item.stationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order| dataNullFilter}}</span></span><span class="span">{{item.stationName| dataNullFilter}}</span>
					</div>
					<div class="pull-left pr-center">{{item.real_kwh[0]| dataNullFilter}}{{item.real_kwh[1]| dataNullFilter}}</div>
					<div class="pull-right pr-right"><div style="text-align:right;margin-right:24px;"><span>总装机</span><span>{{item.inst_kw[0]| dataNullFilter}}{{item.inst_kw[1]| dataNullFilter}}</span></div></div>
				</li>
			</ul>
			<div class="more"  ng-show="generatingPowerRank.length>10"><a ng-click="showMorePower();">更多></a></div>
		</div>
	</div>
	<div id="cover"></div>
	<div id="prMore" >
		<div class="window-center">
			<p class="item-header">PBA排名</p>
			<ul style="padding: 0;height: 410px;overflow: auto;">
				<li class="clearfix" ng-repeat="item in prRank" ng-class="{'bar-first':($index==0),'bar-second':($index==1),'bar-third':($index==2)}">
					<div class="pull-left pr-left" ng-show="$index == 0 || $index == 1 || $index == 2">
						<span class="serial-con span">
							<img src="./theme/images/dataAnalysis/ranking1.png" ng-show="{{item.order == 1}}">
							<img src="./theme/images/dataAnalysis/ranking2.png" ng-show="{{item.order == 2}}">
							<img src="./theme/images/dataAnalysis/ranking3.png" ng-show="{{item.order == 3}}">
							<span class="serial-num span">{{item.order}}</span>
						</span>
						<span class="span">{{item.stationName}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order}}</span></span><span class="span">{{item.stationName}}</span>
					</div>
					<div class="pull-left pr-center">{{item.pba_score}}%</div>
					<div class="pull-right pr-right"><div class="progressBar"><span class="bar-content span" style="width:{{item.pba_score>100?100:item.pba_score}}%"></span></div></div>
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
						<span class="span">{{item.stationName}}</span>
					</div>
					<div class="pull-left pr-left" ng-show="$index != 0 && $index != 1 && $index != 2">
						<span class="serial-con span"><span class="common-num span">{{item.order}}</span></span><span class="span">{{item.stationName}}</span>
					</div>
					<div class="pull-left pr-center">{{item.real_kwh[0]}}{{item.real_kwh[1]}}</div>
					<div class="pull-right pr-right"><div style="text-align:right;margin-right:24px;"><span>总装机</span><span>{{item.inst_kw[0]}}{{item.inst_kw[1]}}</span></div></div>
				</li>
			</ul>
		</div>
	</div>
</div>


<script>
app.controller('wpRankingConCtrl',function($scope, $http, $state, $stateParams) {
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	getData();
	
	$scope.$on('broadChangeDate', function(event, data) {
		if(data){
			$scope.dataType = data.dataType;
			$scope.dtime =data.dtime;
			getData();
		}
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		getData();
    });
	
	function getData(){
		var dtime,dateType;
		switch($scope.dataType){
			case "day" :dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
						dateType = 'd'
				break;
			case "month" : dtime = new Date($scope.dtime).Format("yyyy-MM");
							dateType = 'm'
				break;
			case "year" : dtime = new Date($scope.dtime).Format("yyyy");
							dateType = 'y'
				break;
			case "total" :dtime = '';
						dateType = 'a'
				break;
			default:
				dtime = new Date($scope.dtime).Format("yyyy-MM");
		}
		
		$http({
			method : "POST",
			url : "./WPOrder/getOrderInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			//console.log(msg);
			renderData(msg);
		}).error(function(msg){
		}); 
	}
	
	//填充数据
	function renderData(msg){
		$scope.prRank = msg.pbaList;
		$scope.generatingPowerRank = msg.generatingPowerList;
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
