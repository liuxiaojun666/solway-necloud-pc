<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
	<!-- 综合评估 -->
<div class="col-sm-12 no-padder m-n panel divshadow" ng-controller="analyDataCtrl" style="height: 306px;">
	<div class="col-sm-3 no-padder"  ng-click="goPVCalendar()"  style="cursor: pointer;">
		<img src="./theme/images/any.png" style="width:100%;height: 250px;"/>
		<div class="anaWea">
		<span class=" analyhref cp" style="z-index: 1;position: relative;">光伏日历</span>
		
		<span id="changeTimeId2" class="m-l m-r pull-right font-h2" ng-bind="mapTimeMonth | date:'yyyy-MM-dd'"></span>
		<div style="margin-top:-40px;"class="text-center col-sm-12">
				 <!-- <i class="icon iconfont" style="font-size:140px;color:#fff">&#xe614;</i> -->
				 <!-- <p style="margin-top:-45px;">晴</p> -->
				 <i class="ico-family ico-sun" style="font-size: 90px;" ng-show="getTodayStationWeaterData.weaterTag=='A'"></i>
				 <i class="ico-family ico-yin" style="font-size: 90px;" ng-show="getTodayStationWeaterData.weaterTag=='B'"></i>
				 <i class="ico-family ico-rain" style="font-size: 90px;" ng-show="getTodayStationWeaterData.weaterTag=='C'"></i>
				 <i class="ico-family ico-snow" style="font-size: 90px;" ng-show="getTodayStationWeaterData.weaterTag=='D'"></i>
				 <i class="ico-family ico-smog" style="font-size: 90px;" ng-show="getTodayStationWeaterData.weaterTag=='E'"></i>
				 <i class="ico-family ico-weatherelse" style="font-size: 90px;" ng-show="getTodayStationWeaterData.weaterTag=='X'"></i>
				 <p ng-show="getTodayStationWeaterData.weaterTag=='A'">晴</p>
				 <p ng-show="getTodayStationWeaterData.weaterTag=='B'">阴</p>
				 <p ng-show="getTodayStationWeaterData.weaterTag=='C'">雨</p>
				 <p ng-show="getTodayStationWeaterData.weaterTag=='D'">雪</p>
				 <p ng-show="getTodayStationWeaterData.weaterTag=='E'">霾</p>
				 <p ng-show="getTodayStationWeaterData.weaterTag=='X'">其他</p>
		</div>
		<span class="col-sm-12 ">
			<span class="col-sm-4 text-center">
				<div><span style="transform: rotate(-90deg);display: inline-block;"><i class="ico-family">&#xe612;</i></span></div>
				<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.windSpeed"></span>m/s
			</span>
			<span class="col-sm-4 text-center">
				<div><i class="ico-family ico-temperature"></i></div>
				<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.temperature"></span>℃
			</span>
			<span class="col-sm-4 text-center">
				<div><i class="ico-family ico-humidity"></i></div>
				<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.humidity">8</span>%
			</span>
		</span>
		<span class="text-center m-t col-sm-12">辐射总量
			<span class="m-l-xs">
				<span class="m-t-xs font-h3" ng-bind="getTodayStationWeaterData.weatherInstrument.grossRadiationIntensity[0]"></span>
				<span ng-bind="getTodayStationWeaterData.weatherInstrument.grossRadiationIntensity[1]"></span>
			</span>
		</span>
		</div>
		<span class="col-sm-12 m-t-xs">
			<span class="col-sm-4 no-padder text-center">
				<div class="hrBorder"></div>
				<span class="black-1 font-h2">8h</span>
				<p class="black-3 font-h4 m-n" >日照小时</p>
			</span>
			<span class="col-sm-4 no-padder text-center">
				<div class="hrBorder"></div>
				<span class="black-1 font-h2">200w/㎡</span>
				<p class="black-3 font-h4 m-n">最大光照强度</p>
			</span>
			<span class="col-sm-4 no-padder text-center">
				<span class="black-1 font-h2">13:20</span>
				<p class="black-3 font-h4 m-n">最大光照时刻</p>
			</span>
		</span>
	</div>
	<div class="col-sm-9" style="padding: 20px 30px;">
		<div class="col-sm-12 no-padder">
			 <div class="col-sm-3 text-center a-cur-poi" ng-click="goMonth('1')">
				<div class="wrapper-sm col-sm-12 analyDiv">
					<span class="col-sm-12 no-padder font-h4 black-1">发电量</span>
					<div class="col-sm-12 no-padder" id="MKwh" style="height: 170px;"></div>
					<span class="font-h5 black-3 col-sm-12 no-padder">月完成率
						<span class="m-l-xs">{{targetData.month_finish_r|dataNullFilter}}%</span>
					</span>
				</div>
			</div>
			<div class="col-sm-3 text-center a-cur-poi" ng-click="goMonth('2')">
				<div class="wrapper-sm col-sm-12 analyDiv">
					<span class="col-sm-12 no-padder font-h4 black-1">设备性能对比</span>
					<div class="col-sm-12 no-padder" id="equComp" style="height: 170px;"></div>
					<span class="font-h5 black-3 col-sm-12 no-padder">高于同城均值{{ StationEstimateData.radarCompared[0].pr-StationEstimateData.radarCompared[1].pr |dataNullFilter | number : 1}}<!-- 个百分点 -->
				</div>
			</div>
			<div class="col-sm-3  a-cur-poi" ng-click="goMonth('3')">
				<div class="wrapper-sm col-sm-12 analyDiv">
					<span class="col-sm-12 text-center no-padder font-h4 black-1">故障损失</span>
					<span class="col-sm-12 m-t">
						<span class="font-h3 black-3">损失小时</span>
						<p class="data-orange h3 " >
							<span ng-bind="targetData.fail_hours|dataNullFilter"></span>h
						</p>
					</span>
					<span class="col-sm-12 b-b m-t-sm" style="padding:0px 25px;"></span>
					<span class="col-sm-12 m-t">
						<span class="font-h3 black-3">损失电量</span>
						<p class="data-orange h3 ">
							<span ng-bind="targetData.fail_kwh|dataNullFilter "></span>
							<span ng-bind="targetData.fail_kwhUnit"></span>
						</p>
					</span>
					<span class="col-sm-6 m-t" style="padding-right: 0;">
						<span class="font-h3">MTTR</span></br>
						<span class="font-h3 ">{{ targetData.mttr|dataNullFilter }}h</span>
					</span>
					<span class="col-sm-6 m-t" style="padding-left: 0;">
						<span class="font-h3 ">MTBF</span></br>
						<span class="font-h3 ">{{ targetData.mtbf|dataNullFilter }}h</span>
					</span>
				</div>
			</div>
			 <div class="col-sm-3 text-center a-cur-poi" ng-click="goMonth('4')">
				<div class="wrapper-sm col-sm-12 analyDiv">
					<span class="col-sm-12 no-padder font-h4 black-1">人员效率</span>
					<div class="col-sm-12 no-padder" id="perEffi" style="height: 170px;"></div>
					<span class="font-h5 black-3 col-sm-12 no-padder">
						<span class="m-l-xs">高于同城均值{{StationEstimateData.radarCompared[0].personnelEfficiency-StationEstimateData.radarCompared[1].personnelEfficiency |dataNullFilter}}<!-- 2个百分点 --></span></span>
				</div>
			</div>
		</div>
		<div class="col-sm-12  m-t ">
			<div class="col-sm-12 b-t">
			<div class="ledgerCon-top pull-left">
				<!-- <span  ng-click="changeAnalyTab('0')" class="col-sm-3 ">
					<a id="ledgerCon0"  href="">昨日</a>
				</span> -->
				<span  class="col-sm-4">
					<a id="ledgerCon1" class="active" style="white-space: nowrap;" href="">本月</a>
				</span>
				<span  class="col-sm-4" style="opacity: 0;">
					<a id="ledgerCon2" style="cursor: default;">本年</a>
				</span>
				<span  class="col-sm-4" style="opacity: 0;">
					<a id="ledgerCon3" style="cursor: default;">累计</a>
				</span>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('analyDataCtrl',function($scope, $http, $state, $stateParams) {

	($scope.getStationWeater = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
			params : {
				}
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
			$http({
				method : "POST",
				url : "${ctx}/MobileHmDeviceMonitor/getStationWeater.htm",
				params : {
					'powerStationId':$scope.stid,
					'dateString':$scope.mapTimeMonth
					}
				})
			.success(function (msg) {
				$scope.getTodayStationWeaterData=msg;
			}).error(function(msg){
				return
			});
		}).error(function(msg){
			return
		});
	})()

	$scope.goPVCalendar = function() {
		$state.go("app.pvCalendar", {
			stid: $scope.stid
		});
	};
	//发电量分析
		$scope.refreshViewDataForHead = function () {
			$scope.changeAnalyTab($scope.ledGerConData);
			$scope.getStationWeater();
    	}
    	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

    	//锚点定位
    	//goMonth(
    	$scope.goMonth=function(flagHref){
    		$state.go("app.monthly", {
				 flag :flagHref
			});
    	}

		$scope.changeAnalyTab=function(ledGerConData){
			$scope.ledGerConData=ledGerConData
			$("#ledgerCon"+ledGerConData).addClass("active")
			$("#ledgerCon"+ledGerConData).parent().siblings().children().removeClass("active")

		  	if(ledGerConData=="0"){//昨天

			} else if(ledGerConData=="1"){//ben'y
				 $http.get("${ctx}/Report/getStationBaseDataForMonth.htm",{
					params : {
						stid:$scope.stid,
						month:$scope.mapTimeMonth.substring(0,7)
					}
				})
				.success(function(result) {
					$scope.targetData=result;
			 		$scope.title="月发电量"
			 		$scope.r=$scope.targetData.month_finish_r
			 		//getEquComp($scope.targetData.pr)
			 		//getPerEffi("60")
			 		getMKwh($scope.targetData.real_kwh,$scope.targetData.real_kwhUnit,$scope.targetData.month_r,$scope.title)
				}).error(function(response) {
				});

				//设备性能对比 人员效率
				$http.get("${ctx}/Report/getStationEstimateDataForMonth2.htm",{
					params : {
						stid:$scope.stid,
						month:$scope.mapTimeMonth.substring(0,7)
					}
				})
				.success(function(result) {
					$scope.StationEstimateData=result;
					getEquComp($scope.StationEstimateData.radarCompared[0].pr)
					getPerEffi($scope.StationEstimateData.radarCompared[0].personnelEfficiency)
				}).error(function(response) {
				});

			}
		}
		$scope.changeAnalyTab(1);
});

