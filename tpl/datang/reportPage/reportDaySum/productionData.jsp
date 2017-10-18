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

	.productTable{
		border: 1px solid #a4dfd7;
	}
	.productTable th,.productTable td{
		text-align: center;
		padding: 15px;
	}
	.productTable th{
		border-right: 1px solid #6bd2c2;
	}.productTable td{
		border-right: 1px solid #a4dfd7;
	}
	.productTable thead{
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
	}
	.bgCyan{
		background-color: #e9f8f7;
	}
	.bgWhite{
		background-color: #fff;
	}

	.productTable thead tr, .productTable tbody tr {
	    display:table;
	    width:100%;
	    table-layout:fixed;
	}
</style>
<div ng-controller="reportDayProductDataCtrl" class="container">
	

	<table class="productTable" style="table-layout: fixed;min-width: 100%;">
		<!-- <caption><h1 class="title">生产数据 <span>{{date}}</span></h1></caption> -->
		<thead style="display: block;">
			<tr>
				<th style="width: 250px">参数项目</th>
				<th style="max-width: 110px">合计</th>
				<th style="max-width: 110px" ng-repeat="item in data" ng-if="$index">{{item.stationName}}</th>
			</tr>
		</thead>
		<tbody style="display: block;max-height: 400px;overflow: overlay;">
			<tr ng-repeat="outerItem in parameters" class="{{$index % 2 == 0 ? 'bgCyan' : bgWhite}}" ng-init="key = keys(outerItem)">
				<td style="width: 250px">{{ outerItem[key] }}</td>
				<td style="max-width: 110px">{{ data[0][key] }}</td>
				<td style="max-width: 110px" ng-repeat="item in data" ng-if="$index">{{item[ key ]}}</td>
			</tr>
		</tbody>
	</table>

</div>
<script>
	app.controller('reportDayProductDataCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

		$scope.keys = function (obj) {
			return Object.keys(obj)[0]
		}

		var rightDay = new Date();
			rightDay.setDate(rightDay.getDate() - 1);
			$scope.date = rightDay.Format('yyyy-MM-dd')
			
		$scope.$on('broadChangeDate',function (e, data) {
			data && ($scope.date = data.dtime.Format('yyyy-MM-dd'))
			getData()
			// $scope.$apply()
		});
		$scope.$watch('$viewContentLoading',function(event){
			$scope.$emit("getDate")
		})

		$scope.parameters = [
			{deqCount: '运行台数'},
			{dTW: '日发电量（万kWh）'},
			{mTW: '月发电量（万kWh）'},
			{yTW:'年发电量（万kWh）'},
			{limitsTW:'日调峰电量（万kWh）'},
			{limitsTWRatio:'日调峰比（%）'},
			{mLimitsTW:'月调峰电量（万kWh）'},
			{mLimitsTWRatio:'月调峰比（%）'},
			{yLimitsTW:'年调峰电量（万kWh）'},
			{yLimitsTWRatio:'年调峰比（%）'},
			{mPlanTW:'月计划电量（万kWh）'},
			{mTWDiff:'月差（万kWh）'},
			{mPlanCompleteRatio:'完成月计划比（%）'},
			{yPlanTW:'年计划电量（万kWh）'},
			{yTWDiff:'年差（万kWh）'},
			{dAvgCompleteRatio:'平均日应完成电量（万kWh）'}
		]


		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpds/selectCompanyCurrData.htm",
				params: {
					type: 0,
					dateStr: $scope.date
				}
			}).success(function(res) {
				$scope.data = res.data
			});
		}

	})
</script>