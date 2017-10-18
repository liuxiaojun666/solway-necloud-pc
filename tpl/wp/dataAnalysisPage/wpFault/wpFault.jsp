<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${ctx}/theme/css/wp/dataAnalysisPage/wpFault.css">
<div class="app-content-full-map" ng-controller="wpFaultCtrl" style="position:relative;">
	<div class="hbox " >
		<div class="col">
			<div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
				<div class="col-sm-12 overview-title" >
					<div class="clearfix">
						<div class="pull-left">
							<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
							<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
						</div>
						<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'" style="float:left;"></div>
						<div class="pull-left" style="margin: 0 50px;"><select class="dimention" id="dimention"><option value="0">风机维度</option><option value="1">时间维度</option></select></div>
					</div>
				</div>
			</div>
            <div ng-include="includeModel" class="col-sm-12"></div>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script>
app.controller('wpFaultCtrl',function($scope, $http, $state, $stateParams) {
	$scope.showDay = false;
	$scope.showTotal = false;
	$scope.getCurrentDataName('02',0);
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		judge();
    });
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	$scope.$on("emitChangeDate",function(e,data){
		judge();
		$scope.dataType = data.dataType;
		$scope.dtime =data.dtime;
		$scope.$broadcast('broadChangeDate',data);
	});
	
	//初始化
	$scope.timeDimension = false;
	judge();
	function judge(){
		if($scope.timeDimension == true){
			$scope.includeModel = '${ctx}/tpl/wp/dataAnalysisPage/wpFault/model/timeDimensionPage.jsp';
		}else if($scope.timeDimension == false){
			$scope.includeModel = '${ctx}/tpl/wp/dataAnalysisPage/wpFault/model/fanDimension.jsp';
		}
	}
	
	$("#dimention").change(function(){
		var selectVal = $("#dimention option:selected").val();
		if(selectVal == 0){
			$scope.timeDimension = false;
		}else if(selectVal == 1){
			$scope.timeDimension = true;
		}
		judge();
		$scope.$apply();
	});
	
});
</script>
