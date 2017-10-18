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
					<th colspan="7">当日工作完成情况</th>
				</tr>
				<tr style="background: #9fe8dd;border-top: 1px solid #1cb09a">
					<th>序号</th>
					<th>电站</th>
					<th>计划工作日期</th>
					<th>计划工作内容</th>
					<th>填报人</th>
					<th>是否完成</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in todayFinishedWorkList"  class="{{$index % 2 === 0 ? 'bgCyan' : 'bgWhite'}}">
					<td>{{$index + 1}}</td>
					<td>{{item.name}}</td>
					<td>{{item.time}}</td>
					<td>{{item.desc}}</td>
					<td>{{item.username}}</td>
					<td>{{item.ifFinished}}</td>
					<td>{{item.remark}}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="container" style="margin: 100px 0;" ng-controller="reportWorkBrieCtrl">
		<!-- <h1 class="title">工作简报 <span>{{date}}</span></h1> -->
		<table class="workBriefingTable">
			<thead>
				<tr>
					<th colspan="7">次日工作计划</th>
				</tr>
				<tr style="background: #9fe8dd;border-top: 1px solid #1cb09a">
					<th>序号</th>
					<th>电站</th>
					<th>计划工作日期</th>
					<th>计划工作内容</th>
					<th>填报人</th>
					<th>是否完成</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in tomorrowFinishedWorkList"  class="{{$index % 2 === 0 ? 'bgCyan' : 'bgWhite'}}">
					<td>{{$index + 1}}</td>
					<td>{{item.name}}</td>
					<td>{{item.time}}</td>
					<td>{{item.desc}}</td>
					<td>{{item.username}}</td>
					<td>{{item.ifFinished}}</td>
					<td>{{item.remark}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>


<script>
	app.controller('reportWorkBrieCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

		var rightDay = new Date();
			rightDay.setDate(rightDay.getDate() - 1);
			$scope.date = rightDay.Format('yyyy-MM-dd')

		$scope.isFirst = true
			
		$scope.$on('broadChangeDate',function (e, data) {
			data && ($scope.date = data.dtime.Format('yyyy-MM-dd'))
			getTodayFinishedWorkData(0)
			getTodayFinishedWorkData(1)
			// $scope.$apply()
		});
		$scope.$watch('$viewContentLoading',function(event){
			$scope.$emit("getDate")
		})


		/**
		 * [getTodayFinishedWorkData 获取完成工作情况接口]
		 * @param  {[type]} type 0 今日  1 次日
		 * @return {[type]}      [description]
		 */
		function getTodayFinishedWorkData(type){
			$http({
				method : "GET",
				url : "${ctx}/rpdBriefing/selectCurrData.htm",
				params: {
					dateStr: $scope.date,
					type: type,
				}
			}).success(function(res) {
				var result = res.data.map(function (v, i) {
					return {
						id: v.id,
						name: v.stationName,
						time: new Date(v.busiDate).Format('yyyy-MM-dd'),
						desc: v.completeContent,
						username: v.createUserName,
						ifFinished: ['是', '否'][v.completeStatus],
						remark: v.remark
					}
				})
				if (type === 0) {
					$scope.todayFinishedWorkList = result
				} else if (type === 1) {
					$scope.tomorrowFinishedWorkList = result
				}
			});
		}

	})
</script>