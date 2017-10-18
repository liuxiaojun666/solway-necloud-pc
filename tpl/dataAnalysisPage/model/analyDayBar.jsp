<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="row row-sm no-padder m-n divshadow" ng-controller="overviewDownDayCtrl"  id="overviewday-downmin"  style="min-height: 237px;">
	<div class="col-sm-12" style=" min-height: 280px;height: 100%;">
		<div class="panel wrapper" style="height: 100%;">
			<div id="ssglqx1" style="min-height: 237px;height:100%;"></div>
		</div>
	</div>
</div>
<script>
app.controller('overviewDownDayCtrl',function($scope, $http, $state, $stateParams) {
	function responseHeight(){
		$("#overviewday-downmin").css("height", $(window).height() - 500);
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight();
	$scope.$on('broadChangeDate', function(event, data) {
		$scope.basicData = data;
		if($scope.basicData){
			$scope.dataType = $scope.basicData.dataType;
			$scope.dtime = $scope.basicData.dtime;
		}
		if($scope.dataType == 'day'){
			$scope.getLoginUserPS();
			responseHeight();
		}
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		if($scope.dataType == 'day'){
			$scope.getLoginUserPS();
			responseHeight();
		}
		
    });
	
	//根据当前登陆用户加载数据
	$scope.getLoginUserPS = function() {
		getActPwrLineData($http, $scope);
	};
	//功率趋势图  $scope.powerStationId
	function getActPwrLineData($http, $scope) {
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getDayChartRealTimePower.htm",
			params : {
				'userId':1,
				'dateString':new Date($scope.dtime).Format("yyyy-MM-dd"),
			}
			})
			.success(function (msg) {
				if(msg.echarts_xaxisTime==null){
					getPowerV([],[],[],[])
				}else{
					getPowerV(msg.echarts_xaxisTime,msg.echarts_predictPower,msg.echarts_power,msg.echarts_luminousIntensity,$http, $scope);
				}
			}).error(function(msg){
			});
	}
	//init
	$scope.getLoginUserPS();
	function getPowerV(echarts_xaxisTime,echarts_predictPower,echarts_realTimePower,echarts_luminousIntensity,$http, $scope) {

		var  myChart = echarts.init(document.getElementById('ssglqx1'));
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
				/** formatter: function (params,ticket,callback) {
			            var res = params[0].name;
			            console.log(params)
			            for (var i = 0, l = params.length; i < l; i++) {
			            	if(params[i].value!=""&&!isNaN(params[i].value)){
			            		console.log((parseFloat((params[i]).value)).toFixed(1))
			            		console.log((parseFloat((params[i]).value)).toFixed(1))
			                	res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
			                	if(i==2){
			                		//res += "W/㎡";
			                	}else{
			                		//res += "kW";
			                	}
			            	} else if(params[i].value==""){
			                	res += '<br/>' + params[i].seriesName + ' : N/A';
			            	}
			            }
			            return res;
			      }*/
		    },
		    legend : {
				x : 'right',
				orient : 'horizontal',
				data : [ '应发功率', '实发功率', '光照强度' ]

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
				x : '50px',
				x2 : '40px',
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
				name : 'W/㎡',
				//name : powerVstr.name2,
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
				symbol : 'none',
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
				data : echarts_realTimePower
			}, {
				symbol : 'none',
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
							width : 1
						}
					}
				},
				data : echarts_luminousIntensity
			}
			]
		};
		myChart.setOption(option);
	}
});
</script>
