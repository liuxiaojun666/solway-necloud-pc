<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.title{
		font-size: 30px;
		color: #1cb09a;
		text-align: center;
	}
	.title .date{
		margin-left: 30px;
	}

	.workTickedTable{
		border: 1px solid #a4dfd7;
		width: 100%;
	}
	.workTickedTable th,.workTickedTable td{
		text-align: center;
		padding: 15px 30px;
		word-break: keep-all;
    	white-space: nowrap;
	}
	.workTickedTable th{
		border-right: 1px solid #6bd2c2;
	}.workTickedTable td{
		border-right: 1px solid #a4dfd7;
	}
	.workTickedTable thead{
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
	}
	.bgCyan{
		background-color: #e9f8f7;
	}
	.bgWhite{
		background-color: #fff;
	}
</style>
<div ng-controller="reportPowerStationCtrl" class="" style="padding: 15px;">
	<!-- <h1 class="title">各电站日报 <span ng-bind="date"></span></h1> -->
	
	<div style="overflow-x: auto;">
		<div style="display: table;min-width: 100%;">

			<div ng-if="true" style="display: table-cell;">
				<table class="workTickedTable" style="table-layout: fixed;">
					<thead>
						<tr>
							<th style="width: 80px;"></th>
							<th style="width: 250px;">参数项目</th>
							<th ng-repeat="item in data.lItem" ng-if="$index != 0">{{item.stationName}}</th>
							<th>合计</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="outerItem in parameter_items" class="{{$index % 2 === 0 ? 'bgWhite' : 'bgCyan'}}" ng-init="key = keys(outerItem)">
							<th ng-if="$index === 0" rowspan="{{parameter_items.length}}" style="background: rgb(237,200,129);font-size: 20px;">光<br/>伏</th>
							<td>{{outerItem[key]}}</td>
							<td ng-repeat="item in data.lItem" ng-if="$index != 0">{{item[key]}}</td>
							<td>{{data.lItem[0][key]}}</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div ng-if="data.wItem.length" style="display: table-cell;">
				<table class="workTickedTable">
					<thead>
						<tr>
							<th></th>
							<th>参数项目</th>
							<th ng-repeat="item in data.wItem" ng-if="$index != 0">{{item.stationName}}</th>
							<th>合计</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="outerItem in parameter_items" class="{{$index % 2 === 0 ? 'bgWhite' : 'bgCyan'}}" ng-init="key = keys(outerItem)">
							<th ng-if="$index === 0" rowspan="{{parameter_items.length}}" style="background: rgb(237,200,129);font-size: 20px;">风<br/>电</th>
							<td>{{outerItem[key]}}</td>
							<td ng-repeat="item in data.wItem" ng-if="$index != 0">{{item[key]}}</td>
							<td>{{data.wItem[0][key]}}</td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>

</div>

<script>
	app.controller('reportPowerStationCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

		$scope.keys = function (obj) {
			return Object.keys(obj)[0]
		}

		var rightDay = new Date();
			rightDay.setDate(rightDay.getDate() - 1);
			$scope.date = rightDay.Format('yyyy-MM-dd')

		$scope.$on('broadChangeDate',function (e, data) {
			data && ($scope.date = data.dtime.Format('yyyy-MM-dd'))
			getData()
		});

		$scope.$watch('$viewContentLoading',function(event){
			$scope.$emit("getDate")
		})


		$scope.parameter_items = [
			{dTW: '日发电量(kWh)'},
			{dNetTW: '日上网电量(kWh)'},
			{dRadiation: '日总辐射量(MJ/㎡)'},
			{dThoryTW: '日理论电量(KWh)'},
			{dAvgC: '日平均温度(℃)'},
			{dhours: '日发电时间(h)'},
			{dNetBuyTW: '日购网电量(kWh)'},
			{dNetSideBuyTW: '日网侧侧购网电量(kWh)'},
			{dNetSideBuyTWBack: '日备用电侧购网电量(kWh)'},
			{dFUseTW: '日场用电量(kWh)'},
			{dFUseTWRatio: '日场用电率(%)'},
			{dComFUseTW: '日综合场用电量(kWh)'},
			{dComFUseTWRatio: '日综合场用电率(%)'},
			{limitsTW: '日电网调峰影响电量(kWh)'},
			{limitsTWRatio: '日限电比(%)'},
			{dFaultEffectTW: '日故障影响电量(kWh)'},
			{dMaintainEffectTW: '日维护影响电量(kWh)'},
			{dInvolvedEffectTW: '日受累影响电量(kWh)'},
			{dPerformanceDeclineEffectTW: '日机组性能下降影响电量(kWh)'},
			{dModuleAvgUtilezeRatio: '日设备可利用率(%)'},
			{dStationUtilizeRatio: '日电站可利用率(%)'},
			{mPlanTW: '月计划电量(kWh)'},
			{mTW: '月发电量(kWh)'},
			{mPlanCompleteRatio: '月度计划完成率(%)'},
			{yPlanTW: '年计划电量(kWh)'},
			{yTW: '年发电量(kWh)'},
			{yPlanCompleteRatio: '年度计划完成率(%)'}
		]



		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpds/selectCompanyCurrData.htm",
				params: {
					dateStr: $scope.date,
					type: 1
				}
			}).success(function(res) {
				$scope.data = res.data;
			});
		}

	})
</script>