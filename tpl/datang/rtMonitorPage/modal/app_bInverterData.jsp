<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.simThead_inverter2 .simThead.inverterTable th, .simThead_inverter2 .simThead-table.inverterTable td {width: 12.5%;text-align: left !important;}
	.simThead_inverter2 .simThead.inverterTable th:nth-child(4),
	.simThead_inverter2 .simThead.inverterTable th:nth-child(4) ~ th,
	.simThead_inverter2 .simThead-table.inverterTable td:nth-child(4),
	.simThead_inverter2 .simThead-table.inverterTable td:nth-child(4) ~ td {text-align: right !important;}
	.bg_fault ,.bg_fault ~ td {background-color: #D8412F !important;color: #fff !important;}
	.bg_alarm ,.bg_alarm ~ td {background-color: #FF9900 !important;color: #fff !important;}
	.bg_break ,.bg_break ~ td {background-color: #5F7C8A !important;color: #fff !important;}
</style>
<div class="col-sm-12 no-padder" ng-controller="dtStaTodayCtrl">
	<div class="col-sm-12 panel no-padder rollDiv nverterTablediv simThead_inverter2"style="overflow-y:scroll;max-height: 400px;" id="powerList">
		<center id="nodata" class="m-t-md hidden">暂无数据</center>
		<div class="hasdata simThead inverterTable">
			<table class="table table-striped b-t b-light bg-table" style="border-top-color: transparent;">
				<thead>
					<tr>
						<th ng-repeat="column in columns" class="a-cur-poi text-center"
							ng-click="sort.toggle(column)"
							ng-class="{sortable: column.sortable !== false}">
							{{column.label}} <i
							ng-if="column.name === sort.column && sort.direction"
							class="glyphicon {{sort.direction|orderClass}}"></i>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		<table class="hasdata table table-striped b-light inverterTable simThead-table">
			<thead>
				<tr>
					<th ng-repeat="column in columns" class="a-cur-poi"
						ng-click="sort.toggle(column)"
						ng-class="{sortable: column.sortable !== false}">
						{{column.label}} <i
						ng-if="column.name === sort.column && sort.direction"
						class="glyphicon {{sort.direction|orderClass}}"></i>
					</th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="one in data.data|orderBy:sort.column:sort.direction===-1">
					<td class="text-left" ng-class="{bg_fault:one.statusDesc=='故障',bg_alarm:one.statusDesc=='报警',bg_break:one.statusDesc=='中断'}"><span ng-bind="one.statusDesc"></span></td>
					<!-- <td class="text-left"><span ng-bind="one.code"></span></td> -->
					<td class="text-left"><span ng-bind="one.name"></span></td>
					<!-- <td><span ng-bind="one.capacity"></span></td> -->
					<td><span ng-bind="one.dtime*1000 | date:'yyyy-MM-dd HH:mm:ss'"></span></td>
					<td class="text-right"><span>{{one.acp | dataNullFilter | sDecimalFilter:'2'}}kW</span></td>
					<td class="text-right"><span>{{one.ef*100 | dataNullFilter | sDecimalFilter:'2'}}%</span></td>
					<td class="text-right"><span></span>{{one.dw | dataNullFilter | sDecimalFilter:'2'}}kWh</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('.simThead_inverter2').scroll(function(event) {
		$('.simThead_inverter2 .simThead').css('top', $(this).scrollTop());
	});
	app.controller('dtStaTodayCtrl',function($scope, $http, $state,$rootScope) {
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日");
		$scope.todayTimeForJson=new Date($scope.mapTimeDay).Format("yyyy/MM/dd/");
		$scope.stationListId = $scope.powerStationId;
		CommonPerson.Base.LoadingPic.PartShow('powerList');
		$scope.$on("sationIdChangeCtrl", function (event, msg) {
			$scope.getStaTodayPowerData();
		});
		setInterval(function() {
			if ($("#powerIndexModal").is(":hidden")){
				return;
			}
			//$scope.$apply($scope.getStaTodayPowerData);
		}, 5000);
		($scope.getStaTodayPowerData = function() {
			$http({
				method : "POST",
				url :"${ctx}/DeviceStation/getRealDataBInverter.htm",
				params : {
					'ids':$scope.stationListId,
					'status': '00',
					'pageSize': 1000
					}
				})
			.success(function (msg) {
				partHide('powerList')
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
				return
			});
		})();

		$scope.columns = [ {
			label : '状态',
			name : 'realtimeMonitorMap.statusDesc'
		}, {
			label : '逆变器名称',
			name : 'name'
		}, {
			label : '时间',
			name : 'realtimeMonitorMap.dataTime'
		}, {
			label : '实时功率',
			name : 'realtimeMonitorMap.acp'
		}, {
			label : '效率',
			name : 'realtimeMonitorMap.ef'
		}, {
			label : '日发电量',
			name : 'realtimeMonitorMap.dw'
		}];
		$scope.sort = {
			column : '',//默认有排序的列
			direction : -1,
			toggle : function(column) {
				if (column.sortable === false)
					return;

				if (this.column === column.name) {
					this.direction = -this.direction || -1;
				} else {
					this.column = column.name;
					this.direction = -1;
				}
			}
		};
	});
</script>
