<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	$(function() {
		$("#editForm").validate({
			rules : {
				code : {
					number : true,
					required : true,
					maxlength : 50
				},
				cycle : {
					digits : true
				},
				timeout : {
					digits : true
				},
				name : {
					required : true,
					maxlength : 20
				},
				pstationid : {
					maxlength : 11
				},
				factid : {
					maxlength : 11
				},
				inverterid : {
					required : true,
					maxlength : 11
				},
				address : {
					maxlength : 50
				},
				standardoper : {
					maxlength : 20
				},
				manufid : {
					maxlength : 11
				},
				productid : {
					maxlength : 11
				},
				mainparameter : {
					maxlength : 20
				},
				batterypower : {
					decimal : true,
				// maxlength : 14
				},
				batterycount : {
					number : true
				},
				averagev: {
					number : true,
					maxlength : 10
				},
				deviationrange: {
					number : true,
					maxlength : 10
				},
				maskcode:{
					number : true,
					maxlength : 20
				},
				batterygcount : {
					number : true
				},
				batteryprodparameter : {
					maxlength : 20
				},
				checkstartdate : {
					dateVerify:true
				},
				checkenddate : {
					dateVerify:true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.message == "Nunique") {
							$("#showhint").removeClass('hidden');
						}else if(json.message == "Usuccess"){
							promptObj('success', '',"更新成功");
							$("#cancelBtn").trigger("click");
						}else{
							promptObj('success', '',"保存成功");
							$("#cancelBtn").trigger("click");
						} 
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
		// 		app.controller('JunctionBoxAddCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
		// 			initPageData($stateParams.JbId);  
		// 			$scope.backJunctionBox = function(){
		// 				$state.go('app.junctionBox');
		// 			}
		// 		}]);
	});

	function saveFormJunction() {
		var beginDate = $("#begindate").val();
		var endDate = $("#enddate").val();
		if (beginDate && endDate) {
			if (getDateToMs(beginDate) > getDateToMs(endDate)) {
				promptObj('error', '', "停用时间不小于安装时间");
				return false;
			} else {
				$("#editForm").trigger("submit");
			}
		} else {
			$("#editForm").trigger("submit");
		}
	}

	function getDateToMs(date) {
		Todate = date.replace(new RegExp("-", "gm"), "/");
		var TimeMs = new Date(Todate).getTime();
		return TimeMs;
	}

	//日期控件 
	$('#begindate')
			.datetimepicker({
				format : "yyyy-mm-dd",
				minView : 2,
				endDate : new Date(),
				language : 'zh-CN',
				todayHighlight : true,
				todayBtn : true,
				autoclose : true
			})
			.on(
					'changeDate',
					function(ev) {
						$('#enddate').datetimepicker('setStartDate', ev.date);
						if ($('#enddate').val()
								&& ev.date.getTime() > getDateToMs($("#enddate")
										.val())) {
							$("#enddate").val(ev.date.Format("yyyy-MM-dd"));
							$('#enddate').datetimepicker('setStartDate',
									ev.date).datetimepicker('update')
									.datetimepicker('show');
						}
					});

	//日期控件
	$('#enddate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		startDate : new Date(),
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});

	
	//时间验证 格式:xx:xx
	jQuery.validator.addMethod("dateVerify", function(value, element) {
		var  pattern = /^([01]\d|2[01234]):([0-5]\d|60)$/;
		return this.optional(element) || ((pattern.test(value)) && (value.substring(0,2)<24));
	 },"请输入正确时间格式 如: 09:00");
	
	//初始化预警阀值数据
	function initThresholdData(id){
		$("#deviceid").val(id);
		if(id != "" && id != null){
			 $.ajax({
				type:"post",
				url:"${ctx}/Threshold/selectByDeviceId.htm",
				data:{"deviceid":id},
				success:function(result){
					$("#thresholdId").val(result.id);
					if(result.checkstartdate){
						$("#checkstartdate").val(result.checkstartdate);	
					}
					if(result.checkstartdate){
						$("#checkenddate").val(result.checkenddate);
					}
					$("#averagev").val(result.averagev);
					$("#deviationrange").val(result.deviationrange);
					$("#maskcode").val(result.maskcode);
				}
			});
		}
	}
	
	//初始化页面数据
	function initPageData(id) {
		$(".formData").val("");
		initThresholdData(id);
		if (id != "" && id != null) {
			$("#id").val(id);
			$
					.ajax({
						type : "post",
						url : "${ctx}/JunctionBox/selectById.htm",
						data : {
							"id" : id
						},
						success : function(msg) {
							$("#code").val(msg.code);
							$("#devicename").val(msg.name);
							$("#name").val(msg.name);
							$("#pstationid").val(msg.pstationid);
							$("#factid").val(msg.factid);
							$("#inverterid").val(msg.inverterid);
							$("#address").val(msg.address);
							$("#manufid").val(msg.manufid);
							$("#productid").val(msg.productid);
							$("#mainparameter").val(msg.mainparameter);
							$("#status").val(msg.status);
							$("#standardoper").val(msg.standardoper);
							$("#batterypower").val(msg.batterypower);
							$("#batterycount").val(msg.batterycount);
							$("#batterygcount").val(msg.batterygcount);
							$("#materialtype").val(msg.materialtype);
							$("#batterymanufid").val(msg.batterymanufid);
							$("#batteryprodid").val(msg.batteryprodid);
							$("#batteryprodparameter").val(
									msg.batteryprodparameter);
							$("#serialnumber").val(msg.serialnumber);
							$("#hostaddr").val(msg.hostaddr);
							$("#busid").val(msg.busid);
							$("#protocolid").val(msg.protocolid);
							$("#cycle").val(msg.cycle);
							$("#timeout").val(msg.timeout);
							if (msg.begindate) {
								$("#begindate").val(
										dateFormat(new Date(msg.begindate)));
							}
							if (msg.enddate) {
								$("#enddate").val(
										dateFormat(new Date(msg.enddate)));
							}
							var materialtype = msg.materialtype
							var ridaoleng = document.editForm.materialtype.length;
							for (var i = 0; i < ridaoleng; i++) {
								if (materialtype == document.editForm.materialtype[i].value) {
									document.editForm.materialtype[i].checked = true
								}
							}
							getStation();
							getSelected(id);
						}
					});
		} else {
			getStation();
			getSelected(null);
		}
	}

	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd");
		return time;
	}

	function getStation() {
		$.ajax({
			type : "post",
			url : "${ctx}/Login/getLoginUser.htm",
			dataType : "json",
			async : false,
			success : function(uerstation) {
				if (uerstation.dataScope != "1"
						&& uerstation.pstationid != null) {
					$("#pstationid").val(uerstation.pstationid);
				}
			}
		});
	}
	var getInverterList = null, getManufactureList = null, getProductList = null;
	function getSelected(id) {
		if (getInverterList != null) {
			getInverterList();
		}
		if (getManufactureList != null) {
			getManufactureList(1);
			getManufactureList(7);
		}
	}
	app
			.controller(
					'JunctionBoxAddCtrl',
					[
							'$http',
							'$location',
							'$rootScope',
							'$scope',
							'$state',
							'$stateParams',
							function($http, $location, $rootScope, $scope,
									$state, $stateParams) {
								$scope.inverterd = {};
								$scope.inverter = null;
								$scope.inverterChange = function() {
									$("#inverterid")
											.val(
													angular
															.copy($scope.inverterd.selected.id));
									$("#factid")
											.val(
													angular
															.copy($scope.inverterd.selected.factid));
									$("#pstationid")
											.val(
													angular
															.copy($scope.inverterd.selected.pstationid));
									$scope.getBusCfgList($scope.inverterd.selected.pstationid);
								}
								getInverterList = $scope.getInverterList = function() {
									$scope.inverterd.selected = {
										name : null,
										id : null,
										pstationid : null,
										factid : null
									};
									$scope.inverter = null;
									$http(
											{
												method : "POST",
												url : "${ctx}/Inverter/selectByStation.htm",
												params : {
													pstationid : $(
															"#pstationid")
															.val()
												}
											})
											.success(
													function(result) {
														$scope.inverter = result;
// 														if (inverter) {//入口为逆变器时，所属逆变器默认选中
// 															$("#inverterid")
// 																	.val(
// 																			inverter);
// 														}
														for (var i = 0, len = $scope.inverter.length; i < len; i++) {
															if ($scope.inverter[i].id == $(
																	"#inverterid")
																	.val()) {
																$scope.inverterd.selected = {
																	name : $scope.inverter[i].name,
																	id : $(
																			"#inverterid")
																			.val(),
																	pstationid : $scope.inverter[i].pstationid,
																	factid : $scope.inverter[i].factid
																};
																$scope
																		.inverterChange();
															}
														}
													});
								}
								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.batterymanufacturerd = {};
								$scope.manufacturer = null;
								$scope.batterymanufacturer = null;
								$scope.productd = {};
								$scope.batteryproductd = {};
								$scope.product = null;

								$scope.manufChange = function(type) {
									if(type==1){
									$("#manufid").val($scope.manufacturerd.selected.id);
									$scope.getProductList(type);
									}else if(type==7){
									$("#batterymanufid").val($scope.batterymanufacturerd.selected.id);
									$scope.getProductList(type);
									}
								}
								getManufactureList = $scope.getManufactureList = function(type) {
									$scope.manufacturer = null;
									$scope.batterymanufacturer = null;
									$scope.manufacturerd.selected = {
										manufname : null,
										id : null
									};
									$scope.product = null;
									$scope.productd.selected = {
										productname : null,
										id : null
									};
									$http(
											{
												method : "POST",
												url : "${ctx}/Manufacturer/selectAll.htm",
												params : {
													devicetype: type
												}
											})
											.success(
													function(result) {
														if(type==1){
														$scope.manufacturer = result;
														if ($scope.manufacturer != null
																&& $scope.manufacturer.length > 0) {
															$scope.manufacturer.unshift({id : "",manufname : '请选择'});
														}
														if ($("#manufid").val() != null
																&& $("#manufid").val() != "") {
															for (var i = 0, len = $scope.manufacturer.length; i < len; i++) {
																if ($scope.manufacturer[i].id == $("#manufid").val()) {
																	$scope.manufacturerd.selected = {
																		manufname : $scope.manufacturer[i].manufname,id : $("#manufid").val()
																	};
																}
															}
															$scope.manufChange(type);
														} else {
															$scope.manufacturerd.selected = {
																manufname : $scope.manufacturer[0].manufname,
																id : $scope.manufacturer[0].id
															};
														}
														}else if(type==7){
															$scope.batterymanufacturer = result;
															if ($scope.batterymanufacturer != null && $scope.batterymanufacturer.length > 0) {
																$scope.batterymanufacturer.unshift({id : "",manufname : '请选择'});
															}
															
															if ($("#batterymanufid").val() != null && $("#batterymanufid").val() != "") {
																for (var i = 0, len = $scope.batterymanufacturer.length; i < len; i++) {
																	if ($scope.batterymanufacturer[i].id == $("#batterymanufid").val()) {
																		$scope.batterymanufacturerd.selected = {
																			manufname : $scope.batterymanufacturer[i].manufname,id : $("#batterymanufid").val()
																		};
																	}
																}
																$scope.manufChange(type);
															} else {
																$scope.batterymanufacturerd.selected = {manufname : $scope.batterymanufacturer[0].manufname,
																	id : $scope.batterymanufacturer[0].id
																};
															}
														}
													});
								}
								
								
								
								$scope.productChange = function(type) {
									if(type==1){
									$("#productid").val($scope.productd.selected.id);
									$scope.getProtocolCfgList($scope.productd.selected.id);
									}else if(type==7){
									$("#batteryprodid").val($scope.batteryproductd.selected.id);	
										}
									}
								getProductList = $scope.getProductList = function(type) {
									if(type==1){
										$scope.manufid=$scope.manufacturerd.selected.id
									}else if(type==7){
										$scope.manufid=$scope.batterymanufacturerd.selected.id
									}
									$scope.product = null;
									$scope.productd.selected = {productname : null,id : null};
									$http(
											{
												method : "POST",
												url : "${ctx}/Product/selectByManuf.htm",
												params : {
													manufid : $scope.manufid,
													devicetype: type
												}
											})
											.success(
													function(resultproduct) {
														if(type==1){
														$scope.product = resultproduct;
														if ($scope.product != null && $scope.product.length > 0) {
															$scope.product.unshift({id : null,productname : '请选择'});
														}
														
														var clearProductFlag = true;
														if ($("#productid").val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $("#productid").val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {productname : $scope.product[i].productname,
																		specification : $scope.product[i].specification,
																		id : $("#productid").val()
																	};
																	$scope.getProtocolCfgList($scope.productd.selected.id);
																}
															}
															if (clearProductFlag) {
																$scope.productd.selected = {
																	productname : $scope.product[0].productname,
																	specification : $scope.product[0].specification,
																	id : $scope.product[0].id
																};
																$("#productid").val($scope.productd.selected.id);
																$scope.getProtocolCfgList($scope.productd.selected.id);
															}
														} else {
															$scope.productd.selected = {
																productname : $scope.product[0].productname,
																specification : $scope.product[0].specification,
																id : $scope.product[0].id
															};
															$scope.getProtocolCfgList($scope.productd.selected.id);
														}
														}else if(type==7){
															$scope.batteryproduct = resultproduct;
															if ($scope.batteryproduct != null && $scope.batteryproduct.length > 0) {
																$scope.batteryproduct.unshift({id : null,productname : '请选择'});
															}
															
															var clearProductFlag = true;
															if ($("#batteryprodid").val()) {
																for (var i = 0, len = $scope.batteryproduct.length; i < len; i++) {
																	if ($scope.batteryproduct[i].id == $("#batteryprodid").val()) {
																		clearProductFlag = false;
																		$scope.batteryproductd.selected = {productname : $scope.batteryproduct[i].productname,
																			specification : $scope.batteryproduct[i].specification,id : $("#batteryprodid").val()};
																	}
																}
																if (clearProductFlag) {
																	$scope.batteryproductd.selected = {productname : $scope.batteryproduct[0].productname,
																		specification : $scope.batteryproduct[0].specification,id : $scope.batteryproduct[0].id
																	};
																	$("#batteryprodid").val($scope.batteryproduct[0].id);
																}
															} else {
																$scope.batteryproductd.selected = {
																	productname : $scope.batteryproduct[0].productname,
																	specification : $scope.batteryproduct[0].specification,
																	id : $scope.batteryproduct[0].id
																};
															}
														}
													});
									}
								//所属厂商、产品---------------------------end----------------------------------
								$scope.busd={selected:{name : null,id : null}};
								$scope.bus = null;
								$scope.getBusCfgList = function(stationId){
									$http({
											method : "POST",
											url : "${ctx}/BusCfg/selectAll.htm",
											params : {pstationid:stationId}
										}).success(function(result) {
											$scope.bus = result;
											var clearBusFlag = true;
											if ($("#busid").val()) {
												for (var i = 0; i< $scope.bus.length;i++) {
													if ($scope.bus[i].id == $("#busid").val()) {
														clearBusFlag = false;
														$scope.busd.selected = {
															name : $scope.bus[i].name,
															id : $scope.bus[i].id
														};
													}
												}
											}
											if(clearBusFlag){
												$("#busid").val(null);
											}
											$scope.busChange = function(){
												$("#busid").val($scope.busd.selected.id);
											}
										});
								}
								$scope.protocold={selected :{name : null,id : null}};
								$scope.protocol = null;
								$scope.getProtocolCfgList = function(productId){
									if(!productId){
										$scope.protocol = null;
										$scope.protocold={selected :{name : null,id : null}};
										return false;
									}
									$http({
											method : "POST",
											url : "${ctx}/Protocol/selectAll.htm",
											params : {productid:productId}
										}).success(function(result) {
											$scope.protocol = result;
											var clearProtocolFlag = true;
											if ($("#protocolid").val()) {
												for (var i = 0; i< $scope.protocol.length;i++) {
													if ($scope.protocol[i].id == $("#protocolid").val()) {
														$scope.protocold.selected = {
// 															version:$scope.protocol[i].version,
															name : $scope.protocol[i].name,
															id : $scope.protocol[i].id
														};
														clearProtocolFlag = false;
													}
												}
											}else{
												for (var i = 0; i< $scope.protocol.length;i++) {
													if ($scope.protocol[i].isdefault == 1) {
														$scope.protocold.selected = {
// 															version:$scope.protocol[i].version,
															name : $scope.protocol[i].name,
															id : $scope.protocol[i].id
														};
														clearProtocolFlag = false;
														$("#protocolid").val($scope.protocol[i].id);
													}
												}
											}
											if(clearProtocolFlag){
												$("#protocolid").val(null);
											}
											$scope.protocolChange = function(){
												$("#protocolid").val($scope.protocold.selected.id);
											}
										});
								}
								
								initPageData($stateParams.JbId);
								$scope.backJunctionBox = function() {
									$state.go('app.junctionBox');
								}
							} ]);
