<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
	
</style>
<div class="col-sm-12 no-padder" ng-controller="mpCalendarCtrl">
	<!-- / navbar header -->
	<div class=" col-sm-10">
		<div class="wrapper-md row m-n">
			<div class="col-sm-12 no-padder panel panel-default rollDiv" style="margin-bottom:10px;">
				<div class="col-sm-12 no-padder bg-white">
					<div ng-repeat="day in dayTitle" class="col-sm-7-d calendarTitle text-center text-md" >
						<span ng-bind="day.title"></span>
					</div>
				</div>
				<div class="col-sm-12 no-padder calBlock">
					<div ng-repeat="cal in calendarList" class="col-sm-7-d"
						ng-class="{
								'star1':cal.wind_resource_score<2&& cal.wind_resource_score!=null,
								'star2':cal.wind_resource_score>=2&& cal.wind_resource_score<3,
								'star3':cal.wind_resource_score>=3&& cal.wind_resource_score<4 ,
								'star4':cal.wind_resource_score>=4&& cal.wind_resource_score<5,
								'star5':cal.wind_resource_score>=5}"
							  ng-click="showOneDay($index,cal.day)" >
						<div ng-if="cal!=''" >
							<div style="height: 37px" class="">
								<span class="font-big-26" id="cal{{$index}}">
									<span style="font-weight: 300;" ng-bind="cal.day| date:'dd'"></span>
								</span>
								<span class="pull-right font-big" ng-show="cal.weather=='A'">
									<i class="ico-family ico-sun"></i>
								</span>
								<span class="pull-right font-big" ng-show="cal.weather=='B'">
									<i class="ico-family ico-yin"></i>
								</span>
								<span class="pull-right font-big" ng-show="cal.weather=='C'">
									<i class="ico-family ico-rain"></i>
								</span>
								<span class="pull-right font-big" ng-show="cal.weather=='D'">
									<i class="ico-family ico-snow"></i>
								</span>
								<span class="pull-right font-big" ng-show="cal.weather=='E'">
									<i class="ico-family ico-smog"></i>
								</span>
								<span class="pull-right font-big"ng-show="cal.weather=='X'">
									<i class="ico-family ico-weatherelse"></i>
								</span>
							</div>
							<div style="height: 20px;">
								<span class="data">{{cal.ws_avg | dataNullFilter}}</span><span>m/s</span>
							</div>
							<div style="width:80px;height: 20px;">
								<div class="spacenowrap ohidden starCtrlF">
									<i class="ico-family ico-startscore"></i>
									<i class="ico-family ico-startscore"></i>
									<i class="ico-family ico-startscore"></i>
									<i class="ico-family ico-startscore"></i>
									<i class="ico-family ico-startscore"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-12 panel panel-default no-padder bg-white">
				<ul class="barChartTab clearfix">
					<li class="active" ng-click="changeBarTab('ws_avg')">日平均风速</li>
					<li ng-click="changeBarTab('ws_max')">日最大风速</li>
					<li ng-click="changeBarTab('cws_avg')">日截尾平均风速</li>
					<li ng-click="changeBarTab('ews_avg')">日有效平均风速</li>
					<li ng-click="changeBarTab('ta_avg')">日平均温度</li>
					<li ng-click="changeBarTab('h2o_avg')">日平均湿度</li>
					<li ng-click="changeBarTab('density_avg')">日平均空气密度</li>
				</ul>
				<div class="panel wrapper col-sm-12" id="">
					<!-- <span class="font-h4 black-1">辐射总量</span> -->
					<span class="pull-right">
						<span class="m-r-xs"><i class="fa fa-circle m-r-xs sun_color" style="color:#ffc700"></i>晴</span>
						<span class="m-r-xs"><i class="fa fa-circle m-r-xs yin_color" style="color:#90abfc"></i>阴</span>
						<span class="m-r-xs"><i class="fa fa-circle m-r-xs rain_color" style="color:#5fc6be"></i>雨</span>
						<span class="m-r-xs"><i class="fa fa-circle m-r-xs snow_color" style="color:#28b5fa"></i>雪</span>
						<span class="m-r-xs"><i class="fa fa-circle m-r-xs smog_color" style="color:#999"></i>霾</span>
						<span class="m-r-xs"><i class="fa fa-circle m-r-xs weatherelse_color" style="color:#fe9700"></i>其它</span>
					</span>
					<div id="CalEchart" style="height:270px;"></div>
				</div>
			</div>
			<div class="col-sm-12 radar clearfix">
				<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/meteorologicalResources/model/radar.jsp'"></div>
			</div>
		</div>
	</div>
	<div class="col-sm-2 stars" style="padding: 20px 0px;margin: 12px 0;">
		<div class="stars-5">
			<span></span> 
			<img alt="" src="theme/images/wp/dataAnalysis/meteorologicalRes/star.png"  ng-repeat="i in stars5">
		</div>
		<div class="stars-4">
			<span></span> 
			<img alt="" src="theme/images/wp/dataAnalysis/meteorologicalRes/star.png" ng-repeat="i in stars4">
		</div>
		<div class="stars-3">
			<span></span> 
			<img alt="" src="theme/images/wp/dataAnalysis/meteorologicalRes/star.png" ng-repeat="i in stars3">
		</div>
		<div class="stars-2">
			<span></span> 
			<img alt="" src="theme/images/wp/dataAnalysis/meteorologicalRes/star.png" ng-repeat="i in stars2">
		</div>
		<div class="stars-1">
			<span></span> 
			<img alt="" src="theme/images/wp/dataAnalysis/meteorologicalRes/star.png" ng-repeat="i in stars1">
		</div>
	</div>
