<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.simThead.opTable th, .simThead-table.opTable td{
		width: 14.2857%;
	}
</style>
<div class="col-sm-12  divshadow panel wrapper-xs m-n">
	<span class="font-h4 black-1 col-sm-12  faultTabletitle">运维人员统计</span>
	<div class="col-sm-12 no-padder tab-bordered m-t-sm b-t inverterTablediv simThead_opTable" ng-controller="opTableCtrl">
		<div ng-include="faultTotleM" load-done="finishFaultModal()"></div>
		<div class="simThead opTable">
			<table class="table table-striped b-t b-light bg-table tbody-scroll">
				<thead>
					<tr>
						<th ng-repeat="column in columns" class="a-cur-poi text-center"
							ng-click="sort.toggle(column)"
							ng-class="{sortable: column.sortable != false}">
							{{column.label}}
							<i ng-if="column.name === sort.column && sort.direction"
								class="glyphicon fa"
								ng-class="{true:'fa-angle-down', false:'fa-angle-up'}[sort.direction==-1]"></i>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		<table class="table table-striped b-t b-light bg-table tbody-scroll simThead-table opTable">
			<thead>
				<tr>
					<th ng-repeat="column in columns" class="a-cur-poi text-center"
						ng-click="sort.toggle(column)"
						ng-class="{sortable: column.sortable != false}">
						{{column.label}}
						<i ng-if="column.name === sort.column && sort.direction"
							class="glyphicon fa"
							ng-class="{true:'fa-angle-down', false:'fa-angle-up'}[sort.direction==-1]"></i>
					</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="op in opList|orderBy:sort.column:sort.direction===-1">
					<td class="text-center" >
						<span ng-bind="op.person_name" ></span>
					</td>
					<td class="text-center" >
						<span ng-bind="op.task_rcv_count" ></span>
					</td>
					<td class="text-center" >
						<span ng-bind="op.task_f_count" ></span>
					</td>
					<td class="text-center" >
						<span ng-bind="op.task_n_count" ></span>
					</td>
					<td class="text-center" >
						<span ng-bind="op.task_ref_count" ></span>
					</td>
					<td class="text-center" >
						<span ng-bind="op.task_f_r" ></span>
						<span ng-show="op.task_f_r!=null" class="">%</span>
					</td>
					<td class="text-center" >
						<span ng-bind="op.task_ref_r" ></span>
						<span ng-show="op.task_ref_r !=null" class="">%</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('.simThead_opTable').scroll(function(event) {
		$('.simThead_opTable .simThead').css('top', $(this).scrollTop());
	});
</script>
<script>
app.controller('opTableCtrl',function($scope, $http, $state, $stateParams) {
	$scope.$on('monthlyRefresh', function(event, data) {
	       if(data[0]){
	    	   $scope.mapTimeMonth=data[1]
	    	   $scope.getOpTable();
	      	 }
	      });
	$scope.$on('refreshViewDataForHead', function(event, data) {  
		$scope.getOpTable();
    });
	$scope.columns = [
		{
			label: '姓名',
			name: 'person_name'
		},{
			label: '领取任务总数(个)',
			name: 'task_rcv_count'
		},{
			label: '完成任务数(个)',
			name: 'task_f_count'
		},{
			label: '未完成任务数(个)',
			name: 'task_n_count'
		},{
			label: '拒绝任务数(个)',
			name: 'task_ref_count'
		},{
			label: '完成率',
			name: 'task_f_r'
		},{
			label: '拒绝率',
			name: 'task_ref_r'
		}
	]
	$scope.sort = {
		column: 'person_name',
		direction: -1,
		toggle: function(column) {
			if (column.sortable === false) {
				return;
			}
			if (this.column === column.name) {
				this.direction = -this.direction || -1;
			} else {
				this.column = column.name;
				this.direction = -1;
			}
		}
	};
	var faultModal=0;
	$scope.getOpTable=function(){
		$http.get(
				"${ctx}/Report/getStationOpsPersonListForMonth.htm",
				{
					params : {
						stid:$scope.stid,
						month:$scope.mapTimeMonth
					}
				}).success(function(response) {
					$scope.opList=response.dList
				}).error(function(response) {
				});
	}
	$scope.getOpTable()

});
</script>
