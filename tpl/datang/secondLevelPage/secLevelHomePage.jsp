<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.app-header-fixed {padding-top: 0px;}
html,body {color:white;}
.red{color:#ff1e1e;}
.grey{color:#adadad;}
.modal-backdrop {
    z-index: 9;
}
.map-bg-con{background:url("theme/images/datang/secondLevelHomePage/map-bg.png") no-repeat;background-size: contain;}
/* 地图弹出层 */
.white-border-b{border-bottom:1px solid white;}

.table > tbody > tr > td, .table > tfoot > tr > td {
    padding: 0;text-align: center;
    border-top: 1px solid #eaeff0;
    color: white;
}
.table-striped > tbody > tr:nth-child(odd) {
    background-color: transparent;
}
.table-striped > tbody > tr:nth-child(even) {
    background-color: transparent;
}
.table-striped > tbody > tr:nth-child(odd) > td, .table-striped > tbody > tr:nth-child(odd) > th {
    background-color: transparent;font-size:12px;    border-right: 1px solid white;    height: 27px;
}
.table-striped > tbody > tr:nth-child(even) > td, .table-striped > tbody > tr:nth-child(even) > th {
    background-color: transparent;font-size:12px;    border-right: 1px solid white;    height: 27px;
}
.table > thead > tr > th {
    padding:0;font-size:12px;text-align: center; border-right: 1px solid white;    height: 27px;    vertical-align: middle;
    color: white;
}
</style>
<div ng-controller="dtSecondLevelHomePageCtrl" class="datang-index">
	<div class="secLevelPage-bg"></div>
	<div class="page-content">
		<div style="z-index: 6;position: relative;padding: 0 3rem !important;">
			<div class="header">
				<div class="trapezoid">
				
					<!-- 新 -->
					<div class="time-con">
						<span><img src="theme/images/datang/monitoringMap/clock-icon.png" style="width: 1.67rem;margin-right: 18px;vertical-align: top;"></span>
						<span ng-bind="nowTime | date:'yyyy-MM-dd HH:mm:ss'" class="font24"></span>
					</div>
					<!-- 新 -->
					
					<!-- <h1><img src="theme/images/datang/monitoringMap/logo-new.png" class="company-logo"><span>智慧绿色能源管控平台</span></h1> -->
					<!-- <div class="now-time font20"  ng-bind="nowTime | date:'yyyy-MM-dd HH:mm:ss'"></div> -->
				</div>
			</div>
			<div class="clearfix font18" style="margin-top: -3.9rem;">
				<!-- <div class="pull-left header-tab">
					<a ng-class="{'tab-active':activeTab == 'index'}" ng-click="changeTab('index')"><i class="fa fa-dashboard icon" style="margin-right:8px;font-size: 18px;"></i><span>总览</span></a>
					<a ng-class="{'tab-active':activeTab == 'solar'}" ng-click="changeTab('solar')"><img src="theme/images/datang/monitoringMap/solar-icon.png" style="width: 21px;"><span>葛沽</span></a>
					<a ng-class="{'tab-active':activeTab == 'wind'}" ng-click="changeTab('wind')"><img src="theme/images/datang/monitoringMap/wind-power-icon.png" style="width: 11px;"><span>青灰岭</span></a>
					<a ng-class="{'tab-active':activeTab == 'other'}" ng-click="changeTab('other')"><img src="theme/images/datang/monitoringMap/other-icon.png" style="width: 15px;"><span>其他</span></a>
					<span><img src="theme/images/datang/monitoringMap/clock-icon.png" style="width: 1.67rem;margin-right: 18px;vertical-align: top;"></span>
					<span ng-bind="nowTime | date:'yyyy-MM-dd HH:mm:ss'" class="font24"></span>
				</div> -->
				
				<!-- 新 -->
				<div class="pull-left header-tab" style="    margin-top: -0.8rem;">
					<h1 class="company-name"><img src="theme/images/datang/monitoringMap/logo-new.png" class="company-logo"><span>智慧绿色能源管控平台</span></h1>
				</div>
				<!-- 新 -->
				
				<div class="pull-right header-tab menu-con">
					<ul class="header">
						<li style="margin-left: 0;">
							<a style="color: white;" ui-fullscreen="" class="" title="全屏模式"><i class="fa fa-expand text"> </i><i class="fa fa-compress text-active"> </i></a>
						</li>
						<li>
							<img src="theme/images/common/knowledge-base.png" class="pointer" style="width: 1.55rem;" ng-click="toKnowledge()" title="知识库">
						</li>	
						<li>
							<img src="theme/images/common/bell.png" class="pointer"  style="width: 1.15rem;" ng-click="toBaseMessage()" title="消息库">
							<span class="badge badge-sm bg-danger pull-right-xs msg_center_num"></span>
						</li>	
						<li>
							<span  class="ico_spread" data-toggle="modal" data-target="#switchPowerModal"></span>
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
						<li>
							<img src="theme/images/datang/monitoringMap/index-icon.png" class="pointer" style="width: 1rem;" ng-click="toPageIndex()">
							<!-- <img src="theme/images/datang/secondLevelHomePage/refresh.png"  style=" width: 1.15rem;vertical-align: text-top;"> -->
						</li>			
					</ul>
				</div>
			</div>
		</div>
		<!-- body地图 -->
		<!-- <div class="map-body">
	        <div class="width-center">
                <div id="provinceChart" style="height:100%;"></div>
	        </div>
		</div> -->
		<!-- 左右框 -->
		<div class="clearfix no-padder" style="position: absolute;;bottom: 0;left: 3rem;right: 3rem;top: 9.1rem;">
			<div class="secLevelPage-con-left pull-left">
                <div class="square-con clearfix" style="margin:0">
                    <div class="square-title font20 clearfix">
                    	<div class="col-sm-12 no-padder" style="line-height: 24px;">
	                    	<div class="col-sm-6 no-padder font20"><img src="theme/images/datang/secondLevelHomePage/realtime-icon.png">功率曲线图</div>
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
	                    <div class="alert-station-detail" style="width: 27rem;display:none;">
               				<span class="arrow-left-tip"></span>
               				<!-- <p class="text-left" style="font-size:12px;">{{allSTList.time}}</p> -->
               				<table class="table table-striped " style="color:white;border-left: 1px solid white;border-bottom: 1px solid white;border-top: 1px solid white;margin-bottom: 0;">
               					<thead><tr>
	               					<th style="font-size:22px;width:15px">{{allSTList.time}}</th>
	               					<th ng-repeat="vo in allSTList.stnames" style="width: 4rem;">{{vo.value}}</th>
               					</tr></thead>
               					<tbody>
               						<tr><td style="text-align: left;">实际功率(kW)</td>
               							<td ng-repeat="vo in allSTList.power">{{vo.value}}</td>
               						</tr>
               						<tr><td style="text-align: left;">预测功率(kW)</td>
               							<td ng-repeat="vo in allSTList.prePower">{{vo.value}}</td>
               						</tr>
               						<tr><td style="text-align: left;">应发功率(kW)</td>
               							<td ng-repeat="vo in allSTList.should">{{vo.value}}</td>
               						</tr>
               						<tr><td style="text-align: left;">预测与实际功率差值(kW)</td>
               							<td ng-repeat="vo in allSTList.preMinus">{{vo.value}}</td>
               						</tr>
               						<tr><td style="text-align: left;">应发与实际功率差值(kW)</td>
               							<td ng-repeat="vo in allSTList.shouldMinus">{{vo.value}}</td>
               						</tr>
               					</tbody>
               				</table>
						</div> 
                    </div>
                    
                </div>
                <div class="square-con clearfix">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<p class="square-title font20"><img src="theme/images/datang/secondLevelHomePage/powerInfo.png">电量信息</p>
                    </div>
                    <div class="col-sm-12 no-padder clearfix p-line">
                    	<div class="col-sm-5 font16">日发电量</div>
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height: 0.7rem;"><span class="font18 light-green">{{MonitorData.dayGeneratingPower[0]|sDecimalFilter:'2'}}</span><span class="blue" style="margin-left: 0.8rem;">{{MonitorData.dayGeneratingPower[1]}}</span></div>
                    		<div class="clearfix progress-hover-con">
                    			<div class="pull-left progressBar" id="dayPowerProgressWidth" style="width:70%;background:red;"><span class="bar-content-green span" style="width:{{currentDayPower}};"></span></div><div class="pull-left progressBar" style="width:15%;"><span class="bar-content-orange span" style="width:{{exceedDayPower}};background:orange;height:0.5rem;"></span></div>
                    			<div class="alert-station-detail" style="display:none;">
                    				<span class="arrow-left-tip"></span>
									<p class="font14"><span class="power-type-label">日发电量</span><span>{{MonitorData.dayGeneratingPower[0]|sDecimalFilter:'2'}}{{MonitorData.dayGeneratingPower[1]}}</span></p>
									<p class="font14"><span class="power-type-label">计划电量</span><span>{{MonitorData.dayPlan[0]|sDecimalFilter:'2'}}{{MonitorData.dayPlan[1]}}</span></p>
									<p class="font14"><span class="power-type-label">超发电量</span><span>{{exceedPowerValueD|sDecimalFilter:'2'}}kWh</span></p>
								</div>
                    		</div>
                    	</div>
                    </div>
                    <div class="col-sm-12 no-padder clearfix p-line">
                    	<div class="col-sm-5 font16">月发电量</div>
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">{{MonitorData.monthGeneratingPower[0]|sDecimalFilter:'2'}}</span><span class="blue" style="margin-left: 0.8rem;">{{MonitorData.monthGeneratingPower[1]}}</span></div>
                    		<!-- <div class="progressBar"><span class="bar-content-orange span" style="width:80%;"></span><span class="bar-content-red span" style="width:70%"></span><span class="bar-content-green span" style="width:40%;"></span></div> -->
                    		<div class="clearfix progress-hover-con">
                    			<div class="pull-left progressBar" id="monthPowerProgressWidth" style="width:70%;background:red;"><span class="bar-content-green span" style="width:{{currentMonthPower}};"></span></div><div class="pull-left progressBar" style="width:15%;"><span class="bar-content-orange span" style="width:{{exceedMonthPower}};background:orange;height:0.5rem;"></span></div>
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
                    	<div class="col-sm-5 font16">年发电量</div>
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">{{MonitorData.yearGeneratingPower[0]|sDecimalFilter:'2'}}</span><span class="blue" style="margin-left: 0.8rem;">{{MonitorData.yearGeneratingPower[1]}}</span></div>
                    		<div class="clearfix progress-hover-con">
                    			<div class="pull-left progressBar" id="yearPowerProgressWidth" style="width:70%;background:red;"><span class="bar-content-green span" style="width:{{currentYearPower}};"></span></div><div class="pull-left progressBar" style="width:15%;"><span class="bar-content-orange span" style="width:{{exceedYearPower}};background:orange;height:0.5rem;"></span></div>
                    			<div class="alert-station-detail" style="display:none;">
                    				<span class="arrow-left-tip"></span>
									<p class="font14"><span class="power-type-label">年发电量</span><span>{{MonitorData.yearGeneratingPower[0]|sDecimalFilter:'2'}}{{MonitorData.yearGeneratingPower[1]}}</span></p>
									<p class="font14"><span class="power-type-label">计划电量</span><span>{{MonitorData.yearPlan[0]|sDecimalFilter:'2'}}{{MonitorData.yearPlan[1]}}</span></p>
									<p class="font14"><span class="power-type-label">超发电量</span><span>{{exceedPowerValueY|sDecimalFilter:'2'}}kWh</span></p>
								</div>
                    		</div>
                    	</div>
                    </div>
                    <div class="col-sm-12 progress-tip font12">
                    	<div class="col-sm-4 no-padder text-center green"><span class="green-tip tip"></span><span>当前发电量</span></div>
                    	<div class="col-sm-4 no-padder text-center red"><span class="red-tip tip"></span><span>计划发电量</span></div>
                    	<div class="col-sm-4 no-padder text-center"><span class="orange-tip tip"></span><span>超发电量</span></div>
                    </div>
                </div>
                <div class="square-con clearfix" ng-click="showWindow()">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<p class="square-title font20"><img src="theme/images/datang/secondLevelHomePage/fault-icon.png">设备运行情况</p>
                    </div>
                    <div class="col-sm-12 no-padder font16" style="padding: 0 1.4rem 0 !important;">
                    	 <div class="operation-line clearfix font16"  style="height: 2.2rem;">
                    	 	<span class="per25"></span><span class="per15 green">运行</span><span class="per15">待机</span><span class="per15 red">故障</span><span class="per15 yellow">维护</span><span class="per15 grey">离线</span>
                    	 </div>
                    	 <div class="operation-line-common clearfix font16" style="height: 2.9rem;">
                    	 	<span class="per25">风电</span><span class="per15 green" ng-bind="deviceRunData['02'].run|dataNull0Filter"></span><span class="per15" ng-bind="deviceRunData['02'].wait|dataNull0Filter"></span><span class="per15 red" ng-bind="deviceRunData['02'].fault|dataNull0Filter"></span><span class="per15 yellow" ng-bind="deviceRunData['02'].maintain|dataNull0Filter"></span><span class="per15 grey" ng-bind="deviceRunData['02'].comm|dataNull0Filter"></span>
                    	 </div>
                    	 <div class="operation-line-common clearfix font16"  style="height: 2.9rem;">
                    	 	<span class="per25">光伏</span><span class="per15 green" ng-bind="deviceRunData['01'].run|dataNull0Filter"></span><span class="per15" ng-bind="deviceRunData['01'].wait|dataNull0Filter"></span><span class="per15 red" ng-bind="deviceRunData['01'].fault|dataNull0Filter"></span><span class="per15 yellow" ng-bind="deviceRunData['01'].maintain|dataNull0Filter"></span><span class="per15 grey" ng-bind="deviceRunData['01'].comm|dataNull0Filter"></span>
                    	 </div>
                    </div>
                </div>
            </div>
            <div class="secLevelPage-con-center pull-left">
            	<div class="map-bg-con">
            		<div ng-repeat="item in stationPointsList">
            			<span class="station-point-img" ng-class="{'station1':item.stClass == '01'}"  style="left:{{item.left}}; top:{{item.top}};" >
            				<div class="square-pos">
								<span class="circle-point"><span></span></span>
								<span class="verticle-line"></span>
								<div class="clearfix  square-alert-con">
									<div class="pull-left" style="width:110px;height:100%;">
										<img src="theme/images/datang/secondLevelHomePage/station-normal-pic.png" ng-show="item.stClass == '02'" style="width: 100%;height: 100%">
										<img src="theme/images/datang/secondLevelHomePage/station-fault-pic.png"  ng-show="item.stClass == '01'" style="width: 100%;height: 100%">
									</div>
									<div class="pull-right alert-station-detail">
										<div class="white-border-b clearfix" style="padding:8px 0 3px;">
											<div class="pull-left"><a class="station-name-pointer" ng-click="goStationDetail(item.id,item.stationStatus,item.stClass)">{{item.name}}</a></div>
											<div class="pull-right text-right">
												<p class="weather">
													<span class="pull-right" ng-show="item.weatherTag=='A'">
														<i class="ico-family ico-sun"></i>
													</span>
													<span class="pull-right" ng-show="item.weatherTag=='B'">
														<i class="ico-family ico-yin"></i>
													</span>
													<span class="pull-right " ng-show="item.weatherTag=='C'">
														<i class="ico-family ico-rain"></i>
													</span>
													<span class="pull-right" ng-show="item.weatherTag=='D'">
														<i class="ico-family ico-snow"></i>
													</span>
													<span class="pull-right" ng-show="item.weatherTag=='E'">
														<i class="ico-family ico-smog"></i>
													</span>
													<span class="pull-right"ng-show="item.weatherTag=='X'">
														<i class="ico-family ico-weatherelse"></i>
													</span>
												</p>
												<p class="weather">{{item.t}}℃</p>
											</div>
										</div>
										<div class="col-sm-12 clearfix" style="margin:15px 0;font-size:14px;">
											<div class="col-sm-6 no-padder">实时功率</div>
											<div class="col-sm-6 no-padder">{{item.power|dataNullFilter}}kW</div>
										</div>
										<div class="col-sm-12 clearfix" style="font-size:14px;">
											<div class="col-sm-6 no-padder">{{item.itemName1}}</div>
											<div class="col-sm-6 no-padder">{{item.resource|dataNullFilter}}{{item.itemUnit1}}</div>
										
										</div>
									</div> 
								</div>
							</div>
            			</span>
            		</div>
            	</div>
            </div>
            <div class="secLevelPage-width-right secLevelPage-con-right pull-right clearfix" >
            	<div class="square-con clearfix"  style="margin:0" ng-click="toBaseMessage()">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<p class="square-title font20"><img src="theme/images/datang/secondLevelHomePage/realtime-fault-icon.png">设备实时报警列表</p>
                    </div>
                    <div class="col-sm-12 no-padder font16" ng-repeat="note in basemessage" style="padding: 0 2.4rem 0 !important;margin-top:1.2rem ;">
                    	<div class="col-sm-5 no-padder" ><span ng-bind="note.mc|limitTo : 18"></span><span ng-if="note.mc.length >18">...</span></div>
                    	<div class="col-sm-5 no-padder text-center" ng-bind="note.ct|dateFilter"></div>
                    	<!-- <div class="col-sm-3 no-padder" ng-bind="colorList[item.status]" ng-class="{'state-red':item.status == 0,'state-green':item.status == 1}"></div> -->
                    	<div class="col-sm-2 no-padder">
                    		<small ng-if="note.mhs=='00'" class="handle1">
								待确认
							</small>
							<small ng-if="note.mhs=='01'" class="handle1">
								待受理
							</small>
							<small ng-if="note.mhs=='02'" class="handle2">
								待处理
							</small>
							<small ng-if="note.mhs=='03'" class="handle3">
								已关闭
							</small>
							<small ng-if="note.mhs=='04'" class="handle3">
								被确认
						</small>
                    	</div>
                    	
                    </div>
                </div>
                <div class="square-con clearfix" >
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<p class="square-title font20"><img src="theme/images/datang/secondLevelHomePage/analysis-icon.png">智能分析报警列表</p>
                    </div>
                    <div class="col-sm-12 no-padder font16" ng-repeat="item in intelAnalysisFaultList" style="padding: 0 2.4rem 0 !important;margin-top:1.2rem ;">
                    	<div class="col-sm-5 no-padder" ng-bind="item.name"></div>
                    	<div class="col-sm-5 no-padder text-center" ng-bind="item.time"></div>
                    	<div class="col-sm-2 no-padder" ng-bind="colorList[item.status]" ng-class="{'state-red':item.status == 0,'state-green':item.status == 1}"></div>
                    </div>
                </div>
                <div class="square-con clearfix" >
                    <div class="col-sm-6 no-padder" style="line-height: 24px;">
                    	<p class="square-title font20"><img src="theme/images/datang/secondLevelHomePage/safe-icon.png">工作票完成情况</p>
                    </div>
                    <div class="col-sm-6 no-padder text-right" style="line-height: 24px;">
                    	<p class="square-title font20 green">今日累计300</p>
                    </div>
                     <!-- <div class="col-sm-12 no-padder font16" style="padding: 0 2.4rem 0 !important;margin-top: 0.85rem;">
                    	<div class="col-sm-5 no-padder">今日累计数量</div>
                    	<div class="col-sm-3 no-padder text-right green">300</div>
                    </div>
                   <div class="col-sm-12 no-padder font16" style="padding: 0 2.4rem 0 !important;margin-top: 0.85rem;">
                    	<div class="col-sm-5 no-padder">已完成数量</div>
                    	<div class="col-sm-3 no-padder text-right green">223</div>
                    </div> -->
                    <div class="col-sm-12 no-padder font16" ng-repeat="item in workFinishList" style="padding: 0 2.4rem 0 !important;margin-top: 0.85rem;">
                    	<div class="col-sm-5 no-padder" ><span ng-bind="item.content|limitTo : 7"></span><span ng-if="item.content.length >7">...</span></div>
                    	<div class="col-sm-5 no-padder text-center" ng-bind="item.busiDate|dateFilter"></div>
                    	<div class="col-sm-2 no-padder text-right" ng-bind="workStatusList[1]" ng-class="{'state-green':true}"></div>
                    </div>
                </div>
			</div>
		</div>
	</div>

    <div data-ng-include="'${ctx}/tpl/datang/rtMonitorPage/rtWindow.jsp'"></div>

</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/powerStationManage.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>
<%-- <script type="text/javascript" src="${ctx}/vendor/echarts/echarts-gl.min.js"></script> --%>
<script type="text/javascript">

$(function(){
	setMapHeight();
	function setMapHeight(){
		var mapW = $(".map-bg-con").width();
		var mapH = mapW*0.636;
		$(".map-bg-con").height(mapH)
	}
	
	window.addEventListener("resize", function() {
		setMapHeight();
	});
	
	$("#totalPower").mouseover(function(){
		$("#totalPower .alert-station-detail").show();
	}).mouseout(function(){
		$("#totalPower .alert-station-detail").hide();
	});
	
	$("#powerCurve").mouseover(function(){
		$(".power-curve .alert-station-detail").show();	
	}).mouseout(function(){
		$(".power-curve .alert-station-detail").hide();
	});
	
	$(".progress-hover-con").mouseover(function(){
		$(this).find(".alert-station-detail").show();
	}).mouseout(function(){
		$(this).find(".alert-station-detail").hide();
	});
})
var timeTicket;
var provinceMapChart;
var stationMap;
var stationClassMap;
var timeCurve;
app.controller('dtSecondLevelHomePageCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval) {
	
	$rootScope.isGroup = 1;
	$rootScope.currentView = '00';
	
	//获取左框电量信息数据
	function getPowerData(d_r,d_p,m_r,m_p,y_r,y_p){
		//接口
		//计算日发电功率，bar的长度比例
		var planPowerWidthD = $("#dayPowerProgressWidth").width();
		$scope.planPowerValueD = d_p;
		$scope.currentPowerValueD = d_r;
		$scope.exceedPowerValueD = d_r-d_p;
		if($scope.exceedPowerValueD < 0){
			$scope.exceedPowerValueD = 0;
		}
		
		if($scope.currentPowerValueD/$scope.planPowerValueD > 1){
			$scope.currentDayPower = "100%";
		}else{
			$scope.currentDayPower = ($scope.currentPowerValueD/$scope.planPowerValueD)*100+"%";
		}
		$scope.exceedDayPower = ($scope.exceedPowerValueD/$scope.planPowerValueD)*planPowerWidthD+"px";
		
		//计算月发电功率，bar的长度比例
		var planPowerWidthM = $("#monthPowerProgressWidth").width();
		$scope.planPowerValueM = m_p;
		$scope.currentPowerValueM = m_r;
		$scope.exceedPowerValueM = m_r-m_p;
		if($scope.exceedPowerValueM < 0){
			$scope.exceedPowerValueM = 0;
		}
		
		if($scope.currentPowerValueM/$scope.planPowerValueM > 1){
			$scope.currentMonthPower = "100%";
		}else{
			$scope.currentMonthPower = ($scope.currentPowerValueM/$scope.planPowerValueM)*100+"%";
		}
		$scope.exceedMonthPower = ($scope.exceedPowerValueM/$scope.planPowerValueM)*planPowerWidthM+"px";
		//计算年发电功率，bar的长度比例
		var planPowerWidthY = $("#dayPowerProgressWidth").width();
		
		$scope.planPowerValueY = y_p;
		$scope.currentPowerValueY = y_r;
		$scope.exceedPowerValueY = y_r-y_p;
		if($scope.exceedPowerValueY < 0){
			$scope.exceedPowerValueY = 0;
		}
		
		if($scope.currentPowerValueY/$scope.planPowerValueY > 1){
			$scope.currentYearPower = "100%";
		}else{
			$scope.currentYearPower = ($scope.currentPowerValueY/$scope.planPowerValueY)*100+"%";
		}
		$scope.exceedYearPower = ($scope.exceedPowerValueY/$scope.planPowerValueY)*planPowerWidthY+"px";
	}
	
	$scope.$on("broadcastSwitchStation", function (event, msg) {
		/**$state.go("app.dashboard-v1", {
			dataType: msg.stFlag
		});*/
		$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
			dataType: msg.stFlag
		});
	});
	//获取当前时间
	$interval(function(){
		$scope.nowTime = new Date();
	},1000);
	
	//设备状态-map
	$scope.colorList = {"0":"未处理","1":"已处理"};
	$scope.workStatusList = {"0":"未完成","1":"已完成"}
	//默认显示首页tab
	$scope.activeTab = "index";
	$scope.changeTab = function(val){
		$scope.activeTab = val;
	}

	function init(){
		$scope.realtimeFaultListData();//设备实时报警列表数据 
		intelligentAnalysisData();//智能分析报警列表数据
		$scope.workFinishListData();//工作完成情况列表数据
		powerCurveData();//功率曲线图数据
		$scope.getMapStationData();//获取地图上电站的标注点的信息
		$scope.getDeviceStatus();//获取设备运行台数
		
	}
	
	$scope.getDeviceStatus = function(){
		$http({
			url : "${ctx}/MobileRtmDeviceMonitor/getDeviceStatusForDT.htm",
		}).success(function(res) {
			$scope.deviceRunData = res;
		});
		
	}
	
	$scope.getMapStationData = function(){
		//$scope.stationPointsList = [{"stationId":"3002","left":"65%","top":"14%","stationName":"青灰岭风电场","realPower":"452","windSpeed":30,"weather":0,"degree":"30","itemName1":"风速","itemUnit1":"m/s"},
		//                           {"stationId":"3002","left":"74%","top":"40%","stationName":"葛沽光伏电站","realPower":"452","windSpeed":30,"weather":1,"degree":"20","itemName1":"光照强度","itemUnit1":"W/㎡"}]
	
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
	
	//跳转电站详情页
	$scope.goStationDetail = function(stationId,stationStatus,stClass){
		if(stationStatus != '00') return ;
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/changeDataType.htm",
			params: {
				id: stationId,
				dataType: 0,
				stClass : stClass,
				isGroup : '0'
			}
		}).success(function(res) {
			$state.go($rootScope.firstMenuUrl[stClass]["uisref"], {
				stationId : stationId
			});
		});
	}
	
	$scope.toPageIndex = function(){
        $state.go('power-index-datang');
    };
	//设备实时报警数据获取
	$scope.realtimeFaultListData  = function(){
		
		$http({
			method : "POST",
			url : "${ctx}/BaseMessage/getBaseMessageList.htm",
			params : {
				'pageIndex'	:0,
				'pageSize'	:3,
				'listTab':0,
				'isSystemReport':1,
			}
		}).success(function(result) {
			$scope.basemessage=result.data;
		});
	}
	
	//只能分析报警列表数据获取
	function intelligentAnalysisData(){
		//接口
		$scope.intelAnalysisFaultList = [
		    {'name':'设备01温度超限','time':'10:10:10','status':'0'},
		    {'name':'设备02温度超限','time':'10:10:10','status':'0'},
		    {'name':'设备03温度超限','time':'10:10:10','status':'1'}
		];
	}
	
	//工作完成情况数据获取
	$scope.workFinishListData  = function(){
		//接口
		/* $scope.workFinishList = [
		    {'name':'工作内容1','time':'10:10:10','status':'0'},
		    {'name':'工作内容2','time':'10:10:10','status':'0'},
		    {'name':'工作内容3','time':'10:10:10','status':'1'}
		]; */
		
		$http({
	 		method : "POST",
	 		url : "${ctx}/rpdWorkTicket/page.htm",
	 		params : {
				'pageIndex' : 0,
				'pageSize' : 3,
			}
		 }).success(function(result) {
			 $scope.workFinishList = result.data.data;
		 })
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
	
	init();
	
	function sub2(a,b){
		if(a!=undefined && a!="" && a!=null && b!=undefined && b=="" && b!=null && a!="-" && b!="-"){
			return a - b;
		}
		return "-";
	}
	var a=1;
	//功率曲线图
	function drawPowerCurve(xAxis,forecast,actual,should){
		realtimeChart = echarts.init(document.getElementById('powerCurve'));	
		window.addEventListener("resize", function() {
			realtimeChart.resize();
		});
		option = {
			tooltip : {
				trigger : 'axis',
				formatter: function (params,ticket,callback) {
					var dataIndex = params[0].name;
					var stnames = [{'value':'合计'}];
					var power = [{'value':params[0].value}];
					var should = [{'value':params[1].value}];
					var prePower = [{'value':"-"}];
					var shouldMinus = [{'value':sub2(should,power)}];
					var preMinus = [{'value':sub2(prePower,power)}];
					if($scope.allSTData){
						for(var i=0;i<$scope.allSTData.length;i++){
							if($scope.allSTData[i].power){
								stnames.push({'value':$scope.allSTData[i].name});
								power.push({'value':$scope.allSTData[i].power[dataIndex]});
								if($scope.allSTData[i].should){
									should.push({'value':$scope.allSTData[i].should[dataIndex]});
									shouldMinus.push({'value':sub2($scope.allSTData[i].should[dataIndex],$scope.allSTData[i].power[dataIndex])});
								}else{
									should.push({'value':"-"});
									shouldMinus.push({'value':"-"});
								}
								if($scope.allSTData[i].prePower){
									prePower.push({'value':$scope.allSTData[i].prePower[dataIndex]});
									preMinus.push({'value':sub2($scope.allSTData[i].prePower[dataIndex],$scope.allSTData[i].power[dataIndex])});
								}else{
									prePower.push({'value':"-"});
									preMinus.push({'value':"-"});
								}
							}
						}
					}
					$scope.allSTList= {
							time : dataIndex,
							stnames : stnames,
							power : power,
							should : should,
							prePower : prePower,
							shouldMinus : shouldMinus,
							preMinus : preMinus
					};
					/*$http({
						method : "POST",
						url : "${ctx}/MobileHmDeviceMonitor/getDayChartRealTimePowerAllST.htm",
					}).success(function(res) {
						a = a+1;
						$scope.sjgl = a;
					});*/
					
				 	/* var res = '<div class="alert-station-detail" style="width: 27rem;">'+
			        				'<span class="arrow-left-tip">'+'</span>'+
			        				'<p class="text-left" style="font-size:12px;">'+'2017年5月22日  10:10:10'+'</p>'+
			        				'<table class="table table-striped " style="color:white;border-left: 1px solid white;border-bottom: 1px solid white;border-top: 1px solid white;margin-bottom: 0;">'+
			        					'<thead><tr><th style=""></th><th style="width: 4rem;">合计</th><th>葛沽光伏电站</th><th>青灰岭风电场</th></tr></thead>'+
			        					'<tbody>'+
			        						'<tr><td style="text-align: left;">实际功率</td><td>1111kW</td><td>1111kW</td><td>1111kW</td></tr>'+
			        						'<tr><td style="text-align: left;">预测功率</td><td>1111kW</td><td>1111kW</td><td>1111kW</td></tr>'+
			        						'<tr><td style="text-align: left;">应发功率</td><td>1111kW</td><td>1111kW</td><td>1111kW</td></tr>'+
			        						'<tr><td style="text-align: left;">预测与实际功率差值</td><td>1111kW</td><td>1111kW</td><td>1111kW</td></tr>'+
			        						'<tr><td style="text-align: left;">应发与实际功率差值</td><td>1111kW</td><td>1111kW</td><td>1111kW</td></tr>'+
			        					'</tbody>'+
			        				'</table>'+
								'</div> '; */
					//$(".power-curve .alert-station-detail").show();		
		            //return "";
		      	}
		    },
		    legend : {
				left: 'center',
				bottom:'0',
				orient : 'horizontal',
				data : [ {icon: 'line',name:'实际功率',textStyle: {color: '#25ff2a'}},
				         {icon: 'line',name:'应发功率',textStyle: {color: '#53ddff'}},
				         {icon: 'line',name:'预测功率',textStyle: {color: '#ff8439'}}
						]
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '50px',
				x2 : '20px',
				y : "30px",
				y2 : "40px"
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
				getPowerData(res.dayGeneratingPowerOrg,res.dayPlanOrg,res.monthGeneratingPowerOrg,
						res.monthPlanOrg,res.yearGeneratingPowerOrg,res.yearPlanOrg);//电量信息数据
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
		clearInterval(timer1);
		clearInterval(timer2);
		clearInterval(timeTicket);
		clearInterval(timeCurve);
		
	})

	$scope.roleId = $scope.currentRoleID;

	timer2 = setInterval(function() {
		$scope.$apply($scope.getDayRDM);
		//$scope.$apply($scope.refreshMap);
		$scope.$apply($scope.getMapStationData);
		$scope.$apply($scope.getDeviceStatus);
		$scope.$apply($scope.realtimeFaultListData);
		$scope.$apply($scope.workFinishListData);
		
	}, 5000);
	
	
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
		//$state.go('app.dashboard-v1');
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
	
	//drawMap();
	//画省的地图
	function drawMap() {
		provinceMapChart = echarts.init(document.getElementById('provinceChart'));
		$.get('vendor/echarts/datangMap.json', function (chinaJson) {
		    echarts.registerMap('datangMap', chinaJson);
		    window.addEventListener("resize", function() {
		    	provinceMapChart.resize();
			});
		    var option = {
					/* tooltip : {
						trigger: 'item',
						formatter: '{b}'
					}, */
					legend:{
						show:false,
						data:["地面光伏" , "分布式光伏","户用光伏","风电"]
					}, 
					geo: {
						map: 'datangMap',
						roam: true,
						zoom:0.9,
						top:'20%',
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
					/* geo3D: {
						boxWidth:90,
				        map: 'datangMap',
				        groundPlane: {
				            show: false
				        },
				        viewControl: {
				            distance:400
				        },
				        label: {
						    normal: {
						        show: true,
						        textStyle: {
						            color: "red",//省份颜色,
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
			                    areaColor: '#132a46',
			                    borderWidth:1,
			                    borderColor: 'red'
			                },
			                emphasis: {
			                    areaColor: 'rgba(75,241,241,0.65)'
			                }
			            },
				        regionHeight: 6.0
				    }, */
					series : [
						{
						    name: '地面光伏',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 15,
						    data:[
						        
						    ]
						},
						{
						    name: '分布式光伏',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 12,
						    data:[]
						},
						{
						    name: '户用光伏',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 12,
						    data:[]
						},
						{
						    name: '风电',
						    type: 'scatter',
						    coordinateSystem: 'geo',
						    roam: false,
						    symbolSize: 15,
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
				
				
				provinceMapChart.on('click', function(param) {
					if (stationMap.get(param.name) != null) {//点击电站显示弹出层
						clickMapArea(param, stationMap.get(param.name));
						
					} else {
					}
				});
				
				var $divs = $("#provinceChart").find("div");
				console.log($divs);
				for(var i = 0;i<$divs.length;i++){
					/* if($($div[i]).){
						
					} */
					//$($divs[i]).trigger("click");	
				}
				/* setTimeout(function(){
					$("#provinceChart").trigger("click");	
				},3000); */
		});
		
		
	}
	function refreshMap(){
		$.ajax({
			type : "post",
			url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew2.htm",
			async : false,
			success : function(result) {
				//console.log(result);
					stationMap = new Map();
					stationClassMap = new Map();
					var op = provinceMapChart.getOption();
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
					provinceMapChart.setOption(op,true);
			}
		
		});
		//return option;
	};

    $scope.showWindow = function () {
        $scope.$broadcast('showWindow')
    }
	
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
function formatMapData(PartObj,idx) {
	var arrData = []
	var symbol = "";
	
	if(idx == 1){
		//symbol = "rect";
		symbol = "image://theme/images/datang/monitoringMap/capacity-maintain.png";
	}else if(idx == 2){
		//symbol = "circle";
		symbol = "image://theme/images/datang/monitoringMap/capacity-maintain.png";
	}else if(idx == 3){
		symbol = "image://theme/images/datang/monitoringMap/capacity-maintain.png";
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
function closeMap() {
	$('#showMap').modal("hide");
	$("#upJt").css("display", "none");
	$("#downJt").css("display", "none");
}
$("#station-detail-cover").click(function(){
	$("#station-detail-cover").hide();
	$('#showMap').hide();
});
function clickMapArea(param, id) {
	var xPos, yPos;
	var e = param.event || window.event;
	xPos = e.offsetX + document.body.scrollLeft
			+ document.documentElement.scrollLeft  -385;
	yPos = e.offsetY + document.body.scrollTop
			+ document.documentElement.scrollTop - 300;
	$.ajax({
				type : "post",
				url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationModalShowData.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					clickStationId = id;
					clickStationClass = stationClassMap.get(id);
					
					$("#station-detail-cover").show();
					if (yPos < 0) {
					
						$("#showMap").css({"left" : xPos,"top" : Math
							.abs(e.clientY
							+ document.body.scrollTop
							+ document.documentElement.scrollTop) + 25
						});
						$('#showMap').show();
					} else if (xPos < 0) {
						$("#showMap")
								.css({"left" : Math.abs(e.clientX
										+ document.body.scrollLeft
										+ document.documentElement.scrollLeft) - 10,
										"top" : yPos});
						$('#showMap').show();
					} else {
						$("#showMap").css({"left" : xPos,"top" : yPos});
						$('#showMap').show();
					}
				},
				error : function(json) {
					//alert("保存失败,请稍后重试!");
				}
			});
}
</script>