</div>

<script>
	var emptyArray=[];//光伏日历前面加空数组
	app.controller('mpCalendarCtrl', function ($scope, $http, $state, $stateParams, $rootScope) {
		$scope.$on('monthDate', function(event, data) {
			init();
		});
		//获得上一个月最后一天和当前月第一天周几
		var dayNames = new Array('0',"1","2","3","4","5","6");
		$scope.barYaxis = "ws_avg";//柱形图，y轴默认显示平均风速
		var aCalendarListWeaterColor = [];
		
		var dataType;
		function init(){
			if($scope.dataType == 'month'){
				dataType = 'm'
			}
			var monDate=($scope.dtime).split("-")
			getLastDay(monDate[0],monDate[1]);
			$scope.$broadcast("toPageRadar",dataType);
		}
		
		//初始化
		init();
		
		//右侧星星的个数
		$scope.stars5 = [1,2,3,4,5];
		$scope.stars4 = [1,2,3,4];
		$scope.stars3 = [1,2,3];
		$scope.stars2 = [1,2];
		$scope.stars1 = [1];
		
		
		
		
		//柱状图切换
		$(".barChartTab >li").click(function(){
			$(this).addClass("active").siblings().removeClass("active");
		});
		$scope.dayTitle=[
					  { "title": "星期日"},
					  { "title": "星期一"},
					  { "title": "星期二"},
					  { "title": "星期三"},
					  { "title": "星期四"},
					  { "title": "星期五"},
					  { "title": "星期六"},
		]
		//请求光伏日历数据
		function getCalendar(){
			$http({
				method : "POST",
				url : "./WPWeather/getStationWindCalendarList.htm",
				params : {
					'dtime':$scope.dtime
				}
				})
				.success(function (msg) {
					if (msg.calendarInfoList!= null) {
						msg.calendarInfoList.sort(function (value1, value2) {
							return value1.day - value2.day;
						});
					}
					$scope.calendarList=emptyArray.concat(msg.calendarInfoList);
					
					//为柱形图的柱颜色准备数据
					//对图标天气数据进行处理
					var aCalendarListWeater = aJsonToArr(msg.calendarInfoList, "weather");//得到天气数组
					
					for (var i = 0; i < aCalendarListWeater.length; i++) {
						switch(aCalendarListWeater[i].toLocaleUpperCase()){
							case "A"://晴
								aCalendarListWeaterColor[i] = "#ffc700";
								break;
							case "B"://阴
								aCalendarListWeaterColor[i] = "#90abfc";
								break;
							case "C"://雨
								aCalendarListWeaterColor[i] = "#5fc6be";
								break;
							case "D"://雪
								aCalendarListWeaterColor[i] = "#58b5fa";
								break;
							case "E"://霾
								aCalendarListWeaterColor[i] = "#999";
								break;
							case "X"://其它
								aCalendarListWeaterColor[i] = "#fe9700";
								break;
							default:
								aCalendarListWeaterColor[i] = "rgba(255, 255, 255, 0)"
								break;
						};
					} 
				}).error(function(msg){
				});
		}
		
		function drawChart(x,y){
			var myChart = echarts.init(document.getElementById('CalEchart'));
			window.addEventListener("resize", function() {
				myChart.resize();
			});
			var option = {
				title:{
					text:"辐射总量"
				},
				tooltip: {
					show: true
				},
				grid : {
					borderWidth : '0px',
					x : '60px',
					x2 : '80px',
					y : "60px",
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
								color: function(params) {
									/* var colorList = aCalendarListWeaterColor;
									return colorList[params.dataIndex] */
									return 'red';
								},
							}
						},
						"data": y
					}
				]
			};
			myChart.setOption(option);
		}
		
		function getLastDay(year,month1){
			month=month1-1
			var new_year = year;    //取当前的年份
			var new_month = month++;//取下一个月的第一天，方便计算（最后一天不固定）
			if(month>12) {
			 	new_month -=12;        //月份减
			 	new_year++;            //年份增
			}
			var new_date = new Date(new_year,new_month,1);                //取当年当月中的第一天
			//周几添加几个空格 a.unshift()
			var empData=dayNames[new_date.getDay()];
			emptyArray = [];
			for(var i=0;i<empData;i++){
				var o={} ;
				emptyArray.push(o)
			}
			getCalendar();
			//dayDataDown();
			barData();
		}
		
		//柱形图数据
		function barData(){
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
					$("#CalEchart").html("暂无数据");
				}else if(msg.windInfoList && msg.windInfoList.length>0){
					$("#CalEchart").empty();
					renderBarChart(msg.windInfoList);
				}
			}).error(function(msg){
			}); 
		}
		//渲染柱形图
		function renderBarChart(data){
			//开始获取柱状图的数据来源
			//得到day数组，用于横坐标
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
		
		//柱形图顶部标签页切换
		$scope.changeBarTab = function(type){
			$scope.barYaxis = type;
			if($scope.windInfoList && $scope.windInfoList.length<=0){
				$("#CalEchart").html("暂无数据");
			}else if($scope.windInfoList && $scope.windInfoList.length>0){
				$("#CalEchart").empty();
				var aCalendarRadiationTotal = aJsonArrToArr($scope.barDataTotal, $scope.barYaxis); 
				drawChart($scope.aCalendarListDay,aCalendarRadiationTotal);
			}
		}
	});
</script>
<script>
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

	function getDateForStringDate(strDate){
		//切割年月日与时分秒称为数组
		var s = strDate.split(" ");
		var s1 = s[0].split("-");
		var s2 = s[1].split(":");
		if(s2.length==2){
			s2.push("00");
		}
		return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
	}
	Date.prototype.Format = function(fmt) { //author: meizz
		var o = {
			"M+": this.getMonth() + 1, //月份
			"d+": this.getDate(), //日
			"h+": this.getHours(), //小时
			"m+": this.getMinutes(), //分
			"s+": this.getSeconds(), //秒
			"q+": Math.floor((this.getMonth() + 3) / 3), //季度
			"S": this.getMilliseconds() //毫秒
		};
		if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for (var k in o)
			if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}
</script>
