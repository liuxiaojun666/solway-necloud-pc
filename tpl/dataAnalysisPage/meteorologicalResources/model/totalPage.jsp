<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mete-con" ng-controller="totalPageCtrl">
	<div class="graph" style="height:280px;">
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color: #e5cf0d"></i> <span
					class="col-9 m-r-xs text-1-1x">晴<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color:#b6a2de"></i> <span
					class="col-9 m-r-xs text-1-1x">阴<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color:#5ab1ef"></i> <span
					class="col-9 m-r-xs text-1-1x">雨<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color: #2ec7c9"></i> <span
					class="col-9 m-r-xs text-1-1x">雪<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color:#8d98b3"></i> <span
					class="col-9 m-r-xs text-1-1x">霾<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa  fa-circle" style="color:#ffb980"></i> <span
					class="col-9 m-r-xs text-1-1x">其他<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa  fa-minus" style="color:#f56669"></i> <span
					class="col-9 m-r-xs text-1-1x">晴天数<small></small></span> 
			</span>
		</div>
		<div ng-include="'${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/barChartUp.jsp'"></div>
	</div>
	<div class="clearfix" style="background:white;">
		<span class="font-h4 black-1">辐射总量</span>
		<span class="pull-right">
			<span class="m-r-xs"><i class="fa fa-circle m-r-xs sun_color" style="color:#ffc700"></i>辐射总量</span>
			<!-- <span class="m-r-xs"><i class="fa fa-minus m-r-xs yin_color" style="color:rgb(238,112,98)"></i>周边均值</span> -->
		</span>
		<div ng-include="'${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/barChartDown.jsp'"></div>
	</div>
</div>

<script>
app.controller('totalPageCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationId();
    });
	
	//给上部柱状图页面传值
	function broadcastBarChartUp(data){
		$scope.$broadcast('broadBarChartUpData',data);
	}
	//给下部柱状图页面传值
	function broadcastBarChartDown(data){
		$scope.$broadcast('broadBarChartDownData',data);
	};
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
		$scope.monthBarUpData();
		$scope.monthBarDownData();
		
	}
	
	//柱状图数据（上）
	$scope.monthBarUpData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getAccumulateStationPv.htm",
			params : {
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			broadcastBarChartUp(msg);
		}).error(function(msg){
		}); 
	}
	
	
	//柱状图数据（下）
	$scope.monthBarDownData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getAccumulateStationPv.htm",
			params : {
				'powerStationId': $scope.stid
			}
			})
		.success(function (msg) {
			broadcastBarChartDown(msg.grossRadiationList);
		}).error(function(msg){
		}); 
	}
	//初始化
	$scope.getStationId();
});

</script>
