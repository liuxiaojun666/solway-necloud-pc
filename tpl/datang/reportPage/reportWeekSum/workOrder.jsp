<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.workOrderBox{
		width: 100%;
		background-color: pink;
	}
	.workOrderBox table th{
		padding: 10px 0;
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
		border-bottom: 1px solid #1cb09a;

	}
	.workOrderBox table td{
		border-right: 1px solid #afe8dd;
		padding: 10px 0;
	}
	.workOrderBox table{
		width: 100%;
		border-collapse: collapse;
		border: 1px solid #afe8dd;
	}
</style>
<div class="workOrder" ng-controller="reportWeekSumWorkTicketPageCtrl">
	<h3 ng-style="{paddingRight:'300px'}">工作票</h3>
	<div class="workOrderBox" >
		<table>
			<thead>
				<tr>
					<th>名称</th>
					<th>工作票类型</th>
					<th>工作内容</th>
					<th>工作票号</th>
					<th>工作票接收时间</th>
					<th>许可开始时间</th>
					<th>工作票结束时间</th>
					<th>工作负责人</th>
					<th>工作票许可人</th>
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in dataList" ng-class-odd="{ oddStyle : true }" ng-class-even="{ evenStyle : true }" ng-style="item.M_colorStyle" >
					<td>{{ item.stationName }}</td>
					<td>{{ item.ticketType }}</td>
					<td>{{ item.content}}</td>
					<td>{{ item.ticketNo }}</td>
					<td>{{ item.acceptTime }}</td>
					<td>{{ item.allowTime }}</td>
					<td>{{ item.endTime }}</td>
					<td>{{ item.chargeUser1 }}</td>
					<td>{{ item.allowUser1}}</td>
					<td> {{item.remark}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
app.controller('reportWeekSumWorkTicketPageCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
	$scope.$on("yearWeek",function(e,value){
		$scope.nowTimeYear = value.year;
		$scope.currentWeek = value.week;
		$scope.getData();
	});
	
	$scope.getData = function(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdWorkTicket/selectCurrData.htm",
	 		params: {
	 			'type':2,
	 			'year':$scope.nowTimeYear,
	 			'week':$scope.currentWeek
	 		}
		 }).success(function(res) {
			 $scope.dataList = res.data;
			
		 })
	}
	
	$scope.getData();
	
})

</script>