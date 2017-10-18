<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<div class="mete-con" ng-controller="dayChartCtrl">
	<div id="dayChart"></div>
</div>

<script>
app.controller('dayChartCtrl',function($scope, $http, $state, $stateParams) {
	function responseHeight(){
		$("#dayChart").css("height",$(window).height()-250)
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight(); 
	$scope.$on('broadChangeDateToChild', function(event, data) {
		if(data){
			$scope.dtime =data[0];
		}
		$scope.dayData();
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.dayData();
    });
	//曲线图数据
	$scope.dayData = function(){
		$http.get(
				"./MobileHmDeviceMonitor/getDayChartRealTimePower.htm",
				{
					params : {
						dateString: new Date($scope.dtime).Format("yyyy-MM-dd")
					}
				}).success(function(response) {
					if(response.echarts_xaxisTime==null){
						getPowerVForRT([],[],[],[]);
					}else{
						getPowerVForRT(response.echarts_xaxisTime,response.echarts_predictPower,response.echarts_power,response.echarts_luminousIntensity);
					}
		}).error(function(response) {
		});
	}
	
	
	//初始化
	$scope.dayData();


	// 实时功率
	function getPowerVForRT(echarts_xaxisTime,echarts_predictPower,echarts_power,echarts_luminousIntensity) {

		var myChart = echarts.init(document.getElementById('dayChart'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			title : {
				text : '功率趋势图',
				textStyle : {
					fontSize : 14,
					color : "#666",
					fontFamily : '微软雅黑',
					fontWeight : 'normal'
				}
			},
			noDataLoadingOption:{
				text : '暂无数据',
				effect :function(params,callback){
					return "暂无数据"
				}
			},
			tooltip : {
				trigger: 'axis',
				zlevel:3,
				z:8,
				axisPointer:{
					type: 'line',
					lineStyle: {
						color: '#bbb',
						width: 1,
						type: 'solid'
					}
				} ,
				formatter: function (params,ticket,callback) {
					var res = params[0].name;
					for (var i = 0, l = params.length; i < l; i++) {
						if(params[i].value!=""&&!isNaN(params[i].value)){

							res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
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
				data : [ '应发功率', '实发功率', '光照强度' ]

			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '50px',
				x2 : '40px',
				y : "70px",
				y2 : "50px"
			},
			xAxis : [ {
				axisTick : {
					show : false
				},
				//position : 'top',//X 轴显示的方位
				type : 'category',
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				axisLabel : {
					interval:59,
					axisLabel : 5,
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				splitLine : {
					show : false,
				},
				boundaryGap : false,
				show: true,
				data : echarts_xaxisTime
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : 'kW',
				// nameLocation:'start',
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
				show:true,
				name : 'W/㎡',
				// nameLocation:'start',
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
				z : 1,
				itemStyle : {
					normal : {
						color : 'rgb(217, 83, 79)',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : 'rgba(217, 83, 79,.9)',
							width : 1
						}
					}
				},
				symbol : 'none',
				data : echarts_power
			}, {
				name : '光照强度',
				type : 'line',
				yAxisIndex : 1,
				z : 2,
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
});

</script>
