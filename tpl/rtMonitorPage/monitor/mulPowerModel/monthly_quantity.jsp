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
					<td class="text-left"><span>{{one.name}}</span></td>
					<td class="text-left"><span>{{one.electricityQuantity[0]|dataNullFilter}}</span><span>{{one.electricityQuantity[1]}}</span></td>
					<td class="text-right"><span>{{one.electricityQuantityHours|dataNullFilter}}h</span></td>
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
		/* $scope.$on("sationIdChangeCtrl", function (event, msg) {
			$scope.getStaTodayPowerData();
		});
		*/
		$scope.statFaultType = "M";
		$scope.isReal=0;
		var statData;
		if($scope.statFaultType=="D"){
			statData=new Date($scope.mapTimeDay).Format("yyyy/MM/dd/")
			$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月")
		}else if($scope.statFaultType=="M"){
				$scope.isReal=1;
				statData=new Date($scope.mapTimeDay).Format("yyyy/MM")
				$scope.todayTimeForTitle=new Date().Format("yyyy年MM月")
		}else if($scope.statFaultType=="Y"){
			if($scope.mapTimeYear){
				statData=$scope.mapTimeYear
				$scope.todayTimeForTitle=$scope.mapTimeYear+"年"
			}else{
				statData=new Date().Format("yyyy")
				$scope.todayTimeForTitle=new Date().Format("yyyy")
			}
			
		}else if($scope.statFaultType=="A"){
			statData=""
			$scope.todayTimeForTitle="累计"
		}
		
		
		setInterval(function() {
			if ($("#powerIndexModal").is(":hidden")){
				return;
			}
			$scope.$apply($scope.getMonPowerData);
		}, 5000);
		
		($scope.getMonPowerData = function() {
			var timeStamp = $scope.mapTimeDay;
			var currentYear = (new Date().getFullYear());
			var selectYear = (new Date(timeStamp).getFullYear());
			var currentMonth = (new Date().getMonth())+1;
			var selectMonth = (new Date(timeStamp).getMonth())+1;
			
			if(timeStamp){
				statData = new Date(timeStamp).Format("yyyy/MM")
			}
			
			if(currentMonth != selectMonth){
				getOtherMonth();
			}else{
				if(currentYear != selectYear){
					getOtherMonth();
				}else{
					getCurrentMonth();
				}
			}
		})();

		//如果选择当前月，传标志位isReal
		function getCurrentMonth(){
			$http({
				method : "POST",
				url : "${ctx}/MobileHmDeviceMonitor/getStationChartGeneratingPower.htm",
				params : {
					'dateString':statData,
					//'powerStationId':$scope.powerStationId,
					'idsType':"station",
					'dateType':$scope.statFaultType,
					'isReal':$scope.isReal
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
		}
		
		//如果选择其他月，不传
		function getOtherMonth(){
			$http({
				method : "POST",
				url : "${ctx}/MobileHmDeviceMonitor/getStationChartGeneratingPower.htm",
				params : {
					'dateString':statData,
					'idsType':"station",
					'dateType':$scope.statFaultType
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
		}
		
		$scope.columns = [ {
			label : '名称',
			name : 'name'
		}, {
			label : '发电量',
			name : 'electricityQuantity_s'
		}, {
			label : '发电小时数',
			name : 'electricityQuantityHours'
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
