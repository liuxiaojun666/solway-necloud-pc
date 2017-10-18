<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div  ng-controller="modelContainerCtrl">
	<div ng-include="showModelDiv"></div>
</div>
<script>
app.controller('modelContainerCtrl',function($scope, $http, $state, $stateParams) {
	
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
			case "day" : $scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/meteResModel.jsp";
				$scope.$broadcast('broadChangeDateToChild',$scope.data);
				break;
			case "month" :$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/pvCalendar.jsp";
				$scope.$broadcast('broadChangeDateToChildMonth',$scope.data);
				break;
			case "year" :$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/yearPage.jsp";
				$scope.$broadcast('broadChangeDateToChildYear',$scope.data);
				break;
			case "total" :$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/meteorologicalResources/model/totalPage.jsp";
				break;
		}
	}
	getModel()
});

</script>
