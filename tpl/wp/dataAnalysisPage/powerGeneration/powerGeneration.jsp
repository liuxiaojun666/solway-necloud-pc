<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ctx}/theme/css/wp/dataAnalysisPage/powerGeneration.css">
<div class="hbox hbox-auto-xs hbox-auto-sm"  ng-controller="wpPowerGenerationCtrl">
	<div class="overview-title" >
		<div class="clearfix">
			<div class="pull-left">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
			</div>
			<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'" style="float:left;"></div>
			<div class="pull-left" style="margin: 0 50px;"><select id="dimention" class="dimention"><option value="fan">风机维度</option><option value="time">时间维度</option></select></div>
		</div>
	</div>
	<div class="mete-con">
		<div class="clearfix" style="margin:10px 0;">
			<div class="pull-left square">理论发电量 
				<span>{{renderData.shd_kwh[0]|dataNullFilter}}</span><span>{{renderData.shd_kwh[1]|dataNullFilter}}</span>
			</div>
			<div class="pull-left square">实际发电量
				<span>{{renderData.real_kwh[0]|dataNullFilter}}</span>
				<span>{{renderData.real_kwh[1]|dataNullFilter}}</span>
			</div>
		</div>
	</div>
	<div class="mete-con clearfix" style="background:white;">
		<div class="pull-right" ng-show="tab == 'dataGraph'">
			<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
				<span class="m-t-xs no-padder text-center">
					<i class="fa fa-circle" style="color: rgb(140,41,103)"></i> 
					<span class="col-9 m-r-xs text-1-1x">理论发电量<small></small></span> 
				</span>
				<span class="m-t-xs no-padder text-center">
					<i class="fa fa-circle" style="color:rgb(245,102,105)"></i> 
					<span class="col-9 m-r-xs text-1-1x">实际发电量<small></small></span> 
				</span>
				<span class="tab" ng-click="changeTab('tabTable')">数据表格</span>
			</div >
		</div>
		<div class="clearfix">
			<div  ng-show="tab == 'dataTable'" class="tab pull-right"  ng-click="changeTab('dataGraph')">数据图表</div>
		</div>
		<div id="monthChart" ng-show="tab == 'dataGraph'"></div>
		<div id="monthTable" ng-show="tab == 'dataTable'" style="overflow:auto;">
			<table  class="table  table-striped b-t b-light bg-table">
				<thead>
					<th class="text-center">日期</th>
					<th class="text-center">理论发电量（kWh）</th>
					<th class="text-center">实际发电量（kWh）</th>
				</thead>
				<tbody >
					<tr ng-repeat="kwh in kwhList">
						<td class="text-center">
							 <!-- <span ng-bind="kwh.xaxisTime|date:'yyyy-MM-dd'"></span> -->
						</td>
						<td class="text-center">
							<span>{{kwh.shd_kwh|dataNullFilter}}</span>
						</td>
						<td class="text-center">
							<span>{{kwh.real_kwh|dataNullFilter}}</span>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div> 
