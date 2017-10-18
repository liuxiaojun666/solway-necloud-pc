	var myChart;
	app.controller('staMonCtrl',function($scope, $http, $state,$rootScope,toaster) {
		//监听切换电站刷新数据
		$scope.$on("refStaionInfo",
			    function (event, msg) {
			        $scope.getstaDayData();
			        $scope.ctr1Name = msg;
			        $scope.showRootStation=($scope.rootStationId.length > 1)
			 });
		//监听切换时间时间，并刷新数据
		$scope.$on('statDayBro', function(event, data) {  
		       if(data[0]){
		    	   $scope.mapTimeDay=data[1];
		    	   $scope.getstaDayData();
		      	 }
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
			$http({
				method : "POST",
				url : ctx+"MobileRtmDeviceMonitor/getAccumulateRDM.htm",
				params : {
					'userId':1,
					//'dateString':$scope.mapTimeMonth,
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					//endLoad()
					$scope.statDayData=msg;
					$scope.allDay=msg.maxMonthGeneratingPowerTime;//记录月
					$scope.allYear=msg.maxYearGeneratingPowerTime;//记录年
					$("#nowTimes").text(new Date(msg.productionDate).Format("yyyy/MM"))
					$scope.getMonPower()
				}).error(function(msg){
					//endLoad()
				});
		}
		$scope.getstaDayData();
		
		
		$scope.getMonPower=function(){
			if($scope.rootStationId.length<=1){
				if($scope.rootStationId[0]==null||$scope.rootStationId==null){
					console.log("set empty")
					$scope.rootStationId=[]
				}
			}
			if(myChart) {myChart.clear();}
			$.showLoading(loadFlags)
			
			$http({
				method : "POST",
				url : ctx+"MobileRtmDeviceMonitor/getAccumulateChartGeneratingPower.htm",
				params : {
					'userId':1,
					//'dateString':$scope.mapTimeMonth,
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					$("#kwhTotalMReport").css("width",(msg.echarts_xaxisTime.length)*140)
					powerAnalyze(msg.echarts_xaxisTime,msg.echarts_realGeneratingPower,msg.echarts_predictGeneratingPower,msg.echarts_generatingPowerHours,$http, $scope)
					//endLoad()
				}).error(function(msg){
					//endLoad()
				});
		}
	/*	
		// 点击模块打开实时功率界面
		$scope.showRealPower=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/staDayPower.html"
			$scope.openStatModal();
		}
		// 打开月统计报表
		$scope.showMonElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/staMonModal.html"
			$scope.openStatModal();
		}
		// 打开年统计报表
		$scope.showYearElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/staYearModal.html"
			$scope.openStatModal();
		}
		// 打开累计统计报表
		$scope.showAllElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/staAllModal.html"
			$scope.openStatModal();
		}
		//光资源排名
		$scope.showAllLightRanking=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/allLightRanking.html"
			$scope.openStatModal();
		}
		//打开综合评估
		$scope.showSyScore=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/showSyScore.html"
			$scope.openStatModal();
		}
		// 点击电站排名
		$scope.showRank=function(){
			console.log("排名")
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/statRank.html"
			$scope.openStatModal();
		}
		// 打开减排排名
		$scope.showReductionElectric=function(){
			
			if($scope.statDayData){
				
				$rootScope.plantedTreeAll=$scope.statDayData.plantedTree
				$rootScope.emissionReductionAll=$scope.statDayData.emissionReduction[0]
				$rootScope.emissionReductionUnitAll=$scope.statDayData.emissionReduction[1]
			}
			
			
			$rootScope.statDataPage="./tpl/statistics/modal/statAllModal/staReductionModal.html"
				$scope.openStatModal();
		}*/
	});

	//发电量曲线绘制
		function powerAnalyze(echarts_xaxisTime,echarts_realGeneratingPower,echarts_predictGeneratingPower,echarts_generatingPowerHours,$http, $scope){
			require(
				[ 'echarts', 'echarts/chart/line', 'echarts/chart/bar'],
				function(echarts){
					myChart = echarts.init(document.getElementById('kwhTotalMReport'));
					$.hideLoading(loadFlags)
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
						tooltip : {
							trigger: 'axis',
							formatter: function (params,ticket,callback) {
								var res ="";
								for (var i = 0, l = params.length; i < l; i++) {
									res += params[i].seriesName+" : "+params[i].value +"<br/>" ;
								}
								return res;
							},
							axisPointer:{
								type: 'line',
								lineStyle: {
									color: '#bbb',
									width: 1,
									type: 'solid'
								}
							}
						},
						noDataLoadingOption:{
							text : '暂无数据',
							effect :function(params,callback){
								return "暂无数据"
							}
						},
						grid : {
							borderWidth : '0px',
							x : '50px',
							x2 : '30px',
							y : "30px",
							y2 : "30px"
						},
						calculable : false,
						xAxis : [ {
							font : {
								color : '#fff'
							},
							position : 'top',//X 轴显示的方位
							type : 'category',
							axisTick : {
								show : false
							},
							axisLabel : {
								textStyle : {
									align : 'center',
									color : '#666',
									fontSize : 13
								}
							},
							axisLine : {
								lineStyle : {
									color : 'transparent'
								}
							},
							splitLine : {

								show : true,
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							boundaryGap : false,
							data : echarts_xaxisTime
						},{
							show:false,
							font : {
								color : '#fff'
							},
							position : 'top',//X 轴显示的方位
							type : 'category',
							axisTick : {
								show : false
							},
							axisLabel : {
								textStyle : {
									align : 'center',
									color : 'rgba(144, 168, 252,0.4)',
									fontSize : 13
								}
							},
							axisLine : {
								lineStyle : {
									color : 'transparent'
								}
							},
							splitLine : {

								show : true,
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							boundaryGap : false,
							data : echarts_xaxisTime
						}],
						yAxis : [{
							show:false,
							axisLabel : {
								textStyle : {
									color : 'rgba(144, 168, 252,0.4)',
									fontSize : 12
								}
							},

							nameLocation:'start',
							font : {
								color : '#666'
							},
							position : 'left',//X 轴显示的方位
							axisLine : {
								lineStyle : {
									color : 'transparent',
									width : 1
								}
							},
							splitLine : {
								show : true,
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							type : 'value'
						},
							{
								show:false,
								axisLabel : {
									textStyle : {
										color : 'rgba(144, 168, 252,0.4)',
										fontSize : 12
									}
								},

								nameLocation:'start',
								font : {
									color : '#666'
								},
								position : 'left',//X 轴显示的方位
								axisLine : {
									lineStyle : {
										color : 'transparent',
										width : 1
									}
								},
								splitLine : {
									show : true,
									lineStyle : {
										color : 'rgba(144, 168, 252,0.1)',
										width : 1
									}
								},
								type : 'value'
							}],
						series : [
							{
								name : '实发电量' ,
								type : 'bar',
								barWidth :15,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ff9a00'
										}
									}
								},
								data : echarts_realGeneratingPower
							},{
								name : '应发电量',
								type : 'bar',
								barWidth :15,
								xAxisIndex : 1,
								z:1,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ffc700'
										}
									}
								},
								data : echarts_predictGeneratingPower
							},{
								barWidth : 15,
								name : '发电小时数',
								type : 'bar',
								xAxisIndex : 1,
								yAxisIndex : 1,
								z:1,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#4a8bca'
										}
									}
								},
								data : echarts_generatingPowerHours
							},{
								yAxisIndex : 1,
								barWidth : 15,
								name : '发电小时数',
								type : 'bar',
								itemStyle : {
									normal : {
										color : function(params) {
											return '#4a8bca'
										}
									}
								},
								data : echarts_generatingPowerHours
							}]
					}
					myChart.setOption(option);
				}
			);
		}