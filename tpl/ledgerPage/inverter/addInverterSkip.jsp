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
				inverterroom : {
					maxlength : 50
				},
				invertergid : {
					maxlength : 50
				},
				address : {
					maxlength : 50
				},
				repaircard : {
					maxlength : 50
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
				realcapacity : {
					number : true,
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.message == "Nunique") {
							$("#showhint").removeClass('hidden');
						} else if (json.message == "Usuccess") {
							promptObj('success', '', "更新成功");
							$("#cancelBtn").trigger("click");
						} else {
							promptObj('success', '', "保存成功");
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
		app.controller('InverterAddCtrl', [
				'$http',
				'$location',
				'$rootScope',
				'$scope',
				'$state',
				'$stateParams',
				function($http, $location, $rootScope, $scope, $state,
						$stateParams) {
					initPageData($stateParams.InId);
					$scope.backInverter = function() {
						$state.go('app.inverter');
					}
				} ]);
	});

	function saveForm() {
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

	//初始化页面数据
	function initPageData(id) {
		$(".formData").val("");
		if (id != "" && id != null) {
			$("#id").val(id);
			$.ajax({
				type : "post",
				url : "${ctx}/Inverter/selectById.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					$("#code").val(msg.code);
					$("#name").val(msg.name);
					$("#pstationid").val(msg.pstationid);
					$("#factid").val(msg.factid);
					$("#boxchangeid").val(msg.boxchangeid);
					$("#inverterroom").val(msg.inverterroom);
					$("#invertergid").val(msg.invertergid);
					$("#address").val(msg.address);
					$("#repaircard").val(msg.repaircard);
					$("#manufid").val(msg.manufid);
					$("#productid").val(msg.productid);
					$("#mainparameter").val(msg.mainparameter);
					$("#serialnumber").val(msg.serialnumber);
					$("#realcapacity").val(msg.realcapacity);
					$("#capacity").val(msg.capacity);
					$("#hostaddr").val(msg.hostaddr);
					$("#busid").val(msg.busid);
					$("#protocolid").val(msg.protocolid);
					$("#cycle").val(msg.cycle);
					$("#timeout").val(msg.timeout);
					if (msg.begindate) {
						$("#begindate")
								.val(dateFormat(new Date(msg.begindate)));
					}
					if (msg.enddate) {
						$("#enddate").val(dateFormat(new Date(msg.enddate)));
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
	var getBoxChangeList = null, getManufactureList = null, getProductList = null;
	function getSelected(id) {
		if (getBoxChangeList != null) {
			getBoxChangeList();
		}
		if (getManufactureList != null) {
			getManufactureList();
		}
	}

	app
			.controller(
					'BoxChangeCtrl',
					[
							'$http',
							'$location',
							'$rootScope',
							'$scope',
							'$state',
							'$stateParams',
							function($http, $location, $rootScope, $scope,
									$state, $stateParams) {
								$scope.boxchanged = {};
								$scope.boxchangeList = null;
								$scope.boxChange = function() {
									$("#boxchangeid")
											.val(
													angular
															.copy($scope.boxchanged.selected.id));
									$("#factid")
											.val(
													angular
															.copy($scope.boxchanged.selected.factid));
									$("#pstationid")
											.val(
													angular
															.copy($scope.boxchanged.selected.pstationid));
									$scope.getBusCfgList($scope.boxchanged.selected.pstationid);
								}
								getBoxChangeList = $scope.getBoxChangeList = function() {
									$scope.boxchanged.selected = {
										name : null,
										id : null,
										pstationid : null,
										factid : null
									};
									$http(
											{
												method : "POST",
												url : "${ctx}/BoxChange/selectByStation.htm",
												params : {
													pstationid : $(
															"#pstationid")
															.val()
												}
											})
											.success(
													function(result) {
														$scope.boxchangeList = result;
														if (boxChange) {//入口为箱变时，所属箱变默认选中
															$("#boxchangeid")
																	.val(
																			boxChange);
														}
														for (var i = 0, len = $scope.boxchangeList.length; i < len; i++) {
															if ($scope.boxchangeList[i].id == $(
																	"#boxchangeid")
																	.val()) {
																$scope.boxchanged.selected = {
																	name : $scope.boxchangeList[i].name,
																	id : $scope.boxchangeList[i].id,
																	pstationid : $scope.boxchangeList[i].pstationid,
																	factid : $scope.boxchangeList[i].factid
																};
																$scope
																		.boxChange();
															}
														}
													});
								}
								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.manufacturer = null;
								$scope.productd = {};
								$scope.product = null;

								getManufactureList = $scope.getManufactureList = function() {
									$scope.manufacturer = null;
									$scope.manufacturerd.selected = {
										manufname : null,
										id : null
									};
									$scope.product = null;
									$scope.productd = {};
									$http(
											{
												method : "POST",
												url : "${ctx}/Manufacturer/selectAll.htm",
												params : {
														devicetype: 2
												}
											})
											.success(
													function(result) {
														$scope.manufacturer = result;
														if ($scope.manufacturer != null
																&& $scope.manufacturer.length > 0) {
															$scope.manufacturer
																	.unshift({
																		id : "",
																		manufname : '请选择'
																	});
														}
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
															$scope
																	.manufChange();
														} else {
															$scope.manufacturerd.selected = {
																manufname : $scope.manufacturer[0].manufname,
																id : $scope.manufacturer[0].id
															};
														}
													});
								}
								$scope.manufChange = function() {
									$("#manufid").val(
											$scope.manufacturerd.selected.id);
									$scope.getProductList();
								}
								$scope.productChange = function() {
									$("#productid").val(
											$scope.productd.selected.id);
									$("#capacity")
											.val(
													$scope.productd.selected.buildcapacity);
									$scope.getProtocolCfgList($scope.productd.selected.id);
								}
								getProductList = $scope.getProductList = function() {
									$scope.product = null;
									$scope.productd = {};
									$http(
											{
												method : "POST",
												url : "${ctx}/Product/selectByManuf.htm",
												params : {
													manufid : $scope.manufacturerd.selected.id,
													devicetype: 2
												}
											})
											.success(
													function(resultproduct) {
														$scope.product = resultproduct;
														if ($scope.product != null
																&& $scope.product.length > 0) {
															$scope.product
																	.unshift({
																		id : null,
																		productname : '请选择'
																	});
														}
														var clearProductFlag = true;
														if ($("#productid")
																.val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $(
																		"#productid")
																		.val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {
																		productname : $scope.product[i].productname,
																		specification : $scope.product[i].specification,
																		id : $(
																				"#productid")
																				.val(),
																		buildcapacity : $scope.product[i].buildcapacity
																	};
																	$(
																			"#capacity")
																			.val(
																					$scope.productd.selected.buildcapacity);
																	$scope.getProtocolCfgList($scope.productd.selected.id);
																}
															}
															if (clearProductFlag) {
																$scope.productd.selected = {
																	productname : $scope.product[0].productname,
																	specification : $scope.product[0].specification,
																	id : $scope.product[0].id
																};
																$("#productid")
																		.val($scope.productd.selected.id);
																$(
																"#capacity")
																.val(
																		$scope.productd.selected.buildcapacity);
																$scope.getProtocolCfgList($scope.productd.selected.id);
															}
														} else {
															$scope.productd.selected = {
																productname : $scope.product[0].productname,
																specification : $scope.product[0].specification,
																id : $scope.product[0].id
															};
															$("#productid").val($scope.productd.selected.id);
															$("#capacity").val($scope.productd.selected.buildcapacity);
															$scope.getProtocolCfgList($scope.productd.selected.id);
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
								initPageData($stateParams.InId);
								$scope.backInverter = function() {
									$state.go('app.inverter');
								}
							} ]);
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
	function numFix(objId) {
		var value = $("#" + objId).val();
		if (!isNaN(value)) {
			value = parseFloat(value).toFixed(2);
			$("#" + objId).val(value);
		}
	}
</script>


<div ng-controller="InverterAddCtrl">
	<div ng-controller="BoxChangeCtrl">
		<div class="wrapper-md bg-light b-b">
			<span class="font-h4 blue-1 m-n text-black">编辑逆变器信息</span>
		</div>
		<div class="wrapper-md ng-scope">
			<div class="panel panel-default">
				<div class="row wrapper">
					<!-- form 开始 -->
					<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid"
						action="${ctx}/Inverter/update.htm" method="post" id="editForm"
						name="editForm">
						<input type="hidden" name="id" value="{{$stateParams.InId}}"
							id="id" class="formData" /> <input type="hidden"
							name="serialnumber" value="" id="serialnumber" class="formData" />
						<div class="form-group">
							<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>设备编号</label>
							<div class="col-lg-3">
								<input type="text" id="code" maxlength="50" name="code"
									class="form-control formData" placeholder="请输入数字类型"
									onkeyup="value=value.replace(/\D/g,'')">

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
									ng-change="manufChange()"> <ui-select-match
									placeholder="请输入关键字..."
									ng-model="manufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
								<ui-select-choices
									repeat="item in manufacturer | filter: $select.search">
								<div ng-bind-html="item.manufname | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden" id="manufid" name="manufid"
									class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">产品型号</label>
							<div class="col-lg-3">
								<ui-select ng-model="productd.selected" theme="bootstrap"
									ng-change="productChange()"> <ui-select-match
									placeholder="请输入关键字..."
									ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
								<ui-select-choices
									repeat="item in product | filter: $select.search">
								<div
									ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden" id="productid" name="productid"
									class="form-control formData"> <input type="hidden"
									id="capacity" name="capacity" class="form-control formData">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label">所属箱变</label>
							<div class="col-lg-3">
								<ui-select ng-model="boxchanged.selected" theme="bootstrap"
									ng-change="boxChange()"> <ui-select-match
									placeholder="请输入关键字..." ng-model="boxchanged.selected.name">{{$select.selected.name}}</ui-select-match>
								<ui-select-choices
									repeat="item in boxchangeList | filter: $select.search">
								<div ng-bind-html="item.name | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden" id="boxchangeid" name="boxchangeid"
									class="form-control formData"> <input type="hidden"
									id="pstationid" name="pstationid" class="form-control formData">
								<input type="hidden" id="factid" name="factid"
									class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">安装位置</label>
							<div class="col-lg-3">
								<input type="text" id="address" name="address" maxlength="50"
									class="form-control formData">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label">逆变器室</label>
							<div class="col-lg-3">
								<input type="text" id="inverterroom" maxlength="50"
									name="inverterroom" class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">逆变器组</label>
							<div class="col-lg-3">
								<input type="text" id="invertergid" maxlength="50"
									name="invertergid" class="form-control formData">
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

							<label class="col-lg-1 control-label col-sm-offset-1">接入光伏组件容量</label>
							<div class="col-lg-2">
							<span>
								<input type="text" id="realcapacity" name="realcapacity" maxlength="12"
									onchange="numFix(this.id);" class="form-control formData">
							</span>
							</div>
							<label class="col-lg-1 control-label">(kW)</label>
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
								<textarea rows="3" id="repaircard" maxlength="50"
									name="repaircard" class="form-control formData"></textarea>
							</div>
						</div>

						<div class="form-group m-t-sm">
							<div id="showhint" class="hidden text-center m-b-sm">
								<font color="#FF0000">所属汇流箱下，设备编号必须唯一</font>
							</div>
							<div class="col-lg-12 text-center">
								<button type="button" onclick="saveForm();" id="saveButton"
									class="  btn m-b-xs w-xs   btn-info">
									<strong>保 存</strong>
								</button>
								<button id="cancelBtn" type="button"
									class=" m-l-sm  btn m-b-xs w-xs btn-default"
									ng-click="backInverter();">
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
</div>

