<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mete-con" ng-controller="mpYearPageCtrl">
	<div class="radar clearfix">
		<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/radarYear.jsp'"></div> 
	</div>
	<div class="graph" style="height:380px;">
		<ul class="barChartTab clearfix">
					<li class="active" ng-click="changeBarTab('ws_avg')">月平均风速</li>
					<li ng-click="changeBarTab('ws_max')">月最大风速</li>
					<li ng-click="changeBarTab('cws_avg')">月截尾平均风速</li>
					<li ng-click="changeBarTab('ews_avg')">月有效平均风速</li>
					<li ng-click="changeBarTab('ta_avg')">月平均温度</li>
					<li ng-click="changeBarTab('h2o_avg')">月平均湿度</li>
					<li ng-click="changeBarTab('density_avg')">月平均空气密度</li>
				</ul>
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-circle" style="color: #e5cf0d"></i> <span
					class="col-9 m-r-xs text-1-1x">月平均风速<small></small></span> 
			</span>
		</div>
		<div id="barGraph" style="padding-left:20px;height:270px;"></div>
	</div>
</div>

<script>
app.controller('mpYearPageCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.barYaxis = "ws_avg";//柱形图，y轴默认显示平均风速
	$scope.$on('yearDate', function(event, data) {
		$scope.dtime = data;
		init();
	});
	function responseHeight(){
		$("#barChartDownCon").css("height",$(window).height()-600)
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight(); 
	
	var dataType;
	
	function init(){
		if($scope.dataType == 'year'){
			dataType = 'y'
		}
		yearBarData();
		$scope.$broadcast("toPageRadarYear",dataType);
	}
	
	//柱状图切换
	$(".barChartTab >li").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});
	
	//柱形图顶部标签页切换
	$scope.changeBarTab = function(type){
		$scope.barYaxis = type;			
		
		if($scope.windInfoList && $scope.windInfoList.length<=0){
			$("#barGraph").html("暂无数据");
		}else if($scope.windInfoList && $scope.windInfoList.length>0){
			$("#barGraph").empty();
			var aCalendarRadiationTotal = aJsonArrToArr($scope.barDataTotal, $scope.barYaxis); 
			drawChart($scope.aCalendarListDay,aCalendarRadiationTotal);
		}
	}
	
	//柱状图数据
	function yearBarData(){
		$http({
			method : "POST",
			url : "./WPWeather/getStationWeatherWindInfoList.htm",
			params : {
				'dtime':$scope.dtime,
				'model':dataType
			}
		})
		.success(function (msg) {
			$scope.windInfoList = msg.windInfoList;
			if(msg.windInfoList && msg.windInfoList.length<=0){
				$("#barGraph").html("暂无数据");
			}else if(msg.windInfoList && msg.windInfoList.length>0){
				$("#barGraph").empty();
				organizeBarData(msg.windInfoList);
			}
		}).error(function(msg){
		}); 
	}
	
	function organizeBarData(data){
		data.sort(function (value1, value2) {
			return value1.time - value2.time;
		});
		$scope.barDataTotal = data;//柱状图数据源
		
		$scope.aCalendarListDay = [];
		for(var i=0;i<data.length;i++){
			$scope.aCalendarListDay.push(data[i].time);
		}
		
		var aCalendarRadiationTotal = aJsonArrToArr(data, $scope.barYaxis); 

		drawChart($scope.aCalendarListDay,aCalendarRadiationTotal);
	}
	
	function drawChart(x,y){
		var myChart = echarts.init(document.getElementById('barGraph'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
			tooltip: {
				show: true
			},
			noDataLoadingOption:{
		        text : '暂无数据',
		        effect :function(params,callback){
		        	return "暂无数据"
		        }
		    },
			grid : {
				borderWidth : '0px',
				x : '60px',
				x2 : '80px',
				y : "40px",
				y2 : "30px"
			},
			calculable : false,
			xAxis : [
				{
					type : 'category',
					axisTick : {
							show : false
						},
					axisLabel : {
						textStyle : {
							color : '#bbb',
							fontSize : 12
						}
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
					data : x
				}
			],
			yAxis : [
				{
					name:'m/s',
					type : 'value',
					axisLine : {
						lineStyle : {
							width : 1,
							color : '#bbb'
						}
					},
					axisLabel : {
						axisLabel : 10,
						textStyle : {
							color : '#bbb',
							fontSize : 13
						}
					},
					splitLine : {
						show : false
					},
				}
			],
			series : [
				{
					"type":"bar",
					barWidth : 15,
					itemStyle: {
						normal: {
							color: function(params) {
								return 'rgb(255,199,0)';
							},
						}
					},
					"data": y
				}
			]
		};
		myChart.setOption(option);
	}
});
function aJsonArrToArr(aObj, name) {
	var arr = [];
	for (var i = 0; i < aObj.length; i++) {
		if (aObj[i][name]) {
			arr.push(aObj[i][name]);
		} else {
			arr.push("");
		}
	}
	return arr;
}
</script>
