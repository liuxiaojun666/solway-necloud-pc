<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ctx}/theme/css/datang/odometer-theme-car.css">
<style>
.app-header-fixed {padding-top: 0px;}
html,body {color:white;}
.red{color:#ff1e1e;}
.grey{color:#adadad;}
.pointer{cursor:pointer;}
.modal-backdrop {
    background-color: #12283e;
    z-index: 10;
}
.stClassNoActive{ opacity : .3} 
</style>
<div ng-controller="dtNewMonitorCtrl" class="datang-index ">
	<div class="bg"></div>
	<div class="earth-bg"></div>
	<div class="bg-cover1"></div>
	<div class="bg-cover2"></div>
	<div class="hover-header-con"></div>
	<div class="systems-page">
		<div class="clearfix font18 close-line">
			<div class="pull-right text-center pointer" id="closeSystemBtn" style="width:6rem;">
				<span class="span-inline-block"><img src="theme/images/datang/monitoringMap/systemsPage/close-btn.png" style="margin-right:30px;width:1rem;"></span><span class="span-inline-block">关闭</span>
			</div>
		</div>
		<div class="system-link-list clearfix">
			<!-- 1 -->
			<div class="col-sm-12">
				<div class="col-sm-3 text-center" ng-click="openSubSystem(1,1)">
					<div class="sys-bg2 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-2.png"></div>
						<p class="font24 sys-tip">实时监测</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(1,2)">
					<div class="sys-bg6 system-item-bg " >
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-6.png"></div>
						<p class="font24 sys-tip">生产管理</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(1,3)">
					<div class="sys-bg11 system-item-bg " >
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-11.png"></div>
						<p class="font24 sys-tip">数据报表</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(1,4)">
					<div class="sys-bg3 system-item-bg " >
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-3.png"></div>
						<p class="font24 sys-tip">智能分析</p>
					</div>
				</div>
			</div>
			<!-- 2 -->
			<div class="col-sm-12">
				<div class="col-sm-3 text-center" ng-click="openSubSystem(2,1)">
					<div class="sys-bg1 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-1.png"></div>
						<p class="font24 sys-tip">行为可视</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(2,2)">
					<div class="sys-bg4 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-4.png"></div>
						<p class="font24 sys-tip">智慧工程</p>
					</div>
				</div>
			
				<div class="col-sm-3 text-center" ng-click="openSubSystem(2,3)">
					<div class="sys-bg5 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-5.png"></div>
						<p class="font24 sys-tip">办公管理</p>
					</div>
				</div>
				
				<div class="col-sm-3 text-center" ng-click="openSubSystem(2,4)">
					<div class="sys-bg7 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-7.png"></div>
						<p class="font24 sys-tip">经营管理</p>
					</div>
				</div>
			</div>
			<!-- 3 -->
			<div class="col-sm-12">
				<div class="col-sm-3 text-center" ng-click="openSubSystem(3,1)">
					<div class="sys-bg8 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-8.png"></div>
						<p class="font24 sys-tip">人员管理</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(3,2)">
					<div class="sys-bg9 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-9.png"></div>
						<p class="font24 sys-tip">档案系统</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(3,3)">
					<div class="sys-bg10 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-10.png"></div>
						<p class="font24 sys-tip">标准化系统</p>
					</div>
				</div>
				<div class="col-sm-3 text-center" ng-click="openSubSystem(3,4)">
					<div class="sys-bg12 system-item-bg ">
						<div class="hover-cover"></div>
						<div class="system-item-icon"><img src="theme/images/datang/monitoringMap/systemsPage/sys-icon-12.png"></div>
						<p class="font24 sys-tip">公司网站</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="page-content">
		<div style="z-index: 6;position: relative;padding: 0 3rem !important;">
			<div class="header">
				<hr/>
				<div class="trapezoid">
					<div class="small-trapezoid"></div>
					<!-- <h1><img src="theme/images/datang/monitoringMap/logo-new.png" class="company-logo"><span>智慧绿色能源管控平台</span></h1> -->
					<!-- 新 -->
					<div class="time-con">
						<span><img src="theme/images/datang/monitoringMap/clock-icon.png" style="width: 1.67rem;margin-right: 18px;vertical-align: top;"></span>
						<span ng-bind="nowTime | date:'yyyy-MM-dd HH:mm:ss'" class="font24"></span>
					</div>
					<!-- 新 -->
				</div>
			</div>
			<div class="clearfix font18" style="margin-top: -3.9rem;">
				<!-- <div class="pull-left">
					<span><img src="theme/images/datang/monitoringMap/clock-icon.png" style="width: 1.67rem;margin-right: 18px;vertical-align: top;"></span>
					<span ng-bind="nowTime | date:'yyyy-MM-dd HH:mm:ss'" class="font24"></span>
				</div> -->
				<!-- 新 -->
				<div class="pull-left" style="    margin-top: -0.8rem;">
					<h1 class="company-name"><img src="theme/images/datang/monitoringMap/logo-new.png" class="company-logo"><span>智慧绿色能源管控平台</span></h1>
				</div>
				<!-- 新 -->
				<div class="pull-right header-tab menu-con">
					<ul class="header">
						<li style="margin-left: 0;">
							<a ui-fullscreen="" class="" title="全屏模式"></a>
						</li>
						<li>
							<span data-toggle="modal" data-target="#switchPowerModal" style="margin-left:20px;font-size:1rem;cursor:pointer;"><i class="ico_spread" style="margin-right: 10px;"></i></span>
						</li>
						<li class="dropdown" dropdown>
							<a href class="dropdown-toggle clear" dropdown-toggle style="color:white;">
								<i class="ico_user"></i>
								<span class="" ng-bind="realName"  style="margin-left:8px;"></span>
								<b class="caret"></b>
							</a>
							<!-- dropdown -->
							<ul class="dropdown-menu animated fadeInRight w pull-right">
								<li class="toggletick" ng-repeat="role in rolelist" ng-class="{'active': currentRoleID==role.roleId}">
									<a ng-click="changeRole(role.roleId)" roleId="role.roleId">
										<i class="ico-family ico-active-right"></i>
										{{role.roleDisplayName}}
									</a>
								</li>
								<li class="divider"></li>
								<li>
									<a data-toggle="modal" data-target="#powerStationManageModal"><i class="ico-family ico-null">&#xe604;</i>电站组管理</a>
								</li>
								<li>
									<a ng-click="editUserData()"><i class="ico-family ico-null">&#xe604;</i>个人信息</a>
								</li>
								<li>
									<a ng-click="changePassword()"><i class="ico-family ico-null">&#xe604;</i>修改密码</a>
								</li>
								<li class="divider"></li>
								<li>
									<a  onclick="logOut();"><i class="ico-family ico-null">&#xe604;</i>退出系统</a>
								</li>
							</ul>
							<!-- / dropdown -->
						</li>
						
					</ul>
				</div>
			</div>
		</div>
		<!-- body地图 -->
		<div class="map-body">
	        <div class="width-center con-center">
                <div id="provinceChart" style="height:100%;"></div>
                <div class="wind-solar-tab-con font14">
                	<a ng-click="stationClassSelect('0' )"><span id="stClassId0" ><img src="theme/images/datang/monitoringMap/capacity-maintain.png" style="margin-right:15px;width: 14px;">光伏</span></a>
                	<a ng-click="stationClassSelect('1' )"><span id="stClassId1" ><img src="theme/images/datang/monitoringMap/wind-operation.png"  style="margin-right:15px;width: 14px;">风电</span></a>
                </div>
	        </div>
		</div>
		<!-- 左右框 -->
		<div class="clearfix no-padder" style="position: absolute;;bottom: 0;left: 3rem;right: 3rem;top: 9.1rem;">
			<div class="con-left pull-left">
                <div class="square-con clearfix" style="margin:0" ng-click="showSquareDetail('powerInfo')">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
	                    	<img src="theme/images/datang/monitoringMap/power-info.png" style="width:18px;"><span class="font20 square-item-title">电量信息</span>
	                    </div>
	                    <div class="col-sm-12 no-padder font16" style="padding: 0.83rem 1.7rem 0 !important;">
	                    	<div>日发电量&nbsp;&nbsp;&nbsp;kWh</div>
	                    	<div class="odometer big-green " id="odometer"></div>
	                    	<div class="col-sm-12 clearfix no-padder text-center">
	                    		<div class="col-sm-4 no-padder">
	                    			<p class="">月发电量</p>
	                    			<p class="light-blue font18"><span class="font30" ng-bind="MonitorData.monthGeneratingPower[0]|dataNullFilter"></span><span ng-bind="MonitorData.monthGeneratingPower[1]|dataNullFilter"></span></p>
	                    		</div>
	                    		<div class="col-sm-4 no-padder">
	                    			<p class="">年发电量</p>
	                    			<p class="light-blue font18"><span class="font30" ng-bind="MonitorData.yearGeneratingPower[0]|dataNullFilter"></span><span ng-bind="MonitorData.yearGeneratingPower[1]|dataNullFilter"></span></p>
	                    		</div>
	                    		<div class="col-sm-4 no-padder">
	                    			<p class="">累计电量</p>
	                    			<p class="light-blue font18"><span class="font30" ng-bind="MonitorData.accumulateGeneratingPower[0]|dataNullFilter"></span><span ng-bind="MonitorData.accumulateGeneratingPower[1]|dataNullFilter"></span></p>
	                    		</div>
	                    	</div>
	                    </div>
                    </div>
                </div>
                <div class="square-con clearfix"  ng-click="showSquareDetail('businessCircumstances')">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
	                    	<img src="theme/images/datang/monitoringMap/ico-operation.png" style="width:18px;"><span class="font20 square-item-title">经营情况</span>
	                    </div>
	                    <div class="col-sm-12 no-padder font16" style="padding: 0.8rem 1.4rem 0 !important;">
	                    	 <div id="stateOperPieChart" style="height:100px;"></div>
	                    </div>
                    </div>
                </div>
                <div class="square-con clearfix" style="padding-bottom: 7px;" ng-click="showSquareDetail('equRunning')">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
	                    	<img src="theme/images/datang/monitoringMap/ico-equip.png" style="width:18px;"><span class="font20 square-item-title">设备运行情况</span>
	                    </div>
	                    <div class="col-sm-12 no-padder font16" style="padding: 0 1.4rem 0 !important;">
	                    	 <div class="operation-line clearfix font16"  style="height: 2.2rem;border-bottom: 1px solid rgba(91,115,139,0.3);">
	                    	 	<span class="per25"></span><span class="per15 green">运行</span><span class="per15">待机</span><span class="per15 red">故障</span><span class="per15 yellow">维护</span><span class="per15 grey">离线</span>
	                    	 </div>
	                    	 <div class="operation-line-common clearfix font16" style="height: 2.9rem;border-bottom: 1px solid rgba(91,115,139,0.3);">
	                    	 	<span class="per25">风电<span class="font14">(台数)</span></span><span class="per15 green" ng-bind="deviceRunData['02'].run|dataNull0Filter"></span><span class="per15" ng-bind="deviceRunData['02'].wait|dataNull0Filter">5</span><span class="per15 red" ng-bind="deviceRunData['02'].fault|dataNull0Filter">3</span><span class="per15 yellow" ng-bind="deviceRunData['02'].maintain|dataNull0Filter">9</span><span class="per15 grey" ng-bind="deviceRunData['02'].comm|dataNull0Filter">1</span>
	                    	 </div>
	                    	 <div class="operation-line-common clearfix font16"  style="height: 2.9rem;">
	                    	 	<span class="per25">光伏<span class="font14">(台数)</span></span><span class="per15 green" ng-bind="deviceRunData['01'].run|dataNull0Filter"></span><span class="per15" ng-bind="deviceRunData['01'].wait|dataNull0Filter">5</span><span class="per15 red" ng-bind="deviceRunData['01'].fault|dataNull0Filter">3</span><span class="per15 yellow" ng-bind="deviceRunData['01'].maintain|dataNull0Filter">9</span><span class="per15 grey" ng-bind="deviceRunData['01'].comm|dataNull0Filter">1</span>
	                    	 </div>
	                    </div>
                    </div>
                </div>
            </div>
            <div class="width-right con-right pull-right clearfix">
            	<div class="no-border-con clearfix">
            		<div class="pull-left">
            			<div class="text-center"><div class="circle-border"><img src="theme/images/datang/monitoringMap/circle-rotate-blue.png" class="rotate-img-left "><span class="center-word light-blue font26">CO₂</span></div></div>
            			<p class="light-blue font20" style="margin-top: 7px;"><span ng-bind="MonitorData.co2[0]|dataNullFilter"></span><span ng-bind="MonitorData.co2[1]|dataNullFilter"></span></p>
            		</div>
            		<div class="pull-left">
            			<div class="text-center"><div class="circle-border" style="border:2px solid #25ff2a;"><img src="theme/images/datang/monitoringMap/circle-rotate-green.png" class="rotate-img" style=""><span class="center-word"><img src="theme/images/datang/monitoringMap/ico-tree.png" style="width:2.2rem;"></span></div></div>
            			<p class="green font20" style="margin-top: 7px;"><span ng-bind="MonitorData.plantedTree|dataNullFilter"></span>棵</p>
            		</div>
            	</div>
                <div class="square-con clearfix"  ng-click="showSquareDetail('securityInfo')">
                    <div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
                    	<img src="theme/images/datang/monitoringMap/ico-safe.png" style="width:18px;"><span class="font20 square-item-title">安全信息</span>
                    </div>
                    <div class="col-sm-12 no-padder font16" style="padding: 10px 2rem 0 !important;">
                    	<div class="col-sm-6 no-padder" >安全运行天数</div>
	                    <div class="col-sm-6 no-padder text-right dark-green" ><span ng-bind="firstPageData.safeDays"></span>天</div>
                    </div>
                    <div class="col-sm-12 no-padder font16" style="padding: 10px 2rem 0 !important;">
                    	<div class="col-sm-6 no-padder" >工作票总计</div>
	                    <div class="col-sm-6 no-padder text-right dark-green" ><span ng-bind="firstPageData.jobSum"></span></div>
                    </div>
                    <div class="col-sm-12 no-padder font16" style="padding: 10px 2rem 0 !important;">
                    	<div class="col-sm-6 no-padder" >已完成</div>
	                    <div class="col-sm-6 no-padder text-right dark-green" ><span ng-bind="firstPageData.finishJobSum"></span></div>
                    </div>
                </div>
               <div class="square-con clearfix"  ng-click="showSquareDetail('projectSchedule')">
                    <div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
                    	<img src="theme/images/datang/monitoringMap/ico-schedule.png" style="width:18px;" /><span class="font20 square-item-title">工程进度</span>
                    </div>
                    <div class="col-sm-12 no-padder font16" style="padding: 5px 2rem 0 !important;">
                    	<div class="col-sm-9 no-padder" ><span style="margin-right:45px;">在建数量</span><span ng-repeat="item in underBuildNum" class="underBuildItem"></span></div>
	                    <div class="col-sm-3 no-padder text-right orange" ><span ng-bind="firstPageData.buildSum"></span></div>
                    </div>
                    <div class="col-sm-12 no-padder font16" style="padding: 5px 2rem 0 !important;">
                    	<div class="col-sm-5 no-padder" style="margin-top: 1.7rem;">完成百分比</div>
	                    <div class="col-sm-7 no-padder" id="finishPercentPieChart" style="height:70px;"></div>
                    </div>
                </div>
                <div class="square-con clearfix"  ng-click="showSquareDetail('basicInfo')">
                    <div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
                    	<img src="theme/images/datang/monitoringMap/ico-base.png" style="width:18px;"><span class="font20 square-item-title">基本信息</span>
                    </div>
                    <div class="col-sm-12 no-padder " id="basicInfo" style="height:7.8rem;"></div>
                </div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<div class="map-footer">
		<div class="footer-trapezoid">
			<hr/>
			<div class="small-trapezoid"></div>
		</div>
	</div>
	<div data-ng-include="'${ctx}/tpl/datang/rtMonitorPage/modal/powerModal.jsp'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/powerStationManage.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>
<!-- <script type="text/javascript" src="${ctx}/vendor/echarts/china.js"></script> -->
<script type="text/javascript" src="${ctx}/theme/js/datang/odometer.js"></script>
<script type="text/javascript">
var timeTicket=null;
var provinceMapChart=null;
var stationMap=null;
var stationClassMap=null;
var basicInfoBarChart=null;
var rightPieChart=null;
var leftPieChart=null;
app.controller('dtNewMonitorCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval) {
	
	//鼠标悬浮0.5s页面头部，出现下拉页面
	var timer = null;
	$(".hover-header-con").hover(function(){
        timer=setTimeout(function(){
        	$(".systems-page").slideDown();
        },500);
    },
    function(){
        if(timer)  
            clearTimeout(timer);
    });  
		
	$("#closeSystemBtn").click(function(){
		$(".systems-page").slideUp();
	});
	
	$(".system-item-bg").mouseover(function(){
		$(".hover-cover").removeClass("active");
		$(this).find(".hover-cover").addClass("active");
	});
	
	$(".system-item-bg").mouseout(function(){
		$(".hover-cover").removeClass("active");
	});
	
	
	//弹出子系统  TODO
	$scope.openSubSystem = function(rank,col){
		if(rank == 1){
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeDataType.htm",
				params: {
					id: 3002,
					dataType: 0,
					stClass : '01',
					isGroup : '0'
				}
			}).success(function(res) {
				if(col == 1){
					$state.go("dtSecLevelHomePage");
				}else if(col == 2){
					$state.go("app.workTicketFill");
				}else if(col == 3){
					$state.go("app.DTReportDay");
				}else if(col == 4){
					$state.go("app.overview");
				}
			});
			
			    
		}else{
			var sb =  "subSystem"+ rank +"" +col;
			if($scope.firstPageData[sb]){
				window.open($scope.firstPageData[sb]);
			}
		}
	}
	
	//点击弹框
	$scope.showSquareDetail = function(type){
		if(type == "powerInfo"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/powerInfoDetail.jsp";
		}else if(type == "basicInfo"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/basicInfo.jsp";
		}else if(type == "equRunning"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/equRunning.jsp";
		}else if(type == "resourceInfo"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/resourceInfo.jsp";
		}else if(type == "securityInfo"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/securityInfo.jsp";
		}else if(type == "businessCircumstances"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/businessCircumstances.jsp";
		}else if(type == "projectSchedule"){
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/projectSchedule.jsp";
		}
		$('#powerIndexModal').modal();
	}
	
	//关闭弹出层
	$scope.hiddenModal=function(){
		$('#powerIndexModal').modal("hide");
	};
	//获取当前时间
	$interval(function(){
		$scope.nowTime = new Date();
	},1000);
	var dafdl = 1230;
	var dafdlnum = 0;
	//更改session中 数据
	$http({
		method : "POST",
		url : "${ctx}/UserAuthHandle/goHome.htm"
	}).success(function(res) {
		
		//实时数据
		($scope.getDayRDM = function() {
			$http({
				url : "${ctx}/MobileRtmDeviceMonitor/getRunTimeMonitor.htm",
				params: {
					
				}
			}).success(function(res) {
				$scope.MonitorData = res;
				//dafdlnum += 1;
				//$("#odometer").html(1000000 + (dafdlnum * 210) + dafdl);
				if(res.dayGeneratingPowerKWh || res.dayGeneratingPowerKWh === 0){
					$("#odometer").html(1000000 + res.dayGeneratingPowerKWh);
				}else{
					//$("#odometer").html(0);
				}
				if(!basicInfoBarChart){
					var runInst = [0,0,0];
					var faultInst = [0,0,0];
					if(res.classInstalledCapacity){
						var sumInst = 0;
						if(res.classInstalledCapacity["00"]){
							sumInst = res.classInstalledCapacity["00"][0];
						}
						var solarInst = 0;
						if(res.classInstalledCapacity["01"]){
							solarInst = res.classInstalledCapacity["01"][0];
						}
						var windInst = 0;
						if(res.classInstalledCapacity["02"]){
							windInst = res.classInstalledCapacity["02"][0];
						}
						runInst = [sumInst,windInst,solarInst]
					}
					var sumInst = [runInst[0]+faultInst[0],runInst[1]+faultInst[1],runInst[2]+faultInst[2]];
					//refreshBasicInfoBarChart(runInst,faultInst,sumInst);
					drawBasicInfoBarChart(runInst,faultInst,sumInst);
				}
				
			});
			

			$http({
				url : "${ctx}/MobileRtmDeviceMonitor/getAllDataForDT.htm",
				params: {
					
				}
			}).success(function(res) {
				$scope.firstPageData = res;
				if(!rightPieChart){
					drawPercentFinishPieChart($scope.firstPageData.buildRate);
					var underBuildNum = [];
					if($scope.firstPageData.buildSum){
						for(var i=0;i<$scope.firstPageData.buildSum;i++){
							var bn = {"name":"电站1"};
							underBuildNum.push(bn);
						}
						$scope.underBuildNum = underBuildNum;
					}
				}
				if(!leftPieChart){
					drawStateOperPieChart($scope.firstPageData.income,$scope.firstPageData.cost,$scope.firstPageData.profit);
				}
			});
			
			$http({
				url : "${ctx}/MobileRtmDeviceMonitor/getDeviceStatusForDT.htm",
			}).success(function(res) {
				$scope.deviceRunData = res;
			});
		})();
		
		//获取当前用户
		$http.get("${ctx}/Login/getLoginUser.htm", {
			timeout : 5000
		}).success(function(result) {
			$scope.loginName = result.userName;
			$scope.userId = result.userId;
			if(result.realName){
				$scope.realName = result.realName;
			}else{
				$scope.realName = result.userName;
			}
			if ($stateParams.comId) {
				$scope.selectCompanyId = $stateParams.comId;
				$scope.companyId = $stateParams.comId;
				if ($stateParams.comName != result.companyName) {
					$scope.selectCompanyName = $stateParams.comName;
				}
			} else {
				$scope.selectCompanyId = result.companyid;
				$scope.companyId = result.companyid;
			}
			$scope.companyName = result.companyName;
			if (result.dataScope == 4) {
				getAllCustomer($http, $scope);
			}
			//drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
		})
	});
	
	$scope.$on('$stateChangeStart', function(event) {
		$('.modal-backdrop').css("display","none");
		clearInterval(timer2);
		clearInterval(timeTicket);
	})
	
	//获取角色
	$http({
		method : "POST",
		url : "${ctx}/UserAuthHandle/getRoleListForPC.htm"
	}).success(function(res) {
		$scope.rolelist = res.rolelist;	//用户列表
		$scope.currentRoleID = res.currentRole;//当前用户的ID‘
		$scope.roleType = res.roleType;//当前角色类型
		var currentRoleNum = getArrAtrNum($scope.rolelist, 'roleId', $scope.currentRoleID);
		$scope.currentRoleName = $scope.rolelist[currentRoleNum].roleDisplayName;//当前角色名
		
		//$scope.$emit('CtrlHeaderChange',[$scope.currentRoleID]);
	});
	
	//切换角色,默认跳到各角色的首页
	$scope.changeRole = function (Id) {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/changeRoleNew.htm",
			params: {
				roleId: Id	//用户要切换的ID
			}
		}).success(function(response) {
			
			$scope.roleType = response.roleType;
			//角色
			$scope.currentRoleID = Id;//当前角色Id
			var currentRoleNum = getArrAtrNum($scope.rolelist, 'roleId', $scope.currentRoleID);
			$scope.currentRoleName = $scope.rolelist[currentRoleNum].roleDisplayName;//当前角色名

			var res = {};
			res.currCompanyName = response.comName;
			res.currCompanyLogo = response.comLogo;
			$scope.$emit("chCompanyInfo", res);
			
			if (response.roleType ==3 || response.roleType==99) {//集团管理员,系统管理员
				var uisref = getArrRealVal(response.rightlist, 'uisref');//获取第一个uisref不为空的值
				/**$scope.isRootRoleType = '0';
				$state.go(uisref, {
					RoleId: $scope.currentRoleID
				},{reload: true});*/
				window.location.href="${ctx}/index.jsp";
			} else {//非集团系统角色
				window.location.href="${ctx}/index.jsp";
			};
		});
	};
	
	timer2 = setInterval(function() {
		$scope.$apply($scope.getDayRDM);
		//$scope.$apply($scope.refreshMap);
	}, 5000);
	
	$scope.selectCompanyName = '全部';
	
	//var provinceList = ["河北","河南"];
	drawMap();
	//画省的地图
	function drawMap() {
		provinceMapChart = echarts.init(document.getElementById('provinceChart'));
		$.get('vendor/echarts/datangMap.json', function (chinaJson) {
		    echarts.registerMap('datangMap', chinaJson);
		    window.addEventListener("resize", function() {
		    	provinceMapChart.resize();
			});
		    var option = {
					tooltip : {
						show: false,
						trigger: 'item',
						formatter: '{b}'
					},
					grid : {
						x : '5px',
						x2 : '5px',
						y : "10px",
						y2 : "5px"
					},
					legend:{
						show:false,
						data:["地面光伏" , "分布式光伏","户用光伏","光伏在建","光伏计划","风电","风电在建","风电计划"]
					},
					geo: {
						map: 'datangMap',
						roam: true,
						zoom:0.9,
						label: {
						    normal: {
						        show: true,
						        textStyle: {
						            color: "white",//省份颜色,
						           	borderColor: 'grey'
						        }
						    },
						    emphasis: {
						    	show: true,
						        textStyle: {
						            color: "white",//省份颜色,
						        }
			                }
						},
						itemStyle: {
			                normal: {
			                    areaColor: 'rgba(21,51,86,0.7)',
			                    borderWidth:1.2,
			                    borderColor: 'rgba(0,255,255,0.7)'
			                },
			                emphasis: {
			                    areaColor: 'rgba(75,241,241,0.65)'
			                }
			            },
					},
					series : [
						{
						    name: '地面光伏',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[
						        //{name: '北京',value: Math.round(Math.random()*1000)}
						        
						    ]
						},
						{
						    name: '分布式光伏',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						},
						{
						    name: '户用光伏',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						},
						{
						    name: '光伏在建',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						},
						{
						    name: '光伏计划',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						},
						{
						    name: '风电',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						},
						{
						    name: '风电在建',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						},
						{
						    name: '风电计划',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 20,
						    data:[]
						}
					]
				};
				provinceMapChart.setOption(option,true);
				
				refreshMap();

				// 为echarts对象加载数据
				if(!timeTicket){
					timeTicket = setInterval(function (){
						refreshMap();
					},5000);
				}
				
				/**provinceMapChart.on('click', function(param) {
					if (stationMap.get(param.name) != null) {//点击电站显示弹出层
						clickMapArea(param, stationMap.get(param.name));
						
					} else {
					}
				});*/
				
				provinceMapChart.on('mouseover', function(param) {
					if (stationMap.get(param.name) != null) {//点击电站显示弹出层
						clickMapArea(param, stationMap.get(param.name));
						
					} else {
					}
				});
		});
	}
	var buildSTList= null;
	function refreshMap(){
		$.ajax({
			type : "post",
			url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew2.htm",
			//async : false,
			data : {'buildSTList':buildSTList},
			success : function(result) {
					stationMap = new Map();
					stationClassMap = new Map();
					var op = provinceMapChart.getOption();
					if(result){
						$("#normalStNum").html(result.normalNum);
						$("#faultStNum").html(result.faultNum);
						$("#alarmStNum").html(result.warnNum);
						$("#breakStNum").html(result.breakNum);
						buildSTList = result.buildSTList;
						if(result.data && result.data.length ){
							for (var i = 0; i < result.data.length; i++) {
								var resdata = result.data[i].data;
								if (resdata != null && resdata.length > 0) {
									for (var j = 0; j < resdata.length; j++) {
										var pst = resdata[j];
										stationMap.put(pst.name, pst.id);
										stationClassMap.put(pst.id, {'stClass':pst.stClass,'stStatus':pst.stStatus});
									}
								}
								
								var resName = result.data[i].name;
								if(resName =="地面"){
									op.series[0].data = formatMapData(result.data[i],"1");
								}else if(resName =="分布"){
									op.series[1].data = formatMapData(result.data[i],"2");
								}else if(resName =="户用"){
									op.series[2].data = formatMapData(result.data[i],"3");
								}else if(resName =="光伏在建"){
									op.series[3].data = formatMapData(result.data[i],"4");
								}else if(resName =="光伏计划"){
									op.series[4].data = formatMapData(result.data[i],"5");
								}else if(resName =="风电"){
									op.series[5].data = formatMapData(result.data[i],"6");
								}else if(resName =="风电在建"){
									op.series[6].data = formatMapData(result.data[i],"7");
								}else if(resName =="风电计划"){
									op.series[7].data = formatMapData(result.data[i],"8");
								}
								
							}
							
						}
					}
					provinceMapChart.setOption(op,true);
			}
		
		});
		//return option;
	};
	//左边框的饼图
	function drawStateOperPieChart(income,cost,profit) {
		leftPieChart = echarts.init(document.getElementById('stateOperPieChart'));
		window.addEventListener("resize", function() {
			leftPieChart.resize();
		});
		var option = {
			    tooltip : {
			        trigger: 'item',
			        formatter: "{b} ({d}%)"
			    },
			    legend: {
			        orient : 'vertical',
			        x : 'left',
			        show:false,
			        data:['利润','收入','成本']
			    },
			    calculable : true,
			    series : [
			        {
			            name:'',
			            type:'pie',
			            radius : '80%',
			            center: ['50%', '60%'],
			            data:[
			                {value:profit, name:'利润:'+profit+'元'},
			                {value:income, name:'收入:'+income+'元'},
			                {value:cost, name:'成本:'+cost+'元'}
			            ]
			        }
			    ],
			    label:{
			    	normal:{
			    		textStyle:{
			    			color:'white'
			    		}
			    	}
			    },
			    color: ['#fd7374','#4cddef','#f6e170']
		};
		leftPieChart.setOption(option,true);
	}
	//drawStateOperPieChart();
	
	//右框
	//在建电站数量数据获取
	//$scope.underBuildNum = [{"name":"电站1"},{"name":"电站2"},{"name":"电站3"}];
	//完成百分比饼图
	function drawPercentFinishPieChart(nature){
		rightPieChart = echarts.init(document.getElementById('finishPercentPieChart'));
		window.addEventListener("resize", function() {
			rightPieChart.resize();
		});
		var isNull = false;
		if(nature === null){
			isNull = true;
			nature = 0;
		}
		var labelTop = {
			    normal : {
			    	color:"#3fcf60",
			        labelLine : {
			            show : false
			        }
			    }
			};
			var labelFromatter = {
			    normal : {
			    	formatter : function (params){
		            	if(params.name == 'a'){
		            		if(isNull){
		            			return "-"
		            		}else{
		            			return params.value +"%"
		            		}
		            		
		            	}else{
		            		return ""
		            	}
		            },
					 show : true,
			         position : 'center',
			         textStyle : {
			         	fontSize : '14',
						color : '#3fcf60',
			             baseline : 'middle'
					 }
			    }
			}
			var labelBottom = {
			    normal : {
			        color: '#ccc',
			        labelLine : {
			            show : false
			        }
			    },
			};
			var radius = [25, 30];
			var option = {
			    legend: {
			        x : 'center',
			        y : 'center',
			        data:[
			            ''
			        ]
			    },
			    series : [
			        {	clockWise:false,
			            type : 'pie',
			            center : ['50%', '50%'],
			            radius : radius,
			            x: '0%', 
			            label : labelFromatter,
			            data : [
							{name:'a', value:nature,itemStyle : labelTop},
			                {name:'b', value:100-nature, itemStyle : labelBottom}
			            ]
			        }
			    ]
			};

		rightPieChart.setOption(option,true);
	}
	
	//基本信息柱状图
	//绘制柱状图表方法
	//drawBasicInfoBarChart();
	function drawBasicInfoBarChart(runInst,faultInst,sumInst) {
		basicInfoBarChart = echarts.init(document.getElementById('basicInfo'));
		window.addEventListener("resize", function() {
			basicInfoBarChart.resize();
		});
		var option = {
			    tooltip: {
			        trigger: 'axis'
			    },
			    calculable: true,
			    grid: {
					x: '10px',
					x2: '10px',
					y: "30px",
					y2: "0px"
				},
			    xAxis: [
			        {
			            type: 'category',
			            show: false,
			            data: ['总装机', '风电装机', '光伏装机']
			        }
			    ],
			    yAxis: [
			        {
			            type: 'value',
			            show: false
			        }
			    ],
			    series: [
					{
					    name: '运行容量',
					    type: 'bar',
						stack:'容量',
					    itemStyle: {
					        normal: {
					            color: "#3fcf61",
					        }
					    },
					    data: runInst,
					},
			        {
			            name: '故障容量',
			            type: 'bar',
			          barWidth: 15,
			          stack: '容量',
			            itemStyle: {
			                normal: {
			                    color: "#d9a536",
			                    label: {
			                        show: true,
			                        position: 'top',
			                        formatter:function(params){
			                        	var returnStr = params.name+'\n';
			                        	if(params.name == "光伏装机"){
			                        		returnStr += sumInst[2]+"MWp";
			                        	}else if(params.name == "总装机"){
			                        		returnStr += sumInst[0]+"MWp";
			                        	}else if(params.name == "风电装机"){
			                        		returnStr += sumInst[1]+"MW";
			                        	}
			                        	return returnStr;
			                        },
			                        textStyle:{
			                        	color:"white"
			                        }
			                    }
			                }
			            },
			           data: faultInst,
			        },
			       
			    ]
			};
			                    
		basicInfoBarChart.setOption(option);
	}
	
	function refreshBasicInfoBarChart(runValue,faultValue,sumValue) {
		if(basicInfoBarChart){
			var option = basicInfoBarChart.getOption();
			option.series[0].data = runValue;
			option.series[1].data = faultValue;
			option.series[1].itemStyle = {
                normal: {
                    color: "#d9a536",
                    label: {
                        show: true,
                        position: 'top',
                        formatter:function(params){
                        	var returnStr = params.name+'\n';
                        	if(params.name == "光伏装机"){
                        		returnStr += sumValue[2]+"MWp";
                        	}else if(params.name == "总装机"){
                        		returnStr += sumValue[0]+"MWp";
                        	}else if(params.name == "风电装机"){
                        		returnStr += sumValue[1]+"MW";
                        	}
                        	return returnStr;
                        },
                        textStyle:{
                        	color:"white"
                        }
                    }
                }
	        }
			basicInfoBarChart.setOption(option,true);
		}
		
	}
	
	var staticClassMap = {
			"0" : '地面光伏',
			"1" : '分布式光伏',
			"2" : '户用光伏',
			"3" : '风电',
	}
	$scope.stationClassSelect = function (idx ) {
		var op = provinceMapChart.getOption();
		var isActive = $("#stClassId"+idx).hasClass("stClassNoActive");
		if(isActive){
			$("#stClassId"+idx).removeClass("stClassNoActive");
			if(idx == 1){
				op.legend[0].selected['风电'] = true;
				op.legend[0].selected['风电在建'] = true;
				op.legend[0].selected['风电计划'] = true;
			}else{
				op.legend[0].selected['地面光伏'] = true;
				op.legend[0].selected['分布式光伏'] = true;
				op.legend[0].selected['户用光伏'] = true;
				op.legend[0].selected['光伏在建'] = true;
				op.legend[0].selected['光伏计划'] = true;
			}
			
		}else{
			$("#stClassId"+idx).addClass("stClassNoActive");
			if(idx == 1){
				op.legend[0].selected['风电'] = false;
				op.legend[0].selected['风电在建'] = false;
				op.legend[0].selected['风电计划'] = false;
			}else{
				op.legend[0].selected['地面光伏'] = false;
				op.legend[0].selected['分布式光伏'] = false;
				op.legend[0].selected['户用光伏'] = false;
				op.legend[0].selected['光伏在建'] = false;
				op.legend[0].selected['光伏计划'] = false;
			}
			//op.legend[0].selected[staticClassMap[idx]] = false;
		}
		provinceMapChart.setOption(op ,true);
		
	}
})


