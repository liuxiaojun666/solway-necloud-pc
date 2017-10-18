<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="faultTimesModelChartCtrl">
	<div class="pull-right">
		<span class="m-t-xs no-padder text-center">
				<span class="col-9 m-r-xs text-1-1x"><small></small></span> 
			</span>
	</div>
	<div id="faultTimesChart" style="height:250px;"></div>
</div>

<script>
app.controller('faultTimesModelChartCtrl',function($scope, $http, $state, $stateParams) {
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtimeModel = rightDay.Format("yyyy-MM");
	$scope.dataTypeModel = "month";
	
	$scope.$on('broadChangeDateToChildFault', function(event, data) {
		if(data){
			$scope.dataTypeModel = data.dataType;
			$scope.dtimeModel =data.dtime;
			$scope.faultTimeData();
		}else{
			$scope.faultTimeData();
		}
	});
	
	//各设备类型数据获取，并传值
	$scope.faultTimeData = function(){
		var data;
		console.log($scope.dataTypeModel + "-------$scope.dataTypeModel")
		switch($scope.dataTypeModel){
			case "month" :
				$http.get("./BDFault/getDevsListMonthFaultMonth.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy-MM")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "year" :
				$http.get("./BDFault/getDevsListYearFaultYear.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "total" :
				$http.get("./BDFault/getDevsListAllFaultAll.htm",{
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
		}
		
	}
	function parseData(data){
		var first = [],second = [],third = [],x = [];
		if(data && (data.faults != null) && (data.faults != undefined) && (data.faults.length)){
			for(var i = 0;i<data.faults.length;i++){
				first.push(data.faults[i].first);
				second.push(data.faults[i].second);
				third.push(data.faults[i].three);
				x.push(data.faults[i].day);
			}
		}
		drawChart(first,second,third,x);
	}
	
	$scope.faultTimeData();
	
	function drawChart(first,second,third,x){
		var myChart = echarts.init(document.getElementById('faultTimesChart'));
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
						 console.log(params)
						 	var res = params[0].name;
				           	for (var i = 0, l = params.length; i < l; i++) {
				           		res += '<br/>' + params[i].seriesName + ' : ' +params[i].value+"台次";			
				           	}
				            res += '<br/>'
				            return res;
				      }*/
			    },
				grid : {
					borderWidth : '0px',
					x : '70px',
					x2 : '30px',
					y : "50px",
					y2 : "30px"
				},
				legend : {
					data :['逆变器','汇流箱','箱变'],
					right : 5
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
					data : x
				} ],
				yAxis : [{
					name:'故障台次',
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
							name : '逆变器' ,
							type : 'bar',
							barWidth :20,
							stack : 'bar',
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(72,121,223)'
									}
								}
							},
							data : first
						},{
							name : '汇流箱' ,
							type : 'bar',
							barWidth :20,
							stack : 'bar',
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(151,195,75)'
									}
								}
							},
							data :second
						},{
							name : '箱变' ,
							type : 'bar',
							barWidth :20,
							stack : 'bar',
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(213,131,220)'
									}
								}
							},
							data :third
						}]
		}
		myChart.setOption(option);
	}
});

</script>
