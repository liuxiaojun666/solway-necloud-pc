<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.title{
		font-size: 30px;
		color: #1cb09a;
	}
	.workTickedTable{

	}
	.workTickedTable{
		border: 1px solid #a4dfd7;
	}
	.workTickedTable th,.workTickedTable td{
		padding: 15px;
	}
	.workTickedTable th{
		text-align: center;
		border-right: 1px solid #6bd2c2;
		word-break:keep-all;           /* 不换行 */
		white-space:nowrap;          /* 不换行 */
	}.workTickedTable td{
		border-right: 1px solid #a4dfd7;
	}
	.workTickedTable thead{
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
	}
	.workTickedTable thead tr, .workTickedTable tbody tr {
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
<div class="container" ng-controller="reportOperationTickedCtrl" style="overflow-x: auto;">
	<table class="workTickedTable" style="table-layout: fixed;min-width: 100%;">
	<!-- <caption style="text-align: center;"><h1 class="title">操作票</h1></caption> -->
		<thead style="display: block;">
			<tr>
				<th style="width: 140px;">名称</th>
				<th style="width: 111px;">操作票号</th>
				<th style="width: 250px;">操作任务内容</th>
				<th style="width: 135px;">开始时间</th>
				<th style="width: 135px;">结束时间</th>
				<th style="width: 70px;">操作人</th>
				<th style="width: 70px;">维护人</th>
				<th style="width: 70px;">值班长</th>
				<th style="width: 100px;">备注</th>
			</tr>
		</thead>
		<tbody style="display: block;max-height: 400px;overflow: overlay;">
			<tr ng-repeat="item in data" class="{{$index % 2 === 0 ? 'bgWhite' : 'bgCyan'}}">
				<td style="width: 140px;">{{item.stationName}}</td>
				<td style="width: 111px;">{{item.ticketNo}}</td>
				<td style="width: 250px;">{{item.content}}</td>
				<td style="width: 135px;">{{item.startTime}}</td>
				<td style="width: 135px;">{{item.endTime}}</td>
				<td style="width: 70px;">{{item.operationUser}}</td>
				<td style="width: 70px;">{{item.guardianUser}}</td>
				<td style="width: 70px;">{{item.chiefUser}}</td>
				<td style="width: 100px;">{{item.remark}}</td>
			</tr>
		</tbody>
	</table>
</div>
<script>
	app.controller('reportOperationTickedCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

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




		/**
		 * 发请求，取数据
		 * @return {[type]} [description]
		 */
		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpdOperateTicket/selectCurrData.htm",
				params: {
					dateStr: $scope.date,
					type: 1
				}
			}).success(function(res) {
				$scope.data = res.data
			});
		}

	})
</script>