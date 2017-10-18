	var myChart
	app.controller('staYearCtrl',function($scope, $http, $state,$rootScope,toaster) {
		//监听切换电站刷新数据
		$scope.$on("refStaionInfo",
			    function (event, msg) {
			        $scope.getstaDayData();
			        $scope.ctr1Name = msg;
			        $scope.showRootStation=($scope.rootStationId.length > 1)
			 });
		//监听切换时间时间，并刷新数据
		$scope.$on('statYearBro', function(event, data) {
		       if(data[0]){
		    	   $scope.mapTimeDay=data[1]
		    	   $scope.getstaDayData()
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
				url : ctx+"MobileRtmDeviceMonitor/getYearRDM.htm",
				params : {
					'userId':1,
					'dateString':$scope.mapTimeYear,
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					//endLoad()
					$scope.statDayData=msg;
					$scope.maxYMonth=msg.maxMonthGeneratingPowerTime;
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
				url : ctx+"MobileRtmDeviceMonitor/getYearChartGeneratingPower.htm",
				params : {
					'userId':1,
					'dateString':$scope.mapTimeYear,
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					if(msg.echarts_xaxisTime==null){
						powerAnalyze([],[],[],[])
					}else{
						if(msg.echarts_xaxisTime==null){
							powerAnalyze([],[],[],[])
						}else{
							$("#kwhTotalYearReport").css("width",(msg.echarts_xaxisTime.length)*40)
							powerAnalyze(msg.echarts_xaxisTime,msg.echarts_realGeneratingPower,msg.echarts_predictGeneratingPower,$http, $scope)
						}	
					}
					//endLoad()
				}).error(function(msg){
					//endLoad()
				});
		}
		
	
	/*	// 打开月统计报表
		$scope.showMonElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/staMonModal.html"
			$scope.openStatModal();
		}
		// 点击电站排名
		$scope.showStatRank=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/statRank.html"
			$scope.openStatModal();
		}
		
		//光资源排名
		$scope.showLightRanking=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/lightRanking.html"
			$scope.openStatModal();
		}
		// 打开年统计报表
		$scope.showYearElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/staYearModal.html"
			$scope.openStatModal();
		}
		// 打开累计统计报表
		$scope.showAllElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/staAllModal.html"
			$scope.openStatModal();
		}
		//打开综合评估
		$scope.showSyScore=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/showSyScore.html"
			$scope.openStatModal();
		}
		// 打开减排
		$scope.showReductionElectric=function(){
			
			if($scope.statDayData){
				$rootScope.plantedTree=$scope.statDayData.plantedTree
				$rootScope.emissionReduction=$scope.statDayData.emissionReduction[0]
				$rootScope.emissionReductionUnit=$scope.statDayData.emissionReduction[1]
			}
			
			
			$rootScope.statDataPage="./tpl/statistics/modal/statYearModal/staReductionModal.html"
				$scope.openStatModal();
		}
		*/
	});

	//发电量曲线绘制
		function powerAnalyze(echarts_xaxisTime,echarts_realGeneratingPower,echarts_predictGeneratingPower,$http, $scope){
			require(
				[ 'echarts', 'echarts/chart/line', 'echarts/chart/bar'],
				function(echarts){
					myChart = echarts.init(document.getElementById('kwhTotalYearReport'));
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
							x : '20px',
							x2 : '20px',
							y : "30px",
							y2 : "20px"
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
								formatter:function (value){
									return new Date(value).format("MM");
								},
								textStyle : {
									align : 'center',
									color : '#666',
									fontSize : 13
								}
							},
							axisLine : {
								lineStyle : {
									color : 'transparent',
								}
							},
							splitLine : {
								show : false
							},
							barCategoryGap:'5%',
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
									color : '#666',
									fontSize : 13
								}
							},
							axisLine : {
								lineStyle : {
									color : 'transparent',
								}
							},
							splitLine : {
								show : false
							},
							barCategoryGap:'5%',
							boundaryGap : false,
							data : echarts_xaxisTime
						} ],
						yAxis : [{
							show:false,
							type : 'value',
							axisLine : {
								lineStyle : {
									width : 1,
									color : '#bbb'
								}
							},
							axisLabel : {
								axisLabel : 10,
								textStyle : {
									color : '#bbb',
									fontSize : 13
								}
							},
							splitLine : {
								show : false
							}
						}],
						series : [
							{
								name : '应发电量',
								type : 'bar',
								z:1,
								barWidth : 15,
								barCategoryGap:5,
								xAxisIndex:1,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ffc700'
										}
									}
								},
								data : echarts_predictGeneratingPower
							},{
								name : '实发电量' ,
								type : 'bar',
								barWidth : 15,
								barCategoryGap:5,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ff9a00'
										}
									}
								},
								data : echarts_realGeneratingPower
							}]
					}
					myChart.setOption(option);
				}
			);
		}