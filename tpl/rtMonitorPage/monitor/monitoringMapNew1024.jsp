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
.table-striped > tbody > tr:nth-child(odd) {
    background-color: transparent;
}
.table-striped > tbody > tr:nth-child(even) {
    background-color: transparent;
}
.table > thead > tr > th {
    padding: 0;
    font-size: 12px;
    text-align: center;
    border-right: 1px solid white;
    height: 27px;
    vertical-align: middle;
    color: white;
}
.table-striped > tbody > tr:nth-child(odd) > td, .table-striped > tbody > tr:nth-child(odd) > th {
    background-color: transparent;
    font-size: 12px;
    border-right: 1px solid white;
    height: 27px;
}
.table-striped > tbody > tr:nth-child(even) > td, .table-striped > tbody > tr:nth-child(even) > th {
    background-color: transparent;
    font-size: 12px;
    border-right: 1px solid white;
    height: 27px;
}
.table > tbody > tr > td, .table > tfoot > tr > td {
    padding: 0;
    text-align: center;
    border-top: 1px solid #eaeff0;
    color: white;
}
</style>
<div ng-controller="mapMonitorNew1024Ctrl" class="earth-bg">
	<div class="bg"></div>
	<div class="earth-bg"></div>
	<div class="bg-cover1"></div>
	<div class="bg-cover2"></div>
	<div class="page-content">
		<!-- 头 -->
		<div style="z-index: 6;position: relative;padding: 0 3rem !important;">
			<div class="header">
				<hr/>
				<div class="trapezoid">
					<div class="small-trapezoid"></div>
					<h1><img src="theme/images/common/logo1.png" class="company-logo"><span class="font38">智能运营管控系统</span></h1>
				</div>
			</div>
			<div class="clearfix font18" style="margin-top: -1.8rem;">
				<div class="pull-left">
					<span><img src="theme/images/datang/monitoringMap/clock-icon.png" style="width: 1.4rem;margin-right: 18px;vertical-align: sub;"></span>
					<span class="font24" ng-bind="nowTime | date:'yyyy-MM-dd HH:mm:ss'"></span>
				</div>
				<div class="pull-right header-tab menu-con">
					<ul class="header">
						<li style="margin-left: 0;">
							<a style="color: white;" ui-fullscreen="" class="" title="全屏模式"><i class="fa fa-expand text"> </i><i class="fa fa-compress text-active"> </i></a>
						</li>
						<li>
							<img src="theme/images/common/knowledge-base.png" class="pointer" style="width: 1.2rem;" ng-click="toKnowledge()" title="知识库">
						</li>	
						<li>
							<img src="theme/images/common/bell.png" class="pointer"  style="width: 1rem;" ng-click="toBaseMessage()" title="消息库">
							<span class="badge badge-sm bg-danger pull-right-xs msg_center_num"></span>
						</li>	
						<li>
							<span  class="ico_power" data-toggle="modal" data-target="#switchPowerModal"></span>
						</li>
						<li class="dropdown" dropdown>
							<a href class="dropdown-toggle clear" dropdown-toggle style="color:white;">
								<i class="ico_user"></i>
								<span class="" ng-bind="realName"></span>
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
                <div id="chinaChart" style="height:100%;"></div>
                <div class="wind-solar-tab-con font14">
                	<a ng-click="stationClassSelect('0' )"><span id="stClassId0" ><img src="theme/images/datang/monitoringMap/capacity-maintain.png" style="margin-right:15px;width: 14px;">光伏</span></a>
                	<a ng-click="stationClassSelect('1' )"><span id="stClassId1" ><img src="theme/images/datang/monitoringMap/wind-operation.png"  style="margin-right:15px;width: 14px;">风电</span></a>
                </div>
	        </div>
		</div> 
		<!-- 左右框 -->
		<div class="clearfix no-padder" style="position: absolute;;bottom: 0;left: 3rem;right: 3rem;top: 11rem;">
			<div class="con-left pull-left">
				<div class="square-con clearfix" ng-click="showSquareDetail('powerInfo')">
					<div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<div class="col-sm-12 border-bottom-blue no-padder" style="padding-bottom: 0.6rem !important;">
	                    	<img src="theme/images/datang/monitoringMap/power-info.png" style="width:1rem;"><span class="font20 square-item-title">电量信息</span>
	                    </div>
	                    <div class="col-sm-12 no-padder font16" style="padding: 0.83rem 1.7rem 0 !important;">
	                    	<div>日发电量&nbsp;&nbsp;&nbsp;kWh</div>
	                    	<div class="odometer big-green " id="odometer"></div>
	                    </div>
                    </div>
                    <div class="col-sm-12 no-padder secLevelPage-con-left clearfix" style="padding: 0.83rem 1.7rem 0 !important;">
	                    <div class="col-sm-12 no-padder clearfix p-line">
	                    	<div class="col-sm-3 no-padder font16">月发电量</div>
	                    	<div class="col-sm-7 no-padder progress-con">
	                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">{{MonitorData.monthGeneratingPower[0]|sDecimalFilter:'2'}}</span><span class="blue" style="margin-left: 0.8rem;">{{MonitorData.monthGeneratingPower[1]}}</span></div>
	                    		<div class="clearfix progress-hover-con">
	                    			<div class="pull-left progressBar" id="monthPowerProgressWidth" style="width:70%;">
	                    				<span class="bar-content-red span" style="width:{{planMonthPower}};"></span>
	                    				<span class="bar-content-green span" style="width:{{currentMonthPower}};"></span>
	                    			</div>
	                    			<div class="pull-left progressBar" style="width:15%;"><span class="bar-content-orange span" style="width:{{exceedMonthPower}};background:orange;height:0.5rem;"></span>
	                    			</div>
	                    			<div class="alert-station-detail" style="display:none;">
	                    				<span class="arrow-left-tip"></span>
										<p class="font14"><span class="power-type-label">月发电量</span><span>{{MonitorData.monthGeneratingPower[0]|sDecimalFilter:'2'}}{{MonitorData.monthGeneratingPower[1]}}</span></p>
										<p class="font14"><span class="power-type-label">计划电量</span><span>{{MonitorData.monthPlan[0]|sDecimalFilter:'2'}}{{MonitorData.monthPlan[1]}}</span></p>
										<p class="font14"><span class="power-type-label">超发电量</span><span>{{exceedPowerValueM|sDecimalFilter:'2'}}kWh</span></p>
									</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="col-sm-12 no-padder clearfix p-line">
	                    	<div class="col-sm-3 no-padder font16">年发电量</div>
	                    	<div class="col-sm-7 no-padder progress-con">
	                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">{{MonitorData.yearGeneratingPower[0]|sDecimalFilter:'2'}}</span><span class="blue" style="margin-left: 0.8rem;">{{MonitorData.yearGeneratingPower[1]}}</span></div>
	                    		<div class="clearfix progress-hover-con">
	                    			<div class="pull-left progressBar" id="yearPowerProgressWidth" style="width:70%;">
	                    				<span class="bar-content-red span" style="width:{{planYearPower}};"></span>
	                    				<span class="bar-content-green span" style="width:{{currentYearPower}};"></span>
	                    			</div>
	                    			<div class="pull-left progressBar" style="width:15%;">
	                    				<span class="bar-content-orange span" style="width:{{exceedYearPower}};background:orange;height:0.5rem;"></span>
	                    			</div>
	                    			<div class="alert-station-detail" style="display:none;">
	                    				<span class="arrow-left-tip"></span>
										<p class="font14"><span class="power-type-label">年发电量</span><span>{{MonitorData.yearGeneratingPower[0]|sDecimalFilter:'2'}}{{MonitorData.yearGeneratingPower[1]}}</span></p>
										<p class="font14"><span class="power-type-label">计划电量</span><span>{{MonitorData.yearPlan[0]|sDecimalFilter:'2'}}{{MonitorData.yearPlan[1]}}</span></p>
										<p class="font14"><span class="power-type-label">超发电量</span><span>{{exceedPowerValueY|sDecimalFilter:'2'}}kWh</span></p>
									</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="col-sm-12 no-padder clearfix p-line">
	                    	<div class="col-sm-3 no-padder font16">累计发电量</div>
	                    	<div class="col-sm-7 no-padder progress-con">
	                    		<div class="font12 text-right" style="height: 0.7rem;">
	                    			<span class="font18 light-green">{{MonitorData.accumulateGeneratingPower[0]|sDecimalFilter:'2'}}</span>
	                    			<span class="blue" style="margin-left: 0.8rem;">{{MonitorData.accumulateGeneratingPower[1]}}</span></div>
	                    		<div class="clearfix progress-hover-con">
	                    			<div class="pull-left progressBar" id="totalPowerProgressWidth" style="width:70%;">
	                    				<span class="bar-content-green span" style="width:{{totalPower}};"></span>
	                    			</div>
	                    			<div class="alert-station-detail" style="display:none;">
	                    				<span class="arrow-left-tip"></span>
										<p class="font14"><span class="power-type-label">累计发电量</span>
										<span>{{MonitorData.accumulateGeneratingPower[0]|sDecimalFilter:'2'}}{{MonitorData.accumulateGeneratingPower[1]}}</span></p>
									</div>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="col-sm-10 no-padder progress-tip font12">
	                    	<div class="col-sm-4 no-padder text-left green"><span class="green-tip tip"></span><span>当前发电量</span></div>
	                    	<div class="col-sm-4 no-padder text-center red"><span class="red-tip tip"></span><span>计划发电量</span></div>
	                    	<div class="col-sm-4 no-padder text-right"><span class="orange-tip tip"></span><span>超发电量</span></div>
	                    </div>
                    </div>
				</div>
				<div class="square-con clearfix">
                    <div class="square-title font20 clearfix">
                    	<div class="col-sm-12 no-padder border-bottom-blue" style="line-height: 24px;    padding-bottom: 0.6rem !important;">
	                    	<div class="col-sm-6 no-padder font20">
	                    		<img src="theme/images/datang/secondLevelHomePage/realtime-icon.png" style="width:1.3rem;"><span class="square-item-title">功率曲线图</span></div>
	                    	<div class="col-sm-6 no-padder text-right">
	                    		<span class="font24" id="totalPower">{{sumPower|sDecimalFilter:'1'}}kW
	                    			<div class="alert-station-detail" style="display:none;width:200px">
	                    				<span class="arrow-left-tip"></span>
										<p ng-repeat="item in stationPointsList" class="font14"><span>{{item.name}}：</span><span>{{item.power|dataNullFilter}}kW</span></p>
									</div>
	                    		</span>
	                    	</div>
	                    </div>
                    </div>
                    <div class="power-curve">
                    	<div id="powerCurve" style="height:10rem;"></div>
                    </div>
                </div>
			</div>
			<div class="con-right pull-right">
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
            	<div class="square-con clearfix" style="margin-top: 3rem;"  ng-click="showSquareDetail('basicInfo')">
                    <div class="col-sm-12 border-bottom-blue no-padder" style="line-height: 24px;padding-bottom: 0.6rem !important;">
                    	<img src="theme/images/datang/monitoringMap/ico-base.png" style="width:18px;"><span class="font20 square-item-title">基本信息</span>
                    </div>
                    <div class="col-sm-12 no-padder " id="basicInfo" style="height:7.8rem;"></div>
                </div>
                <div class="square-con clearfix" style="padding-bottom: 7px;" ng-click="showWindow()">
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
    <div data-ng-include="'${ctx}/tpl/datang/rtMonitorPage/rtWindow.jsp'"></div>
