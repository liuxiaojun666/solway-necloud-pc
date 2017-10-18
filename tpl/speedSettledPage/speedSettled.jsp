<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="${ctx}/speedSettled/css/common.css" rel="stylesheet" type="text/css">
<div class="hbox hbox-auto-xs hbox-auto-sm" ng-controller="speedSettledCtrl">
	<center class="col-sm-12">
		<h2 style="padding-bottom: 40px;">快速入驻</h2>
		<%--<input type="hidden" value="${sessionScope.LAST_UNFINISH_BPOWERSTATION_ID}" id="last_unfinish_bpowerstation_id"/>--%>
		<input type="hidden" value="" id="last_unfinish_bpowerstation_id"/>
	</center>
	<div class="col-sm-12">
		<div ui-view ></div>
	</div>
</div>
<script type="text/javascript">
app.controller('speedSettledCtrl', ['$http', '$rootScope',function($http, $rootScope){
	if($rootScope.last_unfinish_bpowerstation_id=="" || $rootScope.last_unfinish_bpowerstation_id==null){
	   	$http({
			method : "POST",
			url : "${ctx}/SpeedSettled/speedSettled-session.htm"
		}).success(function(result) {
			if(result!=""){
				$('#last_unfinish_bpowerstation_id').val(result);
			}else{
				$('#last_unfinish_bpowerstation_id').val("-1");
			}
		});
	}else{
		$('#last_unfinish_bpowerstation_id').val($rootScope.last_unfinish_bpowerstation_id);
	}
}]);
</script>