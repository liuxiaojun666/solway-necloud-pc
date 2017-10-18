<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.app-header-fixed {padding-top: 0px;}
html,body {color:white;}
.red{color:#ff1e1e;}
.grey{color:#adadad;}
</style>
<div ng-controller="dtMonitorCtrl" class="datang-index">
	<div class="bg"></div>
	<div class="bg-cover"></div>
	<div class="page-content">
		<div style="z-index: 6;position: relative;padding: 0 3rem !important;">
			<div class="header">
				<hr/>
				<div class="trapezoid"><div class="small-trapezoid"></div><h1><span  ng-bind="headCenterTitle"></span></h1></div>
			</div>
			<div class="clearfix" style="margin-top: -3rem;">
				<div class="pull-left company-logo"><img ng-src="${imgPath}/{{currCompanyLogo | companyInfoFilter:'${currCompanyLogo}'}}"></div>
				<div class="pull-right header-tab">
					<a ng-class="{'tab-active':activeTab == 'index'}" ng-click="changeTab('index')"><img src="theme/images/datang/monitoringMap/index-icon.png" style="width:15px;"><span>首页</span></a><!-- 
					 --><a ng-class="{'tab-active':activeTab == 'solar'}" ng-click="changeTab('solar')"><img src="theme/images/datang/monitoringMap/solar-icon.png" style="width: 21px;"><span>光伏</span></a><!-- 
					 --><a ng-class="{'tab-active':activeTab == 'wind'}" ng-click="changeTab('wind')"><img src="theme/images/datang/monitoringMap/wind-power-icon.png" style="width: 11px;"><span>风电</span></a><!-- 
					 --><a ng-class="{'tab-active':activeTab == 'other'}" ng-click="changeTab('other')"><img src="theme/images/datang/monitoringMap/other-icon.png" style="width: 15px;"><span>其他</span></a>
				</div>
			</div>
		</div>
		<!-- body地图 -->
		<div class="map-body">
	        <div class="width-center con-center">
                <div id="chinaChart" style="height:100%;"></div>
                <div id="minMapBtn" class="hidden cp" ng-click="tiggerMapBtn()"><img src="theme/images/little_map.png"></div>
	        </div>
		</div>
		<!-- 左右框 -->
		<div class="clearfix no-padder" style="margin-top: 4.5rem;padding: 0 3rem !important;">
			<div class="con-left pull-left">
                <div class="square-con clearfix" style="margin-bottom: 1.5rem;">
                    <div class="col-sm-12 no-padder" style="line-height: 24px;">
                    	<div class="col-sm-6 no-padder"><img src="theme/images/datang/monitoringMap/realtime-icon.png" style="width:20px;"><span class="font20" style="margin-left: 0.5rem;">实时功率</span></div>
                    	<div class="col-sm-6 green font30 text-right no-padder-left"><span>542.67</span><span style="margin-left: 0.9rem;">kW</span></div>
                    </div>
                    <div id="realtimeLineChart" style="height: 8.8rem;z-index: 9999;"></div>
                </div>
                <div class="square-con clearfix no-padder-left no-padder-right" style="padding: 0.7rem 0.5rem 1rem;">
                    <div class="col-sm-12 border-bottom-blue" style="line-height: 24px;padding-bottom: 0.6rem;">
                    	<div class="col-sm-6 no-padder"><img src="theme/images/datang/monitoringMap/power-info.png" style="width:18px;"><span class="font20" style="margin-left: 0.5rem;">电量信息</span></div>
                    </div>
                    <div class="col-sm-12 no-padder clearfix border-bottom-blue p-line">
                    	<div class="col-sm-5 font16 blue">日发电量</div>
                    	<!-- <div class="col-sm-9"><div class="progressBar"><span class="bar-content span" style="width:{{item.percen| dataNullFilter}}%"></span></div></div> -->
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">9.45</span><span class="blue" style="margin-left: 0.8rem;">万千瓦时</span></div>
                    		<div class="progressBar"><span class="bar-content-red span" style="width:70%"></span><span class="bar-content-green span" style="width:40%;"></span></div>
                    	</div>
                    </div>
                    <div class="col-sm-12 no-padder clearfix border-bottom-blue p-line">
                    	<div class="col-sm-5 font16 blue">月发电量</div>
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">9.45</span><span class="blue" style="margin-left: 0.8rem;">万千瓦时</span></div>
                    		<div class="progressBar"><span class="bar-content-red span" style="width:70%"></span><span class="bar-content-green span" style="width:40%;"></span></div>
                    	</div>
                    </div>
                    <div class="col-sm-12 no-padder clearfix border-bottom-blue p-line">
                    	<div class="col-sm-5 font16 blue">年发电量</div>
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">9.45</span><span class="blue" style="margin-left: 0.8rem;">万千瓦时</span></div>
                    		<div class="progressBar"><span class="bar-content-red span" style="width:70%"></span><span class="bar-content-green span" style="width:40%;"></span></div>
                    	</div>
                    </div>
                    <div class="col-sm-12 no-padder clearfix border-bottom-blue p-line">
                    	<div class="col-sm-5 font16 blue">累计发电量</div>
                    	<div class="col-sm-7 no-padder progress-con">
                    		<div class="font12 text-right" style="height:12px;"><span class="font18 light-green">9.45</span><span class="blue" style="margin-left: 0.8rem;">万千瓦时</span></div>
                    		<div class="progressBar"><span class="bar-content-red span" style="width:70%"></span><span class="bar-content-green span" style="width:40%;"></span></div>
                    	</div>
                    </div>
                    <div class="col-sm-12 progress-tip font12">
                    	<div class="col-sm-4 no-padder text-center"><span class="white-tip tip"></span><span>最大发电量</span></div>
                    	<div class="col-sm-4 no-padder text-center red"><span class="red-tip tip"></span><span>计划发电量</span></div>
                    	<div class="col-sm-4 no-padder text-center green"><span class="green-tip tip"></span><span>当前发电量</span></div>
                    </div>
                </div>
            </div>
			<!-- 首页右框 -->
			<div class="width-right con-right pull-right" ng-show="activeTab == 'index'">
				<div class="square-con clearfix">
                    <div class="col-sm-12  border-bottom-blue padding20">
                    	<div class="col-sm-12"><span class="icon-con"><img src="theme/images/datang/monitoringMap/capacity-icon.png" style="width:20px;"></span>总容量</div>
                    	<div class="col-sm-12 yellow font30 text-right lineHeight2"><span ng-bind="MonitorData.installedCapacity[0]|dataNullFilter"></span><span ng-bind="MonitorData.installedCapacity[1]|dataNullFilter" class="font24"></span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20">
                    	<div class="col-sm-12"><span class="icon-con"><img src="theme/images/datang/monitoringMap/wind-power-icon.png" style="width:12px;"></span>风电容量</div>
                    	<div class="col-sm-12 blue font30 text-right lineHeight2"><span>100</span><span class="font24">MW</span></div>
                    </div>
                    <div class="col-sm-12 padding20">
                    	<div class="col-sm-12"><span class="icon-con"><img src="theme/images/datang/monitoringMap/solar-icon.png" style="width:16px;"></span>光伏容量</div>
                    	<div class="col-sm-12 orange font30 text-right lineHeight2"><span>61</span><span class="font24">MWp</span></div>
                    </div>
                </div>
                <div class="square-con clearfix" style="margin-top:1.5rem;">
                    <div class="col-sm-12 padding12">
                    	<div class="col-sm-12"><span class="icon-con"><img src="theme/images/datang/monitoringMap/plant-icon.png" style="width:14px;"></span>植树</div>
                    	<div class="col-sm-12 green font36 text-right lineHeight2"><span ng-bind="MonitorData.plantedTree|dataNullFilter"></span><span class="font24" style="margin-left: 0.9rem;">棵</span></div>
                    </div>
                </div>
                <div class="square-con clearfix" style="margin-top: 1.3rem;">
                    <div class="col-sm-12 padding12">
                    	<div class="col-sm-12"><span class="icon-con"><img src="theme/images/datang/monitoringMap/co2-icon.png" style="width:18px;"></span>碳累计减排</div>
                    	<div class="col-sm-12 light-green font36 text-right lineHeight2"><span ng-bind="MonitorData.co2[0]|dataNullFilter"></span><span class="font24">t</span></div>
                    </div>
                </div>
			</div>
			<!-- 光伏右框 -->
			<div class="width-right con-right pull-right" ng-show="activeTab == 'solar'">
				<div class="square-con clearfix">
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con"><img src="theme/images/datang/monitoringMap/capacity-solar.png" style="width:20px;"></span>光伏容量</div>
                    	<div class="col-sm-6 font30 orange text-right padding-right40"><span >35.6</span><span class="font24">MWp</span></div>
                    </div>
                    <div class="col-sm-12 padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con"><img src="theme/images/datang/monitoringMap/capacity-online.png" style="width:20px;"></span>在线容量</div>
                    	<div class="col-sm-6 font30 blue text-right padding-right40"><span >35.6</span><span  class="font24">MWp</span></div>
                    </div>
                </div>
                <div class="square-con clearfix" style="margin-top: 4rem;">
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 green">
                    	<div class="col-sm-6"><span class="icon-con-solar"><img src="theme/images/datang/monitoringMap/capacity-operation.png" style="width:20px;"></span>运行容量</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >19</span><span  class="font24">MWp</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con-solar"><img src="theme/images/datang/monitoringMap/capacity-standby.png" style="width:20px;"></span>待机容量</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >19</span><span  class="font24">MWp</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 red">
                    	<div class="col-sm-6"><span class="icon-con-solar"><img src="theme/images/datang/monitoringMap/capacity-fault.png" style="width:20px;"></span>故障容量</div>
                    	<div class="col-sm-6 font30  text-right padding-right40"><span >0</span><span  class="font24">MWp</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 yellow">
                    	<div class="col-sm-6"><span class="icon-con-solar"><img src="theme/images/datang/monitoringMap/capacity-maintain.png" style="width:20px;"></span>维护容量</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >0</span><span  class="font24">MWp</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 grey">
                    	<div class="col-sm-6"><span class="icon-con-solar"><img src="theme/images/datang/monitoringMap/capacity-offline.png" style="width:20px;"></span>离线容量</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >0</span><span  class="font24">MWp</span></div>
                    </div>
                </div>
			</div>
			<!-- 风电右框 -->
			<div class="width-right con-right pull-right wind-power" ng-show="activeTab == 'wind'">
				<div class="square-con clearfix">
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con"><img src="theme/images/datang/monitoringMap/wind-capacity.png" style="width:10px;"></span>风电容量</div>
                    	<div class="col-sm-6 font30 text-right padding-right40 orange"><span >35.6</span><span class="font24">MW</span></div>
                    </div>
                    <div class="col-sm-12 border-bottom-blue padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con"><img src="theme/images/datang/monitoringMap/wind-capacity-online.png" style="width:13px;"></span>在线容量</div>
                    	<div class="col-sm-6 font30 text-right padding-right40 blue"><span >35.6</span><span  class="font24">MW</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con"><img src="theme/images/datang/monitoringMap/installed-units.png" style="width:18px;"></span>装机台数</div>
                    	<div class="col-sm-6 font30 text-right padding-right40 orange"><span >38</span><span class="font24">台</span></div>
                    </div>
                    <div class="col-sm-12 padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con"><img src="theme/images/datang/monitoringMap/online-units.png" style="width:18px;"></span>在线台数</div>
                    	<div class="col-sm-6 font30 text-right padding-right40 blue"><span >38</span><span  class="font24">台</span></div>
                    </div>
                </div>
				<div class="square-con clearfix" style="margin-top: 1.5rem;">
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 green">
                    	<div class="col-sm-6"><span class="icon-con-wind"><img src="theme/images/datang/monitoringMap/wind-operation.png" style="width:15px;"></span>运行</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >19</span><span class="font24">台</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2">
                    	<div class="col-sm-6"><span class="icon-con-wind"><img src="theme/images/datang/monitoringMap/wind-standby.png" style="width:15px;"></span>待机</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >19</span><span class="font24">台</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 red">
                    	<div class="col-sm-6"><span class="icon-con-wind"><img src="theme/images/datang/monitoringMap/wind-fault.png" style="width:15px;"></span>故障</div>
                    	<div class="col-sm-6 font30  text-right padding-right40"><span >0</span><span class="font24">台</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 yellow">
                    	<div class="col-sm-6"><span class="icon-con-wind"><img src="theme/images/datang/monitoringMap/wind-maintain.png" style="width:15px;"></span>维护</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >0</span><span class="font24">台</span></div>
                    </div>
                    <div class="col-sm-12  border-bottom-blue padding20 lineHeight2 grey">
                    	<div class="col-sm-6"><span class="icon-con-wind"><img src="theme/images/datang/monitoringMap/wind-offline.png" style="width:15px;"></span>离线</div>
                    	<div class="col-sm-6 font30 text-right padding-right40"><span >0</span><span class="font24">台</span></div>
                    </div>
                </div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<div class="map-footer">
		<div class="col-sm-12 clearfix" style="height:100%;">
			<div class="col-sm-4 no-padder footer-left border-right-blue" style="padding-top: 0.9rem !important;">
				<div class="col-sm-12 no-padder clearfix">
					<div class="col-sm-4 state-con-left"><i class="white"></i><span class="state-name">全部</span><span id="allStNum"></span></div>
					<div class="col-sm-4 state-con" style="color:rgb(255,74,36);"><i class="red"></i><span class="state-name">故障</span><span id="faultStNum"></span></div>
					<div class="col-sm-4 state-con-left"  style="color:rgb(139,139,139);" id="breakOff"><i class="grey"></i><span class="state-name">中断</span><span id="breakStNum"></span></div>
				</div>
				<div class="col-sm-12 no-padder clearfix">
					<div class="col-sm-4 state-con" style="color:rgb(32,208,58);"><i class="green"></i><span class="state-name">正常</span><span id="normalStNum"></span></div>
					<div class="col-sm-4 state-con" style="color:rgb(245,255,0);"><i class="yellow"></i><span class="state-name">报警</span><span id="alarmStNum"></span></div>
				</div>
			</div>
			<div class="col-sm-4 no-padder footer-center border-right-blue">
				<span id="stClassId0" class="state-con-left " ng-click="stationClassSelect('0' )"><i class="square"></i><span class="state-name">地面光伏</span></span>
				<span id="stClassId1" class="state-con " ng-click="stationClassSelect('1')"><i class="circle"></i><span class="state-name">分布式光伏</span></span>
				<span id="stClassId2" class="state-con " ng-click="stationClassSelect('2')"><i class="triangle-new"></i><span class="state-name">互用光伏</span></span>
				<span id="stClassId3" class="state-con " ng-click="stationClassSelect('3')"><i class="fan"></i><span class="state-name">风电</span></span>
			</div>
			<div class="col-sm-4 no-padder footer-right clearfix radiusMenu">
				<ul class="header">
					<li style="margin-left: 0;">
						<a ui-fullscreen="" class="" title="全屏模式"><i class="fa fa-expand text"> </i><i class="fa fa-compress text-active"> </i></a>
					</li>
					<li>
						<a class="ico-lockscreen" ng-click="lockMe();" title="锁屏"></a>
					</li>
					<li>
						<i class="ico_power"></i>
						<span class="label" data-toggle="modal" data-target="#switchPowerModal" style="margin-top: .2em;padding-bottom: .2em;display: inline-block;vertical-align: middle;">切换&gt;</span>
					</li>
					<li class="dropdown" dropdown>
						<a href class="dropdown-toggle clear" dropdown-toggle style="color:white;">
							<i class="ico_user"></i>
							<span class="" ng-bind="realName"></span>
							<b class="caret"></b>
						</a>
						<!-- dropdown -->
						<ul class="dropdown-menu animated fadeInRight w pull-right" style="bottom: -100%;top: initial;">
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
						<img src="theme/images/common/bell.png" ng-click="toBaseMessage()" title="消息库">
						<span class="badge badge-sm bg-danger pull-right-xs msg_center_num"></span>
					</li>				
				</ul>
			</div>
		</div>
		<div class="footer-trapezoid">
			<hr/>
			<div class="small-trapezoid"></div>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/powerStationManage.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>
<script type="text/javascript" src="${ctx}/vendor/echarts/china.js"></script>
<script type="text/javascript">
$(function(){
	//左右框竖直居中
	var wHeight = $(window).height();
	
	new Earth(); 
	function Earth() {
		var stage = new Clay.Stage(1000, 500);
		var world = stage.getWorld();
		var camera = stage.getCamera();
		
		camera.set(0,0,0);
		camera.setResolution(1000, 500);
		camera.setTarget(new Clay.Vector(-100, 0, 100));
		
		window.onresize = function() {
			stage.resizeTo(
				window.innerWidth || document.documentElement.clientWidth,
				window.innerHeight || document.documentElement.clientHeight
			);
		};
		window.onresize();
		Clay.Collada.load('${ctx}/vendor/static/collada/earth.xml', function(scene) {
			scene.init(stage);

			var earth = new Clay.Texture('${ctx}/vendor/static/collada/earthmap1k.jpg', stage);
			
			var clouds = new Image();
			clouds.src = '${ctx}/vendor/static/collada/earthclouds1k.png';

			var dark = new Image();
			dark.src = '${ctx}/vendor/static/collada/darkside.png';

			var waiting = setInterval(function(){
				if (earth.complete && clouds.complete && dark.complete){
					clearInterval(waiting);
					play();
				}
			}, 1000);

			function play() {
				var shape = world.getShapes()[0];
				shape.setMaterial(earth)

				var ttx = earth.canvas.getContext('2d');
				var base = earth.image;
				var wind = 0;

				stage.addEvent('enterframe', function(){

					var pos = (++wind)%1000;
					ttx.drawImage(base, pos, 0);
					ttx.drawImage(base, pos-1000, 0);
					ttx.drawImage(clouds, pos, 0);
					ttx.drawImage(clouds, pos-1000, 0);
					var windowW = $(window).width();
					if(windowW>=1920){
						camera.set(-75, 0, 55);
					}else{
						camera.set(-65, 0, 30);
					}
				});

				stage.run();
			}
		});
	}
});
//发光城市
var outlightMap = [
    {
		name: '台湾',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '海南',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '云南',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '西藏',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '新疆',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '内蒙古',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '黑龙江',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '吉林',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '辽宁',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '天津',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '山东',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '江苏',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '上海',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '浙江',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '福建',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}, {
		name: '广东',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)',
				border:'2px'
			}
		}
	}, {
		name: '广西',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	},
	{
		name: '南海诸岛',
		itemStyle: {
			normal: {
				borderColor:'rgb(0,211,255)'
			}
		}
	}
];

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

