<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@media screen and (min-width : 1701px) and (max-width : 1920px) {
    #availabilityRank{width:530px;}
    #faultTime{}
}

@media screen and (min-width : 1441px) and (max-width : 1700px) {
    
}
@media screen and (min-width : 1371px) and (max-width : 1440px) {
    
}
@media screen and (min-width : 768px) and (max-width : 1370px) {
    #availabilityRank{width:480px;}
    #faultTime{}
}
.black-bg{background:rgba(15,32,49,0.9);}
.white{color:white;}
.equ-running-title{position:relative;    height: 5.5rem;}
.solor-wind-btn-con{position:absolute;top:0;left:0;}
.solor-wind-btn-con .solor-wind-btn{color:white;display:inline-block;width: 5.8rem;height: 2.5rem;line-height:2.5rem;text-align:center;border:1px solid white;background:transparent;}
.solor-wind-btn-con .solor-wind-btn.active{background:#30d1d1;border:1px solid #30d1d1;}

.pro-sta-btn-con{text-align: left;margin: 3rem 0 0;margin-left: 125px;}
.pro-sta-btn-con .province-station-btn{color:white;display:inline-block;width: 5.8rem;height: 2.25rem;line-height:2.25rem;text-align:center;border:1px solid white;background:transparent;}
.pro-sta-btn-con .province-station-btn.active{background:white;border:1px solid white;color:black;}

#availabilityRank{margin:0 auto;}
.alert-oper >span{border-right:1px solid rgba(255,255,255,0.1)}
.alert-oper .blue{color:#5a99f7;}
</style>
<div  ng-controller="dtEquRunningModelCtrl" class="black-bg white">
	<div class="equ-running-title text-center">
		
		<div class="solor-wind-btn-con font20">
			<a class="solor-wind-btn" ng-class="{'active':solarOrWind == 'solar'}" ng-click="changeWindOrWind('solar')">光伏</a><a class="solor-wind-btn"  ng-class="{'active':solarOrWind == 'wind'}"  ng-click="changeWindOrWind('wind')">风电</a>
		</div>
	</div>
	<div class="clearfix"  style="height: 36.7rem;">
		<div class="pull-left text-center" style="width:40%;border-right:1px solid rgba(255,255,255,0.3);">
			<h4 class="font18" style="margin-top: 0;">可利用率排名</h4>
			<p class="font18">数据统计：<span>{{staDate.startDate | date : 'yyyy-MM-dd'}}</span>至<span>{{staDate.endDate | date : 'yyyy-MM-dd'}}</span></p>
			<div class="pro-sta-btn-con"><a class="province-station-btn" ng-class="{'active':proOrStation == 'province'}" ng-click="changeProStation('province')">省份</a><a class="province-station-btn"  ng-class="{'active':proOrStation == 'station'}"  ng-click="changeProStation('station')">电站</a></div>
			<div id="availabilityRank" style="height:27rem;"></div>
		</div>
		<div class="pull-right" style="width:60%;text-align:center;">
			<!-- <div id="faultTime" style="height:40rem;width:52rem;margin: 0 auto;"></div> -->
			<h4 class="font20">设备运行情况</h4>
			<div class="col-sm-12 no-padder font16" style="padding: 4.5rem 4rem 0 !important;">
	        	 <div class="operation-line clearfix font16 alert-oper"  style="height: 2.2rem;border-left: 1px solid rgba(255,255,255,0.1);border-top: 1px solid rgba(255,255,255,0.1);">
	        	 	<span class="per25"></span><span class="per15 green">运行</span><span class="per15 blue">待机</span><span class="per15 red">故障</span><span class="per15 yellow">维护</span><span class="per15">离线</span>
	        	 </div>
	        	 <div ng-repeat="vo in deviceRunDataST" class="operation-line-common clearfix font16 alert-oper" style="height: 2.9rem;border-left: 1px solid rgba(255,255,255,0.1);border-top: 1px solid rgba(255,255,255,0.1);">
	        	 	<span class="per25">{{vo.stationName}}</span><span class="per15 green" ng-bind="vo.run|dataNull0Filter"></span><span class="per15 blue" ng-bind="vo.wait|dataNull0Filter">5</span><span class="per15 red" ng-bind="vo.fault|dataNull0Filter">3</span><span class="per15 yellow" ng-bind="vo.maintain|dataNull0Filter">9</span><span class="per15" ng-bind="vo.comm|dataNull0Filter">1</span>
	        	 </div>
            </div>
		</div>
	</div>
</div>
<script>
app.controller('dtEquRunningModelCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.solarOrWind = "solar";
	$scope.changeWindOrWind = function(type){
		$scope.solarOrWind = type;
	}
	
	$scope.changeProStation = function(type){
		$scope.proOrStation = type;
		availabilityData();
	}
	
	init();
	function init(){
		$scope.proOrStation = "province";
		availabilityData();
		
		$http({
			url : "${ctx}/MobileRtmDeviceMonitor/getDeviceStatusForDT.htm",
			params: {
				type:'2'
			}
		}).success(function(res) {
			$scope.deviceRunDataST = res;
		});
		
		//faultData();
	}
	
	//可利用率图表数据
	function availabilityData(){
		var type=1;
		if($scope.proOrStation == "station"){
			type=2;
		}
		//接口
		$http({
			url : "${ctx}/currentPower/getDeviceUtilizationRate.htm",
			params: {
				type:type,
				//dateStr : new Date().Format("yyyy-MM-dd"),
				clazz : "01"
			}
		}).success(function(res) {
			$scope.staDate = res.data.queryDate;
			var xList = [];
			var valueList = [];
			var yname;
			var resList=[];
			if($scope.proOrStation == "station"){
				yname = "电站";
				if(res && res.data && res.data.stationData){
					resList = res.data.stationData;
				}
			}else{
				yname = "省份";
				if(res && res.data && res.data.provinceData){
					resList = res.data.provinceData;
				}
			}
			for(var i=0;i<resList.length;i++){
				xList.push(resList[i].name);
				valueList.push(resList[i].mStationUtilezeRatio*100);
			}
			var data = {"x":xList,"value":valueList};
			console.log(data);
			drawAvailabilityRankGraph(data.x,data.value,yname);
		});
		
	}
	
	//故障图表数据
	function faultData(){
		//接口2
		var data = {
				//"yData":['变频器单元', '变桨机构', '发电机单元', '液压机构', '齿轮箱', '控制', '电气'],
				"yData":['其它', '电池板', '继电器', '风扇故障', '通讯故障', '组串', '传感器'],
				"xLeft":[2000, 2500, 2900, 4500, 5900, 7000, 8000],
				"xRight": [1300, 2000, 2500, 3800, 5500, 6000, 4000]
		}
		
		var yData = data.yData;
		var xLeft = data.xLeft;
		var newXLeft = [];
		for(var i = 0;i<xLeft.length;i++){
			if(xLeft[i]>0){
				newXLeft.push(-xLeft[i]);
			}
		}
		
		var xRight = data.xRight;
		drawFaultGraph(yData,newXLeft,xRight);
	}
	//故障图
	function drawFaultGraph(yData,xLeft,xRight){
		var myChart = echarts.init(document.getElementById('faultTime'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			    legend: {
			        y: 'bottom',
			        textStyle:{
			        	color:"white"
			        },
			        data: ['故障停机时间（小时）', '平均故障恢复时间 mttr小时']
			    },
			    grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '50px',
					y : "20px",
					y2 : "120px"
				},
			    tooltip: {
			    	formatter: function(params) {
			            var value ;
			            if(params.value < 0){
			            	value = -params.value;
			            }else{
			            	value = params.value
			            }
			            return params.seriesName+"："+value;
			        }
			    },
			    yAxis: {
			        type: 'category',
					axisLine : {
						lineStyle : {
							color : 'white',
							width : 1
						}
					},
			        data: yData

			    },
			    xAxis: [{
			        axisLine : {
						lineStyle : {
							color : 'white',
							width : 1
						}
					},
					splitLine:{
						show:false
					},
			        axisLabel: {
						textStyle:{
							color:"white"
						},
			            formatter: function(value) {
			                if (value < 0) {
			                    return -value
			                } else {
			                    return value
			                }
			            }
			        }

			    }],
			    series: [{
			        name: '故障停机时间（小时）',
			        type: 'bar',
			        stack: 'one',
			        barWidth :15,
			        itemStyle: {
						normal: {
							color:'#eda456'
						}
					},
			        data: xRight
			    }, {
			        name: '平均故障恢复时间 mttr小时',
			        type: 'bar',
			        stack: 'one',
			        itemStyle: {
						normal: {
							color:'#00b929'
						}
					},
			        data: xLeft
			    }]
		};
		myChart.setOption(option);
	}
	//可利用率排名图
	function drawAvailabilityRankGraph(province,value,yname){
		var myChart = echarts.init(document.getElementById('availabilityRank'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				/* title:{
					text:"可利用率排名",
					textStyle:{
						color:"white",
						fontSize:20,
						fontWeight:'normal'
					},
					left:50,
					top:25
				}, */
				tooltip: {
					show: true
				},
				legend : {
					data :['可利用率'],
					textStyle:{
			        	color:"white"
			        },
					left : 100,
					bottom:100
				},
				grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '50px',
					y : "50px",
					y2 : "170px"
				},
				xAxis : [
					{
						type : 'value',
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
					}
				],
				yAxis : [
					{
						name:yname,
						nameTextStyle: {
							color:"white"
						},
						type: 'category',
						axisLabel:{
							textStyle:{
								color:"white"
							}
						},
						axisLine : {
							lineStyle : {
								color : 'white',
								width : 1
							}
						},
						data:province
					}
				],
				series : [
					{
						name:"可利用率",
						type:"bar",
						barWidth :30,
						itemStyle: {
							normal: {
								color:'#fb7567',
								label: {
			                        show: true,
			                        position: 'right',
			                        formatter:function(params){
			                        	return params.value+"%";
			                        },
			                        textStyle:{
			                        	color:"white"
			                        }
			                    }
							}
						},
						data: value
					}
				]
			};
		myChart.setOption(option);
	}

});
</script>
