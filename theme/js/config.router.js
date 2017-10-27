/**
 * Config for the router
 */
function getArrRealVal(arr, atr){//获取数组arr中第一个atr属性不为空的值
	for (var i = 0; i < arr.length; i++) {
		if (arr[i][atr]) {
			return arr[i][atr];
		}
	}
}
var scriptParam = document.getElementById('routerJS').getAttribute('param');
var welComeUrl = "/power-index";
$.ajax({
	type : "post",
	url : scriptParam + "/UserAuthHandle/getRightListForPCNew.htm",
	async : false,
	success : function(result) {
		// if(result.firstMenuUrl){
		// 	welComeUrl="/app"+result.firstMenuUrl;
		// }
		if(result.result){
			if(result.roleType == 3 || result.roleType == 99){
				var uiurl = getArrRealVal(result.rightlist,"uiurl");
				welComeUrl="/app"+uiurl;
			}else{
				welComeUrl = "/" + result.mainPage;
			}
			/**else if(result.mainPageType == 1){
				welComeUrl = "/power-index-meter";
			}*/
		}
	},
	error : function(json) {
	}
});

var allApi = [
			'theme/js/dist/interface.js',
			'theme/js/dist/polyfill.min.js'
			]
var newFile = [
				'theme/js/dist/api.js',
				'theme/js/dist/componets.js',
				'theme/css/publicComponent.css'
			]
/*angular.module('app')
	.run(['$rootScope', '$state', '$stateParams',function($rootScope, $state, $stateParams) {
		$rootScope.$state = $state;
		$rootScope.$stateParams = $stateParams;
	}])*/
