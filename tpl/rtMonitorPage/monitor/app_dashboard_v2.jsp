<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#showMap {
	position: absolute;
	z-index: 2;
}
.modal-backdrop.in {
    opacity: 0;
    filter: alpha(opacity=0);
}
.modal-backdrop {
    z-index: 0;
}
</style>
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
				<span class="modal-title font-h3" id="myModalLabel"></span>
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

<div class="app-content-full-map"> 
	<div class="hbox hbox-auto-xs " ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;" ng-controller="companyMonitorCtrl">		
		<!-- column -->
		<div class="col" id="mapChart" style="overflow: hidden;">
			<div class="map-nav">
					<div class="col-sm-6 no-padder col-xs-12">
						<ul class="col-sm-12 m-n nav navbar-nav map-nav-ul line-50">
							<li class="hidden-xs  m-l-md m-r-md">
								<span ng-click="toNormalMonitorPage();" class="green-new">
								<i class="icon-layers m-r-xs"></i>切为普通模式</span></li>
							<li class="dropdown hidden-xs  green-panel" dropdown="">
								<span class="no-padder" ng-bind="companyName">
								<b class="caret"></b> </span> 
								<div class="dropdown-menu animated fadeInUp"style="margin-left: -1px">
									<div class="panel white-1">
										<div class="list-group">
											<a href="" ng-repeat="com in dataComAreaData"class="media list-group-item" ng-bind="com.label"></a>
										</div>
									</div>
								</div> <!-- / dropdown --></li>
							<li class="hidden-xs wrapper-xs changeCompanyDom"style="display: none;">
								<a class="no-padder"> - </a></li>
							<li class="dropdown bg-black wrapper-xs changeCompanyDom"style="display: none;" dropdown="">
								<span href=""class="no-padder dropdown-toggle font_white" dropdown-toggle=""aria-haspopup="true" aria-expanded="false"> <span
									ng-bind="selectCompanyName"></span><b class="caret"></b>
								</span> <!-- dropdown -->
								<div class="dropdown-menu w-xl animated fadeInUp bg-black font_white"style="margin: -2px 0px 0px -1px;">
									<div class="panel ">
										<!-- <div -->
										<!-- class="wrapper-sm m-n panel-heading  b-b bg-dropdown font_white"> -->
										<!-- <span>当前地区:<span ng-bind="selectCompanyChildName"></span></span> <a class="pull-right" href="#notes" -->
										<!-- data-toggle="class:show animated fadeInRight">x</a> -->
										<!-- </div> -->
										<div class="list-group">
											<div class="col-sm-12  wrapper-sm"
												ng-repeat="dist in districtData">
												<span class="pull-left col-sm-4 no-padder"
													ng-click="selectCom({{dist.id}},'{{dist.label}}')">{{dist.label}}
												</span> <span ng-show="{{dist.children!=null}}"
													class="col-sm-8 no-padder media-body block m-b-none text-left">
													<span ng-repeat="vo in dist.children" ng-bind="vo.label"
													ng-click="selectComChild({{vo.id}},'{{vo.label}}',{{dist.id}},'{{dist.label}}')"
													class="col-sm-4 no-padder"></span>
												</span>
											</div>
										</div>
									</div>
								</div> <!-- / dropdown --></li>
							
							<!-- <li class="m-l-md white-1 ">
									<i class="fa fa-calendar" class="m-r-xs"></i> 切换日 <b class="caret"></b>
								</li> -->
					 			<li class="dropdown bg-black-green hidden" dropdown style="height: 50px;">
						            <a href class="dropdown-toggle clear white-1" dropdown-toggle>
						           	  <i class="fa fa-calendar m-r-xs"></i>切换 <span ng-bind="changeTime"></span> <b class="caret"></b> 
						            </a>
						            <!-- dropdown -->
						            <ul class="dropdown-menu animated fadeInRight">
						           	 <li>
						                <a ng-click="changeDate('1')">切换日</a>
						              </li>
						              <li>
						                <a ng-click="changeDate('2')">切换月</a>
						              </li>
						              <li class="divider"></li>
						              <li>
						                <a ng-click="changeDate('3')">切换年</a>
						              </li>
						            </ul>
					            <!-- / dropdown -->
					          </li>
					           <li class="bg-black-green hidden" style="padding: 12px 20px 20px 0px; height: 50px;">
						          <a class="white-1 no-padder">
									<i class="fa fa-angle-left map-jt" class="m-r-xs" ng-click="dateLeft()"></i> 
										<span>
											<span id="changeTimeId1" class="m-l m-r  font-h2" ng-bind="mapTime| date:'yyyy-MM-dd'"></span> 
											 <span id="changeTimeId2" class="m-l m-r hidden font-h2" ng-bind="mapTimeMonth"></span> 
											<span id="changeTimeId3" class="m-l m-r  hidden font-h2" ng-bind="mapTimeYear"></span> 
										</span>
									<i class="fa fa-angle-right map-jt" class="m-r-xs" ng-click="dateRight()"></i> 
								   </a>
							   </li>
							</ul>
						</div>
						<div class="col-sm-6  pull-right hidden-xs"ng-controller="stationCtrl">
									<div class="inline m-r-md  text-center pull-right">
										<span class="m-b-xs m-n white-1 h3" ng-bind="dataInfoData.co2[0]"></span><span class="text-base"
										ng-bind="dataInfoData.co2[1]"></span>
										<div>
											<span class="text-base black-2">二氧化碳减排</span>
										</div>
									</div>
									<div class="inline m-r-md  text-center pull-right">
										<span class="m-b-xs m-n white-1 h3"
											ng-bind="dataInfoData.accumulateGeneratingPower[0]"></span> <span class="text-base"
											ng-bind="dataInfoData.accumulateGeneratingPower[1]"></span>
										<div>
											<span class="text-base black-2">累计发电量</span>
										</div>
									</div>
									<div class="inline m-r-md  text-center pull-right">
										<span class="m-b-xs m-n white-1 h3"
											ng-bind="dataInfoData.installedCapacity[0]"></span> <span
											class="text-base" ng-bind="dataInfoData.installedCapacity[1]"></span>
										<div>
											<span class="text-base black-2">总装机量</span>
										</div>
									</div>
									
									<div class="inline m-r-md  text-center pull-right">
										<span class="m-b-xs m-n white-1 h3"
											ng-bind="dataInfoData.powerStationNum"></span> <span
											class="text-base">个</span>
										<div>
											<span class="text-base black-2">电站数量</span>
										</div>
									</div>
									
								</div>
					</div>
			<div class="vbox">
				<div class="row-row">
					<div class="cell">
						<div class="cell-inner wrapper-md"
							style="overflow: hidden; padding-top: 0px">
							<div class="row">
								<div class="col-sm-12">
									<div id="commInterrupt" style="display: none;" class="alert alert-danger" role="alert">通讯中断故障！已中断<span ng-bind="dataInfoData.commInterruptTime"></span>，最后更新于<span ng-bind="dataInfoData.millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></div>
								</div>
								<div class="col-sm-12">
									<div id="mapdata" style="width: 100%; height: 800px">loading...</div>
								</div>
								<div id="mapBtn" class="hidden" ng-click="tiggerMapBtn()"><img src="theme/images/little_map.png"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /column -->
		<!-- column -->
		<div class="col w-md lter map-right">
			<div class="vbox">
				<div class="row-row">
					<div class="cell">
						<div class="cell-inner">
							<tabset class="nav-tabs-alt map-tab" justified="true"> <tab>
							<tab-heading>
								<span class="text-md ">数据信息</span> 
							</tab-heading> <!-- 数据信息开始 -->
							<div class="wrapper" ng-controller="dataInfo" style="border-top:1px solid rgba(0, 0, 0,.9)!important;">
								<div class="m-b-sm text-md">
									<ul class="list-group no-bg no-borders pull-in">
										<li class="list-group-item ">
											<p class="font-h2 white-1">实时功率</p>
											<p class="data-red font-h2 ">
												<span class="h2" ng-bind="dataInfoData.realTimePower[0]"></span><span
													ng-bind="dataInfoData.realTimePower[1]"></span>
											</p>
											<hr class="b-b-black line-xs">
										</li>
										<li class="list-group-item ">
											<p class="font-h2 white-1">日发电量</p>
											<p class="data-green font-h2">
												<span class="h2" ng-bind="dataInfoData.dayGeneratingPower[0]"></span> <span
													ng-bind="dataInfoData.dayGeneratingPower[1]"></span>
											</p>
											<hr class="b-b-black line-xs">
										</li>
										<li class="list-group-item ">
											<p class="font-h2 white-1">月累计发电量</p>
											<p class="data-blue font-h2">
												<span class="h2" ng-bind="dataInfoData.monthGeneratingPower[0]">-</span>
												<span ng-bind="dataInfoData.monthGeneratingPower[1]"></span>
											</p>
											<div class="col-sm-12 no-padder data-blue font-h2">
												<span class="">计划完成率</span> <span
													class="pull-right  font-h3"> <span
													ng-bind="dataInfoData.monthRate|number:1"></span>
													<span ng-show="dataInfoData.monthRate !=null" >%</span>
													<span ng-show="dataInfoData.monthRate ==null" >-</span>
												</span>
											</div>
											<div class="col-sm-12 no-padder progress-xxs m-t-sm  progress ng-isolate-scope"
												animate="true" type="primary">
												<div class="progress-bar progress-bar-info"
													role="progressbar" aria-valuemin="0" aria-valuemax="100"
													ng-style="{width:dataInfoData.mElecVProp+'%'}"></div>
											</div>
											<hr class="b-b-black col-sm-12 no-padder m-b-md line-xs">
										</li>
										<li class="list-group-item">
											<p class="font-h2 white-1">年累计发电量</p>
											<p class="data-yellow font-h2">
												<span class="h2" ng-bind="dataInfoData.yearGeneratingPower[0]"></span> <span
													ng-bind="dataInfoData.yearGeneratingPower[1]"></span>
											</p>
											<p class="data-blue font-h2">
											<div class="col-sm-12 no-padder">
												<span class="">计划完成率</span> <span
													class="pull-right  font-h3"> <span
													ng-bind="dataInfoData.yearRate|number:1"></span>
													<span ng-show="dataInfoData.yearRate !=null" >%</span>
													<span ng-show="dataInfoData.yearRate ==null" >-</span>
												</span>
											</div>
											<div
												class="col-sm-12 no-padder progress-xxs m-t-sm  progress ng-isolate-scope"
												animate="true" type="primary">
												<div class="progress-bar progress-bar-warning"
													role="progressbar" aria-valuemin="0" aria-valuemax="100"
													ng-style="{width:dataInfoData.yearRate+ '%'}"></div>
											</div>
											</p>
											<hr class="b-b-black col-sm-12 no-padder m-b-md line-xs">
										</li>
										<li class="list-group-item">
											<p class="font-h2 white-1">年发电小时数</p>
											<p class="data-orange font-h2">
												<span class="h2" ng-bind="dataInfoData.yearGeneratingPowerHour|number:1"></span>h
											</p>
											<hr class="b-b-black col-sm-12 no-padder  line-xs">
										</li>
										<li class="list-group-item">
											<p class="font-h2 white-1">故障台数</p>
											<p class="white-1 font-h2">
												<span class="h2" ng-bind="faultData"></span>台
											</p>
										</li>
									</ul>
								</div>
							</div>
							</tab> 
							<tab>
							 <tab-heading> 
								 <span class="text-md ">电站列表</span>
							 </tab-heading> <!-- 电站列表开始 -->
							<div ng-controller="powerListCtrl" class="col-sm-12 no-padder "  style="border-top:1px solid rgba(0, 0, 0,.9)!important;">
								<div class="wrapper col-sm-12 m-t" ng-repeat="power in powerData">
									<div class="m-b-sm text-md col-sm-12 no-padder">
										<p class="font-h3 a-cur-poi default-blue"
											ng-click="showStationMonitor(power.id);">
											<span ng-bind="power.name"></span>
										</p>
										<div class="no-padder col-sm-12 m-b-xs">
											<span>装机容量</span> <span class="font-h5 green-new pull-right"><span
												ng-bind="power.installedCapacity[0]">-</span><span
												ng-bind="power.installedCapacity[1]"></span></span>
										</div>
										<div class="no-padder col-sm-12 m-b-xs">
											<span>日发电量</span> <span class="font-h5 green-new pull-right"><span
												ng-bind="power.dw[0]">-</span><span
												ng-bind="power.dw[1]"></span></span>
										</div>
										<div class="no-padder col-sm-12 m-b-xs">
											<span>实时功率</span> <span class="font-h5 green-new pull-right"><span
												ng-bind="power.power[0]">-</span><span
												ng-bind="power.power[1]"></span></span>
										</div>
										<div class="no-padder col-sm-12 m-b-xs">
											<span class="col-sm-5 no-padder">出力</span> <span
												class="col-sm-5 no-padder">
												<div class="progress-xxs m-t-sm  progress ng-isolate-scope"
													animate="true" type="primary">
													<div class="progress-bar progress-green-new"
														role="progressbar" aria-valuemin="0" aria-valuemax="100"
														ng-style="{width: power.outputPowerRatio + '%'}"></div>
												</div>
											</span> <span class="col-sm-2 no-padder font-f2 green-new pull-right">
												<span class="pull-right"> <span
													ng-bind="power.outputPowerRatio[0]|number:1"></span>{{power.outputPowerRatio[1]}}
											</span>
											</span>
										</div>
										<hr class="b-b-black col-sm-12 no-padder  line-xs">
									</div>
								</div>
							</div>
							<!-- 电站列表结束 --> </tab> </tabset>

						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /column -->
	</div>