/** $(function(){
	var defaultIndex = 1000000;
	var index = 123;
	index +=defaultIndex;
	var added = 200;
	setInterval(function(){
		index += added;
		changeDayPower(index);
	}, 3000);
	
	function changeDayPower(){		
		$("#odometer").html(index);
	}
	changeDayPower();
});*/

var normalstyle = {
		color: '#24d934',//点的颜色
		shadowColor: 'rgba(156, 74, 60, .5)',
		shadowBlur: 20
}
var falutstyle = {
		color: 'rgb(236, 67, 46)',//点的颜色
		shadowColor: 'rgba(156, 74, 60, .5)',
		shadowBlur: 20
}
var warnstyle= {
		color: 'rgb(246, 254, 57)',
		shadowColor: 'rgba(156, 74, 60, .5)',
		shadowBlur: 20
}
var breakstyle = {
		color: 'rgb(204, 204, 204)',
		shadowColor: 'rgba(204, 204, 204, .5)',
		shadowBlur: 20
}

function formatMapData(PartObj,idx) {
	var arrData = []
	var symbol = "";
	if(idx == 1){
		//symbol = "rect";
		symbol = "image://theme/images/datang/monitoringMap/solar-operation-icon.png";
	}else if(idx == 2){
		//symbol = "circle";
		symbol = "image://theme/images/datang/monitoringMap/solar-operation-icon.png";
	}else if(idx == 3){
		symbol = "image://theme/images/datang/monitoringMap/solar-operation-icon.png";
	}else if(idx == 4){
		symbol = "image://theme/images/datang/monitoringMap/solar-construction-icon.png";
	}else if(idx == 5){
		symbol = "image://theme/images/datang/monitoringMap/solar-plan-icon.png";
	}else if(idx == 6){
		symbol = "image://theme/images/datang/monitoringMap/wind-operation-icon.png";
	}else if(idx == 7){
		symbol = "image://theme/images/datang/monitoringMap/wind-construction-icon.png";
	}else if(idx == 8){
		symbol = "image://theme/images/datang/monitoringMap/wind-plan-icon.png";
	}
	
	for (var j = 0; j < PartObj.data.length; j++) {
		var powerName = PartObj.data[j].name;
		var status = PartObj.data[j].status;
		var itemStyle;
		if(status == "0"){
			itemStyle =  normalstyle;
		}else if(status == "1"){
			itemStyle =  falutstyle;
		}else if(status == "2"){
			itemStyle =  warnstyle;
		}else if(status == "3"){
			itemStyle =  breakstyle;
		}
		var normalitemStyle = {normal : itemStyle};
		var obj = {
			name: powerName,
			id: PartObj.data[j].id,
			value: PartObj.data[j].value,
			symbol : symbol,
			itemStyle : normalitemStyle
		};
		//obj.value.push(PartObj.data[j]['value']);
		arrData.push(obj);
	}
	return arrData;
}
//根据数组中每项的每个属性的值查找在数组中的排序，找不到返回-1
function getArrAtrNum(arr, atr, value) {//getArrAtrNum([{id:1},{id:2}], "id", 3)
	for (var i = 0; i < arr.length; i++) {
		if (arr[i][atr] == value) {
			return i;
		}
	}
	return -1;
};
function getArrAtrNum2(arr, atr, value) {
	for (var i = 0; i < arr.length; i++) {
		if (arr[i][atr].substr(0,2) == value) {
			return i;
		}
	}
	return -1;
};

