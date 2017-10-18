<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
	.tab{background:rgb(0,189,189);color:white;border-radius:5px;padding:5px 10px;font-size:15px;    margin: 10px 0;cursor:pointer;}
</style>
<div class="mete-con clearfix" ng-controller="troubleMonthCtrl">
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/equipmentPerformance/chartModel/topModel.jsp'" style="background:white;height:300px;margin:10px 0;"></div>
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/equipmentPerformance/chartModel/downModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
</div>

<script>
app.controller('troubleMonthCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationId(); 
    });
	
	//获取电站id($scope.stid)
	$scope.getStationId = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
			$scope.topData();
			$scope.downData();
		}).error(function(msg){
			return
		});
	}
	//台次数据获取，并传值
	$scope.topData = function(){
		$http.get("./BDDevicePerform/getStationsListCumulativePerformCumulative.htm",{
			params : {
				powerStationId:$scope.stid 
			}
		}).success(function(msg) {
			$scope.$broadcast("topChild",msg);
		}).error(function(response) {
		}); 
	}
	
	//故障台次数据获取，并传值
	$scope.downData = function(){
		$http.get("./BDDevicePerform/getStationsListCumulativeStrandCumulative.htm",{
			params : {
				//dateString: new Date($scope.dtime).Format("yyyy-MM"),
				powerStationId:$scope.stid 
			}
		}).success(function(msg) {
			$scope.$broadcast("downChild",msg);
		}).error(function(response) {
		}); 
	}
	
	//初始化
	$scope.getStationId(); 
});

</script>
