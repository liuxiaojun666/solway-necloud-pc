<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div ng-controller="BoxChangeCtrl" class="modal fade" id="boxChangeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog modal-lg">
      <div class="modal-content ">
		<div class="modal-body">
	<div class="">
		<span class="font-h4 blue-1 m-n text-black">编辑箱变信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg form-horizontal ng-pristine ng-valid" action="${ctx}/BoxChange/update.htm" method="post" id="editBoxForm" name="editBoxForm">
					<input type="hidden" name="id" id="boxid" class="formData" />
					 <input type="hidden" name="serialnumber"  id="boxserialnumber" class="formData" />
					
					<div class="form-group">
						<label class="col-lg-2 control-label ">设备编号</label>
							<div class="col-lg-4">
								<input type="text" id="boxcode" maxlength="50" name="code" placeholder="请输入数字类型"
								class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
							</div>
						<label class="col-lg-2 control-label">设备名称</label>
						<div class="col-lg-4">
							<input type="text" id="boxname" maxlength="20" name="name" class="form-control formData" onkeyup="value=value.replace(/^\s*$/g,'')">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">所属厂区</label>
						<div class="col-lg-4">
							<ui-select ng-model="boxfactd.selected" theme="bootstrap"
								ng-change="boxfactChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="boxfactd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices repeat="item in boxfact | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
						</div>
						<input type="hidden" id="boxpstationid" name="pstationid" >
						<input type="hidden" id="boxfactid" name="factid" class="formData">
						<label class="col-lg-2 control-label">安装位置</label>
						<div class="col-lg-4">
							<input type="text" id="boxaddress" maxlength="50" name="address" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">设备厂商</label>
						<div class="col-lg-4">
							<ui-select ng-model="manufacturerd.selected" theme="bootstrap"
								ng-change="boxmanufChange()"> <ui-select-match
								placeholder="请输入关键字..."
								ng-model="manufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices
								repeat="item in manufacturer | filter: $select.search">
							<div ng-bind-html="item.manufname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="boxmanufid" name="manufid" class="form-control formData">
						</div>
					<label class="col-lg-2 control-label">产品型号</label>
					<div class="col-lg-4">
						<ui-select ng-model="productd.selected" theme="bootstrap"
							ng-change="boxproductChange()"> <ui-select-match
							placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}} - {{$select.selected.specification}}</ui-select-match>
						<ui-select-choices
							repeat="item in product | filter: $select.search">
						<div
							ng-bind-html="item.productname+'-'+item.specification | highlight: $select.search"></div>
						</ui-select-choices> </ui-select>
						<input type="hidden" id="boxproductid" name="productid"class="form-control formData">
					</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">安装时间</label>
						<div class="col-lg-4">
							<input type="text" id="boxbegindate" name="begindate"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">停用时间</label>
						<div class="col-lg-4">
							<input type="text" id="boxenddate" name="enddate"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">采集周期</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="5000" id="boxcycle" name="cycle" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label no-padder m-t-xs text-left">毫秒</label>
              			<label class="col-lg-2 control-label">超时时间</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="3000" id="boxtimeout" name="timeout" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label no-padder m-t-xs text-left">毫秒</label>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">主要参数</label>
						<div class="col-lg-10">
							<textarea rows="2" id="boxmainparameter" maxlength="20"
								name="mainparameter" class="form-control formData"></textarea>

						</div>
					</div>
					<div class="form-group m-t-sm ">
					<div id="boxnotonly"  class="hidden text-center m-b-sm"><font color="#FF0000">所属电站下，设备编号必须唯一</font></div>
						<div class="col-lg-12 text-center ">
							<button type="button" onclick="saveBoxForm();" id="saveBoxButton" data-loading-text="保存中..." autocomplete="off" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
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