//发电量
function getMKwh(real_kwh,real_kwhUnit,month_r,title){
	console.log(real_kwh);
	console.log(real_kwhUnit);
	if(typeof(real_kwh) == "undefined"){
		real_kwh="-";
		real_kwhUnit="-";
	}
	
	if(!month_r){
		month_r=0;
	}
	var myChart = echarts.init(document.getElementById('MKwh'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#56c6c7",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
		            	fontSize : '18',
						color : '#56c6c7',
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
		                return real_kwh+real_kwhUnit
		            },
		            textStyle: {
		            	fontSize : '22',
						color : '#56c6c7',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center',
		            textStyle: {
		            	fontSize : '18',
						color : '#56c6c7',
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
		                {name:'', value:100-month_r, itemStyle : labelBottom},
		                {name:title, value:month_r,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}

//设备性能对比
function getEquComp(nature){
	if(nature === null){
		nature = "";
	}
	var myChart = echarts.init(document.getElementById('equComp'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#52B4FB",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
		            	fontSize : '18',
						color : '#52B4FB',
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
						color : '#52B4FB',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
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
		                {name:'PR评分', value:nature,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
//人员效率

//设备性能对比
function getPerEffi(nature){
	if(nature === null){
		nature = "";
	}
	var myChart = echarts.init(document.getElementById('perEffi'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#ffc400",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
		            	fontSize : '18',
						color : '#ffc400',
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
						color : '#ffc400',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center',
		            textStyle: {
		            	fontSize : '18',
						color : '#ffc400',
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
		                {name:'修复率', value:nature,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
</script>