app.controller('dtMonitorCtrl', function($scope,$rootScope,$http, $state, $stateParams) {
	//测试
	var realtimeChart;	
	//默认显示首页tab
	$scope.activeTab = "index";
	$scope.changeTab = function(val){
		$scope.activeTab = val;
		if(val == "index"){
			getPowerV();
			$scope.stationClassSelectNew(1);
		}else if(val == "solar"){
			setOptionSolar();
			$scope.stationClassSelectNew(2);
		}else if(val == "wind"){
			setOptionWind();
			$scope.stationClassSelectNew(3);
		}
	}

	//光伏
	function setOptionSolar(){
		realtimeChart = echarts.init(document.getElementById('realtimeLineChart'));	
		window.addEventListener("resize", function() {
			realtimeChart.resize();
		});
		option = {
			tooltip : {
				trigger : 'axis',
		    },
		    legend : {
				left: 'center',
				bottom:'7',
				orient : 'horizontal',
				data : [ {icon: 'line',name:'预测功率',textStyle: {color: '#ff8439'}},
				         {icon: 'line',name:'实际功率',textStyle: {color: '#25ff2a'}},
				         {icon: 'line',name:'光照强度',textStyle: {color: 'rgb(240,173,78)'}}]
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '30px',
				x2 : '30px',
				y : "30px",
				y2 : "50px"
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
				data : [1,2,3,4,5,6]
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
			}, {
				name : 'W/㎡',
				splitNumber : 3,
				font : {
					color : '#bbb'
				},
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
			series : [{
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
				data : [120,20,80,40,100,80]
			}, {
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
				data :[80,40,100,120,20,80]
			},{
				type : 'line',
				name : '光照强度',
				symbol : 'none',
				smooth: true,
				yAxisIndex : 1,
				itemStyle : {
					normal : {
						color : 'rgb(240,173,78)',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : 'rgb(240,173,78)',
							width : 1
						}
					}
				},
				data : [8,2,34,57,12,39]
			}]
		};
		realtimeChart.setOption(option);
		
	}
	//风电
	function setOptionWind(){
		realtimeChart = echarts.init(document.getElementById('realtimeLineChart'));	
		window.addEventListener("resize", function() {
			realtimeChart.resize();
		});
		option = {
			tooltip : {
				trigger : 'axis',
		    },
		    legend : {
				left: 'center',
				bottom:'7',
				orient : 'horizontal',
				data : [ {icon: 'line',name:'预测功率',textStyle: {color: '#ff8439'}},
				         {icon: 'line',name:'实际功率',textStyle: {color: '#25ff2a'}},
				         {icon: 'line',name:'风速',textStyle: {color: 'rgb(240,173,78)'}}]
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '30px',
				x2 : '30px',
				y : "30px",
				y2 : "50px"
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
				data : [1,2,3,4,5,6]
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
			}, {
				name : 'm/s',
				splitNumber : 3,
				font : {
					color : '#bbb'
				},
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
			series : [{
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
				data : [120,20,80,40,100,80]
			}, {
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
				data :[80,40,100,120,20,80]
			},{
				type : 'line',
				name : '风速',
				symbol : 'none',
				smooth: true,
				yAxisIndex : 1,
				itemStyle : {
					normal : {
						color : 'rgb(240,173,78)',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : 'rgb(240,173,78)',
							width : 1
						}
					}
				},
				data : [8,2,34,57,12,39]
			}]
		};
		realtimeChart.setOption(option);
	}
	$rootScope.isGroup = 1;
	$rootScope.currentView = '00';
	
	$scope.$on("broadcastSwitchStation", function (event, msg) {
		/**$state.go("app.dashboard-v1", {
			dataType: msg.stFlag
		});*/
		$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
			dataType: msg.stFlag
		});
	});
	
	$rootScope.$on('$stateChangeStart',function(){
		$(".canvas3D").remove();
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
			/**if(clickStationClass == '01'){
				$state.go("app.dashboard-v1", {
					stationId : clickStationId
				});
			}else if(clickStationClass == '02'){
				$state.go("app.wpMonitoring", {
					stationId : clickStationId
				});
			}*/
			
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
	
	$scope.stationClassSelectNew = function (idx) {
		var op = myChart.getOption();
		if(idx == 1){
			op.legend[0].selected[staticClassMap[0]] = true;
			op.legend[0].selected[staticClassMap[1]] = true;
			op.legend[0].selected[staticClassMap[2]] = true;
			op.legend[0].selected[staticClassMap[3]] = true;
		}else if(idx == 2){
			op.legend[0].selected[staticClassMap[0]] = true;
			op.legend[0].selected[staticClassMap[1]] = true;
			op.legend[0].selected[staticClassMap[2]] = true;
			op.legend[0].selected[staticClassMap[3]] = false;
		}else if(idx == 3){
			op.legend[0].selected[staticClassMap[0]] = false;
			op.legend[0].selected[staticClassMap[1]] = false;
			op.legend[0].selected[staticClassMap[2]] = false;
			op.legend[0].selected[staticClassMap[3]] = true;
		}
		myChart.setOption(op ,true);
		
	}
	
	
	getPowerV();
	function getPowerV() {
		realtimeChart = echarts.init(document.getElementById('realtimeLineChart'));	
		window.addEventListener("resize", function() {
			realtimeChart.resize();
		});
		option = {
			tooltip : {
				trigger : 'axis',
		    },
		    legend : {
				left: 'center',
				bottom:'7',
				orient : 'horizontal',
				data : [ {icon: 'line',name:'预测功率',textStyle: {color: '#ff8439'}},
				         {icon: 'line',name:'实际功率',textStyle: {color: '#25ff2a'}}]
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '30px',
				x2 : '30px',
				y : "30px",
				y2 : "50px"
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
				data : [1,2,3,4,5,6]
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
			series : [{
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
				data : [120,20,80,40,100,80]
			}, {
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
				data :[80,40,100,120,20,80]
			}]
		};
		realtimeChart.setOption(option);
	}
});


function refreshMap(){
	$.ajax({
		type : "post",
		url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew2.htm",
		async : false,
		success : function(result) {
			//console.log(result);
				stationMap = new Map();
				stationClassMap = new Map();
				var op = myChart.getOption();
				if(result){
					console.log("-----")
					console.log(result)
					$("#normalStNum").html(result.normalNum);
					$("#faultStNum").html(result.faultNum);
					$("#alarmStNum").html(result.warnNum);
					$("#breakStNum").html(result.breakNum);
					
					$("#allStNum").html(result.normalNum + result.faultNum + result.warnNum + result.breakNum);
					
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
			zoom:0.9,
			label: {
			    normal: {
			        show: true,
			        textStyle: {
			            color: "#16e6ff",//省份颜色,
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
                    areaColor: 'rgba(0,0,0,0.5)',
                    borderColor: 'grey',
                },
                emphasis: {
                    areaColor: 'rgba(75,241,241,0.65)'
                }
            },
            regions: outlightMap
		},
		series : [
		          {
		              name: '地面光伏',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 8,
		              data:[
		                  
		              ]
		          },
		          {
		              name: '分布式光伏',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 8,
		              data:[]
		          },
		          {
		              name: '户用光伏',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 8,
		              data:[]
		          },
		          {
		              name: '风电',
		              type: 'scatter',
                      coordinateSystem: 'geo',
		              roam: false,
		              symbolSize: 15,
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
		},5000);
	}

	myChart.on('click', function(param) {
		if (stationMap.get(param.name) != null) {//点击电站显示弹出层
			clickMapArea(param, stationMap.get(param.name));
			
		} else {
		}
	});

	//双击跳转到电站界面
	myChart.on('dblclick', function(param) {
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
		}
	});
}
function closeMap() {
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

app.controller('oneStationMonitorCtrl', function($scope, $http, $state) {
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
			/**if(clickStationClass == '01'){
				$state.go("app.dashboard-v1", {
					stationId : clickStationId
				});
			}else if(clickStationClass == '02'){
				$state.go("app.wpMonitoring", {
					stationId : clickStationId
				});
			}*/
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

