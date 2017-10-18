<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div ng-controller="falutData">
	<div class="col-sm-6 divshadow" style="padding: 0px 10px 0px 0px;">
		<div class="col-sm-12 bg-white2 fault-data font-h4">
			<div class="col-sm-2">故障台次</div>
			<div class="col-sm-2 m-t-n-xs" >
				<span class="font-h1" ng-bind="targetData.fail_count|dataNullFilter"></span>台次
			</div>
			<div class="col-sm-8">
				<span class="col-sm-3 no-padder">
					<span class="pull-right">故障率</span>
				</span>
				<span class="col-sm-7">
					<div class="col-sm-12 no-padder progress-xs m-t-sm  progress ng-isolate-scope"
					animate="true" type="primary">
					<div class="progress-bar progress-bar-danger"
						role="progressbar" aria-valuemin="0" aria-valuemax="100"
						ng-style="{width:targetData.fail_r+ '%'}"></div>
					</div>
				</span>
				<span class="text-danger no-padder font-h3 col-sm-1" >
					<span ng-bind="targetData.fail_r|dataNullFilter">40</span>%</span>
			</div>
		</div>
	</div>
	<div class="col-sm-6 divshadow" style="padding: 0px 0px 0px 10px;"> 
		<div class="col-sm-12 bg-white2 fault-data font-h4">
			<div class="col-sm-2">故障小时数</div>
			<div class="col-sm-2 m-t-n-xs" >
				<span class="font-h1" ng-bind="targetData.fail_hours|dataNullFilter">56</span>h
			</div>
			<div class="col-sm-1"></div>
			<div class="col-sm-3">故障损失电量</div>
			<div class="col-sm-4 m-t-n-xs" >
				<span class="font-h1" ng-bind="targetData.fail_kwh|dataNullFilter">456</span>
				<span ng-bind="targetData.fail_kwhUnit|dataNullFilter">456</span>
			</div>
		</div>
	</div>
	</div>
	<script >
	app.controller('falutData',function($scope, $http, $state, $stateParams) {
		$scope.$on('monthlyRefresh', function(event, data) {  
		       if(data[0]){
		    	   $scope.mapTimeMonth=data[1]
		    	   $scope.getFaultData();
		      	 }
		      }); 
		$scope.$on('refreshViewDataForHead', function(event, data) {  
			$scope.getFaultData();
	    });
		$scope.getFaultData=function(){
			 $http.get(
						"${ctx}/Report/getStationBaseDataForMonth.htm",{
							params : {
								stid:$scope.stid,
								month:$scope.mapTimeMonth
							}
						})
						.success(function(result) {
							$scope.targetData=result
						
						}).error(function(response) {
				});
			
		}
		$scope.getFaultData()
		
	});
	</script>
