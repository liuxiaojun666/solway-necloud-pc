<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.day-num .line-item{border-bottom:1px solid rgb(221,221,221);line-height:70px;    padding: 0 10px !important;}
	.day-num .line-item:last-child{border:none;}
</style>
<div ng-controller="overviewUpCtrl">
	<div  class="col-sm-12 no-padder panel cp" >
		<div class="col-sm-3 no-padder">
			<img src="./theme/images/any.png" class="img">
			<div class="anaWea">
				<div class="text-center" style="margin-top: 26px;"><img src="./theme/images/wp/dataAnalysis/themeAnalysis/blade.png"></div>
				<p class="text-center sunny-days">平均风速{{weatherData.ws_avg|dataNullFilter}}m/s</p>
				<div class="clearfix">
					<div class="pull-left">平均空气密度<span>{{weatherData.density_avg|limitTo:5|dataNullFilter}}</span><span class="unit-font">kWh/m<sup>2</sup></span></div>
					<div class="pull-right">温度<span>{{weatherData.ta_avg|limitTo:5|dataNullFilter}}</span><span class="unit-font">℃</span></div>
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
					<span class="num">{{weatherData.other_count|dataNullFilter}}</span>
				</li>
			</ul>
		</div>
		<div class="col-sm-9 up-right">
			<div class="col-sm-12 no-padder">
				<div class="col-sm-4 text-center">
					<div class="wrapper-sm col-sm-12 item">
						<span class="col-sm-12 no-padder font15 black-1">PBA</span>
						<div class="col-sm-12 no-padder" id="PBA" style="height: 184px;"></div>
					</div>
				</div>
				<div class="col-sm-4 text-center">
					<div class="wrapper-sm col-sm-12 item">
						<span class="col-sm-12 no-padder font15 black-1">可利用率</span>
						<div class="col-sm-12 no-padder" id="available" style="height: 184px;"></div>
					</div>
				</div>
				<div class="col-sm-4 text-center">
					<div class="wrapper-sm col-sm-12 item">
						<span class="col-sm-12 no-padder font15 black-1">发电计划完成率</span>
						<div class="col-sm-12 no-padder" id="completionRation" style="height: 184px;"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div  class="col-sm-12 panel cp no-padder" >
		<div class="col-sm-3  up-right" style="padding:18px 0;">
			<div class="wrapper-sm col-sm-12 item ">
				<div class="day-num">
					<p class="text-center font15">天数</p>
					<div class="col-sm-12 line-item no-padder">
						<div class="col-sm-7 font16 no-padder">无限电天数</div>
						<div class="col-sm-5 text-right font24 no-padder" style="color:#6d6bd1;">{{dataDown.no_restrict_count|dataNullFilter}}天</div>
					</div>
					<div class="col-sm-12 line-item no-padder">
						<div class="col-sm-7 font16 no-padder">无故障天数</div>
						<div class="col-sm-5 text-right font24 no-padder" style="color:#6d6bd1;">{{dataDown.no_fault_count|dataNullFilter}}天</div>
					</div>
					<div class="col-sm-12 line-item no-padder">
						<div class="col-sm-7 font16 no-padder">平均风速>6m/s天数</div>
						<div class="col-sm-5 text-right font24 no-padder" style="color:#6d6bd1;">{{dataDown.ws_gt6_count|dataNullFilter}}天</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-9 up-right">
			<div class="col-sm-4">
				<div class="wrapper-sm col-sm-12 item failure">
					<div class="h2-1">
						<p class="text-center font15">故障损失</p>
						<p class="font16">故障率</p>
						<p class="font24 red">{{dataDown.fail_r|dataNullFilter}}</p>
					</div>
					<div class="h2-1 below">
						<p class="font16">损失电量</p>
						<p class="font24 red">{{dataDown.fail_loss_kwh[0]|dataNullFilter}}{{dataDown.fail_loss_kwh[1]|dataNullFilter}}</p>
						<div class="rows font13"><div class="col-sm-6 text-left">MTTR {{dataDown.mttr |dataNullFilter}}h</div>
						<div class="col-sm-6 text-right">MTBF {{dataDown.mtbf |dataNullFilter}}h</div></div>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="wrapper-sm col-sm-12 item failure">
					<div class="h2-1">
						<p class="text-center font15">发电情况</p>
						<p class="font16">发电量</p>
						<p class="font24 green">{{dataDown.real_kwh[0] |dataNullFilter}}{{dataDown.real_kwh[1] | limitTo:5|dataNullFilter}}</p>
					</div>
					<div class="h2-1 below">
						<p class="font16">发电小时数</p>
						<p class="font24 green">{{dataDown.real_hours|dataNullFilter}}h</p>
						<div class="rows font13"><div class="col-sm-6">总装机容量</div><div class="col-sm-6 text-right">{{dataDown.inst_kw[0]|dataNullFilter}}{{dataDown.inst_kw[1]|dataNullFilter}}</div></div>
					</div>
				</div>
			</div>
			<div class="col-sm-4">
				<div class="wrapper-sm col-sm-12 item failure">
					<div class="h2-1">
						<p class="text-center font15">节能减排</p>
						<p class="font16">CO₂减排</p>
						<p class="font24" style="color:#fed601;">{{dataDown.co2[0] |dataNullFilter}}{{dataDown.co2[1] | limitTo:5|dataNullFilter}}</p>
					</div>
					<div class="h2-1 below">
						<p class="font16">植树</p>
						<p class="font24"  style="color:#78da31;">{{dataDown.tree|dataNullFilter}}棵</p>
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
		$scope.getWeatherData();
		$scope.getStationBasicDataUp();
		$scope.getStationBasicDataDown();
	});
	
	$scope.$on('switchStation', function(event, data) {
		$scope.getWeatherData();
		$scope.getStationBasicDataUp();
		$scope.getStationBasicDataDown();
    });
	
	
	//初始化月数据
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	//接口传参
	var dtime ,dateType;
	function getParams(){
		switch($scope.dataType){
			case "day" :dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
						dateType = 'd'
				break;
			case "month" : dtime = new Date($scope.dtime).Format("yyyy-MM");
							dateType = 'm'
				break;
			case "year" : dtime = new Date($scope.dtime).Format("yyyy");
							dateType = 'y'
				break;
			case "total" :dtime = '';
						dateType = 'a'
				break;
			default:
				dtime = new Date($scope.dtime).Format("yyyy-MM");
		}
	}
	
	
	//获取天气数据
	$scope.getWeatherData = function(){
		getParams();
		$http({
			method : "POST",
			url : "./WPTheme/getStationOverviewWeatherInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.weatherData = msg;
		}).error(function(msg){
		}); 
	};
	
	//获取电站基础数（上-右）
	$scope.getStationBasicDataUp = function(){
		getParams();
		$http({
			method : "POST",
			url : "./WPTheme/getStationOverviewPbaUseR.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			getPBA(msg.pba);
			getAvailable(msg.available_r);
			getCompletionRate(msg.finish_r)
		}).error(function(msg){
		}); 
	}
	
	//获取电站基础数（下）
	$scope.getStationBasicDataDown = function(){
		getParams();
		$http({
			method : "POST",
			url : "./WPTheme/getStationOverviewOtherInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.dataDown = msg;
		}).error(function(msg){
		}); 
	}
	
	//初始化
	$scope.getWeatherData();//上-左
	$scope.getStationBasicDataUp();	//上-右
	$scope.getStationBasicDataDown();//下
	
	function getPBA(nature){
		if(nature === null){
			$("#PBA").empty();
			return;
		}
		var myChart = echarts.init(document.getElementById('PBA'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var labelTop = {
		    normal : {
		    	color:"rgb(91,69,127)",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{d}%',
		            textStyle : {
		            	fontSize : '18',
						color : 'rgb(91,69,127)',
		                baseline : 'bottom'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		          	formatter : function (params){
		                return  nature
		            },
		            textStyle: {
		            	fontSize : '22',
						color : 'rgb(91,69,127)',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : false,
		            position : 'center',
		            textStyle: {
		            	fontSize : '18',
						color : '#52B4FB',
		                baseline : 'top'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
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
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-nature, itemStyle : labelBottom},
		                {name:'', value:nature,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

		myChart.setOption(option);
	}
	
	//getPR(可利用率)
	function getAvailable(nature){
		if(nature === null){
			$("#available").empty();
			return ;
		}
		var myChart = echarts.init(document.getElementById('available'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var labelTop = {
		    normal : {
		    	color:"rgb(66,139,202)",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{d}%',
		            textStyle : {
		            	fontSize : '18',
						color : 'rgb(66,139,202)',
		                baseline : 'bottom'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		          	formatter : function (params){
		                return  nature
		            },
		            textStyle: {
		            	fontSize : '22',
						color : 'rgb(66,139,202)',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : false,
		            position : 'center',
		            textStyle: {
		            	fontSize : '18',
						color : 'rgb(66,139,202)',
		                baseline : 'top'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
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
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-nature, itemStyle : labelBottom},
		                {name:'', value:nature,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

		myChart.setOption(option);
	}
	
	//计划完成率
	function getCompletionRate(nature){
		if(nature === null){
			$("#completionRation").empty();
			return ;
		}
		var myChart = echarts.init(document.getElementById('completionRation'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var labelTop = {
		    normal : {
		    	color:"rgb(246,123,80)",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{d}%',
		            textStyle : {
		            	fontSize : '18',
						color : 'rgb(246,123,80)',
		                baseline : 'bottom'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		          	formatter : function (params){
		                return  nature
		            },
		            textStyle: {
		            	fontSize : '22',
						color : 'rgb(246,123,80)',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : false,
		            position : 'center',
		            textStyle: {
		            	fontSize : '18',
						color : 'rgb(246,123,80)',
		                baseline : 'top'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
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
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-nature, itemStyle : labelBottom},
		                {name:'', value:nature,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

		myChart.setOption(option);
	}
});
	</script>
