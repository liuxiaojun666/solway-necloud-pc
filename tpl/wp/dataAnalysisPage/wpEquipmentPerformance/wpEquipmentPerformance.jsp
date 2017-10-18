<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.dimention {
    -webkit-appearance: none;
    background: rgb(78,208,208) url(theme/images/wp/dataAnalysis/arrow-down.png) no-repeat;
    height: 30px;
    line-height: 30px;
    border: none;
    border-radius: 30px;
    color: white;
    background-position: 93%;
    padding: 0 20px 0 8px;
}
</style>
 <div class="hbox hbox-auto-xs hbox-auto-sm"  ng-controller="wpEquPerforCtrl">
	<div class="overview-title" >
		<div class="clearfix">
			<div class="pull-left">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
			</div>
			<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'" style="float:left;"></div>
			<div class="pull-left" style="margin: 0 0 0 100px;">
				<select class="dimention" ng-change="changeFans()" ng-model="fanId">
					<!-- <option value="all">全部风机</option> -->
					<option value="all">请选择风机</option>
					<option ng-repeat="item in fans" value="{{item.eqid}}">{{item.name}}</option>
				</select>
			</div>
		</div>
	</div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpEquipmentPerformance/model/topModel.jsp'"  style="padding:60px 0;background: white;margin: 10px;"></div>
	<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpEquipmentPerformance/model/centerModel.jsp'"></div>
	<div ng-show="dataType != 'year'" ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpEquipmentPerformance/model/bottomModel.jsp'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div> 
<script>
app.controller('wpEquPerforCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.showDay = false;
	$scope.showTotal = false;
	$scope.getCurrentDataName('02',0);
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		init();
    });
	$scope.$on("emitChangeDate",function(e,data){
		$scope.dataType = data.dataType;
		$scope.dtime = data.dtime;
		init();
	});
	
	//初始化
	//初始化月数据
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	$scope.fanId = "all";
	var dtime ,dateType;
	$scope.eqid = "-1";
	getFansData();
	init();
	
	function init(){
		switch($scope.dataType){
			case "day" :dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
						dateType = 'd'
				break;
			case "month" : dtime = new Date($scope.dtime).Format("yyyy-MM");
							dateType = 'm'
				break;
			case "year" : dtime = new Date($scope.dtime).Format("yyyy");
							dateType = 'y'
				break;
			case "total" :dtime = '';
						dateType = 'a'
				break;
			default:
				dtime = new Date($scope.dtime).Format("yyyy-MM");
		}
		getUpData();//重载环形图的数据
		getCenterData();//重载图中曲线数据
		if(dateType == 'm'){
			getDownData();//重载图下的数据
		}else{
			$scope.$broadcast("bottomData",null);
		}
		
	}
	
	//获取所有风机数据
	function getFansData(){
		$http.get("./WPDevicePerform/getStationDevicePerformWind.htm")
		.success(function(msg) {
			$scope.fans = msg.windList;
		}).error(function(response) {
		});
	}
	
	//切换风机
	$scope.changeFans = function(){
		var fanId = $scope.fanId;
		if(fanId == "all"){
			$scope.eqid = "-1";
		}else{
			$scope.eqid = fanId;
		}
		init();
	}
	
	//环形图数据获取（上图）
	function getUpData(){
		$http({
			method : "POST",
			url : "./WPDevicePerform/getStationDevicePerformPbaOper.htm",
			params : {
				'dtime':dtime,
				'model':dateType,
				'eqid':$scope.eqid
			}
		})
		.success(function (msg) {
			$scope.$broadcast("dataUp",msg);
		}).error(function(msg){
		}); 
	}
	//故障率数据获取（中图）
	function getCenterData(){
		$http.get("./WPDevicePerform/getStationDevicePerformPba.htm",{
			params : {
				'dtime':dtime,
				'model':dateType,
				'eqid':$scope.eqid
			}
		}).success(function(msg) {
			$scope.$broadcast("faultRateChild",msg);
		}).error(function(response) {
		});
	}
	
	//柱状图，点等数据获取（下图）
	function getDownData(){
		$http.get("./WPDevicePerform/getStationDevicePerformWindKW.htm",{
			params : {
				'dtime':dtime,
				'model':dateType,
				'eqid':$scope.eqid
			}
		}).success(function(msg) {
			$scope.$broadcast("bottomData",msg);
		}).error(function(response) {
		});
	}
});
</script>
