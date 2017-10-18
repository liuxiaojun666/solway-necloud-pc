<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	th{
		word-break:keep-all;           /* 不换行 */
		white-space:nowrap;          /* 不换行 */
	}
	.showLie{
		z-index: 9999;
		position: fixed;
		top: 0;left: 0;
		right: 0;
		bottom: 0;
		background-color: rgba(0,0,0,0.5);
	}
	.showLie .content{
		padding: 30px;
		overflow: auto;
		margin:auto;
		position: absolute;
		width: 800px;
		height: 400px;
		left: 0;
		right: 0;
		top: 0;
		bottom: 0;
	}
	.showLie ul {
		padding: 0;
		margin-top: 30px;
	}
	.showLie ul li{
		width: 33%;
		padding-bottom: 10px;
		padding-left: 30px;
		border-right: 1px solid #ccc;
	}
	.showLie ul li:nth-child(3n){
		border-right: none;
	}
</style>
 <!-- 弹出层界面 -->
<%-- <div id="boxChangeEdit" data-ng-include="'${ctx}/tpl/ledgerPage/boxChange/addBoxChange.jsp'"></div> --%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>

<div ng-controller="indexManagementCtrl">

	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">运行日志</span> -->
	</div>

	<div class="wrapper-md row ng-scope">
		 <div class="col-sm-6 p-l-n">
			<!-- <label class="col-sm-2 control-label" ></label> -->
			<div class="input-group " style="width: 550px;margin-left: 25px;">

				<input type="text" id="sStartTime" name="sStartTime" value="{{startDateStr | date:'yyyy-MM-dd'}}" class="form-control">

	         	<span class="input-group-addon">至</span>

	         	<input type="text" id="sEndTime" name="sEndTime" value="{{endDateStr | date:'yyyy-MM-dd'}}" class="form-control">
	         	
	      		 <!-- <span class="input-group-btn padder-l-sm ">
	         		<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
	         	</span> -->

	      		 <span class="input-group-btn padder-l-sm ">
	         		<button class=" btn btn-sm btn-info" ng-click="showLie = !showLie" type="button">自定义显示项</button>
	         	</span>

      		</div>
	    </div>
	</div>

	
	<div class="wrapper-md pt5">
		<div class="col-sm-12  b-a panel border-none" style="overflow: auto;">

			<table class="table table-striped b-t b-light" style="width: auto;min-width: 100%;">

				<thead>
					<tr>
						<th ng-repeat="item in dataNames track by $index" ng-if="item != $index">{{ item }}</th>
					</tr>
				</thead>

				<tbody>
					<tr ng-repeat="outerItem in data">
						<td ng-repeat="item in lieNames track by $index" ng-if="$index != dataNames[$index]">{{ outerItem[keys(item)] }}</td>
					</tr>
				</tbody>

			</table>


		</div>

		<div ng-show="showLie" class="showLie" ng-click="showLie = !showLie" style="">
			<div class="col-sm-12  b-a panel border-none content" ng-click="$event.stopPropagation()" style="">


				<label style="padding-left: 45px;" class="i-checks m-b-none" id="allShow" ng-click="allShow()"> 
                    <input type="checkbox" name="" id="" value="" ng-checked="true">
                    <i></i>
                    <span class="" style="margin: 0;">全选</span>
                </label>

				<ul style="" class="list-inline">
					<li style="" ng-repeat="name in allNames track by $index">
						<label class="i-checks m-b-none" id="" ng-click="setData($index)"> 
		                    <input type="checkbox" name="checkbox" id="" value="" ng-checked="true">
		                    <i></i>
		                    <span class="" style="margin: 0;">{{name}}</span>
		                </label>
					</li>
				</ul>

			</div>
		</div>

	</div>


	
</div>


 <div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>

<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script>
function getDateForStringDate(strDate){
    //切割年月日与时分秒称为数组
    var s = strDate.split(" ");
    var s1 = s[0].split("-");
    var s2

    if (s[1]) {
        s2 = s[1].split(":");
        if(s2.length==2){
            s2.push("00");
        }
    } else {
        s2 = ['00','00','00']
    }
    
    return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
}