<script>
app.controller('wpPowerGenerationCtrl',function($scope, $http, $state, $stateParams) {
	
	function responseHeight(){
		$("#monthChart").css("height",$(window).height()-280);
		$("#monthTable").css("height",$(window).height()-280);
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight(); 
	
	var dateType,dtime;//接口参数，全局变量
	$scope.chartData = null;//判断是否初始化图表的标志
	
	var myChart = echarts.init(document.getElementById('monthChart'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dateType = "month";
	$scope.pageType = "fan";//判断接口请求的是时间维度还是风机维度的标志
	
	init();
	
	//初始化函数
	function init(){
		getParams();
		infoData();
		judge();
	}
	
	$scope.$on("emitChangeDate",function(e,data){
		$scope.dateType = data.dataType;
		$scope.dtime =data.dtime;
		
		init();
	});
	
	//接口参数获取
	function getParams(){
		if($scope.dateType == "day"){
			dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
			dateType = 'd';
		}else if($scope.dateType == "month"){
			dtime = new Date($scope.dtime).Format("yyyy-MM");
			dateType = 'm';
		}else if($scope.dateType == "year"){
			dtime = new Date($scope.dtime).Format("yyyy");
			dateType = 'y';
		}else{
			dtime = '';
			dateType = '';
		}
	}
	
	//获取基本数据
	function infoData(){
		$http({
			method : "POST",
			url : "./WPTurbines/getStationWeatherTurbinesInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.renderData = msg;
		}).error(function(msg){
		}); 
	}
	
	//判断调时间维度接口还是风机维度接口
	function judge(){
		if($scope.pageType == "fan"){
			fanChartData();
		}else if($scope.pageType == "time"){
			timeChartData();
		}
	}
	
	//获取图表数据-风机维度
	function fanChartData(){
		$http({
			method : "POST",
			url : "./WPTurbines/getStationTurbinesWindChart.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			if(msg.windChartList){
				organizeData(msg.windChartList,"fan");
			}else{
				organizeData([],"fan");
			}
		}).error(function(msg){
		}); 
	}
	
	//获取图表数据-时间维度
	function timeChartData(){
		$http({
			method : "POST",
			url : "./WPTurbines/getStationWeatherTurbinesChart.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			if(msg.turbinesChartList){
				organizeData(msg.turbinesChartList,"time");
			}else{
				organizeData([],"time");
			}
		}).error(function(msg){
		}); 
	}
	
	//切换时间维度和风机维度
	$("#dimention").change(function(){
		var currentValue = $(this).val();
		infoData();
		if(currentValue == "fan"){
			$scope.pageType = "fan";
			fanChartData();
		}else if(currentValue == "time"){
			$scope.pageType = "time";
			timeChartData();
		}
	});
	
	function organizeData(data,type){
		drawTable(data);
		
		var x = [],y1 = [],y2 = [];
		for(var i = 0;i<data.length;i++){
			if(type == "fan"){
				if(data[i].eqName != null){
					x.push(data[i].eqName);
				}else{
					x.push("-");
				}
			}else if(type == "time"){
				if(data[i].time != null){
					x.push(data[i].time);
				}else{
					x.push("-");
				}
			}
			
			if(data[i].shd_kwh != null){
				y1.push(data[i].shd_kwh);
			}else{
				y1.push("-");
			}
			
			if(data[i].real_kwh != null){
				y2.push(data[i].real_kwh);
			}else{
				y2.push("-");
			}
		}
		
		if(type == "time"){
			x.sort(function (value1, value2) {
				return value1 - value2;
			});
		}
		if($scope.chartData){
			drawChart(x,y1,y2)
		}else{
			initOption(x,y1,y2);
			$scope.chartData = data;
		} 
	}
	
	
	//图表和table切换
	$scope.tab = "dataGraph";//默认显示图表
	$scope.changeTab = function(val){
		if(val == "tabTable"){
			$scope.tab = "dataTable";
		}
		if(val == "dataGraph"){
			$scope.tab = "dataGraph";
		}
	}
	
	function drawTable(msg){
		$scope.kwhList = [];
		$scope.kwhList = msg
	}
	function drawChart(x,y1,y2){
		myChart.setOption({
			xAxis : [ {
				data : x
			}],
			series : [
					  {
						name : '理论发电量' ,
						type : 'bar',
						data :y1
					},{
						name : '实际发电量' ,
						type : 'bar',
						barGap:'-100%',
						data :y2
					}]
		})
	}
	function initOption(x,y1,y2){
	 	var option = {
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
						 	var res = params[0].name;
						 	var value0 = (params[0].value == undefined)?'-':params[0].value;
						 	var value1 = (params[1].value == undefined)?'-':params[1].value;
						 	res += '<br/>' + params[0].seriesName + ' : ' +value0 +'kWh';
				            res += '<br/>' + params[1].seriesName + ' : ' +value1+'kWh';
				            return res; 
				      }
			    }, 
				grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '30px',
					y : "30px",
					y2 : "80px"
				}, 
				xAxis : [ {
					font : {
						color : '#fff'
					},
					type : 'category',
					axisTick : {
							show : false
						},
					axisLabel : {
						textStyle : {
							align : 'center',
							color : 'rgba(187,187,187,0.9)',
							fontSize : 13
						}
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					splitLine : {
						show : false,
					},
					boundaryGap : true, 
					data : x
				}],
				yAxis : [{
					name: "kWh",
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
					}, 
					type : 'value'
				}],
				series : [
						  {
							name : '理论发电量' ,
							type : 'bar',
							barWidth :20,
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(140,41,103)'
									}
								}
							}, 
							data :y1
						},{
							name : '实际发电量' ,
							type : 'bar',
							barWidth :20,
							itemStyle : {
								normal : {
									color : function(params) {
										return 'rgb(245,102,105)'
									}
								}
							},
							barGap:'-100%',
							data :y2
						}]
		}
		myChart.setOption(option);
	}
});

</script>