</script>

<div ng-controller="JunctionBoxAddCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h4 blue-1 m-n text-black">编辑汇流箱信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid"
					action="${ctx}/JunctionBox/update.htm" method="post" id="editForm"
					name="editForm">
					<input type="hidden" name="devicename" id="devicename" class="formData"/>
					<input type="hidden" name="deviceid" id="deviceid" class="formData"/>
					<input type="hidden" name="thresholdid" id="thresholdId" class="formData"/>
					<input type="hidden" name="id" value="{{$stateParams.JbId}}"
						id="id" class="formData" /> <input type="hidden"
						name="serialnumber" id="serialnumber" class="formData" />
					<div class="form-group">
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>设备编号</label>
						<div class="col-lg-3">
							<input type="text" id="code" maxlength="50" name="code"
								class="form-control formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/\D/g,'')">
						</div>
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>设备名称</label>
						<div class="col-lg-3">
							<input type="text" id="name" maxlength="20" name="name"
								class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">设备厂商</label>
						<div class="col-lg-3">
							<ui-select ng-model="manufacturerd.selected" theme="bootstrap"
								ng-change="manufChange(1)"> <ui-select-match
								placeholder="请输入关键字..."
								ng-model="manufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices
								repeat="item in manufacturer | filter: $select.search">
							<div ng-bind-html="item.manufname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="manufid" name="manufid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">产品型号</label>
						<div class="col-lg-3">
							<ui-select ng-model="productd.selected" theme="bootstrap"
								ng-change="productChange(1)"> <ui-select-match
								placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
							<ui-select-choices
								repeat="item in product | filter: $select.search">
							<div
								ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="productid" name="productid"
								class="form-control formData">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">所属逆变器</label>
						<div class="col-lg-3">
							<ui-select ng-model="inverterd.selected" theme="bootstrap"
								ng-change="inverterChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="inverterd.selected.name">{{$select.selected.name}}</ui-select-match>
							<ui-select-choices
								repeat="item in inverter | filter: $select.search">
							<div ng-bind-html="item.name | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="inverterid" name="inverterid"
								class="form-control formData"> <input type="hidden"
								id="pstationid" name="pstationid" class="form-control formData">
							<input type="hidden" id="factid" name="factid"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">安装位置</label>
						<div class="col-lg-3">
							<input type="text" id="address" maxlength="20" name="address"
								class="form-control formData">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">安装时间</label>
						<div class="col-lg-3">
							<input type="text" id="begindate" name="begindate"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">停用时间</label>
						<div class="col-lg-3">
							<input type="text" id="enddate" name="enddate"
								class="form-control formData">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">主要参数</label>
						<div class="col-lg-8">
							<textarea rows="3" id="mainparameter" maxlength="20"
								name="mainparameter" class="form-control formData"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">检修工艺卡</label>
						<div class="col-lg-8">
							<textarea rows="3" id="standardoper" maxlength="20"
								name="standardoper" class="form-control formData"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">组串数</label>
						<div class="col-lg-3">
							<input type="text" id="batterygcount" maxlength="11"
								name="batterygcount" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">光伏组件</label>
						<div class="col-lg-3">
							<label class="checkbox-inline i-checks"> <input
								type="radio" name="materialtype" id="materialtype0" value="00"
								class="form-control"> <i></i> 单晶
							</label> <label class="checkbox-inline i-checks"> <input
								type="radio" name="materialtype" id="materialtype1" value="01"
								class="form-control "> <i></i> 多晶
							</label> <label class="checkbox-inline i-checks"> <input
								type="radio" name="materialtype" id="materialtype2" value="02"
								class="form-control "> <i></i> 薄膜
							</label>

						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">电池板功率(kW)</label>
						<div class="col-lg-3">
							<input type="text" id="batterypower" name="batterypower"
								class="form-control formData">
						</div>
						<!--                <label class="col-lg-1 control-label p-l-n ">kw</label> -->
						<label class="col-lg-2 control-label">每串电池板数</label>
						<div class="col-lg-3">
							<input type="text" id="batterycount" name="batterycount" maxlength="11"
								class="form-control formData">
						</div>
					</div>

			<!-- 		<div class="form-group">
						<label class="col-lg-2 control-label">电池板厂商</label>
						<div class="col-lg-3">
							<input type="text" id="batterymanufid" maxlength="11"
								name="batterymanufid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">电池板型号</label>
						<div class="col-lg-3">
							<input type="text" id="batteryprodid" name="batteryprodid" maxlength="11"
								class="form-control formData">
						</div>
					</div> -->
					
						<div class="form-group">
						<label class="col-lg-2 control-label">电池板厂商</label>
						<div class="col-lg-3">
							<ui-select ng-model="batterymanufacturerd.selected" theme="bootstrap"
								ng-change="manufChange(7)"> <ui-select-match
								placeholder="请输入关键字..."
								ng-model="batterymanufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices
								repeat="item in batterymanufacturer | filter: $select.search">
							<div ng-bind-html="item.manufname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden"  id="batterymanufid" maxlength="11"
								name="batterymanufid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">电池板型号</label>
						<div class="col-lg-3">
							<ui-select ng-model="batteryproductd.selected" theme="bootstrap"
								ng-change="productChange(7)"> <ui-select-match
								placeholder="请输入关键字..." ng-model="batteryproductd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
							<ui-select-choices
								repeat="item in batteryproduct | filter: $select.search">
							<div
								ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="batteryprodid" name="batteryprodid"
								class="form-control formData">
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-lg-2 control-label">电池板参数</label>
						<div class="col-lg-8">
							<textarea rows="3" id="batteryprodparameter" maxlength="20"
								name="batteryprodparameter" class="form-control formData"></textarea>
						</div>
					</div>
			
