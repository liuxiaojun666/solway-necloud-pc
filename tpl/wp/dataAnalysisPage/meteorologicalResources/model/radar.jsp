<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 wrapper first-right " ng-controller="mpRadarCtrl">
	<div class="col-sm-6">
		<div id="radarMapLeft"  style="height:300px;"></div>
	</div>
	<div class="col-sm-6">
		<div id="radarMapRight" style="height:300px;"></div>
	</div>
</div>
<script>

app.controller('mpRadarCtrl',function($scope, $http, $state, $stateParams) {
	
	var dataType;
    $scope.$on("toPageRadar",function(e,data){
    	dataType = data;
    	dayDataDown();
    });
    
    var myChartDirection = echarts.init(document.getElementById('radarMapLeft'));
	window.addEventListener("resize", function() {
		myChartDirection.resize();
	});
	
	var myChartSpeed = echarts.init(document.getElementById('radarMapRight'));
	window.addEventListener("resize", function() {
		myChartSpeed.resize();
	});
	
	//判断雷达图是否初始化option
	$scope.speedInitOptionFlag = false;
	$scope.directionInitOptionFlag = false;
	
  	//若没有dataType值，初始化为m
    if(dataType == undefined || dataType == null || dataType == ""){
		dataType = "m"
	}
    	
  	dayDataDown();//页面首次进入，初始化
  	//玫瑰图（月）
	function dayDataDown(){
  		console.log(dataType +"===dataType")
		//风向
		$http({
			method : "POST",
			url : "./WPWeather/getStationWeatherWindDirectRose.htm",
			params : {
				'dtime':$scope.dtime,
				'model':dataType
			}
		})
		.success(function (msg) {
			renderRadarDirection(msg);
		}).error(function(){
		}); 
		
		//风速
		$http({
			method : "POST",
			url : "./WPWeather/getStationWeatherWindSpeedRose.htm",
			params : {
				'dtime':$scope.dtime,
				'model':dataType
			}
		})
		.success(function (msg) {
			renderRadarSpeed(msg);
		}).error(function(){
		}); 
	}
	
	
	//判断是否重绘图option
	function judgeDirction(data){
		if($scope.directionInitOptionFlag){
			drawRadarDir(data);
		}else{
			initDirctionOption(data);
			$scope.directionInitOptionFlag = true;
		}
	}
	
	function judgeSpeed(data){
		if($scope.speedInitOptionFlag){
			drawRadarSpeed(data);
		}else{
			initSpeedOption(data);
			$scope.speedInitOptionFlag = true;
		}
	}
	
	//获取数据
	function renderRadarDirection(data){//风向
	 	var radarList = [data.wa12_tally,data.wa11_tally,data.wa10_tally,data.wa9_tally,data.wa8_tally,data.wa7_tally,
	 	                 data.wa6_tally,data.wa5_tally,data.wa4_tally,data.wa3_tally,data.wa2_tally,data.wa1_tally];
	 	for(var i = 0;i<radarList.length;i++){
	 		if(radarList[i] == null){
	 			radarList[i] = "";
	 		}
	 	}
	 	judgeDirction(radarList)
	}
	
	function renderRadarSpeed(data){//风速
	 	var radarList = [data.wa12_ws_avg,data.wa11_ws_avg,data.wa10_ws_avg,data.wa9_ws_avg,data.wa8_ws_avg,data.wa7_ws_avg,
	 	                 data.wa6_ws_avg,data.wa5_ws_avg,data.wa4_ws_avg,data.wa3_ws_avg,data.wa2_ws_avg,data.wa1_ws_avg];
	 	for(var i = 0;i<radarList.length;i++){
	 		if(radarList[i] == null){
	 			radarList[i] = ""
	 		}
	 	}
	 	
	 	judgeSpeed(radarList)
	}
	
	//二次绘制雷达图
	function drawRadarDir(data){//风向
		myChartDirection.setOption({
			series : [
		        {
		            type: 'radar',
		            data : [
		                {
		                    value : data,
		                    name : '风向',
		                    itemStyle: {
		                        normal: {
		                            areaStyle: {
		                                type: 'default'
		                            }
		                        }
		                    },
		                }
		            ]
		        }
		    ]
		})
	}
	
	function drawRadarSpeed(data){//风速
		myChartSpeed.setOption({
			series : [
				{
		            type: 'radar',
		            data : [
		                {
		                    value : data,
		                    name : '风速',
		                    itemStyle: {
		                        normal: {
		                            areaStyle: {
		                                type: 'default'
		                            }
		                        }
		                    },
		                }
		            ]
		        }
		    ]
		})
	}
	function initDirctionOption(data){
		var optionDir = {
				title : {
			        text: '风向玫瑰图',
			        x:"center"
			    },
				color:['#56c6c7'],
			    tooltip : {
			    	trigger: 'axis'
			    }, 
			    legend: {
			        x : 'left',
			        orient:'vertical',
			        data:['风向']
			    },
			   
			    calculable : false,
			    radar : [
			        {
			            indicator : [
							{name : '0'},
			                {name : '330'},
			                {name : '300'},
			                {name : '270'},
			                {name : '240'},
			                {name : '210'},
			                {name : '180'},
			                {name : '150'},
			                {name : '120'},
			                {name : '90'},
			                {name : '60'},
			                {name : '30'}
			            ],
			            center:['50%', '50%'],
			            radius :90
			        }
			    ],
			    series : [
			        {
			            type: 'radar',
			            tooltip: {
			                trigger: 'item'
			            },
			            data : [
			                {
			                    value : data,
			                    name : '风向'
			                }
			            ]
			        }
			    ]
			};
		myChartDirection.setOption(optionDir);                  
	}
	
	function initSpeedOption(data){
		var optionSpeed = {
				title : {
			        text: '风速玫瑰图',
			        x:"center"
			    },
				color:['#56c6c7'],
			    tooltip : {
			        trigger: 'axis'
			    }, 
			    legend: {
			        x : 'left',
			        orient:'vertical',
			        data:['风速']
			    },
			   
			    calculable : false,
			    radar : [
			        {
			            indicator : [
							{name : '0'},
			                {name : '330'},
			                {name : '300'},
			                {name : '270'},
			                {name : '240'},
			                {name : '210'},
			                {name : '180'},
			                {name : '150'},
			                {name : '120'},
			                {name : '90'},
			                {name : '60'},
			                {name : '30'}
			            ],
			            center:['50%', '50%'],
			            radius :90
			        }
			    ],
			    series : [
			        {
			            type: 'radar',
			            tooltip: {
			                trigger: 'item'
			            },
			            data : [
			                {
			                    value : data,
			                    name : '风速'
			                }
			            ]
			        }
			    ]
			};
		myChartSpeed.setOption(optionSpeed);    
	}
	
	
});
</script>
