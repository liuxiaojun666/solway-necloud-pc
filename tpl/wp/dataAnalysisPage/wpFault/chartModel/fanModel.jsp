<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.tab-left{margin:20px;padding:0}
	.tab-left li{    padding: 4px 10px;cursor: pointer;text-align: center;width: 80px;margin: 0 auto 15px;}
	.tab-left li.active{border:1px solid rgb(0,190,190);color:rgb(0,190,190);border-radius:15px;}
	.tab-right{margin:20px;padding:0}
	.tab-right li{margin-bottom:15px;padding: 4px 10px;    cursor: pointer;    text-align: center;float:right;    width: 80px;}
	.tab-right li.active{border:1px solid rgb(0,190,190);color:rgb(0,190,190);border-radius:15px;}
	#top{    border: 1px solid black;z-index:2;margin-bottom:10px;width:98%;
    position: absolute;
    display:none;
    background: white;}
	.left-navi li{    border-bottom: 1px solid rgb(207,207,207); height: 30px;line-height: 30px;text-align: center;}
	.hover-right tr{border-bottom: 1px solid rgb(207,207,207);}
	table td[class*="col-"]{
	    float: left;text-align:center;    border-right: 1px solid rgb(207,207,207);
	}
	table th[class*="col-"] {
	    float: left;text-align:center; 
	}
</style>
<div class="mete-con clearfix" ng-controller="fanModelChartCtrl">
	<div class="clearfix">
		<div class="col-sm-1 no-padder">
			<ul class="tab-left" id="tab-left">
				<li ng-click="changeAxis('y','fail_count')" ng-class="{'active':yAxis=='fail_count'}">故障率</li>
				<li ng-click="changeAxis('y','mtbf')" ng-class="{'active':yAxis=='mtbf'}">MTBF</li>
				<li ng-click="changeAxis('y','mttr')" ng-class="{'active':yAxis=='mttr'}">MTTR</li>
			</ul>
		</div>
		<div class="col-sm-11 no-padder">
			<div id="fanCurve"  style="height:350px;"></div>
		</div>
	</div>
	<div class="clearfix">
		<div  style="float: right;">
			<ul class="tab-right" id="tab-right">
				<li ng-click="changeAxis('x','fail_count')" ng-class="{'active':xAxis=='fail_count'}">故障率</li>
				<li ng-click="changeAxis('x','mtbf')" ng-class="{'active':xAxis=='mtbf'}">MTBF</li>
				<li ng-click="changeAxis('x','mttr')" ng-class="{'active':xAxis=='mttr'}">MTTR</li>
			</ul>
		</div>
	</div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/model/hoverTopModel.jsp'"  id="top" class=" clearfix" ></div>
</div>
<script>
app.controller('fanModelChartCtrl',function($scope, $http, $state, $stateParams) {
	var myChartFan = echarts.init(document.getElementById('fanCurve'));
	$scope.isInitOption = false;//图表是否初始化option的标志
	$scope.yAxis = "fail_count";//默认y轴名称
	$scope.xAxis = "mttr";//默认x轴名称
	
	var dtime,dateType;
	function init(){
		
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
	init();
	
	window.addEventListener("resize", function() {
		myChartFan.resize();
	});
	myChartFan.on('mouseover', function (params) {
		$scope.yOffset = params.event.offsetY;
		$scope.yClient = params.event.event.clientY;
		init();
		var dataIndex = params.dataIndex;
		//获取设备Id
		$scope.eqid = $scope.data[dataIndex].eqid;
		$scope.eqName = $scope.data[dataIndex].name;
		getAlertData();
	});
	
	//风机图表选择不同的坐标名称
	$scope.changeAxis = function(type,name){
		if(type == "x"){
			$scope.xAxis = name;
		}else if(type == "y"){
			$scope.yAxis = name;
		}
		organizeData();
	}
	$scope.$on('fanModelData', function(event, data) {
		console.log("------");
		console.log(data);
		$scope.data = data;
		organizeData();
	});
	
	function organizeData(){
		var organizeData = [];
		for(var i = 0;i<$scope.data.length;i++){
			organizeData.push([$scope.data[i][$scope.xAxis],$scope.data[i][$scope.yAxis]]);
		}
		if($scope.isInitOption){
			drawChart(organizeData);
		}else{
			initOption(organizeData);
			$scope.isInitOption = true;
		}
	}
	
	function drawChart(data){
		var opt = myChartFan.getOption();
		opt.series[0].data = data;
		myChartFan.setOption(opt);
	}
	
	
	function initOption(data){
		option = {
			    grid : {
					borderWidth : '0px',
					x : '60px',
					x2 : '30px',
					y : "50px",
					y2 : "50px"
				},
				calculable : false,
				xAxis : [ {
					type : 'value',
					scale : true,
					axisTick : {
						show : false
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					axisLabel : {
						textStyle : {
							align : 'center',
							color : 'rgba(187,187,187,0.9)',
							fontSize : 13
						}
					},
					splitLine : {
						show : false,
					}
				} ],
				yAxis : [{
					//name:'%',
					type : 'value',
					scale : true,
					axisLabel : {
						margin:20,
						textStyle : {
							color : 'rgba(187,187,187,0.9)',
							fontSize : 12
						}
					},
					
					font : {
						color : '#666'
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					splitLine : {
						show : false,
					} 
					
				}],
				series : [
					{
							type : 'scatter',
							symbol: 'image://theme/images/wp/dataAnalysis/wpFault/fan.png',
							symbolSize:15,
							data : data
					}
			]
		}
		myChartFan.setOption(option);
	}
	
	//弹框数据
	function getAlertData(){
		$("#bottom").hide();
		$("#top").show();
		$http({
			method : "POST",
			url : "./WPFault/getStationEqFaultSubSysGraid.htm",
			params : {
				'dtime':dtime,
				'eqOrSubId':$scope.eqid,
				'model':dateType,
				'type':0
			}
		})
		.success(function (msg) {
			$scope.$broadcast("hoverData",msg);
		}).error(function(msg){
		}); 
		
	}
});

</script>
