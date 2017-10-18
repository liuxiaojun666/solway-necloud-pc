<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.carousel-inner {
	height: 300px;
}

.second-div {
	position: absolute;
}
</style>

<div ng-controller="powerStationMonitorCtrl">
	<input type="hidden" id="stationId" value="123">
	<div class="hbox hbox-auto-xs hbox-auto-sm"
		ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;">
		<!-- main -->
		<div class="col">
			<!-- main header -->
			<div
				data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/statisticalData.jsp'"></div>
			<!-- / main header -->

			<div class="col-sm-12" style="padding: 20px 20px 20px 25px;">
				<div id="response_respStatus" style="display: none;"
					class="alert alert-danger" role="alert">未接收到任何数据。请等待...</div>
				<div id="comm_interruptDev" style="display: none;"
					class="alert alert-danger" role="alert">
					通讯中断故障！已中断<span ng-bind="powerData.commInterruptTime"></span>，最后更新于<span
						ng-bind="powerData.millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span>
				</div>
				<div id="comm_initDev" style="display: none;"
					class="alert alert-info" role="alert">设备初始化，未接收到任何数据。请等待...</div>
				<div id="getPowerStationRtData" class="row row-xs m-b-sm">
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
											<h1>
												<span ng-bind="powerData.powerV"></span><small
													class="m-l-xs"><span ng-bind="powerData.powerVUnit"></span></small>
											</h1>
										</div>
									</div>
									<!-- row -->

									<div class="m-b-sm"></div>

									<div class="row">
										<div class="col-xs-6">
											<small class="stat-label">光照强度</small>
											<h4>
												<span ng-bind="powerData.lh|number:1"></span> W/㎡
											</h4>
										</div>

										<div class="col-xs-6">
											<small class="stat-label">出力</small>
											<h4>
												<span ng-bind="powerData.powerVProp|number:1">0.0</span>%
											</h4>
										</div>
									</div>
									<!-- row -->
								</div>
								<!-- stat -->

							</div>
							<!-- panel-heading -->
						</div>
						<!-- panel -->
					</div>
					<!-- col-sm-6 -->

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
												<span ng-bind="powerData.dElecV" class="ng-binding">0.00</span><small
													class="m-l-xs"><span ng-bind="powerData.dElecVUnit"
													class="ng-binding">kWh</span></small>
											</h1>
										</div>
									</div>
									<!-- row -->

									<div class="m-b-sm"></div>

									<!-- 	                 <small class="stat-label">昨日发电量</small> -->
									<!-- 	                <h4><span ng-bind="powerData.mElecVProp|number:1" >0.0</span></h4>  -->

								</div>
								<!-- stat -->

							</div>
							<!-- panel-heading -->
						</div>
						<!-- panel -->
					</div>
					<!-- col-sm-6 -->

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
												<span ng-bind="powerData.mElecV" class="ng-binding">0.00</span><small
													class="m-l-xs"><span ng-bind="powerData.mElecVUnit"
													class="ng-binding">kWh</span></small>
											</h1>
										</div>
									</div>
									<!-- row -->

									<div class="m-b-sm"></div>

									<small class="stat-label">月度达成率</small>
									<h4>
										<span ng-bind="powerData.mElecVProp|number:1">0.0</span> <span
											ng-show="powerData.mElecVProp !=null">%</span> <span
											ng-show="powerData.mElecVProp ==null">-</span>
									</h4>

								</div>
								<!-- stat -->

							</div>
							<!-- panel-heading -->
						</div>
						<!-- panel -->
					</div>
					<!-- col-sm-6 -->

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
												<span ng-bind="powerData.yElecV" class="ng-binding">0.00</span><small
													class="m-l-xs"><span ng-bind="powerData.yElecVUnit"
													class="ng-binding">kWh</span></small>
											</h1>
										</div>
									</div>
									<!-- row -->

									<div class="m-b-sm"></div>

									<div class="row">
										<div class="col-xs-6">
											<small class="stat-label">年发电小时数</small>
											<h4>
												<span ng-bind="powerData.yElecHour|number:1">0.0</span> h
											</h4>
										</div>

										<div class="col-xs-6">
											<small class="stat-label">年度达成率</small>
											<h4>
												<span ng-bind="powerData.yElecVProp|number:1">0.0</span> <span
													ng-show="powerData.yElecVProp !=null">%</span> <span
													ng-show="powerData.yElecVProp ==null">-</span>
											</h4>
										</div>
									</div>
									<!-- row -->

								</div>
								<!-- stat -->

							</div>
							<!-- panel-heading -->
						</div>
						<!-- panel -->
					</div>
					<!-- col-sm-6 -->
				</div>
				<!-- 第一排开始 -->
				<div class="row row-sm" id="first-div">
					<div class="col-sm-12">
						<div class="panel wrapper">
							<div id="ssglqx" style="height: 237px;"></div>
						</div>
					</div>
				</div>
				<!-- 第一排结束 -->
				<div class="row row-sm fact-table-div" id="second-div"
					style="margin-right: -13px;" style="display: none;">
					<div class="col-sm-12">
						<div
							class="col-sm-12  m-n panel wrapper nav-tabs-alt ng-isolate-scope"
							justified="true">
							<ul class="col-sm-12 no-padder nav nav-tabs btn-nav"
								ng-init="vm.activeTab=1">
								<li ng-class="{active: vm.activeTab == 1}"><a
									href="javascript:;" ng-click="vm.activeTab = 1"
									style="border-bottom-color: transparent !important;">厂区列表</a></li>
								<!-- 								<li id="fullScreen" class="pull-right font-h4 a-cur-poi" -->
								<!-- 									onclick="fullScreen()"><i -->
								<!-- 									class="icon icon-size-fullscreen black-4 text"></i></li> -->
								<!-- 								<li id="closeFullScreen" -->
								<!-- 									class="pull-right font-h4 hover-action a-cur-poi" -->
								<!-- 									onclick="closeFullScreen()"><i -->
								<!-- 									class="icon icon-size-actual black-4 text"></i> -->
								<!-- 								</li> -->
								<!-- 								<li class="pull-right font-h4 m-r-md"> -->
								<!-- 									<i class="fa fa-circle black-4 m-r-xs m-l"></i> -->
								<!-- 									<span class="black-4">中断</span> -->
								<!-- 									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.stopCount" ></span> -->
								<!-- 								</li> -->
								<!-- 								<li class="pull-right font-h4 m-r-md"> -->
								<!-- 									<i class="fa fa-circle m-r-xs data-yellow  m-l"></i> -->
								<!-- 									<span class="black-4">报警</span> -->
								<!-- 									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.warnCount"></span> -->
								<!-- 								</li> -->
								<!-- 								<li class="pull-right font-h4 m-r-md"> -->
								<!-- 									<i class="fa fa-circle m-r-xs data-red  m-l"></i> -->
								<!-- 									<span class="black-4">故障</span> -->
								<!-- 									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.faultCount"></span> -->
								<!-- 								</li> -->
								<!-- 								<li class="pull-right font-h4 m-r-md"> -->
								<!-- 									<i class="fa fa-circle m-r-xs data-green  m-l"></i> -->
								<!-- 									<span class="black-4">运行</span> -->
								<!-- 									<span class="black-2 m-l-xs" ng-bind="stationStatusCount.runCount"></span> -->
								<!-- 								</li> -->
							</ul>
							<div
								class="col-sm-12 no-padder tab-content tab-bordered m-t-sm b-t"
								id="table-div">
								<div class="tab-panel" ng-show="vm.activeTab == 1">
									<div class="col-sm-12 no-padder ">
										<table id="result_table" class="table table-striped  b-light">
											<thead>
												<tr>
													<th ng-repeat="column in columns" class="a-cur-poi"
														ng-click="sort.toggle(column)"
														ng-class="{sortable: column.sortable !== false}">
														{{column.label}} <i
														ng-if="column.name === sort.column && sort.direction"
														class="glyphicon {{sort.direction|orderClass}}"></i>
													</th>
												</tr>
											</thead>
											<tbody>
												<tr
													ng-repeat="factory in factoryData|orderBy:sort.column:sort.direction===-1">
													<td>
														<!-- 										<span ng-if="factory.status==1"> --> <!-- 											<i class="font-h6 fa fa-circle data-red "></i> -->
														<!-- 										</span> --> <!-- 										<span ng-if="factory.status==2"> -->
														<!-- 											<i class="font-h6 fa fa-circle data-yellow "></i> -->
														<!-- 										</span> --> <!-- 										<span  ng-if="factory.status==-9"> -->
														<!-- 											<i class="font-h6 fa fa-circle black-4 "></i> -->
														<!-- 										</span> --> <!-- 										<span  ng-if="factory.status>10||factory.status==0"> -->
														<!-- 											<i class="font-h6 fa fa-circle data-green"></i> -->
														<!-- 										</span> --> 
														<!--class="href-blur a-cur-poi" -->
														<span ng-bind="factory.factName">
														<!-- ng-click="changeStation({{factory.powerStationId}});" -->
														
													</span>
													</td>
													<td><span ng-bind="factory.buildCapacity"> </span> <span
														ng-bind="factory.buildCapacityUnit"></span></td>
													<td><span ng-bind="factory.dElecV"></span> <span
														ng-bind="factory.dElecVUnit"></span></td>
													<td><span ng-bind="factory.powerV"></span> <span
														ng-bind="factory.powerVUnit"></span></td>
													<td><span ng-bind="factory.powerVProp|number:1"></span>
														<span>%</span></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(".modal-backdrop").css("display", "none")
	//改变table 的样式
	function fullScreen() {
		$("#first-div").slideUp("slow", function() {
			//var height = $(window).height()- 267;
			//$("#table-div").css("height", height);
			$("#fullScreen").addClass("hover-action");
			$("#closeFullScreen").removeClass("hover-action");

		});
	}
	//退出全屏样式修改
	function closeFullScreen() {
		//var height = $(window).height()- (77 + $("#first-div").height() + 70 + 70  + 50);
		//$("#table-div").css("height", height);
		$("#first-div").slideDown("slow", function() {
			$("#fullScreen").removeClass("hover-action");
			$("#closeFullScreen").addClass("hover-action");
		});
	}
	/* var height = $(window).height()- (77 + $("#first-div").height() + 70 + 70 + 50);
	$("#table-div").css("height", height);
	window.addEventListener("resize",function() {
		var height = $(window).height()
				- (77 + $("#first-div").height() + 70 + 70
						+ 7 + 70);
		$("#table-div").css("height", height);
	}); */
	// 路径配置
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
	// 实时功率
	function getPowerV(powerVstr, $http, $scope) {
		require(
				[ 'echarts', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('ssglqx'));
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
						},
						tooltip : {
							trigger : 'axis',
							axisPointer : {
								type : 'line',
								lineStyle : {
									color : '#bbb',
									width : 1,
									type : 'solid'
								}
							},
							formatter : function(params, ticket, callback) {
								var res = params[0].name;
								for (var i = 0, l = params.length; i < l; i++) {
									if ((params[i].value === 0 ) ||(params[i].value != ""
											&& !isNaN(params[i].value))) {
										res += '<br/>' + params[i].seriesName
												+ ' : '
												+ params[i].value;
										if (i == 0) {
											res += powerVstr.name2;
										} else {
											res += powerVstr.name1;
										}
									}else{
										res += '<br/>' + params[i].seriesName
										+ ' : N/A';
										}
								}
								return res;
							}
						},
						legend : {
							x : 'right',
							orient : 'horizontal',
							data : [ '应发功率', '实发功率', '光照强度' ]

						},
						calculable : false,
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
								interval : 59,
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
						/* #e74c3c */
						series : [
						{
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
						},
						{
							symbol : 'none',
							name : '实发功率',
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
						},
						{
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
						}
						 /* , {
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
																		} */]
					};
					myChart.setOption(option);
					timer2 = setInterval(
							function() {
								if ($scope.lastTime == null) {
									return false;
								}
								$http
										.get(
												"${ctx}/PowerStationMonitor/getPowerStationActPwrLineData.htm",
												{
													params : {
														id : $scope.powerStationId,
														lastTime : $scope.lastTime,
														powerUnit : $scope.powerUnit
													},
													timeout : 5000
												})
										.success(
												function(response) {
													if (option.series[0].data.length == 0
															|| option.series[1].data.length == 0
															|| option.series[2].data.length == 0) {
														clearInterval(timer2);
														getPowerV(response,
																$http, $scope);
													} else {
														option.series[0].data = response.lightV;
														option.series[1].data = response.powerV;
														option.series[2].data = response.theoryV;
														myChart.setOption(
																option, true);
													}
												}).error(function(response) {
											// 										if(response==null){
											// 											promptObj('error','','请求功率趋势图数据超时!');
											// 										}else{
											// 											promptObj('error','','请求功率趋势图数据出错!');
											// 										}
										});
							}, 60000);
				});
	}
