<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.modal-open {
    overflow-y: auto;
}
</style>
<div ng-controller="datangMonitoringCtrl">
	<div class="dt-monitor-header col-sm-12 clearfix no-padder">
		<div class="col-sm-3 no-padder">
			<div ng-include="'${ctx}/tpl/datang/rtMonitorPage/model/commonHeader.jsp'"></div>
		</div>
		<div class="col-sm-6 no-padder capcity-state text-center clearfix">
			<span class="status status-standby">
				<p class="font12">总容量</p>
				<p class="font14 m-t-xs">60kWp</p>
			</span>
			<span class="status status-operation">
				<p class="font12">运行容量</p>
				<p class="font14 m-t-xs">20kWp</p>
			</span>
			<span class="status status-standby">
				<p class="font12">待机容量</p>
				<p class="font14 m-t-xs">20kWp</p>
			</span>
			<span class="status status-fault">
				<p class="font12">故障容量</p>
				<p class="font14 m-t-xs">20kWp</p>
			</span>
			<span class="status status-maintain">
				<p class="font12">维护容量</p>
				<p class="font14 m-t-xs">0kWp</p>
			</span>
			<span class="status status-offline">
				<p class="font12">离线容量</p>
				<p class="font14 m-t-xs">0kWp</p>
			</span>
		</div>
		<div class="col-sm-3 no-padder fault-message-con text-center">
			<span class="fault-message font12" style="line-height: 13px;vertical-align: super;">故障<br/>信息</span>
			<span>
				<p class="font12">汇流箱</p>
				<p class="font14 m-t-xs status-fault pointer" ng-click="goFaultAlarm()">20</p>
			</span>
			<span>
				<p class="font12">逆变器</p>
				<p class="font14 m-t-xs status-fault pointer" ng-click="goFaultAlarm()">10</p>
			</span>
			<span>
				<p class="font12">箱变</p>
				<p class="font14 m-t-xs status-fault pointer" ng-click="goFaultAlarm()">0</p>
			</span>
		</div>
	</div>
	<div class="col-sm-12 clearfix dt-monitor-main">
		<div  style="margin:10px auto;"><div class="clearfix" ng-include="'${ctx}/tpl/datang/rtMonitorPage/model/changeDate.jsp'"></div></div>
		<div class ="col-sm-12 white no-padder">
			<div class="col-sm-3 no-padding-l" >
				<div class="col-sm-12 no-padder bg-1 radius5 square-power pointer" ng-click="showRealPower('1')">
					<div class="m-t-10 p-l-20">
						<img src="theme/images/datang/monitorOverview/realtime-icon1.png" class="v-middle" /><span class="font14 m-l-10">实时功率</span>
					</div>
					<div class="text-center font24 ">
						<span class="">456.23</span>
						<small class="">kW</small>
					</div>
					<div class="col-sm-12 font12">
						<div class="col-sm-6">
							<div>出力比</div>
							<h4 class="font14 m-t-5">
								<span>5</span>%
							</h4>
						</div>
						<div class="col-sm-6" >
							<div>光照强度</div>
							<h4 class="font14 m-t-5">
								<span >53</span>
								<span >W/㎡</span>
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3" >
				<div class="col-sm-12 no-padder  bg-2 radius5 square-power pointer" ng-click="showRealPower('2')">
					<div class="m-t-10 p-l-20">
						<img src="theme/images/datang/monitorOverview/day-power.png" class="v-middle" /><span class="font14 m-l-10">日发电量</span>
					</div>
					<div class="text-center font24 ">
						<span class="">456.23</span>
						<small class="">度</small>
					</div>
					<div class="col-sm-12 font12">
						<div class="col-sm-6">
							<div>日辐射总量</div>
							<h4 class="font14 m-t-5">
								<span>5</span>kWh/㎡
							</h4>
						</div>
						<div class="col-sm-6" >
							<div>日发电小时数</div>
							<h4 class="font14 m-t-5">
								<span >53</span>
								<span >h</span>
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3" >
				<div class=" col-sm-12 no-padder  bg-3 radius5 square-power pointer" ng-click="showRealPower('3')">
					<div class="m-t-10 p-l-20">
						<img src="theme/images/datang/monitorOverview/month-power.png" class="v-middle" /><span class="font14 m-l-10">月累计发电量</span>
					</div>
					<div class="text-center font24 ">
						<span class="">456.23</span>
						<small class="">度</small>
					</div>
					<div class="col-sm-12 font12">
						<div class="col-sm-6">
							<div>月辐射总量</div>
							<h4 class="font14 m-t-5">
								<span>5</span>kWh/㎡
							</h4>
						</div>
						<div class="col-sm-6" >
							<div>月发电小时数</div>
							<h4 class="font14 m-t-5">
								<span >53</span>
								<span >h</span>
							</h4>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-3 no-padding-r" >
				<div class="col-sm-12 no-padder  bg-4 radius5 square-power pointer"  ng-click="showRealPower('4')">
					<div class="m-t-10 p-l-20">
						<img src="theme/images/datang/monitorOverview/year-power.png" class="v-middle" /><span class="font14 m-l-10">年累计发电量</span>
					</div>
					<div class="text-center font24 ">
						<span class="">456.23</span>
						<small class="">度</small>
					</div>
					<div class="col-sm-12 font12">
						<div class="col-sm-6">
							<div>年辐射总量</div>
							<h4 class="font14 m-t-5">
								<span>5</span>kWh/㎡
							</h4>
						</div>
						<div class="col-sm-6" >
							<div>年发电小时数</div>
							<h4 class="font14 m-t-5">
								<span>53</span>
								<span>h</span>
							</h4>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="box-change-list col-sm-12 no-padder clearfix" ng-hide="boxChangeDetail">	
			<div class="pull-left box-change-item font14 pointer"  ng-repeat="item in boxChangeList" ng-class="{'fault-bg':item.state == 1}" ng-click="singleClick()" ng-dblclick="doubleClick(item.did)">
				<div class="col-sm-12 no-padder clearfix">
					<div class="col-sm-5 no-padder clearfix">
						<img alt="" src="theme/images/datang/monitorOverview/box-change-icon.png">
					</div>
					<div class="col-sm-7 no-padder text-right clearfix">
						<p class="dark-green">{{item.name}}</p>
						<p class="m-t-5">{{item.acpCount}}</p> 
					</div>
				</div>
				<div class="col-sm-12 no-padder m-t-5 clearfix">
					<div class="col-sm-7 no-padder clearfix">
						<div class="progressBar"><span class="bar-content-red span" style="width:70%;position:relative;"><span  class="total-tip">10</span></span><span class="total-tip">18</span></div>
					</div>
					<div class="col-sm-5 no-padder text-right light-green clearfix font12 lineHeight14">逆变器</div>
				</div>
			</div>
		</div>
		<div class="box-change-detail col-sm-12 no-padder clearfix" ng-show="boxChangeDetail">
			<div><img src="theme/images/datang/monitorOverview/be-back.png" class="pointer" style="width:40px;" ng-click="showBoxChangeList()"><span style="margin-left: 15px;">01号箱变</span></div>
			<div class="junction-box-list col-sm-12 no-padder clearfix">
				<div class="junction-box-item col-sm-3 pointer" ng-repeat="junctionItem in junctionBoxList" >
					<div class="junction-box col-sm-12 clearfix font14 " ng-class="{'fault-junction-box':junctionItem.state == 1}">
						<div class="col-sm-6 no-padder">{{junctionItem.name}}</div>
						<!-- <div class="col-sm-6 no-padder text-right">137.2W</div> -->
					</div>
					<div class="inverter-list clearfix font12">
						<div class="pull-left inverter-item pointer" ng-repeat="inverterItem in junctionItem.inverterList" ng-class="{'fault-inverter':inverterItem.state == 1}" ng-click="dblclick(3002,2881,100,'2',1)">
							<p ng-class="{'dark-green':inverterItem.state == 0,'dark-red':inverterItem.state == 1}">{{inverterItem.name}}</p>
							<div class="col-sm-12 clearfix no-padder" style="margin: 7px 0;">
								<div class="col-sm-6 no-padder"><img src="theme/images/datang/monitorOverview/inverter-icon.png" ng-if="inverterItem.state == 0"><img src="theme/images/datang/monitorOverview/inverter-icon-fault.png" ng-if="inverterItem.state != 0"></div>
								<div class="col-sm-6 no-padder black-word">
									<p>{{inverterItem.acp|number:1}}w</p>
									<p>{{inverterItem.t|number:1}}℃</p>
								</div>
							</div>
							<div class="zuchuan-list">
								<span class="zuchuan-item" ng-repeat="zuchuanItem in inverterItem.cList" ng-class="{'fault-zuchuan':zuchuanItem.status == 3}" ng-show="zuchuanItem.statuFlag == 3"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div data-ng-include="'${ctx}/tpl/datang/rtMonitorPage/modal/powerModal.jsp'"></div>
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp'" ></div>
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData2.jsp'" ></div>
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData3.jsp'" ></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div class="waterPlaceholder"></div>
<script src="${ctx}/theme/js/datang/monitorPage/monitoring.js"type="text/javascript"></script>
<script>
function responseHeight(){
	/* var het = 380;
	$(".alert").each(function(){
		if($(this).is(":visible")){
			het = 450;
		}
	}); */
	
}
window.addEventListener("resize", function() {
	responseHeight();
});
responseHeight();
</script>
