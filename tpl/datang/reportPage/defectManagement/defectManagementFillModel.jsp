<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
.page-con{padding:20px 45px 10px;}
.form-input-con{margin-bottom:10px;}
.form-input-con .label-name{display:block;width:100px;height: 35px;line-height: 35px;}
.form-input-con input{height:35px;line-height:35px;}
.form-input-con input.small-input{width:76%;}
.form-input-con input.big-input{width:100%;    margin-bottom: 8px;}
.form-input-con select.small-select{    width: 76%;height: 35px;}
.form-data-con .add-input-icon{width:26px;height:26px;text-align:center;color:white;font-size:29px;border-radius:50%;background:#1cb09a;display: inline-block;line-height: 26px;margin-right: 10px;}
.form-data-con .add-input-tip{    color: #1cb09a;line-height: 26px;height: 26px;display: inline-block;vertical-align: super;}
.width2-1{width:50%;}
.save-add-workticket{color:white;width:90px;height:45px;line-height:45px;text-align:center;background:#1cb09a;font-size:16px;}
.cancel-add-workticket{width:90px;height:45px;line-height:45px;text-align:center;background:white;border:1px solid #1cb09a;color:#1cb09a;font-size:16px;}
.date-time-con{
    border: 1px solid rgb(177,177,177);
    height: 35px;
    display: inline-block;
    line-height: 32px;
    width: 76%;text-align: left;}
</style>
<div  ng-controller="dtDefectManagementFillModelCtrl" class="background-white page-con">
	<div class="form-data-con">
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">设备类型</label>
					<div class="flex">
						<select  class="small-select" ng-model="formData.deviceType"  ng-options="o.devid as o.devtype for o in deviceTypeList" ng-change="getDeviceName()"></select>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;">
						<label class="label-name" style="right: 78%;position:absolute;text-align: left;">设备名称</label>
						<select  class="small-select" ng-model="deviceItem"  ng-options="deviceItem as deviceItem.name for deviceItem in deviceNameList" ng-change="deviceName(deviceItem)"></select>
					</div>
				</div>
			</div>
		</div>
		<div class="form-input-con h-box font14">
			<label class="label-name">缺陷内容</label>
			<div class="flex"><textarea  name="workTask" style="width: 100%;height: 90px;" ng-model="formData.faultContent" ></textarea></div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">缺陷类型</label>
					<div class="flex">
						<select class="small-select" ng-model="formData.faultType"  ng-options="o.dictValue as o.description for o in FaultTypeList"></select>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">工作票号</label>
					<input type="text" name="inchargePerson" class="small-input" ng-model="formData.workTicketNum"></div>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">停运时间</label>
					<div class="flex">
						<span class="input-append date form_datetime date-time-con" id="changeTimeId-stopTime" data-link-field="stopTime">
							<input type="hidden"  id="stopTime"/>
							<span id="showStopTime" class="showdate m-l m-r  font-h2" ng-bind="formData.stopTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">光照强度</label>
					<input type="text" name="" class="small-input" ng-model="formData.illuminationIntensity"></div>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">消缺时间</label>
					<div class="flex">
						<span class="input-append date form_datetime date-time-con" id="changeTimeId-eleminationTime" data-link-field="eleminationTime">
							<input type="hidden"  id="eleminationTime"/>
							<span id="showEleminationTime" class="showdate m-l m-r  font-h2" ng-bind="formData.deOxygenTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">修复启动时间</label>
					<span class="input-append date form_datetime date-time-con" id="changeTimeId-repairStartUpTime" data-link-field="repairStartUpTime">
						<input type="hidden"  id="repairStartUpTime"/>
						<span id="showRepairStartUpTime" class="showdate m-l m-r  font-h2" ng-bind="formData.repairStartupTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
					</span>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="clearfix ">
				<div class="width2-1 pull-left">
					<div class="form-input-con h-box font14">
						<label class="label-name">消缺时数(分钟)</label>
						<div class="flex"><input type="text" name="" class="small-input" ng-model="formData.deOxygenMinute"></div>
					</div>
				</div>
				<div class="width2-1 pull-left ">
					<div class="form-input-con h-box font14">
						<label class="label-name"></label>
						<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">影响电量</label>
						<input type="text" name="" class="small-input"  ng-model="formData.effectTW"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="form-input-con h-box font14" style="margin: 20px 0 0px;">
			<label class="label-name">处理经过</label>
			<div class="flex"><textarea  name="workTask" style="width: 100%;height: 90px;" ng-model="formData.doProcess" ></textarea></div>
		</div>
		<div class="form-input-con h-box font14" style="margin: 6px 0;">
			<label class="label-name">原因分析</label>
			<div class="flex"><textarea  name="workTask" style="width: 100%;height: 90px;" ng-model="formData.reason" ></textarea></div>
		</div>
		<div class="form-input-con h-box font14" style="margin: 6px 0 20px;">
			<label class="label-name">备注</label>
			<div class="flex"><textarea  name="workTask" style="width: 100%;height: 90px;" ng-model="formData.remark" ></textarea></div>
		</div>
		<div class="clearfix" style="margin-bottom: 15px;"><a class="pull-right cancel-add-workticket" ng-click="cancel()">取消</a><a class="pull-right save-add-workticket" ng-click="saveDefectManage()" style="margin-right:12px;">保存</a></div>
	</div>
</div>
<script>
app.controller('dtDefectManagementFillModelCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('fillItem', function(event,item) {
		$scope.getFaultTypesList();
		$scope.getDeviceType();
        var item = item[0];
		if(item != null){
			$scope.currentId = item.id;
			$scope.initPageData(item);
		}else{
			$scope.currentId = "";
			$scope.formData = {};
		}
	});
	
	function emit(value){
		$scope.$emit("childPage",value);
	};
	
	//查询单条记录数据
	$scope.initPageData = function(item){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdFault/selectById.htm",
	 		params : {
				id : item.id,
				deviceId:item.deviceId,
				deviceType:item.deviceType
			}
		 }).success(function(result) {
			 
			 $scope.formData = result.data;

			 $("#stopTime").val(new Date($scope.formData.stopTime).Format("yyyy-MM-dd hh:mm:ss"));
			 $("#eleminationTime").val(new Date($scope.formData.deOxygenTime).Format("yyyy-MM-dd hh:mm:ss"));
			 $("#repairStartUpTime").val(new Date($scope.formData.repairStartupTime).Format("yyyy-MM-dd hh:mm:ss"));
			 
		 })
	}
	
	$scope.deviceName = function(item){
		$scope.formData.serialNumber = item.serialnumber;
		$scope.formData.deviceId = item.id;
	}
	//保存
	$scope.saveDefectManage = function(){
		var stopTime = $("#stopTime").val();
		var deOxygenTime = $("#eleminationTime").val();
		var repairStartUpTime = $("#repairStartUpTime").val();
		
		$http({
	 		method : "POST",
	 		url : "${ctx}/rpdFault/update.htm",
	 		params : {
	 			id:$scope.currentId,
	 			deviceType : $scope.formData.deviceType,
	 			deviceId:$scope.formData.deviceId,
	 			serialNumber:$scope.formData.serialNumber,
	 			faultContent:$scope.formData.faultContent,
	 			faultType:$scope.formData.faultType,
	 			workTicketNum:$scope.formData.workTicketNum,
	 			stopTime:stopTime,
	 			illuminationIntensity:$scope.formData.illuminationIntensity,
	 			deOxygenTime:deOxygenTime,
	 			repairStartupTime:repairStartUpTime,
	 			deOxygenMinute:$scope.formData.deOxygenMinute,
	 			effectTW:$scope.formData.effectTW,
	 			doProcess:$scope.formData.doProcess,
	 			reason:$scope.formData.reason,
	 			remark:$scope.formData.remark
			}
		 }).success(function(result) {
			 console.log(result);
				if(result.code == 0){
					promptObj('success', '', "保存成功");
					emit("listOrFill");
				}else if(result.code == 1){
					promptObj('error', '',"保存失败");
				}
			 
		 })
	}
	
	//获取设备类型
	$scope.getDeviceType = function(){
        $http({
            method : "POST",
            url :"${ctx}/DeviceStation/getDeviceType.htm"
        }).success(function (msg) {
        	console.log(msg);
            if (msg.key == "0"){
                $scope.deviceTypeList = msg.data;
                
            }
        });
    };
	
    
  //设备查询地址
	var url={
			"url1":"${ctx}/HistoryData/getJunctionBox.htm",
			"url2":"${ctx}/HistoryData/getInverter.htm",
			"url3":"${ctx}/HistoryData/getBoxchange.htm",
			"url4":"${ctx}/HistoryData/getAmmeter.htm",
			"url5":"${ctx}/HistoryData/getAerograph.htm",
	}
    //由设备类型获取设备名称列表
    $scope.getDeviceName = function(){
    	$http({
    		method : "POST",
    		url : url["url"+$scope.formData.deviceType]
    	}).success(function(result) {
    		$scope.deviceNameList = result;
    	})
    }
    
	//获取缺陷类型
	$scope.getFaultTypesList = function(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdFault/selectByFaultTypes.htm",
		 }).success(function(result) {
			 $scope.FaultTypeList = result.data;
		 })
	}
	
	//取消
	$scope.cancel = function(){
		emit("");
	}
	
	var rightDay2 = new Date();
	rightDay2.setDate(rightDay2.getDate() - 1);
	$scope.today = rightDay2;
	
	$scope.stopTime = rightDay2;
	$("#stopTime").val($scope.stopTime.Format("yyyy-MM-dd hh:mm:ss"));
	$scope.eleminationTime = rightDay2;
	$("#eleminationTime").val($scope.eleminationTime.Format("yyyy-MM-dd hh:mm:ss"));
	$scope.repairStartUpTime = rightDay2;
	$("#repairStartUpTime").val($scope.repairStartUpTime.Format("yyyy-MM-dd hh:mm:ss"));
	
	//停运时间
	$("#changeTimeId-stopTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.stopTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeId-stopTime").on('hide',function(ev) {
		var stringTime = $("#stopTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showStopTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});
	
	//消缺时间
	$("#changeTimeId-eleminationTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.eleminationTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeId-eleminationTime").on('hide',function(ev) {
		var stringTime = $("#eleminationTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showEleminationTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});
	
	//修复启动时间
	$("#changeTimeId-repairStartUpTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.repairStartUpTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeId-repairStartUpTime").on('hide',function(ev) {
		var stringTime = $("#repairStartUpTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showRepairStartUpTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});
	
	
	
	//显示隐藏填写要求
	$scope.showFillRequirement = function(){
		$("#requirement-con").toggle();
		$("#require-btn").toggleClass("require-btn-active")
	}
	
	//添加工作任务
	$scope.addWorkTaskInput = function(){
		var html = '<input type="text" name="ticketNum" class="big-input">';
		$("#workTaskList").append(html);
	}
	
	
});
function getDateForStringDate(strDate){
	//切割年月日与时分秒称为数组
	var s = strDate.split(" ");
	var s1 = s[0].split("-");
	var s2 = s[1].split(":");
	if(s2.length==2){
		s2.push("00");
	}
	return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
}
</script>
