<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.operationOrderBox{
		width: 100%;
		background-color: pink;
	}
	.operationOrderBox table th{
		padding: 10px 0;
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
		border-bottom: 1px solid #1cb09a;

	}
	.operationOrderBox table td{
		border-right: 1px solid #afe8dd;
		padding: 10px 0;
	}
	.operationOrderBox table{
		width: 100%;
		border-collapse: collapse;
		border: 1px solid #afe8dd;
	}
</style>
<div ng-controller="reportWeekSumOperationTicketPageCtrl">
	<h3 ng-style="{paddingRight:'300px'}">操作票</h3>
	<div class="operationOrderBox" >
		<table>
			<thead>
				<tr>
					<th ng-repeat="headerData in tHeader" ng-bind="headerData"></th>		
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in dataList" ng-class-odd="{ oddStyle : true }" ng-class-even="{ evenStyle : true }" >
					<td >{{item.stationName}}</td>
					<td >{{item.ticketNo}}</td>
					<td >{{item.content}}</td>
					<td >{{item.startTime}}</td>
					<td >{{item.endTime}}</td>
					<td>{{item.operationUser}}</td>
					<td>{{item.guardianUser}}</td>
					<td>{{item.chiefUser}}</td>
					<td>{{item.remark}}</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
app.controller('reportWeekSumOperationTicketPageCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
	$scope.$on("yearWeek",function(e,value){
		$scope.nowTimeYear = value.year;
		$scope.currentWeek = value.week;
		$scope.getData();
	});
	
	$scope.getData = function(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdOperateTicket/selectCurrData.htm",
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
	//测试
	$scope.tHeader = ["名称","操作票号","操作任务内容","开始时间","结束时间","操作人","监护人","值班长","备注"]
})

</script>