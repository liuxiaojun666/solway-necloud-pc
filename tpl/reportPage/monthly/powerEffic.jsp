<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
	<style>
#powerEfficId{
overflow-y: auto; overflow-x: hidden}
</style>
	<div id="powerEfficId" class="panel wrapper col-sm-12 m-n" ng-controller="kwhCtrl" style="height: 340px;">
		<div id="kwhChart">
				<span class="font-h4 black-1">发电量分析</span>
				<span class="pull-right">
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs" style="color:#fe9700"></i>实时发电量</span>
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs" style="color:#ffc400"></i>应发电量</span>
					<span class="m-r-xs"><i class="fa  fa-minus  m-r-xs" style="color:#6b008e"></i>月计划完成率</span>
					<button class="btn btn-sm btn-info" ng-click="showKwhTable()">数据表格 ></button>
				</span>
				<div id="kwhTotalMReport2" style="height:270px;"></div>
			</div>
			<div id="kwhTable" class="hidden">
			<span class="font-h4 black-1">发电量分析</span>
			<button class="btn btn-sm btn-info m-b-xs pull-right" ng-click="showKwhChart()">数据报表 ></button>
			<table  class="table  table-striped b-t b-light bg-table">
				<thead>
					<th class="text-center">日期</th>
					<th class="text-center">实际发电量(kwh)</th>
					<th class="text-center">应发电量(kwh)</th>
					<th class="text-center">月累计发电量(kwh)</th>
					<th class="text-center">计划发电量(kwh)</th>
					<th class="text-center">计划完成率(%)</th>
				</thead>
				<tbody >
					<tr ng-repeat="kwh in kwhList">
						<td class="text-center">
							 <span ng-bind="kwh.xaxisTime|date:'yyyy-MM-dd'" ></span>
						</td>
						<td class="text-center">
							<span ng-bind="kwh.realGeneratingPower" ></span>
						</td>
						<td class="text-center">
							<span ng-bind="kwh.predictGeneratingPower" ></span>
						</td>
						<td class="text-center"><span ng-bind="kwh.kwh_total"></span>
						</td>
						<td class="text-center"><span ng-bind="kwh.plan_kwh"></span>
						</td>
						<td class="text-center"><span ng-bind="kwh.finish_r"></span></td>

					</tr>
				</tbody>
			</table>
		</div>
	</div>
<script>
app.controller('kwhCtrl',function($scope, $http, $state, $stateParams) {
	if(!$scope.mapTimeMonth){
		$scope.mapTimeMonth = $scope.mapTimeDayRefresh.substring(0,7);
	}
	$scope.refreshViewDataForHead = function () {
		if($scope.showFlag == 0){
			$scope.showKwhChart();
		}else{
			$scope.showKwhTable();
		}

	}
	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

	$scope.$on('dailyRefresh', function(event, data) {
		   if(data[0]){
			   $scope.mapTimeMonth=data[1].substring(0,7);
			   $scope.showKwhChart();
			 }
		  });
	$scope.$on('monthlyRefresh', function(event, data) {
		   if(data[0]){
			   $scope.mapTimeMonth=data[1]
			   $scope.showKwhChart();
			 }
		  });
	$scope.showFlag = 0;
	$scope.showKwhChart=function(){
		$scope.showFlag = 0;
		$("#kwhTable").addClass("hidden");
		$("#kwhChart").removeClass("hidden");
		$http.get("${ctx}/Report/getStationMonthKwhChart.htm",{
			params : {
				stid:$scope.stid,
				month:$scope.mapTimeMonth
			}
		})
		.success(function(result) {
			powerAnalyze(result)
		}).error(function(response) {

		});
	}
	if ($('#powerIndexModal').length>0) {
		$('#powerIndexModal').one('shown.bs.modal', function (e) {
			$scope.showKwhChart();
		});
	} else {
		$scope.showKwhChart();
	}
	//切换表格
	$scope.showKwhTable=function(){
		$scope.showFlag = 1;
		$("#kwhChart").addClass("hidden");
		$("#kwhTable").removeClass("hidden");
		$http.get("${ctx}/Report/getStationMonthKwhForTable.htm",{
			params : {
				stid:$scope.stid,
				month:$scope.mapTimeMonth
			}
		})
		.success(function(result) {
			$scope.kwhList=result.chartList;
			console.log($scope.kwhList)
		}).error(function(response) {

		});
	}
});
function powerAnalyze(powerAnalyVstr) {
		var myChart = echarts.init(document.getElementById('kwhTotalMReport2'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		//console.log(JSON.stringify(powerAnalyVstr))
		option = {
			tooltip: {
				trigger: 'axis',
				formatter: function(params, ticket, callback) {
					var res = "";
					for (var i = 0, l = params.length; i < l; i++) {
						//res += params[i].seriesName+" : "+params[i].value +"<br/>" ;
						if (params[i].value != "" && !isNaN(params[i].value)) {
							console.log(params[i].seriesName)
							res += params[i].seriesName + ' : ' + params[i].value;
							if (i == 0) {
								res += "kWh";
							} else if (i == 1) {
								res += "%";
							} else if (i == 2) {
								res += "%";
							} else if (i == 3) {
								//res += powerAnalyVstr.unit1;
								res += "%";
							} else if (i == 4) {
								res += "%";
							}
							if (i != params.length) {
								res += "</br>";
							}
						}
					}
					return res;
				},
				axisPointer: {
					type: 'line',
					lineStyle: {
						color: '#bbb',
						width: 1,
						type: 'solid'
					}
				}
			},
			grid: {
				borderWidth: '0px',
				x: '60px',
				x2: '80px',
				y: "40px",
				y2: "30px"
			},
			calculable: false,
			xAxis: [{
				type: 'category',
				axisTick: {
					show: false
				},
				axisLabel: {
					textStyle: {
						color: '#bbb',
						fontSize: 12
					}
				},
				axisLine: {
					lineStyle: {
						color: '#bbb',
						width: 1
					}
				},
				splitLine: {
					show: false
				},
				data: powerAnalyVstr.echarts_xaxisTime
			}, {
				type: 'category',
				show: false,

				data: powerAnalyVstr.echarts_xaxisTime
			}],
			yAxis: [{
				name: "kWh",
				type: 'value',
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				splitLine: {
					show: false
				},
			}, {
				name: '%',
				type: 'value',
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				splitLine: {
					show: false
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
			}],
			series: [{
				name: '实际发电量',
				type: 'bar',
				barWidth: 15,
				// barCategoryGap: '-15',
				itemStyle: {
					normal: {
						color: function(params) {
							return '#fe9700'
						}
					}
				},
				data: powerAnalyVstr.echarts_realGeneratingPower
			}, {
				name: '应发电量',
				type: 'bar',
				barWidth: 15,
				itemStyle: {
					normal: {
						color: function(params) {
							return '#ffc400'
						}
					}
				},
				xAxisIndex: 1,
				data: powerAnalyVstr.echarts_predictGeneratingPower
			}, {
				name: '月计划完成率',
				type: 'line',
				yAxisIndex: 1,
				symbol: 'none',
				itemStyle: {
					normal: {
						color: function(params) {
							return '#6b008e'
						},
						lineStyle: {
							type: "solid"
						}
					}

				},

				data: powerAnalyVstr.finish_r
			}]
		};
		myChart.setOption(option);
}
//$('#kwhChart .btn').trigger('click');
//$('#kwhTable .btn').trigger('click');
</script>
