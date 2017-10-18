<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="monitoringListCtrl">
	<input type="hidden" id="stationId" value="123">
	<div class="hbox hbox-auto-xs hbox-auto-sm"
		ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;">
		<!-- main -->
		<div class="col">
			<!-- main header -->
			<!-- 顶部标题开始 -->
			<div class="bg-light lter b-b" id="head-title" style="padding:15px 0px">
				<div class="row">
					<div class="col-sm-6 col-xs-12 ">
						<span class="href-blur col-sm-12 no-padder text-muted ">
							<ul class="col-sm-12 m-n nav navbar-nav">
								<li class="m-l-md">
									<span class="font-h2 blue-1  text-black" ng-bind="companyName"></span>
								</li>
								<li class="m-t-xs m-l-xs">
									<span class="font-h5 blue-1 text-black" ng-bind="showCompanyName"></span>
								</li>
							</ul>
						</span>
							<span class="href-blur col-sm-12 no-padder text-muted ">
							<ul class="col-sm-12 m-n nav navbar-nav">
								<li class="m-t-xs m-l-md">
									<span ng-click="toMapMonitorPage();">
											<i class="icon-layers m-r-xs"></i>切为地图模式
									</span>
								</li>
								<li class="dropdown m-t-xs m-l-md" dropdown="">
									<span href="" class="no-padder dropdown-toggle"
									dropdown-toggle="" aria-haspopup="true" aria-expanded="false">
									 <span ng-bind="selectCompanyName"></span>
								 <b class="caret"></b>
								</span> <!-- dropdown -->
								<ul class="dropdown-menu" role="menu">
					              <li ng-click="selectCom({{dist.id}},'{{dist.label}}')" ng-repeat="dist in districtData">
					              	<a  >{{dist.label}}</a>
					              </li>
					            </ul>
							</ul>
						</span>
					</div>
					<div class="col-sm-6 text-right hidden-xs">
						<div class="inline m-r text-left">
							<span class="m-b-xs m-n black-1 h3"
								ng-bind="stationData.stationCount"></span> <span
								class="text-base">个</span>
							<div>
								<span class="text-base balck-2">电站数量</span>
							</div>
						</div>
						<div class="inline m-r text-left">
							<span class="m-b-xs m-n black-1 h3"
								ng-bind="stationData.installedTotle"></span> <span
								class="text-base">MW</span>
							<div>
								<span class="text-base balck-2">总装机量</span>
							</div>
						</div>
						<div class="inline m-r text-left">
							<span class="m-b-xs m-n black-1 h3"
								ng-bind="stationData.capacity"></span> <span class="text-base">mWh</span>
							<div>
								<span class="text-base balck-2">累计发电量</span>
							</div>
						</div>
						<div class="inline m-r text-left">
							<span class="m-b-xs m-n black-1 h3" ng-bind="stationData.co2"></span>
							<span class="text-base">t</span>
							<div>
								<span class="text-base balck-2">二氧化碳减排</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 顶部标题结束 -->
			<!-- / main header -->
			<div style="padding: 10px 20px 10px 15px;">
				<!-- 第一排开始 -->
				<div class="row" id="first-div">
					<div class="col-md-4">
						<div class="row row-sm text-center">
							<div class="col-xs-6">
								<div class="panel  item" style="height:80px;padding-top:5px;">
									<div class="font-big-32 text-info font-thin data-red">
										<span ng-bind="dataInfoData.powerV"></span>
										<small><span ng-bind="dataInfoData.powerVUnit"></span></small>
									</div>
									<span class="text-muted">实时功率</span>
									<div class="top text-right w-full">
										<span class="font-h4 grey text-warning m-r-sm"
											ng-bind="dataInfoData.powerVProp+' %'">0%</span>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div href="" class="block panel  bg-green-94 item"
									style="height:80px;padding-top:5px;"> <span
									class="text-white font-thin font-big-32 block"> <span
										ng-bind="dataInfoData.dElecV"></span> <small><span
										ng-bind="dataInfoData.dElecVUnit">kw</span></small>
								</span> <span class="text-white">日发电量</span>
								</div>
							</div>
							<div class="col-xs-6">
								<div  class="block panel  bg-blue-new item"
									style="height: 80px;padding-top:5px;">
									<span class="text-white font-thin font-big-32 block"> <span
										ng-bind="dataInfoData.mElecV">
									</span> 
									<small>
										<span ng-bind="powerData.mElecVUnit"></span>
										</small>
								</span> <span class="text-white">月发电量</span>
									<div class="top text-right w-full">
										<span class="font-h4 text-white m-r-sm"
											ng-bind="dataInfoData.mElecVProp + '%'">60%</span>
									</div>
								</div>
							</div>
							<div class="col-xs-6">
								<div class="panel  item" style="height:80px;padding-top:5px;">
									<div class="font-thin font-big-32 data-yellow">
										<span ng-bind="dataInfoData.yElecV"></span> <small><span
											ng-bind="dataInfoData.yElecVUnit"></span></small>
									</div>
									<span class="grey">年发电量</span>
									<div class="top text-right w-full">
										<!-- <i class="fa fa-caret-down text-warning m-r-sm"></i> -->
										<span class="font-h4 grey text-warning m-r-sm"
											ng-bind="dataInfoData.yElecVProp + '%'"></span>
									</div>
								</div>
							</div>
							<div class="col-xs-12 m-b-md" style="height:80px;">
								<div class="r bg-light dker item hbox no-border">
									<div class="col w-xs v-middle hidden-md">
										<img src="${ctx}/theme/images/solway/icon-clock.png" />
									</div>
									<div class="col dk  r-r">
										<div class="plure-new font-thin font-big-34">
											<span ng-bind="dataInfoData.elecHours"></span>
											<small>h</small>
										</div>
										<span class="text-xs grey">年发电小时数</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<div class=" row-sm panel wrapper">
							<div id="ssglqx" style="height: 237px;"></div>
						</div>
					</div>
				</div>
				<!-- 第一排结束 -->
				<!-- 第二排开始 -->
				<div class="row row-sm" id="second-div" style="margin-right: -13px;">
					<div class="col-sm-12">
						<div class="col-sm-12  m-n panel wrapper nav-tabs-alt ng-isolate-scope">
							<ul class="col-sm-12  nav nav-tabs" style="height: 40px;">
								<li >
									<span class="areaActive" style="border-bottom-color: transparent !important;">电站列表</span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<i class="fa fa-circle black-4 m-r-xs m-l"></i>
									<span class="black-4">停机</span>
									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.stopCount" ></span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<i class="fa fa-circle m-r-xs data-red  m-l"></i>
									<span class="black-4">故障</span>
									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.faultCount"></span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<img class="m-t-n-xs" src="./theme/images/solway/icon/icon_loser.png">
									<span class="black-4">发电效率最差</span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<img class="m-t-n-xs" src="./theme/images/solway/icon/icon_winner.png">
									<span class="black-4">发电效率最优</span>
								</li>
							</ul>
							<!-- table开始 -->
						<div class="col-sm-12 no-padder panel b-t m-t-n-xs" >
							<table class="table table-striped  b-light">
							<thead >
								<tr>
								<th class="text-center"></th>
								<th class="text-center">电站名称</th>
								<th class="text-center">负责人/电话</th>
								<th class="text-center" >发电效率</th>
								<th class="text-center">装机容量</th>
								<th class="text-center">实时功率</th>
								<th class="text-center">日发电量</th>
								<th class="text-center">月累计发电量</th>
								<th class="text-center">年累计发电量</th>
								</tr>
							</thead>
							<tbody >
								<tr ng-repeat="power in powerData">
									<td style="width:20%" class="font-bold  font-h4 a-cur-poi">
										<span  ng-if="power.status=='02'">
											<i class="font-h6 fa fa-circle data-red "></i>
										</span>
										<span  ng-if="power.status=='03'">
											<i class="font-h6 fa fa-circle black-4 "></i>
										</span>
										<span  ng-if="power.status=='00'">
											<i class="font-h6 fa fa-circle m-r-xs white-1"></i>
										</span>
										<img ng-if="power.best==1" class="m-t-n-xs" src="./theme/images/solway/icon/icon_winner.png">
										<img ng-if="power.worst==1" class="m-t-n-xs" src="./theme/images/solway/icon/icon_loser.png">
										<span class="m-l" ng-bind="power.factName" ng-click="showStationMonitor(power.stationId);"></span>
									</td>
									<td style="width: 14%" class="font-h4 black-2" >
									<span ng-bind="power.STATION_STATUS_NORMAL_FAULT"></span>
										<span ng-bind="power.managerName"></span>
										<div ng-bind="power.managerTel"></div>
									</td>
									<td style="width:9%" class="font-h2 black-2"
										ng-bind="power.elecV+'%'"></span></td>
									<td style="width:9%" class="font-h2 black-2"
										ng-bind="power.buildCapacity+power.buildCapacityUnit"></span></td>
									<td style="width:9%" class="font-h2 black-2"
										ng-bind="power.powerV+power.powerVUnit"></span></td>
									<td style="width:9%" class="font-h2 black-2">
										<span ng-bind="power.dElecV+power.dElecVUnit"></span>
									</td>
									<td style="width: 15%">
										<div class="font-h4 text-center" ng-bind="power.mElecV+power.mElecVUnit"></div>
										<span class="font-h6 blue-2">计划达成率</span>
										 <span class="pull-right" ng-bind="power.mElecVProp+'%'"></span>
										<div class="col-sm-12  m-b-none no-padder  progress-xxs  progress ng-isolate-scope"
											animate="true" type="primary">
											<div class=" progress-bar progress-bar-info"
												ng-class="type &amp;&amp; 'progress-bar-' + type"
												role="progressbar" aria-valuemin="0" aria-valuemax="100"
												ng-style="{width: power.mElecVProp + '%'}" ></div>
										</div>
									</td>
									<td style="width: 15%">
										<div class="font-h2 text-center" ng-bind="power.yElecV+power.yElecVUnit"></div>
										<span class="font-h6 blue-2">计划达成率</span>
										 <span class="pull-right"ng-bind="power.yElecVRatio+'%'"></span>
										<div class="col-sm-12 m-b-none no-padder  progress-xxs  progress ng-isolate-scope"
											animate="true" type="primary" >
											<div class="progress-bar progress-bar-warning"
												ng-class="type &amp;&amp; 'progress-bar-' + type"
												role="progressbar" aria-valuemin="0" aria-valuemax="100"
												ng-style="{width: power.yElecVRatio + '%'}" ></div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- table结束 -->
				</div>
				<!-- 第二排结束 -->
						</div>
					</div>
			</div>
			</div>
