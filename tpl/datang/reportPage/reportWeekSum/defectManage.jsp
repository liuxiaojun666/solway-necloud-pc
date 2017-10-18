<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.defectStatisticsBox table th{
		padding: 10px 0;
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
		border-bottom: 1px solid #1cb09a;
	}
	.defectStatisticsBox table td{
		border-right: 1px solid #afe8dd;
		padding: 10px 0;
	}
	.defectStatisticsBox table{
		width: 100%;
		border-collapse: collapse;
		border: 1px solid #afe8dd;
	}
	
</style>
<div ng-controller="reportWeekSumDefectPageCtrl">
	<h3 ng-style="{paddingRight:'320px'}">缺陷管理</h3>
	 <div class="defectStatisticsBox" >
		<table>
			<thead>
				<tr>
					<th>风场</th>	
					<th>设备名称</th>	
					<th>缺陷内容</th>	
					<th>类型</th>	
					<th>工作票号</th>
					<th>停运时间</th>	
					<th>消缺时间</th>
					<th>消缺时数（分钟）</th>	
					<th>处理经过</th>
					<th>原因分析</th>	
					<th>备注</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in dataList" ng-class-odd="{ oddStyle : true }" ng-class-even="{ evenStyle : true }" >
					<td>{{ item.stationName }}</td>
					<td>{{ item.deviceName }}</td>
					<td>{{ item.faultContent }}</td>
					<td>{{ item.faultType }}</td>
					<td>{{ item.workTicketNum }}</td>
					<td>{{ item.stopTime }}</td>
					<td>{{ item.deOxygenTime }}</td>
					<td>{{ item.deOxygenMinute }}</td>
					<td>{{ item.doProcess }}</td>
					<td>{{ item.reason }}</td>
					<td> {{item.remark}} </td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
app.controller('reportWeekSumDefectPageCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
	$scope.$on("yearWeek",function(e,value){
		$scope.nowTimeYear = value.year;
		$scope.currentWeek = value.week;
		$scope.getData();
	});
	
	$scope.getData = function(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdFault/selectCurrData.htm",
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