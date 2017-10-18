<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel wrapper col-sm-12 m-n" ng-controller="powerBightCtrl" style="height: 269px">
	<div id="powerBight" style="height: 237px;"></div>
</div>
<script>
app.controller('powerBightCtrl',function($scope, $http, $state, $stateParams) {
	$scope.$on('dailyRefresh', function(event, data) {
	       if(data[0]){
	    	   $scope.mapTimeDay=data[1]
	    	   getActPwrLineData($http, $scope)
	      	 }
	      });
	$scope.$on('refreshViewDataForHead', function(event, data) {
		getActPwrLineData($http, $scope);
    });
	getActPwrLineData($http, $scope)
});
function getActPwrLineData($http, $scope) {

	$http.get(
			"${ctx}/Report/getStationCurveDataForDay.htm",
			{
				params : {
					stid:$scope.stid,
					dtime:$scope.mapTimeDayRefresh
				}
			}).success(function(response) {
				$("#powerBight").removeClass("hidden")
				console.log(response)
				getPowerV(response,$http, $scope);
			}).error(function(response) {
				$("#powerBight").addClass("hidden")
			});
}
function getPowerV(powerVstr,$http, $scope) {
	console.log(powerVstr)
		var myChart = echarts.init(document.getElementById('powerBight'));
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
			                	res += '<br/>' + params[i].seriesName + ' : ' + params[i].value;
			                	if(i==0){
			                		//res += "W/㎡";
			                	}else if(i==3){
			                		//res += "%";
			                	}else{
			                		//res += "kW";
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
			calculable : false,
			grid : {
				borderWidth : '0px',
				x : '60px',
				x2 : '40px',
				y : "60px",
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
				data : powerVstr.echarts_xaxisTime
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : "kW",
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
				name : "W/㎡",
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
			series : [ {
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
				symbol : 'none',
				data : powerVstr.echarts_luminousIntensity
			}, {
				symbol : 'none',
				name : '实时功率',
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
				data : powerVstr.echarts_power
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
							width : 1
						}
					}
				},
				data : powerVstr.echarts_predictPower
			} ]
		};
		myChart.setOption(option);
}

</script>
