<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder" ng-controller="WpstaMonCtrl">
	<div class="h3 text-center">
		<span ng-bind="todayTimeForTitle"></span>发电量分析
	</div>
	<div class="col-sm-12 no-padder mt20" >
		<div class="col-sm-12">
			<div class="pull-right">
				<span>
					<i class="fa fa-circle" style="color: #ffc700"></i>
					<span class="m-r-xs">应发电量<small>(kWh)</small></span>
				</span>
				<span class="ml10">
					<i class="fa fa-circle" style="color: #ff9a00"></i>
					<span class="">实发电量(kWh)</span>
				</span>
			</div>
		</div>
		<div class="col-sm-12 no-padder clearfix">
			<div class="text-center" id="loadFlags"></div>
			<div id="kwhTotalMReport" style="height:300px;width: 100%;"></div>
		</div>
	</div>
</div>
<script>
	var myChart;
	app.controller('WpstaMonCtrl',function($scope, $http, $state,$rootScope) {
		//得到当前月时间
		$scope.analData=new Date($scope.mapTimeDay).Format("yyyy-MM");

		//标题的时间
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月");
		//向后台发送时间请求
		$scope.todayTimeForJson=new Date($scope.mapTimeDay).Format("yyyy-MM");
		//切换时间
		$scope.changeData=function(nowData,obj){
			myChart.clear();
			$.showLoading(loadFlags);
			$("#"+obj+"span").parent().siblings().children().removeClass("active animated fadeInLeft");
			$("#"+obj+"span").addClass("active");
			$scope.getstaDayPowerData(nowData + "-01");
		};

		$scope.getstaDayPowerData=function(nowData){
			$http({
				method : "POST",
				url : "${ctx}/WpHmDeviceStation/getWpChartGeneratingPowerMonth.htm",
				params : {
					'userId':1,
					'dateString':nowData
				}
			}).success(function (msg) {
				if(msg.echarts_xaxisTime==null){
					powerAnalyze([],[],[])
					$.hideLoading(loadFlags)
				}else{
					$("#kwhTotalMReport").width(860);
					powerAnalyze((msg.echarts_xaxisTime),
							(msg.echarts_realGeneratingPower),
							(msg.echarts_predictGeneratingPower),$http, $scope)
				}
			}).error(function(msg){
			});

		};
		$scope.getstaDayPowerData($scope.analData);
	});

	function powerAnalyze(echarts_xaxisTime,echarts_realGeneratingPower,echarts_predictGeneratingPower,$http, $scope){
		require(
				[ 'echarts', 'echarts/chart/line', 'echarts/chart/bar'],
				function(ec) {
					var  myChart = ec.init(document.getElementById('kwhTotalMReport'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
						tooltip : {
							trigger: 'axis',
							formatter: function (params,ticket,callback) {
								var res ="";
								for (var i = 0, l = params.length; i < l; i++) {
									res += params[i].seriesName+" : "+params[i].value +"<br/>" ;
								}
								return res;
							},
							axisPointer:{
								type: 'line',
								lineStyle: {
									color: '#bbb',
									width: 1,
									type: 'solid'
								}
							}
						},
						grid : {
							borderWidth : 1,
							x : 50,
							x2 : 10,
							y : 30,
							y2 : 40,
							borderColor:'rgba(144, 168, 252,0.1)'
						},
						noDataLoadingOption:{
							text : '暂无数据',
							effect :function(params,callback){
								return "暂无数据"
							}
						},
						calculable : false,
						yAxis : [{
							axisLabel : {
								textStyle : {
									color : 'rgba(187, 187, 187, 1)',
									fontSize : 12
								}
							},
							font : {
								color : '#666'
							},
							// position : 'top',//X 轴显示的方位
							axisLine : {
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							splitLine : {
								show : true,
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							type : 'value'
						}],
						xAxis : [ {
							font : {
								color : '#fff'
							},
							// position : 'left',//X 轴显示的方位
							type : 'category',
							axisTick : {
								show : false
							},
							axisLabel : {
								formatter:function (value){
									return value;
								},
								textStyle : {
									align : 'center',
									color : 'rgba(187, 187, 187, 1)',
									fontSize : 13
								}
							},
							axisLine : {
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)'
								}
							},
							splitLine : {
								show : true,
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							data : echarts_xaxisTime
						}
						,{
							show:false,
							font : {
								color : '#fff'
							},
							// position : 'left',//X 轴显示的方位
							type : 'category',
							axisTick : {
								show : false
							},
							axisLabel : {

								textStyle : {
									align : 'center',
									color : 'rgba(144, 168, 252,0.4)',
									fontSize : 13
								}
							},
							axisLine : {
								lineStyle : {
									color : 'transparent'
								}
							},
							splitLine : {

								show : true,
								lineStyle : {
									color : 'rgba(144, 168, 252,0.1)',
									width : 1
								}
							},
							data : echarts_xaxisTime
							}
						],
						series : [
							{
								name : '实发电量' ,
								type : 'bar',
								barWidth : 20,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ff9a00'
										}
									}
								},
								data : echarts_realGeneratingPower
							},{
								name : '应发电量',
								z:1,
								type : 'bar',
								z:1,
								xAxisIndex : 1,
								barWidth : 20,
								itemStyle : {
									normal : {
										color : function(params) {
											return '#ffc700'
										}
									}
								},
								data : echarts_predictGeneratingPower
							}]
					};
					myChart.setOption(option);
				}
		);
	}
</script>
