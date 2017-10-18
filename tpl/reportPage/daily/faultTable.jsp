<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.simThead.faultTable th, .simThead-table.faultTable td {width: 25%;}
</style>
<div class="col-sm-12  divshadow panel wrapper-xs m-n">
<span class="font-h4 black-1 col-sm-12  faultTabletitle">故障情况</span>
	<div class="col-sm-12 no-padder tab-bordered m-t-sm b-t inverterTablediv simThead_fault" ng-controller="faultTableCtrl">
		<div class="simThead faultTable">
			<table class="table table-striped b-t b-light bg-table">
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
		<table class="table table-striped b-t b-light bg-table simThead-table faultTable">
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
				<tr ng-repeat="fault in faultList|orderBy:sort.column:sort.direction===-1">
					<td class="text-center" >
						<span ng-bind="fault.devicename" ></span>
					</td>
					<td class="text-center"><span ng-bind="fault.sStartTime|date:'yyyy-MM-dd HH:mm'"></span>
					</td>
					<td class="text-center"><span ng-bind="fault.eventDesc"></span></span></td>
					<td class="text-center">
						<span ng-if="fault.handStatus=='03'" >是</span>
						<span ng-if="fault.handStatus=='01'" class="data-red">否</span>
						<span ng-if="fault.handStatus=='02'" class="data-red">否</span>
						<span ng-if="fault.handStatus=='00'" class="data-red">否</span>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('.simThead_fault').scroll(function(event) {
		$('.simThead_fault .simThead').css('top', $(this).scrollTop());
	});
</script>
<script>
	app.controller('faultTableCtrl',function($scope, $http, $state, $stateParams) {
		var faultModal=0;
		$scope.$on('dailyRefresh', function(event, data) {
		       if(data[0]){
		    	   $scope.mapTimeDay=data[1]
		    		$scope.getFaultTable();
		      	 }
		      });
		$scope.$on('refreshViewDataForHead', function(event, data) {  
			$scope.getFaultTable();
	    });
		$scope.columns = [
			{
				label: '设备名称',
				name: 'devicename'
			},{
				label: '故障发生时间',
				name: 'sStartTime'
			},{
				label: '故障描述',
				name: 'eventDesc'
			},{
				label: '是否修复',
				name: 'handStatus'
			}
		]
		$scope.sort = {
			column: 'devicename',
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
		$scope.getFaultTable=function(){
			$http.get(
					"${ctx}/Report/getFaultForDayReport.htm",
					{
						params : {
							stid:$scope.stid,
							dtime:$scope.mapTimeDayRefresh
						}
					}).success(function(response) {
						$scope.faultList=response.data
					}).error(function(response) {
					});
		}
		$scope.getFaultTable();
	});
</script>
