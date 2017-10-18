<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<div class="col-sm-12 no-padder"  ng-controller="dtStaTodayCtrl" >
	<!-- <div class="col-sm-12  m-n panel wrapper nav-tabs-alt ng-isolate-scope"  id="distUserNav">
		<ul class="nav col-sm-12 nav nav-tabs btn-nav"  >
          <li class="active">
          	<a class="" style="border-bottom-color: transparent !important;">
          		日发电量
          	</a>
           </li>
        </ul>
	</div> -->
<div class="col-sm-12 panel no-padder rollDiv nverterTablediv simThead_inverter2"style="max-height: 350px;;overflow:auto" id="powerList">
	<center id="nodata" class="m-t-md hidden">暂无数据</center>
	<div class="hasdata simThead inverterTable">
		<table class="table table-striped b-t b-light bg-table" style="border-top-color: transparent;">
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
			<tr ng-repeat="one in data.devList|orderBy:sort.column:sort.direction===-1">
				<td><span ng-bind="one.name"></span></td>
				<td>
					<span class="white" ng-bind="one.powerkwh[0]|dataNullFilter">-</span>
					<span class="m-l-xs" ng-bind="one.powerkwh[1]|dataNullFilter">kWh</span>
				</td>
				<td>
					<span class="white" ng-bind="one.powerHours">-</span>
					<span class="m-l-xs">h</span>
				</td>
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
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日")
		$scope.todayTimeForJson=new Date($scope.mapTimeDay).Format("yyyy/MM/dd/")
		$scope.stationListId = $scope.powerStationId;
		CommonPerson.Base.LoadingPic.PartShow('powerList');
		$scope.$on("dateChangeCtrl", function (event, msg) {
			$scope.todayTimeForJson=new Date($scope.mapTimeDay).Format("yyyy/MM/dd/")
			$scope.getStaTodayPowerData();
		});
		$scope.$on("sationIdChangeCtrl", function (event, msg) {
			$scope.stationListId = $scope.powerStationId;
			$scope.getStaTodayPowerData();
		});
		($scope.getStaTodayPowerData = function() {
			//请求电站的信息
			$http({
				method : "POST",
				url :"${ctx}/MobileHmDeviceMonitor/getInvtChartGeneratingPower.htm",
				params : {
					'dateString':$scope.todayTimeForJson,
					//'powerStationId':$scope.stationListId,
					'idsType':"station_one",
					'dateType':'D'
					}
				})
			.success(function (msg) {
				partHide('powerList')
				if(msg==null||msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden")
					$('.hasdata').addClass('hidden')
					return
				} else {
					$("#nodata").addClass("hidden");
					$('.hasdata').removeClass('hidden')
				}
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
				return
			});
		})();

		$scope.columns = [ {
			label : '名称',
			name : 'name'//表头 name 需要和table 的列 一致
		}, {
			label : '发电量',
			name : 'dayGeneratingPower[0]'
		}, {
			label : '发电小时数',
			name : 'dayGeneratingPowerIncome[1]'
		}];
		$scope.sort = {
			column : 'name',//默认有排序的列
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
