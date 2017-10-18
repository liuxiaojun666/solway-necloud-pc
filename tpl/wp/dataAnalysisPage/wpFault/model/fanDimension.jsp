<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.tab{background:rgb(0,189,189);color:white;border-radius:5px;padding:5px 10px;font-size:15px;    margin: 10px 0;cursor:pointer;}
</style>
<div class="mete-con clearfix" ng-controller="fanDimensionPageCtrl">
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/chartModel/fanModel.jsp'" style="background:white;margin-bottom:10px;"></div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/chartModel/barModel.jsp'" style="background:white;margin-bottom:10px;"></div>
</div>

<script>
app.controller('fanDimensionPageCtrl',function($scope, $http, $state, $stateParams) {
	
	var dtime,dateType;
	init();
	
	$scope.$on('broadChangeDate', function(event, data) {
		if(data){
			$scope.dataType = data.dataType;
			$scope.dtime =data.dtime;
		}
		init();
	});
	
	function init(){
		
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
		
		fanData();
		barData();
	}
	
	function fanData(){
		$http({
			method : "POST",
			url : "./WPFault/getStationFaultWindInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.$broadcast("fanModelData",msg.windInfoList);
		}).error(function(msg){
		}); 
	}
	
	function barData(){
		$http({
			method : "POST",
			url : "./WPFault/getStationFaultSubSysChart.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.$broadcast("barModelData",msg.subSyssList);
		}).error(function(msg){
		}); 
	}
});

</script>
