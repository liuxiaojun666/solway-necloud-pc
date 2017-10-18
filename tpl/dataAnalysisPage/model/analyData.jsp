<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  class="col-sm-12 no-padder m-n panel cp" ng-controller="overviewUpCtrl" style="height: 306px;">
	<div class="col-sm-3 no-padder" style="cursor: pointer;" ng-show="dataType == 'day'">
		<img src="./theme/images/any.png" style="width:100%;height: 250px;"/>
		<div class="anaWea">
			<!-- <span id="changeTimeId2" class="m-l m-r pull-right font-h2" ng-bind="dtime | date:'yyyy-MM-dd'|dataNullFilter"></span> -->
			<div style="margin-top:5px;"class="text-center col-sm-12">
					 <i class="ico-family ico-sun" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag=='A'"></i>
					 <i class="ico-family ico-yin" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag=='B'"></i>
					 <i class="ico-family ico-rain" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag=='C'"></i>
					 <i class="ico-family ico-snow" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag=='D'"></i>
					 <i class="ico-family ico-smog" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag=='E'"></i>
					 <i class="ico-family ico-weatherelse" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag=='X'"></i>
					 <i class="ico-family" style="font-size: 75px;" ng-show="getTodayStationWeaterData.weaterTag== undefined">-</i>
					 <p ng-show="getTodayStationWeaterData.weaterTag=='A'">晴</p>
					 <p ng-show="getTodayStationWeaterData.weaterTag=='B'">阴</p>
					 <p ng-show="getTodayStationWeaterData.weaterTag=='C'">雨</p>
					 <p ng-show="getTodayStationWeaterData.weaterTag=='D'">雪</p>
					 <p ng-show="getTodayStationWeaterData.weaterTag=='E'">霾</p>
					 <p ng-show="getTodayStationWeaterData.weaterTag=='X'">其他</p>
					  <p ng-show="getTodayStationWeaterData.weaterTag== undefined">-</p>
			</div>
			<span class="col-sm-12 ">
				<span class="col-sm-4 text-center">
					<div><span style="transform: rotate(-90deg);display: inline-block;"><i class="ico-family">&#xe612;</i></span></div>
					<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.windSpeed|dataNullFilter"></span>m/s
				</span>
				<span class="col-sm-4 text-center">
					<div><i class="ico-family ico-temperature"></i></div>
					<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.temperature|dataNullFilter"></span>℃
				</span>
				<span class="col-sm-4 text-center">
					<div><i class="ico-family ico-humidity"></i></div>
					<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.humidity|dataNullFilter"></span>%
				</span>
			</span>
			<span class="text-center m-t col-sm-12">辐射总量
				<span class="m-l-xs">
					<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.grossRadiationIntensity[0]|dataNullFilter"></span>
					<span ng-bind="getTodayStationWeaterData.weatherInstrument.grossRadiationIntensity[1]|dataNullFilter"></span>
				</span>
			</span>
		</div>
		<span class="col-sm-12 m-t-xs font12">
			<span class="col-sm-4 no-padder text-center" style="overflow:hidden;">
				<div class="hrBorder"></div>
				<span class="black-1 ">{{getTodayStationWeaterData.real_hours|dataNullFilter}}h</span>
				<p class="black-3 m-n" >日照小时</p>
			</span>
			<span class="col-sm-4 no-padder text-center" style="overflow:hidden;">
				<div class="hrBorder"></div>
				<span class="black-1">{{getTodayStationWeaterData.maxLuminousIntensity[0]|dataNullFilter}}{{getTodayStationWeaterData.maxLuminousIntensity[1]|dataNullFilter}}</span>
				<p class="black-3 m-n">最大光照强度</p>
			</span>
			<span class="col-sm-4 no-padder text-center" style="overflow:hidden;">
				<span class="black-1">{{getTodayStationWeaterData.maxLuminousIntensityTime|date:'hh:ss'|dataNullFilter}}</span>
				<p class="black-3 m-n">最大光照时刻</p>
			</span>
		</span>
	</div>
	<div class="col-sm-3 no-padder"  ng-show="dataType != 'day'">
		<img src="./theme/images/any.png" class="img">
		<div class="anaWea">
			<!-- <p class="text-center sel-date">{{weatherData.dtime|dataNullFilter}}</p> -->
			<div class="text-center" style="margin-top: 26px;"><img src="./theme/images/statisticAnalysisPage/weather/sun-icon.png"></div>
			<p class="text-center sunny-days">晴天数{{weatherData.sunny_count|dataNullFilter}}</p>
			<div class="clearfix">
				<div class="pull-left">辐射总量<span>{{weatherData.rad|limitTo:5|dataNullFilter}}</span><span class="unit-font">kWh/m<sup>2</sup></span></div>
				<div class="pull-right sunny-time">日照小时<span>{{weatherData.sun_hours|limitTo:5|dataNullFilter}}</span><span class="unit-font">h</span></div>
			</div>
		</div>
		<ul class="clearfix weather-paracon">
			<li class="weather-para">
				<span><img src="./theme/images/statisticAnalysisPage/weather/1.png"></span>
				<span class="weather">晴</span>
				<span class="num">{{weatherData.sunny_count|dataNullFilter}}</span>
			</li>
			<li class="weather-para">
				<span><img src="./theme/images/statisticAnalysisPage/weather/2.png"></span>
				<span class="weather">阴</span>
				<span  class="num">{{weatherData.cloudy_count|dataNullFilter}}</span>
			</li>
			<li class="weather-para">
				<span><img src="./theme/images/statisticAnalysisPage/weather/3.png"></span>
				<span class="weather">雨</span>
				<span  class="num">{{weatherData.rainy_count|dataNullFilter}}</span>
			</li>
			<li class="weather-para">
				<span><img src="./theme/images/statisticAnalysisPage/weather/4.png"></span>
				<span class="weather">雪</span>
				<span  class="num">{{weatherData.snowy_count|dataNullFilter}}</span>
			</li>
			<li class="weather-para">
				<span><img src="./theme/images/statisticAnalysisPage/weather/5.png"></span>
				<span class="weather">霾</span>
				<span  class="num">{{weatherData.woomay_count|dataNullFilter}}</span>
			</li>
			<li class="weather-para">
				<span><img src="./theme/images/statisticAnalysisPage/weather/6.png"></span>
				<span class="weather">其他</span>
				<span  class="num">{{weatherData.other_count|dataNullFilter}}</span>
			</li>
		</ul>
	</div>
	<div class="col-sm-9 up-right">
		<div class="col-sm-12 no-padder">
			<div class="col-sm-3 text-center">
				<div class="wrapper-sm col-sm-12 item">
					<span class="col-sm-12 no-padder font-h4 black-1">PBA</span>
					<div class="col-sm-12 no-padder" id="PBA" style="height: 184px;"></div>
					<!-- <span class="font-h5 black-3 col-sm-12 no-padder">高于同城3个百分点</span> -->
				</div>
			</div>
			<div class="col-sm-3 text-center">
				<div class="wrapper-sm col-sm-12 item">
					<span class="col-sm-12 no-padder font-h4 black-1">PR</span>
					<div class="col-sm-12 no-padder" id="PR" style="height: 184px;"></div>
					<!-- <span class="font-h5 black-3 col-sm-12 no-padder">高于同城3个百分点</span> -->
				</div>
			</div>
			<div class="col-sm-3">
				<div class="wrapper-sm col-sm-12 item failure">
					<div class="h2-1">
						<p class="text-center font15">故障损失</p>
						<p class="font16">故障率</p>
						<p class="font24 red">{{basicData.fail_r|dataNullFilter}}</p>
					</div>
					<div class="h2-1 below">
						<p class="font16">损失电量</p>
						<p class="font24 red">{{basicData.fail_kwh[0]|dataNullFilter}}{{basicData.fail_kwh[1]|dataNullFilter}}</p>
						<div class="rows font13"><div class="col-sm-6 text-left">MTTR {{basicData.mttr |dataNullFilter}}h</div>
						<div class="col-sm-6 text-right">MTBF {{basicData.mtbf |dataNullFilter}}h</div></div>
					</div>
				</div>
			</div>
			<div class="col-sm-3">
				<div class="wrapper-sm col-sm-12 item failure">
					<div class="h2-1">
						<p class="text-center font15">发电情况</p>
						<p class="font16">发电量</p>
						<p class="font24 green">{{basicData.real_kwh[0] |dataNullFilter}}{{basicData.real_kwh[1] | limitTo:5|dataNullFilter}}</p>
					</div>
					<div class="h2-1 below">
						<p class="font16">发电小时数</p>
						<p class="font24 green">{{basicData.real_hours|dataNullFilter}}h</p>
						<div class="rows font13"><div class="col-sm-6">总装机容量</div><div class="col-sm-6 text-right">{{basicData.inst_kw[0]|dataNullFilter}}{{basicData.inst_kw[1]|dataNullFilter}}</div></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('overviewUpCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadChangeDate', function(event, data) {
		$scope.basicData = data;
		if($scope.basicData){
			$scope.dataType = $scope.basicData.dataType;
			$scope.dtime = $scope.basicData.dtime;
		}
		$scope.getWeatherData();//天气
		$scope.getStationBasicData();//基础数据
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getWeatherData();//天气
		$scope.getStationBasicData();//基础数据
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
	
	//初始化月数据
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	monthWeatherData();
	monthBasicData();
	
	//获取天气数据
	$scope.getWeatherData = function(){
		switch($scope.dataType){
			case "day" : dayWeatherData();
				break;
			case "month" : monthWeatherData();
				break;
			case "year" : yearWeatherData();
				break;
			case "total" : totalWeatherData();
				break;
		}
	};
	
	//获取电站基础数据
	$scope.getStationBasicData = function(){
		switch($scope.dataType){
			case "day" : dayBasicData()
				break;
			case "month" : monthBasicData();
				break;
			case "year" : yearBasicData();
				break;
			case "total" : totalBasicData();
				break;
		}
	}
	function dayWeatherData(){//日（天气）
	    $http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getStationWeater.htm",
			params : {
				'powerStationId':$scope.stid,
				'dateString':new Date($scope.dtime).Format("yyyy-MM-dd"),
			}
		})
		.success(function (msg) {
			$scope.getTodayStationWeaterData=msg;
		}).error(function(msg){
		}); 
	};
	function dayBasicData(){//日（基础数据）
	    $http({
			method : "POST",
			url : "./BDOverview/getStationSumDayOverviewDay.htm",
			params : {
				'dtime':new Date($scope.dtime).Format("yyyy-MM-dd"),
			}
		})
		.success(function (msg) {
			$scope.basicData = msg;
			if($scope.basicData){
				getPBA($scope.basicData.pba);
				getPR($scope.basicData.pr)
			}
		}).error(function(msg){
		}); 
	};
	function monthWeatherData(){//月（天气）
		
	    $http({
			method : "POST",
			url : "./BDOverview/getStationSumMonthWeatherMonth.htm",
			params : {
				'dtime':new Date($scope.dtime).Format("yyyy-MM"),
			}
		})
		.success(function (msg) {
			$scope.weatherData = msg;
		}).error(function(msg){
		}); 
	};
	function monthBasicData(){//月（基础数据）
		if(!$scope.dtime){
			$scope.dtime = new Date().Format("yyyy-MM");
		}
	    $http({
			method : "POST",
			url : "./BDOverview/getStationSumMonthOverviewMonth.htm",
			params : {
				'dtime':new Date($scope.dtime).Format("yyyy-MM"),
			}
		})
		.success(function (msg) {
			$scope.basicData = msg;
			if($scope.basicData){
				getPBA($scope.basicData.pba);
				getPR($scope.basicData.pr)
			}
		}).error(function(msg){
		}); 
	};
	function yearWeatherData(){//年（天气）
	    $http({
			method : "POST",
			url : "./BDOverview/getMonthPowerStationWeather.htm",
			params : {
				'dtime':new Date($scope.dtime).Format("yyyy"),
			}
		})
		.success(function (msg) {
			$scope.weatherData = msg;
		}).error(function(msg){
		}); 
	};
	function yearBasicData(){//年（基础数据）
	    $http({
			method : "POST",
			url : "./BDOverview/getStationSumYearOverviewYear.htm",
			params : {
				'dtime':new Date($scope.dtime).Format("yyyy"),
			}
		})
		.success(function (msg) {
			$scope.basicData = msg;
			if($scope.basicData){
				getPBA($scope.basicData.pba);
				getPR($scope.basicData.pr)
			}
		}).error(function(msg){
		}); 
	};
	function totalWeatherData(){//累计（天气）
	    $http({
			method : "POST",
			url : "./BDOverview/getCumutativePowerStationWeather.htm"})
		.success(function (msg) {
			$scope.weatherData = msg;
		}).error(function(msg){
		}); 
	};
	function totalBasicData(){//累计（基础数据）
	    $http({
			method : "POST",
			url : "./BDOverview/getStationSumCumutativeOverviewCumutative.htm"
		})
		.success(function (msg) {
			$scope.basicData = msg;
			if($scope.basicData){
				getPBA($scope.basicData.pba);
				getPR($scope.basicData.pr)
			}
		}).error(function(msg){
		}); 
	};
	function getPBA(nature){
		var myChart = echarts.init(document.getElementById('PBA'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var isNull = false;
		if(nature === null){
			isNull = true;
			nature = 0;
		}
		var labelTop = {
		    normal : {
		    	color:"rgb(255,196,0)",
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		    	formatter : function (params){
	            	if(params.name == 'a'){
	            		if(isNull){
	            			return "-"
	            		}else{
	            			return params.value +"%"
	            		}
	            		
	            	}else{
	            		return ""
	            	}
	            },
				 show : true,
		         position : 'center',
		         textStyle : {
		         	fontSize : '18',
					color : 'black',
		             baseline : 'bottom'
				 }
		    }
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        labelLine : {
		            show : false
		        }
		    },
		};
		var radius = [60, 70];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {	clockWise:false,
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', 
		            label : labelFromatter,
		            data : [
						{name:'a', value:nature,itemStyle : labelTop},
		                {name:'b', value:100-nature, itemStyle : labelBottom}
		            ]
		        }
		    ]
		};

		myChart.setOption(option);
	}
	
	//getPR
	function getPR(nature){
		var myChart = echarts.init(document.getElementById('PR'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var isNull = false;
		if(nature === null){
			isNull = true;
			nature = 0;
		}
		var labelTop = {
		    normal : {
		    	color:"rgb(255,196,0)",
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		    	formatter : function (params){
	            	if(params.name == 'a'){
	            		if(isNull){
	            			return "-"
	            		}else{
	            			return params.value +"%"
	            		}
	            		
	            	}else{
	            		return ""
	            	}
	            },
				 show : true,
		         position : 'center',
		         textStyle : {
		         	fontSize : '18',
					color : 'black',
		             baseline : 'bottom'
				 }
		    }
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        labelLine : {
		            show : false
		        }
		    },
		};
		var radius = [60, 70];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {	clockWise:false,
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', 
		            label : labelFromatter,
		            data : [
						{name:'a', value:nature,itemStyle : labelTop},
		                {name:'b', value:100-nature, itemStyle : labelBottom}
		            ]
		        }
		    ]
		};

		myChart.setOption(option);
	}
});
	</script>
