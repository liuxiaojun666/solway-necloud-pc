	var myChart;
	app.controller('staDayCtrl',function($scope, $http, $state, $rootScope, toaster, $stateParams) {
		console.log("currentRole:"+$scope.currentRole);
		console.log("rootStationId:"+$scope.rootStationId);
		//监听切换电站刷新数据
		$scope.$on("refStaionInfo",
			    function (event, msg) {
			        $scope.rootStationId= [1]; //JSON.parse(storage["powerStationId"])
			        $scope.getstaDayData();
			        $scope.ctr1Name = msg;
			        $scope.showRootStation=($scope.rootStationId.length > 1)
			        if(myChart) {myChart.clear();}
				});
		//当前界面的获得全部数据
		$scope.getstaDayData=function(){
			if($scope.rootStationId.length<=1){
				if($scope.rootStationId[0]==null||$scope.rootStationId==null){
					console.log("set empty")
					$scope.rootStationId=[]
				}
			}
			//beginLoad();
			//console.log("-$scope.rootStationId:"+$scope.rootStationId);
			//$scope.rootStationId = [1];
			//console.log("http:$scope.rootStationId:"+$scope.rootStationId);
			$http({
				method : "POST",
				url : ctx + "MobileRtmDeviceMonitor/getDayRDM.htm",
				params : {
					'userId':1,
					'dateString':new Date($scope.mapTimeDay).Format("yyyy-MM-dd"),
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					//endLoad()
					$scope.statDayData=msg;
					$scope.getPowerData()//加载报表
				}).error(function(msg){
					//endLoad()
				});
		};
		$scope.getstaDayData();
		//判断电站个数以及改变标题
		
		$scope.showRootStation=($scope.rootStationId.length > 1)
		console.log($scope.showRootStation+"我就是看看我有数据吗")
		if($scope.rootStationId.length==1){
			$("#statTitle").text("演示电站一")
		}
		//监听切换时间时间，并刷新数据
		$scope.$on('statDayBro', function(event, data) {  
		       if(data[0]){
		    	   $scope.mapTimeDay=data[1]
		    	   $scope.getstaDayData()
		    	   if(myChart) {myChart.clear();}
		      	 }
		  }); 

		//请求报表
		$scope.getPowerData=function(){
			if($scope.rootStationId.length<=1){
				if($scope.rootStationId[0]==null||$scope.rootStationId==null){
					console.log("set empty")
					$scope.rootStationId=[]
				}
			}
			$("#ssglqxDay").html("")
			if(myChart) {myChart.clear();}
			$.showLoading(loadFlags)
			$http({
				method : "POST",
				url : ctx + "MobileRtmDeviceMonitor/getDayChartRealTimePower.htm",
				params : {
					'userId':1,
					'dateString':new Date($scope.mapTimeDay).Format("yyyy-MM-dd"),
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					 $.hideLoading(loadFlags)
					if(msg.echarts_xaxisTime==null){
						getPowerV([],[],[],[])
					}else{
						getPowerV(msg.echarts_xaxisTime,msg.echarts_predictPower,msg.echarts_realTimePower,msg.echarts_luminousIntensity,$http, $scope);
					}
				}).error(function(msg){
				});
		};
		
		/*// 点击模块打开实时功率界面
		$scope.showRealPower=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/staDayPower.html"
			$scope.openStatModal();
		};
		//打开气象实时监控
		$scope.showWeatherPower=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/showWeatherPower.html"
			$scope.openStatModal();
		};
		//打开综合评估
		$scope.showSyScore=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/showSyScore.html"
			$scope.openStatModal();
		};
		// 打开日统计报表
		$scope.showDayElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/staTodayPower.html"
			$scope.openStatModal();
		};
		// 打开月统计报表
		$scope.showMonElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/staMonModal.html"
			$scope.openStatModal();
		};
		// 打开年统计报表
		$scope.showYearElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/staYearModal.html"
			$scope.openStatModal();
		};
		// 打开累计统计报表
		$scope.showAllElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statDayModal/staAllModal.html"
			$scope.openStatModal();
		}*/
		
	});

	//实时功率趋势图绘制
	function getPowerV(echarts_xaxisTime,echarts_predictPower,echarts_realTimePower,echarts_luminousIntensity,$http, $scope) {
		require(
			[ 'echarts', 'echarts/chart/line', 'echarts/chart/bar'],
			function(echarts){
				myChart = echarts.init(document.getElementById('ssglqxDay'));
				$.hideLoading(loadFlags);
				window.addEventListener("resize", function() {
					myChart.resize();
				});
				option = {
						title : {
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
						formatter: function (params,ticket,callback) {
							var res = params[0].name;
							console.log(params)
							for (var i = 0, l = params.length; i < l; i++) {
								if(params[i].value!=""&&!isNaN(params[i].value)){
									console.log((parseFloat((params[i]).value)).toFixed(1))
									console.log((parseFloat((params[i]).value)).toFixed(1))
									res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
									/*if(i==1){
									 res += powerVstr.name2;
									 }else{
									 res += powerVstr.name1;
									 }*/
								} else if(params[i].value==""){
									res += '<br/>' + params[i].seriesName + ' : N/A';
								}
							}
							return res;
						}
					},
					noDataLoadingOption:{
						text : '暂无数据',
						effect :function(params,callback){
							return "暂无数据"
						}
					},
					calculable : true,
					grid : {
						borderWidth : '0px',
						x : '60px',
						x2 : '40px',
						y : "20px",
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
						data : echarts_xaxisTime
					} ],
					yAxis : [ {
						axisLabel : {
							textStyle : {
								color : '#bbb',
								fontSize : 12
							}
						},
						//name : powerVstr.name1,
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
									width : 1
								}
							}
						},
						data : echarts_predictPower
					}, {
						name : '实发功率',
						type : 'line',
						z : 2,
						itemStyle : {
							normal : {
								color : 'rgb(217, 83, 79)',
								areaStyle : {
									color : 'transparent'
								},
								lineStyle : {
									/* 	type : 'none',
										width:2, */
									color : 'rgba(217, 83, 79,.9)',
									width : 1
								}
							}
						},
						symbol : 'none',
						data : echarts_realTimePower
					}, {
						name : '光照强度',
						type : 'line',
						yAxisIndex :1,
						z : 3,
						itemStyle : {
							normal : {
								color : '#f0ad4e',
								areaStyle : {
									color : 'transparent'
								},
								lineStyle : {
									color : '#f0ad4e',
									width : 1
								}
							}
						},
						symbol : 'none',
						data : echarts_luminousIntensity
					}
					]
				};
				myChart.setOption(option);
			}
		);
	}
