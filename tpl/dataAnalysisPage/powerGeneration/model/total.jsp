<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
	.tab{background:rgb(0,189,189);color:white;border-radius:5px;padding:5px 10px;font-size:15px;    margin: 10px 0;cursor:pointer;}
</style>
<div class="mete-con clearfix" ng-controller="yearChartCtrl">
	<div class="pull-right" ng-show="tab == 'dataGraph'">
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<!-- <span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color: rgb(140,41,103)"></i> <span
					class="col-9 m-r-xs text-1-1x">应发电量<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color:rgb(245,102,105)"></i> <span
					class="col-9 m-r-xs text-1-1x">实际发电量<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color:rgb(255,153,0)"></i> <span
					class="col-9 m-r-xs text-1-1x">上网电量<small></small></span> 
			</span> -->
			<span class="tab" ng-click="changeTab('tabTable')">数据表格</span>
		</div >
	</div>
	<div class="clearfix">
		<div  ng-show="tab == 'dataTable'" class="tab pull-right"  ng-click="changeTab('dataGraph')">数据图表</div>
	</div>
	<div id="monthChart" ng-show="tab == 'dataGraph'"></div>
	<div id="monthTable" ng-show="tab == 'dataTable'">
		<table  class="table  table-striped b-t b-light bg-table">
			<thead>
				<th class="text-center">日期</th>
				<th class="text-center">应发电量（kWh）</th>
				<th class="text-center">实际发电量（kWh）</th>
				<th class="text-center">上网电量（kWh）</th>
			</thead>
			<tbody >
				<tr ng-repeat="kwh in kwhList">
					<td class="text-center">
						 <span ng-bind="kwh.xaxisTime|date:'yyyy'"></span>
					</td>
					<td class="text-center">
						<span>{{kwh.predictGeneratingPower}}</span>
					</td>
					<td class="text-center">
						<span>{{kwh.realGeneratingPower}}</span>
					</td>
					<td class="text-center"><span>{{kwh.send_kwh}}</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<script>
app.controller('yearChartCtrl',function($scope, $http, $state, $stateParams) {
	function responseHeight(){
		$("#monthChart").css("height",$(window).height()-250)
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight(); 
	
	//图表和table切换
	$scope.tab = "dataGraph";//默认显示图表
	$scope.changeTab = function(val){
		if(val == "tabTable"){
			$scope.tab = "dataTable";
		}
		if(val == "dataGraph"){
			$scope.tab = "dataGraph";
		}
		$scope.getStationId();
	}
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationId();
    });
	
	//获取电站id($scope.stid)
	$scope.getStationId = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
			$scope.monthData();
		}).error(function(msg){
			return
		});
	}
	
	//曲线图数据
	$scope.monthData = function(){
		$http.get("./MobileHmDeviceMonitor/getAccumulateChartGeneratingPower.htm",{
			params : {
				powerStationId:$scope.stid
			}
		}).success(function(msg) {
			console.log(msg)
			drawChart(msg.echarts_xaxisTime,msg.echarts_predictGeneratingPower,msg.echarts_realGeneratingPower,msg.send_kwh,msg.plan_kwh,msg.finish_r);
			drawTable(msg.chartList);
		}).error(function(response) {
		});
	}
	
	
	//初始化
	$scope.getStationId();
	
	function drawTable(msg){
		$scope.kwhList = [];
		$scope.kwhList = msg
	}
	function drawChart(echarts_xaxisTime,echarts_predictGeneratingPower,echarts_realGeneratingPower,send_kwh,plan_kwh,finish_r){
		var myChart = echarts.init(document.getElementById('monthChart'));
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
						 	var res = params[0].name;
				           	for (var i = 0, l = params.length; i < l; i++) {
				            	if(params[i].value!=""&&!isNaN(params[i].value)){
				            		if(i == 0){
				            			res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1)+"kWh";
				            		}else{
				            			res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1)+"kWh";
				            		}
				            	} else if(params[i].value == ""){
				            		res += '<br/>' + params[i].seriesName + ' : '+'无数据';
				            	}
				            }
				            res += '<br/>'
				            return res;
				      }*/
			    },
				grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '30px',
					y : "50px",
					y2 : "80px"
				},
				legend : {
					data :['应发电量','实际发电量','上网电量','计划完成率'],
					right : 5
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
				}],
				yAxis : [{
					name: "kWh",
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
							name : '应发电量' ,
							type : 'bar',
							barWidth :20,
							barGap : '-100%',
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(140,41,103)'
									}
								}
							},
							data : echarts_predictGeneratingPower
						},{
							name : '实际发电量' ,
							type : 'bar',
							barWidth :20,
							barGap : '-100%',
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(245,102,105)'
									}
								}
							},
							data :echarts_realGeneratingPower
						},{
							name : '上网电量' ,
							type : 'bar',
							barWidth :20,
							barGap : '-100%',
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(255,153,0)'
									}
								}
							},
							data :send_kwh
						}]
		}
		myChart.setOption(option);
	}
});

</script>
