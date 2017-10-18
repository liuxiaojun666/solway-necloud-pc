<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<div class="col-sm-12 no-padder first-right" ng-controller="barChartDownCtrl">
	<div id="barChartDown" ></div>
</div>
<script>
app.controller('barChartDownCtrl',function($scope, $http, $state, $stateParams) {
	function responseHeight(){
		$("#barChartDown").css("height", $(window).height() - 470);
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight(); 
	$scope.$on('broadBarChartDownData', function(event, msg) {
		if(msg){
			////得到day数组，用于横坐标
			var aCalendarListDay;
			var arr = [];
			for(var i=0;i<msg.length;i++){
				arr.push(msg[i].text);
			}
			aCalendarListDay = arr;
			var aCalendarRadiationTotal = aJsonArrToArr(msg, "grossRadiationIntensity", 0);
			drawBarChartUp(aCalendarListDay,aCalendarRadiationTotal)
		}else{
			drawBarChartUp([],[])
		}
	});
	
	
	//生成上部柱状图
	function drawBarChartUp(aCalendarListDay,aCalendarRadiationTotal){

		var myChart = echarts.init(document.getElementById('barChartDown'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var aCalendarListWeaterColor = "rgb(255,199,0)";
		var option = {
				tooltip: {
					show: true
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
						data : aCalendarListDay
					}
				],
				yAxis : [
					{
						name:'kWh/㎡',
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
						"name":"辐射总量",
						"type":"bar",
						barWidth : 15,
						itemStyle: {
							normal: {
								color:'rgb(255,199,0)'
							}
						},
						"data": aCalendarRadiationTotal
					}
				]
			};
		myChart.setOption(option);
		
	}
	
});
function aJsonToArr(aObj, name) {
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
function aJsonArrToArr(aObj, name, index) {
	var arr = [];
	for (var i = 0; i < aObj.length; i++) {
		if (aObj[i][name]) {
			arr.push(aObj[i][name][index]);
		} else {
			arr.push("");
		}
	}
	return arr;
}



</script>
