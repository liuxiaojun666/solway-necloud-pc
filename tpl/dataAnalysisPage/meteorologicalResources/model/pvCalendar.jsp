<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
	.col-sm-7-d {width: 14.2858%;float: left;font-size: 14px;padding: 0px 10px;}
	.calBlock .star1, .calBlock .star2, .calBlock .star3, .calBlock .star4, .calBlock .star5 {color: #fff;}
	.calBlock .star0 {background-color: #fafafa;}
	.calBlock .star1 {background-color: #f9b164;}
	.calBlock .star2 {background-color: #e7646a;}
	.calBlock .star3 {background-color: #ea4b6f;}
	.calBlock .star4 {background-color: #d02969;}
	.calBlock .star5 {background-color: #8c2967;}
	.calBlock .starCtrlF {width: 0px;}
	.star1 .starCtrlF, .star2 .starCtrlF, .star3 .starCtrlF, .star4 .starCtrlF, .star5 .starCtrlF,
	.star1 .none.data, .star2 .none.data, .star3 .none.data, .star4 .none.data, .star5 .none.data {display: block;}
	.star0 .starCtrlF {width: 0;}
	.star1 .starCtrlF {width: 20%;}
	.star2 .starCtrlF {width: 40%;}
	.star3 .starCtrlF {width: 60%;}
	.star4 .starCtrlF {width: 80%;}
	.star5 .starCtrlF {width: 100%;}
	.tabCal {border-bottom: 1px solid #ddd;background-color: #fff;margin-left: 0;}
	.tabCal > li {border-bottom: 1px solid transparent;margin-bottom: -1px;}
	.tabCal > li.active {border-color: #06BEBD;color: #06BEBD;}
	.tabCal a:hover {color: #06BEBD;}
	.tabCal a {display: inline-block;line-height: 40px;padding: 0 10px;}
</style>
<div class="col-sm-12 no-padder" ng-controller="calendarCtrl">
	<!-- / navbar header -->
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
							'star1':cal.scoreRadiationIntensity<2&& cal.scoreRadiationIntensity!=null,
							'star2':cal.scoreRadiationIntensity>=2&& cal.scoreRadiationIntensity<3,
							'star3':cal.scoreRadiationIntensity>=3&& cal.scoreRadiationIntensity<4 ,
							'star4':cal.scoreRadiationIntensity>=4&& cal.scoreRadiationIntensity<5,
							'star5':cal.scoreRadiationIntensity>=5}"
						  ng-click="showOneDay($index,cal.day)" >
					<div ng-if="cal!=''" >
						<div style="height: 37px" class="">
							<span class="font-big-26" id="cal{{$index}}">
								<span style="font-weight: 300;" ng-bind="cal.day| date:'dd'"></span>
							</span>
							<span class="pull-right font-big" ng-show="cal.weaterTag=='A'">
								<i class="ico-family ico-sun"></i>
							</span>
							<span class="pull-right font-big" ng-show="cal.weaterTag=='B'">
								<i class="ico-family ico-yin"></i>
							</span>
							<span class="pull-right font-big" ng-show="cal.weaterTag=='C'">
								<i class="ico-family ico-rain"></i>
							</span>
							<span class="pull-right font-big" ng-show="cal.weaterTag=='D'">
								<i class="ico-family ico-snow"></i>
							</span>
							<span class="pull-right font-big" ng-show="cal.weaterTag=='E'">
								<i class="ico-family ico-smog"></i>
							</span>
							<span class="pull-right font-big"ng-show="cal.weaterTag=='X'">
								<i class="ico-family ico-weatherelse"></i>
							</span>
						</div>
						<div style="height: 20px;">
							<span class="none data">{{cal.grossRadiationIntensity[0] | dataNullFilter}}
							<span>{{cal.grossRadiationIntensity[1] | dataNullFilter}}</span></span>
							
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
			<div class="panel wrapper col-sm-12" id="">
				<span class="font-h4 black-1">辐射总量</span>
				<span class="pull-right">
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs sun_color" style="color:#ffc700"></i>晴</span>
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs yin_color" style="color:#90abfc"></i>阴</span>
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs rain_color" style="color:#5fc6be"></i>雨</span>
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs snow_color" style="color:#28b5fa"></i>雪</span>
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs smog_color" style="color:#999"></i>霾</span>
					<span class="m-r-xs"><i class="fa fa-circle m-r-xs weatherelse_color" style="color:#fe9700"></i>其它</span>
					<!-- <span class="m-r-xs"><i class="fa fa-minus m-r-xs" style="color:#e74c3c"></i>周边均值</span> -->
				</span>
				<div id="CalEchart" style="height:270px;"></div>
			</div>
		</div>
	</div>
</div>
<script>
	var emptyArray=[];//光伏日历前面加空数组
	$(".tabCal li").click(function() {
		$(this).addClass("active").siblings().removeClass("active")
	});
	app.controller('calendarCtrl', function ($scope, $http, $state, $stateParams, $rootScope) {
		
		function responseHeight(){
			$("#CalEchart").css("height", window.screen.height -640);
		}
		window.addEventListener("resize", function() {
			responseHeight();
		});
		responseHeight(); 
		
		var rightDay = new Date();
		rightDay.setDate(rightDay.getDate() - 1);
		$scope.mapTime = rightDay.Format("yyyy-MM");
		
		$scope.$on('refreshViewDataForHead', function(event, data) {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
				params : {
					}
			}).success(function (msg) {
				$scope.CalStid = msg.currentSTID;
				$scope.getLastDay(monDate[0],monDate[1],$scope.mapTime);
			})
	    });
		
		$scope.$on('broadChangeDateToChildMonth', function(event, data) {
			if(data){
				$scope.mapTime =data[0];
			}
			init();
		});
		
		function init(){
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
			}).success(function (msg) {
				$scope.CalStid = msg.currentSTID;
				var monDate=($scope.mapTime).split("-")
				$scope.getLastDay(monDate[0],monDate[1],$scope.mapTime)
				$scope.nowMonth=monDate[1]+"月";
			})
		}
		
		//初始化
		init();
		
		//获得上一个月最后一天和当前月第一天周几
		var dayNames = new Array('0',"1","2","3","4","5","6");
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
		$scope.getCalendar=function(mapTime){
			$http({
				method : "POST",
				url : "${ctx}/MobileHmDeviceMonitor/getCalendarSolarPower.htm",
				params : {
					'dateString': mapTime,
					'powerStationId': $scope.CalStid
				}
				})
				.success(function (msg) {
					if (msg.dayList!==null) {
						msg.dayList.sort(function (value1, value2) {
							return value1.day - value2.day;
						});
					}
					$scope.calendarList=emptyArray.concat(msg.dayList)
					////得到day数组，用于横坐标
					
					var aCalendarListDay ;
					var arr = [];
					for(var i=0;i<msg.grossRadiationList.length;i++){
						arr.push(msg.grossRadiationList[i].text);
					}
					aCalendarListDay = arr;
					
					var aCalendarRadiationTotal = aJsonArrToArr(msg.grossRadiationList, "grossRadiationIntensity", 0);
					//对图标天气数据进行处理
					var aCalendarListWeater = aJsonToArr(msg.dayList, "weaterTag");//得到天气数组
					var aCalendarListWeaterColor = [];
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
					var myChart = echarts.init(document.getElementById('CalEchart'));
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
							y2 : "20px"
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
										color: function(params) {
											var colorList = aCalendarListWeaterColor;
											return colorList[params.dataIndex]
										},
									}
								},
								"data": aCalendarRadiationTotal
							}
						]
					};
					myChart.setOption(option);
				}).error(function(msg){
				});
		}
		$scope.getLastDay=function(year,month1,selectTime){
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
			$scope.monFlag=dayNames[new_date.getDay()]
			emptyArray = [];
			for(var i=0;i<empData;i++){
				var o={} ;
				emptyArray.push(o)
			}
			$scope.getCalendar(selectTime);
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
