<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 wrapper first-right" ng-controller="lineChartCtrl">
	<div id="lineChart"></div>
</div>
<script>
app.controller('lineChartCtrl',function($scope, $http, $state, $stateParams) {
	function responseHeight(){
		//$(".graph").css("height",$(window).height()-250)
		$("#lineChart").css("height", $(window).height() - 300);
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight(); 
	$scope.$on('broadLineData', function(event, data) {  
       renderRadar(data);
    }); 
	
	function renderRadar(data){
		if(data){
			$scope.echarts_xaxisTime = data.echarts_xaxisTime;
			$scope.echarts_luminousIntensity = data.echarts_luminousIntensity;
			getPowerVForRT($scope.echarts_xaxisTime,$scope.echarts_luminousIntensity);
		}else{
			getPowerVForRT([],[]);
		}
	}
});

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
			/**formatter: function (params,ticket,callback) {
				 var res = "";
				 res = params[0].seriesName + ' : ' + params[0].data+"W/㎡";
		         return res;
		    }*/
	    },
		title : {
			text : '光照曲线',
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
			data : [ '光照强度' ]

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
			name : 'W/m²',
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
			name : '光照强度',
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

</script>
