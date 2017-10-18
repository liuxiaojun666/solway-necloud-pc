<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div ng-controller="BusDeviceCtrl" class="modal fade" id="addPBuscfgDevice" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg">
  <div class="modal-content ">
   <div class="modal-body col-sm-12 wrapper panel">
   
	<div class="wrapper-md ng-scope hidden">
		<div class="panel panel-default">
			<div class="wrapper">
			
				<!-- form 开始 -->
				<form class=" m-t-lg form-horizontal ng-pristine ng-valid" action="${ctx}/BusCfg/update.htm" method="post" id="busDeviceForm" name="busDeviceForm">
					<input type="hidden" name="id" id="idBus" class="formData" /> 
					<input type="hidden" name="boxChangeIds" value="" id="boxChangeIds" class="formData" /> 
					<input type="hidden" name="inverterIds" value="" id="inverterIds" class="formData" /> 
					<input type="hidden" name="junctionBoxIds" value="" id="junctionBoxIds" class="formData" /> 
					<input type="hidden" name="otherDeviceIds" value="" id="otherDeviceIds" class="formData" /> 
					<div class="form-group">
						<label class="col-lg-1 control-label">电站名称</label>
						<div class="col-lg-5">
							<ui-select ng-model="stationd.selected" theme="bootstrap"
								ng-change="textChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="stationd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices
								repeat="item in station | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input id="pstationidBus" name="pstationid" class="form-control formData">
						</div>
						<label class="col-lg-1 control-label">总线名称</label>
						<div class="col-lg-5">
							<input type="text" id="nameBus" maxlength="50" name="name"  class="form-control formData" >
						</div>
					</div>
					
					
					<div class="form-group">
						<label class="col-lg-1 control-label">总线模式</label>
						<div class="col-lg-5">
	              		<label class="checkbox-inline i-checks ">
	       			 		<input type="radio"  name="passive" checked="checked" id="passive0" value="0"  class="form-control " >  <i></i> 主动
	         		 	</label>
         		 
	         		 	<label class="checkbox-inline i-checks">
	        			 <input type="radio" name="passive"  id="passive1" value="1"  class="form-control ">  <i></i> 被动
	         		 	</label>
	         		 	</div>
						<label class="col-lg-1 control-label">超时时间</label>
						<div class="col-lg-4">
							<input type="text" id="timeoutBus" name="timeout" maxlength="11" class="form-control formData">
						</div>
						<label class="col-lg-1 control-label p-l-n text-left">ms</label>
					</div>
					
					
					<div class="form-group">
						<label class="col-lg-1 control-label">总线分类</label>
	         		 	<div class="col-lg-5">
	              		<label class="checkbox-inline i-checks ">
	       			 		<input type="radio" onclick="changeType(1);" name="type"  checked="checked" id="type1" value="1"  class="form-control " >  <i></i> TCP客户端总线
	         		 	</label>
         		 
	         		 	<label class="checkbox-inline i-checks">
	        			 <input type="radio" onclick="changeType(2);" name="type"  id="type2" value="2"  class="form-control ">  <i></i> TCP服务端总线
	         		 	</label>
	         		 	
	         		 	<label class="checkbox-inline i-checks">
	        			 <input type="radio" onclick="changeType(3);" name="type"  id="type3" value="3"  class="form-control ">  <i></i> 全双工串行总线
	         		 	</label>
	         		 	</div>
						<label class="col-lg-1 control-label">通讯地址</label>
						<div class="col-lg-5">
							<input placeholder="IP:端口号" type="text" id="hostaddrBus" name="hostaddr" maxlength="30" class="form-control formData">
						</div>
					</div>
				</form>
				<!-- form 结束 -->
			</div>
		</div>
	</div>
	<div class="wrapper-md ng-scope">
	<div class="col-sm-12 wrapper panel">
	<div class="form-group col-sm-12">
  		<span class="font-h3 blue-1 m-n text-black">箱变</span>
  	</div>
  	<div class="form-group col-sm-12">
		<div class="col-sm-2 " ng-repeat="device in boxChangeList">
			<input type="checkbox" ng-click="selectBoxChange(device.deviceChk,device.id);" ng-model="device.deviceChk" value="{{device.id}}"/><span ng-bind="device.name"></span>
		</div>
  	</div>
	</div>
   </div>
   
	<div class="wrapper-md ng-scope">
	<div class="col-sm-12 wrapper panel">
	<div class="form-group col-sm-12">
  		<span class="font-h3 blue-1 m-n text-black">逆变器</span>
  	</div>
  	<div class="form-group col-sm-12">
		<div class="col-sm-2 " ng-repeat="device in inverterList">
			<input type="checkbox" ng-click="selectInverter(device.deviceChk,device.id);" ng-model="device.deviceChk" value="{{device.id}}"/><span ng-bind="device.name"></span>
		</div>
  	</div>
	</div>
   </div>
   
   	<div class="wrapper-md ng-scope">
	<div class="col-sm-12 wrapper panel">
	<div class="form-group col-sm-12">
  		<span class="font-h3 blue-1 m-n text-black">汇流箱</span>
  	</div>
  	<div class="form-group col-sm-12">
		<div class="col-sm-2 " ng-repeat="device in junctionBoxList">
			<input type="checkbox" ng-click="selectJunctionBox(device.deviceChk,device.id);" ng-model="device.deviceChk" value="{{device.id}}"/><span ng-bind="device.name"></span>
		</div>
  	</div>
	</div>
   </div>
   
   	<div class="wrapper-md ng-scope">
	<div class="col-sm-12 wrapper panel">
	<div class="form-group col-sm-12">
  		<span class="font-h3 blue-1 m-n text-black">电能表和气象仪</span>
  	</div>
  	<div class="form-group col-sm-12">
		<div class="col-sm-2 " ng-repeat="device in otherDeviceList">
			<input type="checkbox" ng-click="selectOtherDevice(device.deviceChk,device.id);" ng-model="device.deviceChk" value="{{device.id}}"/><span ng-bind="device.name"></span>
		</div>
  	</div>
  	<div class="form-group m-t-sm ">
		<div class="col-lg-12 text-center ">
			<button type="button" onclick="saveBusForm();" id="saveButton" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
			<button id="escCancelBtnDevice" type="button"class=" m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
		</div>
	</div>
	</div>
   </div>   
