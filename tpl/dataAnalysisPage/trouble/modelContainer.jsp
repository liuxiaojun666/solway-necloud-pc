<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div  ng-controller="troubleConCtrl" style="overflow:auto;padding:0 10px;">
	<div ng-include="showModelDiv" ></div>
</div>
<script>
app.controller('troubleConCtrl',function($scope, $http, $state, $stateParams) {
	
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
	//默认显示月
	$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/trouble/model/month.jsp";
	
	function getModel(){
		/**switch($scope.dataType){
			case "month" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/trouble/model/month.jsp";
				break;
			case "year" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/trouble/model/year.jsp";
				break;
			case "total" :
				$scope.showModelDiv="${ctx}/tpl/dataAnalysisPage/trouble/model/total.jsp";
				break;
		}*/
		$scope.$broadcast('broadChangeDateToChildFault',$scope.data);
	}
	
});

</script>
