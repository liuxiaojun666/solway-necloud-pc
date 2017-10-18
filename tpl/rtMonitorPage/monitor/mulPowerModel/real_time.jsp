<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.simThead_inverter2 .simThead.inverterTable th, .simThead_inverter2 .simThead-table.inverterTable td {width: 12.5%;text-align: left !important;}
	.simThead_inverter2 .simThead.inverterTable th:nth-child(4),
	.simThead_inverter2 .simThead.inverterTable th:nth-child(4) ~ th,
	.simThead_inverter2 .simThead-table.inverterTable td:nth-child(4),
	.simThead_inverter2 .simThead-table.inverterTable td:nth-child(4) ~ td {text-align: left !important;}
	.bg_fault ,.bg_fault ~ td {background-color: #D8412F !important;color: #fff !important;}
	.bg_alarm ,.bg_alarm ~ td {background-color: #FF9900 !important;color: #fff !important;}
	.bg_break ,.bg_break ~ td {background-color: #5F7C8A !important;color: #fff !important;}
	.simThead-table thead {visibility: visible;}
</style>
<div class="col-sm-12 no-padder" ng-controller="staTodayCtrl">
	<div class="col-sm-12 panel no-padder rollDiv nverterTablediv simThead_inverter2" style="overflow-y:scroll;max-height: 400px;" id="powerList">
		<center id="nodata" class="m-t-md hidden">暂无数据</center>
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
				<tr ng-repeat="one in data|orderBy:sort.column:sort.direction===-1">
					<td class="text-left"><span ng-bind="one.name"></span></td>
					<td class="text-left"><span>{{one.installedCapacity[0]|dataNullFilter}}</span><span>{{one.installedCapacity[1]}}</span></td>
					<td class="text-left"><span>{{one.power[0]|dataNullFilter}}</span><span>{{one.power[1]}}</span></td>
					<td class="text-left"><span>{{one.outputPowerRatio|dataNullFilter}}%</span></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('.simThead_inverter2').scroll(function(event) {
		$('.simThead_inverter2 .simThead').css('top', $(this).scrollTop());
	});
	app.controller('staTodayCtrl',function($scope, $http, $state,$rootScope) {
		 setInterval(function() {
				if ($("#powerIndexModal").is(":hidden")){
					return;
				}
				$scope.$apply($scope.getStaTodayPowerData);
			}, 5000);
		
		($scope.getStaTodayPowerData = function() {
			$http({
				method : "POST",
				url : "${ctx}/MobileRtmDeviceMonitor/getStationPower.htm",
				params : {
					'dateString':new Date().Format("yyyy/MM/dd/"),
					//'powerStationId':$scope.powerStationId,
					'idsType':"station"
					}
				})
			.success(function (msg) {
				if(msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden")
					return
				}
				$scope.data=msg.devList;
			}).error(function(msg){
				$("#nodata").show();
				return
			});
		})();
		$scope.columns = [ {
			label : '名称',
			name : 'name'
		}, {
			label : '装机容量',
			name : 'installedCapacity_s'
		}, {
			label : '功率',
			name : 'power_s'
		}, {
			label : '出力',
			name : 'outputPowerRatio'
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
