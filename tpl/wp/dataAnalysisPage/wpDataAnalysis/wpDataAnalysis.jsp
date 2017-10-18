<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ctx}/theme/css/wp/dataAnalysisPage/dataAnalysis.css">
<style>

</style>
 <div class="hbox hbox-auto-xs hbox-auto-sm"  ng-controller="wpDataAnalysisCtrl">
	<div class="overview-title" >
		<div class="clearfix">
			<div class="pull-left">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
			</div>
			<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'"></div>
		</div>
	</div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpDataAnalysis/assetDataModel.jsp'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div> 
<script>
app.controller('wpDataAnalysisCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.getCurrentDataName('02',0);
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
    });
	
	$scope.$on("emitChangeDate",function(e,data){
		$scope.$broadcast('broadChangeDate',data);
	});
});

</script>
