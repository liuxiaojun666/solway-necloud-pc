<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mete-con clearfix" ng-controller="wpTimesModelChartCtrl">
	<div id="timesChart" style="height:250px;"></div>
</div>
<script>
app.controller('wpTimesModelChartCtrl',function($scope, $http, $state, $stateParams) {
	var myCharttime = echarts.init(document.getElementById('timesChart'));
	//init2();
	$scope.$on('timesChild', function(event, data) {
		$scope.data = data;
		init2();
	});
	function init2(){
		var first = [],second = [],third = [],x= [];
		if($scope.data){
			$scope.data.sort(function (value1, value2) {
				return value1.time - value2.time;
			});
			for(var i = 0;i<$scope.data.length;i++){
				first.push($scope.data[i].fail_count);
				second.push($scope.data[i].alarm_count);
				third.push($scope.data[i].inter_count);
				x.push($scope.data[i].time);
			}
		}
		drawCharttimes(first,second,third,x);
	}
	function drawCharttimes(first,second,third,x){
		myCharttime = echarts.init(document.getElementById('timesChart'));
		window.addEventListener("resize", function() {
			myCharttime.resize();
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
						 	var res = params[0].name;
				           	for (var i = 0, l = params.length; i < l; i++) {
				           		res += '<br/>' + params[i].seriesName + ' : ' +params[i].value+"台次";			
				           	}
				            res += '<br/>'
				            return res;
				      }*/
			    },
			    legend : {
					data :["故障" , "报警" , "中断"],
					right : 5
				},
				grid : {
					borderWidth : '0px',
					x : '70px',
					x2 : '30px',
					y : "100px",
					y2 : "30px"
				},
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
						show : false
					},
					boundaryGap : true,
					data : x,
				} ],
				yAxis : [{
					name:'台次',
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
						show : true,
						lineStyle : {
							color : 'rgba(187,187,187,0.4)',
							width : 1,
							type:'dashed'
						}
					},
					type : 'value'
				}],
				series : [
						  {
							name : '故障' ,
							type : 'bar',
							barMaxWidth:15,
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(192,80,77)'
									}
								}
							},
							data : first,
							
						},{
							name : '报警' ,
							type : 'bar',
							barMaxWidth:15,
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(255,199,0)'
									}
								}
							},
							data :second
						},{
							name : '中断' ,
							type : 'bar',
							barMaxWidth:15,
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(153,153,153)'
									}
								}
							},
							data :third,
						}]
		}
		myCharttime.setOption(option);
	}
});

</script>
