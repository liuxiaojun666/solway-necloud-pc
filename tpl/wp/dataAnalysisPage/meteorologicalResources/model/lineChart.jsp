<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 wrapper first-right" ng-controller="mpLineChartCtrl">
	<div id="lineChart" style="height:300px;"></div>
</div>
<script>
app.controller('mpLineChartCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadWpLineData', function(event, data) { 
       	renderRadar(data);
    }); 
	
	function renderRadar(data){
		var x = [],y = [];
		if(data && data.length>0){
			$("#lineChart").empty();
			for(var i = 0;i<data.length;i++){
				x.push(data[i].time);
				y.push(data[i].windSpeed);
			}
			getPowerVForRT(x,y);
		}else{
			$("#lineChart").html("暂无数据");
		}
	}
	
	
	function getPowerVForRT(xData,yData) {
		var myChart = echarts.init(document.getElementById('lineChart'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
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
					 var res = "";
					 res = params[0].seriesName + ' : ' + params[0].data+"m/s";
			         return res;
			    }
		    },
			title : {
				text : '风速曲线',
				textStyle : {
					fontSize : 14,
					color : "#666",
					fontFamily : '微软雅黑',
					fontWeight : 'normal'
				}
			},
			legend : {
				x : 'right',
				orient : 'horizontal',
				data : [ '平均风速' ]

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
				type : 'category',
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				axisLabel : {
					interval:59,
					axisLabel : 6,
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
				data : xData
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : 'm/s',
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
			}],
			series : [ {
				name:"平均风速",
				type : 'line',
				z : 1,
				itemStyle : {
					normal : {
						color : 'rgb(217, 83, 79)',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : 'rgba(233,171,79,.9)',
							width : 1
						}
					}
				},
				symbol : 'none',
				data : yData
			}]
		};
		myChart.setOption(option);
	}
});


</script>
