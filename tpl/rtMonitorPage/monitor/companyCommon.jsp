<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="monitoringListCtrl">
	<input type="hidden" id="stationId" value="123">
	<div class="hbox hbox-auto-xs hbox-auto-sm"
		ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;">
		<!-- main -->
		<div class="col">
			<!-- main header -->
			<!-- 顶部标题开始 -->
			<div class="bg-light lter b-b col-sm-12" id="head-title" style="padding:15px 0px">
					<div class="col-sm-6 col-xs-12 no-padder">
						<span class="href-blur col-sm-12 no-padder text-muted ">
							<ul class="col-sm-12 m-n nav navbar-nav">
								<li class="m-l-md">
									<span class="font-h2 blue-1  text-black" ng-bind="companyName"></span>
								</li>
								<!-- <li class="m-t-xs m-l-xs">
									<span class="font-h5 blue-1 text-black" ng-bind="showCompanyName"></span>
								</li> -->
								<li class="font-h3 dropdown blue-1" style="display: none;margin-top:2px" dropdown="" id="changeCompanyDom">
									<span href="" class="no-padder dropdown-toggle"
									dropdown-toggle="" aria-haspopup="true" aria-expanded="false"><span class="m-l-xs m-r-xs">-</span><span ng-bind="selectCompanyName"></span>
								 <b class="caret"></b>
								</span> <!-- dropdown -->
								<ul class="dropdown-menu" role="menu">
					              <li ng-click="selectCom({{dist.id}},'{{dist.label}}')" ng-repeat="dist in districtData">
					              	<a  >{{dist.label}}</a>
					              </li>
					            </ul>
					            </li>
					            <li class="m-t-xs m-l-md">
									<span ng-click="toMapMonitorPage();">
											<i class="icon-layers m-r-xs"></i>切为地图模式
									</span>
								</li>
							</ul>
						</span>
						<span class="href-blur col-sm-12 no-padder text-muted ">
							<ul class="col-sm-12 m-n nav navbar-nav">
			
								<li class="m-t-xs m-l-md  black-1 font-h5">
									最后更新于 <span ng-bind="dataInfoData.millisecond| date:'yyyy-MM-dd HH:mm:ss'" class="ng-binding">1970-01-01 08:00:00</span>
								</li>
							</ul>
					</span>
					</div>
					<div class="col-sm-6 text-right hidden-xs">
						<div class="inline m-r text-center">
							<span class="m-b-xs m-n black-1 h3"
								ng-bind="stationData.stationCount"></span> <span
								class="text-base">个</span>
							<div>
								<span class="text-base balck-2">电站数量</span>
							</div>
						</div>
						<div class="inline m-r text-center">
							<span class="m-b-xs m-n black-1 h3"
								ng-bind="stationData.installedTotle"></span> <span
								class="text-base" ng-bind="stationData.installedTotleUnit"></span>
							<div>
								<span class="text-base balck-2">总装机量</span>
							</div>
						</div>
						<div class="inline m-r text-center">
							<span class="m-b-xs m-n black-1 h3"
								ng-bind="dataInfoData.capacity"></span> <span class="text-base" ng-bind="dataInfoData.capacityUnit"></span>
							<div>
								<span class="text-base balck-2">累计发电量</span>
							</div>
						</div>
						<div class="inline m-r text-center">
							<span class="m-b-xs m-n black-1 h3" ng-bind="dataInfoData.co2"></span>
							<span class="text-base">t</span>
							<div>
								<span class="text-base balck-2">二氧化碳减排</span>
							</div>
						</div>
					</div>
			</div>
			<!-- 顶部标题结束 -->
			<!-- / main header -->
			<div class="col-sm-12"  style="padding: 20px 20px 20px 25px;">
			<div id="commInterrupt" style="display: none;" class="alert alert-danger" role="alert">通讯中断故障！已中断<span ng-bind="dataInfoData.commInterruptTime"></span>，最后更新于<span ng-bind="dataInfoData.millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></div>
				<!-- 第一排开始 -->
			<div id="first-div">
			<div class="row row-xs m-b-sm">
	        <div class="col-sm-6 col-md-3">
	          <div class=" panel-danger panel-stat">
	            <div class="panel-heading panel-green">
	
	              <div class="stat">
	                <div class="row">
	                  <div class="col-xs-4">
	                   <img src="./theme/images/solway/icon/blok1-gonglv@2x.png"
						class="v-middle" />
	                  </div>
	                  <div class="col-xs-8 no-padder">
	                    <small class="stat-label">实时功率</small>
	                    <h1><span ng-bind="dataInfoData.powerV"></span><small class="m-l-xs"><span ng-bind="dataInfoData.powerVUnit"></span></small>
						</h1>					
	                  </div>
	                </div><!-- row -->
	
	                <div class="m-b-sm"></div>
	
	                <div class="row">
	                  <!-- <div class="col-xs-6">
	                    <small class="stat-label">光照强度</small>
	                    <h4><span ng-bind="powerData.lh|number:1"></span> W/㎡</h4>
	                  </div> -->
	
	                  <div class="col-xs-6">
	                    <small class="stat-label">出力</small>
	                    <h4><span ng-bind="dataInfoData.powerVProp|number:1">0.0</span>%</h4>
	                  </div>
	                </div><!-- row -->
	              </div><!-- stat -->
	
	            </div><!-- panel-heading -->
	          </div><!-- panel -->
	        </div><!-- col-sm-6 -->
	
	        <div class="col-sm-6 col-md-3">
	          <div class=" panel-success panel-stat">
	            <div class="panel-heading">
	
	              <div class="stat">
	                <div class="row">
	                  <div class="col-xs-4">
	                     <img src="./theme/images/solway/icon/icon_day.png" alt="">
	                  </div>
	                  <div class="col-xs-8 no-padder">
	                    <small class="stat-label">日发电量</small>
	                    <h1>
							<span ng-bind="dataInfoData.dElecV" class="ng-binding">0.00</span><small class="m-l-xs"><span ng-bind="dataInfoData.dElecVUnit" class="ng-binding">kWh</span></small>
	                    </h1>
	                  </div>
	                </div><!-- row -->
	
	                <div class="m-b-sm"></div>
	
