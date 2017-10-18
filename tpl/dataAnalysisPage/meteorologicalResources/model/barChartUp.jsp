<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-sm-12 wrapper first-right" ng-controller="barChartUpCtrl">
	<div id="barChartUp" style="height:220px;"></div>
</div>
<script>
app.controller('barChartUpCtrl',function($scope, $http, $state, $stateParams) {
	$scope.$on('broadBarChartUpData', function(event, msg) {
		if(msg){
			drawBarChartUp(msg.echarts_xaxisTime,
					msg.echarts_sunny_count,
					msg.echarts_cloudy_count,
					msg.echarts_rainy_count,
					msg.echarts_snowy_count,
					msg.echarts_woomay_count,
					msg.echarts_other_count,
					msg.echarts_sunny_count);
		}else{
			drawBarChartUp([],[],[],[],[],[],[],[]);
		}
		
	});
	
	//生成上部柱状图
	function drawBarChartUp(echarts_xaxisTime,echarts_sunny_count,echarts_cloudy_count,
			echarts_rainy_count,echarts_snowy_count,echarts_woomay_count,echarts_other_count,echarts_sunny_count){
		var myChart = echarts.init(document.getElementById('barChartUp'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
				title : {
					text : '光资源统计',
					textStyle : {
						fontSize : 14,
						color : "#666",
						fontFamily : '微软雅黑',
						fontWeight : 'normal'
					}
				},
			  	 tooltip : {
			        trigger: 'axis',
			  	 	  formatter: function (params,ticket,callback) {
			            var res ="";
			            for (var i = 0, l = params.length; i < l; i++) {
			            	if(i < l - 1){
				            	res += params[i].seriesName+" : "+params[i].value +"<br/>" ;
			            	}
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
			    grid : {
					borderWidth : '0px',
					x : '40px',
					x2 : '30px',
					y : "50px",
					y2 : "50px"
				},
				calculable : false,
				xAxis : [ {
					font : {
						color : '#fff'
					},
					type : 'category',
					 axisTick : {
							show : false
						},
					axisLabel : {
						textStyle : {
							align : 'center',
							color : 'rgba(187,187,187,0.9)',
							fontSize : 13
						}
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					splitLine : {
						show : false,
					},
					boundaryGap : true,
					data : echarts_xaxisTime
				} ],
				yAxis : [{
					axisLabel : {
						margin:20,
						textStyle : {
							color : 'rgba(187,187,187,0.9)',
							fontSize : 12
						}
					},
					
					font : {
						color : '#666'
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					splitLine : {
						show : false,
					},
					type : 'value'
				}],
				series : [
				  {
					name : '晴' ,
					type : 'bar',
					barWidth : 20,
					itemStyle : {
						normal : {
							color : function(params) {
								return '#e5cf0d'
							}
						}
					},
					stack : '天气',
					data : echarts_sunny_count
				},{
					name : '阴',
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								return '#b6a2de'
							}
						}
					},
					stack : '天气',
					data : echarts_cloudy_count
				},{
					name : '雨',
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								return '#5ab1ef'
							}
						}
					},
					stack : '天气',
					data :echarts_rainy_count
				},{
					name : '雪',
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								return '#2ec7c9'
							}
						}
					},
					stack : '天气',
					data :echarts_snowy_count
				},{
					name : '雾霾',
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								return '#8d98b3'
							}
						}
					},
					stack : '天气',
					data :echarts_woomay_count
				},{
					name : '其他',
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								return '#ffb980'
							}
						}
					},
					stack : '天气',
					data :echarts_other_count
				},{
					name : '晴天数' ,
					type : 'line',
					z : 1,
					itemStyle : {
						normal : {
							areaStyle : {
								color : 'transparent'
							},
							lineStyle : {
								color : '#f56669',
								width : 1
							}
						}
					},	
					symbol : 'none',
					data : echarts_sunny_count
				}]
			}
			myChart.setOption(option);
	}
	
});

</script>