//退出登录
function logOut(){
	$.ajax({
		type:"post",
		url:"${ctx}/Login/logout.htm",
		timeout : 5000,
		data:{},
		success:function(msg){
			window.location.href="${ctx}/login.jsp";
		},
		error:function(msg){
			window.location.href="${ctx}/login.jsp";
		}
	});
}
function closeMap() {
	$('#showMap').modal("hide");
	$("#upJt").css("display", "none");
	$("#downJt").css("display", "none");
	$("#right-arrow").css("display", "none");
	$("#left-arrow").css("display", "none");
}

function clickMapArea(param, id, ecConfig) {
	var xPos, yPos ,xRight ,yDown;
	var e = param.event || window.event;
	
	xPos = e.offsetX + document.body.scrollLeft
			+ document.documentElement.scrollLeft  - 150;
	yPos = e.offsetY + document.body.scrollTop
			+ document.documentElement.scrollTop - 360;
	
	var winX = $(window).width();
	var winY = $(window).height();
	
	yDown = winY-(e.offsetY+360);
	xRight = e.offsetX-360;
	$.ajax({
				type : "post",
				url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationModalShowData.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					$("#myModalLabelName").html(param.name);
					clickStationId = id;
					clickStationClass = stationClassMap.get(id).stClass;
					//在建或者规划电站 不显示“进入电站”链接
					if(stationClassMap.get(id).stStatus == '01' || stationClassMap.get(id).stStatus == '02' ){
						$("#goStationIsShow").hide();
					}else{
						$("#goStationIsShow").show();
					}
					if(msg.factPic){
						$("#stationModalImg").attr(
								"src",
								"${imgPath}/document/powerStationPicture/"
										+ msg.factPic);
					}else{
						if(clickStationClass == '01'){
							$("#stationModalImg").attr("src","${ctx}/theme/images/dailybg.jpg");
						}else if(clickStationClass == '02'){
							$("#stationModalImg").attr("src","${ctx}/theme/images/defaultWP.png");
						}
					}
					if(msg.powerData.realTimePower){
						$("#stationActPwr").html(msg.powerData.realTimePower[0]+ msg.powerData.realTimePower[1]);
					}else{
						$("#stationActPwr").html("-");
					}
					if(msg.powerData.dayGeneratingPower){
						$("#stationDayPower").html(msg.powerData.dayGeneratingPower[0]+ msg.powerData.dayGeneratingPower[1]);
					}else{
						$("#stationDayPower").html("-");
					}
					if(msg.powerData.monthGeneratingPower){
						$("#stationMonthPower").html(msg.powerData.monthGeneratingPower[0]+ msg.powerData.monthGeneratingPower[1]);
					}else{
						$("#stationMonthPower").html("-");
					}
					if(msg.powerData.yearGeneratingPower){
						$("#stationYearPower").html(msg.powerData.yearGeneratingPower[0]+ msg.powerData.yearGeneratingPower[1]);
					}else{
						$("#stationYearPower").html("-");
					}
					//判断状态
					if(stationClassMap.get(id).stStatus == '01'){
						$("#stationStatus").html("<span class='black-5'>建设中</span>")
					}else if(stationClassMap.get(id).stStatus == '02' ){
						$("#stationStatus").html("<span class='black-5'>规划中</span>")
					}else{
						if(msg.powerData.comm==1){
							$("#stationStatus").html("<span class='black-5'>通讯中断</span>")
						}else if(msg.powerData.comm==2){
							$("#stationStatus").html("<span class='black-5'>初始化</span>")
						}else{
							if(msg.powerData.status==1){//故障
								$("#stationStatus").html("<span class='map-red'>故障</span>")
							}else if(msg.powerData.status==2){//报警
								$("#stationStatus").html("<span class='map-yellow'>报警</span>")
							}else {//正常
								$("#stationStatus").html("<span class='map-green'>正常运行</span>")
							}
						}
					}
					
					/* if (yPos < 0) {
						$("#showMap").css({"left" : xPos,"top" : Math
							.abs(e.offsetY
							+ document.body.scrollTop
							+ document.documentElement.scrollTop) + 25
						});
						$("#downJt").css("display", "none");
						$("#upJt").css("display", "block");
						$('#showMap').modal("show");
					} else if (xPos < 0) {
						$("#showMap").css({"left" : Math.abs(e.offsetX
								+ document.body.scrollLeft
								+ document.documentElement.scrollLeft) - 10,
								"top" : yPos});
						$('#showMap').modal("show");
					} else {
						$("#showMap").css({"left" : xPos,"top" : yPos});
						$("#upJt").css("display", "none");
						$("#downJt").css("display", "block");
						$('#showMap').modal("show");
					} */
					$("#upJt").css("display", "none");
					$("#downJt").css("display", "none");
					$("#right-arrow").css("display", "none");
					$("#left-arrow").css("display", "none");
					
					if(yPos > 0){
						$("#modalPosition").css({"left" : xPos,"top" : yPos});
						$("#downJt").css("display", "block");
					}else if((yPos <= 0) && (yDown > 0)){
						$("#modalPosition").css({"left" : xPos,"top" : Math
							.abs(e.offsetY
							+ document.body.scrollTop
							+ document.documentElement.scrollTop) + 25
						});
						
						$("#upJt").css("display", "block");
					}else if(xRight > 0){
						$("#modalPosition").css({"left" : xPos - 240,
								"top" : Math.abs(e.offsetY
										+ document.body.scrollTop
										+ document.documentElement.scrollTop)-165});
						$("#right-arrow").show();
					}else{
						$("#modalPosition").css({"left" : xPos + 200,
							"top" : Math.abs(e.offsetY
									+ document.body.scrollTop
									+ document.documentElement.scrollTop)-165});
						$("#left-arrow").show();
					}
					$('#showMap').modal("show");
				},
				error : function(json) {
					//alert("保存失败,请稍后重试!");
				}
			});
}

