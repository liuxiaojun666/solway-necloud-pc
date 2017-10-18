<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.black-bg{background:rgba(15,32,49,0.9);}
.white{color:white;}
.security-info-title{height: 10.45rem;line-height:10.45rem;}
.index-item{height: 2.78rem;line-height: 2.78rem;margin-bottom: 0.3rem;}
.index-item-name{width:70%;background:#0c8bb0;}
.index-item-name >img{margin:0 20px;}
.index-item-value{width:15%;background:#2a58ac;}
.index-item-value1{width:15%;background:#0c74b0}
.safety-index-list{margin: 0 17.2rem;padding-bottom: 3.85rem;}
</style>
<div ng-controller="dtSecurityInfoModelCtrl" class="black-bg white">
	<p class="security-info-title font24 text-center">北京公司年度安全管理指标完成情况</p>
	<div class="safety-index-list">
		<div class="clearfix index-item font20"  style="border: 1px solid rgba(100,212,249,0.2);    margin: 0;">
			<div class="pull-left index-item-name"></div>
			<div class="pull-right index-item-value text-center" style="border-left: 1px solid rgba(100,212,249,0.2);background: transparent;"><span>目标值</span></div>
			<div class="pull-right index-item-value1 text-center" style="border-left: 1px solid rgba(100,212,249,0.2);background: transparent;"><span>完成值</span></div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe1.png">两票合格率</div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.jobPassTarget"></span>%</div>
			<div class="pull-right index-item-value1 text-center" style="color:#fa2929;"><span ng-bind="firstPageData.jobPass"></span>%</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe2.png">两措计划完成率 </div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.twoFinishTarget"></span>%</div>
			<div class="pull-right index-item-value1 text-center"  style="color:#43ff18;"><span ng-bind="firstPageData.twoFinish"></span>%</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe3.png">负主要责任的人身事故</div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.accidentNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.accidentNum"></span>次</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe4.png">负主要责任的一般及以上施工机械和设备损坏事故 </div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.deviceAccidentNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.deviceAccidentNum"></span>次</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe5.png">负有主要责任造成的电网事故</div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.gridAccidentNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.gridAccidentNum"></span>次</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe6.png">负主要责任的火灾事故</div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.fireAccidentNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.fireAccidentNum"></span>次</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe7.png">负主要责任的一般及以上交通事故</div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.trafficAccidentNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.trafficAccidentNum"></span>次</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe8.png">负主要责任的公共卫生事件</div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.healthAccidentNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.healthAccidentNum"></span>次</div>
		</div>
		<div class="clearfix index-item font20">
			<div class="pull-left index-item-name text-left"><img src="theme/images/datang/monitoringMap/safe9.png">人员违纪次数 </div>
			<div class="pull-right index-item-value text-center"><span ng-bind="firstPageData.principleNumTarget"></span>次</div>
			<div class="pull-right index-item-value1 text-center" style="color:#43ff18;"><span ng-bind="firstPageData.principleNum"></span>次</div>
		</div>
	</div>
</div>
<script>
app.controller('dtSecurityInfoModelCtrl',function($scope, $http, $state, $stateParams) {
	

});
</script>
