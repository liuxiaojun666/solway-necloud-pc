<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.workBriefingTable{
		width: 100%;
		border-left: 1px solid #a4dfd7;
		border-bottom: 1px solid #a4dfd7;
	}
	.workBriefingTable thead{
		text-align: center;
		border: 1px solid #1cb09a;
	}
	.workBriefingTable th{
		padding: 15px;
		border-right: 1px solid #6bd2c2;
	}
	.workBriefingTable td{
		border-right: 1px solid #a4dfd7;
		padding: 15px;
	}
	.bgCyan{
		background-color: #e9f8f7;
	}
	.bgWhite{
		background-color: #fff;
	}
</style>
<div>
	<div class="container" style="margin-top: 50px;" ng-controller="reportWorkBrieCtrl">
		<!-- <h1 class="title">工作简报 <span>{{date}}</span></h1> -->
		<table class="workBriefingTable">
			<thead>
				<tr>
					<th colspan="4"><h3 style="font-size: 24px;color: #1cb09a;margin:0;">月工作总结和下月工作计划</h3></th>
				</tr>
				<tr style="background: #9fe8dd;border-top: 1px solid #1cb09a">
					<th>电站</th>
					<th>月完成情况工作</th>
					<th>下月工作计划</th>
					<th>填报人</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in data"  class="{{$index % 2 === 0 ? 'bgCyan' : 'bgWhite'}}">
					<td>{{item.stationName}}</td>
					<td>{{item.content1}}</td>
					<td>{{item.content2}}</td>
					<td>{{item.createUserName}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>


<script>
	app.controller('reportWorkBrieCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

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


		/**
		 * 发请求，取数据
		 * @return {[type]} [description]
		 */
		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpmSummary/selectCurrData.htm",
				params: {
					dateStr: $scope.date,
				}
			}).success(function(res) {
				$scope.data = res.data
			});
		}

	})
</script>