<!-- 	                 <small class="stat-label">昨日发电量</small> -->
<!-- 	                <h4><span ng-bind="dataInfoData.mElecVProp|number:1" >0.0</span></h4>  -->
	
	              </div><!-- stat -->
	
	            </div><!-- panel-heading -->
	          </div><!-- panel -->
	        </div><!-- col-sm-6 -->
	
	        <div class="col-sm-6 col-md-3">
	          <div class=" panel-primary panel-stat">
	            <div class="panel-heading">
	
	              <div class="stat">
	                <div class="row">
	                  <div class="col-xs-4">
	                     <img src="./theme/images/solway/icon/icon_month.png" alt="">
	                  </div>
	                  <div class="col-xs-8 no-padder">
	                    <small class="stat-label">月累计发电量</small>
	                    <h1>
							<span ng-bind="dataInfoData.mElecV" class="ng-binding">0.00</span><small class="m-l-xs"><span ng-bind="dataInfoData.mElecVUnit" class="ng-binding">kWh</span></small>
	                    </h1>
	                  </div>
	                </div><!-- row -->
	
	                <div class="m-b-sm"></div>
	
	                <small class="stat-label">月度达成率</small>
	                <h4><span ng-bind="dataInfoData.mElecVProp|number:1" >0.0</span>
					<span ng-show="dataInfoData.mElecVProp !=null" >%</span>
					<span ng-show="dataInfoData.mElecVProp ==null" >-</span>
					</h4>
	
	              </div><!-- stat -->
	
	            </div><!-- panel-heading -->
	          </div><!-- panel -->
	        </div><!-- col-sm-6 -->
	
	        <div class="col-sm-6 col-md-3">
	          <div class=" panel-dark panel-stat">
	            <div class="panel-heading">
	
	              <div class="stat">
	                <div class="row">
	                  <div class="col-xs-4">
	                     <img src="./theme/images/solway/icon/icon_year.png" alt="">
	                  </div>
	                  <div class="col-xs-8 no-padder">
	                    <small class="stat-label">年累计发电量</small>
	                    <h1>
							<span ng-bind="dataInfoData.yElecV" >0.00</span><small class="m-l-xs"><span ng-bind="dataInfoData.yElecVUnit" class="ng-binding">kWh</span></small>
	                    </h1>
	                  </div>
	                </div><!-- row -->
	
	                <div class="m-b-sm"></div>
	
	                <div class="row">
	                  <div class="col-xs-6">
	                    <small class="stat-label">年发电小时数</small>
	                    <h4>
							<span ng-bind="dataInfoData.elecHours|number:1" >0.0</span> h
	                    </h4>
	                  </div>
	
	                  <div class="col-xs-6">
	                    <small class="stat-label">年度达成率</small>
	                    <h4>
							<span ng-bind="dataInfoData.yElecVProp|number:1" >0.0</span>
							<span ng-show="dataInfoData.yElecVProp !=null" >%</span>
							<span ng-show="dataInfoData.yElecVProp ==null" >-</span>
						</h4>
	                  </div>
	                </div><!-- row -->
	
	              </div><!-- stat -->
	
	            </div><!-- panel-heading -->
	          </div><!-- panel -->
	        </div><!-- col-sm-6 -->
      </div>
				<!-- 第一排结束 -->
			<!-- 报表开始 -->
				<div class="row row-sm" >
					<div class="col-sm-12">
						<div class="panel wrapper">
							<div id="ssglqx" style="height: 237px;"></div>
						</div>
					</div>
				</div>
		</div>
			<!-- 报表结束 -->
				<!-- 第二排开始 -->
				<div class="row row-sm com-table-div" id="second-div" style="margin-right: -13px;">
					<div class="col-sm-12" >
						<div class="col-sm-12  m-n panel wrapper nav-tabs-alt ng-isolate-scope">
							<ul class="col-sm-12  nav nav-tabs" style="height: 40px;">
								<li >
									<span class="areaActive" style="border-bottom-color: transparent !important;">电站列表</span>
								</li>
