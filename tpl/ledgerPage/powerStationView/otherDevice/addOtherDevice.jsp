<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div ng-controller="AddOtherDeviceCtrl" class="modal fade" id="otherDeviceEdit" tabindex="-1" role="dialog" aria-labelledby="otherDeviceEdit" aria-hidden="true">
<div class="modal-dialog modal-lg">
      <div class="modal-content ">
		<div class="modal-body">
	<div class="">
		<span class="font-h4 blue-1 m-n text-black">编辑设备信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/OtherDevice/update.htm" method="post" id="othersaveForm" name="othersaveForm">
					<input type="hidden" name="id" id="otherid" class="formData" /> 
					<input type="hidden" name="serialnumber" value="" id="otherserialnumber" class="formData" />
					<div class="form-group">
						<label class="col-lg-2 control-label">设备编号</label>
						<div class="col-lg-4">
							<input type="text" id="othercode" maxlength="50" name="code"
								class="form-control formData" placeholder="请输入数字类型"
								onkeyup="value=value.replace(/\D/g,'')">
						</div>
						<label class="col-lg-2 control-label">设备名称</label>
						<div class="col-lg-4">
							<input type="text" id="othername" maxlength="20" name="name"
								class="form-control formData" onkeyup="value=value.replace(/^\s*$/g,'')">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">所属厂区</label>
							<div class="col-lg-4">
							<ui-select ng-model="factd.selected" theme="bootstrap"
								ng-change="othertextChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="factd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices repeat="item in fact | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="otherfactid" name="factid" class="form-control formData">
							<input type="hidden" id="otherpstationid" name="pstationid" class="form-control">
						</div>
					   <label class="col-lg-2 control-label">安装位置</label>
						<div class="col-lg-4">
							<input type="text" id="otheraddress" maxlength="50" name="address"
								class="form-control formData">
						</div>	
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">设备类型</label>
						<div class="col-lg-4" id="userType_Div">
							<label class="checkbox-inline i-checks">
							 <input type="radio" name="devicetype" id="otherammeter" value="4" checked="checked" onclick="getManufactureList(this.value)"
								class="form-control"> <i></i> 电能表
							</label> <label class="checkbox-inline i-checks">
							 <input type="radio" name="devicetype" id="otherweather" value="5" onclick="getManufactureList(this.value)"
								class="form-control "> <i></i> 气象站
							</label>
						</div>

						<label class="col-lg-2 control-label" id="parentDevice_title">上级设备</label>
						<div class="col-lg-4 tree-box" id="parentDevice_content">
							<div class="tree-show" ng-click="showTreeSelect()">
								<input type="text" name="pname" id="otherpname" placeholder="请输入上级设备" class="form-control formData">
								<p type="text" class="form-control formData pname"></p>
								<span class="tree-icon"></span>
							</div>
							<div class="tree-select" id="treeSelect">
								<ul id="classifyTree" class="ztree"></ul>
							</div>
							<input type="hidden" id="otherpid" name="pid" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">设备厂商</label>
						<div class="col-lg-4">
							<ui-select ng-model="manufacturerd.selected" theme="bootstrap"
								ng-change="manufChange()"> <ui-select-match
								placeholder="请输入关键字..."
								ng-model="manufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices
								repeat="item in manufacturer | filter: $select.search">
							<div ng-bind-html="item.manufname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="othermanufid" name="manufid"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">产品型号</label>
						<div class="col-lg-4">
							<ui-select ng-model="productd.selected" theme="bootstrap"
								ng-change="productChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
							<ui-select-choices
								repeat="item in product | filter: $select.search">
							<div
								ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="otherproductid" name="productid"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">安装时间</label>
						<div class="col-lg-4">
							<input type="text" id="otherbegindate" name="begindate" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">停用时间</label>
						<div class="col-lg-4">
							<input type="text" id="otherenddate" name="enddate" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">采集周期</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="5000" id="othercycle" name="cycle" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label no-padder m-t-xs text-left">毫秒</label>
              			
              			<label class="col-lg-2 control-label">超时时间</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="3000" id="othertimeout" name="timeout" maxlength="11" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label no-padder m-t-xs text-left">毫秒</label>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">斜面</label>
              			<div class="col-lg-4">
               	 			<input type="text"  id="otherobliquity" name="obliquity" maxlength="11" class="form-control formData" >
              			</div>
              			<label class="col-lg-2 control-label">水平</label>
              			<div class="col-lg-4">
               	 			<input type="text"  id="otherhorizontal" name="horizontal" maxlength="11" class="form-control formData" >
              			</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">散射</label>
              			<div class="col-lg-4">
               	 			<input type="text"  id="otherscattering" name="scattering" maxlength="11" class="form-control formData" >
              			</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">主要参数</label>
						<div class="col-lg-10">
							<textarea rows="2" id="othermainparameter" maxlength="20"
								name="mainparameter" class="form-control formData"></textarea>

						</div>
					</div>
					<div class="form-group m-t-sm">
					<div id="othernotonly"  class="hidden text-center m-b-sm"><font color="#FF0000">所属电站下，设备编号必须唯一</font></div>
						<div class="col-lg-12 text-center">
							<button type="button" onclick="saveOtherForm();" id="saveButton" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
							<button id="cancelBtn" type="button"class=" m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
						</div>
					</div>
				</form>
				<!-- form 结束 -->
			</div>
		</div>
	</div>