</div>
</div>
</div>
</div>

<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/array.extend.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/json2.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	$(function() {
		$("#busDeviceForm").validate({
			rules : {
				name : {
					required : true,
					maxlength : 50
				},
				pstationid : {
					required : true,
				},
				type : {
					required : true
				},
// 				passive : {
// 					required : true
// 				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.type == "error"){
							
						}else{
							promptObj(json.type, '',json.message);
							goPage(0);
							$("#escCancelBtnDevice").trigger("click");
						}
					},
					error : function(json) {
						promptObj("error", '',"操作失败,请稍后再试");
						goPage(0);
					}
				};
				$('#busDeviceForm').ajaxSubmit(options);
			}
		});

	});
	function changeType(type){
		if(type==3){
			$("#hostaddr").attr("placeholder","COM1，波特率，数据位，停止位，校验位");
		} else {
			$("#hostaddr").attr("placeholder","IP:端口号");
		}
	}
	var boxChangeIds = [];
	var inverterIds = [];
	var junctionBoxIds = [];
	var otherDeviceIds = [];

	function saveBusForm() {
// 		if($("#file0").val()==""){
// 			$("#file0").attr("disabled","disabled");
// 		}
		if(boxChangeIds!=null&&boxChangeIds.length>0){
			$("#boxChangeIds").val(JSON.stringify(boxChangeIds));
		}
		if(inverterIds!=null&&inverterIds.length>0){
			$("#inverterIds").val(JSON.stringify(inverterIds));
		}
		if(junctionBoxIds!=null&&junctionBoxIds.length>0){
			$("#junctionBoxIds").val(JSON.stringify(junctionBoxIds));
		}
		if(otherDeviceIds!=null&&otherDeviceIds.length>0){
			$("#otherDeviceIds").val(JSON.stringify(otherDeviceIds));
		}
		$("#busDeviceForm").trigger("submit");
	}
	
	function getDateToMs(date) {
		Todate = date.replace(new RegExp("-", "gm"), "/");
		var TimeMs = new Date(Todate).getTime();
		return TimeMs;
	}

	//初始化页面数据
	function initPageDeviceData(id) {
		$(".formData").val("");
		$("#timeout").val(5000);
		if (id != "" && id != null) {
			$("#idBus").val(id);
			$.ajax({
				type : "post",
				url : "${ctx}/BusCfg/selectById.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					$("#nameBus").val(msg.name);
					$("#pstationidBus").val(msg.pstationid);
					$("#hostaddrBus").val(msg.hostaddr);
					$("#timeoutBus").val(msg.timeout);
					
					var passive=msg.passive;
					var passivelen=document.busDeviceForm.passive.length;
					for(var a=0;a<passivelen;a++){
						if(passive==document.busDeviceForm.passive[a].value){
			                document.busDeviceForm.passive[a].checked=true
			            }
					}
					
					var type=msg.type;
					var typelen=document.busDeviceForm.type.length;
					for(var i=0;i<typelen;i++){
						if(type==document.busDeviceForm.type[i].value){
			                document.busDeviceForm.type[i].checked=true
			            }	
					}
					getStationList();
				}
			});
		}else{
			getStationList();
		}
	}

	
	
