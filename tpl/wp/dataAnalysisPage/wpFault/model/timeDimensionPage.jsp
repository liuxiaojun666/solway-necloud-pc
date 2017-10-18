<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
	.tab{background:rgb(0,189,189);color:white;border-radius:5px;padding:5px 10px;font-size:15px;    margin: 10px 0;cursor:pointer;}
</style>
<div class="mete-con clearfix" ng-controller="timeDimensionPageCtrl">
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/chartModel/timesModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/chartModel/faultRateModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/chartModel/mtModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
</div>

<script>
app.controller('timeDimensionPageCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadChangeDate', function(event, data) {
		if(data){
			$scope.dataType = data.dataType;
			$scope.dtime =data.dtime;
		}
		init();
	});
	
	function init(){
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
			url : "./WPFault/getStationFaultTimeInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.$broadcast("timesChild",msg.faultList);
			$scope.$broadcast("faultRateChild",msg.faultAvailList);
			$scope.$broadcast("mtChild",msg.faultMttrMtbfList);
			
		}).error(function(msg){
		}); 
	}
	
	init();
});

</script>