</script>
<script>
	app.controller('powerStationMonitorCtrl', function($scope, $http, $state,
			$stateParams) {
		$scope.columns = [ {
			label : '厂区名称',
			name : 'factName'//表头 name 需要和table 的列 一致
		}, {
			label : '装机量',
			name : 'buildCapacityOri'
		}, {
			label : '日发电量',
			name : 'dElecVOri'
		}, {
			label : '实时功率',
			name : 'powerVOri'
		}, {
			label : '出力',
			name : 'powerVProp'
		} ];
		$scope.sort = {
			column : 'factName',//默认有排序的列
			direction : -1,
			toggle : function(column) {
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
		$scope.powerStationId = null;
		$scope.pstationName = null;
		$scope.pstationAddress = null;

		$scope.refreshViewDataForHead = function () {
			$scope.refreshData();
			getStatisticalData($http, $scope);
			$scope.getLoginUserPS();
    	}
    	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

		//根据当前登陆用户加载数据
		$scope.getLoginUserPS = function() {
			$http.get("${ctx}/Login/getLoginUser.htm").success(
					function(result) {
						$scope.powerStationId = result.pstationid;
						//$scope.powerParentStationId = result.pstationid;
						//	$scope.pstationName = result.pstationName;
						$scope.parentName = result.pstationName;
						$scope.pstationAddress = result.pstationAddress;
						$scope.getFactList();
						getDatas($http, $scope);
					}).error(function(response) {
			});
		};
		//根据当前用户加载电站列表
		CommonPerson.Base.LoadingPic.PartShow('result_table');//加载状态
		//加载厂区列表
		$scope.getFactList = function() {
			getFactoryData($http, $scope);
		}
		//电站列表
		$scope.getStationList = function() {
			$http.get("${ctx}/PowerStation/selectByLoginUser.htm", {
				params : {}
			}).success(function(result) {
				if (result == null || result.length <= 1) {
					//隐藏切换电站
					$("#changeStationSP").hide();
				} else {
					//显示切换电站
					$("#changeStationSP").show();
				}
				$scope.stationList = result;
			}).error(function(response) {
			});
		};
		$scope.stationScopeStr = ""; //切换电站
		//切换电站
		$scope.changeStation = function(id) {
			$scope.powerStationId = id;
			$http.get("${ctx}/PowerStation/selectByIdForMonitor.htm", {
				params : {
					id : $scope.powerStationId
				}
			}).success(function(result) {
				$scope.pstationAddress = result.address;
				//切换的是厂区
				if (result.parentid != null) {
					var parentId = result.parentid;
					$scope.parentId = parentId;
					//	$scope.parentName = $scope.pstationName;
					$scope.parentName = result.stationname;
					// 														$("#factSP").hide();
					$("#table-div").hide();
					$("#deviceStationId").hide();
					$("#deviceLayoutId").hide();
					$(".fact-table-div").hide();
					$scope.factoryData = null;//切换厂区是厂区列表清空
					//根据当前厂区加载同一电站下所有厂区
					$http.get("${ctx}/PowerStation/selectByScope.htm", {
						params : {
							parentid : parentId
						}
					}).success(function(result) {
						if (result == null || result.length <= 1) {
							$("#changeStationSP").hide();
						} else {
							$scope.stationScopeStr = "";
							$("#changeStationSP").show();
						}
						$scope.stationList = result;
					}).error(function(response) {
					});
				} else {//切换的是电站

					$scope.parentName = result.stationname;
					$("#deviceStationId").show();
					$("#deviceLayoutId").show();
					$scope.getFactList();
					$scope.weatherId = null;
					$scope.serialnumber = null;
					$scope.parentId = null;
					//$scope.parentName = null;
				}
				getDatas($http, $scope);
			}).error(function(response) {
			});
		};
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timer1);
			clearInterval(timer2);
			CommonPerson.Base.LoadingPic.FullScreenHide();
		})
		$scope.getWeatherData = function(flag) {
			getWeatherData($http, $scope);
			if (flag == 1) {
				getNext3DayWeatherData($http, $scope)
			}
		}
		if ($stateParams.stationId) {
			//showGoBackFlag();
			$scope.changeStation($stateParams.stationId);
			//getDatas($http, $scope);
		} else {
			$scope.getLoginUserPS();
			hideGoBackFlag();
		}
		//$scope.getStationList();
		$scope.refreshData = function(){
			getRtData($http, $scope);
			getWeatherData($http, $scope);
			if ($scope.factoryData != null && $scope.factoryData.length > 0) {
				getFactoryData($http, $scope);
			}
		}
		timer1 = setInterval(function() {
			//getStatisticalData($http, $scope);
			$scope.refreshData();
		}, 5000);
		/* timer2=setInterval(function(){
 			getActPwrLineData($http, $scope);
 			getActPwrLineNewlyData($http, $scope);
 		},5000); */
	});
	var timer1, timer2;
	function getDatas($http, $scope) {
		getRtData($http, $scope);
		getActPwrLineData($http, $scope);
		getStatisticalData($http, $scope);
		getWeatherData($http, $scope);
		// 					getBoxChangeData($http, $scope);
		// 					getInverterData($http, $scope);
		// 					getJunctionBoxData($http, $scope);
	}
	function getFactoryData($http, $scope) {

		$http
				.get(
						"${ctx}/PowerStationMonitor/getPowerStationStationAreaData.htm",
						{
							params : {
								id : $scope.powerStationId,
								factIds : $scope.factIds
							},
							timeout : 5000
						}).success(function(response) {
					setTimeout("partHide('" + 'result_table' + "')");
					if (response.data == null || response.data.length == 0) {
						// 									$("#factSP").hide();
						$(".fact-table-div").hide();
					} else {
						// 									$("#factSP").show();
						$(".fact-table-div").show();
					}
					if (response.respStatus == 1) {
						$scope.factoryData = response.data;
					}
					$scope.factIds = response.factIds;
					$scope.stationStatusCount = response.statusCount;
				}).error(function(response) {
					// 								if(response==null){
					// 									promptObj('error','','请求厂区列表数据超时!');
					// 								}else{
					// 									promptObj('error','','请求厂区列表数据出错!');
					// 								}
				});
	}
	//装机统计数据
	function getStatisticalData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getPowerStationTotalData.htm", {
			params : {
				id : $scope.powerStationId
			}
		}).success(function(response) {
			$scope.totleData = response;
		}).error(function(response, msg) {
			
		});
	}
	//气象数据
	function getWeatherData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getWeatherRtData.htm", {
			params : {
				id : $scope.powerStationId,
				weatherId : $scope.weatherId,
				serialnumber : $scope.serialnumber,
				parentId : $scope.parentId
			},
			timeout : 5000
		}).success(function(response) {
			$scope.weatherData = response;
			$scope.weatherId = response.weatherId;
			$scope.serialnumber = response.serialnumber;
		}).error(function(response) {
			// 								if(response==null){
			// 									promptObj('error','','请求气象数据超时!');
			// 								}else{
			// 									promptObj('error','','请求气象数据出错!');
			// 								}
		});
	}
	//未来三天的气象数据
	function getNext3DayWeatherData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getNext3DayWeatherData.htm", {
			params : {
				id : $scope.powerStationId,
				cityName : $scope.cityName
			}
		}).success(function(response) {
			$scope.cityName = response.cityName;
			if (response.respStatus == 1) {
				$scope.next3DayWeatherData = response.weatherData;
			}
		}).error(function(response) {
		});
	}
	//功率等实时数据
	function getRtData($http, $scope) {
		$http.get("${ctx}/PowerStationMonitor/getPowerStationRtData.htm", {
			params : {
				id : $scope.powerStationId
			},
			timeout : 5000
		}).success(
				function(response) {
					if (response.respStatus == 1) {
						$("#response_respStatus").hide();
						$("#getPowerStationRtData").show();
						$scope.powerData = response;
						if ($scope.powerData.comm == 1) {
							//通讯中断
							$("#comm_interruptDev").show();
							$("#comm_initDev").hide();
						} else if ($scope.powerData.comm == 2
								|| $scope.powerData.comm == null) {
							$("#comm_interruptDev").hide();
							$("#comm_initDev").show();
						} else {
							$("#comm_interruptDev").hide();
							$("#comm_initDev").hide();
						}
					} else {
						$("#response_respStatus").show();
						$("#getPowerStationRtData").hide();
					}
				}).error(function(response) {
			// 								if(response==null){
			// 									promptObj('error','','请求发电量数据超时!');
			// 								}else{
			// 									promptObj('error','','请求发电量数据出错!');
			// 								}
		});
	}
	//功率趋势图
	function getActPwrLineData($http, $scope) {
		$http.get(
				"${ctx}/PowerStationMonitor/getPowerStationActPwrLineData.htm",
				{
					params : {
						id : $scope.powerStationId
					}
				}).success(function(response) {
			$scope.lastTime = response.lastTime;
			$scope.powerUnit = response.name1;
			getPowerV(response, $http, $scope);
		}).error(function(response) {
			// 								if(response==null){
			// 									promptObj('error','','请求功率趋势图数据超时!');
			// 								}else{
			// 									promptObj('error','','请求功率趋势图数据出错!');
			// 								}
		});
	}
</script>
