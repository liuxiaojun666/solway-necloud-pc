<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div ng-controller="BoxChangeCtrl">

	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">编辑箱变信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid"
					action="${ctx}/BoxChange/update.htm" method="post" id="editForm"
					name="editForm">
					<input type="hidden" name="id" value="{{$stateParams.InId}}"
						id="id" class="formData" /> <input type="hidden"
						name="serialnumber" value="" id="serialnumber" class="formData" />
					<div class="form-group">
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>设备编号</label>
						<div class="col-lg-3">
							<input type="text" id="code" maxlength="50" name="code" placeholder="请输入数字类型"
								class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
						</div>
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>设备名称</label>
						<div class="col-lg-3">
							<input type="text" id="name" maxlength="20" name="name"
								class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">所属电站</label>
						<div class="col-lg-3">
							<ui-select ng-model="stationd.selected" theme="bootstrap"
								ng-change="textChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="stationd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices
								repeat="item in station | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="pstationid" name="pstationid"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">所属厂区</label>
						<div class="col-lg-3">
							<input type="hidden" id="factid" name="factid"
								class="form-control formData">
							<ui-select ng-model="factd.selected" theme="bootstrap"
								ng-change="factChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="factd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices repeat="item in fact | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
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
								placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}} - {{$select.selected.specification}}</ui-select-match>
							<ui-select-choices
								repeat="item in product | filter: $select.search">
							<div
								ng-bind-html="item.productname+'-'+item.specification | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="productid" name="productid"
								class="form-control formData">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">安装位置</label>
						<div class="col-lg-3">
							<input type="text" id="address" maxlength="50" name="address"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">安装时间</label>
						<div class="col-lg-3">
							<input type="text" id="begindate" name="begindate"
								class="form-control formData">
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
						<label class="col-lg-2 control-label">停用时间</label>
						<div class="col-lg-3">
							<input type="text" id="enddate" name="enddate"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">主要参数</label>
						<div class="col-lg-8">
							<textarea rows="4" id="mainparameter" maxlength="20"
								name="mainparameter" class="form-control formData"></textarea>

						</div>
					</div>


					<div class="form-group m-t-sm ">
					<div id="showhint"  class="hidden text-center m-b-sm"><font color="#FF0000">所属电站下，设备编号必须唯一</font></div>
						<div class="col-lg-12 text-center ">
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

				boxchangeid : {
					required : true,
					maxlength : 11
				},

				inverterroom : {
					maxlength : 50
				},
				invertergid : {
					maxlength : 11
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
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.message == "Nunique"){
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

	});

	//日期控件
	$('#begindate')
			.datetimepicker({
				format : "yyyy-mm-dd",
				minView : 2,
				language : 'zh-CN',
				todayHighlight : true,
				todayBtn : true,
				endDate : new Date(),
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
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		startDate : new Date(),
		autoclose : true
	});

	function saveForm() {
		$("#editForm").trigger("submit");
	}

	function getDateToMs(date) {
		Todate = date.replace(new RegExp("-", "gm"), "/");
		var TimeMs = new Date(Todate).getTime();
		return TimeMs;
	}

	//初始化页面数据
	function initPageData(id) {
		$(".formData").val("");
		if (id != "" && id != null) {
			$("#id").val(id);
			$.ajax({
				type : "post",
				url : "${ctx}/BoxChange/selectById.htm",
				data : {
					"id" : id
				},
				success : function(msg) {
					$("#code").val(msg.code);
					$("#name").val(msg.name);
					$("#pstationid").val(msg.pstationid);
					$("#address").val(msg.address);
					$("#manufid").val(msg.manufid);
					$("#factid").val(msg.factid);
					$("#productid").val(msg.productid);
					$("#mainparameter").val(msg.mainparameter);
					$("#status").val(msg.status);
					$("#serialnumber").val(msg.serialnumber);
					$("#serialnumber").val(msg.serialnumber);
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
						$("#enddate").val(dateFormat(new Date(msg.begindate)));
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
	var getStationList = null, getManufactureList = null, getProductList = null;
	app
			.controller(
					'BoxChangeCtrl',
					[
							'$http',
							'$scope',
							'$stateParams',
							'$state',
							function($http, $scope, $stateParams, $state) {
								$scope.stationd = {};
								$scope.station = null;
								$scope.factd = {};
								$scope.fact = null;
								$scope.textChange = function() {
									$scope.getBusCfgList($scope.stationd.selected.id);
									$scope.factd.selected = {
										stationname : null,
										id : null
									};
									$scope.fact = null;
									a = angular
											.copy($scope.stationd.selected.id);
									$("#pstationid").val(a);
									$scope.factd.selected = {
										stationname : null,
										id : null
									};
									$http(
											{
												method : "POST",
												url : "${ctx}/PowerStation/selectByParentId.htm",
												params : {
													parentid : a
												}
											})
											.success(
													function(resultfact) {
														$scope.fact = resultfact;
														if ($scope.fact != null
																&& $scope.fact.length > 0) {
															$scope.fact
																	.unshift({
																		id : null,
																		stationname : '请选择'
																	});
														}
														var clearFactFlag = true;
														if ($("#factid").val()) {
															for (var i = 0, len = $scope.fact.length; i < len; i++) {
																if ($scope.fact[i].id == $(
																		"#factid")
																		.val()) {
																	clearFactFlag = false;
																	$scope.factd.selected = {
																		stationname : $scope.fact[i].stationname,
																		id : $(
																				"#factid")
																				.val()
																	};
																}
															}
															if (clearFactFlag) {
																$("#factid")
																		.val(
																				null);
																$scope.factd.selected = {
																	stationname : $scope.fact[0].stationname,
																	id : $scope.fact[0].id
																};
															}
														} else {
															$scope.factd.selected = {
																stationname : $scope.fact[0].stationname,
																id : $scope.fact[0].id
															};
														}
														for (var i = 0, len = $scope.fact.length; i < len; i++) {
															if ($scope.fact[i].id == $(
																	"#factid")
																	.val()) {
																$scope.factd.selected = {
																	stationname : $scope.fact[i].stationname,
																	id : $(
																			"#factid")
																			.val()
																};
															}
														}
														$scope.factChange = function() {
															b = angular
																	.copy($scope.factd.selected.id);
															$("#factid").val(b);
														}
													});
								}
								getStationList = $scope.getStationList = function() {
									$scope.stationd.selected = {
										stationname : null,
										id : null
									};
									$scope.station = null;
									$scope.factd.selected = {
										stationname : null,
										id : null
									};
									$scope.fact = null;
									$http(
											{
												method : "POST",
												url : "${ctx}/PowerStation/selectByParentId.htm",
												params : {}
											})
											.success(
													function(result) {
														$scope.station = result;
														if ($("#pstationid")
																.val() != null
																&& $(
																		"#pstationid")
																		.val() != "") {
															for (var i = 0, len = $scope.station.length; i < len; i++) {
																if ($scope.station[i].id == $(
																		"#pstationid")
																		.val()) {
																	$scope.stationd.selected = {
																		stationname : $scope.station[i].stationname,
																		id : $(
																				"#pstationid")
																				.val()
																	};
																}
															}
														} else if (result.length == 1) {
															$scope.stationd.selected = {
																stationname : $scope.station[0].pstationname,
																id : $scope.station[0].pstationid
															};
															$("#pstationid")
																	.val(
																			$scope.station[0].id);
														}
														if ($("#pstationid")
																.val() != null
																&& $(
																		"#pstationid")
																		.val() != "") {
															$scope.textChange();
														}
													});
								}
								
								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.manufacturer = null;
								$scope.productd = {};
								$scope.product = null;

								$scope.manufChange = function() {
									$("#manufid").val(
											$scope.manufacturerd.selected.id);
									$scope.getProductList();
								}
								getManufactureList = $scope.getManufactureList = function() {
									$scope.manufacturer = null;
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
													
													devicetype: 3
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
														} else {
															$scope.manufacturerd.selected = {
																manufname : $scope.manufacturer[0].manufname,
																id : $scope.manufacturer[0].id
															};
														}
														if ($("#manufid").val() != null
																&& $("#manufid")
																		.val() != "") {
															$scope
																	.manufChange();
														}
													});
								}
								$scope.productChange = function() {
									$("#productid").val($scope.productd.selected.id);
									$scope.getProtocolCfgList($scope.productd.selected.id);
								}
								getProductList = $scope.getProductList = function() {
									$scope.product = null;
									$scope.productd.selected = {
										productname : null,
										id : null
									};
									$http(
											{
												method : "POST",
												url : "${ctx}/Product/selectByManuf.htm",
												params : {
													manufid : $scope.manufacturerd.selected.id,
													devicetype: 3
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
														if ($("#productid").val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $("#productid").val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {
																		productname : $scope.product[i].productname,
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
									$state.go('app.boxChange');
								}
							} ]);
	function getStation() {
		$.ajax({
			type : "post",
			url : "${ctx}/Login/getLoginUser.htm",
			dataType : "json",
			async : false,
			success : function(uerstation) {
				if (uerstation.pstationid != null) {
					$("#pstationid").val(uerstation.pstationid);
				}
			}
		});
	}
	function getSelected(id) {
		if (getStationList != null) {
			getStationList();
		}
		if (getManufactureList != null) {
			getManufactureList();
		}
	}
</script>

