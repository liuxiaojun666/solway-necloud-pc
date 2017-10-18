<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
  <!-- navbar -->
  <!-- <div data-ng-include=" 'tpl/blocks/header.jsp' " class="app-header navbar"> </div> -->
  <!-- / navbar -->
  <div class="hbox hbox-auto-xs hbox-auto-sm">
	<div class="col-sm-12" style="padding: 20px 20px 20px 25px;" ng-controller="analyzwHomeCtrl">
		<div class="row row-xs">
			<div ng-include="'${ctx}/tpl/reportPage/analyzeHome/analyData.jsp'"></div>
		</div>
		<div class="row row-xs m-t-md">
			<div ng-include="'${ctx}/tpl/reportPage/analyzeHome/analyBar.jsp'"></div>
		</div>
	</div>
</div>
<script>
app.controller('analyzwHomeCtrl',function($scope, $http, $state, $stateParams) {
	$scope.mapTimeMonth = new Date().Format("yyyy-MM-dd");
	$scope.stid = $stateParams.stid;
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
