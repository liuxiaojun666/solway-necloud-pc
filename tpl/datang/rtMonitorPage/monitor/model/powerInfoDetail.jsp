<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.black-bg{background:rgba(15,32,49,0.9);}
.power-output{width:26%;}
.generating-capacity{width:50%;}
.contrast{width:24%;margin-top: 4.8rem;border-left: 1px solid  rgba(255,255,255,0.3);padding: 0 2.2rem;    height: 32.9rem;}
.power-output-title{color:white;text-align:center;    text-align: center;height: 4.8rem;padding: 1rem;}
.pie-chart-con{border-right:1px solid rgba(255,255,255,0.3);padding: 0 2.2rem;    margin-bottom: 3rem;}
#pie-chart-solar{border-bottom:1px solid rgba(255,255,255,0.3)}
.white-square{width:0.8rem;height:0.8rem;background:white;display:inline-block;margin-right:1rem;}

.progress-con{position:relative;margin: 3.1rem 0 3.1rem 1.8rem;}
.progressBar {
    width: 100%;
    height: 1rem;
    border: 1px solid rgb(178,178,178);
    background: white;
    line-height: 0px; 
}
.span {
    display: inline-block;height:1rem;
}
.bar-content-green {
   position: absolute;right: 0;
}
.bar-content-red {
    background: #ff445e;
    
}
.bar-top-tip{position:absolute;top: -1.6em;   left: 0;}
.bar-down-tip{position:absolute;bottom:-1.6em;right:0;}
.cursor{cursor:pointer;}
.power-finish-detail-alert{display:none; position: absolute;
    bottom: -6rem;
    left: 1.8rem;
    background: white;
    color: black;
    padding: 8px;}
.triangle-tip{position: absolute;top: -0.7rem;
    border-left: 2px solid transparent;
    border-right: 34px solid transparent;
    border-bottom: 18px solid white;
    right: 1.7rem;
 }
@media screen and (min-width : 1701px) and (max-width : 1920px) {
    #pie-chart-solar{width:340px;}
    #pie-chart-wind{width:340px;}
     #generating-capacity{width:807px;}
}

@media screen and (min-width : 1441px) and (max-width : 1700px) {
    
}
@media screen and (min-width : 1371px) and (max-width : 1440px) {
    
}
@media screen and (min-width : 768px) and (max-width : 1370px) {
    #pie-chart-solar{width:250px;}
    #pie-chart-wind{width:250px;}
    #generating-capacity{width:580px;}
}