</div>

<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/powerStationManage.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>
<script type="text/javascript" src="${ctx}/vendor/echarts/china-min.js"></script>
<script type="text/javascript" src="${ctx}/theme/js/datang/odometer.js"></script>
<script>
//发光城市
$(function(){
	$("#totalPower").mouseover(function(){
		$("#totalPower .alert-station-detail").show();
	}).mouseout(function(){
		$("#totalPower .alert-station-detail").hide();
	});
	
	$(".progress-hover-con").mouseover(function(){
		$(this).find(".alert-station-detail").show();
	}).mouseout(function(){
		$(this).find(".alert-station-detail").hide();
	});
});

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
		symbol = "rect";
	}else if(idx == 2){
		symbol = "circle";
	}else if(idx == 3){
		symbol = "triangle";
	}else if(idx == 4){
		symbol = "image://theme/images/WindTurbine_DJ.gif";
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
</script>
<script type="text/javascript">
$(".modal-backdrop").css("display","none")
var curIndx = 0;
var doubleClick=false;
var mapType = [ 'china',
	// 5个自治区
	'新疆', '广西', '宁夏', '内蒙古', '西藏',
	// 23个省
	'广东', '青海', '四川', '海南', '陕西', '甘肃', '云南', '湖南', '湖北', '黑龙江', '贵州', '山东',
			'江西', '河南', '河北', '山西', '安徽', '福建', '浙江', '江苏', '吉林', '辽宁', '台湾',
			// 4个直辖市
			'北京', '天津', '上海', '重庆',
			// 2个特别行政区
			'香港', '澳门' ];
var mt = mapType[0];
var stationMap;
var stationClassMap;
var timeTicket;
var timer2;
var basicInfoBarChart=null;
app.controller('mapMonitorNew1024Ctrl', function($scope,$rootScope,$http, $state, $stateParams,$interval) {
	
	$rootScope.isGroup = 1;
	$rootScope.currentView = '00';
	
	//获取当前时间
	$interval(function(){
		$scope.nowTime = new Date();
	},1000);

	$scope.$on("broadcastSwitchStation", function (event, msg) {
		$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
			dataType: msg.stFlag
		});
	});
	
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
	$scope.selectCompanyName = '全部';
	
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
				if(res.dayGeneratingPowerKWh || res.dayGeneratingPowerKWh === 0){
					$("#odometer").html(1000000 + res.dayGeneratingPowerKWh);
				}
				getPowerData(res.monthGeneratingPowerOrg,res.monthPlanOrg,res.yearGeneratingPowerOrg,res.yearPlanOrg,res.accumulateGeneratingPower);//电量信息数据

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
			drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
		})
	});
	
	$scope.getMapStationData = function(){
		$http({
			method : "POST",
			url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew2.htm",
		}).success(function(res) {
			var stList = [];
			var sumPower = 0;
			for(var i=0; i<res.data.length;i++){
				var st = res.data[i].data;
				for(var j=0; j<st.length;j++){
					var stMap = st[j];
					if(stMap['stClass'] == '01'){
						stMap['left'] = "74%";
						stMap['top'] = "40%";
						stMap['itemName1'] = "光照强度";
						stMap['itemUnit1'] = "W/㎡";
					}else if(stMap['stClass'] == '02'){
						stMap['left'] = "65%";
						stMap['top'] = "14%";
						stMap['itemName1'] = "风速";
						stMap['itemUnit1'] = "m/s";
					}
					if(stMap['power']){
						sumPower +=stMap['power'];
					}
					stList.push(stMap);
				}
				
			}
			$scope.sumPower = sumPower;
			$scope.stationPointsList = stList;
		});
	
	}

	//功率曲线数据获取
	function powerCurveData(){
		//接口
		$http({
			method : "POST",
			url : "${ctx}/MobileHmDeviceMonitor/getDayChartRealTimePowerAllST.htm",
		}).success(function(res) {
			var data = {
					'xAxis':res.echarts_xaxisTime,
					'forecast': res.echarts_predictPower,
					'actual': res.echarts_power,
					'should': res.echarts_predictPower
			}
			
			//$scope.echarts_xaxisTime = res.echarts_xaxisTime;
			drawPowerCurve(res.echarts_xaxisTime,[],res.echarts_power,res.echarts_predictPower)
		});
		
		$http({
			method : "POST",
			url : "${ctx}/currentPower/getCurrentPowerPointData.htm",
		}).success(function(res) {
			$scope.allSTData = res.data;
		});
		
	}

	function init(){
		$scope.getMapStationData();//获取地图上电站的标注点的信息
		powerCurveData();//功率曲线图数据
	}
	
	init();


    //点击弹框
    $scope.showSquareDetail = function(type){
        if(type == "powerInfo"){
            $scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/powerInfoDetail.jsp";
        }else if(type == "basicInfo"){
            $scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/basicInfo.jsp";
        }else if(type == "equRunning"){
            $scope.showPowerIndexData="tpl/datang/rtMonitorPage/monitor/model/equRunning.jsp";
        }
        $('#powerIndexModal').modal();
    }

    $scope.showWindow = function () {
        $scope.$broadcast('showWindow')
    }
    
    //关闭弹出层
    $scope.hiddenModal=function(){
        $('#powerIndexModal').modal("hide");
    };

	function sub2(a,b){
		if(a!=undefined && a!="" && a!=null && b!=undefined && b=="" && b!=null && a!="-" && b!="-"){
			return a - b;
		}
		return "-";
	}
	//功率曲线图
	function drawPowerCurve(xAxis,forecast,actual,should){
		realtimeChart = echarts.init(document.getElementById('powerCurve'));	
		window.addEventListener("resize", function() {
			realtimeChart.resize();
		});
		var option = {
			tooltip : {
				trigger : 'axis'
		    },
		    legend : {
				left: 'center',
				bottom:'0',
				orient : 'horizontal',

				data : [ 
						{icon: 'line',name:'预测功率',textStyle: {color: '#ff8439'}},
						{icon: 'line',name:'实际功率',textStyle: {color: '#25ff2a'}},
				        {icon: 'line',name:'应发功率',textStyle: {color: '#53ddff'}}
					]
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '50px',
				x2 : '20px',
				y : "30px",
				y2 : "45px"
			},
			xAxis : [ {
				axisTick : {
					show : false
				},
				type : 'category',
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				splitLine : {
					show : false
				},
				axisLabel : {
					formatter: function (value, index) {
					    // 格式化成月/日，只在第一个刻度显示年份
					    // var date = new Date(value);
					    var sList = value.split(":");
					    return sList[0];
					}
				},
				data :xAxis
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : 'kW',
				font : {
					color : '#bbb'
				},
				splitNumber : 3,
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				splitLine : {
					show : false
				},
				type : 'value'
			}],
			series : [ {
				name : '实际功率',
				type : 'line',
				symbol : 'none',
				smooth: true,
				itemStyle : {
					normal : {
						color : '#25ff2a',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#25ff2a',
							width : 1
						}
					}
				},
				data :actual
			},{
				type : 'line',
				name : '应发功率',
				symbol : 'none',
				smooth: true,
				itemStyle : {
					normal : {
						color : '#53ddff',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#53ddff',
							width : 1
						}
					}
				},
				data : should
			},{
				name : '预测功率',
				symbol : 'none',
				type : 'line',
				smooth: true,
				itemStyle : {
					normal : {
						color : '#ff8439',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#ff8439',
							width : 1
						}
					}
				},
				data : forecast
			}]
		};
		realtimeChart.setOption(option);
		
		timeCurve=setInterval(function(){
			$http.get("${ctx}/MobileHmDeviceMonitor/getDayChartRealTimePowerAllST.htm",
				{params : {},timeout: 5000
			}).success(function(res) {
				var opt = realtimeChart.getOption();
				opt.series[2].data = [];
				opt.series[1].data = res.echarts_predictPower;
				opt.series[0].data = res.echarts_power;
				realtimeChart.setOption(opt,true);	
			})
			
			$http({
				method : "POST",
				url : "${ctx}/currentPower/getCurrentPowerPointData.htm",
			}).success(function(res) {
				console.log("-------111");
				$scope.allSTData = res.data;
			});
		},60000);
		
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

	$scope.$on('$stateChangeStart', function(event) {
		$('.modal-backdrop').css("display","none");
		clearInterval(timer1);
		clearInterval(timer2);
		clearInterval(timeTicket);
	})

	$scope.roleId = $scope.currentRoleID;

	timer2 = setInterval(function() {
		$scope.$apply($scope.getDayRDM);
		//$scope.$apply($scope.refreshMap);
	}, 5000);

	//获取左框电量信息数据
	function getPowerData(m_r,m_p,y_r,y_p,t){	
		//计算月发电功率，bar的长度比例
		var planPowerWidthM = $("#monthPowerProgressWidth").width();
		$scope.planPowerValueM = m_p;
		$scope.currentPowerValueM = m_r;
		$scope.exceedPowerValueM = m_r-m_p;
		if($scope.exceedPowerValueM < 0){
			$scope.exceedPowerValueM = 0;
		}
		
		$scope.planMonthPower = $scope.planPowerValueM == 0 ? "0%": '100%';

		if($scope.currentPowerValueM/$scope.planPowerValueM > 1){
			$scope.currentMonthPower = "100%";
		}else{
			$scope.currentMonthPower = ($scope.currentPowerValueM/$scope.planPowerValueM)*100+"%";
		}
		$scope.exceedMonthPower = ($scope.exceedPowerValueM/$scope.planPowerValueM)*planPowerWidthM+"px";
		//计算年发电功率，bar的长度比例
		var planPowerWidthY = $("#yearPowerProgressWidth").width();
		
		$scope.planPowerValueY = y_p;
		$scope.currentPowerValueY = y_r;
		$scope.exceedPowerValueY = y_r-y_p;
		if($scope.exceedPowerValueY < 0){
			$scope.exceedPowerValueY = 0;
		}
		
		$scope.planYearPower = $scope.planPowerValueY == 0 ? "0%": '100%';

		if($scope.currentPowerValueY/$scope.planPowerValueY > 1){
			$scope.currentYearPower = "100%";
		}else{
			$scope.currentYearPower = ($scope.currentPowerValueY/$scope.planPowerValueY)*100+"%";
		}
		$scope.exceedYearPower = ($scope.exceedPowerValueY/$scope.planPowerValueY)*planPowerWidthY+"px";

		//计算累计发电功率
		$scope.totalPower = t[0] == '0'? '0%' : "100%";
		
	}

	//地图图例过滤
	$scope.filterMapData = function () {
		var oMapData = {};
		oMapData.normal = $scope.isUnNormal?[]:$scope.normalData;
		oMapData.fault  = $scope.isUnFault ?[]:$scope.faultData;
		oMapData.alarm  = $scope.isUnAlarm ?[]:$scope.alarmData;
		oMapData.breaks = $scope.isUnBreak ?[]:$scope.breakData;
		return oMapData;
	}
	$scope.mapAllData = function () {
		$scope.isUnAll = !$scope.isUnAll;
		if ($scope.isUnAll) {
			$scope.isUnNormal = true;
			$scope.isUnFault = true;
			$scope.isUnAlarm = true;
			$scope.isUnBreak = true;
		} else {
			$scope.isUnNormal = false;
			$scope.isUnFault = false;
			$scope.isUnAlarm = false;
			$scope.isUnBreak = false;
		}
		$scope.oMapData = $scope.filterMapData();
		drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
	}
	$scope.mapNormalData = function () {
		$scope.isUnNormal = !$scope.isUnNormal;
		$scope.oMapData = $scope.filterMapData();
		drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
	}
	$scope.mapFaultData = function () {
		$scope.isUnFault = !$scope.isUnFault;
		$scope.oMapData = $scope.filterMapData();
		drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
	}
	$scope.mapAlarmData = function () {
		$scope.isUnAlarm = !$scope.isUnAlarm;
		$scope.oMapData = $scope.filterMapData();
		drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
	}
	$scope.mapBreakData = function () {
		$scope.isUnBreak = !$scope.isUnBreak;
		$scope.oMapData = $scope.filterMapData();
		drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
	}
	$scope.tiggerMapBtn = function(){
		$("#minMapBtn").addClass("hidden");
		doubleClick=true;
		mt = 'china';
		curIndx = 0;
		drawMap($scope.companyId, $http, $scope,mt,$scope.oMapData);
	}


	//进入电站监控
	$scope.showStationMonitor = function(){
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
			
		});
		
	}



	//消息中心
	$scope.toBaseMessage = function() {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/setSTClass.htm",
			params: {
			}
		}).success(function(res) {
			$state.go("app.note", {
				recuserId : $scope.userId
			});
		});
		
	}
	$scope.toKnowledge = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/setSTClass.htm",
			params: {
			}
		}).success(function(res) {
			$state.go('app.knowledgeBaseSummary');
		});
	}
	$scope.toMonitoring = function () {
		$state.go($rootScope.firstMenuUrl["01"]["uisref"]);
	}
	$scope.toIncomeSettlement = function () {
		$state.go('app.incomeSettlement');
	}
	$scope.toAnalyze = function () {
		$state.go('analyzeHome');
	}
	$scope.toPowerStationView = function () {
		$state.go('app.powerStationView');
	}

	//锁屏
	$scope.lockMe = function() {
		$.ajax({
			url: '${ctx}/Login/logout.htm',
			type: 'POST',
			data: {},
		})
		.done(function(msg) {
			$state.go("lockme", {
				loginName : $scope.loginName,
				realName : $scope.realName
			});
		})
	}
	$scope.editUserData=function(){
		initPageDataUserMod($scope.userId);
		$('#userInformationUpdateModel').modal('show');
	}
	$scope.changePassword=function(){
		$('#userPasswordChangeModel').modal('show');
	}
	$scope.powerStationManage = function(){
		$('#powerStationManageModal').modal('show');
	}
	
	//判断是否有邀请 TODO
	$scope.hasCompanysInvite = function() {
		var storage = window.localStorage;
		var hasComInvite = storage["hasComInvite"];
		if(hasComInvite && hasComInvite == 1){
			$http({
				method : "POST",
				url : "${ctx}/BaseMessage/queryUserValidComInvite.htm",
				params: {
				}
			}).success(function(res) {
				var storage = window.localStorage;
				storage["hasComInvite"] = 0;
				if(res && res.code == 1 && res.data.length > 0){
					$('#hasComInvite').modal('show');
				}
			});
		}
		
	}
	
	$scope.hasCompanysInvite();
	
	var staticClassMap = {
			"0" : '地面光伏',
			"1" : '分布式光伏',
			"2" : '户用光伏',
			"3" : '风电',
	}
	$scope.stationClassSelect = function (idx ) {
		var op = myChart.getOption();
		var isActive = $("#stClassId"+idx).hasClass("stClassNoActive");
		if(isActive){
			$("#stClassId"+idx).removeClass("stClassNoActive");
			op.legend[0].selected[staticClassMap[idx]] = true;
		}else{
			$("#stClassId"+idx).addClass("stClassNoActive");
			op.legend[0].selected[staticClassMap[idx]] = false;
		}
		myChart.setOption(op ,true);
		
	}
	
});
function refreshMap(){
		$.ajax({
			type : "post",
			url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew2.htm",
			async : false,
			success : function(result) {
				//console.log(result);
					stationMap = new MapDef();
					stationClassMap = new MapDef();
					var op = myChart.getOption();
					if(result){
						$("#normalStNum").html(result.normalNum);
						$("#faultStNum").html(result.faultNum);
						$("#alarmStNum").html(result.warnNum);
						$("#breakStNum").html(result.breakNum);
						
						if(result.data && result.data.length ){
							for (var i = 0; i < result.data.length; i++) {
								var resdata = result.data[i].data;
								if (resdata != null && resdata.length > 0) {
									for (var j = 0; j < resdata.length; j++) {
										var pst = resdata[j];
										stationMap.put(pst.name, pst.id);
										stationClassMap.put(pst.id, pst.stClass);
									}
								}
								
								var resName = result.data[i].name;
								if(resName =="地面"){
									op.series[0].data = formatMapData(result.data[i],"1");
								}else if(resName =="分布"){
									op.series[1].data = formatMapData(result.data[i],"2");
								}else if(resName =="户用"){
									op.series[2].data = formatMapData(result.data[i],"3");
								}else if(resName =="风电"){
									op.series[3].data = formatMapData(result.data[i],"4");
								}
								
							}
							
						}
					}
					myChart.setOption(op,true);
			}
		
	});
};
var myChart;
function drawMap(companyId, $http, $scope,mt, oMapData) {
	myChart = echarts.init(document.getElementById('chinaChart'));
	if(navigator.userAgent.indexOf("Firefox")>0){
		$(myChart._dom).height(window.innerHeight);
		myChart.resize();
	}
	window.addEventListener("resize", function() {
		if(navigator.userAgent.indexOf("Firefox")>0){
			$(myChart._dom).height(window.innerHeight);
			myChart.resize();
		}else{
			myChart.resize();
		}
		
	});
	var option = {
		tooltip : {
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
			data:["地面光伏" , "分布式光伏","户用光伏","风电"]
		},
		geo: {
			map: mt,
			roam: true,
			zoom:0.87,
			center: [100, 38],
			label: {
			    normal: {
			        show: true,
			        textStyle: {
			            color: "#16e6ff",//省份颜色,
			           	borderColor: 'rgb(0,211,255)'
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
                    areaColor: 'rgba(0,0,0,0.5)',
                    borderColor: 'rgb(0,211,255)',
                },
                emphasis: {
                    areaColor: 'rgba(75,241,241,0.65)'
                }
            },
		},
		series : [
		          {
		              name: '地面光伏',
		              //type: 'map',
		              //mapType: 'china',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 8,
		              //symbol: 'rect',//?试下是这个吗
		              data:[
		                  //{name: '北京',value: Math.round(Math.random()*1000)}
		                  
		              ]
		          },
		          {
		              name: '分布式光伏',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 8,
		            //symbol: 'circle',
		              data:[]
		          },
		          {
		              name: '户用光伏',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 8,
		              //symbol: 'triangle',
		              data:[]
		          },
		          {
		              name: '风电',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 15,
		            //symbol: 'image://url',
		              data:[]
		          },
		]
	};
	myChart.setOption(option,true);
	refreshMap();

	// 为echarts对象加载数据
	if(!timeTicket){
		timeTicket = setInterval(function (){
			refreshMap();
			//myChart.setOption(option);
		},5000);
	}

	// var ecConfig = require('echarts/config');
	//点击事件，判断是点击点 还是点击区域

	//var zrEvent = require('zrender/tool/event');
	myChart.on('click', function(param) {
		if (stationMap.get(param.name) != null) {//点击电站显示弹出层
			//alert('电站')
			clickMapArea(param, stationMap.get(param.name));
			
		} else {//返回全国
			//console.log("返回哪里")
			//curIndx = 0;
			//mt = 'china';
		}
		
		//option.geo.map = mt;
		//option.title.subtext = mt + ' （滚轮或点击切换）';
		//myChart.setOption(option, true);
	});

	//双击跳转到电站界面
	myChart.on('dblclick', function(param) {
		return;
		//closeMap();
		if (mapType.indexOf(param.name) >= 0) {
			var len = mapType.length;
			mt = mapType[curIndx % len];
			if (mt == 'china') {//点击全国地图中的省份进入该省地图
				for ( var i in mapType) {
					if (mapType[i] == param.name) {
						mt = mapType[i];
						curIndx = i;
						break;
					}
				}
				doubleClick=false;
				$("#minMapBtn").removeClass("hidden");
				option.geo.map = mt;
				myChart.setOption(option, true);
				refreshMap();
			}
		}else if (mapType.indexOf(param.name) < 0){
			//if(stationMap.get(param.name)){
				//clickStationId = stationMap.get(param.name);
				//$scope.showStationMonitor()
			//}
		}
	});
}
function closeMap() {
	//$("#showMap").css("left", "-999px");
	$('#showMap').modal("hide");
	$("#upJt").css("display", "none");
	$("#downJt").css("display", "none");
}
var clickStationId = null;
var clickStationClass = null;
function clickMapArea(param, id, ecConfig) {
	var xPos, yPos;
	var e = param.event || window.event;
	xPos = e.offsetX + document.body.scrollLeft
			+ document.documentElement.scrollLeft  - 150;
	yPos = e.offsetY + document.body.scrollTop
			+ document.documentElement.scrollTop - 360;
	$.ajax({
				type : "post",
				url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationModalShowData.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					$("#myModalLabelName").html(param.name);
					clickStationId = id;
					clickStationClass = stationClassMap.get(id);
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
					//$('#myModal').modal({keyboard : true});
					if (yPos < 0) {

						$("#showMap").css({"left" : xPos,"top" : Math
							.abs(e.clientY
							+ document.body.scrollTop
							+ document.documentElement.scrollTop) + 25
						});
						$("#downJt").css("display", "none");
						$("#upJt").css("display", "block");
						$('#showMap').modal("show");
					} else if (xPos < 0) {
						$("#showMap")
								.css({"left" : Math.abs(e.clientX
										+ document.body.scrollLeft
										+ document.documentElement.scrollLeft) - 10,
										"top" : yPos});
						$('#showMap').modal("show");
					} else {
						$("#showMap").css({"left" : xPos,"top" : yPos});
						$("#upJt").css("display", "none");
						$("#downJt").css("display", "block");
						$('#showMap').modal("show");
					}
				},
				error : function(json) {
					//alert("保存失败,请稍后重试!");
				}
			});
}

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