<script>
	//年发电小时数
	getScore();
	function getScore() {
		var scopeStr = {
			"totle" : '75', //总数
			"scope" : '优', //评比
			"ranking" : '60%'//击败
		}
		require([ 'echarts', 'echarts/chart/pie' ], function(ec) {
			var myChart = ec.init(document.getElementById('elecHours'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			var labelFromatter = {
				normal : {
					label : {
						formatter : function(params) {
							return 100 - params.value + '%'
						},
						textStyle : {
							baseline : 'top'
						}
					}
				},
			}
			var labelTop = {
				normal : {
					color : '#6fbb1b',
					label : {
						show : true,
						position : 'center',
						formatter : '{b}',
						textStyle : {
							fontSize : '20',
							color : '#1e3e50',
							baseline : 'top'
						}
					},
					labelLine : {
						show : false
					}
				}
			};
			var labelBottom = {
				normal : {
					color : '#ccc',
					label : {
						show : true,
						position : 'center',
						formatter : scopeStr.totle,
						textStyle : {
							fontSize : '36',
							color : '#6fbb1b',
							baseline : 'bottom'
						}
					},
					labelLine : {
						show : false
					}
				},
				emphasis : {
					color : 'rgba(0,0,0,0)'
				}
			};
			var radius = [ '80%', '83%' ];
			option = {
				series : [ {
					type : 'pie',
					center : [ '50%', '50%' ],
					radius : radius,
					x : '0%', // for funnel
					itemStyle : labelFromatter,
					data : [ {
						name : 'other',
						value : 100 - scopeStr.totle,
						itemStyle : labelBottom
					}, {
						name : '优',
						value : scopeStr.totle,
						itemStyle : labelTop
					} ]
				} ]
			};

			myChart.setOption(option);
		});
	}
</script>

<script>
//
//电站列表
app.controller('monitoringListCtrl',function($scope, $http, $state,$stateParams) {
	$http.get("${ctx}/Login/getLoginUser.htm").success(function(result) {
		//查询组织机构树
		//getCompanyTree(result.companyid, $http, $scope);
		$scope.selectCompanyName = "切换地区";
		$scope.companyName = result.companyName;
		if($stateParams.comId){
			$scope.selectCompanyId = $stateParams.comId;
			//$scope.selectCompanyName = $stateParams.comName;
			if($stateParams.comId!=result.companyid){
				$scope.showCompanyName = " - "+$stateParams.comName;			
			}
		} else {
			$scope.selectCompanyId = result.companyid;
			//$scope.selectCompanyName = result.companyName;
		}

		//查询下级组织机构
		getNextLevelCompany(result.companyid,$http, $scope);
		//加载数据
		//refreshDatas($scope.selectCompanyId, $scope.selectCompanyName, $http, $scope);
	}).error(function(response) {
	});
	$scope.selectCom = function(comId,comName){
			$scope.selectCompanyName = comName;
			$scope.showCompanyName = " - "+comName;
			$scope.selectCompanyId = comId;
			$scope.selectCompanyChildName = null;
			// 刷新数据
			refreshDatas(comId,$http, $scope);
		};
});
/* //导航栏统计
app.controller('stationCtrl', function($scope, $http) {
});
//发电量信息
app.controller('dataInfo', function($scope, $http) {
	
}); */

//刷新数据
function refreshDatas(companyId,companyName,$http, $scope){
	//导航栏总体数据统计
	getTotalData(companyId,$http, $scope);
	//发电量相关统计
	getElecVData(companyId,$http, $scope);
	//电站列表
	getStationListData(companyId,$http, $scope);
	//发电效率
	getElecvRatioData(companyId,$http, $scope);
}
//查询下级组织机构
function getNextLevelCompany(companyId,$http, $scope){
	$http.get("${ctx}/Company/getCompanyTreeNotIncludeSelf.htm",{params:{comId:companyId}}).success(
			function(response) {
				$scope.districtData = response;
			}).error(function(response) {
	});
}
//导航栏总体数据统计
function getTotalData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getPowerStationTopMapData.htm",{params : {id : companyId}})
	.success(function(response) {
		$scope.stationData = response;
	}).error(function(response) {
	});
}
//发电量相关统计
function getElecVData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getComRtData.htm",{params : {id : companyId}})
	.success(function(response) {
		$scope.dataInfoData = response;
	}).error(function(response) {
	});
}
//电站列表
function getStationListData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getComPowerStationRtData.htm",{params : {id : companyId}})
	.success(function(response) {
		$scope.powerData = response.stationList;
		$scope.stationStatusCount = response.statusCount;
	}).error(function(response) {
	});
}
//发电效率
function getElecvRatioData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getElecVRatioData.htm",{params : {id : companyId}})
	.success(function(response) {
		$scope.elecVBestData = response.elecVBestData;
		$scope.elecVWorstData = response.elecVWorstData;
	}).error(function(response) {
	});
}
</script>
