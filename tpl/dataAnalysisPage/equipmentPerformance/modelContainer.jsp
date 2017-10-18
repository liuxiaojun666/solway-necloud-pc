<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div  ng-controller="equipmentConCtrl" class="mete-con" style="overflow:auto;padding:0 10px;">
	<div ng-include="showModelDiv" ></div>
</div>
<script>
app.controller('equipmentConCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadChangeDate', function(event, data) {
		$scope.data = data;
		if(data){
			$scope.dataType = data.dataType;
			getModel()
		}
		
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		getModel()
    });
	
	$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/equipmentPerformance/model/month.jsp";
	
	function getModel(){
		/**switch($scope.dataType){
			case "month" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/equipmentPerformance/model/month.jsp";
				$scope.$broadcast('broadChangeDateToChildMonth',$scope.data);
				break;
			case "year" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/equipmentPerformance/model/year.jsp";
				$scope.$broadcast('broadChangeDateToChildYear',$scope.data);
				break;
			case "total" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/equipmentPerformance/model/total.jsp";
				break;
		}*/
		
		$scope.$broadcast('broadChangeDateToChildEP',$scope.data);
	}
	//getModel();
	
	
});

</script>
