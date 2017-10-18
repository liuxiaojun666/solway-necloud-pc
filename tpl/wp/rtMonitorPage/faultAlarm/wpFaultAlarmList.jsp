<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="FaultAlarmCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">故障报警</span> -->
	</div>
	<div class="wrapper-sm bg-light m-b-sm">
	<!-- 按级别 -->
		<div class="col-sm-3 col-xs-12  no-padder">
			<div class="col-sm-4 col-xs-12 data-bg-red-2 no-padder v-middle faultRtStatics">
			<div class="bg-black-05 faultRtStatics text-center-xs">
			<div class="text-center-xs padder-t">
			<span class="font-h4 text-black">
				<a class="text-info"><img src="./theme/images/solway/icon/anjibie.png" width="24" height="24"></a>
			</span>
			</div>
			<span class="font-h4 white-1 m">按级别</span>
			</div>
			</div>
			<div class="col-sm-4 col-xs-12 v-middle text-center-xs faultRtStatics data-bg-red-2" >
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">故障</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.seriousCount">0</span>
			</div>
			<div class="col-sm-4 col-xs-12 faultRtStatics data-bg-red-2 text-center-xs" >
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">报警</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.normalCount">0</span>
			</div>
		</div>
		<!-- 按设备 -->
		<div class="col-sm-4 col-xs-12  ">
			<div class="col-sm-2 col-xs-12 no-padder faultRtStatics bg-blue-1 ">
			<div class="bg-black-05 faultRtStatics text-center-xs">
			<div class="text-center-xs padder-t">
			<span class="font-h1 text-black " >
				<a class="text-info"><img src="./theme/images/solway/icon/anshebei.png" width="24" height="24"></a>
			</span>
			</div>
			<span class="font-h4 white-1 ">按设备</span>
			</div>
			</div>
			
			<div class="col-sm-5 col-xs-12 bg-blue-1 faultRtStatics text-center-xs">
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">测风塔</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.windTowerCount">0</span>
			</div>
			<div class="col-sm-5 col-xs-12 bg-blue-1 faultRtStatics text-center-xs">
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">风电机组</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.windTurbineCount">0</span>
			</div>
		</div>
		<!-- 按时间 -->
		<div class="col-sm-5 col-xs-12  no-padder">
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics no-padder">
			<div class="bg-black-05 faultRtStatics text-center-xs">
			<div class="text-center-xs padder-t">
			<span class="font-h1 text-black">
				<a class="text-info"><img src="./theme/images/solway/icon/anshijian.png" width="24" height="24"></a>
			</span>
			</div>
			<span class="font-h4 white-1 m">按时间</span>
			</div>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics text-center-xs">
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">4小时以上</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.above4Count">0</span>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics text-center-xs">
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">2小时以上</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.above2Count">0</span>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics text-center-xs">
			<div class="padder-t text-center-xs">
				<span class="font-h4 white-1">2小时以内</span>
			</div>
			<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.below2Count">0</span>
			</div>
		</div>
	</div>
	<div class="wrapper-md ng-scope">
		<paging>
			<div class="col-sm-5 pull-right" style="margin: 10px 0;">
				<%@ include file="/common/pager.jsp"%>
			</div>
			<div class="wrapper-sm  no-border-xs panel">
				<table class="table table-striped b-t b-light bg-table" id="t">
					<tr>
						<th style="text-align: center;" width="5%">设备名称</th>
						<th style="text-align: center;" width="5%">故障类型</th>
						<th style="text-align: center;" width="5%">设备类型</th>
						<th style="text-align: center;" width="10%">事件发生时间</th>
						<th style="text-align: center;" width="10%">事件描述</th>
						<th style="text-align: center;" width="5%">持续时间</th>
					</tr>
					<tr ng-repeat="vo in rtStatisticsData">
						<td style="text-align: center;" ng-bind="vo.name"></td>
						<td style="text-align: center;" ng-bind="vo.eventType"></td>
						<td style="text-align: center;" ng-bind="vo.deviceType"></td>
						<td style="text-align: center;" ng-bind="vo.sStartTime"></td>
						<td style="text-align: center;" ng-bind="vo.eventDesc"></td>
						<td style="text-align: center;" ng-bind="vo.hours"></td>
					</tr>
				</table>
			</div>
		</paging>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">
    app.controller('FaultAlarmCtrl', function ($scope, $rootScope,$http,$state,$stateParams) {
    	$scope.getCurrentDataName('00',0);
    	$scope.$on('broadcastSwitchStation', function(event, data) {
    		$scope.currentDataName = data.dataName;
			$scope.refreshViewDataForHead();
	    });
    	$scope.totalStatistics=null;
    	
    	$scope.refreshViewDataForHead = function () {
    		$http({method:"POST",url:"${ctx}/WpRtmFaultAlarm/getFaultAlarmTotalStatisticsData.htm"
        	}).success(function (result) {
    	    	$scope.totalStatistics=result;
    		});
    		$scope.rtStatistics(1);
    	};
    	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);
    	
    	$scope.faultLevelList = [{'dictName':'故障'},{'dictName':'报警'}];
		$scope.faultLevelCount = 2;
    	$scope.rtStatisticsData = null;
    	
    	$http({method:"POST",url:"${ctx}/WpRtmFaultAlarm/getFaultAlarmTotalStatisticsData.htm"
    	}).success(function (result) {
	    	$scope.totalStatistics = result;
		});

		initTableConfig($scope);
		$scope.onSelectPage = $scope.rtStatistics = function (page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method:"POST",
				url:"${ctx}/WpRtmFaultAlarm/getWpStationFaultAlarmRtData.htm",
				params : {
					'pageIndex': page - 1,
					'pageSize': $scope.pageSizeSelect
				}
			}).success(function (result) {
				getTableData($scope,result);
			});
        };
		$scope.onSelectPage(1);
    });
</script>