<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	$(function() {
		$("#editBoxForm").validate({
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
					required : true,
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
						if (json.type == "error"){
							$("#boxnotonly").removeClass('hidden');
						}else{
							hideModal("boxChangeModal");
							promptObj(json.type, '',json.message);
							$("#searchboxBtn").trigger("click");
						}
					},
					error : function(json) {
						hideModal("boxChangeModal");
						promptObj("error", '',"操作失败,请稍后重试");
					}
				};
				$("#saveBoxButton").button('loading');
				$('#editBoxForm').ajaxSubmit(options);
			}
		});

	});

	//日期控件
	$('#boxbegindate')
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
	$('#boxenddate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		startDate : new Date(),
		autoclose : true
	});

	function saveBoxForm() {
		$("#editBoxForm").trigger("submit");
	}

	function getDateToMs(date) {
		Todate = date.replace(new RegExp("-", "gm"), "/");
		var TimeMs = new Date(Todate).getTime();
		return TimeMs;
	}

	//初始化页面数据
	function initBoxPageData(id) {
		$(".formData").val("");
		if (id != "" && id != null) {
			$("#id").val(id);
			$.ajax({
				type : "post",
				url : "${ctx}/BoxChange/selectById.htm",
				data : {
					"id" : id
				},success : function(msg) {
					$("#boxid").val(msg.id);
					$("#boxcode").val(msg.code);
					$("#boxfactid").val(msg.factid);
					$("#boxcycle").val(msg.cycle);
					$("#boxtimeout").val(msg.timeout);
					$("#boxname").val(msg.name);
					$("#boxpstationid").val(msg.pstationid);
					$("#boxaddress").val(msg.address);
					$("#boxmanufid").val(msg.manufid);
					$("#boxfactid").val(msg.factid);
					$("#boxproductid").val(msg.productid);
					$("#boxmainparameter").val(msg.mainparameter);
					$("#boxstatus").val(msg.status);
					$("#boxserialnumber").val(msg.serialnumber);
					$("#boxhostaddr").val(msg.hostaddr);
					if(msg.begindate){
					$("#boxbegindate").val(dateFormat(msg.begindate));
					}
					if(msg.enddate){
					$("#boxenddate").val(dateFormat(msg.enddate));
					}
					getBelongFactory();
					getStation();
					getboxManufactureList();
				}
			});
		} else {
			getBelongFactory();
			getStation();
			getboxManufactureList();
		}
	}

	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd");
		return time;
	}
	var getBelongFactory = null; 
	var getboxManufactureList = null, getProductList = null,getboxPrompt;
	app.controller('BoxChangeCtrl',['$http','toaster','$scope','$stateParams','$state',
	                                function($http,toaster, $scope, $stateParams, $state) {
  		$scope.boxfactChange = function() {
			b = angular.copy($scope.boxfactd.selected.id);
			$("#boxfactid").val(b);
		}
  		//选择厂区
  		getBelongFactory = $scope.getBelongFactory = function() {
			$scope.station = null;
			$scope.station = {};
			$scope.stationd=null;
			$scope.stationd={};
			$scope.boxfact = null;
			$scope.boxfact = {};
			$scope.boxfactd = null;
			$scope.boxfactd = {};
			    $http({
						method : "POST",
						url : "${ctx}/PowerStation/selectByParentId.htm",
						params : {
					    "parentid":$("#boxpstationid").val()
						}
					}).success(
							function(result) {
								$scope.boxfact = result;
								if ($("#boxfactid").val()) {
									$scope.boxfact.unshift({pstationid : "",stationname : '请选择'});
									$scope.boxfactd.selected = {stationname : $scope.boxfact[0].pstationname,id : $scope.boxfact[0].id};
									for (var i = 0, len = $scope.boxfact.length; i < len; i++) {
										if ($scope.boxfact[i].id == $("#boxfactid").val()) {
											$scope.boxfactd.selected = {stationname : $scope.boxfact[i].stationname,id : $("#boxfactid").val()};
										}
									}
								} 
							});
							}
								
							
		
								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.manufacturer = null;
								$scope.productd = {};
								$scope.product = null;

								$scope.boxmanufChange = function() {
									$("#boxmanufid").val($scope.manufacturerd.selected.id);
									$scope.getProductList();
								}
								
								getboxManufactureList= $scope.getboxManufactureList= function() {
									$scope.manufacturer = null;
									$scope.manufacturerd.selected = {manufname : null,id : null};
									$scope.product = null;
									$scope.productd.selected = {productname : null,id : null};
									$http({
										method : "POST",
												url : "${ctx}/Manufacturer/selectAll.htm",
												params : {
													devicetype: 3
												}
											}).success(
													function(result) {
														$scope.manufacturer = result;
														if ($scope.manufacturer.length > 0) {
															$scope.manufacturer.unshift({id : "",manufname : '请选择'});
															$scope.manufacturerd.selected = {manufname : $scope.manufacturer[0].manufname,id : $scope.manufacturer[0].id};
														}

														if ($("#boxmanufid").val()) {
															for (var i = 0, len = $scope.manufacturer.length; i < len; i++) {
																if ($scope.manufacturer[i].id == $("#boxmanufid").val()) {
																	$scope.manufacturerd.selected = {manufname : $scope.manufacturer[i].manufname,id : $("#boxmanufid").val()};
																}
															}
														}

														if ($("#boxmanufid").val() != null && $("#boxmanufid").val() != "") {
															$scope.boxmanufChange();
														}
													});
								}
								$scope.boxproductChange = function() {
									$("#boxproductid").val($scope.productd.selected.id);
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
											}).success(
													function(resultproduct) {
														$scope.product = resultproduct;
														if ($scope.product.length > 0) {
															$scope.product.unshift({id : null,productname : '请选择'});
														}
														
														var clearProductFlag = true;
														if ($("#boxproductid").val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $("#boxproductid").val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {productname : $scope.product[i].productname,specification : $scope.product[i].specification,id : $("#boxproductid").val()};
																}
															}
															if (clearProductFlag) {
																$scope.productd.selected = {
																	productname : $scope.product[0].productname,specification : $scope.product[0].specification,id : $scope.product[0].id};
																$("#boxproductid").val($scope.productd.selected.id);
															}
														} else {
															$scope.productd.selected = {productname : $scope.product[0].productname,specification : $scope.product[0].specification,id : $scope.product[0].id};
														}

													});
								}
								//所属厂商、产品---------------------------end----------------------------------
								
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
					$("#boxpstationid").val(uerstation.pstationid);
				}
			}
		});
	}
		
</script>

