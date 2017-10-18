<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.tab-left{margin:20px;padding:0}
	.tab-left li{    padding: 4px 10px;cursor: pointer;text-align: center;width: 80px;margin: 0 auto 15px;}
	.tab-left li.active{border:1px solid rgb(0,190,190);color:rgb(0,190,190);border-radius:15px;}
	.tab-right{margin:20px;padding:0}
	.tab-right li{margin-bottom:15px;padding: 4px 10px;    cursor: pointer;    text-align: center;float:right;    width: 80px;}
	.tab-right li.active{border:1px solid rgb(0,190,190);color:rgb(0,190,190);border-radius:15px;}
</style>
<div class="mete-con clearfix" ng-controller="barModelChartCtrl" style="position:relative;">
	<div class="clearfix">
		<div class="col-sm-1 no-padder">
			<ul class="tab-left" id="tab-left">
				<li ng-click="changeYaxis('fail_count')" ng-class="{'active':axis=='fail_count'}">故障率</li>
				<li ng-click="changeYaxis('mtbf')" ng-class="{'active':axis=='mtbf'}">MTBF</li>
				<li ng-click="changeYaxis('mttr')" ng-class="{'active':axis=='mttr'}">MTTR</li>
			</ul>
		</div>
		<div class="col-sm-11 no-padder">
			<div id="barCurve"  style="height:400px;"></div>
		</div>
	</div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpFault/model/hoverBottomModel.jsp'"  id="bottom" class=" clearfix" ></div>
</div>
<script>
app.controller('barModelChartCtrl',function($scope, $http, $state, $stateParams) {
	var myBarChart = echarts.init(document.getElementById('barCurve'));
	window.addEventListener("resize", function() {
		myBarChart.resize();
	});
	$scope.isInitOption = false;//图表是否初始化option的标志
	$scope.axis = "fail_count";//默认y轴名称
	$scope.systemId ;//子系统ID
	
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
	
	$scope.$on('barModelData', function(event, data) {
		$scope.data = data;
		organizeBarData();
	});
	
	$("#barCurve").on('mouseover',function(e){
		init();
	});
	
	function organizeBarData(){
		var x = [],y = [];
		for(var i = 0;i<$scope.data.length;i++){
			if($scope.data[i].eqName != null){
				x.push($scope.data[i].eqName);
			}else{
				x.push("-");
			}
			
			if($scope.data[i][$scope.axis] != null){
				y.push($scope.data[i][$scope.axis]);
			}else{
				y.push("-");
			}
		}
		
		if($scope.isInition){
			drawChart(x,y);
		}else{
			initOption(x,y);
			$scope.isInitOption = true;
		}
	}
	
	$("#tab-left > li").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});
	$("#tab-right > li").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});
	
	//风机图表选择不同的坐标名称
	$scope.changeYaxis = function(name){
		$scope.axis = name;
		organizeBarData();
	}
	
	function drawChart(x,y){
		var opt = myBarChart.getOption();
		opt.xAxis[0].data = x;
		opt.series[0].data = y;
		myBarChart.setOption(opt);
	}
	
	function initOption(x,y){
		option = {
			tooltip : {
				trigger : 'axis',
				axisPointer : {
					type : 'line',
					lineStyle : {
						color : '#bbb',
						width : 1,
						type : 'solid'
					}
				},
				 formatter: function (params,ticket,callback) {
					 console.log(params)
					 var dataIndex = params[0].dataIndex;
					 $scope.systemId = $scope.data[dataIndex].id;
					 getAlertData();
			      }
		    }, 
			grid: {
				borderWidth: '0px',
				x: '60px',
				x2: '80px',
				y: "40px",
				y2: "30px"
			},
			calculable: false,
			xAxis: [{
				type: 'category',
				axisTick: {
					show: false
				},
				axisLabel: {
					textStyle: {
						color: '#bbb',
						fontSize: 12
					}
				},
				axisLine: {
					lineStyle: {
						color: '#bbb',
						width: 1
					}
				},
				splitLine: {
					show: false
				},
				data: x
			}],
			yAxis: [{
				type: 'value',
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				splitLine: {
					show: false
				},
			}],
			series: [{
				type: 'bar',
				barWidth: 15,
				itemStyle: {
					normal: {
						color: function(params) {
							return '#fe9700'
						}
					}
				},
				data:y
			}]
		}
		myBarChart.setOption(option);
	}
	
	//弹框数据下
	function getAlertData(){
		$("#top").hide();
		$("#bottom").css("top",0);
		$("#bottom").show();
		$http({
			method : "POST",
			url : "./WPFault/getStationEqFaultSubSysGraid.htm",
			params : {
				'dtime':dtime,
				'eqOrSubId':$scope.systemId, //系统Id
				'model':dateType,
				'type':1
			}
		})
		.success(function (msg) {
			$scope.$broadcast("hoverBottomData",msg);
		}).error(function(msg){
		}); 
	}
});

</script>