</div>
<script type="text/javascript">
	$("#mapdata").css("height",$(window).height()-50)
	$(".modal-backdrop").css("display","none")
	var stationIdMap = new Map();
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
	
	var mapTimer1;
	var timeTicket;
	
	var typeFlag;
	var doubleClick=false
	app.controller('companyMonitorCtrl', function($scope, $http, $state, $stateParams) {
		
		$scope.roleId = $stateParams.roleId;
		$scope.selectCompanyName = '全部';
		//获取当前用户
		$http.get("${ctx}/Login/getLoginUser.htm", {
			timeout : 5000
		}).success(function(result) {
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
			getNextLevelCompany(result.companyid, $http, $scope);
			refreshDatas($scope.selectCompanyId, $http, $scope);
			//统计数据
			getTotalData($scope.selectCompanyId, $http, $scope);
			//画地图
			drawMap($scope.selectCompanyId, $http, $scope,mt);
			mapTimer1 = setInterval(function() {
				refreshDatas($scope.selectCompanyId, $http, $scope);
			}, 5000);
			
		}).error(function(response) {
		});
		$scope.$on('$stateChangeStart', function(event) {
			$('.modal-backdrop').css("display","none");
			clearInterval(mapTimer1);
			clearInterval(timeTicket);
		})
		$scope.selectCom = function(comId, comName) {
			$scope.selectCompanyName = comName;
			$scope.selectCompanyId = comId;
			$scope.selectCompanyChildName = null;
			// 刷新数据
			refreshDatas(comId, $http, $scope);
			//统计数据
			getTotalData(comId, $http, $scope);
		};
		$scope.selectComChild = function(comId, comName, comParentId,
				comParentName) {
			$scope.selectCompanyChildName = comName;
			$scope.selectCompanyId = comId;
			$scope.selectCompanyName = comParentName;
			// 刷新数据
			refreshDatas(comId, $http, $scope);
			//统计数据
			getTotalData(comId, $http, $scope);
		};
		//进入电站监控
		$scope.showStationMonitor = function(id){
			
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
				params: {
				}
			}).success(function(res) {
				if(res.result){
					$http({
						method : "POST",
						url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
						params: {
							roleId : res.currentRole,
							stId : id,
							view : '00'
						}
					}).success(function(response) {
						if(response.result){
							$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
								stationId : id
							});
						}
						
					});
				}
				
			});
			
			
			
		}
		$scope.toNormalMonitorPage = function() {
			
			$state.go("power-index", {
				roleIdPowerToIndex: $scope.roleId
			});
			
		}
		
		$scope.tiggerMapBtn=function(){
			$("#mapBtn").addClass("hidden");
			doubleClick=true;
			drawMap($scope.companyId, $http, $scope,mt);
		}
		
		//根据日月年，切换日期
		$scope.changeTime="日";
		$scope.mapTime=new Date().getTime();
		$scope.mapTimeYear=new Date().getFullYear();
		$scope.mapTimeMonth1=new Date().getMonth()+1
		
		$scope.mapTimeMonth=new Date().getFullYear()+' -'+$scope.mapTimeMonth1;
		$scope.mapTimeMonthY=new Date().getFullYear();

		$scope.changeTimeId=1;
		
		$scope.changeDate=function(changeDateFlag){
			$scope.changeTimeId=changeDateFlag
			if(changeDateFlag=="1"){//日
				$scope.changeTime="日";
				$("#changeTimeId1").removeClass("hidden");
				$("#changeTimeId1").siblings().addClass("hidden");
			}else if(changeDateFlag=="2"){//月
				$scope.changeTime="月";
				$("#changeTimeId2").removeClass("hidden");
				$("#changeTimeId2").siblings().addClass("hidden");
			}else if(changeDateFlag=="3"){//年
				$scope.changeTime="年";
				$("#changeTimeId3").removeClass("hidden");
				$("#changeTimeId3").siblings().addClass("hidden");
			}
		}
		$scope.dateLeft=function(){
			if($scope.changeTimeId=="1"){//日
				$scope.mapTime=$scope.mapTime-1000*60*60*24;
			}else if($scope.changeTimeId=="2"){//月
				console.log($scope.mapTimeMonth1-1)
				if($scope.mapTimeMonth1-1<=0){
					$scope.mapTimeMonth1=$scope.mapTimeMonth1+11
					$scope.mapTimeMonthY=$scope.mapTimeMonthY-1
				}else{
					$scope.mapTimeMonth1=$scope.mapTimeMonth1-1;
				}
				$scope.mapTimeMonth=$scope.mapTimeMonthY+' -'+$scope.mapTimeMonth1;
			}else if($scope.changeTimeId=="3"){//年
				$scope.mapTimeYear=$scope.mapTimeYear-1

			}
		}
		$scope.dateRight=function(){
			if($scope.changeTimeId=="1"){//日
 				$scope.mapTime=$scope.mapTime+1000*60*60*24;
			}else if($scope.changeTimeId=="2"){//月
				if($scope.mapTimeMonth1+1>12){
					$scope.mapTimeMonth1=($scope.mapTimeMonth1+1)%12;
					$scope.mapTimeMonthY=$scope.mapTimeMonthY+1
				}else{
					$scope.mapTimeMonth1=$scope.mapTimeMonth1+1;
				}
				$scope.mapTimeMonth=$scope.mapTimeMonthY+' -'+$scope.mapTimeMonth1;
			}else if($scope.changeTimeId=="3"){//年
				$scope.mapTimeYear=$scope.mapTimeYear+1
			}
		}
	});
	//查询客户列表
	function getAllCustomer($http, $scope) {
		$http.get("${ctx}/AuthCompanyMonitor/getComAndArea.htm").success(
				function(response) {
					$scope.dataComAreaData = response;
				}).error(function(response) {
		});
	}
	//查询下级组织机构
	function getNextLevelCompany(companyId, $http, $scope) {
		$http.get("${ctx}/Company/getCompanyTreeNotIncludeSelf.htm", {
			params : {
				comId : companyId
			}
		}).success(function(response) {
			$scope.districtData = response;
			if (response != null && response.length > 0) {
				$(".changeCompanyDom").show();
			}
		}).error(function(response) {
		});
	}
	//刷新数据
	function refreshDatas(companyId, $http, $scope) {
		//数据信息
		getDataInfo(companyId, $http, $scope);
		//统计数据
		//getTotalData(companyId,$http, $scope);
		//电站列表
		getStationListData(companyId, $http, $scope);
	}
	
	function refreshMap(companyId, $http, $scope, option, mt){
		if (mt == 'china') {
			$http.get("${ctx}/AuthCompanyMonitor/getPowerStationStatusData.htm",
				{params : {companyId : companyId},
					timeout : 5000
				}).success(function(result) {
				if (result) {
					stationMap = new Map();
					stationDatas = result;
					for (var i = 0; i < stationDatas.length; i++) {
						var st = stationDatas[i];
						option.series[i].name = st.name;
						option.series[i].markPoint.data = st.data;
						if (st.data != null && st.data.length > 0) {
							for (var j = 0; j < st.data.length; j++) {
								var pst = st.data[j];
								stationMap.put(pst.name, pst.id);
							}
						}
						option.series[i].geoCoord = st.geoCoord;
					}
				}
			}).error(function(response) {
			});
		}
		return option;
	}
	function drawMap(companyId, $http, $scope,mt) {
		mt = 'china';
		if(doubleClick){
			curIndx = 0;
			//mt = 'china';
		/* 	for (var i = 0; i < option.series.length; i++) {
				option.series[i].mapType = mt;
			}
			myChart.setOption(option, true); */
			//return false;
		}
		
		// 路径配置
		require.config({
			paths : {
				echarts : 'vendor/echarts'
			}
		});
		// 使用
		require([ 'echarts', 'echarts/chart/map' // 使用柱状图就加载bar模块，按需加载
		], function(ec) {
			// 基于准备好的dom，初始化echarts图表
			var myChart = ec.init(document.getElementById('mapdata'));
			window.addEventListener("resize", function() {
				myChart.resize();
			});
			
			option = {
					//显示提示信息
				 tooltip : {
					 trigger : 'item', 
					 formatter: '{b}'
					},
				color : [ '#66f74b', '#ec432e','#f6fe39', '#cccccc' ],
				hoverable:false,
				legend : {
					textStyle:{
						color:'#fff'
					},
					//selectedMode : 'single',
					orient : 'vertical',
					x : 'right',
					/* data : [ { */
						/*  name:'正常',
		                icon : '${ctx}//images/validator/check_n.gif',
		                textStyle:{ color:'#66f74b'}
		           		 },'故障','报警', '中断' ] */
					data : [ '正常', '故障','报警', '中断' ] 
				},
				roamController : {
					show : true,
					x : 'right',
					y: 'bottom', 
				    fillerColor:'#06bebd',
				    handleColor:'rgba(0, 0, 0,0.3)',
					mapTypeControl : {
						'china' : true
					}
				},
				series : [ {
					name : '正常',
					type : 'map',
					mapType : mt,
					roam : 'scale',
					itemStyle : {
						normal : {
							label : {
								show : true,
								textStyle : {
									color : '#04B1B0'
								}
							},
							areaStyle : {
								color : 'rgba(4, 177, 176,0.07)'
							},
							borderColor : '#04B1B0'
						},
						emphasis : {
							areaStyle : {
								color : 'rgba(0, 0, 0,0.3)'

							},
							label : {
								show : true
							}
						}
					},
					data : [],
					markPoint : {
						symbol : 'Circle',
						symbolSize : 3,
						
						effect : {
							show : false,
							shadowBlur : 0
						},
						itemStyle : {
							normal : {
								color : '#66f74b',
								borderColor : '#66f74b',
								borderWidth : 1, // 标注边线线宽，单位px，默认为1
								label : {
									show : false
								}
							},
							emphasis : {
								color : '#66f74b',
								label : {
									show : false,
									position : 'top'
								}
							}
						},
						data : []
					},
					geoCoord : {}

				},

				{
					name : '故障',
					type : 'map',
					mapType : 'china',
					itemStyle : {
						normal : {
							label : {
								show : true
							}
						},
						emphasis : {
							label : {
								show : true
							}
						}
					},
					data : [],
					markPoint : {
						symbol : 'Circle',
						symbolSize : 3, // 标注大小，半宽（半径）参数，当图形为方向或菱形则总宽度为symbolSize * 2
						effect : {
							show : false,
							shadowBlur : 0
						},
						itemStyle : {
							normal : {
								color : '#ec432e',
								borderColor : '#ec432e',
								borderWidth : 1, // 标注边线线宽，单位px，默认为1
								label : {
									show : false
								}
							},
							emphasis : {
								color : '#ec432e',
								borderColor : '#ec432e',
								borderWidth : 5,
								label : {
									show : false
								}
							}
						},
						data : []
					},
					geoCoord : {}
				},
				{
					name : '报警',
					type : 'map',
					mapType : 'china',
					itemStyle : {
						normal : {
							label : {
								show : true
							}
						},
						emphasis : {
							label : {
								show : true
							}
						}
					},
					data : [],
					markPoint : {
						symbol : 'Circle',
						symbolSize : 3, // 标注大小，半宽（半径）参数，当图形为方向或菱形则总宽度为symbolSize * 2
						effect : {
							show : false,
							shadowBlur : 0
						},
						itemStyle : {
							normal : {
								color : '#f6fe39',
								borderColor : '#f6fe39',
								borderWidth : 1, // 标注边线线宽，单位px，默认为1
								label : {
									show : false
								}
							},
							emphasis : {
								color : '#f6fe39',
								borderColor : '#f6fe39',
								borderWidth : 5,
								label : {
									show : false
								}
							}
						},
						data : []
					},
					geoCoord : {}
				},{
					name : '中断',
					type : 'map',
					mapType : 'china',
					itemStyle : {
						normal : {
							label : {
								show : true
							}
						},
						emphasis : {
							label : {
								show : true
							}
						}
					},
					data : [],
					markPoint : {
						symbol : 'Circle',
						symbolSize : 3, // 标注大小，半宽（半径）参数，当图形为方向或菱形则总宽度为symbolSize * 2
						effect : {
							show : false,
							shadowBlur : 0
						},
						itemStyle : {
							normal : {
								color : '#cccccc',
								borderColor : '#cccccc',
								borderWidth : 1, // 标注边线线宽，单位px，默认为1
								label : {
									show : false
								}
							},
							emphasis : {
								color : '#cccccc',
								borderColor : '#cccccc',
								borderWidth : 5,
								label : {
									show : false
								}
							}
						},
						data : []
					},
					geoCoord : {}
				} ]
			};
			
			option = refreshMap(companyId, $http, $scope, option, mt);

			myChart.setOption(option, true);
			 
			// 为echarts对象加载数据 
			timeTicket = setInterval(function (){
				option = refreshMap(companyId, $http, $scope, option, mt);
			    myChart.setOption(option,true);
			},2000);
			
			var ecConfig = require('echarts/config');
			//点击事件，判断是点击点 还是点击区域
			
			//var zrEvent = require('zrender/tool/event');
			myChart.on(ecConfig.EVENT.CLICK, function(param) {
				//alert(param.event.type==ecConfig.EVENT.CLICK);
					if (stationMap.get(param.name) != null) {//点击电站显示弹出层
						clickMapArea(param, stationMap.get(param.name),ecConfig);
					} else {//返回全国
						/* console.log("返回哪里")
						curIndx = 0;
						mt = 'china'; */
					}
				for (var i = 0; i < option.series.length; i++) {
					option.series[i].mapType = mt;
				}
				//option.title.subtext = mt + ' （滚轮或点击切换）';
				myChart.setOption(option, true);
			});
			
			//双击跳转到电站界面
			myChart.on(ecConfig.EVENT.DBLCLICK, function(param) {

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
					$("#mapBtn").removeClass("hidden")
					} 
					for (var i = 0; i < option.series.length; i++) {
						option.series[i].mapType = mt;
					}
					myChart.setOption(option, true);
				}else if (mapType.indexOf(param.name) < 0){
				
					if(stationMap.get(param.name)){
						clickStationId = stationMap.get(param.name);
						$scope.showStationMonitor()
					}else{
						/* curIndx = 0;
						mt = 'china';
					 	for (var i = 0; i < option.series.length; i++) {
							option.series[i].mapType = mt;
						}
						myChart.setOption(option, true); */
					}
				}
			});
		});
	}
	function closeMap() {
		//$("#showMap").css("left", "-999px");
		$('#showMap').modal("hide");
		$("#upJt").css("display", "none");
		$("#downJt").css("display", "none");
	}
	var clickStationId = null;
	function clickMapArea(param, id, ecConfig) {
		var xPos, yPos;
		var e = param.event || window.event;
		xPos = e.clientX + document.body.scrollLeft
				+ document.documentElement.scrollLeft  - 150;
		yPos = e.clientY + document.body.scrollTop
				+ document.documentElement.scrollTop - 360;
		$.ajax({
					type : "post",
					url : "${ctx}/AuthCompanyMonitor/getPowerStationModalShowData.htm",
					data : {
						"id" : id
					},
					success : function(msg) {
						
						$("#myModalLabel").html(param.name);
						clickStationId = id;
						$("#stationModalImg").attr(
								"src",
								"${imgPath}/document/powerStationPicture/"
										+ msg.factPic);
						$("#stationTotalFault").html(msg.faultData.totalFault);
						$("#stationTotalFaultCountName0").html(
								msg.faultData.data[0].name);
						$("#stationTotalFaultCountValue0").html(
								msg.faultData.data[0].value);
						$("#stationTotalFaultCountName1").html(
								msg.faultData.data[1].name);
						$("#stationTotalFaultCountValue1").html(
								msg.faultData.data[1].value);

						$("#stationActPwr").html(msg.powerData.powerV+ msg.powerData.powerVUnit);
						$("#stationDayPower").html(msg.powerData.dElecV+ msg.powerData.dElecVUnit);
						$("#stationMonthPower").html(msg.powerData.mElecV+ msg.powerData.mElecVUnit);
						$("#stationYearPower").html(msg.powerData.yElecV+ msg.powerData.yElecVUnit);
						//判断状态
						if(msg.powerData.comm==1){
							$("#stationStatus").html("<span class='black-5'><i class='fa fa-circle m-r-xs'></i>通讯中断</span>")
						}else if(msg.powerData.comm==2){
							$("#stationStatus").html("<span class='black-5'><i class='fa fa-circle m-r-xs'></i>初始化</span>")
						}else{
							if(msg.powerData.status==1){//故障
								$("#stationStatus").html("<span class='map-red'><i class='fa fa-circle m-r-xs'></i>故障</span>")
							}else if(msg.powerData.status==2){//报警
								$("#stationStatus").html("<span class='map-yellow'><i class='fa fa-circle m-r-xs'></i>报警</span>")
							}else {//正常
								$("#stationStatus").html("<span class='map-green'><i class='fa fa-circle m-r-xs'></i>正常运行</span>")
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
	app.controller('oneStationMonitorCtrl', function($scope, $http, $state) {
		//进入电站监控
		$scope.showStationMonitor = function() {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
				params: {
				}
			}).success(function(res) {
				if(res.result){
					$http({
						method : "POST",
						url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
						params: {
							roleId : res.currentRole,
							stId : clickStationId,
							view : '00'
						}
					}).success(function(response) {
						if(response.result){
							$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
								stationId : clickStationId
							});
						}
						
					});
				}
				
			});
				
		}
	});
	//
	//电站列表
	app.controller('powerListCtrl', function($scope, $http) {

	});
	//统计信息
	app.controller('stationCtrl', function($scope, $http) {

	});

	//数据信息
	app.controller('dataInfo', function($scope, $http) {

	});
	//电站列表
	function getStationListData(comId, $http, $scope) {
		$http.get("${ctx}/homePage/powerStationListNew.htm", {
			timeout : 5000
		}).success(function(response) {
			$scope.powerData = response.devList;
		}).error(function(response) {
			// 				if(response==null){
			// 					promptObj('error','','请求电站列表数据超时!');
			// 				}else{
			// 					promptObj('error','','请求电站列表数据出错!');
			// 				}
		}); 
	}
	//统计信息
	function getTotalData(comId, $http, $scope) {
		var data = {};
		$http.get("${ctx}/homePage/faultAlarms.htm", {
			timeout : 5000
		}).success(function(response) {
			if(response.key == 1){
				data = response.data;
				$scope.faultData = parseInt(data.warn) + parseInt(data.fault) + parseInt(data.interrupt);
			}
		}).error(function(response) {
			// 				if(response==null){
			// 					promptObj('error','','请求装机容量等数据超时!');
			// 				}else{
			// 					promptObj('error','','请求装机容量等数据出错!');
			// 				}
		});
	}
	//数据信息
	function getDataInfo(comId, $http, $scope) {
		$http.get("${ctx}/MobileRtmDeviceMonitor/getRunTimeMonitor.htm", {
			timeout : 5000
		}).success(function(response) {
			$scope.dataInfoData = response;
			if($scope.dataInfoData.status==-9){
				//通讯中断
				$("#commInterrupt").show();
			}else{
				$("#commInterrupt").hide();
			}
		}).error(function(response) {
			// 				if(response==null){
			// 					promptObj('error','','请求发电量等数据超时!');
			// 				}else{
			// 					promptObj('error','','请求发电量等数据出错!');
			// 				}
		});
	}
	
</script>
