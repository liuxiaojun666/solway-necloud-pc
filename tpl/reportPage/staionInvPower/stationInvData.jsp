<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div class="col-sm-12 divshadow no-padder b-b" ng-controller="stationInvDataCtrl">
		<div class="col-sm-12 bg-white2 fault-data font-h4">
			<div class="col-sm-3 font-h3 black-1">创维电站<span ng-bind="stationInvData.month"></span>逆变器发电数据</div>
			<div class="col-sm-9">
				<span class="col-sm-3 no-padder">
					<div class="col-sm-6 text-right black-4 no-padder">实际发电量</div>
					<div class="col-sm-6 m-t-n-xs" >
						<span class="font-h1">
							<span ng-bind="stationInvData.real_kwh|dataNullFilter"></span>
							<span ng-bind="stationInvData.real_kwhUnit"></span>
						</span>
					</div>
				</span>
				<span class="col-sm-3 no-padder">
					<div class="col-sm-6 text-right black-4 no-padder">应发电量</div>
					<div class="col-sm-6 m-t-n-xs" >
						<span class="font-h1">
							<span ng-bind="stationInvData.shd_kwh|dataNullFilter"></span>
							<span ng-bind="stationInvData.shd_kwhUnit"></span></span>
						</span>
					</div>
				</span>
				<span class="col-sm-3">
					<span class="col-sm-2 no-padder black-4">PBA</span>
					<div class="col-sm-8 no-padder progress-xs m-t-sm  progress ng-isolate-scope"
					animate="true" type="primary">
					<div class="progress-bar progress-bar-danger"
						role="progressbar" aria-valuemin="0" aria-valuemax="100"
						ng-style="{width:stationInvData.pba+ '%'}"></div> 
					</div>
					<span class=" font-h3 col-sm-1"><span ng-bind="stationInvData.pba"></span>%</span>
				</span>
				<span class="col-sm-3">
					<span class="col-sm-2 no-padder black-4">PR</span>
					<div class="col-sm-8 no-padder progress-xs m-t-sm  progress ng-isolate-scope"
					animate="true" type="primary">
					<div class="progress-bar progress-bar-danger"
						role="progressbar" aria-valuemin="0" aria-valuemax="100"
						ng-style="{width:stationInvData.pr+ '%'}"></div> 
					</div>
					<span class=" font-h3 col-sm-1"><span ng-bind="stationInvData.pr"></span>%</span>
				</span>
				
			</div>
		</div>
	</div>
	<script>
	app.controller('stationInvDataCtrl',function($scope, $http, $state, $stateParams) {
		 $http.get(
					"${ctx}/Report/getStationBaseDataForMonth.htm",{
						params : {
							stid:$scope.stid,
							month:$("#changeTimeId2").html()
						}
					})
					.success(function(result) { 
						$scope.stationInvData=result.data
					}).error(function(response) {
					});
	});
	
	</script>