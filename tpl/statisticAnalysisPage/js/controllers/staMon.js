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
		$scope.$on('statMonthBro', function(event, data) {  
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
				url : ctx+"MobileRtmDeviceMonitor/getMonthRDM.htm",
				params : {
					'userId':1,
					'dateString':$scope.mapTimeMonth,
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					//endLoad()
					$scope.statDayData=msg;
					$scope.maxDay=$scope.statDayData.maxDayGeneratingPowerTime;
					$scope.getMonPower()
				}).error(function(msg){
					//endLoad()
				});
		};
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
				url : ctx+"MobileRtmDeviceMonitor/getMonthChartGeneratingPower.htm",
				params : {
					'userId':1,
					'dateString':$scope.mapTimeMonth,
					'powerStationId':$scope.rootStationId
				}
				})
				.success(function (msg) {
					console.log(msg)
					console.log("我是外面的数据")
					if(msg.echarts_xaxisTime==null){
						powerAnalyze([],[],[],[])
					}else{
						$("#kwhTotalMReportModal").css("width",(msg.echarts_xaxisTime.length)*40)
						powerAnalyze(msg.echarts_xaxisTime,msg.echarts_realGeneratingPower,msg.echarts_predictGeneratingPower,$http, $scope)
					}
					
				}).error(function(msg){
				});
		}
		
		/*// 点击电站排名
		$scope.showRealPower=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/statRank.html"
			$scope.openStatModal();
		}
		//光资源排名
		$scope.showLightRanking=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/lightRanking.html"
			$scope.openStatModal();
		}
		
		// 打开日统计报表
		$scope.showDayElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/staDayModal.html"
			$scope.openStatModal();
		}
		
		// 打开月统计报表
		$scope.showMonElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/staMonModal.html"
			$scope.openStatModal();
		}
		// 打开年统计报表
		$scope.showYearElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/staYearModal.html"
			$scope.openStatModal();
		}
		// 打开累计统计报表
		$scope.showAllElectric=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/staAllModal.html"
			$scope.openStatModal();
		}
		//打开综合评估
		$scope.showSyScore=function(){
			$rootScope.statDataPage="./tpl/statistics/modal/statMonModal/showSyScore.html"
			$scope.openStatModal();
		}*/
	});

	//发电量曲线绘制
		function powerAnalyze(echarts_xaxisTime,echarts_realGeneratingPower,echarts_predictGeneratingPower,$http, $scope){
			require(
				[ 'echarts', 'echarts/chart/line', 'echarts/chart/bar'],
				function(echarts){
					myChart = echarts.init(document.getElementById('kwhTotalMReportModal'));
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
							x: '30px',
							x2 : '30px',
							y : "30px",
							y2 : "0px"
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
									return new Date(value).format("dd");
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
							boundaryGap : false,
							data : echarts_xaxisTime
						},  {
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
							boundaryGap : false,
							data : echarts_xaxisTime
						}],
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
								name : '实发电量' ,
								type : 'bar',
								barWidth : 20,
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
								barWidth : 20,
								z:1,
								xAxisIndex:1,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ffc700'
										}
									}
								},
								data : echarts_predictGeneratingPower
							}]
					}
					myChart.setOption(option);
				}
			);
		}