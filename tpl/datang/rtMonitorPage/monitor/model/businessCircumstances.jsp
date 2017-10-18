<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.black-bg{background:rgba(15,32,49,0.9);}
.white{color:white;}
.bus-cir-title{position:relative;    height: 7rem;padding: 1.65rem;}
.solor-wind-btn-con{position:absolute;top:0;left:0;}
.solor-wind-btn-con .solor-wind-btn{color:white;display:inline-block;width: 5.8rem;height: 2.5rem;line-height:2.5rem;text-align:center;border:1px solid white;background:transparent;}
.solor-wind-btn-con .solor-wind-btn.active{background:#30d1d1;border:1px solid #30d1d1;}
.rankAsProvince{width:33%;}
.rankAsBrand{width:34%;border-left:1px solid rgba(255,255,255,0.3);border-right:1px solid rgba(255,255,255,0.3);}
.rankAsCapacity{width:33%;}
@media screen and (min-width : 1701px) and (max-width : 1920px) {
    #rankAsProvince{width:380px;}
    #rankAsBrand{width:380px;}
    #rankAsCapacity{width:380px;}
}

@media screen and (min-width : 1441px) and (max-width : 1700px) {
    
}
@media screen and (min-width : 1371px) and (max-width : 1440px) {
    
}
@media screen and (min-width : 768px) and (max-width : 1370px) {
    #rankAsProvince{width:330px;}
    #rankAsBrand{width:330px;}
    #rankAsCapacity{width:330px;}
}
</style>
<div ng-controller="dtBusinessCircumstancesModelCtrl" class="black-bg white">
	<div class="bus-cir-title text-center">
		<p class="font24" style="margin-bottom: 0.9rem;">投入产出比</p>
		<p class="font18">数据统计：<span>2017-01-01</span>至<span>2017-06-01</span></p>
		<div class="solor-wind-btn-con font20">
			<a class="solor-wind-btn" ng-class="{'active':solarOrWind == 'solar'}" ng-click="changeWindOrWind('solar')">光伏</a><a class="solor-wind-btn"  ng-class="{'active':solarOrWind == 'wind'}"  ng-click="changeWindOrWind('wind')">风电</a>
		</div>
	</div>
	<div class="clearfix" style="padding-bottom: 4.5rem;">
		<div class="rankAsProvince pull-left">
			<div id="rankAsProvince" style="height: 29.5rem;"></div>
		</div>
		<div class="rankAsBrand pull-left">
			<div id="rankAsBrand" style="height: 29.5rem;"></div>
		</div>
		<div class="rankAsCapacity pull-left">
			<div id="rankAsCapacity" style="height: 29.5rem;"></div>
		</div>
	</div>
</div>
<script>
app.controller('dtBusinessCircumstancesModelCtrl',function($scope, $http, $state, $stateParams) {
	$scope.solarOrWind = "solar";
	$scope.changeWindOrWind = function(type){
		$scope.solarOrWind = type;
	}

	
	init();
	function init(){
		//接口
		var data = {
				"rankAsProvince":{"province":["河北","天津","北京"],"value":[200,240,500]},
				"rankAsBrand":{"brand":["阳光","华为","古瑞瓦特","艾默生","台达","欧姆尼克","冠亚电源"],"value":[180,240,280,300,440,500,800]},
				"rankAsCapacity":{"capacity":["750","1500","2000"],"value":[200,240,500]}
		}
		
		var rankAsProvince = data.rankAsProvince;
		drawRankAsProvince(rankAsProvince.province,rankAsProvince.value);
		
		var rankAsBrand = data.rankAsBrand;
		drawRankAsBrand(rankAsBrand.brand,rankAsBrand.value);
		
		var rankAsCapacity = data.rankAsCapacity;
		drawRankAsCapacity(rankAsCapacity.capacity,rankAsCapacity.value);
	}
	
	//按省排名
	function drawRankAsProvince(province,value){
		var myChart = echarts.init(document.getElementById('rankAsProvince'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				title:{
					text:"按省份排名",
					textStyle:{
						color:"white",
						fontSize:20,
						fontWeight:'normal'
					},
					left:50,
					top:25
				},
				tooltip: {
					show: true
				},
				grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '50px',
					y : "150px",
					y2 : "70px"
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
						name:"省份",
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
						type:"bar",
						barWidth : 15,
						itemStyle: {
							normal: {
								color:'#fb7567'
							}
						},
						data: value
					}
				]
			};
		myChart.setOption(option);
	}
	
	//按品牌排名
	function drawRankAsBrand(brand,value){
		var myChart = echarts.init(document.getElementById('rankAsBrand'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				title:{
					text:"按品牌排名",
					textStyle:{
						color:"white",
						fontSize:20,
						fontWeight:'normal'
					},
					left:50,
					top:25
				},
				tooltip: {
					show: true
				},
				grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '50px',
					y : "120px",
					y2 : "70px"
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
						name:"品牌",
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
						data:brand
					}
				],
				series : [
					{
						type:"bar",
						barWidth : 15,
						itemStyle: {
							normal: {
								color:'#fb7567'
							}
						},
						data: value
					}
				]
			};
		myChart.setOption(option);
	}
	
	//按容量排名
	function drawRankAsCapacity(capacity,value){
		var myChart = echarts.init(document.getElementById('rankAsCapacity'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				title:{
					text:"按容量排名",
					textStyle:{
						color:"white",
						fontSize:20,
						fontWeight:'normal'
					},
					left:50,
					top:25
				},
				tooltip: {
					show: true
				},
				grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '50px',
					y : "150px",
					y2 : "70px"
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
						name:"容量：kW",
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
						data:capacity
					}
				],
				series : [
					{
						type:"bar",
						barWidth : 15,
						itemStyle: {
							normal: {
								color:'#fb7567'
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