<!-- 								<li id="fullScreen" class="pull-right font-h4 a-cur-poi" -->
<!-- 									onclick="fullScreen()"><i class="icon icon-size-fullscreen black-4 text"></i> -->
<!-- 								</li> -->
<!-- 								<li id="closeFullScreen" -->
<!-- 									class="pull-right font-h4 hover-action a-cur-poi" -->
<!-- 									onclick="closeFullScreen()"><i class="icon icon-size-actual black-4 text"></i> -->
<!-- 								</li> -->
								<li class="pull-right font-h4 m-r-md">
									<i class="fa fa-circle black-4 m-r-xs m-l"></i>
									<span class="black-4">中断</span>
									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.stopCount" ></span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<i class="fa fa-circle m-r-xs data-yellow m-l"></i>
									<span class="black-4">报警</span>
									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.warnCount"></span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<i class="fa fa-circle m-r-xs data-red  m-l"></i>
									<span class="black-4">故障</span>
									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.faultCount"></span>
								</li>
								<li class="pull-right font-h4 m-r-md">
									<i class="fa fa-circle m-r-xs data-green  m-l"></i>
									<span class="black-4">运行</span>
									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.runCount"></span>
								</li>
<!-- 								<li class="pull-right font-h4 m-r-md"> -->
<!-- 									<img class="m-t-n-xs" src="./theme/images/solway/icon/icon_loser.png"> -->
<!-- 									<span class="black-4">发电效率最差</span> -->
<!-- 								</li> -->
<!-- 								<li class="pull-right font-h4 m-r-md"> -->
<!-- 									<img class="m-t-n-xs" src="./theme/images/solway/icon/icon_winner.png"> -->
<!-- 									<span class="black-4">发电效率最优</span> -->
<!-- 								</li> -->
							</ul>
							<!-- table开始 -->
						<div class="col-sm-12 no-padder panel b-t m-t-n-xs" style="overflow: auto;" id="table-mail">
							<table class="table table-striped  b-light" >
							<thead >
								<tr>
									<th ng-repeat="column in columns" class="a-cur-poi {{column.cellClass}}"
									ng-click="sort.toggle(column)"
									ng-class="{sortable: column.sortable !== false}">
									{{column.label}} <i
									ng-if="column.name === sort.column && sort.direction"
									class="glyphicon {{sort.direction|orderClass}}"></i>
								</th>
								</tr>
							</thead>
							<tbody >
								<tr ng-repeat="power in stationList |orderBy:sort.column:sort.direction===-1">
									<td style="width:5%" class="font-bold  font-h5 a-cur-poi">
										<img ng-if="power.best==1" class="m-t-n-xs" src="${ctx}/theme/images/solway/icon/icon_winner.png" width="16px">
										<img ng-if="power.worst==1" class="m-t-n-xs" src="${ctx}/theme/images/solway/icon/icon_loser.png" width="16px">
										<span ng-if="power.status==1">
											<i class="font-h6 fa fa-circle data-red "></i>
										</span>
										<span ng-if="power.status==2">
											<i class="font-h6 fa fa-circle data-yellow "></i>
										</span>
										<span  ng-if="power.status==-9">
											<i class="font-h6 fa fa-circle black-4 "></i>
										</span>
										<span  ng-if="power.status>10||power.status==0">
											<i class="font-h6 fa fa-circle data-green"></i>
										</span>
									</td>
									<td style="width:19%" class="font-bold  font-h4 a-cur-poi">
										<span class="" ng-bind="power.factName"  data-toggle="tooltip" data-placement="bottom" title="{{power.factName}}"
										ng-click="showStationMonitor(power.stationId);"></span>
									</td>
									<td style="width: 14%" class="font-h4 black-2" >
									<span ng-bind="power.STATION_STATUS_NORMAL_FAULT"></span>
										<span ng-bind="power.managerName"></span>
										<div ng-bind="power.managerTel"></div>
									</td>
									<td style="width:9%" class="font-h4 black-2 text-right"><span
										ng-bind="power.powerVProp|number:1"></span>%</td>
									<td style="width:9%" class="font-h4 black-2 text-right">
									<span
										ng-bind="power.buildCapacity+power.buildCapacityUnit"></span></td>
									<td style="width:9%" class="font-h4 black-2 text-right"><span
										ng-bind="power.powerV+power.powerVUnit"></span></td>
									<td style="width:9%" class="font-h4 black-2 text-right" >
										<span ng-bind="power.dElecV+power.dElecVUnit"></span>
									</td>
									<td style="width: 13%"class="text-right">
										<div class="font-h4 text-center" ng-bind="power.mElecV+power.mElecVUnit"></div>
										<span class="font-h6 blue-2" ng-show="power.mElecVProp !=null" >计划达成率</span>
										 <span class="pull-right" ng-show="power.mElecVProp !=null" >
										 	<span ng-bind="power.mElecVProp|number:1"></span>%
										 </span>
										<div ng-show="power.mElecVProp !=null"  class="col-sm-12  m-b-none no-padder  progress-xxs  progress ng-isolate-scope"
											animate="true" type="primary">
											<div class=" progress-bar progress-bar-info"
												ng-class="type &amp;&amp; 'progress-bar-' + type"
												role="progressbar" aria-valuemin="0" aria-valuemax="100"
												ng-style="{width: power.mElecVProp + '%'}" ></div>
										</div>
									</td>
									<td style="width: 13%" class="text-right">
										<div class="font-h4 text-center" ng-bind="power.yElecV+power.yElecVUnit"></div>
										<span ng-show="power.yElecVProp !=null"  class="font-h6 blue-2">计划达成率</span>
										 <span ng-show="power.yElecVProp !=null"  class="pull-right">
											<span ng-bind="power.yElecVProp|number:1"></span>%
										 </span>
										<div ng-show="power.yElecVProp !=null"  class="col-sm-12 m-b-none no-padder  progress-xxs  progress ng-isolate-scope"
											animate="true" type="primary" >
											<div class="progress-bar progress-bar-warning"
												ng-class="type &amp;&amp; 'progress-bar-' + type"
												role="progressbar" aria-valuemin="0" aria-valuemax="100"
												ng-style="{width: power.yElecVProp + '%'}" ></div>
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
			</div>
			</div>
