<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.modal-open {
    overflow-y: auto;
}
</style>
 <div class="hbox hbox-auto-xs hbox-auto-sm"  ng-controller="rankingCtrl">
	<div class="overview-title" >
		<div class="clearfix">
			<div class="pull-left">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
			</div>
			<div ng-include="'${ctx}/tpl/dataAnalysisPage/model/analyChangeDate.jsp'"></div>
		</div>
	</div>
	<div ng-include="'${ctx}/tpl/dataAnalysisPage/ranking/modelContainer.jsp'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div> 
<script>
app.controller('rankingCtrl',function($scope, $http, $state, $stateParams) {
	$scope.showDay = false;
	
	$scope.getCurrentDataName('02',0);
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
    });
	
	$scope.$on("emitChangeDate",function(e,data){
		$scope.dataType = data.dataType;
		$scope.$broadcast('broadChangeDate',data);
		
	});
});
Date.prototype.Format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

</script>
