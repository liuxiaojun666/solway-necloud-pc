<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ctx}/theme/css/wp/dataAnalysisPage/meteorologicalResources.css">
<style>
.modal-open {
    overflow-y: auto;
}
</style>
 <div class="hbox hbox-auto-xs hbox-auto-sm"  ng-controller="wpMeteResourcesCtrl">
	<div class="overview-title" >
		<div class="clearfix">
			<div class="pull-left">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
			</div>
			<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'"></div>
		</div>
	</div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/dayModel.jsp'" ng-show="showModel == 'day'"></div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/monthModel.jsp'" ng-show="showModel == 'month'"></div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/yearModel.jsp'" ng-show="showModel == 'year'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div> 
<script>
app.controller('wpMeteResourcesCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.getCurrentDataName('02',0);
	$scope.showTotal = false;//不显示累计
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	$scope.showModel = "month";
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
    });
	
	$scope.$on("emitChangeDate",function(e,data){
		getModel(data)
	});
	
	function getModel(data){
		$scope.dataType = data.dataType;
		switch(data.dataType){
			case "day" :
				$scope.dtime = new Date(data.dtime).Format("yyyy-MM-dd");
				$scope.$broadcast('dayDate',$scope.dtime);
				$scope.showModel = "day";
				break;
			case "month" :
				$scope.dtime = new Date(data.dtime).Format("yyyy-MM");
				$scope.$broadcast('monthDate',$scope.dtime);
				$scope.showModel = "month";
				break;
			case "year" :
				$scope.dtime = new Date(data.dtime).Format("yyyy");
				$scope.$broadcast('yearDate',$scope.dtime);
				$scope.showModel = "year";
				break;
		}
	}
});

</script>
