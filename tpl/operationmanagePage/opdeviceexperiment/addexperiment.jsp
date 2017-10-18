<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#editForm").validate({
			rules : {
				experifact : {
					maxlength : 50
				},
				expericontent : {
					required : true,
					maxlength : 50
				},

				operator : {
					required : true,
					maxlength : 40
				},
				experidate:{
					required : true,
				},
				experiresult : {
					maxlength : 500
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success', '', json.message);
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
	});
	
	//提交方法
	function saveForm() {
		$("#editForm").trigger("submit");
	}
	
	$(function() {
		$('#experidate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		   	autoclose: true
		});
	});
	
	//初始化页面数据
	function initPageData(id) {
		$(".formData").val("");
		$("#devicetype").val("0").change();
		if (id != "" && id != null) {
			$("#id").val(id);
			$.ajax({
				type : "post",
				url : "${ctx}/Experiment/selectById.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					$("#pstationid").val(msg.pstationid);
					$("#pstationname").val(msg.pstationname);
					$("#deviceid").val(msg.deviceid);
					$("#devicename").val(msg.devicename);
					$("#experifact").val(msg.experifact);
					$("#experiresult").val(msg.experiresult);
					$("#operator").val(msg.operator);
					$("#expericontent").val(msg.expericontent);
					$("#experidate").val(new Date(msg.experidate).Format("yyyy-MM-dd"));
					$("#devicetype").val(msg.devicetype).change(); 
					var status= msg.status;
					//radio 选中处理
					if (status) {
						var ridaolen = document.editForm.status.length;
						for (var i = 0; i < ridaolen; i++) {
							if (status == document.editForm.status[i].value) {
								document.editForm.status[i].checked = true;
							}
						}
					}
				}
			});
		} 
	}
	
	//设备查询地址	
	var url={
			"url0":"null",
			"url1":"${ctx}/HistoryData/getJunctionBox.htm",
			"url2":"${ctx}/HistoryData/getInverter.htm",
			"url3":"${ctx}/HistoryData/getBoxchange.htm",
			"url4":"${ctx}/HistoryData/getAmmeter.htm",
			"url5":"${ctx}/HistoryData/getAerograph.htm",
	}
	
	//下拉查询电站
	var getManufacturer;
	var deviceNamevalue;
	app.controller('BoxChangeCtrl',['$http','$location','$rootScope','$scope','$state','$stateParams',
							function($http, $location, $rootScope, $scope, $state,$stateParams) {
// 电站下拉查询-------------------------------Start------------------------------------------------------								
								$scope.stationd = {};
								$scope.station = null;
								$http({
									method : "POST",
									url : "${ctx}/PowerStation/selectAll.htm",
									params : {
// 										id : $("#id").val()
									}
								})
										.success(
												function(result) {
													$scope.station = result;
// 													if ($scope.station != null&& $scope.station.length > 0) {
// 														$scope.station.unshift({id : "",stationname : '请选择'});
// 													}
													
													if ($("#pstationid").val() != null&& $("#pstationid").val() != "") {
														for (var i = 0, len = $scope.station.length; i < len; i++) {
															if ($scope.station[i].id == $("#pstationid").val()) {
																$scope.stationd.selected = {
																	stationname : $scope.station[i].stationname,
																	id : $("#pstationid").val()
																};
															}
														}
													} else {
														$scope.stationd.selected = {
															stationname : $scope.station[0].stationname,
															id : $scope.station[0].id
														};
													}
													//选择框变化触发
													$scope.textChange = function() {
														$("#pstationid").val(angular.copy($scope.stationd.selected.id));
														$("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
													}
														$scope.textChange();
												});

							
     //根据设备名称查询厂商-----------------------Start----------------------------------
							$scope.manufacturerd = {};
							$scope.manufacturer = null;
							$scope.productd = {};
							$scope.product = null;
							getManufacturer=$scope.getManufacturer=function(id){
								$http({
									method : "POST",
									url : "${ctx}/Manufacturer/selectAll.htm",
									params : {
											devicetype: id
											}
								})
										.success(
												function(result) {
													$scope.manufacturer = result;
													if ($("#manufid").val() != null
															&& $("#manufid")
																	.val() != "") {
														for (var i = 0, len = $scope.manufacturer.length; i < len; i++) {
															if ($scope.manufacturer[i].id == $(
																	"#manufid")
																	.val()) {
																$scope.manufacturerd.selected = {
																	manufname : $scope.manufacturer[i].manufname,
																	id : $(
																			"#manufid")
																			.val()
																};
															}
														}
													}
													
													$scope.manufChange = function() {
														a = angular
																.copy($scope.manufacturerd.selected.id);
														$("#manufid").val(a);

														$scope.productd.selected = {
															productname : null,
															id : null
														};
														$http(
																{
																	method : "POST",
																	url : "${ctx}/Product/selectByManuf.htm",
																	params : {
																		manufid : a
																	}
																})
																.success(
																		function(
																				resultproduct) {
																			$scope.product = resultproduct;
																			for (var i = 0, len = $scope.product.length; i < len; i++) {
																				if ($scope.product[i].id == $(
																						"#productid")
																						.val()) {
																					$scope.productd.selected = {
																						productname : $scope.product[i].productname,
																						id : $(
																								"#productid")
																								.val()
																					};
																				}
																			}
																			$scope.productChange = function() {
																				b = angular
																						.copy($scope.productd.selected.id);
																				$(
																						"#productid")
																						.val(
																								b);
																			}
																		});
													}
													if ($("#manufid").val() != null
															&& $("#manufid")
																	.val() != "") {
														$scope.manufChange();
													}
												});
							} 
// 							initPageData($stateParams.InId);
							$scope.backInverter = function() {
								$state.go('app.opdeviceExperiment');
								}
			
	//监督人查询---------------------------Start-----------------------------------
			$scope.managerd = {};
		    	$scope.manager = null;
				$http({method:"POST",url:"${ctx}/AdminUser/selectAll.htm",params:{}})
				.success(function (result) {
			    	 $scope.manager = result;
			    	 if( $scope.manager.length>0){
			    		 $scope.manager.unshift({userId:"",realName:'请选择'});
			    	 }
			    	 for(var i=0,len=$scope.manager.length;i<len;i++){
		 					if($scope.manager[i].userId==  $("#managerid").val()){
		 						$scope.managerd.selected= { realName: $scope.manager[i].realName,userId:  $("#managerid").val()};
		 					}
		 				}
			    	 $scope.managerChange= function () {
				         $("#managerid").val(angular.copy($scope.managerd.selected.userId));
					} 
				}); 	
	
 //根据设备类型查询设备---------------------------Start------------------------------------------------				
				$scope.deviced = {};
				$scope.device = null;
				selectDevice = $scope.selectDevice = function(type){
// 					$("#devicetype").val(type);
					$scope.deviceType=type;	
					$http({
						method : "POST",
						url : url["url"+type],
						params : {
						pstationid: $("#pstationid").val(),
					},
					}).success(function(result) {
						$scope.device = result;
						if($scope.device.length>0){
							 	$scope.device.unshift({id:"",name:'请选择'});
								for(var i=0;i<$scope.device.length;i++){
									if($("#deviceid").val() == $scope.device[i].id){
										$scope.deviced.selected= { name: $scope.device[i].name,id: $scope.device[i].id};
										break;
									}
								}
							} else {
								$scope.deviced.selected= {name: $scope.device[0].name,id: $scope.device[0].id};
						}
					})
				};			
				
				$scope.deviceChange=function(){
					$("#deviceid").val(angular.copy($scope.deviced.selected.id));
					$("#devicename").val(angular.copy($scope.deviced.selected.name));
				}
	//初始化数据及调回List页面----------------------------Start------------------------------------------
					initPageData($stateParams.InId);
					$scope.backInverter = function() {
					$state.go('app.opdeviceExperiment');
									}
					}
				]);

</script>

	<div ng-controller="BoxChangeCtrl">
		<div class="wrapper-md bg-light b-b">
			<span class="font-h4 blue-1 m-n text-black">设备监督信息</span>
		</div>
		<div class="wrapper-md ng-scope">
			<div class="panel panel-default">
				<div class="row wrapper">

					<!-- form 开始 -->
					<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid"
						action="${ctx}/Experiment/update.htm" method="post" id="editForm"
						name="editForm">
						<input type="hidden" name="id" id="id" class="formData" />
						<div class="form-group">
								 <label
								class="col-lg-2 control-label">电站名称</label>
							<div class="col-sm-3">
								<ui-select ng-model="stationd.selected" theme="bootstrap"
									ng-change="textChange()"> <ui-select-match
									placeholder="请输入关键字..."
									ng-model="stationd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
								<ui-select-choices
									repeat="item in station | filter: $select.search">
								<div ng-bind-html="item.stationname | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
								<input type="hidden" id="pstationname" name="pstationname" class="form-control formData">
							</div>
							
						</div>	
						
						<div class="form-group">
							<label class="col-lg-2 control-label">设备类型</label>
							<div class="col-sm-3 " id="userType_Div">
<!-- 							<input type="hidden"  name="devicetype" id="devicetype"> -->
								   <select id="devicetype" name="devicetype" class="form-control formData" onchange="selectDevice(this.value);" id="deviceType" >
					                <option value="0">请选择</option>
					                <option value="3">箱变</option>
					                <option value="2">逆变器</option>
					                <option value="1">汇流箱</option>
					                <option value="5">气象仪</option>
					                <option value="4">电能表</option>
					                </select>
							</div>
							
							<label class="col-lg-2 control-label">设备名称</label>
							 <div class="col-sm-3 ">
				              	<ui-select ng-model="deviced.selected" theme="bootstrap" ng-change="deviceChange()">
					            <ui-select-match  placeholder="请选择设备..." ng-model="deviced.selected.name" >{{$select.selected.name}}</ui-select-match>
					            <ui-select-choices  repeat="item in device | filter: $select.search">
					              <div ng-bind-html="item.name | highlight: $select.search"></div>
					            </ui-select-choices>
					         	 </ui-select> 
			                	<input type="hidden" id="deviceid" name="deviceid" class="form-control formData">
			                	<input type="hidden" id="devicename"  name="devicename" class="form-control formData">
			              </div> 
							
						</div>

					<div class="form-group">
		              <label class="col-lg-2 control-label">监督厂商</label>
		              	<div class="col-lg-3">
		                	<input type="text" id="experifact" maxlength="50" name="experifact" placeholder="请输入监督厂商名称..." class="form-control ">
		               </div>
		               
		               	<label class="col-lg-2 control-label">监督项目</label>
							<div class="col-lg-3">
								<input type="text" id="expericontent" maxlength="50" name="expericontent" placeholder="请输入监督项目..."
									class="form-control formData">
							</div>
                   </div>  

						<div class="form-group">
							<label class="col-lg-2 control-label">监督执行人</label>
		             	 		<div class="col-lg-3">
		                			<input type="text" id="operator" maxlength="40" name="operator" placeholder="请输入监督人姓名..." class="form-control">
		               			</div>  
							<label class="col-lg-2 control-label">监督时间</label>
							<div class="col-lg-3">
								<input type="text" id="experidate" name="experidate" placeholder="请选择监督时间..."
									class="form-control formData">
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 control-label">状态</label>
							<div id="userType_Div" class="col-lg-3">
								<label class="checkbox-inline i-checks"> <input
									type="radio" class="form-control" value="00" id="status00"
									name="status"> <i></i> 临时
								</label> <label class="checkbox-inline i-checks"> <input
									type="radio" class="form-control " value="01" id="status01"
									name="status"> <i></i> 正式
								</label> <label class="checkbox-inline i-checks"> <input
									type="radio" class="form-control " value="02" id="status02"
									name="status"> <i></i> 作废
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 control-label">实验结果</label>
							<div class="col-lg-8">
								<textarea rows="4" maxlength="500" name="experiresult" id="experiresult"
									class="form-control formData"></textarea>
							</div>
						</div>

						<div class="form-group m-t-lg">
							<div class="col-lg-12 text-center ">
								<button type="button" onclick="saveForm();" id="saveButton" class=" btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
								<button id="cancelBtn" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" ng-click="backInverter();"><strong>取消</strong></button>
							</div>
						</div>

					</form>
					<!-- form 结束 -->
				</div>
			</div>
		</div>
	</div>
