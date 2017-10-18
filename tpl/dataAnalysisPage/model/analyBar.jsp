<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder m-n divshadow"   id="overview-downmin"  style="min-height: 237px;">
	<!-- 发电量分析开始 -->
	<div id="powerEfficId" class="panel wrapper col-sm-12 m-n" ng-controller="overviewDownCtrl" style=" min-height: 280px;height: 100%;">
		<div id="kwhChart" style="height: 100%;">
			<span class="font-h4 black-1">发电量分析</span>
			<span class="pull-right">
				<span class="m-r-xs"><i class="fa fa-circle m-r-xs" style="color:#fe9700"></i>实际发电量</span>
				<span class="m-r-xs"><i class="fa fa-circle m-r-xs" style="color:#ffc400"></i>应发电量</span>
				<span class="m-r-xs"><i class="fa  fa-minus  m-r-xs" style="color:#6b008e"></i>月计划完成率</span>
				<button class="btn btn-sm btn-info" ng-click="showKwhTable()" ng-hide="dataType == 'day'">数据表格 ></button>
			</span>
			<div id="kwhTotalMReport2" style="min-height: 237px;height: 100%;"></div>
		</div>
		<div id="kwhTable" class="hidden">
			<span class="font-h4 black-1">发电量分析</span>
			<button class="btn btn-sm btn-info m-b-xs pull-right" ng-click="showKwhChart()">数据报表 ></button>
			<table  class="table  table-striped b-t b-light bg-table">
			<thead>
				<th class="text-center">日期</th>
				<th class="text-center">实际发电量(kWh)</th>
				<th class="text-center">应发电量(kWh)</th>
				<th class="text-center"  ng-show="dataType == 'month'">月累计发电量(kWh)</th>
                <th class="text-center"  ng-show="dataType == 'year'">年累计发电量(kWh)</th>
				<th class="text-center"  ng-show="dataType != 'total'">计划发电量(kWh)</th>
				<th class="text-center"  ng-show="dataType != 'total'">计划完成率(%)</th>
                <th class="text-center"  ng-show="dataType == 'total'"></th>
                <th class="text-center"  ng-show="dataType == 'total'"></th>
                <th class="text-center"  ng-show="dataType == 'total'"></th>
			</thead>
			<tbody >
				<tr ng-repeat="kwh in kwhList">
					<td class="text-center">
						 <span ng-bind="kwh.xaxisTime|date:'yyyy-MM-dd'" ng-show="dataType == 'month'"></span>
                         <span ng-bind="kwh.xaxisTime|date:'yyyy-MM'" ng-show="dataType == 'year'"></span>
                         <span ng-bind="kwh.xaxisTime|date:'yyyy'" ng-show="dataType == 'total'"></span>
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
	<!-- 发电量分析结束 -->
</div>
<script>
app.controller('overviewDownCtrl',function($scope, $http, $state, $stateParams) {
	function responseHeight(){
		$("#overview-downmin").css("height", $(window).height() - 500);
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
		$scope.getStationBasicData();
		$("#kwhTable").addClass("hidden");
		$("#kwhChart").removeClass("hidden");
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationBasicData();
		$("#kwhTable").addClass("hidden");
		$("#kwhChart").removeClass("hidden");
    });
	
	//获取电站id($scope.stid)
	($scope.getStationWeater = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
		}).error(function(msg){
			return
		});
	})()
	
	$scope.getStationBasicData = function(){
		switch($scope.dataType){
			case "day" : $scope.dayGraphData()
				break;
			case "month" : $scope.monthGraphData()
				break;
			case "year" : $scope.yearGraphData()
				break;
			case "total" : $scope.totalGraphData()
				break;
		}
	}
	
	
	//graph（日）
	$scope.dayGraphData = function(){
		$http({
			method : "POST",
			url : "./BDOverview/getStationListDayCurveDay.htm",
			params : {
				'dtime':$scope.dtime
			}
		})
		.success(function (msg) {
			powerAnalyze(msg)
		}).error(function(msg){
		}); 
	}
	//graph（月）
	$scope.monthGraphData = function(){
		$http({
			method : "POST",
			url : "./BDOverview/getStationListMonthKwhMonth.htm",
			params : {
				'dtime':new Date($scope.dtime).Format("yyyy-MM"),
			}
		})
		.success(function (msg) {
			powerAnalyze(msg)
		}).error(function(msg){
		}); 
	}
	//graph（年）
	$scope.yearGraphData = function(){
		
		$http.get("${ctx}/Report/getStationYearKwhForTable.htm",{
			params : {
				stid:$scope.stid,
				year:new Date($scope.dtime).Format("yyyy")
			}
		})
		.success(function(result) {
			powerAnalyze(result)
		}).error(function(response) {
		});
		
	}
	//graph（累计）
	$scope.totalGraphData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getAccumulateChartGeneratingPower.htm",
			params : {
				'powerStationId':$scope.stid 
			}
		})
		.success(function (msg) {
			powerAnalyze(msg)
		}).error(function(msg){
		}); 
	}
	
	//初始化月数据
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	$scope.monthGraphData()
	
	//点击按钮（数据表格），查看table
	$scope.showKwhTable=function(){
		$("#kwhChart").addClass("hidden");
		$("#kwhTable").removeClass("hidden");
		switch($scope.dataType){
			case "month" : $scope.monthTableData()
				break;
			case "year" : $scope.yearTableData()
				break;
			case "total" : $scope.totalTableData()
				break;
		}
	} 
	
	//table（月）
	$scope.monthTableData = function(){
		$http.get("${ctx}/Report/getStationMonthKwhForTable.htm",{
			params : {
				stid:$scope.stid,
				month:new Date($scope.dtime).Format("yyyy-MM")
			}
		})
		.success(function(result) {
			$scope.kwhList=result.chartList;
            console.log(result);
		}).error(function(response) {
		});
	}
	//table（年）
	$scope.yearTableData = function(){
		$http.get("${ctx}/Report/getStationYearKwhForTable.htm",{
			params : {
				stid:$scope.stid,
				year:new Date($scope.dtime).Format("yyyy")
			}
		})
		.success(function(result) {
			$scope.kwhList=result.chartList;
    console.log(result);
		}).error(function(response) {
		});
	}
	//table（累计）
	$scope.totalTableData = function(){
		$http.get("${ctx}/Report/getStationAllKwhForTable.htm",{
			params : {
				stid:$scope.stid
			}
		})
		.success(function(result) {
			$scope.kwhList=result.chartList;
    console.log(result);
		}).error(function(response) {
		});
	}
	//切换表格
	$scope.showKwhChart = function(){
		$("#kwhTable").addClass("hidden");
		$("#kwhChart").removeClass("hidden");
		$scope.getStationBasicData();
	}
	
	//绘制柱状图表方法
	function powerAnalyze(powerAnalyVstr) {
		var myChart = echarts.init(document.getElementById('kwhTotalMReport2'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			tooltip: {
				trigger: 'axis',
				/** formatter: function(params, ticket, callback) {
					var res = "";
					for (var i = 0, l = params.length; i < l; i++) {
						if (params[i].value != "" && !isNaN(params[i].value)) {
							res += params[i].seriesName + ' : ' + params[i].value;
							if (i == 0) {
								res += "kWh";
							} else if (i == 1) {
								res += "%";
							} else if (i == 2) {
								res += "%";
							} else if (i == 3) {
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
				},*/
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
				barGap : '-100%',
				itemStyle: {
					normal: {
						color: function(params) {
							return '#ffc400'
						}
					}
				},
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
});
</script>
