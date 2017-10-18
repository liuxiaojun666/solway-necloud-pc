<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.weatherlis {line-height: 45px;margin-bottom: 0;}
	.light-white{color:#d9e2e8;}
	.light-black{color:#25292c;}
</style>
<div ng-controller="dtStaTodayCtrl" class="col-sm-12 no-padder">
	<div class=""  id="distUserNav">
		<ul class="nav col-sm-12 no-padder nav-top mt10"  >
		  <li class="col-sm-12 no-padder text-center font18">
			 <span ng-bind="todayTimeForTitle"></span><span style="margin-left:30px;">实时功率</span>
		  </li>
		</ul>
	</div>
	<div class="col-sm-12 no-padder" style="margin-top:20px;" id="powerList">
		<div class="col-sm-6 no-padder" style="background:#4a5961;">
			<div id="powerTrendGraph" style="height:235px;width:434px;"></div>
		</div>
		<div class="col-sm-6 text-md no-padder" style="height: 235px;">
			<div class="col-sm-12 pt10 pb10 font12 light-white" style="background-color:#3e707d;height: 60px;">
				<div class="col-sm-12" >
						<div class="col-sm-4 text-center">
							<span>实时功率</span>
						</div>
						<div class="col-sm-4 text-center">
							<span>装机</span>
						</div>
						<div class="col-sm-4 text-center">
							<span>出力</span>
						</div>
				</div>
				<div class="col-sm-12" style="margin-top:10px;">
						<div class="col-sm-4 text-center">
							<span>45</span>
							<span>kW</span>
						</div>
						<div class="col-sm-4 text-center">
							<span>10</span>
							<span>MW</span>
						</div>
						<div class="col-sm-4 text-center">
							<span>20</span>
							<span>%</span>
						</div>
				</div>
			</div>
			<div class="clearfix font12 light-black" id="data" style="background-color: #f9f9f9;">
				<div class="col-sm-12" style="border-top: 1px solid #ccc;height: 50px;">
					<div class="col-sm-12 no-padder m-t-xs m-b-xs">
						<div class="col-sm-4 text-center  ">辐射总量</div>
						<!-- <div class="col-sm-5 text-center no-padder" style="font-size: 15px;">
							<span >23</span>
							<span>kWh/㎡</span>
						</div> -->
						<div class="col-sm-4 text-center ">
							<!-- <i class="fa fa-star" ng-show="data.weatherInstrument.grossRadiationIntensityStar>=1"></i>
							<i class="fa fa-star" ng-show="data.weatherInstrument.grossRadiationIntensityStar>=2"></i>
							<i class="fa fa-star" ng-show="data.weatherInstrument.grossRadiationIntensityStar>=3"></i>
							<i class="fa fa-star" ng-show="data.weatherInstrument.grossRadiationIntensityStar>=4"></i>
							<i class="fa fa-star" ng-show="data.weatherInstrument.grossRadiationIntensityStar>=5"></i> -->
						</div>
					</div>
					<div class="col-sm-12 no-padder">
						<div class="col-sm-4  text-center ">
						<span></span>光照强度</div>
						<div class="col-sm-4 text-center">
							<!-- <span>456</span>
							<span>kWh/㎡</span> -->
						</div>
						<div class="col-sm-4  text-center" ng-show="data.weatherInstrument.luminousWay=='0'">
							水平光照
						</div>
					</div>
				</div>
				<div class="col-sm-12" style="border-top: 1px solid rgba(0,0,0,0.5);height: 125px;">
					<div class="col-sm-4 text-center" style="margin-top:20px;">
						<span class="col-d black-2">风速</span>
						<p class="weatherlis" style="margin-top:3px"><span style="display: inline-block;"><img src="theme/images/datang/model/wind-speed.png"></span></p>
						<div class=""  style="margin-top:6px"><span>32</span> m/s</div>
					</div>
					<div class="col-sm-4 text-center" style="margin-top:20px;">
						<span class="col-d black-2">温度</span>
						<p class="weatherlis"  style="margin-top:3px"><img src="theme/images/datang/model/temperature.png"></p>
						<div style="margin-top:6px"><span>12</span> ℃</div>
					</div>
					<div class="col-sm-4 text-center" style="margin-top:20px;">
						<span class="col-d black-2">湿度</span>
						<p class="weatherlis" style="margin-top:3px"><img src="theme/images/datang/model/humidity.png"></p>
						<div  style="margin-top:6px"><span>33</span> %RH</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<script>
app.controller('dtStaTodayCtrl',function($scope, $http, $state, $rootScope) {
	$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日");

	$scope.stationListId = $scope.powerStationId
	var dayNames = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
	weekdays = new Date($scope.mapTimeDay);
	$scope.week=dayNames[weekdays.getDay()];

	//当前日
	$scope.todayTime=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日")
		$http({
			method : "POST",
			url : "${ctx}/MobileHmDeviceMonitor/getStationWeater.htm",
			params : {
				'dateString':new Date($scope.mapTimeDay).Format("yyyy-MM-dd")
				}
			})
	.success(function (msg) {
		if(msg==null){
			return
		}
		$scope.data=msg;
	}).error(function(msg){
		return
	});
	
	//功率趋势图
	var realtimeChart;
	drawGraph();
	function drawGraph(){
		realtimeChart = echarts.init(document.getElementById('powerTrendGraph'));	
		window.addEventListener("resize", function() {
			 realtimeChart.resize();
			/*  $($("#powerTrendGraph > div")[0]).css("width","100%");
			 $($("#powerTrendGraph > canvas")[0]).css("width", "100%"); */
		});
		option = {
			title:{
				text:"功率趋势图",
				textStyle:{
					color:"white",
					fontSize:'12'
				},
				padding:[10,10]
			},
			tooltip : {
				trigger : 'axis',
		    },
		    legend : {
				left: 'right',
				top:'7',
				orient : 'horizontal',
				data : [ {icon: 'line',name:'应发功率',textStyle: {color: '#3cb3ff'}},
				         {icon: 'line',name:'实发功率',textStyle: {color: '#45d355'}},
				         {icon: 'line',name:'光照强度',textStyle: {color: '#ffc600'}}]
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '30px',
				x2 : '30px',
				y : "60px",
				y2 : "30px"
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
				splitLine : {
					show : false
				},
				data : [1,2,3,4,5,6]
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : 'kW',
				font : {
					color : '#bbb'
				},
				splitNumber : 3,
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
				splitNumber : 3,
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
			series : [{
				name : '应发功率',
				type : 'line',
				smooth: true,
				itemStyle : {
					normal : {
						color : '#3cb3ff',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#3cb3ff',
							width : 1
						}
					}
				},
				data : [120,20,80,40,100,80]
			}, {
				name : '实发功率',
				type : 'line',
				smooth: true,
				itemStyle : {
					normal : {
						color : '#45d355',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#25ff2a',
							width : 1
						}
					}
				},
				data :[80,40,100,120,20,80]
			},{
				type : 'line',
				name : '光照强度',
				smooth: true,
				yAxisIndex : 1,
				itemStyle : {
					normal : {
						color : '#ffc600',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#ffc600',
							width : 1
						}
					}
				},
				data : [8,2,34,57,12,39]
			}]
		};
		realtimeChart.setOption(option);
	}
});
</script>

