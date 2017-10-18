<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div  ng-controller="powerGenConCtrl" class="mete-con">
	<div class="clearfix" style="margin:10px 0;">
		<div class="pull-left square">应发电量 
			<span>{{renderData.shdKwh[0]|dataNullFilter}}</span><span>{{renderData.shdKwh[1]|dataNullFilter}}</span>
		</div>
		<div class="pull-left square">实际发电量
			<span>{{renderData.realKwh[0]|dataNullFilter}}</span>
			<span>{{renderData.realKwh[1]|dataNullFilter}}</span>
		</div>
		<div class="pull-left square">上网电量
			<span>{{renderData.gridKwh[0]|dataNullFilter}}</span> 
			<span>{{renderData.gridKwh[1]|dataNullFilter}}</span> 
		</div>
	</div>
	<div ng-include="showModelDiv" style="background:white;"></div>
</div>
<script>
app.controller('powerGenConCtrl',function($scope, $http, $state, $stateParams) {
	
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
					$scope.data = [$scope.dtime,$scope.dataType];
					break;
				case "month" :
					$scope.dtime = new Date($scope.dtime).Format("yyyy-MM");
					$scope.data = [$scope.dtime,$scope.dataType];
					break;
				case "year" :
					$scope.dtime = new Date($scope.dtime).Format("yyyy");
					$scope.data = [$scope.dtime,$scope.dataType];
					break;
				case "total" :
					break;
			}
		}
		getModel()
		
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		getModel()
    });
	
	function getModel(){
		switch($scope.dataType){
			case "day" : 
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/powerGeneration/model/day.jsp";
				getTopDataDay();
				$scope.$broadcast('broadChangeDateToChild',$scope.data);
				break;
			case "month" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/powerGeneration/model/month.jsp";
				$scope.$broadcast('broadChangeDateToChildMonth',$scope.data);
				getTopDataMonth();
				break;
			case "year" :$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/powerGeneration/model/year.jsp";
				$scope.$broadcast('broadChangeDateToChildYear',$scope.data);
				getTopDataYear();
				break;
			case "total" :$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/powerGeneration/model/total.jsp";
				getTopDataTotal()
				break;
		}
	}
	getModel();
	
	//头部三框数据获取（日）
	function getTopDataDay(){
		$http.get("./BDTurbines/getStationSumDayKwhDay.htm",{
			params : {dateString: new Date($scope.dtime).Format("yyyy-MM-dd")}
		}).success(function(response) {
			$scope.renderData = response;
		}).error(function(response) {
		});
	}
	//头部三框数据获取（月）
	function getTopDataMonth(){
		$http.get("./BDTurbines/getStationSumMonthKwhMonth.htm",{
			params : {dateString: new Date($scope.dtime).Format("yyyy-MM")}
		}).success(function(response) {
			$scope.renderData = response;
		}).error(function(response) {
		});
	}
	//头部三框数据获取（年）
	function getTopDataYear(){
		$http.get("./BDTurbines/getStationSumYearKwhYear.htm",{
			params : {dateString: new Date($scope.dtime).Format("yyyy")}
		}).success(function(response) {
			$scope.renderData = response;
		}).error(function(response) {
		});
	}
	//头部三框数据获取（累计）
	function getTopDataTotal(){
		$http.get("./BDTurbines/getStationSumAllKwhAll.htm").success(function(response) {
			$scope.renderData = response;
		}).error(function(response) {
		});
	}
});

</script>