</style>
<div  ng-controller="dtPowerInfoDetailModelCtrl" class="black-bg">
	<div class="clearfix">
		<div class="pull-left power-output">
			<p class="power-output-title font20">应发电量<br/>(截至{{statDate}})</p>
			<div class="pie-chart-con">
				<div id="pie-chart-solar" style="height:16.5rem;"></div>
				<div id="pie-chart-wind" style="height:16.5rem;"></div>
			</div>
		</div>
		<div class="pull-left generating-capacity">
			<p class="power-output-title font20" style="line-height: 2.5rem;">发电量完成情况一览</p>
			<div id="generating-capacity" style="height: 33rem;"></div>
		</div>
		<div class="pull-left contrast">
			<div style="margin-top: 5rem;">
				<p class="font18">
					<span class="white-square"></span><span>今年计划发电量完成情况</span>
				</p>
				<div class="progress-con">
                	<div class="bar-hover-tip" style="height:12px;display:none;">aaaaaaaaa</div>
                	<span class="bar-top-tip font14" style="color:#de7571;">实际</span>
                	<div class="progressBar cursor">
						<span class="bar-content-red span" style="width:0.7;background:#de7571;"></span>
						<span class="bar-content-green span" style="width:30%;background:#62bfd9;"></span>
					</div>
					<span class="bar-down-tip font14" style="color:#62bfd9;">计划</span>
                </div>
			</div>
			<div>
				<p class="font18">
					<span class="white-square"></span><span>模型预测电量情况</span>
				</p>
				<div class="progress-con">
                	<div class="bar-hover-tip" style="height:12px;display:none;"></div>
                	<span class="bar-top-tip font14" style="color:#e574ac;">模型预测</span>
                	<div class="progressBar cursor">
						<span class="bar-content-red span" style="width:{{item.percen| dataNull0Filter}}%;background:#e574ac;"></span>
						<span class="bar-content-green span" style="width:{{(100-item.percen)| dataNull0Filter}}%;background:#6f89e1;"></span>
					</div>
					<span class="bar-down-tip font14" style="color:#6f89e1;">计划电量</span>
                </div>
			</div>
			<div style="padding-top: 10px;position:relative;">
				<p class="font18">
					<span class="white-square"></span><span class="cursor" id="powerFinishHover">发电量同比完成情况</span>
					<span><img src="theme/images/datang/monitoringMap/arrow-green-up.png" style="width: 0.55rem;margin: 0 0.85rem 0 1.8rem;"></span>
					<span style="color:#06ff9e;">20%</span>
				</p>
				<div class="power-finish-detail-alert font16">
					<p>截止6月30日</p>
					<p>今年累计发电量：120kWh</p>
					<p>去年同期发电量:350kWh</p>
					<span class="triangle-tip"></span>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	
})
app.controller('dtPowerInfoDetailModelCtrl',function($scope, $http, $state, $stateParams) {
	
	$("#powerFinishHover").mouseover(function(){
		$(".power-finish-detail-alert").show();
	});
	$("#powerFinishHover").mouseout(function(){
		$(".power-finish-detail-alert").hide();
	});
	init();
	function init(){
		initSolarPieData(); //光伏数据
		initWindPieData();  //风电数据
		initPowerFinishBarData(); //发电完成情况数据
	}
	
	function initSolarPieData(){
		//接口？
		//返回数据
		$http({
			url : "${ctx}/currentPower/getElectricityData.htm",
			params: {
				//dateStr : new Date().Format("yyyy-MM-dd"),
				clazz : "01"
			}
		}).success(function(res) {
			$scope.statDate = new Date().Format("yyyy-MM-dd");
			var data = [
		                {value:0, name:'实发电量'},
		                {value:0, name:'故障损失电量'},
		                {value:0, name:'限电损失电量'},
		                {value:0, name:'计划检修损失电量'},
		                {value:0, name:'其他'}
			];
			if(res && res.data){
				data = [
			                {value:res.data.DTW, name:'实发电量'},
			                {value:res.data.DDeviceFaultLoseTW, name:'故障损失电量'},
			                {value:res.data.LimitsTW, name:'限电损失电量'},
			                {value:res.data.DPlanRepairLoseTW, name:'计划检修损失电量'},
			                {value:res.data.OrtherTW, name:'其他'}
			            ];
			}
			
			drawPieSolarChart(data);
		});
		
	}
	
	function initWindPieData(){
		
		$http({
			url : "${ctx}/currentPower/getElectricityData.htm",
			params: {
				//dateStr : new Date().Format("yyyy-MM-dd"),
				clazz : "02"
			}
		}).success(function(res) {
			console.log(res)
			var data = [
			                {value:0, name:'实发电量'},
			                {value:0, name:'故障损失电量'},
			                {value:0, name:'限电损失电量'},
			                {value:0, name:'计划检修损失电量'},
			                {value:0, name:'其他'}
			];
			if(res && res.data){
				data = [
			                {value:res.data.DTW, name:'实发电量'},
			                {value:res.data.DDeviceFaultLoseTW, name:'故障损失电量'},
			                {value:res.data.LimitsTW, name:'限电损失电量'},
			                {value:res.data.DPlanRepairLoseTW, name:'计划检修损失电量'},
			                {value:res.data.OrtherTW, name:'其他'}
			    ];
			}
			
			drawPieWindChart(data);
		});
	}
	
	function initPowerFinishBarData(){
		//接口？
		
		$http({
			url : "${ctx}/Report/getStationYearKwhForTable.htm",
			params: {
				//dateStr : new Date().Format("yyyy-MM-dd"),
				year : new Date().Format("yyyy")
			}
		}).success(function(res) {
			 var data = {
						"lastYearPower":[10,20,30,20,40,50,53,89,0,20,40,50],
				        "thisYearPower": [20,40,50,53,89,10,20,30,0,20,40,50],
				        "thisYearPlanPower":[53,89,20,40,50],
				        "time":["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
				};
			
				drawGeneratingPowerBarChart(data.lastYearPower,data.thisYearPower,data.thisYearPlanPower,data.time);
		});
		
	}
	//光伏饼图
	function drawPieSolarChart(data) {
		var pieSolarChart = echarts.init(document.getElementById('pie-chart-solar'));
		window.addEventListener("resize", function() {
			pieSolarChart.resize();
		});
		var option = {
				title : {
			        text: '光伏',
			        y:'5%',
			        textStyle:{
			        	color:"white"
			        },
			        x:'left'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{b}<br/>{c} ({d}%)"
			    },
			    legend: {
			        orient : 'vertical',
			        x : 'left',
			        y:'20%',
			        show:true,
			        textStyle:{
			        	color:'white',
			        	fontSize:'12'
			        },
			        data: [{
			            name: '实发电量',
			            icon: 'rect'
			        },{
			            name: '故障损失电量',
			            icon: 'rect'
			        },{
			            name: '限电损失电量',
			            icon: 'rect'
			        },{
			            name: '计划检修损失电量',
			            icon: 'rect'
			        },{
			            name: '其他',
			            icon: 'rect'
			        }]
			    },
			    calculable : true,
			    series : [
			        {
			            name:'',
			            type:'pie',
			            radius : '40%',
			            center: ['70%', '40%'],
			            label:{
			            	normal:{
			            		show:false
			            	}
			            },
			            data:data
			        }
			    ],
			    label:{
			    	normal:{
			    		textStyle:{
			    			color:'white'
			    		}
			    	}
			    },
			    color: ['#81b3e5','#f5a49f','#bd8cbf','#7cf7d6']
		};
		pieSolarChart.setOption(option,true);
	}
	
	
	//风电饼图
	function drawPieWindChart(data) {
		var pieWindChart = echarts.init(document.getElementById('pie-chart-wind'));
		window.addEventListener("resize", function() {
			pieWindChart.resize();
		});
		var option = {
				title : {
			        text: '风电',
			        y:'5%',
			        textStyle:{
			        	color:"white"
			        },
			        x:'left'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{b}<br/>{c} ({d}%)"
			    },
			    legend: {
			        orient : 'vertical',
			        x : 'left',
			        y:'20%',
			        show:true,
			        textStyle:{
			        	color:'white',
			        	fontSize:'12'
			        },
			        data: [{
			            name: '实发电量',
			            icon: 'rect'
			        },{
			            name: '故障损失电量',
			            icon: 'rect'
			        },{
			            name: '限电损失电量',
			            icon: 'rect'
			        },{
			            name: '计划检修损失电量',
			            icon: 'rect'
			        },{
			            name: '其他',
			            icon: 'rect'
			        }]
			        //data:['实发电量','故障损失电量','限电损失电量','亚健康损失电量','计划检修损失电量','其他']
			    },
			    calculable : true,
			    series : [
			        {
			            name:'',
			            type:'pie',
			            radius : '40%',
			            center: ['70%', '40%'],
			            label:{
			            	normal:{
			            		show:false
			            	}
			            },
			            data:data
			        }
			    ],
			    label:{
			    	normal:{
			    		textStyle:{
			    			color:'white'
			    		}
			    	}
			    },
			    color: ['#81b3e5','#f5a49f','#bd8cbf','#fb4cbb','#4e5dcb','#7cf7d6']
		};
		pieWindChart.setOption(option,true);
	}
	

	//发电量对比柱状图
	
	function drawGeneratingPowerBarChart(lastYearPower,thisYearPower,thisYearPlanPower,time){
		var myChart = echarts.init(document.getElementById('generating-capacity'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var aCalendarListWeaterColor = "rgb(255,199,0)";
		var option = {
				tooltip: {
					show: true
				},
				legend : {
					data :[{name:'今年计划发电量',icon: 'circle'},'去年发电量','今年发电量'],
			        
					textStyle:{
			        	color:"white"
			        },
					left : 50,
					bottom:100
				},
				color:['#ff9947'],
				grid : {
					borderWidth : '0px',
					x : '60px',
					x2 : '80px',
					y : "90px",
					y2 : "200px"
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
						data : time
					}
				],
				yAxis : [
					{
						name:'电量',
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
						"name":"去年发电量",
						"type":"bar",
						barWidth : 15,
						itemStyle: {
							normal: {
								color:'#8393ca'
							}
						},
						"data": lastYearPower
					},
					{
						"name":"今年发电量",
						"type":"bar",
						barWidth : 15,
						itemStyle: {
							normal: {
								color:'#69e963'
							}
						},
						"data":thisYearPower
					},
					{
						"name":"今年计划发电量",
						"type":"line",
						itemStyle : {
							normal : {
								lineStyle : {
									color : 'color:#ff9947',
									width : 1,
									//type:'dashed'
								}
							}
						},	
						"data":thisYearPlanPower 
					}
				]
			};
		myChart.setOption(option);
		
	}
});
</script>
