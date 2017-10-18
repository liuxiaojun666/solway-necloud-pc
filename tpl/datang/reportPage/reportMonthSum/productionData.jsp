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
	.productTable thead tr, .productTable tbody tr {
	    display:table;
	    width:100%;
	    table-layout:fixed;
	}
	.bgCyan{
		background-color: #e9f8f7;
	}
	.bgWhite{
		background-color: #fff;
	}
</style>
<div ng-controller="reportDayProductDataCtrl" class="container">
	
	<!-- <h1 class="title">月生产指标情况 <small style="color: inherit;">（截止{{ data[0].busiDate | MyDataFormat }}24时生产指标情况）</small></h1> -->

	<table class="productTable" style="table-layout: fixed;min-width: 100%;">
		<caption class="text-right" style="border: 1px solid #1cb09a;font-size: 18px;color: #333;padding-right: 5px;border-bottom: none;">单位：万千瓦时</caption>
		<thead style="display: block;">
			<tr>
				<th style="width: 250px;">指标</th>
				<th style="min-width: 150px;" ng-repeat="item in data">{{ item.stationName }}</th>
			</tr>
		</thead>
		<tbody style="display: block;height: 400px;overflow: overlay;">
			<tr ng-repeat="outerItem in parameters" class="{{$index % 2 === 0 ? 'bgWhite' : 'bgCyan'}}" ng-init="key = keys(outerItem)">
				<td style="width: 250px;">{{ outerItem[key] }}</td>
				<td style="min-width: 150px;" ng-repeat="item in data">{{ item[key] }}</td>
			</tr>
		</tbody>
	</table>

</div>
<script>

	app.filter("MyDataFormat",function () {
	    return function (src) {
	        var date, dateArr
	        date= new Date(src || new Date)
	        date.setMonth(date.getMonth() + 1)
	        date.setDate(date.getDate() - 1)
	        dateArr = date.Format('yyyy-MM-dd').split('-')
	        return dateArr[0] + '年' + dateArr[1] + '月' + dateArr[2] + '日'
	    }
	})

	app.controller('reportDayProductDataCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

		var rightDay = new Date();
			rightDay.setMonth(rightDay.getMonth() - 1);
			$scope.date = rightDay.Format('yyyy-MM-dd')
			
			
		$scope.$on('broadChangeDate',function (e, data) {
			data && ($scope.date = data.dtime.Format('yyyy-MM-dd'))
			getData()
		});


		$scope.$watch('$viewContentLoading',function(event){
			$scope.$emit("getDate")
		})

	    $scope.keys = function (obj) {
	        return Object.keys(obj)[0]
	    }

		$scope.parameters = [
			{ yPlanTW: '年计划发电量' },
			{ yTW: '年度完成发电量' },
			{ yPlanCompleteRatio: '年度计划百分比（％）' },
			{ mPlanTW: '月计划发电量' },
			{ mTW: '月度完成发电量' },
			{ mCompleteSameRatio: '月度完成发电量同期比' },
			{ mCompleteRatio: '月度发电量百分比（％）' },
			{ mLimitsTW: '月电网调峰影响电量' },
			{ mLimitsTWSameRatio: '月调峰影响电量同期比' },
			{ mLimitsTWRatio: '月限电比（％）' },
			{ mLimitsTWRatioSameRatio: '月限电比同期比（％）' },
			{ mFaultEffectTW: '月故障影响电量' },
			{ mFaultEffectTWSameRatio: '月故障影响电量同期比' },
			{ mFUseTW: '月场用电量' },
			{ mFUseTWSameRatio: '场用电量同期比' },
			{ mComFUseTW: '月综合场用电量' },
			{ mComFUseTWSameRatio: '月综合场用电量同期比' },
			{ mModuleAvgUtilezeRatio: '月光伏组串利用率（％）' },
			{ mModuleAvgUtilezeRatioSameRatio: '月光伏组串利用率同期比（％）' },
			{ mDeviceUtilizeRatio: '月风机设备利用率（％）' },
			{ mDeviceUtilizeSameRatio: '月风机设备利用率同期比（％）' },
			{ mWindSpeedAvg: '月平均风速（m/s）' },
			{ mWindSpeedAvgSameRatio: '月平均风速同期比（m/s）' },
			{ mEmittanceAvg: '月平均辐射强度（MJ/㎡）' },
			{ mEmittanceAvgSameRatio: '月平均辐射强度同期比（MJ/㎡）' },
			{ mPWCurve: '月功率曲线一致性' },
			{ mPWCurveRatio: '月功率曲线一致性与设计值比' },
			{ mWindUseRatio: '月风能利用系数' },
			{ mWindUseSameRatio: '月风能利用系数同期比' },
			{ mUtilizeHours: '月完整利用小时数' }
		]


		function getData(argument) {
			$http({
				method : "GET",
				url : "${ctx}/rpms/getProductData.htm",
				params: {
					dateStr: $scope.date
				}
			}).success(function(res) {
				$scope.data = res.data
			})
		}

	})
</script>