<!-- 			预警阀值开始		 -->
			 <div class="form-group">
              <label class="col-lg-2 control-label">开始时间</label>
              <div class="col-lg-3">
                <input type="text" id="checkstartdate" name="checkstartdate" placeholder="请输入时间  如: 09:00" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">结束时间</label>
              <div class="col-lg-3">
                <input type="text" id="checkenddate" name="checkenddate" placeholder="请输入时间  如: 09:10" class="form-control formData">
              </div>
           </div>   
              <div class="form-group">
              <label class="col-lg-2 control-label">平均值(A)</label>
              <div class="col-lg-3">
                <input type="text" id="averagev"  maxlength="10" name="averagev" class="form-control  formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
              </div>
              <label class="col-lg-2 control-label">偏差幅度(%)</label>
              <div class="col-lg-3">
                <input type="text" id="deviationrange" maxlength="10" name="deviationrange" class="form-control formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
              </div>
             </div>
      		
      		  <div class="form-group">
              <label class="col-lg-2 control-label">电路屏蔽掩码</label>
              <div class="col-lg-3">
                <input type="text" id="maskcode" maxlength="20" name="maskcode" class="form-control  formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/\D/g,'')">
              </div>
             <label class="col-lg-2 control-label">所属总线</label>
						<div class="col-lg-3">
							<ui-select ng-model="busd.selected" theme="bootstrap"
								ng-change="busChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="busd.selected.name">{{$select.selected.name}}</ui-select-match>
							<ui-select-choices
								repeat="item in bus | filter: $select.search">
							<div
								ng-bind-html="item.name | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="busid" name="busid" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
					<label class="col-lg-2 control-label">协议</label>
						<div class="col-lg-3">
							<ui-select ng-model="protocold.selected" theme="bootstrap"
								ng-change="protocolChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="protocold.selected.name">{{$select.selected.name}}</ui-select-match>
							<ui-select-choices
								repeat="item in protocol | filter: $select.search">
							<div
								ng-bind-html="item.name | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="protocolid" name="protocolid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">通讯地址</label>
						<div class="col-lg-3">
							<input type="text" id="hostaddr" name="hostaddr" maxlength="30" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">采集周期</label>
              			<div class="col-lg-2">
               	 			<input type="text" value="5000" id="cycle" name="cycle" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label text-left">毫秒</label>
              			<label class="col-lg-2 control-label">超时时间</label>
              			<div class="col-lg-2">
               	 			<input type="text" value="3000" id="timeout" name="timeout" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label text-left">毫秒</label>
					</div>
<!--              预警阀值结束 -->
<!-- 					<div class="form-group"></div> -->
					<div class="form-group m-t-sm">
					<div id="showhint"  class="hidden text-center m-b-sm"><font color="#FF0000">所属逆变器下，设备编号必须唯一</font></div>
						<div class="col-lg-12 text-center">
							<button type="button" onclick="saveFormJunction();"
								id="saveButton" class="  btn m-b-xs w-xs   btn-info">
								<strong>保 存</strong>
							</button>
							<button id="cancelBtn" type="button"
								class=" m-l-sm  btn m-b-xs w-xs btn-default"
								ng-click="backJunctionBox();">
								<strong>取消</strong>
							</button>
						</div>
					</div>
				</form>
				<!-- form 结束 -->
			</div>
		</div>
	</div>
</div>

