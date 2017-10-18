<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
@media screen and (min-width : 1701px) and (max-width : 1920px) {
    #pie-chart-fan-capacity{width:340px;}
    #pie-chart-fan-number{width:340px;}
    #pie-chart-inverter-capacity{width:340px;}
    #pie-chart-inverter-number{width:340px;}
     #generating-capacity{width:807px;}
}

@media screen and (min-width : 1441px) and (max-width : 1700px) {
    
}
@media screen and (min-width : 1371px) and (max-width : 1440px) {
    
}
@media screen and (min-width : 768px) and (max-width : 1370px) {
    #pie-chart-fan-capacity{width:250px;}
    #pie-chart-fan-number{width:250px;}
    #pie-chart-inverter-capacity{width:250px;}
    #pie-chart-inverter-number{width:250px;}
    #generating-capacity{width:580px;}
}
.black-bg{background:rgba(15,32,49,0.9);}
.power-output{width:26%;}
.generating-capacity{width:50%;}
.contrast{width:24%;}
.power-output-title{color:white;text-align:center;    text-align: center;height: 4.8rem;padding: 1rem;}
.pie-chart-con{border-right:1px solid rgba(255,255,255,0.3);padding: 0 2.2rem;    margin-bottom: 3rem;}
.pie-chart-con-right{border-left:1px solid rgba(255,255,255,0.3);margin-bottom: 3rem;}
#pie-chart-fan-capacity{border-bottom:1px solid rgba(255,255,255,0.3)}
#pie-chart-inverter-capacity{border-bottom:1px solid rgba(255,255,255,0.3)}
#pie-chart-fan-number{}
.title-blue-word{color:rgb(2,210,213);margin:0 7rem;text-align:center;}
.title-blue-word >span{display:inline-block;margin-right:2rem;}
.title-blue-word >span:last-child{margin-right:0;}
.year-area-btn{width:100px;height:40px;text-align:center;display:inline-block;font-size:14px;color:white;background:transparent;border:1px solid white;line-height:40px;}
.year-area-btn.active{color:black;background:white;}
</style>
<div  ng-controller="dtBasicInfoModelCtrl" class="black-bg">
	<div class="clearfix">
		<div class="pull-left power-output">
			<p class="power-output-title font20">风机情况</p>
			<div class="pie-chart-con">
				<div id="pie-chart-fan-capacity" style="height:16.5rem;"></div>
				<div id="pie-chart-fan-number" style="height:16.5rem;"></div>
			</div>
		</div>
		<div class="pull-left generating-capacity">
			<p class="power-output-title font20" style="height: 3rem;">装机情况</p>
			<div class="title-blue-word font16">
				<span>风机：100台</span>
				<span>箱变：200台</span>
				<span>逆变器：100台</span>
				<span>汇流箱：100台</span>
			</div>
			<div style="height: 33rem;">
				<div style="margin:45px 30px;"><a class="year-area-btn" ng-click="changeInstData(1)">年份</a><a class="year-area-btn active" ng-click="changeInstData(2)">区域</a></div>
				<div id="generating-capacity" style="height:24rem;"></div>
			</div>
			
		</div>
		<div class="pull-left contrast">
			<p class="power-output-title font20">逆变器情况</p>
			<div class="pie-chart-con-right">
				<div id="pie-chart-inverter-capacity" style="height:16.5rem;margin: 0 auto;"></div>
				<div id="pie-chart-inverter-number" style="height:16.5rem;    margin: 0 auto;"></div>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('dtBasicInfoModelCtrl',function($scope, $http, $state, $stateParams) {
	
	$(".year-area-btn").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});
	init();
	function init(){
		
		$scope.isYear = false;
		
		fanCapacityData();//风机按容量数据
		fanNumberData();//风机按数量数据
		
		inverterCapacityData();//逆变器按容量数据
		inverterNumberData();//逆变器按容量数据
		
		installConditionData();//装机情况数据
		
	}
	$scope.changeInstData = function(type){
		
		if(type == 1){
			$scope.isYear = true;
		}else{
			$scope.isYear = false;
		}
		installConditionData();
	}
	function fanCapacityData(){
		//接口
		var data = [
	                {value:2335, name:'联合动力'},
	                {value:310, name:'金风'},
	                {value:1548, name:'Gamesa'},
	                {value:500, name:'远景'}
	            ];
		drawFanCapacityPieChart(data);
	}
	
	function fanNumberData(){
		//接口
		var data = [
	                {value:2335, name:'联合动力'},
	                {value:310, name:'金风'},
	                {value:1548, name:'Gamesa'},
	                {value:500, name:'远景'}
	            ];
		drawFanNumberPieChart(data);
	}
	
	function installConditionData(){
		//接口
		var data = {
				"solarCapacity":[30,89,50],
		        "windCapacity": [89,100,400],
		        "x":["天津","北京","河北"]
		};
		if($scope.isYear){
			data = {
					"solarCapacity":[40,19,70],
			        "windCapacity": [29,80,100],
			        "x":[2014,2015,2016]
			};
		}
		drawInstallConditionBarChart(data.solarCapacity,data.windCapacity,data.x)
	}
	
	function inverterCapacityData(){
		//接口
		var data = [
	                {value:2335, name:'阳光'},
	                {value:310, name:'华为'}
	            ];
		drawInverterCapacityPieChart(data)
	}
	
	function inverterNumberData(){
		//接口
		var data = [
	                {value:2335, name:'阳光'},
	                {value:310, name:'华为'}
	            ];
		drawInverterNumberPieChart(data)
	}
	//风机按容量-饼图
	function drawFanCapacityPieChart(data) {
		var fanNumberChart = echarts.init(document.getElementById('pie-chart-fan-capacity'));
		window.addEventListener("resize", function() {
			fanNumberChart.resize();
		});
		var option = {
				title : {
			        text: '按容量',
			        y:'5%',
			        textStyle:{
			        	color:"white"
			        },
			        x:'left'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
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
			            name: '联合动力',
			            icon: 'rect'
			        },{
			            name: '金风',
			            icon: 'rect'
			        },{
			            name: 'Gamesa',
			            icon: 'rect'
			        },{
			            name: '远景',
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
			    color: ['#73a3d2','#ec766f','#c477c7','#74dbbf']
		};
		fanNumberChart.setOption(option,true);
	}
	
	//风机按数量-饼图
	function drawFanNumberPieChart(data) {
		var pieSolarChart = echarts.init(document.getElementById('pie-chart-fan-number'));
		window.addEventListener("resize", function() {
			pieSolarChart.resize();
		});
		var option = {
				title : {
			        text: '按数量',
			        y:'5%',
			        textStyle:{
			        	color:"white"
			        },
			        x:'left'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
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
			            name: '联合动力',
			            icon: 'rect'
			        },{
			            name: '金风',
			            icon: 'rect'
			        },{
			            name: 'Gamesa',
			            icon: 'rect'
			        },{
			            name: '远景',
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
			    color: ['#73a3d2','#ec766f','#c477c7','#74dbbf']
		};
		pieSolarChart.setOption(option,true);
	}
	
	//装机情况柱状图
	function drawInstallConditionBarChart(solar,wind,x){
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
					data :['光伏','风电'],
			        
					textStyle:{
			        	color:"white"
			        },
					left : 50,
					bottom:20
				},
				color:['#ff9947'],
				grid : {
					borderWidth : '0px',
					x : '60px',
					x2 : '80px',
					y : "40px",
					y2 : "80px"
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
						name:'容量',
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
						"name":"风电",
						"type":"bar",
						barGap : '-100%',
						barWidth : 20,
						itemStyle: {
							normal: {
								color:'#69e963'
							}
						},
						"data":wind
					},
					{
						"name":"光伏",
						"type":"bar",
						barGap : '-100%',
						barWidth : 20,
						itemStyle: {
							normal: {
								color:'#8393ca'
							}
						},
						"data": solar
					}
				]
			};
		myChart.setOption(option);
		
	}
	
	//逆变器按容量-饼图
	function drawInverterCapacityPieChart(data){
		var myChart = echarts.init(document.getElementById('pie-chart-inverter-capacity'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				title : {
			        text: '按数量',
			        y:'5%',
			        textStyle:{
			        	color:"white"
			        },
			        x:'left'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
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
			            name: '阳光',
			            icon: 'rect'
			        },{
			            name: '华为',
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
			    color: ['#73a3d2','#ec766f']
		};
		myChart.setOption(option,true);
	}
	
	//逆变器按数量-饼图
	function drawInverterNumberPieChart(data){
		var myChart = echarts.init(document.getElementById('pie-chart-inverter-number'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		var option = {
				title : {
			        text: '按数量',
			        y:'5%',
			        textStyle:{
			        	color:"white"
			        },
			        x:'left'
			    },
			    tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
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
			            name: '阳光',
			            icon: 'rect'
			        },{
			            name: '华为',
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
			    color: ['#73a3d2','#ec766f']
		};
		myChart.setOption(option,true);
	}
});
</script>