var getStationList = null;
app.controller('BusDeviceCtrl',['$http','$scope','$stateParams','$state',
							function($http, $scope, $stateParams, $state) {
								$scope.stationd = {};
								$scope.station = null;
								$scope.factd = {};
								$scope.fact = null;
								getStationList = $scope.getStationList = function() {
									$http({method : "POST",
												url : "${ctx}/PowerStation/selectByParentId.htm",
												params : {}
											}).success(function(result) {
														$scope.station = result;
														if(result.length>0){
															$scope.station.unshift({id:"",stationname:'请选择'});
															$scope.stationd.selected = {stationname : $scope.station[0].stationname,id : $scope.station[0].stationname.id};
														}
															
														if ($("#pstationidBus").val() != null && $("#pstationidBus").val() != "") {
															for (var i = 0, len = $scope.station.length; i < len; i++) {
																if ($scope.station[i].id == $("#pstationidBus").val()) {
																	$scope.stationd.selected = {stationname : $scope.station[i].stationname,id : $("#pstationidBus").val()};
																	$scope.getBoxChangeList($scope.station[i].id);
																	$scope.getInverterList($scope.station[i].id);
																	$scope.getJunctionBoxList($scope.station[i].id);
																	$scope.getOtherDeviceList($scope.station[i].id);
																}
															}
														} 
													});
								}
								//$scope.getStationList();
								$scope.textChange = function() {
									a = angular.copy($scope.stationd.selected.id);
									$("#pstationidBus").val(a);
									$scope.getBoxChangeList(a);
									$scope.getInverterList(a);
									$scope.getJunctionBoxList(a);
									$scope.getOtherDeviceList(a);
								}
								
								//initPageData($stateParams.InId);
								
								//返回list
								$scope.backpbuscfg = function() {
									$state.go('app.pbuscfg');
								}

								$scope.selectBoxChange = function(chk,deviceId){
									var index = boxChangeIds.indexOf(deviceId);
									if(chk&&index<0){
										boxChangeIds.push(deviceId);
									} else if((!chk)&&index>=0){
										boxChangeIds.remove(index);
									}
								}
								$scope.selectInverter = function(chk,deviceId){
									var index = inverterIds.indexOf(deviceId);
									if(chk&&index<0){
										inverterIds.push(deviceId);
									} else if((!chk)&&index>=0){
										inverterIds.remove(index);
									}
								}
								$scope.selectJunctionBox = function(chk,deviceId){
									var index = junctionBoxIds.indexOf(deviceId);
									if(chk&&index<0){
										junctionBoxIds.push(deviceId);
									} else if((!chk)&&index>=0){
										junctionBoxIds.remove(index);
									}
								}
								$scope.selectOtherDevice = function(chk,deviceId){
									var index = otherDeviceIds.indexOf(deviceId);
									if(chk&&index<0){
										otherDeviceIds.push(deviceId);
									} else if((!chk)&&index>=0){
										otherDeviceIds.remove(index);
									}
								}
								//箱变
								$scope.getBoxChangeList = function(stationId){
									boxChangeIds = [];
									var busId = $("#idBus").val();
									if(!busId){
										busId=-1;
									}
									$http({
										method : "POST",
										url : "${ctx}/BoxChange/selectByStation.htm",
										params : {
											'pstationid': stationId
											,'busidOrNull':busId
										}
									}).success(function(result) {
										if(result!=null&&result.length>0&&$("#idBus").val()){
											for(var i=0;i<result.length;i++){
												if($("#idBus").val()==result[i].busid){
													boxChangeIds.push(result[i].id);
													result[i].deviceChk = true;
												}
											}	
										}
										$scope.boxChangeList = result;
									}).error(function(response){
										
									});
								}
								//逆变器
								$scope.getInverterList = function(stationId){
									inverterIds = [];
									var busId = $("#idBus").val();
									if(!busId){
										busId=-1;
									}
									$http({
										method : "POST",
										url : "${ctx}/Inverter/selectByStation.htm",
										params : {
											'pstationid': stationId
											,'busidOrNull':busId
										}
									}).success(function(result) {
										if(result!=null&&result.length>0&&$("#idBus").val()){
											for(var i=0;i<result.length;i++){
												if($("#idBus").val()==result[i].busid){
													inverterIds.push(result[i].id);
													result[i].deviceChk = true;
												}
											}	
										}
										$scope.inverterList = result;
									}).error(function(response){
										
									});
								}
								//汇流箱
								$scope.getJunctionBoxList = function(stationId){
									junctionBoxIds = [];
									var busId = $("#idBus").val();
									if(!busId){
										busId=-1;
									}
									$http({
										method : "POST",
										url : "${ctx}/JunctionBox/selectByStation.htm",
										params : {
											'pstationid': stationId
											,'busidOrNull':busId
										}
									}).success(function(result) {
										if(result!=null&&result.length>0&&$("#idBus").val()){
											for(var i=0;i<result.length;i++){
												if($("#idBus").val()==result[i].busid){
													junctionBoxIds.push(result[i].id);
													result[i].deviceChk = true;
												}
											}	
										}
										$scope.junctionBoxList = result;
									}).error(function(response){
										
									});
								}
								//其他设备(电能表和气象站)
								$scope.getOtherDeviceList = function(stationId){
									otherDeviceIds = [];
									var busId = $("#idBus").val();
									if(!busId){
										busId=-1;
									}
									$http({
										method : "POST",
										url : "${ctx}/OtherDevice/selectByStation.htm",
										params : {
											'pstationid': stationId
											,'busidOrNull':busId
										}
									}).success(function(result) {
										if(result!=null&&result.length>0&&$("#idBus").val()){
											for(var i=0;i<result.length;i++){
												if($("#idBus").val()==result[i].busid){
													otherDeviceIds.push(result[i].id);
													result[i].deviceChk = true;
												}
											}	
										}
										$scope.otherDeviceList = result;
									}).error(function(response){
										
									});
								}
								
								}]);
	
	
</script>