app.controller('oneStationMonitorCtrl', function($scope, $http, $state,$rootScope) {
	//进入电站监控
	$scope.showStationMonitor = function() {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/changeDataType.htm",
			params: {
				id: clickStationId,
				dataType: 0,
				stClass : clickStationClass,
				isGroup : '0'
			}
		}).success(function(res) {
			$state.go($rootScope.firstMenuUrl[clickStationClass]["uisref"], {
				stationId : clickStationId
			});
			/**if(clickStationClass == '01'){
				$state.go("app.dashboard-v1", {
					stationId : clickStationId
				});
			}else if(clickStationClass == '02'){
				$state.go("app.wpMonitoring", {
					stationId : clickStationId
				});
			}*/
		});
	}
});
</script>
<!-- 地图弹出层 -->
<!-- <div id="showMap"> -->
<div class="modal fade " tabindex="-1" id="showMap"  role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" >
<div class="modal-dialog modal-sm m-n" ng-controller="oneStationMonitorCtrl" id="modalPosition">
	<div id="upJt" class="upJt">
		<img src="${ctx}/theme/images/solway/icon/up.png" />
	</div>
	<div class="modal-content white-trans-70 modal-map">
		<div class="modal-header wrapper-sm">
			<button type="button" class="close green-new" onclick="closeMap()">×</button>
			<span class="modal-title font-h3" id="myModalLabelName"></span>
			<span class="font-h6 green-new a-cur-poi  m-l"
				ng-click="showStationMonitor();" id="goStationIsShow">进入电站 >></span>
		</div>
		<div class="modal-body no-padder">
			<div class="row">
				<div class="col-sm-12">
					<div class="panel-body wrapper-sm" style="padding-bottom: 0px">
						<div class="col-sm-12 no-padder white-1 font-h4">
							<img id="stationModalImg" class="no-padder control-label"
								style="width: 100%; height: 100px;" src="">
						</div>
						<div class="col-sm-12 no-padder" style="line-height: 40px;border-bottom: 1px solid rgba(0, 0, 0,.4);">
								<span class="m-r-xs white-1">运行状态</span> 
								<span id="stationStatus"></span>
						</div>
						<div class="col-sm-12 no-padder" style="line-height: 40px;">
							<span class="white-1 font-h3">实时功率</span> <span
								class="m-l-sm font-h2 data-orange" id="stationActPwr"></span> 
						</div>
						<div class="col-sm-12 no-padder white-1 font-h3"
							style="line-height: 30px;">
							<span class="col-sm-4 no-padder">
								<div>日发电量</div>
								<div class="font-h2 data-green" id="stationDayPower"></div>
							</span> <span class="col-sm-4 no-padder">
								<div>月发电量</div>
								<div class="font-h2 data-blue" id="stationMonthPower"></div>
							</span> <span class="col-sm-4 no-padder">
								<div>年发电量</div>
								<div class="font-h2 data-yellow" id="stationYearPower"></div>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		<img id="right-arrow" src="${ctx}/theme/images/solway/icon/down.png" style="display:none;position:absolute;transform: rotate(-90deg);right: -40px;bottom: 150px;">
		<img id="left-arrow" src="${ctx}/theme/images/solway/icon/down.png" style="display:none;position:absolute;transform: rotate(90deg);left: -40px;bottom: 95px;">
		<div id="downJt" class="downJt">
			<img src="${ctx}/theme/images/solway/icon/down.png" />
		</div>
	</div>
	<!-- /.modal-dialog -->
</div>
</div>