<script>
//组织机构下辖电站id，key:机构id，value：以,隔开的电站id字符串，如1,2,3
var stationIdMap = new Map();
//改变table 的样式
function fullScreen() {
	$("#first-div").slideUp("slow", function(){
		//var height = $(window).height()- 267;
		//$("#table-mail").css("height", height);
		$("#fullScreen").addClass("hover-action");
		$("#closeFullScreen").removeClass("hover-action");
		
	});
}
//退出全屏样式修改
function closeFullScreen() {
	//var height = $(window).height()- (80 + $("#first-div").height() + 90 + 70 + 50);
	//$("#table-mail").css("height", height);					
	$("#first-div").slideDown("slow",function(){
		$("#fullScreen").removeClass("hover-action");
		$("#closeFullScreen").addClass("hover-action");
	});
}

var listTimer5s;
var listTimer60s;
app.controller('monitoringListCtrl',function($scope, $http, $state,$stateParams) {
	$scope.columns = [
	                  	{
					      label: '',
					      name: 'status',
					      sortable: false
					     },
			       	    {
			       	      label: '电站名称',
			       	      name: 'factName'//表头 name 需要和table 的列 一致
			       	    },
			       	    {
			       	      label: '负责人/电话',
			       	      name: 'managerName+managerTel'
			       	    },
			       	    {
			       	      label: '实时出力',
			       	      name: 'powerVProp',
			       	   	  cellClass : 'text-right'
			       	    },
			       	    {
			       	      label: '装机容量',
			       	      name: 'buildCapacityOri',
			       	   	  cellClass : 'text-right'
			       	    },
			       	    {
			       	      label: '实时功率',
			       	      name: 'powerVOri',
			       	   	  cellClass : 'text-right'
			       	    },
			       	    {
			       	      label: '日发电量',
			       	      name: 'dElecVOri',
			       	 	  cellClass : 'text-right'
			       	    },
			       	    {
			       	      label: '月累计发电量',
			       	      name: 'mElecVOri',
			       	 	  cellClass : 'text-center'
			       	    },
			       	    {
			       	      label: '年累计发电量',
			       	      name: 'yElecVOri',
			       	   	  cellClass : 'text-center'
			       	    }
			       	  ];
					$scope.sort = {
							    column: 'factName',//默认有排序的列
							    direction: -1,
							    toggle: function(column) {
							      if (column.sortable === false)
							        return;

							      if (this.column === column.name) {
							        this.direction = -this.direction || -1;
							      } else {
							        this.column = column.name;
							        this.direction = -1;
							      }
							    }
							  };
	$http.get("${ctx}/Login/getLoginUser.htm",{timeout: 5000}).success(function(result) {
		//查询组织机构树
		//getCompanyTree(result.companyid, $http, $scope);
		$scope.selectCompanyName = "全部区域";
		$scope.companyName = result.companyName;
		if($stateParams.comId){
			$scope.selectCompanyId = $stateParams.comId;
			$scope.selectCompanyName = $stateParams.comName;
			if($stateParams.comId!=result.companyid){
				$scope.showCompanyName = " - "+$stateParams.comName;			
			}
		} else {
			$scope.selectCompanyId = result.companyid;
			//$scope.selectCompanyName = result.companyName;
		}
		//查询下级组织机构
		getNextLevelCompany(result.companyid,$http,$scope);
		//加载数据
		refreshDatas($scope.selectCompanyId,$http,$scope);
	}).error(function(response) {
	});
	$scope.selectCom = function(comId,comName){
			$scope.selectCompanyName = comName;
			$scope.showCompanyName = " - "+comName;
			$scope.selectCompanyId = comId;
			$scope.selectCompanyChildName = null;
			$scope.stationList = null;
			$scope.stationStatusCount = null;
			// 刷新数据
			refreshDatas($scope.selectCompanyId,$http,$scope);
		};
	$scope.toMapMonitorPage = function(){
		$state.go("dashboard-v2", {
			comId : $scope.selectCompanyId,
			comName:$scope.selectCompanyName
		});
	}
	listTimer5s = setInterval(function() {
		refreshDatas5s($scope.selectCompanyId,$http, $scope);
	}, 5000);
// 	listTimer60s = setInterval(function() {
// 		refreshDatas60s($scope.selectCompanyId,$http, $scope);
// 	}, 5000); 
	$scope.$on('$stateChangeStart', function(event) {
		clearInterval(listTimer5s);
		clearInterval(listTimer60s);
	});
	//进入电站监控
	$scope.showStationMonitor = function(id) {
		$state.go($rootScope.firstMenuUrl["01"]["uisref"], {
			stationId : id
		});
	}
});
//刷新数据
function refreshDatas(companyId,$http, $scope){
	//导航栏总体数据统计
	getTotalData(companyId,$http, $scope);
	refreshDatas5s(companyId,$http, $scope);
	getActPwrLineData(companyId,$http, $scope)
}
function refreshDatas5s(companyId,$http, $scope){
	//导航栏总体数据统计
	//getTotalData(companyId,$http, $scope);
	//发电量相关统计
	getElecVData(companyId,$http, $scope);
	//电站列表
	getStationListData(companyId,$http, $scope);
	//发电效率
	//getElecvRatioData(companyId,$http, $scope);
}
function refreshDatas60s(companyId,$http, $scope){
	//功率趋势图
	getActPwrLineNewlyData(companyId,$http, $scope);
}
//功率趋势图
function getActPwrLineData(companyId,$http, $scope) {
	$http
			.get(
					"${ctx}/AuthCompanyMonitor/getCompanyActPwrLineData.htm",
					{
						params : {
							id : companyId
						},timeout: 5000
					}).success(function(response) {
						$scope.lastTime = response.lastTime;
						$scope.powerUnit = response.name1;
						getPowerV(response,$http, $scope);
			}).error(function(response) {
// 				if(response==null){
// 					promptObj('error','','请求功率趋势图数据超时!');
// 				}else{
// 					promptObj('error','','请求功率趋势图数据出错!');
// 				}
			});
}
//查询下级组织机构
function getNextLevelCompany(companyId,$http, $scope){
	$http.get("${ctx}/Company/getCompanyTreeNotIncludeSelf.htm",{params:{comId:companyId}}).success(
			function(response) {
				if(response!=null&&response.length>0){
					$("#changeCompanyDom").show();
					var allCom= new Object;
					allCom.id= $scope.selectCompanyId;
					allCom.label="全部区域";	
					response.unshift(allCom)
					$scope.districtData = response;
				}
			}).error(function(response) {
	});
}
//导航栏总体数据统计
function getTotalData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getPowerStationTopMapData.htm",{params : {id : companyId},timeout: 5000})
	.success(function(response) {
		$scope.stationData = response;
	}).error(function(response) {
// 		if(response==null){
// 			promptObj('error','','请求装机容量等数据超时!');
// 		}else{
// 			promptObj('error','','请求装机容量等数据出错!');
// 		}
	});
}
//发电量相关统计
function getElecVData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getComRtData.htm",{params : {id : companyId}})
	.success(function(response) {
		if(response.respStatus==1){
			$scope.dataInfoData = response;
			if($scope.dataInfoData.status==-9){
				//通讯中断
				$("#commInterrupt").show();
			}else{
				$("#commInterrupt").hide();
			}
		}
	}).error(function(response) {
	});
}
//电站列表
function getStationListData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getComPowerStationRtData.htm",{params : {id : companyId,stationIds:stationIdMap.get(companyId)},timeout: 5000})
	.success(function(response) {
		if(response.respStatus==1){
			$scope.stationList = response.stationList;
			$scope.stationStatusCount = response.statusCount;
			stationIdMap.put(companyId,response.stationIds);
		}
		if($scope.stationList==null||$scope.stationList.length==0){
			$(".com-table-div").hide()
		}else{
			$(".com-table-div").show()

		}
	}).error(function(response) {
// 		if(response==null){
// 			promptObj('error','','请求电站列表数据超时!');
// 		}else{
// 			promptObj('error','','请求电站列表数据出错!');
// 		}
	});
}
//发电效率 最优最差
function getElecvRatioData(companyId,$http, $scope){
	$http.get("${ctx}/AuthCompanyMonitor/getElecVRatioData.htm",{params : {id : companyId},timeout: 5000})
	.success(function(response) {
		$scope.elecVBestData = response.elecVBestData;
		$scope.elecVWorstData = response.elecVWorstData;
	}).error(function(response) {
	});
}
		require.config({
					paths : {
						echarts : 'vendor/echarts'
					}
				});
				// 实时功率
				function getPowerV(powerVstr,$http, $scope) {
					require([ 'echarts', 'echarts/chart/line' ], function(ec) {
						var myChart = ec
								.init(document.getElementById('ssglqx'));
						window.addEventListener("resize", function() {
							myChart.resize();
						});
						option = {
							title : {
								text : '实时功率趋势图',
								textStyle : {
									fontSize : 14,
									color : "#666",
									fontFamily : '微软雅黑',
									fontWeight : 'normal'
								}
							},tooltip : {
								 trigger: 'axis',
								 axisPointer:{
									 type: 'line',
									    lineStyle: {
									        color: '#bbb',
									        width: 1,
									        type: 'solid'
									    }
								 },
								 formatter: function (params,ticket,callback) {
							            var res = params[0].name;
							            for (var i = 0, l = params.length; i < l; i++) {
							            	if(params[i].value!=""&&!isNaN(params[i].value)){
							                	res += '<br/>' + params[i].seriesName + ' : ' + params[i].value.toFixed(1);
							                	if(i==0){
							                		res += powerVstr.name2;
							                	}else{
							                		res += powerVstr.name1;
							                	}
							            	} else if(params[i].value==""){
							                	res += '<br/>' + params[i].seriesName + ' : N/A';
							            	}
							            }
							            return res;
							      }
						    },
							legend : {
								x : 'right',
								orient : 'horizontal',
								data : [ '光照强度', '实时功率','应发功率']

							},
							calculable : true,
							grid : {
								borderWidth : '0px',
								x : '40px',
								x2 : '30px',
								y : "50px",
								y2 : "20px"
							},
							xAxis : [ {
								axisTick : {
									show : false
								},
								axisLabel : {
									interval:59,
									textStyle : {
										color : '#bbb',
										fontSize : 12
									}
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
								boundaryGap : false,
								data : powerVstr.time
							} ],
							yAxis : [ {
								axisLabel : {
									textStyle : {
										color : '#bbb',
										fontSize : 12
									}
								},
								name : powerVstr.name1,
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
							}, {
								name : powerVstr.name2,
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
								type : 'value',
								axisLabel : {
									textStyle : {
										color : '#bbb',
										fontSize : 12
									},
									formatter : function(v) {
										return v;
									}
								}
							} ],
							series : [{
								name : '光照强度',
								type : 'line',
								z : 3,
								yAxisIndex : 1,
								itemStyle : {
									normal : {
										color : '#f0ad4e',
										areaStyle : {
											color : 'transparent'
										},
										lineStyle : {
											color : '#f0ad4e',
											width : 2
										}
									}
								},
								symbol : 'none',
								data : powerVstr.lightV
							}, {
								symbol : 'none',
								name : '实时功率',
								type : 'line',
								
								z : 2,
								itemStyle : {
									normal : {
										color : 'rgb(217, 83, 79)',
										areaStyle : {
											color : 'rgba(217, 83, 79,.8)'
										},
										lineStyle : {
										/* 	type : 'none',
											width:2, */
											color : 'rgba(217, 83, 79,.9)',
											width : 1
										}
									}
								},
								data : powerVstr.powerV
							}, {
								symbol : 'none',
								name : '应发功率',
								type : 'line',
								
								z : 1,
								itemStyle : {
									normal : {
										color : 'rgb(66,139,202)',
										areaStyle : {
											color : 'transparent'
										},
										lineStyle : {
										/* 	type : 'none',
											width:2, */
											color : 'rgba(66,139,202,.9)',
											width : 2
										}
									}
								},
								data : powerVstr.theoryV
							}/* , {
								name : '预测功率',
								type : 'line',
								smooth : false,
								itemStyle : {
									normal : {
										color : '#fc4c7a',
										z : 2,
										areaStyle : {
											color : 'transparent'
										},
										lineStyle : {
											type : 'dotted',
											color : '#fc4c7a'
										}
									}
								},
								symbol : 'none',
								data : powerVstr.forecasV
							} */ ]
						};

						myChart.setOption(option);
						timer2=setInterval(function(){
							if($scope.lastTime==null){
								return false;
							}
							$http
									.get(
											"${ctx}/AuthCompanyMonitor/getCompanyActPwrLineData.htm",
											{
												params : {
													id : $scope.selectCompanyId,
													lastTime : $scope.lastTime,
													powerUnit:$scope.powerUnit
												},timeout: 5000
											}).success(function(response) {
												if(option.series[0].data.length==0||option.series[1].data.length==0||option.series[2].data.length==0){
													clearInterval(timer2);
													getPowerV(response,$http, $scope);
												} else {
													option.series[0].data = response.lightV;
													option.series[1].data = response.powerV;
													option.series[2].data = response.theoryV;
													myChart.setOption(option,true);	
												}
									}).error(function(response) {
// 										if(response==null){
// 											promptObj('error','','请求功率趋势图数据超时!');
// 										}else{
// 											promptObj('error','','请求功率趋势图数据出错!');
// 										}
									});
							},60000);
					});
				}
				</script>
