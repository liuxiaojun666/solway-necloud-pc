<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ctx}/theme/css/monitoringMap.css">
<style>
	.toggletick .ico-active-right {color: #22c1aa;visibility: hidden;}
	.toggletick.active .ico-active-right {visibility: visible;}
</style>
<div class="app-content-full-map">
	<div class="hbox hbox-auto-xs" ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;" ng-controller="companyMonitorCtrl">
		<div style="padding: 0;" class="hp">
			<!-- map -->
				<div class="hp">
					<div style="position: fixed;top: 50px;text-align: center;width: 100%;font-size: 30px;color: #74fffd;z-index: 2;">
						<span  ng-bind="headCenterTitle"></span>
					</div>
					<div class="hp" id="mapdata" style=""></div>
					<div id="minMapBtn" class="hidden cp" ng-click="tiggerMapBtn()"><img src="theme/images/little_map.png"></div>
					<div class="mapLegend">
						<ul class="list-inline" style="color: #fff;">
							<li><i class="glyphicon glyphicon-stop mr5"></i>地面电站</li>
							<li><i class="fa fa-circle mr5"></i>分布式电站</li>
							<li><i class="fa fa-play mr5" style="transform: rotate(30deg);vertical-align: middle;"></i><span class="triangle_block"></span>户用电站</li>
						</ul>
						<div class="stateBtns">
							<!-- <button ng-click="mapAllData()" ng-class="{'disable': isUnAll}" class="btn all">全部<span class="badge">123</span></button>
							<button ng-click="mapNormalData()" ng-class="{'disable': isUnNormal}" class="btn normal">正常<span class="badge">23</span></button>
							<button ng-click="mapFaultData()" ng-class="{'disable': isUnFault}" class="btn fault">故障<span class="badge">40</span></button>
							<button ng-click="mapAlarmData()" ng-class="{'disable': isUnAlarm}" class="btn alarm">报警<span class="badge">30</span></button>
							<button ng-click="mapBreakData()" ng-class="{'disable': isUnBreak}" class="btn break">中断<span class="badge">30</span></button>
							 -->
							<button ng-class="{'disable': isUnAll}"  class="btn all">全部<span class="badge" id="allStNum">-</span></button>
							<button ng-class="{'disable': isUnNormal}" class="btn normal">正常<span id="normalStNum" class="badge">-</span></button>
							<button ng-class="{'disable': isUnFault}" class="btn fault">故障<span id="faultStNum" class="badge">-</span></button>
							<button ng-class="{'disable': isUnAlarm}" class="btn alarm">报警<span id="alarmStNum" class="badge">-</span></button>
							<button ng-class="{'disable': isUnBreak}" class="btn break">中断<span id="breakStNum" class="badge">-</span></button>
						</div>
					</div>
				</div>
			<!-- map End -->
			<!-- left -->
				<div class="mapLeft pr">
					<div class="bdrs5 text-center noheightmiddle" style="background-color: rgba(40, 54, 60, .8);height: 9%;margin-bottom: 2%;">
						<div style="margin-top: -12px;">
							<img src="${imgPath}/{{currCompanyLogo | companyInfoFilter:'${currCompanyLogo}'}}" alt="" style="width: 30px;margin-top: -4px;margin-right: 20px;">
							<span class="font-h1"  ng-bind="currCompanyName | companyInfoFilter:'${currCompanyName}'"></span>
						</div>
					</div>
					<div class="data-bg-orange bdrs5 noheightmiddle" style="height: 16%;">
						<div style="margin-top: -34px;">
							<p class="h4 ico_poweNum">电站数量</p>
							<span ng-bind="MonitorData.powerStationNum|dataNullFilter" class="h2"></span>
							<p class="mt5">
								<span class="h4">总装机量</span>
								<span ng-bind="MonitorData.installedCapacity[0]|dataNullFilter"  class="h4"></span>
								<span ng-bind="MonitorData.installedCapacity[1]|dataNullFilter"></span>
							</p>
						</div>
					</div>
					<div class="data-bg-red bdrs5 p20" style="margin: 1% 0;height: 14%;">
						<div class="">
							<p class="h4">
								<img src="${ctx}/theme/images/solway/icon/blok1-gonglv@2x.png" width="20">
								实时功率
							</p>
							<div class="pr mt5">
								<span ng-bind="MonitorData.realTimePower[0]|dataNullFilter" class="h2"></span>{{MonitorData.realTimePower[1]|dataNullFilter}}
								<div class="pa" style="bottom: 0;right: 0;">
									<span ng-bind="MonitorData.outputPowerRatio|dataNullFilter"></span>%
								</div>
							</div>
						</div>
					</div>
					<div class="bolckPower clearfix" style="height: 33%;">
						<div class="data-bg-green bdrs5">
                            <p>日发电量</p>
                            <div class="text-center">
                                <span ng-bind="MonitorData.dayGeneratingPower[0]|dataNullFilter" class="h3"></span>{{MonitorData.dayGeneratingPower[1]}}
                                <div class="h4 mt5 h20">
                                    <span class="font16">¥</span><span ng-bind="MonitorData.dayGeneratingPowerIncome[0]|dataNullFilter"></span>
                                    <span ng-bind="MonitorData.dayGeneratingPowerIncome[1]|dataNullFilter"></span>
                                </div>
                            </div>
						</div>
						<div class="month_bg bdrs5">
								<p>月累计发电量</p>
								<div class="text-center">
									<span ng-bind="MonitorData.monthGeneratingPower[0]|dataNullFilter|dataNullFilter" class="h3"></span>{{MonitorData.monthGeneratingPower[1]|dataNullFilter|dataNullFilter}}
									<div class="h4 mt5 h20">
                                        <span class="font16">¥</span><span ng-bind="MonitorData.monthGeneratingPowerIncome[0]|dataNullFilter"></span>
										<span ng-bind="MonitorData.monthGeneratingPowerIncome[1]|dataNullFilter"></span>
									</div>
								</div>
							</div>
							<!-- <span class="rightbottom">{{MonitorData.monthGeneratingPowerHour|dataNullFilter}}h</span> -->
						<br>
						<div class="year_bg bdrs5">
								<p>年累计发电量</p>
								<div class="text-center">
									<span ng-bind="MonitorData.yearGeneratingPower[0]|dataNullFilter" class="h3"></span>{{MonitorData.yearGeneratingPower[1]|dataNullFilter}}
									<div class="h4 mt5 h20">
                                        <span class="font16">¥</span><span ng-bind="MonitorData.yearGeneratingPowerIncome[0]|dataNullFilter"></span>
										<span ng-bind="MonitorData.yearGeneratingPowerIncome[1]|dataNullFilter"></span>
									</div>
								</div>
							<!-- <span class="rightbottom">{{yearGeneratingPowerHour|dataNullFilter}}h</span> -->
						</div>
						<div class="total_bg bdrs5">
								<p>累计发电量</p>
								<div class="text-center">
									<span ng-bind="MonitorData.accumulateGeneratingPower[0]|dataNullFilter" class="h3"></span>{{MonitorData.accumulateGeneratingPower[1]|dataNullFilter}}
									<div class="h4 mt5 h20">
                                        <span class="font16">¥</span><span ng-bind="MonitorData.accumulateGeneratingPowerIncome[0]|dataNullFilter"></span>
										<span ng-bind="MonitorData.accumulateGeneratingPowerIncome[1]|dataNullFilter"></span>
									</div>
								</div>
							<!-- <span class="rightbottom">{{accumulateGeneratingPowerHour}}</span> -->
						</div>
					</div>
					<div class="jianpai_bg bdrs5 h4 noheightmiddle" style="margin: 1% 0;height: 13%;">
						<div style="margin-top: -28px;">
							<p>碳累计减排</p>
							<div class="pr mt5 text-center">
								<span ng-bind="MonitorData.co2[0]|dataNullFilter" class="h2"></span>{{MonitorData.co2[1]|dataNullFilter}}
							</div>
						</div>
					</div>
					<div class="zhishu_bg bdrs5 h4 noheightmiddle" style="margin: 1% 0;height: 13%;">
						<div style="margin-top: -28px;">
							<p>植树</p>
							<div class="pr mt5 text-center" style="white-space: nowrap;">
								<span ng-bind="MonitorData.plantedTree|dataNullFilter" class="h2"></span>棵
							</div>
						</div>
					</div>
				</div>
			<!-- left End -->
			<!-- header -->
				<ul class="header list-inline">
					<li>
						<a ui-fullscreen></a>
					</li>
					<li>
						<a class="ico-lockscreen" ng-click="lockMe();" title="锁屏"></a>
					</li>
					<li>
						<i class="ico_power"></i>
						<span class="label" data-toggle="modal" data-target="#switchPowerModal" style="margin-top: .2em;padding-bottom: .2em;display: inline-block;vertical-align: middle;">切换></span>
					</li>
					<li class="dropdown" dropdown>
						<a href class="dropdown-toggle clear" dropdown-toggle>
							<i class="ico_user"></i>
							<span class="" ng-bind="realName"></span>
							<!-- <span data-currentRole="currentRoleID" ng-bind="currentRoleName"></span> -->
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
								<!-- <a ng-click="powerStationManage()"><i class="ico-family ico-null">&#xe604;</i>电站组管理</a> -->
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
			<!-- header End -->
			<!-- radiusMenu -->
				<ul class="radiusMenu">
					<li ng-click="toBaseMessage()" class="default-blue-bg">
						<span class="badge badge-sm bg-danger pull-right-xs msg_center_num"></span>
					</li>
					<!--<li ng-click="toKnowledge()"></li>
					 <li ng-click="toMonitoring()"></li>
					<li ng-click="toIncomeSettlement()"></li>
					<li ng-click="toAnalyze()"></li>
					<li ng-click="toPowerStationView()"></li> -->
				</ul>
			<!-- radiusMenu End -->
		</div>
		
		<div class="modal fade" id="hasComInvite" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		   <div class="modal-dialog row">
		      <div class="modal-content ">
		<div class="modal-body wrapper-lg">
		<div class="row">
		    <div class="col-sm-12">
		            <h4 class="m-t-none m-b font-thin" style="color:#000" >有公司邀请您加入，是否前往消息中心处理？</h4>
		            <div class="form-group">
		            <div class="col-lg-offset-2 col-lg-10">   
		                <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
		                 <button type="button" ng-click="toBaseMessage()" id="saveUserInformationButton" class="pull-right btn m-b-xs w-xs btn-info"><strong>确定</strong></button>
		   			 </div>
		   			 </div>
		    </div>
		  </div>
		</div>
		</div>
		</div>
		</div>	

	</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/powerStationManage.jsp'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>

<!--<script src="vendor/echarts/echarts3.js"></script>
<script src="vendor/echarts/china-min.js"></script> 
<script src="vendor/echarts/china-min.js"></script>-->
<script>
	//发光城市
	var outlightMap = [
	    {
			name: '台湾',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .8)",
					shadowBlur: 35,
					shadowOffsetX: 0,
					shadowOffsetY: 0,
				},
				emphasis: {
					areaColor: '#2a333d',
					color: '#2a333d'
				}
			}
		}, {
			name: '海南',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .8)",
					shadowBlur: 30,
					shadowOffsetX: 0,
					shadowOffsetY: 2,
				}
			}
		}, {
			name: '云南',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: -5,
					shadowOffsetY: 10,
				}
			}
		}, {
			name: '西藏',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: -8,
					shadowOffsetY: 10,
				}
			}
		}, {
			name: '新疆',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 50,
					shadowOffsetX: -6,
					shadowOffsetY: -8,
				}
			}
		}, {
			name: '内蒙古',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 30,
					shadowOffsetX: -10,
					shadowOffsetY: -10,
				}
			}
		}, {
			name: '黑龙江',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: -5,
				}
			}
		}, {
			name: '吉林',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 2,
				}
			}
		}, {
			name: '辽宁',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .6)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 5,
				}
			}
		}, {
			name: '天津',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .8)",
					shadowBlur: 50,
					shadowOffsetX: 20,
					shadowOffsetY: -2,
				}
			}
		}, {
			name: '山东',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 0,
				}
			}
		}, {
			name: '江苏',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 0,
				}
			}
		}, {
			name: '上海',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 0,
				}
			}
		}, {
			name: '浙江',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 0,
				}
			}
		}, {
			name: '福建',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 10,
					shadowOffsetY: 3,
				}
			}
		}, {
			name: '广东',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 0,
					shadowOffsetY: 10,
				}
			}
		}, {
			name: '广西',
			itemStyle: {
				normal: {
					shadowColor: "rgba(28, 175, 154, .5)",
					shadowBlur: 40,
					shadowOffsetX: 0,
					shadowOffsetY: 10,
				}
			}
		}
	];
	
	function formatMapData(PartObj) {
		var arrData = []
		for (var j = 0; j < PartObj.data.length; j++) {
			var powerName = PartObj.data[j].name;
			var obj = {
				name: powerName,
				id: PartObj.data[j].id,
				value: PartObj.data[j].value
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
	
	app.controller('companyMonitorCtrl', function($scope,$rootScope,$http, $state, $stateParams) {
		
		$rootScope.isGroup = 1;
		$rootScope.currentView = '00';
		
		$scope.$on("broadcastSwitchStation", function (event, msg) {
			$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
				dataType: msg.stFlag
			},{reload: true});
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
		$scope.toKnowledge = function () {
			$state.go('app.knowledge');
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
					console.log(hasComInvite + "=========hasComInvite")
					console.log(res)
					if(res && res.code == 1 && res.data.length > 0){
						$('#hasComInvite').modal('show');
					}
				});
			}
			
		}
		
		$scope.hasCompanysInvite();
		
	});
	function refreshMap(){
			$.ajax({
				type : "post",
				url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew.htm",
				async : false,
				success : function(result) {
						stationMap = new MapDef();
						stationClassMap = new MapDef();
						var sumStNum = 0;
						var normalStNum = 0;
						var faultStNum = 0;
						var warnStNum = 0;
						var breakStNum = 0;
						var op = myChart.getOption();
						for (var i = 0; i < result.length; i++) {
							var st = result[i];
							if(st){
								if (st.data != null && st.data.length > 0) {
									for (var j = 0; j < st.data.length; j++) {
										var pst = st.data[j];
										stationMap.put(pst.name, pst.id);
										stationClassMap.put(pst.id, pst.stClass);
									}
								}
								sumStNum += st.sum;
								
								if(i <= 2 || i == 12){
									normalStNum += st.sum;
								}else if((i > 2 && i <= 5) || ( i == 13)){
									faultStNum += st.sum;
								}else if(i > 5 && i <= 8){
									warnStNum += st.sum;
								}else if((i > 8 && i <= 11 ) || ( i == 14)){
									breakStNum += st.sum;
								}
								$("#normalStNum").html(normalStNum);
								$("#faultStNum").html(faultStNum);
								$("#alarmStNum").html(warnStNum);
								$("#breakStNum").html(breakStNum);
								
								$("#allStNum").html(sumStNum);
								
								op.series[i].data = formatMapData(result[i]);
								
							}
							
						}
						myChart.setOption(op,true);
				}
			
		});
		//return option;
	};
	var myChart;
	function drawMap(companyId, $http, $scope,mt, oMapData) {
		// 基于准备好的dom，初始化echarts图表
		myChart = echarts.init(document.getElementById('mapdata'));
		/* if(navigator.userAgent.indexOf("Firefox")>0){
			alert("火狐初始化")
			$("#mapdata").height(window.innerHeight);
			$(myChart._dom).height(window.innerHeight);
			alert($("#mapdata").height())
		} */
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
		    //backgroundColor: '#0e0f11',
			title: {
				// text: '国开新能源集中监控系统',
				left: 'center',
				top: '50px',
				textStyle: {
					color: '#74fffd',
					fontWeight: 'normal',
					fontSize: '24'
				}
			},
			tooltip : {
				trigger: 'item',
				formatter: '{b}'
			},
			/*legend: {
				orient: 'vertical',
				y: 'bottom',
				x:'right',
				data:['pm2.5'],
				textStyle: {
					color: '#fff'
				}
			},*/
			geo: {
				map: mt,
				roam: true,
				label: {
				    normal: {
				        show: true,
				        textStyle: {
				            color: "#04B1B0"//省份颜色
				        }
				    }
				},
				itemStyle: {
		            normal: {
		                areaColor: '#1b2839',//地图区域颜色
		                borderColor: '#1caf9a'//地图描边颜色
		            },
		            emphasis: {
		                areaColor: '#1c2b36'
		            }
		        },
				regions: outlightMap
			},
			series : [
				{
					name: '正常',
					type: 'scatter',
					coordinateSystem: 'geo',
					label: {
						normal: {
							show: false,
							textStyle: {
								color: '#04B1B0',//数据点字的颜色
							}
						}
					},
					itemStyle: {
						normal: {
							//areaColor: "#1b2839",//地图区域颜色
							//borderColor: '#04B1B0',
							color: '#24d934',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'rect',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '正常',
					type: 'scatter',
					coordinateSystem: 'geo',
					label: {
						normal: {
							show: false,
							textStyle: {
								color: '#04B1B0',//数据点字的颜色
							}
						}
					},
					itemStyle: {
						normal: {
							color: '#24d934',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'circle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '正常',
					type: 'scatter',
					coordinateSystem: 'geo',
					label: {
						normal: {
							show: false,
							textStyle: {
								color: '#04B1B0',//数据点字的颜色
							}
						}
					},
					itemStyle: {
						normal: {
							color: '#24d934',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'triangle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '报警',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(236, 67, 46)',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'rect',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '报警',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(236, 67, 46)',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'circle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '报警',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(236, 67, 46)',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'triangle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '故障',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(246, 254, 57)',
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'rect',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '故障',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(246, 254, 57)',
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'circle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '故障',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(246, 254, 57)',
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'triangle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '中断',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(204, 204, 204)',
							shadowColor: 'rgba(204, 204, 204, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'rect',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '中断',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(204, 204, 204)',
							shadowColor: 'rgba(204, 204, 204, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'circle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '中断',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(204, 204, 204)',
							shadowColor: 'rgba(204, 204, 204, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'triangle',
		            symbolSize: 8,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '正常',
					type: 'scatter',
					coordinateSystem: 'geo',
					label: {
						normal: {
							show: false,
							textStyle: {
								color: '#04B1B0',//数据点字的颜色
							}
						}
					},
					itemStyle: {
						normal: {
							//areaColor: "#1b2839",//地图区域颜色
							//borderColor: '#04B1B0',
							color: '#24d934',//点的颜色
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'image://theme/images/WindTurbine_DJ.gif',
		            symbolSize: 15,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '故障',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(246, 254, 57)',
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'image://theme/images/WindTurbine_TJ.gif',
		            symbolSize: 15,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '报警',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(246, 254, 57)',
							shadowColor: 'rgba(156, 74, 60, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'image://theme/images/WindTurbine_TJ.gif',
		            symbolSize: 15,
		            hoverAnimation: true,
					data: []
				},
				{
					name: '中断',
					type: 'scatter',
		            coordinateSystem: 'geo',
					itemStyle: {
						normal: {
							color: 'rgb(204, 204, 204)',
							shadowColor: 'rgba(204, 204, 204, .5)',
							shadowBlur: 20
						}
					},
					symbol: 'image://theme/images/WindTurbine_TXZD.gif',
		            symbolSize: 15,
		            hoverAnimation: true,
					data: []
				}
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
