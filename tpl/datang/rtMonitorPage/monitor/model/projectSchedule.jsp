<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@media screen and (min-width : 1701px) and (max-width : 1920px) {
    #solarWindBarGraph{width:540px;}
}
@media screen and (min-width : 1441px) and (max-width : 1700px) {
    
}
@media screen and (min-width : 1371px) and (max-width : 1440px) {
    
}
@media screen and (min-width : 768px) and (max-width : 1370px) {
    #solarWindBarGraph{width:480px;}
}
.black-bg{background:rgba(15,32,49,0.9);}
.progress-con{position:relative;}
.progressBar {
    width: 100%;
    height: 1.7rem;
    background: #c7ddf7;
}
.span {
    display: inline-block;height:1.7rem;
}
.bar-content-blue { background: #4ba0ff;position:relative;}
.percent-value{position:absolute;    top: -1.6rem;left: 100%;}
.bar-down-tip{position:absolute;bottom:-1.6em;right:0;}
.cursor{cursor:pointer;}
.label-name{display: block;width: 6.7rem;text-align: center;height: 1.7rem;line-height: 1.7rem;}
.blue-word{color:#68afff;}
</style>
<div  ng-controller="dtProjectScheduleModelCtrl" class="black-bg">
	<div class="clearfix" style="padding:65px 0;">
		<div class="pull-left" style="width:50%;padding-bottom: 6rem;border-right: 1px solid rgba(255,255,255,0.3);">
			<p class="font20 text-center">工程进度情况</p>
			<div style="padding: 1rem 11rem 0px 6.5rem;">
				<div class="h-box" style="margin-top:6rem;">
					<label class="label-name font18">龙游电站</label>
					<div class="progress-con flex">
		               	<div class="progressBar cursor">
							<span class="bar-content-blue span" style="width:70%;"><span class="percent-value">70%</span></span>
						</div>
						<span class="bar-down-tip font16">预计完工时间：<span class="blue-word">2017年8月20日</span></span>
		            </div>
		        </div>
		        <div class="h-box" style="margin-top:6rem;">
					<label class="label-name font18">盐山电站</label>
					<div class="progress-con flex">
		               	<div class="progressBar cursor">
							<span class="bar-content-blue span" style="width:65%;"><span class="percent-value">65%</span></span>
						</div>
						<span class="bar-down-tip font16">预计完工时间：<span class="blue-word">2017年8月20日</span></span>
		            </div>
		        </div>
		        <div class="h-box" style="margin-top:6rem;">
					<label class="label-name font18">风口电站</label>
					<div class="progress-con flex">
		               	<div class="progressBar cursor">
							<span class="bar-content-blue span" style="width:95%;"><span class="percent-value">95%</span></span>
						</div>
						<span class="bar-down-tip font16">预计完工时间：<span class="blue-word">2017年8月20日</span></span>
		            </div>
		        </div>
	        </div>
		</div>
		<div class="pull-left" style="width:50%;">
			<p class="font20 text-center">2018年规划</p>
			<div style="padding:2.6rem 7rem 0;">
				<div class="clearfix col-sm-12">
					<div class="col-sm-6 no-padder">风电合计：<span>19000kW</span></div>
					<div class="col-sm-6 no-padder">光伏合计：<span>19000kW</span></div>
				</div>
				<div id="solarWindBarGraph" style="height: 28.5rem;"></div>
			</div>
		</div>		
	</div>
</div>
<script>
app.controller('dtProjectScheduleModelCtrl',function($scope, $http, $state, $stateParams) {

	init();
	function init(){
		//2018风电，光伏规划
		var data = {
				"solar":[50,53,89],
		        "wind": [20,30,50],
		        "xaxis":["北京","天津","河北"]
		};
		drawWindSolarBarChart(data.solar,data.wind,data.xaxis);
	}
	
	//2018规划柱状图
	
	function drawWindSolarBarChart(solar,wind,xaxis){
		var myChart = echarts.init(document.getElementById('solarWindBarGraph'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				tooltip: {
					show: true
				},
				legend : {
					data :['光伏','风电'],
			        
					textStyle:{
			        	color:"white"
			        },
					left : 50,
					bottom:70
				},
				grid : {
					borderWidth : '0px',
					x : '60px',
					x2 : '80px',
					y : "90px",
					y2 : "150px"
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
								color : 'white',
								fontSize : 12
							}
						},
						axisLine : {
							lineStyle : {
								color : 'white',
								width : 1
							}
						},
						splitLine : {
							show : false
						},
						data : xaxis
					}
				],
				yAxis : [
					{
						name:'单位：kW',
						type : 'value',
						axisLine : {
							lineStyle : {
								width : 1,
								color : 'white'
							}
						},
						axisLabel : {
							axisLabel : 10,
							textStyle : {
								color : 'white',
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
						name:"光伏",
						type:"bar",
						stack: '1',
						barWidth : '30',
						itemStyle: {
							normal: {
								color:'#f0ae58'
							}
						},
						data: solar
					},
					{
						name:"风电",
						type:"bar",
						stack: '1',
						barWidth : '30',
						itemStyle: {
							normal: {
								color:'#29bf8f'
							}
						},
						data:wind
					}
				]
			};
		myChart.setOption(option);
		
	}
	
});
</script>
