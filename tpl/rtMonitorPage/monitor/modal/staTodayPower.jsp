<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<div class="col-sm-12 no-padder"  ng-controller="staTodayCtrl" >
	<div class=""  id="distUserNav">
		<ul class="nav col-sm-12 no-padder nav-top b-b "  >
          <li class="col-sm-12 no-padder text-center h3">
          	<a class="text-1-8x">
          		<span ng-bind="todayTimeForTitle"></span>发电量
          	</a>
           </li>
        </ul>
	</div>
<div class="col-sm-12 no-padder rollDiv"style="height: 350px;;overflow:auto" id="powerList">
	<center id="nodata" class="m-t-md hidden">暂无数据</center>
	<div class="hasdata simThead inverterTable">
		<table class="table table-striped b-t b-light bg-table">
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
					<span class="white" ng-bind="one.dayGeneratingPower[0]">-</span>
					<span class="m-l-xs" ng-bind="one.dayGeneratingPower[1]">kWh</span>
				</td>
				<td>
					<span class="white" ng-bind="one.dayGeneratingPowerIncome[0]">-</span>
					<span class="m-l-xs" ng-bind="one.dayGeneratingPowerIncome[1]">￥</span>
				</td>
			</tr>
		</tbody>
	</table>
	<%--<div class="col-sm-12 font-h2 no-padder bg-writer m-t-sm " ng-repeat="one in data.devList">
		<div class="col-sm-4 wrapper wrapper-l-r-md font-big" ng-bind="one.name"></div>
		<div class="col-sm-4 wrapper wrapper-l-r-md text-center col-d b-r-5">
			<span class="text-1-2x">发电量</span>
			<span class="white font-big" ng-bind="one.dayGeneratingPower[0]">-</span>
			<span class="m-l-xs font-big" ng-bind="one.dayGeneratingPower[1]">kWh</span>
		</div>
		<div class="col-sm-4 wrapper wrapper-l-r-md col-d text-center">
			<span class="text-1-2x">日收入</span>
			<span class="white font-big" ng-bind="one.dayGeneratingPowerIncome[0]">-</span>
			<span class="m-l-xs font-big" ng-bind="one.dayGeneratingPowerIncome[1]">￥</span>
		</div>
	</div>--%>
</div>
</div>
<script>
	$('.simThead_inverter3').scroll(function(event) {
		$('.simThead_inverter3 .simThead').css('top', $(this).scrollTop());
	});
	app.controller('staTodayCtrl',function($scope, $http, $state,$rootScope) {
		$scope.todayTimeForTitle=new Date($scope.mapTimeDay).Format("yyyy年MM月dd日")
		$scope.todayTimeForJson=new Date($scope.mapTimeDay).Format("yyyy/MM/dd/")
		$scope.stationListId = $scope.powerStationId
		CommonPerson.Base.LoadingPic.PartShow('powerList');
		if($scope.stationListId.length>1){
			//请求组的信息
			$http({
				method : "POST",
				url : "${ctx}/MobileRtmDeviceMonitor/getDayChartGeneratingPower.htm",
				params : {
					'dateString':$scope.todayTimeForJson,
					'ids':$scope.stationListId,
					'idsType':"station"
					}
				})
			.success(function (msg) {
				partHide('powerList')
				if(msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden")
					return
				}
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
				return
			});
		}else {
			//请求电站的信息
			$http({
				method : "POST",
				url :"${ctx}/MobileRtmDeviceMonitor/getDayChartGeneratingPower.htm",
				params : {
					'dateString':$scope.todayTimeForJson,
					'ids':$scope.stationListId,
					'idsType':"station_one"
					}
				})
			.success(function (msg) {
				partHide('powerList')
				if(msg==null||msg.devList==null|| msg.devList.length<=0){
					$("#nodata").removeClass("hidden")
					return
				}
				$scope.data=msg;
			}).error(function(msg){
				$("#nodata").show();
				return
			});

		}
		$scope.columns = [ {
			label : '名称',
			name : 'name'//表头 name 需要和table 的列 一致
		}, {
			label : '日发电量',
			name : 'dayGeneratingPower[0]'
		}, {
			label : '日收入',
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
