<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.pWD_onediv h3{
		display: inline-block;
	}
	.pWD_onediv h4{
		display: inline-block;
		color:#1cb09a;
	}
	.productStatuBox{
		position: relative;
		width: 100%;
	}
	.productStatuBox table th{
		padding: 10px 0;		
		border: 1px solid #1cb09a;
	}
	.productStatuBox table td{
		border-right: 1px solid #afe8dd;
		padding: 10px 0;
	}
	.productStatuBox table{
		width: 100%;
		border-collapse: collapse;
	}
	.productStatuBox table tbody{
		border-bottom: 1px solid #afe8dd;
		border-left: 1px solid #afe8dd;
	}
</style>
<div class="productWeekData" ng-controller="reportWeekProductDataCtrl"> 
	<!--<div class="pWD_onediv">
		<h3>一周生产指标情况</h3>
		<h4>(截止06月22日24时生产指标情况)</h4>
	</div>-->
	<div class="productStatuBox container" >
		<table class="row">

			<thead>	
				<tr><th colspan="11" style="text-align: right;padding-right: 20px">单位：千万瓦时</th></tr>
				<tr style="background-color: #9fe8dd;">
					<th>指标</th>	
					<th  ng-repeat="item in res">{{item.stationName}}</th>	
					<!-- <th>合计</th> -->
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in parameters" ng-class-odd="{ oddStyle : true }" ng-class-even="{ evenStyle : true }" ng-cloak  ng-init="key = keys(item)">
					<td >{{item[key] }}</td>
					<td  ng-repeat="inItem in res">{{ inItem[key]}}</td>
					<!-- <td>{{ res.total[key] }}</td> -->
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
app.controller('reportWeekProductDataCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
	$scope.$on("yearWeek",function(e,value){
		$scope.nowTimeYear = value.year;
		$scope.currentWeek = value.week;
		$scope.getProductData();
	});
	$scope.getProductData = function(){
		$http({
	 		method : "POST",
	 		url : "${ctx}/rpws/getProductData.htm",
	 		params: {
	 			year:$scope.nowTimeYear,
	 			week:$scope.currentWeek
	 		}
		 }).success(function(res) {
			 $scope.res = res.data;
			
		 })
	};
	
	$scope.getProductData();
	
	$scope.keys = function (obj) {
		return Object.keys(obj)[0]
	}
	$scope.parameters = [
         			{yPlanTW: '年计划发电量'},
         			{yTW: '年度完成发电量'},
         			{yPlanCompleteRatio: '年度计划百分比（%）'},
         			{mPlanTW: '月计划发电量'},
         			{mTW: '月度完成发电量'},
         			{mCompleteSameRatio: '月度完成发电量同期比'},
         			{mCompleteRatio: '月度发电量百分比（％）'},
         			{wTW: '周完成电量'},
         			{wCompleteSameRatio: '周完成电量同期比'},
         			{wLimitsTW: '上周电网调峰影响电量'},
         			{wLimitsTWSameRatio: '周调峰影响电量同期比'},
         			{wLimitsTWRatio: '周限电比（％）'},
         			{wLimitsTWRatioSameRatio: '周限电比同期比（％）'},
         			{mLimitsTW: '月电网调峰影响电量'},
         			{mLimitsTWSameRatio: '月调峰影响电量同期比'},
         			{mLimitsTWRatio: '月限电比（％）'},
         			{mLimitsTWRatioSameRatio: '月限电比同期比（％）'},
         			{wDeviceFaultEffectTW: '上周设备缺陷影响电量'},
         			{wDeviceFaultEffectTWSameRatio: '设备缺陷影响电量同期比'},
         			{wModuleAvgUtilezeRatio: '上周设备利用率（％）'},
         			{wModuleAvgUtilezeRatioSameRatio: '设备利用率同期比（％）'},
         			{mDeviceUtilizeRatio: '月风机设备利用率（％）'},
         			{mDeviceUtilizeSameRatio: '月风机设备利用率同期比（％）'},
         			{wComFUseTW: '上周综合场用电量'},
         			{wComFUseTWRatio: '上周综合场用电率（％）'},
         			{wWindSpeedAvg: '上周平均风速（m/s）'},
         			{wWindSpeedAvgSameRatio: '周平均风速同期比（m/s）'},
         			{mWindSpeedAvg: '月平均风速（m/s）'},
         			{mWindSpeedAvgSameRatio: '月平均风速同期比（m/s）'},
         			{mEmittanceAvg: '月平均辐射强度（MJ/㎡）'},
         			{mEmittanceAvgSameRatio: '月平均辐射强度同期比（MJ/㎡）'}
         		];
})	
</script>
