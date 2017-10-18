<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<link rel="stylesheet" href="${ctx}/theme/css/dataAnalysisPage/dataAnalysis.css">
<div class="dataAnalysis-con" ng-controller="assetDataModelCtrl">
	<div class="score">
		<div class="score-circle">{{comprehensive.togetherScore|dataNullFilter|limitTo:4}}</div>
		<p class="score-title">综合得分</p>
		<p class="score-params">{{comprehensive.descStr|dataNullFilter}}</p>
	</div>
	<div class="evaluate-detail">
		<div class="graph">
			<div ng-include="'${ctx}/tpl/dataAnalysisPage/dataAnalysis/assess.jsp'"></div>
		</div>
		<div class="detail-center">
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{hours.value|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">发电小时数</p>
					<p class="p-detail">{{hours.describeStr|dataNullFilter}}<BR/></p>
				</div>
			</div>
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{MTTR.value|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">MTTR</p>
					<p class="p-detail">{{MTTR.describeStr|dataNullFilter}}</p>
				</div>
			</div>
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{PR.value|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">PR</p>
					<p class="p-detail">{{PR.describeStr|dataNullFilter}}</p>
				</div>
			</div>
		</div>
		<div class="detail-right">
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{lightResource.value|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">光资源</p>
					<p class="p-detail">{{lightResource.describeStr|dataNullFilter}}</p>
				</div>
			</div>
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{MTBR.value|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">MTBF</p>
					<p class="p-detail">{{MTBR.describeStr|dataNullFilter}}</p>
				</div>
			</div>
		</div>
	</div>
	<div class="table-data">
		<table  class="table  table-striped b-t b-light bg-table">
			<thead>
				<th class="text-center"></th>
				<th class="text-center">光资源</th>
				<th class="text-center">发电小时数</th>
				<th class="text-center">PR</th>
				<th class="text-center">MTBF</th>
				<th class="text-center">MTTR</th>
			</thead>
			<tbody >
				<tr>
					<td class="text-center">
						 <span>自身</span>
					</td>
					<td class="text-center">
						 <span>{{table[0].personnelEfficiency|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[0].generatingPowerHours|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[0].pr|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[0].mtbf|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[0].mttr|dataNullFilter}}</span>
					</td>
				</tr>
				<tr>
					<td class="text-center">
						 <span>城市平均</span>
					</td>
					<td class="text-center">
						 <span>{{table[1].personnelEfficiency|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[1].generatingPowerHours|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[1].pr|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[1].mtbf|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[1].mttr|dataNullFilter}}</span>
					</td>
				</tr>
				<tr>
					<td class="text-center">
						 <span>方圆50</span>
					</td>
					<td class="text-center">
						 <span>{{table[2].personnelEfficiency|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[2].generatingPowerHours|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[2].pr|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[2].mtbf|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{table[2].mttr|dataNullFilter}}</span>
					</td>
				</tr>
			</tbody>
	</table>
	</div>
</div>

<script>
app.controller('assetDataModelCtrl',function($scope, $http, $state, $stateParams) {
	//获取电站id($scope.stid)
	$scope.getStationId = function () {
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
		})
		.success(function (msg) {
			$scope.stid = msg.currentSTID;
			init();
		}).error(function(msg){
			return
		});
	}
	
	function init(){
		data();
		comprehensiveData();
	}

	//初始化数据(日)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	$scope.$on('broadChangeDate', function(event, data) {
		$scope.basicData = data;
		if($scope.basicData){
			$scope.dataType = $scope.basicData.dataType;
			$scope.dtime = $scope.basicData.dtime;
		}
		$scope.getStationId();
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getStationId();
    });
	
	//页面数据
	function data(){
		switch($scope.dataType){
			case "day" : $scope.dayData();
				break;
			case "month" : $scope.monthData();
				break;
			case "year" : $scope.yearData();
				break;
			case "total" : $scope.totalData();
				break;
		}
	};
	//页面综合数据
	function comprehensiveData(){
		switch($scope.dataType){
			case "day" : $scope.dayComprehensiveData()
				break;
			case "month" : $scope.monthComprehensiveData();
				break;
			case "year" : $scope.yearComprehensiveData();
				break;
			case "total" : $scope.totalComprehensiveData();
				break;
		}
	};
	
	
	
	//综合数据（日）
	$scope.dayComprehensiveData = function(){
		$http({
			method : "POST",
			url : "./BDEstimate/getStationsSumDayEstimateDay.htm",
			params : {
				'dateString':new Date($scope.dtime).Format("yyyy-MM-dd")
			}
		})
		.success(function (msg) {
			renderComprehensive(msg);
		}).error(function(msg){
		}); 
	}
	
	//综合数据（月）
	$scope.monthComprehensiveData = function(){
		$http({
			method : "POST",
			url : "./BDEstimate/getStationsSumMonthEstimateMonth.htm",
			params : {
				'dateString':new Date($scope.dtime).Format("yyyy-MM")
			}
		})
		.success(function (msg) {
			renderComprehensive(msg);
		}).error(function(msg){
		}); 
	}
	//综合数据（年）
	$scope.yearComprehensiveData = function(){
		$http({
			method : "POST",
			url : "./BDEstimate/getStationsSumYearEstimateYear.htm",
			params : {
				'dateString':new Date($scope.dtime).Format("yyyy")
			}
		})
		.success(function (msg) {
			renderComprehensive(msg);
		}).error(function(msg){
		}); 
	}
	//综合数据（累计）
	$scope.totalComprehensiveData = function(){
		$http({
			method : "POST",
			url : "./BDEstimate/getStationsSumAllEstimateAll.htm"
		})
		.success(function (msg) {
			renderComprehensive(msg);
		}).error(function(msg){
		}); 
	}
	//数据（日）
	$scope.dayData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getChartComprehensiveEvaluation.htm",
			params : {
				'dateString':new Date($scope.dtime).Format("yyyy-MM-dd"),
				'dateType':"D",
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			renderParamsDetail(msg.myComprehensiveEvaluationList);
			renderTable(msg.radarCompared);
			broadcastRadar(msg.radarCompared);
			
		}).error(function(msg){
		}); 
	}
	
	//数据（月）
	$scope.monthData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getChartComprehensiveEvaluation.htm",
			params : {
				'dateString':new Date($scope.dtime).Format("yyyy-MM"),
				'dateType':"M",
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			renderParamsDetail(msg.myComprehensiveEvaluationList);
			renderTable(msg.radarCompared);
			broadcastRadar(msg.radarCompared);
		}).error(function(msg){
		}); 
	}
	//数据（年）
	$scope.yearData = function(){
		$http({
			method : "POST",
			url : "./MobileHmDeviceMonitor/getChartComprehensiveEvaluation.htm",
			params : {
				'dateString':new Date($scope.dtime).Format("yyyy"),
				'dateType':"Y",
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			renderParamsDetail(msg.myComprehensiveEvaluationList);
			renderTable(msg.radarCompared);
			broadcastRadar(msg.radarCompared);
			
		}).error(function(msg){
		}); 
	}
	//数据（累计）
	$scope.totalData = function(){
		$http({
			method : "POST",
			url : "./ MobileHmDeviceMonitor/getChartComprehensiveEvaluation.htm",
			params : {
				'dateType':"A",
				'powerStationId':$scope.stid
			}
		})
		.success(function (msg) {
			renderParamsDetail(msg.myComprehensiveEvaluationList);
			renderTable(msg.radarCompared);
			broadcastRadar(msg.radarCompared);
			
		}).error(function(msg){
		}); 
	}
	//发电小时数至MTBR的数据填充
	function renderParamsDetail(data){
		$scope.hours = data[1];
		$scope.lightResource = data[2];
		$scope.MTTR = data[3];
		$scope.MTBR = data[4];
		$scope.PR = data[5];
	}
	//综合的数据填充
	function renderComprehensive(data){
		console.log(1)
		console.log(data)
		console.log(2)
		$scope.comprehensive = data;
	}
	//table的数据填充
	function renderTable(data){
		$scope.table = data;
	};
	//给雷达图子页面传值
	function broadcastRadar(data){
		 $scope.$broadcast('broadRadar',data);
	}
	//初始化
	$scope.getStationId();
});

</script>
