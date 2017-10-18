<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.workFinishedBox{
		position: relative;
		width: 100%;
	}
	.workFinishedBox table th{
		padding: 10px 0;
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
	}
	.workFinishedBox table td{
		border-right: 1px solid #afe8dd;
		padding: 10px 0;white-space: nowrap;

	}
	.workFinishedBox table{
		width:100%;
		border-collapse: collapse;
	}
	.workFinishedBox table tbody{
		border-bottom: 1px solid #afe8dd;
		border-left: 1px solid #afe8dd;
	}
</style>
<div class="weekWorkPlan" ng-controller="reportWeekFinishDataCtrl">
	<h3>周工作完成情况</h3>
	<div class="workFinishedBox container" >
		<table class="row">
			<thead>
				<tr>
					<th class="col-sm-2" > 电站 </th>	
					<th class="col-sm-4" > 本周内容 </th>	
					<th class="col-sm-4" > 下周工程 </th>	
					<th class="col-sm-2" > 填报人 </th>	
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="item in dataList" ng-class-odd="{ oddStyle : true }" ng-class-even="{ evenStyle : true }" >
					<td><div class="empty"></div>{{ item.stationName }}<div class="empty"></td>
					<td><div class="empty"></div>{{ item.content1 }}<div class="empty"></td>
					<td><div class="empty"></div>{{ item.content2 }}<div class="empty"></td>
					<td><div class="empty"></div>{{ item.createUserName }}<div class="empty"></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
app.controller('reportWeekFinishDataCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
	$scope.$on("yearWeek",function(e,value){
		console.log(value);
		$scope.nowTimeYear = value.year;
		$scope.currentWeek = value.week;
		$scope.getData();
	});
	 console.log("时间："+$scope.nowTimeYear+"-"+$scope.currentWeek);
	$scope.getData = function(){
		$http({
			method : "GET",
			url : "${ctx}/rpwSummary/selectCurrData.htm",
			params : {
				'dateStr':"2017-7-28"
			}
		}).success(function(result) {
			console.log(result);
			$scope.dataList = result.data;
		});		
	}
	$scope.getData();
	//测试数据
	/* $scope.dataList = [
	               	{
	            		"A_name":"葛沽光伏电站",
	            		"B_operationOrder":"057DQ1409001",
	            		"C_operationContent":"3kv无功补偿装置由\“运行\”转\“热装备\”",
	            		"D_startTime":"06月7日10时01分",
	            		"E_finshTime":"06月18日16时20分",
	            		"F_operationPeople":"小明",
	            		"G_guardian":"小红",
	            		"H_watcher":"小白",
	            		"I_remarks":"zheshibeizhu"
	            	},
	            	{
	            		"A_name":"东起光伏电站",
	            		"B_operationOrder":"057DQ142309",
	            		"C_operationContent":"3kv无功补偿装置由\“运行\”转\“热装备\”",
	            		"D_startTime":"06月7日10时01分",
	            		"E_finshTime":"06月18日16时20分",
	            		"F_operationPeople":"小明",
	            		"G_guardian":"小红",
	            		"H_watcher":"小白",
	            		"I_remarks":"zheshibeizhu"
	            	},
	            	{
	            		"A_name":"葛沽光伏电站",
	            		"B_operationOrder":"057DQ1409001",
	            		"C_operationContent":"3kv无功补偿装置由\“运行\”转\“热装备\”",
	            		"D_startTime":"06月7日10时01分",
	            		"E_finshTime":"06月18日16时20分",
	            		"F_operationPeople":"小明",
	            		"G_guardian":"小红",
	            		"H_watcher":"小白",
	            		"I_remarks":"zheshibeizhu"
	            	}
	            ]; */
})

</script>