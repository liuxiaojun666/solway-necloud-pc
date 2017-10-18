<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
	.tab{background:rgb(0,189,189);color:white;border-radius:5px;padding:5px 10px;font-size:15px;    margin: 10px 0;cursor:pointer;}
</style>
<div class="mete-con clearfix" ng-controller="troubleYearCtrl">
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/trouble/chartModel/timesModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/trouble/chartModel/faultTimeModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/trouble/chartModel/faultRateModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/trouble/chartModel/mtModel.jsp'" style="background:white;height:300px;margin-bottom:10px;"></div>
</div>

<script>
app.controller('troubleYearCtrl',function($scope, $http, $state, $stateParams) {
	
});

</script>