app.controller('indexManagementCtrl', function($scope, $http, $state,$stateParams) {

	/**
	 * [获取当前电站信息]
	 * @param  {[type]} currentStationInfo) {		$scope.currentSTID [description]
	 * @return {[type]}                     [description]
	 */
	$scope.getCurrentDataName('00', 0, function (currentStationInfo) {
		$scope.currentSTID = currentStationInfo.currentSTID
		getData()
	})

	/**
	 * [切换电站后，执行]
	 * @param  {[type]} event [description]
	 * @param  {[type]} data) {		电站名  电站 id
	 * @return {[type]}       [description]
	 */
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName
		$scope.currentSTID = data.dataId
		getData()
	})


	$scope.startDateStr = new Date()
	$scope.startDateStr.setDate($scope.startDateStr.getDate() - 1)
	$scope.endDateStr = new Date()

	$scope.keys = function (obj) {
		return Object.keys(obj)[0]
	}

	//日期控件
	$('#sStartTime').datetimepicker({
		format: "yyyy-mm-dd",
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true,
	   	minView : 2,
	   	endDate: $scope.startDateStr
	}).on('hide',function(ev) {
        var stringTime = $("#sStartTime").val();//2016-08-31 14:12:57
        if(stringTime){
            var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
            $scope.startDateStr = new Date(timestamp);
        }
        getData()
    })

	//日期控件
	$('#sEndTime').datetimepicker({
		format: "yyyy-mm-dd",
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true,
	   	minView : 2,
	   	endDate: $scope.endDateStr
	}).on('hide',function(ev) {
        var stringTime = $("#sEndTime").val();//2016-08-31 14:12:57
        if(stringTime){
            var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
            $scope.endDateStr = new Date(timestamp);
        }
        getData()
    })

	$scope.showLie = false;

	$scope.lieNames = [
		{ dTW: '发电量' },
		{ dNetTW: '上网电量' },
		{ dAvgC: '平均温度' },
		{ dRadiation: '总辐射量' },
		{ dThoryTW: '理论电量' },
		{ dhours: '发电时间' },
		{ dThoryHours: '理论利用小时' },
		{ dNetBuyTW: '购网电量' },
		{ dNetSideBuyTW: '网侧侧购网电量' },
		{ dNetSideBuyTWBack: '备用电侧购网电量' },
		{ dFUseTW: '场用电量' },
		{ dFUseTWRatio: '场用电率' },
		{ dComFUseTW: '综合场用电量' },
		{ dComFUseTWRatio: '综合场用电率' },
		{ dDeviceUtilizeRatio: '设备可利用率' },
		{ dStationUtilizeRatio: '电站可利用率' },
		{ ljlkjl: '调峰影响电量' },
		{ dFaultEffectTW: '故障影响电量' },
		{ dMaintainEffectTW: '维护影响电量' },
		{ dInvolvedEffectTW: '受累影响电量' },
		{ dPerformanceDeclineEffectTW: '机组性能下降影响电量' },
		{ ljlkjl: '等效利用小时' },
		{ ljlkjl: '设备故障台数' },
		{ ljlkjl: '设备总数' },
		{ ljlkjl: '故障率' },
		{ ljlkjl: '故障损失小时' },
		{ limitsTW: '限电量' },
		{ limitsTWRatio: '限电比' },
		{ buildCapacity: '装机容量' },
		{ mPlanCompleteRatio: '计划完成率' },
		{ dHorizontalEmittance: '水平面辐射强度' },
		{ dHorizontalDirectEmittance: '水平面直射辐射强度' },
		{ dHorizontalScatterEmittance: '水平面散射辐射强度' },
		{ dBestAngleEmittance: '最佳倾角辐射强度' },
		{ dDeviceAngleEmittance: '设备角度辐射强度' },
		{ dHorizontalRadiation: '水平总辐射量' },
		{ dBestRadiation: '最佳倾角总辐射量' },
		{ dDeviceRadiation: '设备角度辐射强度' },
		{ dPlanRepairLoseTW: '计划检修损失电量' },
		{ dTechRepairLoseTW: '技术改造损失电量' },
		{ dTimerRepairLoseTW: '定检损失电量' },
		{ dTempRepairLoseTW: '临时性计划检修' },
		{ dDeviceFaultLoseTW: '设备故障损失电量' },
		{ dModuleFaultLoseTW: '组件设备故障损失电量' },
		{ dInverterFaultLoseTW: '逆变器设备故障损失电量' },
		{ dJunctionBoxFaultLoseTW: '汇流箱设备故障损失电量' },
		{ dChangeBoxFaultLoseTW: '变电设备故障损失电量' },
		{ dNetInvolvedEffectLoseTW: '电网受累损失电量' },
		{ dWeatherLoseTW: '气候原因损失电量' },
		{ dDeviceRejectionRatio: '设备弃光率' },
		{ dNetRejectionRatio: '电网弃光率' },
		{ dModuleAvgUtilezeRatio: '组串平均可利用率' },
		{ dInverterUtilezeRatio: '逆变器可利用率' },
		{ dStationUtilizeRatio: '电站可利用率' },
		{ dPVModuleAttenuationRatio: '光伏组件衰减率' },
		{ dArrFaultNum: '串均故障次数' },
		{ dArrInvolvedNum: '串均受累次数' },
		{ dInverterAvgFaultNum: '逆变器台均故障次数' },
		{ dModuleADiscreteRate: '组串电流离散率' },
		{ dInverterPowerDiscreteRate: '逆变器功率离散率' },
		{ dLPowerForecastOpRate: '光功率预测投运率' },
		{ dLPowerForecastAccuracyRate: '光功率预测准确率' },
		{ dKWFee: '单位千瓦运行维护费（元）' },
		{ dKWHFee: '度电运行维护费（元）' },
		{ dRepairFee: '检修费用（万元）' },
		{ dMaterialFee: '材料费用（万元）' },
		{ dNoPlanStopNum: '非计划停运次数' },
		{ dNoPlanStopHours: '非计划停运时间' }
	]

	$scope.data = []
	$scope.allNames = $scope.lieNames.map(function (v, i) {
		return v[Object.keys(v)[0]]
	})


	$scope.dataNames = $scope.allNames.slice(0)


	$scope.clicked = false
	$scope.setData = function (index) {
		if (!$scope.clicked) {
			$scope.clicked = true
			return
		}


		if (!$('input[type=checkbox][name=checkbox]').eq(index).prop('checked')) {

			$scope.dataNames.splice(index,1,index)

			$('#allShow').find('[type=checkbox]').prop('checked', false)

		} else if($('input[type=checkbox][name=checkbox]').eq(index).prop('checked')) {

			$scope.dataNames[index] = $scope.allNames[index]

			if ($scope.dataNames.every(function (e, i, arr) {return e == $scope.allNames[i]})) {

				$('#allShow').find('[type=checkbox]').prop('checked', true)
			}
		}


		$scope.clicked = false
	}

	$scope.allShow = function () {

		if (!$scope.clicked) {

			$scope.clicked = true

			return
		}


		if ($('#allShow').find('[type=checkbox]').prop('checked')) {

			$scope.dataNames = $scope.allNames.slice(0)

			$('[name=checkbox]:checkbox').prop('checked', true)

		} else {

			$scope.dataNames = $scope.dataNames.map(function (v, i) {

				return i
			})

			$('[name=checkbox]:checkbox').prop('checked', false)
		}

		$scope.clicked = false
	}

	/**
	 * [getData 发请求取数据]
	 * @return {[type]} [description]
	 */
	function getData() {
		$http({
			method : "GET",
			url : "${ctx}/rpds/selectStationCurrData.htm",
			params: {
				stationId: $scope.currentSTID,
				startDateStr: $scope.startDateStr,
				endDateStr: $scope.endDateStr
			}
		}).success(function(res) {
			$scope.data = res.data
		})
	}
})
</script>