</div>
</div>
</div>
</div>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css"/>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.all.min.js"></script>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
	.line{height:auto;}
	.tree-box{position:relative;}
	.tree-select{display:none;width:90%;position:absolute;top:33px;left:15px;z-index:1001;background:#fff;border:1px solid #cfdadd;max-height:260px;overflow:scroll;}
	.tree-show{position:relative;}
	.tree-icon{position:absolute;width:0px;height:0px;border-left: 8px solid transparent;border-right: 8px solid transparent;border-top: 12px solid #cfdadd;right:10px;top:12px;}
	.pname{position: absolute;z-index: 1;top: 0px;opacity: 0;}
</style>
<script type="text/javascript">
	var zTreeObj, zNodes;
	var setting = {
		check: {
			enable: true,
			chkStyle: "radio",
			radioType: "all"
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid",
				rootPId: 0
			}
		},
		callback: {
			onCheck: onCheck
		}
	};
	function onCheck(event, treeId, treeNode){
		$("#otherpname").val(treeNode.name);
		$("input[name='pid']").val(treeNode.id);
		$("#treeSelect").slideUp(200);
	}
	$(function() {
		$("#othersaveForm").validate({
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
						if (json.type == "error") {
							$("#othernotonly").removeClass('hidden');
						}else{
							hideModal("otherDeviceEdit");
							promptObj(json.type, '',json.message);
							$("#searchOtherBtn").trigger("click");
						}
					},
					error : function(json) {
						hideModal("otherDeviceEdit");
						$("#searchOtherBtn").trigger("click");
					}
				};
				$('#othersaveForm').ajaxSubmit(options);
			}
		});
	});

	function saveOtherForm() {
		$("#othersaveForm").trigger("submit");
	}

	//初始化页面数据
	function initOtherData(id) {
		$(".formData").val("");
		if (id != "" && id != null) {
			$("#otherid").val(id);
			$.ajax({
					type : "post",
						url : "${ctx}/OtherDevice/selectById.htm",
						data : {
							"id" : id
						},
						success : function(msg) {
							$("#otherpid").val(msg.pid)
							$("#othercode").val(msg.code);
							$("#othername").val(msg.name);
							$("#otherpstationid").val(msg.pstationid);
							$("#otherfactid").val(msg.factid);
							$("#otheraddress").val(msg.address);
							$("#othermanufid").val(msg.manufid);
							$("#otherproductid").val(msg.productid);
							$("#othermainparameter").val(msg.mainparameter);
							$("#otherstatus").val(msg.status);
							$("#otherserialnumber").val(msg.serialnumber);
							$("#otherhostaddr").val(msg.hostaddr);
							$("#otherbusid").val(msg.busid);
							$("#otherprotocolid").val(msg.protocolid);
							$("#othercycle").val(msg.cycle);
							$("#othertimeout").val(msg.timeout);
							$("#otherobliquity").val(msg.obliquity);
							$("#otherhorizontal").val(msg.horizontal);
							$("#otherscattering").val(msg.scattering);
							if(msg.begindate){
							$("#otherbegindate").val(dateFormat(msg.begindate));
							}
							if(msg.enddate){
							$("#otherenddate").val(dateFormat(msg.enddate));
							}
							getStation();
							getSelected(id);
							getOtherfactoryList();
							getTree();
						}
					});
		} else {
			getStation();
			getSelected(null);
			getOtherfactoryList();
			getTree();
		}

	}

	function getTree() {
		var id = $("#otherid").val();
		$.getJSON('${ctx}/OtherDevice/getTree.htm', {'pstationid': $("#stationid").val(), 'devicetype': '4', 'id': id}, function(data){
			zTreeObj = $.fn.zTree.init($("#classifyTree"), setting, data.treeData);
			var pid = $("#otherpid").val();
			if (pid != "" && pid != null) {
				var node = zTreeObj.getNodeByParam("id", pid);
				zTreeObj.expandNode(node, true);
				zTreeObj.checkNode(node, true, true, true);
			}
			if (id != "" && id != null && data.flag) {
				var node = zTreeObj.getNodeByParam("id", id);
				zTreeObj.setChkDisabled(node, true, false, true);
				zTreeObj.expandNode(node, false);
			}
		});
	}

	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd");
		return time;
	}
	var getOtherfactoryList = null, getManufactureList = null, getProductList = null;
	function getSelected(id) {
		if (getManufactureList != null) {
			var dtype=$("input[name='devicetype']:checked").val();
			getManufactureList(dtype);
		}
	}
	
	//日期控件 
	$('#otherbegindate')
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
	$('#otherenddate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		startDate : new Date(),
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	app.controller('AddOtherDeviceCtrl',['$http','$location','$rootScope','$scope','$state','$stateParams',
							function($http, $location, $rootScope, $scope,$state, $stateParams) {
								$scope.factd = {};
								$scope.fact = null;
								$scope.othertextChange = function() {
									a = angular.copy($scope.factd.selected.id);
									$("#otherfactid").val(a);
								}
								
								getOtherfactoryList = $scope.getOtherfactoryList = function() {
									$http({
											method : "POST",
											url : "${ctx}/PowerStation/selectByParentId.htm",
											params : {
										    "parentid":$("#stationid").val()
											}
											}).success(
													function(result) {
														$scope.fact = result;
														if($scope.fact.length>0){
															$scope.fact.unshift({id : "",stationname : '请选择'});
															$scope.factd.selected = {stationname : $scope.fact[0].stationname,id : $scope.fact[0].id};
														}
														if ($("#otherfactid").val()) {
															for (var i = 0, len = $scope.fact.length; i < len; i++) {
																if ($scope.fact[i].id == $("#otherfactid").val()) {
																	$scope.factd.selected = {stationname : $scope.fact[i].stationname,id : $("#otherfactid").val()};
																}
															}
														}
														if ($("#otherfactid").val() != null&& $("#otherfactid").val() != "") {
// 															$scope.textChange();
														}
													});
								}

								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.manufacturer = null;
								$scope.productd = {};
								$scope.product = null;

								$scope.manufChange = function() {
									$("#othermanufid").val($scope.manufacturerd.selected.id);
									$scope.getProductList();
								}
								getManufactureList = $scope.getManufactureList = function(dtype) {
									if (dtype == 4) {
										$('#parentDevice_title').show();
										$('#parentDevice_content').show();
									}
									if (dtype == 5) {
										$('#parentDevice_title').hide();
										$('#parentDevice_content').hide();
									}
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
									$http({
												method : "POST",
												url : "${ctx}/Manufacturer/selectAll.htm",
												params : {
													devicetype: dtype
												}
											}).success(
													function(result) {
														JSON.stringify(result);
														$scope.manufacturer = result;
														if ($scope.manufacturer != null&& $scope.manufacturer.length > 0) {
															$scope.manufacturer.unshift({id : "",manufname : '请选择'});
														}
														if ($("#othermanufid").val() != null&& $("#othermanufid").val() != "") {
															for (var i = 0, len = $scope.manufacturer.length; i < len; i++) {
																if ($scope.manufacturer[i].id == $("#othermanufid").val()) {
																	$scope.manufacturerd.selected = {manufname : $scope.manufacturer[i].manufname,id : $("#othermanufid").val()};
																}
															}
															$scope.manufChange();
														} else {
															$scope.manufacturerd.selected = {manufname : $scope.manufacturer[0].manufname,id : $scope.manufacturer[0].id};
														}
													});
								}
								$scope.productChange = function(dtype) {
									$("#otherproductid").val($scope.productd.selected.id);
								}
								getProductList = $scope.getProductList = function() {
									if($scope.manufacturerd.selected.id){
									$scope.product = null;
									$scope.productd.selected = {productname : null,id : null};
									$http({
												method : "POST",
												url : "${ctx}/Product/selectByManuf.htm",
												params : {
													manufid : $scope.manufacturerd.selected.id,
													devicetype: $("input[name='devicetype']:checked").val()
												}
											}).success(
													function(resultproduct) {
														$scope.product = resultproduct;
														if ($scope.product != null&& $scope.product.length > 0) {
															$scope.product.unshift({id : null,productname : '请选择'});
														}
														var clearProductFlag = true;
														if ($("#otherproductid").val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $("#otherproductid").val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {productname : $scope.product[i].productname,specification : $scope.product[i].specification,id : $("#otherproductid").val()};
																}
															}
															if (clearProductFlag) {
																$scope.productd.selected = {productname : $scope.product[0].productname,specification : $scope.product[0].specification,id : $scope.product[0].id};
																$("#otherproductid").val($scope.productd.selected.id);
															}
														} else {
															$scope.productd.selected = {productname : $scope.product[0].productname,specification : $scope.product[0].specification,id : $scope.product[0].id};
														}
													});
									}
								}
								
								//所属厂商、产品---------------------------end----------------------------------

								//Device Tree Select
								$scope.showTreeSelect = function(){
									var _obj = $("#treeSelect");
									if(_obj.is(":visible")){
										_obj.slideUp(200);
									}else{
										_obj.slideDown(500);
									}
								};


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
</script>