//消息中心
getNoticeCount1();
timer1 = setInterval(getNoticeCount1,5000)
function getNoticeCount1(){
	$.ajax({
		type : "POST",
		url : "${ctx}/BaseMessage/getNoReadBaseMessageCount.htm",
		data : {
			'searchKey':'',
			isRorS:true
		},
		success:function(result) {
			if(result > 0) {
				$(".msg_center_num").html(result);
			}else{
				$(".msg_center_num").html("");
			}
		}
	});
};

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
		});
	}
});
</script>

<!-- 地图弹出层 -->
<!-- <div id="showMap"> -->
<div class="modal fade "id="showMap" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" >
<div class="modal-dialog modal-sm m-n" ng-controller="oneStationMonitorCtrl">
	<div id="upJt" class="upJt">
		<img src="${ctx}/theme/images/solway/icon/up.png" />
	</div>
	<div class="modal-content white-trans-70 modal-map">
		<div class="modal-header wrapper-sm">
			<button type="button" class="close green-new" onclick="closeMap()">×</button>
			<span class="modal-title font-h3" id="myModalLabelName"></span>
			<span class="font-h6 green-new a-cur-poi  m-l"
				ng-click="showStationMonitor();">进入电站 >></span>
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
		<div id="downJt" class="downJt">
			<img src="${ctx}/theme/images/solway/icon/down.png" />
		</div>
	</div>
	<!-- /.modal-dialog -->
</div>
</div>