angular.module('app')
  .run(['$rootScope', '$window', '$location', '$log','$state','$stateParams', function ($rootScope, $window, $location, $log,$state,$stateParams)  {
	var locationChangeStartOff = $rootScope.$on('$locationChangeStart', locationChangeStart);
	var locationChangeSuccessOff = $rootScope.$on('$locationChangeSuccess', locationChangeSuccess);

	function locationChangeStart(event) {
		$('#loadAnimation').show(0);
		$('#loadinfo').show(0);
	}

	function locationChangeSuccess(event) {
		$("#loadAnimation").hide(1500, function(){
			$('#loadinfo').hide()
		});
		setTimeout(function(){
			$('#loadinfo').hide();
		},500);
	}
		  $rootScope.$state = $state;
		  $rootScope.$stateParams = $stateParams;
	  }
	]
  )
	.config(['$stateProvider','$urlRouterProvider',function($stateProvider, $urlRouterProvider) {
		$urlRouterProvider.otherwise(welComeUrl);		
		$stateProvider
						.state('app',{
							abstract : true,
							url : '/app',
							templateUrl: /* @ */'tpl/app.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('toaster')
										}]
							}
						})
						.state('power-index2',{
							url : '/power-index2?roleIdPowerToIndex',
							templateUrl : 'tpl/homePage/power-index.jsp',
							resolve: {
								deps: ['$ocLazyLoad', 'uiLoad',
									function( $ocLazyLoad, uiLoad ){
										return $ocLazyLoad
											.load([
												'toaster',
												'theme/js/modal.js',
												'theme/css/power-index.css',
												'theme/fonts/defind/iconfont.css'
											])
									}
								]
							}
						})
						.state('app.dashboard-v1',{
							url : '/monitoring?dataType',
							templateUrl : 'tpl/rtMonitorPage/monitor/app_dashboard_v1.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load([ 
															'theme/js/modal.js','ngGrid'])
															.then(function() {
																return $ocLazyLoad.load('theme/js/controllers/grid.js')
															});
										}]
							}
						})
						.state('app.wpMonitoring',{
							url : '/wpMonitoring?dataType',
							templateUrl : 'tpl/wp/rtMonitorPage/monitor/wpMonitoring.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load([
												'vendor/echarts/testnull.js',
												'theme/js/modal.js','ngGrid'])
											.then(function() {
												return $ocLazyLoad.load('theme/js/controllers/grid.js')
											});
									}]
							}
						})
						.state('dashboard-v2',{
							url : '/monitoringMap?roleId',
							templateUrl : 'tpl/rtMonitorPage/monitor/app_dashboard_v2.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(['vendor/echarts/echarts.js',
															'theme/js/controllers/chart.js']);
										}]
							}
						})
						.state('power-index',{
							url : '/power-index?roleId',
							templateUrl : 'tpl/rtMonitorPage/monitor/monitoringMapNew.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/monitoringMapNew.css','vendor/echarts/testnull.js'])
											.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/toaster.js')
										});
									}
								]
							}
						})
						//新能云新——17-10-24
						.state('power-index171024',{
							url : '/power-index171024?roleId',
							templateUrl : 'tpl/rtMonitorPage/monitor/monitoringMapNew1024.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/monitoringMapNew1024.css'])
											.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/toaster.js')
										});
									}
								]
							}
						})
						//北京区域首页
						.state('power-index-beijing',{
							url : '/power-index-beijing',
							templateUrl : 'tpl/rtMonitorPage/monitor/monitoringMapBeijing.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/monitoringMapBeijing.css'])
											.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/toaster.js')
										});
									}
								]
							}
						})
						.state('power-index-meter',{
							url : '/power-index-meter?roleId',
							templateUrl : 'tpl/meter/rtMonitorPage/monitor/monitoringMapNew.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/monitoringMapNew.css','vendor/echarts/testnull.js'])
											.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/toaster.js')
										});
									}
								]
							}
						})
						//大唐
						.state('power-index-datang2',{
							url : '/power-index-datang2?roleId',
							templateUrl : 'tpl/datang/rtMonitorPage/monitor/monitoringMap.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/monitoringMapDatang.css','vendor/static/js/clay.min.js'])
											.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/toaster.js')
										});
									}
								]
							}
						})
						//大唐新
						.state('power-index-datang',{
							url : '/power-index-datang?roleId',
							templateUrl : 'tpl/datang/rtMonitorPage/monitor/monitoringMapNew.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/datangNew.css','vendor/static/js/clay.min.js'])
											.then(function() {
											return $ocLazyLoad.load(['theme/js/controllers/toaster.js'])
										});
									}
								]
							}
						})
						//大唐二级首页
						.state('dtSecLevelHomePage',{
							url : '/dtSecLevelHomePage',
							templateUrl : 'tpl/datang/secondLevelPage/secLevelHomePage.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['toaster','theme/css/datang/secLevelPage/secLevelHomePage.css','vendor/static/js/clay.min.js'])
											.then(function() {
											return $ocLazyLoad.load(['theme/js/controllers/toaster.js'])
										});
									}
								]
							}
						})
						//大唐-电站监控
						.state('app.stMonitorOverview',{
							url : '/stMonitorOverview',
							templateUrl : 'tpl/datang/rtMonitorPage/monitor/stMonitorOverview.jsp',
							resolve : {
								deps: ['$ocLazyLoad',
									function( $ocLazyLoad ){
									  return $ocLazyLoad.load('theme/css/datang/dtMonitor.css','ngGrid','ui.select').then(
											function() {
											return $ocLazyLoad.load(['theme/js/controllers/toaster.js']);
										}).then(
												function() {
													return $ocLazyLoad
															.load([
																   'theme/js/controllers/grid.js',
																   'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
												})
								  }]
								}
						})
						//首页新版
						.state('power-index-new',{
							url : '/power-index-new?roleId',
							templateUrl : 'tpl/rtMonitorPage/monitor/monitoringMapNew.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['theme/css/monitoringMapNew.css','toaster'])
											.then(function() {
											return $ocLazyLoad.load('vendor/echarts/china.js','theme/js/controllers/toaster.js')
										});
									}
								]
							}
						})
						.state('app.analyzeHome',{
							url : '/analyzeHome?stid',
							templateUrl : 'tpl/reportPage/analyzeHome.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/echarts-all.js']);
									}
								]
							}
						})
						
						//统计分析模块-开始-（光伏）
						
						//概览
						.state('app.overview',{
							url : '/overview?stid',
							templateUrl : 'tpl/dataAnalysisPage/overview/overview.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//综合评估
						.state('app.dataAnalysis',{
							url : '/dataAnalysis',
							templateUrl : 'tpl/dataAnalysisPage/dataAnalysis/dataAnalysis.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//气象资源
						.state('app.meteorologicalResources',{
							url : '/meteorologicalResources',
							templateUrl : 'tpl/dataAnalysisPage/meteorologicalResources/meteorologicalResources.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js','ngGrid'])
										.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/grid.js')
										});;
									}
								]
							}
						})
						//发电量
						.state('app.powerGeneration',{
							url : '/powerGeneration',
							templateUrl : 'tpl/dataAnalysisPage/powerGeneration/powerGeneration.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js','ngGrid'])
										.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/grid.js')
										});;
									}
								]
							}
						})
						//故障
						.state('app.trouble',{
							url : '/trouble',
							templateUrl : 'tpl/dataAnalysisPage/trouble/trouble.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js','ngGrid'])
										.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/grid.js')
										});;
									}
								]
							}
						})
						//设备性能
						.state('app.equipmentPerformance',{
							url : '/equipmentPerformance',
							templateUrl : 'tpl/dataAnalysisPage/equipmentPerformance/equipmentPerformance.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js','ngGrid'])
										.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/grid.js')
										});;
									}
								]
							}
						})
						//排名
						.state('app.ranking',{
							url : '/ranking',
							templateUrl : 'tpl/dataAnalysisPage/ranking/ranking.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['ngGrid'])
										.then(function() {
											return $ocLazyLoad.load('theme/js/controllers/grid.js')
										});
									}
								]
							}
						})
						//光伏日历
						.state('app.pvCalendar',{
							url : '/pvCalendar?stid',
							templateUrl : 'tpl/reportPage/pvCalendar.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/echarts-all.js']);
									}
								]
							}
						})
						
						//统计分析模块-开始-（风电）
						//概览 
						.state('app.wpGeneralView',{
							url : '/wpGeneralView',
							templateUrl : 'tpl/wp/dataAnalysisPage/overview/overview.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//电量分析
						.state('app.wpPowerGeneration',{
							url : '/wpPowerGeneration',
							templateUrl : 'tpl/wp/dataAnalysisPage/powerGeneration/powerGeneration.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//气象资源
						.state('app.wpMeteorologicalResources',{
							url : '/wpMeteorologicalResources',
							templateUrl : 'tpl/wp/dataAnalysisPage/meteorologicalResources/wpMeteorologicalResources.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js'])
									}
								]
							}
						})
						//主题分析
						.state('app.wpThemeAnalysis',{
							url : '/wpThemeAnalysis',
							templateUrl : 'tpl/wp/dataAnalysisPage/themeAnalysis/themeAnalysis.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//功率曲线
						.state('app.wpPowerCurve',{
							url : '/wpPowerCurve',
							templateUrl : 'tpl/wp/dataAnalysisPage/powerCurve/powerCurve.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/echarts-all.js','vendor/echarts/echarts.js']);
									}
								]
							}
						})
						//故障
						.state('app.wpFault',{
							url : '/wpFault',
							templateUrl : 'tpl/wp/dataAnalysisPage/wpFault/wpFault.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//排名
						.state('app.wpRanking',{
							url : '/wpRanking',
							templateUrl : 'tpl/wp/dataAnalysisPage/wpRanking/wpRanking.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/echarts-all.js','vendor/echarts/echarts.js']);
									}
								]
							}
						})
						//性能
						.state('app.wpEquipmentPerformance',{
							url : '/wpEquipmentPerformance',
							templateUrl : 'tpl/wp/dataAnalysisPage/wpEquipmentPerformance/wpEquipmentPerformance.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						//综合评估
						.state('app.wpDataAnalysis',{
							url : '/wpDataAnalysis',
							templateUrl : 'tpl/wp/dataAnalysisPage/wpDataAnalysis/wpDataAnalysis.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad.load(['vendor/echarts/testnull.js']);
									}
								]
							}
						})
						.state('app.daily',{
							url : '/daily?analData&stid',
							templateUrl : 'tpl/reportPage/daily/daily.jsp',
							 resolve : {
									deps : ['$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(['toaster','theme/js/modal.js','vendor/echarts/echarts-all.js'])
										}]
								}
						})
						.state('app.monthly',{
							url : '/monthly?analData&analMon&flag&stid',
							templateUrl : 'tpl/reportPage/monthly/monthly.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
										function($ocLazyLoad) {
									return $ocLazyLoad .load('toaster','vendor/echarts/echarts-all.js')
								}]
							}
						})
						.state('app.staionInvPower',{
							url : '/staionInvPower',
							templateUrl : 'tpl/reportPage/staionInvPower/stationInvPower.jsp',
							resolve : {
								deps : ['$ocLazyLoad',
										function($ocLazyLoad) {
									return $ocLazyLoad
									.load('toaster')
								}]
							}
						})

						.state('app.deviceLayout',{
							url : '/RtmDeviceLayout?stationId&stationName',
							templateUrl : '	tpl/rtMonitorPage/deviceLayout/deviceLayout.jsp',
							resolve : {
							deps: ['$ocLazyLoad',
								function( $ocLazyLoad ){
								  return $ocLazyLoad.load('ngGrid','ui.select').then(
										function() {
										return $ocLazyLoad.load(['theme/js/controllers/toaster.js']);
									}).then(
											function() {
												return $ocLazyLoad
														.load([
															   'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
															   'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
											})
							  }]
							}
						})
			.state('app.rtmDeviceLayoutTab',{
				url : '/rtmDeviceLayoutTab?stationId&stationName',
				templateUrl : 'tpl/rtMonitorPage/deviceLayout/deviceLayoutTab.jsp',
				resolve : {
					deps: [
						'$ocLazyLoad',
						function ($ocLazyLoad) {
							return $ocLazyLoad.load('ngGrid', 'ui.select').then(function () {
									return $ocLazyLoad.load([
										'theme/js/controllers/grid.js',
										'theme/js/controllers/toaster.js',
										'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
										'vendor/jquery/jquery-ui-1.10.3.custom.min.js',
										'theme/js/angular.pagination.js',
										'vendor/echarts/testnull.js'
									]);
								}).then(
										function() {
											return $ocLazyLoad.load('ui.select');
										})
						}]
				}
			})
						.state('app.deviceList',{
							url : '/RtmDeviceList?stationId&stationName',
							templateUrl : '	tpl/rtMonitorPage/deviceLayout/deviceList.jsp',
							resolve : {
							   deps: ['$ocLazyLoad',
								function( $ocLazyLoad ){
								  	return $ocLazyLoad.load('ngGrid','ui.select').then(function() {
										return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
									}).then(function() {
										return $ocLazyLoad.load([
													   'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
													   'vendor/jquery/jquery-ui-1.10.3.custom.min.js',
														'theme/js/angular.pagination.js']);
									})
							  	}]
							}
						})
						.state('app.wpDeviceList',{
							url : '/wpDeviceList?stationId&stationName',
							templateUrl : 'tpl/wp/rtMonitorPage/deviceLayout/deviceList.jsp',
							resolve : {
								deps: ['$ocLazyLoad',
									function( $ocLazyLoad ){
										return $ocLazyLoad.load('ngGrid','ui.select').then(
											function() {
												return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
											}).then(
											function() {
												return $ocLazyLoad
													.load([
														'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
														'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
											})
									}]
							}
						})
						.state('app.DeviceLayoutView',{
							url : '/DeviceLayoutView?stationId',
							templateUrl : 'tpl/rtMonitorPage/deviceLayout/deviceLayoutView.jsp',
							resolve : {
								deps: ['$ocLazyLoad',
									function( $ocLazyLoad ){
										return $ocLazyLoad.load('ngGrid','ui.select').then(
											function() {
												return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
											}).then(
											function() {
												return $ocLazyLoad
													.load([
														'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
														'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
											})
									}]
							}
						})
						.state('app.mail',{
							url : '/monitoringList?comId&comName',
							templateUrl : 'tpl/rtMonitorPage/monitor/companyCommon.jsp',
							// use resolve to load other
							// dependences
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'angularBootstrapNavTree')
													.then(
															function() {
																return $ocLazyLoad
																		.load(['theme/js/modal.js']);
															});
										}]
							}
						})
						.state('app.mail.list',{
							url : '/factory?comId&comName',
							templateUrl : 'tpl/rtMonitorPage/monitor/mail.list.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(['vendor/echarts/echarts.js'])
										}]
							}
						})
						//消息中心
						 .state('apps', {
							 // abstract: true,
							  url: '/apps',
							  templateUrl: 'tpl/apps.html',
								  resolve : {
										deps : ['$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load('toaster')
													.then(
															function() {
																return $ocLazyLoad.load('ui.select').then(
																				function() {
																					return $ocLazyLoad.load('theme/js/angular.pagination.js')
																				})
															})
											}]
									}
						  })
						.state('app.note',{
							url : '/note',
							templateUrl : 'tpl/systemPage/basemessage/note.jsp',
								  resolve: {
									  deps: ['$ocLazyLoad',
										function( $ocLazyLoad ){
										  return $ocLazyLoad.load('ngGrid','ui.select').then(
												function() {
												return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
											}).then(
											  function() {
												  return $ocLazyLoad.load('ui.select');
											  }).then(
													function() {
														return $ocLazyLoad
																.load('theme/js/angular.pagination.js');
													})
									  }]
								  }
							})
						//部门管理
						.state('apps.companyDepartment',{
							url : '/manageDepartment',
							templateUrl : 'tpl/systemPage/companyDepartment/manageDepartment.jsp',
							resolve : {
							deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
												.load(['theme/js/angular.pagination.js'])
									}]
							}
						})
							//快速入驻
						.state('app.speedSettled', {
								//abstract: true,
								url : '/speedSettled',
								templateUrl: 'speedSettled/speedSettled.jsp',
								resolve: {
									  deps: ['uiLoad',
										function( uiLoad ){
										  return uiLoad.load( ['theme/js/app/mail/mail.js',
															   'theme/js/app/mail/mail-service.js',
															   'vendor/libs/moment.min.js'] );
									  }]
								  }
							  })
					  .state('app.speedSettled.one', {
						  url: '/speedSettled-one',
						  templateUrl: 'speedSettled/speedSettled-one.jsp',
						  resolve : {deps : ['$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad.load('ui.select').then(
														function() {
															return $ocLazyLoad.load('theme/js/angular.pagination.js')
														})
													}]
								  }
					  })
					  .state('app.speedSettled.two', {
						  url: '/speedSettled-two',
						  templateUrl: 'speedSettled/speedSettled-two.jsp',
						  resolve : {deps : ['$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad.load('ui.select').then(
												function() {
													return $ocLazyLoad.load('theme/js/angular.pagination.js')
												})
											}]
						  }
					  })
					  .state('app.speedSettled.three', {
						  url: '/speedSettled-three',
						  templateUrl: 'speedSettled/speedSettled-three.jsp',
						  resolve : {deps : ['$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad.load('ui.select').then(
														function() {
															return $ocLazyLoad.load('theme/js/angular.pagination.js')
														})
													}]
								  }
					  })
					  .state('app.speedSettled.final', {
						  url: '/speedSettled-final',
						  templateUrl: 'speedSettled/speedSettled-final.jsp'
					  })
						.state('app.table', {
							url : '/table',
							template : '<div ui-view></div>'
						})
						.state('app.faultalarm',{
							url : '/faultalarm?tabId',
							templateUrl : 'tpl/rtMonitorPage/faultAlarm/faultAlarmList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ngGrid','ui.select')
													.then(function() {
																return $ocLazyLoad
																		.load(['theme/js/controllers/grid.js','theme/js/modal.js', 'theme/js/angular.pagination.js', 'theme/js/controllers/select.js']);
															})
										}]
							}
						})
                        .state('app.wpFaultalarm',{
                            url : '/wpFaultalarm?tabId',
                            templateUrl : 'tpl/wp/rtMonitorPage/faultAlarm/wpFaultAlarmList.jsp',
                            resolve : {
                                deps : [
                                    '$ocLazyLoad',
                                    function($ocLazyLoad) {
                                        return $ocLazyLoad
                                            .load(
                                                'ui.select')
                                            .then(
                                                function() {
                                                    return $ocLazyLoad
                                                        .load('theme/js/modal.js');
                                                })
                                            .then(
                                                function() {
                                                    return $ocLazyLoad
                                                        .load('theme/js/angular.pagination.js');
                                                })
                                            .then(
                                                function() {
                                                    return $ocLazyLoad
                                                        .load('theme/js/controllers/select.js');
                                                })
                                    }]
                            }
                        })
						//历史数据
						.state('app.historyData',{
							url : '/historyData?deviceId&deviceType&pstationid',
							templateUrl : 'tpl/rtMonitorPage/historyData/historyDataList.jsp',
							 resolve: {
								  deps: ['$ocLazyLoad',
									function( $ocLazyLoad ){
									  return $ocLazyLoad.load('ngGrid').then(
											function() {
											return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
										}).then(
												function() {
													return $ocLazyLoad.load('ui.select');
												}).then(
												function() {
													return $ocLazyLoad
															.load('theme/js/angular.pagination.js');
												})
										}]
									}
								})
								.state('app.wpHistoryData',{
									url : '/wpHistoryData?deviceId&deviceType&pstationid',
									templateUrl : 'tpl/wp/rtMonitorPage/historyData/wpHistoryDataList.jsp',
									resolve: {
										deps: ['$ocLazyLoad',
											function( $ocLazyLoad ){
												return $ocLazyLoad.load('ngGrid').then(
													function() {
														return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
													}).then(
													function() {
														return $ocLazyLoad.load('ui.select');
													}).then(
													function() {
														return $ocLazyLoad
															.load('theme/js/angular.pagination.js');
													})
											}]
									}
								})
								//历史电站查询
								.state('app.historyPowerLine',{
									url : '/historyPowerLine',
									templateUrl : 'tpl/rtMonitorPage/historyPowerLine/historyPowerLine.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load('ui.select').then(
																	function() {
																		return $ocLazyLoad
																				.load(['vendor/echarts/testnull.js']);
																	})
												}]
											}
                                })
                                //光伏历史电站查询
                                .state('app.wpHistoryPowerLine',{
                                    url : '/wpHistoryPowerLine',
                                    templateUrl : 'tpl/wp/rtMonitorPage/historyPowerLine/wpHistoryPowerLine.jsp',
                                    resolve : {
                                        deps : [
                                            '$ocLazyLoad',
                                            function($ocLazyLoad) {
                                                return $ocLazyLoad
                                                    .load('ui.select').then(
                                                        function() {
                                                            return $ocLazyLoad
                                                                .load(['vendor/echarts/testnull.js']);
                                                        })
                                            }]
                                    }
                                })
								//历史功率趋势图
								.state('app.historyDeviceLine',{
									url : '/historyDeviceLine',
									templateUrl : 'tpl/rtMonitorPage/historyPowerLine/historyDeviceLine.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
														.load('ui.select')
														.then(
															function() {
																return $ocLazyLoad
																		.load('vendor/echarts/testnull.js');
															}
														)
												}]
											}
										})
                                //光伏历史功率趋势图
                                .state('app.wphistoryDeviceLine',{
                                    url : '/wphistoryDeviceLine',
                                    templateUrl : 'tpl/wp/rtMonitorPage/historyPowerLine/wpHistoryDeviceLine.jsp',
                                    resolve : {
                                        deps : [
                                            '$ocLazyLoad',
                                            function($ocLazyLoad) {
                                                return $ocLazyLoad
                                                    .load('ui.select')
                                                    .then(
                                                        function() {
                                                            return $ocLazyLoad
                                                                .load('vendor/echarts/testnull.js');
                                                        }
                                                    )
                                            }]
                                    }
                                })
							   //设备运行日志查询
								.state('app.devicerunLog',{
									url : '/devicelog',
									templateUrl : 'tpl/rtMonitorPage/devicelog/devicelogList.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load('ui.select')
															.then(
																function() {
																		return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
															.then(
																function() {
																	return $ocLazyLoad
																	.load('ngGrid')
																	.then(function() {
																				return $ocLazyLoad.load('theme/js/controllers/grid.js')
																			});
															})
												}]
											}
										})
									.state('app.wpDevicelog',{
										url : '/wpDevicelog',
										templateUrl : 'tpl/wp/rtMonitorPage/devicelog/wpDevicelogList.jsp',
										resolve : {
											deps : [
													'$ocLazyLoad',
													function($ocLazyLoad) {
														return $ocLazyLoad
																.load('ui.select')
																.then(
																	function() {
																			return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
																.then(
																	function() {
																		return $ocLazyLoad
																		.load('ngGrid')
																		.then(function() {
																					return $ocLazyLoad.load('theme/js/controllers/grid.js')
																				});
																})
													}]
										}
									})

						//锁屏界面
						.state('lockme',{
							url : '/lockme?loginName&realName',
							templateUrl : 'tpl/blocks/page_lockme.jsp'
						})
						.state('app.faultAlarmHand',{
							url : '/faultAlarmHand?faultId&backUrl&recuserId&tabId',
							templateUrl : 'tpl/rtMonitorPage/faultAlarm/faultAlarmHand.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
										}]
							}
						})
						.state('app.table.datatable',{
							url : '/datatable',
							templateUrl : 'tpl/table_datatable.html'
						})
						.state('app.incomeSettlement',{
							url : '/incomeSettlement',
							templateUrl : 'tpl/maintenancePage/incomeSettlement/incomeSettlementList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						.state('app.addIncomeSettlement',{
							url : '/addIncomeSettlement?InId',
							templateUrl : function(
									$stateParams) {
								return 'tpl/maintenancePage/incomeSettlement/addIncomeSettlementSkip.jsp';
							},
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('ui.select')
										}]
							}
						})
						.state('app.paySettlement',{
							url : '/paySettlement',
							templateUrl : 'tpl/maintenancePage/paySettlement/paySettlementList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						.state('app.taskSettlement',{
							url : '/taskSettlement',
							templateUrl : 'tpl/maintenancePage/taskSettlement/taskSettlementList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}

						})
						.state('app.myTaskList',{
							url : '/myTaskList',
							templateUrl : 'tpl/maintenancePage/myTaskList/myTaskList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						.state('app.viewTask',{
							url : '/viewTask?InId&backUrl&recuserId',
							templateUrl : 'tpl/maintenancePage/myTaskList/viewTask.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}

						})
						//派工任务受理
						.state('app.taskRespMan',{
							url : '/taskRespMan?InId&backUrl&recuserId&tabId',
							templateUrl : 'tpl/maintenancePage/taskSettlement/taskRespMan.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}

						})

						.state('app.producePlan',{
							url : '/producePlan',
							templateUrl : 'tpl/maintenancePage/producePlan/producePlanList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										'uiLoad',
										function(
												$ocLazyLoad,
												uiLoad) {
											return uiLoad
													.load(
															[
																	'theme/js/modal.js',
																	'theme/js/angular.pagination.js'])
													.then(
															function() {
																// return
																// $ocLazyLoad.load('ui.calendar');
															})
										}]
							}

						})

						.state('app.addProducePlan',{
							url : '/app.addProducePlan?ppId',
							templateUrl : function(
									$stateParams) {
								return 'tpl/maintenancePage/producePlan/addProducePlan.jsp';
							}
						})

						//台账新页面
						.state('app.powerStationView',{
							url : '/powerStationView?inId&createPower',
							templateUrl : 'tpl/ledgerPage/powerStationView/powerStationDetail.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															}).then(
																	function() {
																		return $ocLazyLoad
																				.load('theme/js/modal.js');
																	})
										}]
							}
						})
						.state('app.powerStation',{
							url : '/powerStation',
							templateUrl : 'tpl/ledgerPage/powerStation/powerStationList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															}).then(
																	function() {
																		return $ocLazyLoad
																				.load('theme/js/modal.js');
																	})
										}]
							}
						})
						.state('app.powerStationConfig',{
							url : '/powerStationConfig',
							templateUrl : 'tpl/ledgerPage/pstationConfig/powerStationDetail.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load('ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																}).then(
																		function() {
																			return $ocLazyLoad
																					.load('theme/js/modal.js');
																		})
											}]
								}

						})
						.state('app.svgManager',{
							url : '/svgManager',
							templateUrl : 'tpl/systemPage/svgManager/svgManagerList.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load('ui.select')
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/angular.pagination.js');
												}).then(
												function() {
													return $ocLazyLoad
														.load('theme/js/modal.js');
												})
									}]
							}
						})
						.state('app.svgCreate',{
							url : '/svgCreate?id',
							templateUrl : 'tpl/systemPage/svgManager/svgManagerCreate.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load('ui.select');
									}]
							}
						})
						//电厂管理
						.state('app.powerFactory',{
							url : '/powerFactory',
							templateUrl : 'tpl/ledgerPage/powerFactory/powerFactoryList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															}).then(
																	function() {
																		return $ocLazyLoad
																				.load('theme/js/modal.js');
																	})
										}]
							}
						})


						.state('app.addPowerStation',{
							url : '/app.addPowerStation?psId',
							templateUrl : function(
									$stateParams) {
								return 'tpl/ledgerPage/powerStation/addPowerStationSkip.jsp';
							},
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
										}]
							}
						})
						//厂区管理
						.state('app.addpowerFactory',{
							url : '/app.addpowerFactory?psId',
							templateUrl : function(
									$stateParams) {
								return 'tpl/ledgerPage/powerFactory/addpowerFactorySkip.jsp';
							},
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
										}]
							}
						})
						//运维信息管理
						.state('app.maintenanceInfo',{
							url : '/maintenanceInfo',
							templateUrl : 'tpl/maintenancePage/maintenanceInfo/maintenanceInfo.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})

						//排班计划
						.state('app.scheduling',{
							url : '/scheduling',
							templateUrl : 'tpl/maintenancePage/maintenanceInfo/scheduling.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										'uiLoad',
										function(
												$ocLazyLoad,
												uiLoad) {
											return uiLoad
													.load(
															[
																	'vendor/jquery/fullcalendar/fullcalendar.css',
																	'vendor/jquery/fullcalendar/theme.css',
																	'vendor/jquery/jquery-ui-1.10.3.custom.min.js',
																	'vendor/libs/moment.min.js',
																	'vendor/jquery/fullcalendar/fullcalendar.min.js'])
													.then(
															function() {
																return $ocLazyLoad
																		.load('ui.calendar');
															})
										}]
							}
						})

						//添加排班信息
						.state('app.manualScheduling',{
							url : '/app.manualScheduling',
							templateUrl : function(
									$stateParams) {
								return 'tpl/maintenancePage/maintenanceInfo/manualScheduling.jsp';
							},
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
										}]
							}
						})
						.state('app.equipment',{
							url : '/equipment',
							templateUrl : 'tpl/data/app_equipment.html'
						})
						.state('app.operating',{
							url : '/operating',
							templateUrl : 'tpl/data/app_operating .html'
						})
						.state('app.modelConfig',{
							url : '/modelConfig',
							templateUrl : 'tpl/ledgerPage/modelConfig/modelConfigList.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load(
												'ui.select')
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/modal.js');
												})
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/angular.pagination.js');
												})
									}]
							}
						})
						.state('app.manufacturer',{
							url : '/manufacturer',
							templateUrl : 'tpl/ledgerPage/manufacturer/manufacturerList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						.state('app.addManufacturer',{
							url : '/app.addManufacturer?manId&pid',
							templateUrl : function(
									$stateParams) {
								return 'tpl/ledgerPage/manufacturer/addManufacturerSkip.jsp';
							}
						})
                        .state('app.baseDictionary',{
                            url : '/baseDictionary',
                            templateUrl : 'tpl/ledgerPage/baseDictionary/baseDictionaryList.jsp',
                            resolve : {
                                deps : [
                                    '$ocLazyLoad',
                                    function($ocLazyLoad) {
                                        return $ocLazyLoad
                                            .load(
                                                'ui.select')
                                            .then(
                                                function() {
                                                    return $ocLazyLoad
                                                        .load('theme/js/modal.js');
                                                })
                                            .then(
                                                function() {
                                                    return $ocLazyLoad
                                                        .load('theme/js/angular.pagination.js');
                                                })
                                    }]
                            }
                        })
                        .state('app.addBaseDictionary',{
                            url : '/app.addBaseDictionary',
                            templateUrl : function(
                                $stateParams) {
                                return 'tpl/ledgerPage/baseDictionary/addBaseDictionary.jsp';
                            }
                        })
						.state('app.systemOperationLog',{
							url : '/systemOperationLog',
							templateUrl : 'tpl/systemPage/systemOperationLog/systemOperationLogList.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load(
												'ui.select')
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/modal.js');
												})
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/angular.pagination.js');
												})
									}]
							}
						})
						.state('app.product',{
							url : '/product',
							templateUrl : 'tpl/ledgerPage/product/productList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						//总线
						.state('app.pbuscfg',{
								url : '/pbuscfg',
								templateUrl : 'tpl/ledgerPage/pbuscfg/PBuscfgList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
						//总线
						.state('app.addpbuscfg',{
								url : '/addpbuscfg?InId',
								templateUrl : 'tpl/ledgerPage/pbuscfg/addPBuscfg.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
						//新协议配置
						.state('app.powerConfig',{
								url : '/powerConfig?inId',
								templateUrl : 'tpl/ledgerPage/pstationConfig/powerStationDetail.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})

						//协议配置
						.state('app.protocol',{
								url : '/protocol',
								templateUrl : 'tpl/ledgerPage/protocol/protocolList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})

						//电站软件版本
						.state('app.pstationDatacoll',{
							url : '/pstationDatacoll',
								templateUrl : 'tpl/ledgerPage/pstationDatacoll/pstationDatacollList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})

							.state('app.addProtocol',{
								url : '/addProtocol?InId&copyId',
								templateUrl : 'tpl/ledgerPage/protocol/addProtocol.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							//通讯规约
							.state('app.commProtocol',{
								url : '/commProtocol',
								templateUrl : 'tpl/ledgerPage/commProtocol/commProtocolList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})

							.state('app.addCommProtocol',{
								url : '/addCommProtocol?InId',
								templateUrl : 'tpl/ledgerPage/commProtocol/addCommProtocol.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})

							.state('app.faultCode',{
								url : '/faultCode',
								templateUrl : 'tpl/ledgerPage/faultCode/faultCodeList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addFaultCode', {
								url : '/app.addFaultCode?id',
								templateUrl : function($stateParams) {
									return 'tpl/ledgerPage/faultCode/addFaultCodeSkip.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
											}]
								}
							})
							.state('app.boxChange', {
								url : '/boxChange',
								templateUrl : 'tpl/ledgerPage/boxChange/boxChangeList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addBoxChange', {
								url : '/app.addBoxChange?InId',
								templateUrl : function($stateParams) {
									return 'tpl/ledgerPage/boxChange/addBoxChange.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addOtherDevice', {
								url : '/app.addOtherDevice?InId',
								templateUrl : function($stateParams) {
									return 'tpl/ledgerPage/otherDevice/addOtherDevice.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.powerAnalysis', {
								url : '/powerAnalysis',
								templateUrl : 'tpl/dataAnalysisPage/powerAnalysis.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return uiLoad
														.load(
																[
																		'theme/js/modal.js',
																		'vendor/echarts/echarts.js'])
														.then(
																function() {
																	return $ocLazyLoad
																			.load('ui.calendar');
																})
											}]
								}
							})
							.state('app.opdeviceExperiment', {
								url : '/opdeviceExperiment',
								templateUrl : 'tpl/operationmanagePage/opdeviceexperiment/experimentList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return uiLoad
														.load(
																[
																		'theme/js/modal.js',
																		'vendor/echarts/echarts.js'])
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addexperiment', {
								url : '/addexperiment?InId',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/opdeviceexperiment/addexperiment.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
											}]
								}
							})
							.state('app.experimentDetail', {
								url : '/replacedDetail',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/opdeviceexperiment/experimentDetail.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load([
																					'vendor/echarts/echarts.js',
																					'theme/js/controllers/chart.js']);
																})
											}]
								}
							})
							.state('app.opdeviceReplaced', {
								url : '/opdeviceReplaced',
								templateUrl : 'tpl/operationmanagePage/opdevicereplaced/replacedList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return uiLoad
														.load(
																[
																		'theme/js/modal.js',
																		'vendor/echarts/echarts.js'])
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addreplaced', {
								url : '/addreplaced?InId',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/opdevicereplaced/addreplaced.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.replacedDetail', {
								url : '/replacedDetail',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/opdevicereplaced/repairDetail.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load([
																					'vendor/echarts/echarts.js',
																					'theme/js/controllers/chart.js']);
																})
											}]
								}
							})
							.state('app.opdeviceRepair', {
								url : '/opdeviceRepair',
								templateUrl : 'tpl/operationmanagePage/opdevicerepair/repairList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return uiLoad
														.load(
																[
																		'theme/js/modal.js',
																		'vendor/echarts/echarts.js'])
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addrepair', {
								url : '/addrepair?InId',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/opdevicerepair/addrepair.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
											}]
								}
							})
							.state('app.repairDetail', {
								url : '/repairDetail',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/opdevicerepair/repairDetail.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load([
																					'vendor/echarts/echarts.js',
																					'theme/js/controllers/chart.js']);
																})
											}]
								}
							})

							//预警阀值
							.state('app.faultThreshold', {
								url : '/faultThreshold',
								templateUrl : 'tpl/operationmanagePage/faultthreshold/faultThresholdList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return uiLoad
														.load(
																[
																		'theme/js/modal.js'
																		])
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})

							.state('app.addfaultThreshold', {
								url : '/addfaultThreshold?InId',
								templateUrl : function($stateParams) {
									return 'tpl/operationmanagePage/faultthreshold/addfaultThreshold.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
											}]
								}
							})
							.state('app.inverterDetail', {
								url : '/inverterDetail?InId&serialnumber&pstationid',
								templateUrl : 'tpl/ledgerPage/inverter/inverterDetail.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return $ocLazyLoad
												.load('ngGrid')
												.then(function() {
															return $ocLazyLoad.load('theme/js/controllers/grid.js')
														})
														.then(
																		function() {
																			return $ocLazyLoad.load(['theme/js/modal.js',
																										'vendor/echarts/echarts.js'])
																		}).then(
																function() {
																	return $ocLazyLoad
																			.load('ui.calendar');
																}).then(
																		function() {
																			return $ocLazyLoad.load('theme/js/angular.pagination.js')
																		})
											}]
								}
							})
							.state('app.BoxChangeDetail', {
								url : '/BoxChangeDetail?InId&serialnumber&pstationid&sizeFlag',
								templateUrl : 'tpl/ledgerPage/boxChange/boxChangeDetail.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return $ocLazyLoad
												.load('ngGrid')
												.then(function() {
															return $ocLazyLoad.load('theme/js/controllers/grid.js')
														})
														.then(
																		function() {
																			return $ocLazyLoad.load(['theme/js/modal.js',
																										'vendor/echarts/echarts.js'])
																		}).then(
																function() {
																	return $ocLazyLoad
																			.load('ui.calendar');
																}).then(
																		function() {
																			return $ocLazyLoad.load('theme/js/angular.pagination.js')
																		})
											}]
								}
							})

							.state('app.otherDeviceDetail', {
								url : '/otherDeviceDetail?InId&serialnumber&pstationid',
								templateUrl : 'tpl/ledgerPage/otherDevice/otherDeviceDetail.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											'uiLoad',
											function($ocLazyLoad,
													uiLoad) {
												return uiLoad
														.load(
																[
																		'theme/js/modal.js',
																		'vendor/echarts/echarts.js'])
														.then(
																function() {
																	return $ocLazyLoad
																			.load('ui.calendar');
																}).then(
																		function() {
																			return $ocLazyLoad
																					.load('theme/js/angular.pagination.js');
																		}).then(
																				function() {
																					return $ocLazyLoad.load('ngGrid').then(
																							function() {
																								return $ocLazyLoad
																										.load('theme/js/controllers/grid.js');
																							})
																				})
											}]
								}
							})

							.state('app.inverter',{
								url : '/inverter?boxChangeId',
								templateUrl : 'tpl/ledgerPage/inverter/inverterList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.generationAnalysis',{
								url : '/generationAnalysis',
								templateUrl : 'tpl/dataAnalysisPage/generationAnalysis.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load([
																'vendor/echarts/echarts.js',
																'theme/js/modal.js']);
											}]
								}
							})
							.state('app.addInverter',{
								url : '/app.addInverter?InId',
								templateUrl : function($stateParams) {
									return 'tpl/ledgerPage/inverter/addInverterSkip.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
											}]
								}
							})
							.state('app.junctionBox',{
								url : '/junctionBox?inverterId',
								templateUrl : 'tpl/ledgerPage/junctionBox/junctionBoxList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.addJunctionBox',{
								url : '/app.addJunctionBox?JbId',
								templateUrl : function($stateParams) {
									return 'tpl/ledgerPage/junctionBox/addJunctionBoxSkip.jsp';
								},
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
											}]
								}
							})
							.state('app.otherDevice',{
								url : '/otherDevice',
								templateUrl : 'tpl/ledgerPage/otherDevice/otherDeviceList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.inverterMonitor?devId',{
								url : '/inverterMonitor',
								templateUrl : 'tpl/rtMonitorPage/inverter/inverterMonitorIndex.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load([
																					'vendor/echarts/echarts.js',
																					'theme/js/controllers/chart.js']);
																})
											}]
								}
							})
							.state('app.junctionBoxMonitor',{
								url : '/junctionBoxMonitor?InId&serialnumber&pstationid',
								templateUrl : 'tpl/ledgerPage/junctionBox/junctionBoxDetail.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load([
																					'vendor/echarts/echarts.js',
																					'theme/js/controllers/chart.js']);
																}).then(
																		function() {
																			return $ocLazyLoad.load('theme/js/angular.pagination.js')
																		}).then(
																				function() {
																					return $ocLazyLoad.load('ngGrid').then(
																							function() {
																								return $ocLazyLoad
																										.load('theme/js/controllers/grid.js');
																							})
																				})
											}]
								}
							})
							.state('app.deviceStation',{
								url : '/deviceStation?stationId&stationName',
								templateUrl : 'tpl/rtMonitorPage/deviceStation/deviceStationIndex.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load('ngGrid')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js','theme/js/controllers/grid.js')
																})
											}]
								}
							})
                            .state('app.wpDeviceLayout',{
                                url : '/wpDeviceLayout?stationId&stationName',
                                templateUrl : 'tpl/wp/rtMonitorPage/deviceLayout/wpDeviceLayoutIndex.jsp',
                                resolve : {
                                    deps : [
                                        '$ocLazyLoad',
                                        function($ocLazyLoad) {
                                            return $ocLazyLoad
                                                .load(
                                                    'ui.select')
                                                .then(
                                                    function() {
                                                        return $ocLazyLoad
                                                            .load([
                                                                'theme/js/modal.js',
                                                                'theme/js/angular.pagination.js',
                                                                'vendor/echarts/echarts.js']);
                                                    })
                                        }]
                                }
                            })
							.state('app.opentrust',{
								url : '/opentrust',
								templateUrl : 'tpl/ledgerPage/opentrust/opentrustList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('apps.userInformation',{
								url : '/userInformation',
								templateUrl : 'tpl/systemPage/companyDepartment/managePerson.jsp',//'tpl/systemPage/userInformation/userInformationList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.loginUserInformation',{
								url : '/loginUser',
								templateUrl : 'tpl/systemPage/userInformation/loginUserInformation.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('apps.powerStationGroup',{
								url : '/powerStationGroup',
								templateUrl : 'tpl/systemPage/powerstationGroup/powerstationgroup.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.loginUserPassword',{
								url : '/loginUser',
								templateUrl : 'tpl/systemPage/userInformation/loginUserPassword.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.user',{
								url : '/user',
								templateUrl : 'tpl/data/app_user.html',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load('ui.select')
											}]
								}
							})
						// fullCalendar
						.state('app.customer',{
									url : '/customer',
									templateUrl : 'tpl/data/app_customer.html'
								})
						.state('app.boxChange_para',{
									url : '/boxChange_para',
									templateUrl : 'tpl/data/app_boxChange_para.html'
								})
						.state('app.inverter_para',{
									url : '/inverter_para',
									templateUrl : 'tpl/data/app_inverter_para.html'
								})
						.state('app.junctionBox_para',{
									url : '/junctionBox_para',
									templateUrl : 'tpl/data/app_junctionBox_para.html'
								})
						.state('app.role', {
							url : '/role',
							templateUrl : 'tpl/data/app_role.html'
						})
						.state('apps.roleInformation',{
							url : '/roleInformation',
							templateUrl : 'tpl/systemPage/companyDepartment/manageRole.jsp',//'tpl/systemPage/roleInformation/roleInformationList.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															[
																	'ui.select',
																	'angularBootstrapNavTree'])
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load([
																				'theme/js/angular.pagination.js',
																				'theme/js/controllers/tree.js']);
															})
										}]
									}
						})
						.state('apps.baseRegion',{
							url : '/baseRegion',
							templateUrl : 'tpl/systemPage/baseregion/baseRegion.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load(
												[
													'ui.select',
													'angularBootstrapNavTree'])
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/modal.js');
												})
											.then(
												function() {
													return $ocLazyLoad
														.load([
															'theme/js/angular.pagination.js',
															'theme/js/controllers/tree.js']);
												})
									}]
							}
						})
						.state('app.rightInformation',{
								url : '/rightInformation',
								templateUrl : 'tpl/systemPage/rightInformation/rightInformationList.jsp',
								resolve : {
									deps : [
											'$ocLazyLoad',
											function($ocLazyLoad) {
												return $ocLazyLoad
														.load(
																'ui.select')
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/modal.js');
																})
														.then(
																function() {
																	return $ocLazyLoad
																			.load('theme/js/angular.pagination.js');
																})
											}]
								}
							})
							.state('app.basemessage',{
								url : '/basemessage?recuserId&sendstatus',
								templateUrl : 'tpl/systemPage/basemessage/list.jsp',
								resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('theme/js/angular.pagination.js')
										}]
								}
							})
							.state('app.company',{
								url : '/company',
								templateUrl : 'tpl/systemPage/companyDepartment/companyDepartment.jsp',
								resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('theme/js/angular.pagination.js')
										}]
								}
							})

							//角色管理
							.state('apps.manageRole',{
								url : '/manageRole',
								templateUrl : 'tpl/systemPage/companyDepartment/manageRole.jsp',
								resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('theme/js/angular.pagination.js')
										}]
								}
							})
							//人员管理
							.state('apps.managePerson',{
								url : '/managePerson',
								templateUrl : 'tpl/systemPage/companyDepartment/managePerson.jsp',
								resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('theme/js/angular.pagination.js')
										}]
								}
							})
							//企业信息
							.state('app.companyDepartmentInfo',{
								url : '/companyDepartmentInfo',
								templateUrl : 'tpl/systemPage/companyDepartment/companyDepartment.jsp',
								resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('theme/js/angular.pagination.js')
										}]
								}
							})
							.state('app.addCompany',{
									url : '/app.addCompany?cmId',
									templateUrl : function(
											$stateParams) {
										return 'tpl/systemPage/company/addCompanySkip.jsp';
									},
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load(
																	'ui.select')
															.then(
																	function() {
																		return $ocLazyLoad
																				.load('theme/js/modal.js');
																	})
												}]
									}
							})
							.state('app.addOpentrust',{
									url : '/app.addOpentrust?comId',
									templateUrl : function(
											$stateParams) {
										return 'tpl/ledgerPage/opentrust/addopentrust.jsp';
									},
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load(
																	'ui.select')
															.then(
																	function() {
																		return $ocLazyLoad
																				.load('theme/js/modal.js');
																	})
												}]
									}
							})
							.state('app.addCompanyDepartment',{
									url : '/app.addCompanyDepartment?cmId',
									templateUrl : function(
											$stateParams) {
										return 'tpl/systemPage/companyDepartment/addCompanyDepartmentSkip2.jsp';
									},
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load(
																	'ui.select')
															.then(
																	function() {
																		return $ocLazyLoad
																				.load('theme/js/modal.js');
																	})
												}]
									}
							})
							.state('app.faultLoss',{
									url : '/faultLoss',
									templateUrl : 'tpl/dataAnalysisPage/faultLoss/faultLossAnalysis.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load([
																	'vendor/echarts/echarts.js',
																	'theme/js/modal.js']);
												}]
									}
							})
							.state('app.faultAlarmAnalysis',{
									url : '/faultAlarmAnalysis',
									templateUrl : 'tpl/dataAnalysisPage/faultAlarmAnalysis/faultAlarmAnalysis.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load(
																	'ui.select')
															.then(
																	function() {
																		return $ocLazyLoad
																				.load('vendor/echarts/echarts.js');
																	})
												}]
									}
							})
							.state('app.generatingEfficiency',{
									url : '/generatingEfficiencyAnalysis',
									templateUrl : 'tpl/dataAnalysisPage/generatingEfficiency.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load([
																	'vendor/echarts/echarts.js',
																	'theme/js/modal.js']);
												}]
									}
							})
							.state('app.historyFaultAlarmStatistics',{
									url : '/historyFaultAlarmStatistics',
									templateUrl : 'tpl/dataAnalysisPage/historyFaultAlarmStatistics/historyFaultAlarmStatistics.jsp',
									resolve : {
										deps : [
												'$ocLazyLoad',
												function($ocLazyLoad) {
													return $ocLazyLoad
															.load(
																	'ui.select')
															.then(
																	function() {
																		return $ocLazyLoad
																				.load('vendor/echarts/echarts.js');
																	})
												}]
									}
							})
							//日期插件
						 .state('app.calendar', {
						  url: '/calendar',
						  templateUrl: 'tpl/app_calendar.html',
						  // use resolve to load other dependences
						  resolve: {
							  deps: ['$ocLazyLoad', 'uiLoad',
								function( $ocLazyLoad, uiLoad ){
								  return uiLoad.load(
									['vendor/jquery/fullcalendar/fullcalendar.css',
									  'vendor/jquery/fullcalendar/theme.css',
									  'vendor/libs/moment.min.js',
									  'vendor/jquery/fullcalendar/fullcalendar.min.js',
									  'theme/js/app/calendar/calendar.js']
								  ).then(
									function(){
									  return $ocLazyLoad.load('ui.calendar');
									}
								  )
							  }]
						  }
					  })
					  //知识库
					  .state('app.knowledge', {
							url : '/knowledge',
							templateUrl : 'tpl/knowledgePage/knowledge.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/modal.js');
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						//知识库汇总（查询展示）
					  .state('app.knowledgeBaseSummary', {
							url : '/knowledgeBaseSummary',
							templateUrl : 'tpl/knowledgePage/summaryQuery/knowledgeBaseQuery.jsp',
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load(
															'ui.select')
													.then(
															function() {
																return $ocLazyLoad
																		.load(['theme/js/modal.js','theme/css/knowledgeBase/knowledgeBaseQuery.css']);
															})
													.then(
															function() {
																return $ocLazyLoad
																		.load('theme/js/angular.pagination.js');
															})
										}]
							}
						})
						.state('app.addShareRepos', {
							url : '/app.addShareRepos?id&type',
							templateUrl : function(
									$stateParams) {
								return 'tpl/knowledgePage/shareRepository/shareRepositoryAdd.jsp';
							},
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('ui.select')
										}]
							}
						})
						.state('app.detailShareRepos', {
							url : '/app.detailShareRepos?id',
							templateUrl : function(
									$stateParams) {
								return 'tpl/knowledgePage/shareRepository/shareRepositoryDetail.jsp';
							},
							resolve : {
								deps : [
										'$ocLazyLoad',
										function($ocLazyLoad) {
											return $ocLazyLoad
													.load('ui.select')
										}]
							}
						})
						.state('app.addMaintainAdvise', {
							url: '/app.addMaintainAdise?type',
							templateUrl: 'tpl/knowledgePage/shareRepository/maintainAdviseAdd.jsp',
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load(['ui.select','toaster']);
									}]
							}
						})
						.state('app.statistics', {
							url: '/statistics',
							templateUrl: "tpl/statisticAnalysisPage/statsticAnalysis.jsp",
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load([
												'vendor/echarts/echarts.js',
												'toaster',
												'theme/js/modal.js'
											]);
									}]
							}
						})
						.state('app.statistics.staDay', {
							url: '/staDay?roleId',
							templateUrl: "tpl/statisticAnalysisPage/stat/staDay.jsp",
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load([
												'vendor/echarts/echarts.js',
												'toaster',
												'theme/js/modal.js',
												'tpl/statisticAnalysisPage/css/solway.css'
											]);
									}]
							}
						})
						.state('app.statistics.staMon', {
							url: '/staDay?roleId',
							templateUrl: "tpl/statisticAnalysisPage/stat/staMon.jsp",
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load([
												'vendor/echarts/echarts.js',
												'toaster',
												'theme/js/modal.js',
												'tpl/statisticAnalysisPage/css/solway.css'
											]);
									}]
							}
						})
						.state('app.statistics.staYear', {
							url: '/staDay?roleId',
							templateUrl: "tpl/statisticAnalysisPage/stat/staYear.jsp",
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load([
												'vendor/echarts/echarts.js',
												'toaster',
												'theme/js/modal.js',
												'tpl/statisticAnalysisPage/css/solway.css'
											]);
									}]
							}
						})
						.state('app.statistics.staAll', {
							url: '/staDay?roleId',
							templateUrl: "tpl/statisticAnalysisPage/stat/staAll.jsp",
							resolve : {
								deps : ['$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load([
												'vendor/echarts/echarts.js',
												'toaster',
												'theme/js/modal.js',
												'tpl/statisticAnalysisPage/css/solway.css'
											]);
									}]
							}
						})
						.state('app.roleInformationList', {
							url: '/roleInformationList',
							templateUrl: "tpl/systemPage/roleInformation/roleInformationList.jsp",
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load(
												'ui.select')
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/modal.js');
												})
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/angular.pagination.js');
												})
									}]
							}
						})
						.state('app.userInformation', {
							url: '/userInformation',
							templateUrl: "tpl/systemPage/userInformation/userInformationList.jsp",
							resolve : {
								deps : [
									'$ocLazyLoad',
									function($ocLazyLoad) {
										return $ocLazyLoad
											.load(
												'ui.select')
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/modal.js');
												})
											.then(
												function() {
													return $ocLazyLoad
														.load('theme/js/angular.pagination.js');
												})
									}]
							}
						})
			.state('app.wpOverview',{
				url : '/wpOverview',
				templateUrl : 'tpl/wp/analysisView/overview/wpOverview.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpResourceAnalysis',{
				url : '/wpResourceAnalysis',
				templateUrl : 'tpl/wp/analysisView/resourceAnalysis/wpResourceAnalysis.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpPowerAnalysis',{
				url : '/wpPowerAnalysis',
				templateUrl : 'tpl/wp/analysisView/powerAnalysis/wpPowerAnalysis.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpFaultAnalysis',{
				url : '/wpFaultAnalysis',
				templateUrl : 'tpl/wp/analysisView/faultAnalysis/wpFaultAnalysis.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpPerformsAnalysis',{
				url : '/wpPerformsAnalysis',
				templateUrl : 'tpl/wp/analysisView/performsAnalysis/wpPerformsAnalysis.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpSyntheticEvaluation',{
				url : '/wpSyntheticEvaluation',
				templateUrl : 'tpl/wp/analysisView/syntheticEvaluation/wpSyntheticEvaluation.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpOrder',{
				url : '/wpOrder',
				templateUrl : 'tpl/wp/analysisView/order/wpOrder.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpPowerLineAnalysis',{
				url : '/wpPowerLineAnalysis',
				templateUrl : 'tpl/wp/analysisView/powerLineAnalysis/wpPowerLineAnalysis.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpOrderClassPlan',{
				url : '/wpOrderClassPlan',
				templateUrl : 'tpl/wp/manageView/orderClassPlan/wpOrderClassPlan.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpProductPlan',{
				url : '/wpProductPlan',
				templateUrl : 'tpl/wp/manageView/productPlan/wpProductPlan.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpShiftTurnover',{
				url : '/wpShiftTurnover',
				templateUrl : 'tpl/wp/manageView/shiftTurnover/wpShiftTurnover.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpTeamManage',{
				url : '/wpTeamManage',
				templateUrl : 'tpl/wp/manageView/teamManage/wpTeamManage.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpWorkOrder',{
				url : '/wpWorkOrder',
				templateUrl : 'tpl/wp/manageView/workOrder/wpWorkOrder.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpPowerAccount',{
				url : '/wpPowerAccount',
				templateUrl : 'tpl/wp/accountView/powerAccount/wpPowerAccount.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.wpRunConfig',{
				url : '/wpRunConfig',
				templateUrl : 'tpl/wp/accountView/runConfig/wpRunConfig.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.orderClassPlan',{
				url : '/orderClassPlan',
				templateUrl : 'tpl/ledgerPage/orderClassPlan/orderClassPlan.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.shiftTurnover',{
				url : '/shiftTurnover',
				templateUrl : 'tpl/ledgerPage/shiftTurnover/shiftTurnover.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.teamManage',{
				url : '/teamManage',
				templateUrl : 'tpl/ledgerPage/teamManage/teamManage.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.workOrder',{
				url : '/workOrder',
				templateUrl : 'tpl/ledgerPage/workOrder/workOrder.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.msKnowledge',{
				url : '/msKnowledge',
				templateUrl : 'tpl/ledgerPage/msKnowledge/msKnowledge.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			.state('app.stationLayout',{
				url : '/stationLayout',
				templateUrl : 'tpl/ledgerPage/stationLayout/stationLayout.jsp',
				resolve : {
					deps : ['$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(['toaster','theme/js/modal.js'])
						}]
				}
			})
			//电能站
			.state('app.meterMonitoring',{
				url : '/meterMonitoring?dataType',
				templateUrl : 'tpl/meter/rtMonitorPage/monitor/meterMonitoring.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load([
									'theme/js/modal.js','ngGrid'])
								.then(function() {
									return $ocLazyLoad.load('theme/js/controllers/grid.js')
								});
						}]
				}
			})
			//矩阵视图-（电能）
			.state('app.meterDeviceLayout',{
				url : '/meterDeviceLayout?stationId&stationName',
				templateUrl : '	tpl/meter/rtMonitorPage/monitor/deviceLayout/deviceLayout.jsp',
				resolve : {
				deps: ['$ocLazyLoad',
					function( $ocLazyLoad ){
					  return $ocLazyLoad.load('ngGrid','ui.select').then(
							function() {
							return $ocLazyLoad.load(['theme/js/controllers/toaster.js']);
						}).then(
								function() {
									return $ocLazyLoad
											.load([
												   'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
												   'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
								})
				  }]
				}
			})
			//布局视图-（电能）
			.state('app.meterDeviceLayoutView',{
				url : '/meterDeviceLayoutView?stationId',
				templateUrl : 'tpl/meter/rtMonitorPage/monitor/deviceLayout/deviceLayoutView.jsp',
				resolve : {
					deps: ['$ocLazyLoad',
						function( $ocLazyLoad ){
							return $ocLazyLoad.load('ngGrid','ui.select').then(
								function() {
									return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
								}).then(
								function() {
									return $ocLazyLoad
										.load([
											'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
											'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
								})
						}]
				}
			})
			//列表视图-（电能）
			.state('app.meterDeviceList',{
				url : '/meterDeviceList?stationId&stationName',
				templateUrl : '	tpl/meter/rtMonitorPage/monitor/deviceLayout/deviceList.jsp',
				resolve : {
				deps: ['$ocLazyLoad',
					function( $ocLazyLoad ){
					  return $ocLazyLoad.load('ngGrid','ui.select').then(
							function() {
							return $ocLazyLoad.load(['theme/js/controllers/grid.js','theme/js/controllers/toaster.js']);
						}).then(
								function() {
									return $ocLazyLoad
											.load([
												   'tpl/rtMonitorPage/deviceLayout/js/d3.min.js',
												   'vendor/jquery/jquery-ui-1.10.3.custom.min.js','theme/js/angular.pagination.js']);
								})
				  }]
				}
			})
			//总功率趋势图
			.state('app.meterHistoryPowerLine',{
				url : '/meterHistoryPowerLine',
				templateUrl : 'tpl/meter/rtMonitorPage/monitor/historyPowerLine/historyPowerLine.jsp',
				resolve : {
					deps : [
							'$ocLazyLoad',
							function($ocLazyLoad) {
								return $ocLazyLoad
										.load('ui.select').then(
												function() {
													return $ocLazyLoad
															.load(['vendor/echarts/testnull.js']);
												})
							}]
						}
            })
			//设备趋势图
            .state('app.meterHistoryDeviceLine',{
				url : '/meterHistoryDeviceLine',
				templateUrl : 'tpl/meter/rtMonitorPage/monitor/historyPowerLine/historyDeviceLine.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load('ui.select')
								.then(
									function() {
										return $ocLazyLoad
												.load('vendor/echarts/testnull.js');
									}
								)
					}]
				}
			})
			//视频
			.state('app.video',{
				url : '/video',
				templateUrl : 'tpl/rtMonitorPage/video/showVideo.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			//系统数据修改操作记录
			.state('app.systemDataInit',{
				url : '/systemDataInit',
				templateUrl : 'tpl/systemPage/systemDataInit/systemDataInitList.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			//系统报表审批角色管理
			.state('app.wfRoleManage',{
				url : '/wfRoleManage?componyId',
				templateUrl : 'tpl/systemPage/wfRoleManage/list.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			/**
			 * workflow start
			 */
			.state('app.flowAccess',{
				url : '/flowAccess?processId&processName&orderId&taskId&taskKey&taskName',
				templateUrl : 'snaker/flow/access.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			.state('app.activityTask',{
				url : '/activityTask',
				templateUrl : 'snaker/task/activityTaskList.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			.state('app.historyTask',{
				url : '/historyTask',
				templateUrl : 'snaker/task/historyTaskList.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			.state('app.flowOrder',{
				url : '/flowOrder',
				templateUrl : 'snaker/order/orderList.jsp',
				resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad
								.load(
								'ui.select')
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/modal.js');
								})
								.then(
								function() {
									return $ocLazyLoad
										.load('theme/js/angular.pagination.js');
								})
						}]
				}
			})
			
			//***************************大唐**************************
			//报表
			.state('app.DTReportDay', {
				  url: '/DTReportDay',
				  templateUrl: 'tpl/datang/reportPage/dayReport/dayReportHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})

			//工作票-填报
			.state('app.workTicketFill', {
				  url: '/workTicketFill',
				  templateUrl: 'tpl/datang/reportPage/workTicketFill/workTicketHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
			//操作票-填报
			.state('app.operationTicketFill', {
				  url: '/operationTicketFill',
				  templateUrl: 'tpl/datang/reportPage/operationTicketFill/operationTicketHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
			//缺陷管理
			.state('app.defectManagement', {
				  url: '/defectManagement',
				  templateUrl: 'tpl/datang/reportPage/defectManagement/defectManagementHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
			//大唐月报-填报
			.state('app.DTReportMonth', {
				  url: '/DTReportMonth',
				  templateUrl: 'tpl/datang/reportPage/monthReport/monthReportList.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
            //大唐周报 -填报
            .state('app.DTReportWeek', {
                url: '/DTReportWeek',
                templateUrl: 'tpl/datang/reportPage/weekReport/weekReportList.jsp',
                resolve : {
                    deps : [
                        '$ocLazyLoad',
                        function($ocLazyLoad) {
                            return $ocLazyLoad
                                .load('theme/js/angular.pagination.js')
                        }]
                }
            })
			//两票分析-单个电站
			.state('app.dtAnalysisTwoTicketForStation', {
				  url: '/dtAnalysisTwoTicketForStation',
				  templateUrl: 'tpl/datang/reportPage/ticketAnalysis/ticketAnalysisHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
			//两票分析-多个电站（公司）
			.state('app.dtAnalysisTwoTicketForCompany', {
				  url: '/dtAnalysisTwoTicketForStation/:id',
				  templateUrl: 'tpl/datang/reportPage/ticketAnalysis/ticketAnalysisCompanyHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
			//调度指令记录
			.state('app.dtDispatchInstruction', {
				  url: '/dtDispatchInstruction',
				  templateUrl: 'tpl/datang/reportPage/dispatchInstruction/dispatchInstructionHomePage.jsp',
				  resolve : {
						deps : [
								'$ocLazyLoad',
								function($ocLazyLoad) {
									return $ocLazyLoad
											.load('theme/js/angular.pagination.js')
								}]
					}
			})
			//大唐日报汇总
			.state('app.DTReportDaySum', {
				  url: '/DTReportDaySum',
				  templateUrl: 'tpl/datang/reportPage/reportDaySum/index.jsp'
			})
			//大唐日报各电站日数据
			.state('app.DTReportDaySum.powerStation',{
				url : '/powerStation',
				templateUrl : 'tpl/datang/reportPage/reportDaySum/powerStation.jsp'
			})
			//大唐日报生产数据
			.state('app.DTReportDaySum.productData',{
				url : '/productData',
				templateUrl : 'tpl/datang/reportPage/reportDaySum/productionData.jsp'
			})
			//大唐日报 缺陷管理
			.state('app.DTReportDaySum.defectManage',{
				url : '/defectManage',
				templateUrl : 'tpl/datang/reportPage/reportDaySum/defectManage.jsp'
			})
			//大唐日报 工作简报
			.state('app.DTReportDaySum.workBriefing',{
				url : '/workBriefing',
				templateUrl : 'tpl/datang/reportPage/reportDaySum/workBriefing.jsp'
			})
			//大唐日报 工作票
			.state('app.DTReportDaySum.workTicket',{
				url : '/workTicket',
				templateUrl : 'tpl/datang/reportPage/reportDaySum/workTicket.jsp'
			})
			//大唐日报 操作票
			.state('app.DTReportDaySum.operationTicket',{
				url : '/operationTicket',
				templateUrl : 'tpl/datang/reportPage/reportDaySum/operationTicket.jsp'
			})

			//----大唐周报汇总-----
			.state('app.DTReportWeekSum', {
				  url: '/DTReportWeekSum',
				  templateUrl: 'tpl/datang/reportPage/reportWeekSum.jsp'
			})
			//大唐周报 生产周数据
			.state('app.DTReportWeekSum.productWeekData', {
				  url: '/productWeekData',
				  templateUrl: 'tpl/datang/reportPage/reportWeekSum/productWeekData.jsp'
			})
			//大唐周报 缺陷管理
			.state('app.DTReportWeekSum.defectManage', {
				  url: '/defectManage',
				  templateUrl: 'tpl/datang/reportPage/reportWeekSum/defectManage.jsp'
			})
			//大唐周报 操作票
			.state('app.DTReportWeekSum.operationOrder', {
				  url: '/operationOrder',
				  templateUrl: 'tpl/datang/reportPage/reportWeekSum/operationOrder.jsp'
			})
			//大唐周报 周工作计划
			.state('app.DTReportWeekSum.weekWorkPlan', {
				  url: '/weekWorkPlan',
				  templateUrl: 'tpl/datang/reportPage/reportWeekSum/weekWorkPlan.jsp'
			})
			//大唐周报 工作票
			.state('app.DTReportWeekSum.workOrder', {
				  url: '/workOrder',
				  templateUrl: 'tpl/datang/reportPage/reportWeekSum/workOrder.jsp'
			})
			//月报汇总
			.state('app.DTReportMonthSum', {
				  url: '/DTReportMonthSum',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/index.jsp'
			})
			//月报汇总 生产月数据
			.state('app.DTReportMonthSum.productData', {
				  url: '/productData',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/productionData.jsp'
			})
			//月报汇总 月工作总结
			.state('app.DTReportMonthSum.workSummary', {
				  url: '/workSummary',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/workSummary.jsp'
			})
			//月报汇总 却邪管理
			.state('app.DTReportMonthSum.defectManage', {
				  url: '/defectManage',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/defectManage.jsp'
			})
			//月报汇总 工作票
			.state('app.DTReportMonthSum.workTicket', {
				  url: '/workTicket',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/workTicket.jsp'
			})
			//月报汇总 操作票
			.state('app.DTReportMonthSum.operationTicket', {
				  url: '/operationTicket',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/operationTicket.jsp'
			})
			//月报汇总 操作票
			.state('app.DTReportMonthSum.twoVoteAnalysis', {
				  url: '/twoVoteAnalysis',
				  templateUrl: 'tpl/datang/reportPage/reportMonthSum/twoVoteAnalysis.jsp'
			})
			.state('app.DTBenchmarking', {
				  url: '/DTBenchmarking',
				  templateUrl: 'tpl/datang/reportPage/benchmarking.jsp'
			})
			//对标管理 日
			.state('app.DTBenchmarkingDay', {
				  url: '/DTBenchmarkingDay',
				  templateUrl: 'tpl/datang/reportPage/benchmarking/benchmarkingDay.jsp'
			})

			//对标管理 周
			.state('app.DTBenchmarkingWeek', {
				  url: '/DTBenchmarkingWeek',
				  templateUrl: 'tpl/datang/reportPage/benchmarking/benchmarkingWeek.jsp'
			})

			//对标管理 月
			.state('app.DTBenchmarkingMonth', {
				  url: '/DTBenchmarkingMonth',
				  templateUrl: 'tpl/datang/reportPage/benchmarking/benchmarkingMonth.jsp'
			})

			//对标管理 电站外部对标
			.state('app.DTOutsideTheStation', {
				  url: '/DTOutsideTheStation',
				  templateUrl: 'tpl/datang/reportPage/benchmarking/outsideTheStation.jsp'
			})

			//对标管理 公司外部对标
			.state('app.DTCompanyOutsideTheStandard', {
				  url: '/DTCompanyOutsideTheStandard',
				  templateUrl: 'tpl/datang/reportPage/benchmarking/companyOutsideTheStandard.jsp'
			})
			//指标管理
			.state('app.DTIndexManagement', {
				  url: '/DTIndexManagement',
				  templateUrl: 'tpl/datang/reportPage/indexManagement.jsp'
			})
			
			//两票管理
			.state('app.DTWorkOrders', {
				  url: '/DTWorkOrders',
				  templateUrl: 'tpl/datang/operationmanagePage/workOrders.jsp'
			})
			//缺陷管理
			.state('app.DTDefects', {
				  url: '/DTDefects',
				  templateUrl: 'tpl/datang/operationmanagePage/defects.jsp'
			})

			//大唐 实时监控系统弹窗
			.state('app.DTRtWindow', {
				  url: '/DTRtWindow',
				  templateUrl: 'tpl/datang/rtMonitorPage/rtWindow.jsp'
			})

			//风机品牌
			.state('app.WBrand', {
				  url: '/WBrand',
				  templateUrl: 'tpl/wBrand/components/index.jsp'
			})

			//组串阴影遮挡
			.state('app.groupStringShadow', {
				 url: '/groupStringShadow',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/groupStringShadow/groupStringShadowNew.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/groupStringShadowNew.js'
									])
								})
						}
					]
				}
			})

			//设备衰减分析
			.state('app.deviceAttenuation', {
				 url: '/deviceAttenuation',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/deviceAttenuation.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/deviceAttenuation.js'
									])
								})
						}
					]
				}
				  
			})

			//逆变器温度异常分析
			.state('app.temperatureAnomaly', {
				 url: '/temperatureAnomaly',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/temperatureAnomaly.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/temperatureAnomaly.js',
										'theme/js/dist/datang/siteAnalysis/privateComponents.js'
									])
								})
						}
					]
				}
				  
			})

			//逆变器转换效率
			.state('app.inverterConversionEfficiency', {
				 url: '/inverterConversionEfficiency',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/inverterConversionEfficiency.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/inverterConversionEfficiency.js',
										'theme/js/dist/datang/siteAnalysis/privateComponents.js'
									])
								})
						}
					]
				}
				  
			})

			//逆变器电压异常判断模型
			.state('app.inverterVoltageAnomaly', {
				 url: '/inverterVoltageAnomaly',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/inverterVoltageAnomaly.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/inverterVoltageAnomaly.js',
										'theme/js/dist/datang/siteAnalysis/privateComponents.js'
									])
								})
						}
					]
				}
				  
			})

			//汇流箱电压异常判断模型
			.state('app.boxVoltageAnomaly', {
				 url: '/boxVoltageAnomaly',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/boxVoltageAnomaly.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/boxVoltageAnomaly.js',
										'theme/js/dist/datang/siteAnalysis/privateComponents.js'
									])
								})
						}
					]
				}
				  
			})

			//箱变电压异常判断模型
			.state('app.boxChangeVoltageAnomaly', {
				 url: '/boxChangeVoltageAnomaly',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/boxChangeVoltageAnomaly.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/boxChangeVoltageAnomaly.js',
										'theme/js/dist/datang/siteAnalysis/privateComponents.js'
									])
								})
						}
					]
				}
				  
			})

			//箱变运行温度异常判断模型
			.state('app.boxChangeTemperatureAnomaly', {
				 url: '/boxChangeTemperatureAnomaly',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/boxChangeTemperatureAnomaly.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/boxChangeTemperatureAnomaly.js',
										'theme/js/dist/datang/siteAnalysis/privateComponents.js'
									])
								})
						}
					]
				}
			})

			//电站清洗建议
			.state('app.cleaningAdvice', {
				 url: '/cleaningAdvice',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/cleaningAdvice.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/cleaningAdvice.css',
										'theme/js/dist/datang/siteAnalysis/cleaningAdvice.js',
									])
								})
						}
					]
				}
			})

			//故障情况评估
			.state('app.failureAssessment', {
				 url: '/failureAssessment',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/failureAssessment.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/failureAssessment.js'
									])
								})
						}
					]
				}
			})

			//发电量预估
			.state('app.powerGenerationForecast', {
				 url: '/powerGenerationForecast',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/powerGenerationForecast.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/powerGenerationForecast.css',
										'theme/js/dist/datang/siteAnalysis/powerGenerationForecast.js'
									])
								})
						}
					]
				}
			})

			//经济性评价
			.state('app.economicEvaluation', {
				 url: '/economicEvaluation',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/economicEvaluation.jsp',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/economicEvaluation.css',
										'theme/js/dist/datang/siteAnalysis/economicEvaluation.js'
									])
								})
						}
					]
				}
			})

			//发电稳定度分析
			.state('app.powerGenerationStability', {
				 url: '/powerGenerationStability',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/powerGenerationStability.html',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/powerGenerationStability.js'
									])
								})
						}
					]
				}
			})

			//资源 理论辐射分析
			.state('app.theoreticalRadiationAnalysis', {
				 url: '/theoreticalRadiationAnalysis',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/resources/theoreticalRadiationAnalysis.html',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis/theoreticalRadiationAnalysis.css',
										'theme/js/dist/datang/siteAnalysis/resources/theoreticalRadiationAnalysis.js',
									])
								})
						}
					]
				}
			})

			//电量 损失电量分析
			.state('app.lossOfPower', {
				 url: '/lossOfPower',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/electricity/lossOfPower.html',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis/lossOfPower.css',
										'theme/js/dist/datang/siteAnalysis/electricity/lossOfPower.js',
									])
								})
						}
					]
				}
			})

			//人员 风电运维
			.state('app.windPowerOperations', {
				 url: '/windPowerOperations',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/personnel/windPowerOperations.html',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis/windPowerOperations.css',
										'theme/js/dist/datang/siteAnalysis/personnel/windPowerOperations.js',
									])
								})
						}
					]
				}
			})

			//人员 风云榜
			.state('app.fengyunList', {
				 url: '/fengyunList',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/personnel/fengyunList.html',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis/fengyunList.css',
										'theme/js/dist/datang/siteAnalysis/personnel/fengyunList.js',
									])
								})
						}
					]
				}
			})

			//人员 专家库
			.state('app.expertLibrary', {
				 url: '/expertLibrary',
				 templateUrl: /* @ */'tpl/datang/siteAnalysis/personnel/expertLibrary.html',
				 resolve : {
					deps : [
						'$ocLazyLoad',
						function($ocLazyLoad) {
							return $ocLazyLoad.load(allApi).then(function () {
									return $ocLazyLoad.load(newFile)
								}).then(function() {
									return $ocLazyLoad.load([
										'theme/css/datang/siteAnalysis/expertLibrary.css',
										'theme/js/dist/datang/siteAnalysis/personnel/expertLibrary.js',
									])
								})
						}
					]
				}
			})

			//事故预想记录
			.state('app.accidentPrediction', {
				  url: '/accidentPrediction',
				  templateUrl: /* @ */'tpl/datang/recordingList/accidentPrediction.jsp'
			})

			//表单验证测试用
			// .state('app.lxjTest', {
			// 	  url: '/lxjTest',
			// 	  templateUrl: 'tpl/lxj_test/test.jsp'
			// })


	}]);
