<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.myserf, .city, .gongli {background-color: #f6f8f8;}
</style>
<div class="col-sm-12 no-padder panel wrapper"  ng-controller="staScoreCtrl" >
	<div class=""  id="distUserNav">
		<ul class="nav col-sm-12 no-padder nav-top"  >
			<li class="col-sm-10 no-padder">
				<a class="text-md">综合评估</a>
			</li>
		</ul>
	</div>
	<div class="col-sm-12 no-padder">
		<div class="col-sm-12 no-padder rollDiv">
			<div class="col-sm-12 no-padder bg-writer b-b-5">
				<div class="col-sm-12 text-center m-t-xs"id="loadFlags"></div>
				<div id="kwhTotalDReport" style="height:250px;"></div>
			</div>
			<ul class="nav col-sm-12 no-padder text-1-3x bg-writer b-b-5 nav-score" >
				<li class="text-center col-sm-4 no-padder b-r-5 myserf" id="tab1" ng-click="changeDataScore('1')" >
					<a class="span wrapper-t-15"><i class="fa fa-circle-o m-r-xs"></i>自身</span></a>
				 </li>
				<li class="text-center col-sm-4 no-padder b-r-5" id="tab2" ng-click="changeDataScore('2')">
					<a class="span wrapper-t-15"><i class="fa fa-circle-o m-r-xs"></i>城市平均</span></a>
				 </li>
				<li class="text-center col-sm-4 no-padder b-r-5" id="tab3" ng-click="changeDataScore('3')">
					<a class="span wrapper-t-15"><i class="fa fa-circle-o m-r-xs"></i>方圆50公里</span></a>
				 </li>
			</ul>

			<div class="b-b-5 col-sm-12 wrapper" ng-repeat="com in listData">
				<div class="col-sm-3 text-center">
					<div class="scopeCir"><span ng-bind="com.value">-</span></div>
					<span class="col-d" ng-if="$index==0">综合</span>
					<span class="col-d" ng-if="$index==1">发电小时数</span>
					<span class="col-d" ng-if="$index==2">人员效率</span>
					<span class="col-d" ng-if="$index==3">MTTR</span>
					<span class="col-d" ng-if="$index==4">MTBF</span>
					<span class="col-d" ng-if="$index==5">PR</span>
				</div>
				<div class="col-sm-9">
					<p class="text-1-4x m-t-sm m-b-xs" ng-bind="com.describeStr"></p>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	var myChart;

	app.controller('staScoreCtrl',function($scope, $http, $state,$rootScope) {
		$scope.$on("dateChangeCtrl", function (event, msg) {
			$scope.getAllData($scope.mapTimeDay);
		});
		$scope.stationListId = $scope.powerStationId
		//得到当前月时间
		//$scope.analData=$scope.getDayData($scope.mapTimeDay)
		//标题的时间
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日")

		console.log($scope.analData)
		console.log($scope.todayTimeForTitle)
		//向后台发送时间请求
		$scope.todayTimeForJson=new Date($scope.mapTimeDay).Format("yyyy/MM/dd/")

		$scope.changeDataScore=function(flag){
					//myChart.clear()
					//$.showLoading(loadFlags)
					if(flag=='1'){
						$("#tab1").addClass("myserf")
						$("#tab2").removeClass("city")
						$("#tab3").removeClass("gongli")
						powerAnalyze($scope.radarData[0],[],[])
					}else if(flag=='2'){
						$("#tab1").removeClass("myserf")
						$("#tab2").addClass("city")
						$("#tab3").removeClass("gongli")
						powerAnalyze([],$scope.radarData[1],[])
					}
					else if(flag=='3'){
						$("#tab1").removeClass("myserf")
						$("#tab2").removeClass("city")
						$("#tab3").addClass("gongli")
						powerAnalyze([],[],$scope.radarData[2])
					}
			}
			$scope.getAllData=function(nowData){
				//标题的时间
				$scope.todayTimeForTitle=new Date(nowData).Format("yyyy年MM月dd日")
				//向后台发送时间请求
				$scope.todayTimeForJson=new Date(nowData).Format("yyyy/MM/dd")
				$http({
					method : "POST",
					url : "${ctx}/MobileRtmDeviceMonitor/getChartComprehensiveEvaluation.htm",
					params : {
						'dateString':$scope.todayTimeForJson,
						'dateType':'D',
						'powerStationId':$scope.stationListId
					}
					})
					.success(function (msg) {
						$scope.listData=msg.myComprehensiveEvaluationList;
						$scope.radarCom=msg.radarCompared;

						$scope.radarData = new Array();
						for(var i=0;i<3;i++){
							$scope.radarData[i]=[$scope.radarCom[i].generatingPowerHours,
										   $scope.radarCom[i].pr,
										   $scope.radarCom[i].mtbf,
										   $scope.radarCom[i].mttr,
										   $scope.radarCom[i].personnelEfficiency];
							   }

						$scope.changeDataScore(1)
					}).error(function(msg){

					});
			}
			$scope.getAllData($scope.mapTimeDay)
			//切换时间
			$scope.changeData=function(nowData,obj){
				$("#"+obj+"span").parent().siblings().children().removeClass("active ")
				$("#"+obj+"span").addClass("active ");
				$scope.getAllData(nowData)

			}
	});
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
	function powerAnalyze(tab1,tab2,tab3){
	   //$.hideLoading(loadFlags)
	   require(
			[ 'echarts', 'echarts/chart/radar' ], function(ec) {
				   myChart = ec.init(document.getElementById('kwhTotalDReport'));
				   window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
							color:['#56c6c7','#b4a3de','#e47488'],//自身，城市平均，方圆50公里
							tooltip : {
								trigger: 'axis',
							},
							noDataLoadingOption:{
								text : '暂无数据',
								effect :function(params,callback){
									return "暂无数据"
								}
							},
							calculable : false,
							polar : [
								{
									axisLabel:{
										textStyle:{
											color:"#fff"
										}
									},
									indicator : [
										{text : '发电小时数'},
										{text : 'PR'},
										{text : 'MTBF'},
										{text : 'MTTR'},
										{text : '人员效率'}
									],
									radius : 100
								}
							],
							series : [
								{
									type: 'radar',
									data : [
										{
											value :tab1 ,
											name : '自身',
											z : 3,
											itemStyle : {
												normal : {
													color:'#fff',
													areaStyle : {
														color : 'rgba(46, 199, 201,.4)'
													},
													label:{
														textStyle:{
															color:'#fff'
														}
													},
													lineStyle : {
														color : 'rgba(46, 199, 201,.9)',
														width : 1
													},textStyle:{
														color:'#fff'
													}
												},
												emphasis:{
													color:"#fff"
												}
											}
										},
										{
											value :tab2,
											name : '城市平均',
											z : 2,
											itemStyle : {
												normal : {
													color : 'rgba(182, 162, 222,.9)',
													areaStyle : {
														color : 'rgba(182, 162, 222,.4)'
													},
													lineStyle : {
														color : 'rgba(182, 162, 222,.9)',
														width : 1
													}
												}
											}
										},
										{
											value : tab3,
											z : 1,
											name : '方圆50公里',
											itemStyle : {
												normal : {
													color : 'rgb(217, 83, 79)',
													areaStyle : {
														color : 'rgba(217, 83, 79,.4)'
													},
													lineStyle : {
														color : 'rgba(217, 83, 79,.9)',
														width : 1
													}
												}
											},
										}
									]
								}
							]
					};
					myChart.setOption(option);
			}
		)
	}
</script>
