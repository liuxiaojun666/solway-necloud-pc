<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div ng-controller="inverterEditCtrl"  class="modal fade" id="inverterModal" tabindex="-1" role="dialog" aria-labelledby="inverterModal" aria-hidden="true">
 <div class="modal-dialog modal-lg">
      <div class="modal-content ">
		<div class="modal-body">
		<div class="">
			<span class="font-h4 blue-1 m-n text-black">编辑逆变器信息</span>
		</div>
		<div class="wrapper-md ng-scope">
			<div class="panel panel-default">
				<div class="row wrapper">
					<!-- form 开始 -->
					<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/Inverter/update.htm" method="post" id="editInverterForm" name="editInverterForm">
						<input type="hidden" name="id" id="inverterid" class="formData" />
						<input type="hidden" name="maskCode" id="maskCodeInv"  class="formData" />
						<input type="hidden" id="junbatterygcountInv" name="batterygcount" class="formData">
						<input type="hidden" name="junid" id="junidInv"  class="formData" />
						 <input type="hidden" name="serialnumber" value="" id="inverterserialnumber" class="formData" />
						 <input type="hidden" name="deviceSN" value="" id="deviceSN" class="formData" />
						<div class="form-group">
							<label class="col-lg-2 control-label">设备编号</label>
							<div class="col-lg-4">
								<input type="text" id="invertercode" maxlength="50" name="code"
									class="form-control formData" 
									onkeyup="value=value.replace(/^\s*$/g,'')">

							</div>
							<label class="col-lg-2 control-label">设备名称</label>
							<div class="col-lg-4">
								<input type="text" id="invertername" maxlength="20" name="name"
									class="form-control formData" onkeyup="value=value.replace(/^\s*$/g,'')">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label">所属厂区</label>
							<div class="col-lg-4">
								<ui-select ng-model="factd.selected" theme="bootstrap"
									ng-change="factChange()"> <ui-select-match
									placeholder="请输入关键字..." ng-model="factd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
								<ui-select-choices repeat="item in fact | filter: $select.search">
								<div ng-bind-html="item.stationname | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
							</div>
							<input type="hidden" id="inverterpstationid" name="pstationid" >
							<input  type="hidden" id="inverterfactid" name="factid" class="formData">
							<label class="col-lg-2 control-label">安装位置</label>
							<div class="col-lg-4">
								<input type="text" id="inverteraddress" name="address" maxlength="50"
									class="form-control formData">
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
								<input type="hidden" id="invertermanufid" name="manufid" class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">产品型号</label>
							<div class="col-lg-4">
								<ui-select ng-model="productd.selected" theme="bootstrap"
									ng-change="productChange()"> <ui-select-match
									placeholder="请输入关键字..."
									ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
								<ui-select-choices
									repeat="item in product | filter: $select.search">
								<div
									ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden"  id="inverterproductid" name="productid" class="form-control formData">
								 <input type="hidden" id="invertercapacity" name="capacity" class="form-control formData">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label">所属箱变</label>
							<div class="col-lg-4">
								<ui-select ng-model="boxchanged.selected" theme="bootstrap"
									ng-change="boxChange()"> <ui-select-match
									placeholder="请输入关键字..." ng-model="boxchanged.selected.name">{{$select.selected.name}}</ui-select-match>
								<ui-select-choices
									repeat="item in boxchangeList | filter: $select.search">
								<div ng-bind-html="item.name | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden" id="inverterboxchangeid" name="boxchangeid" class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">接入容量</label>
							<div class="col-lg-3">
							<span>
								<input type="text" id="inverterrealcapacity" name="realcapacity" maxlength="12"
									onchange="numFix(this.id);" class="form-control formData">
							</span>
							</div>
							<label class="col-lg-1 no-padder m-t-xs control-label text-left">(kW)</label>
						</div>
						 <div class="form-group">
							<label class="col-lg-2 control-label">是否小逆</label>
							<div class="col-lg-10" id="addInvt">
								<label class="checkbox-inline i-checks" > 
									<input
									type="radio" name="hasJBN" id="hasJB0" value="0"
									class="form-control" checked onclick="addInvt('0')"> <i></i> 否
								</label> 
								<label class="checkbox-inline i-checks"> <input
									type="radio" name="hasJBN" id="hasJB1" value="1"
									class="form-control " onclick="addInvt('1')"> <i></i> 是
								</label>
							</div>
							<div class="col-lg-10" id="editInvt" hidden style="line-height: 32px;"></div>
							<input type="hidden" name="hasJB" id="hasJB" value="0">
						</div>
					<div class="form-group" id="maskCode1Inv" hidden>
						<label class="col-lg-2 control-label">组串掩码</label>
						<div class="col-lg-10">
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="0"  class="form-control">  <i></i> 1
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="1"  class="form-control">  <i></i> 2
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="2"  class="form-control" >  <i></i> 3
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv"  value="3"  class="form-control">  <i></i> 4
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="4"  class="form-control">  <i></i> 5
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="5"  class="form-control">  <i></i> 6
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="6"  class="form-control" >  <i></i> 7
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv"  value="7"  class="form-control">  <i></i> 8
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="8"  class="form-control" >  <i></i> 9
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv"  value="9"  class="form-control">  <i></i> 10
							 </label>
						</div>
					</div>
					<div class="form-group" id="maskCode2Inv" hidden>
						<label class="col-lg-2 control-label"></label>
						<div class="col-lg-10">
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="10"  class="form-control">  <i></i> 11
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="11"  class="form-control">  <i></i> 12
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="12"  class="form-control" >  <i></i> 13
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv"  value="13"  class="form-control">  <i></i> 14
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="14"  class="form-control">  <i></i> 15
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="15"  class="form-control">  <i></i> 16
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="16"  class="form-control" >  <i></i> 17
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv"  value="17"  class="form-control">  <i></i> 18
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv" value="18"  class="form-control" >  <i></i> 19
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckInv"  value="19"  class="form-control">  <i></i> 20
							 </label>
						</div>
					</div>
						 <div class="form-group">
							<label class="col-lg-2 control-label">逆变器室</label>
							<div class="col-lg-4">
								<input type="text" id="inverterinverterroom" maxlength="50"
									name="inverterroom" class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">逆变器组</label>
							<div class="col-lg-4">
								<input type="text" id="inverterinvertergid" maxlength="50"
									name="invertergid" class="form-control formData">
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label">安装时间</label>
							<div class="col-lg-4">
								<input type="text" id="inverterbegindate" name="begindate"
									class="form-control formData">
							</div>
							<label class="col-lg-2 control-label">停用时间</label>
							<div class="col-lg-4">
								<input type="text" id="inverterenddate" name="enddate"
									class="form-control formData">
							</div>
						</div>
					  <div class="form-group">
						<label class="col-lg-2 control-label">采集周期</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="5000" id="invertercycle" name="cycle" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label no-padder m-t-xs  text-left">毫秒</label>
              			
              			<label class="col-lg-2 control-label">超时时间</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="3000" id="invertertimeout" name="timeout" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label no-padder m-t-xs text-left">毫秒</label>
					 </div>
						<div class="form-group">
							<label class="col-lg-2 control-label">主要参数</label>
							<div class="col-lg-10">
								<textarea rows="2" id="invertermainparameter" maxlength="20"
									name="mainparameter" class="form-control formData"></textarea>

							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-2 control-label">检修工艺卡</label>
							<div class="col-lg-10">
								<textarea rows="2" id="inverterrepaircard" maxlength="50"
									name="repaircard" class="form-control formData"></textarea>
							</div>
						</div>
						<div class="form-group m-t-sm">
							<div id="inverternotonly" class="hidden text-center m-b-sm">
								<font color="#FF0000">所属汇流箱下，设备编号必须唯一</font>
							</div>
							<div class="col-lg-12 text-center">
								<button type="button" onclick="saveInverterForm();" id="saveButton"
									class="  btn m-b-xs w-xs   btn-info">
									<strong>保 存</strong>
								</button>
								<button id="cancelBtn" type="button"
									class=" m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
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
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	$(function() {
		$("#editInverterForm").validate({
			rules : {
				code : {
					//number : true,
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
					required : true,
					number : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.type == "error") {
							$("#inverternotonly").removeClass('hidden');
						} {
							hideModal("inverterModal");
							promptObj(json.type, '', json.message);
							$("#searchInverterBtn").trigger("click");
						} 
					},
					error : function(json) {
						hideModal("inverterModal");
						promptObj("error", '', "操作失败,请稍后重试");
					}
				};
				
				var hasJB = $("#hasJB").val();
				//当属于小逆时
				if(hasJB == '1'){
					var relist = maskCodeParseInvRe();
					$("#junbatterygcountInv").val(relist[0]);
					$("#maskCodeInv").val(relist[1]);
				}
				$('#editInverterForm').ajaxSubmit(options);
			}
		});
	});

	function saveInverterForm() {
		$("#editInverterForm").trigger("submit");
	}

	//日期控件 
	$('#inverterbegindate')
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
	$('#inverterenddate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		startDate : new Date(),
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	
	//初始化页面数据
	function initInverterData(id) {
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
					$("#inverterid").val(msg.id);
					$("#invertercode").val(msg.code);
					$("#invertername").val(msg.name);
					$("#inverterpstationid").val(msg.pstationid);
					$("#inverterfactid").val(msg.factid);
					$("#inverterboxchangeid").val(msg.boxchangeid);
					$("#inverterinverterroom").val(msg.inverterroom);
					$("#inverterinvertergid").val(msg.invertergid);
					$("#inverteraddress").val(msg.address);
					$("#inverterrepaircard").val(msg.repaircard);
					$("#invertermanufid").val(msg.manufid);
					$("#inverterproductid").val(msg.productid);
					$("#invertermainparameter").val(msg.mainparameter);
					$("#inverterserialnumber").val(msg.serialnumber);
					$("#inverterrealcapacity").val(msg.realcapacity);
					$("#invertercapacity").val(msg.capacity);
					$("#inverterhostaddr").val(msg.hostaddr);
					$("#inverterbusid").val(msg.busid);
					$("#inverterprotocolid").val(msg.protocolid);
					$("#invertercycle").val(msg.cycle);
					$("#invertertimeout").val(msg.timeout);
					if(msg.begindate){
					$("#inverterbegindate").val(dateFormat(msg.begindate));
					}
					if(msg.enddate){
					$("#inverterenddate").val(dateFormat(msg.enddate));
					}
					$("#deviceSN").val(msg.deviceSN);
					
					/**var hasJB = msg.hasJB
					var ridaoleng = document.editInverterForm.hasJB.length;
					for (var i = 0; i < ridaoleng; i++) {
						if (hasJB == document.editInverterForm.hasJB[i].value) {
							document.editInverterForm.hasJB[i].checked = true
						}
						//document.editInverterForm.hasJB[i].disabled = true
					}*/
					
					$("#hasJB").val(msg.hasJB)
					if(msg.hasJB == '1'){
						document.editInverterForm.hasJBN[1].checked = true;
						//$("#editInvt").html('是');
						$("#junidInv").val(msg.junid);
						//$("#maskCode1Inv").show();
						//$("#maskCode2Inv").show();
						var maskCode = msg.maskCode;
						if(maskCode){
							maskCodeParseInv(maskCode);
						}else{
							maskCodeParseInv(0);
						}
						
					}else{
						document.editInverterForm.hasJBN[0].checked = true;
						//$("#maskCode1Inv").hide();
						//$("#maskCode2Inv").hide();
						//$("#editInvt").html('否');
					}
					
					//$("#addInvt").hide();
					//$("#editInvt").show();
					getInverterManufacture();
					getInverterFactory();
					getInverterList();
				}
			});
		} else {
			//$("#addInvt").show();
			//$("#editInvt").hide();
			
			//$("#maskCode1Inv").hide();
			//$("#maskCode2Inv").hide();
			//默认选中前16串
			maskCodeParseInv(65535);
			document.editInverterForm.hasJBN[0].checked = true;
			$("#hasJB").val('0');
			getInverterList();
			getInverterManufacture();
			getInverterFactory();
		}
	}
	
	function addInvt(v){
		/**if(v == '1'){
			$("#maskCode1Inv").show();
			$("#maskCode2Inv").show();
		}else{
			$("#maskCode1Inv").hide();
			$("#maskCode2Inv").hide();
		}*/
		$("#hasJB").val(v)
	}
	
	//根据组串掩码整型值选中复选框
	function maskCodeParseInv(maskCode){
		for(var i=0;i<20;i++){
			if(((1<<i)&maskCode)>0){
				$("input[name='maskCodeCheckInv'][value='"+i+"']").prop("checked", true);
			}else{
				$("input[name='maskCodeCheckInv'][value='"+i+"']").prop("checked", false);
			}
		}
	}
	
	//根据选中复选框得到整型值及有效组串数
	function maskCodeParseInvRe(){
		var arrayObj = new Array();
		var maskCodeInt=0;
		var i=0;
		$("input[name=maskCodeCheckInv]:checked").each(function(){
			i++;
			maskCodeInt += Math.pow(2,parseInt($(this).val()));
	    });
		arrayObj[0]=i;
		arrayObj[1]=maskCodeInt;
		return arrayObj;
	}
	
	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd");
		return time;
	}
	var getInverterList = null, getInverterManufacture = null, getProductList = null,getInverterFactory=null;
	app.controller('inverterEditCtrl',['$http','$location','$rootScope','$scope','$state','$stateParams',
							function($http, $location, $rootScope, $scope,$state, $stateParams) {
								$scope.factChange = function() {
									b = angular.copy($scope.factd.selected.id);
									$("#inverterfactid").val(b);
								}
								$scope.boxchanged = {};
								$scope.boxchangeList = null;
								$scope.boxChange = function() {
									$("#inverterboxchangeid").val(angular.copy($scope.boxchanged.selected.id));
									$("#inverterfactid").val(angular.copy($scope.boxchanged.selected.factid));
									$("#inverterpstationid").val(angular.copy($scope.boxchanged.selected.pstationid));
								}
								
								//选择厂区
						  		getInverterFactory = $scope.getInverterFactory = function() {
									$scope.station = null;
									$scope.station = {};
									$scope.stationd=null;
									$scope.stationd={};
									$scope.fact = null;
									$scope.fact = {};
									$scope.factd = null;
									$scope.factd = {};
									    $http({
												method : "POST",
												url : "${ctx}/PowerStation/selectByParentId.htm",
												params : {
											    "parentid":$("#stationid").val()
												}
											}).success(
													function(result) {
														$scope.fact = result;
														if ($("#inverterfactid").val()) {
															$scope.fact.unshift({pstationid : "",stationname : '请选择'});
															$scope.factd.selected = {stationname : $scope.fact[0].pstationname,id : $scope.fact[0].id};
															for (var i = 0, len = $scope.fact.length; i < len; i++) {
																if ($scope.fact[i].id == $("#inverterfactid").val()) {
																	$scope.factd.selected = {stationname : $scope.fact[i].stationname,id : $("#inverterfactid").val()};
																}
															}
														} 
													});
													}
								
								getInverterList = $scope.getInverterList = function() {
									$scope.boxchanged.selected = {name : null,id : null,pstationid : null,factid : null};
									$http(
											{
												method : "POST",
												url : "${ctx}/BoxChange/selectByStation.htm",
												params : {
													pstationid : $("#inverterpstationid").val()
												}
											}).success(function(result) {
														$scope.boxchangeList = result;
														if (boxChange) {//入口为箱变时，所属箱变默认选中
															$("#inverterboxchangeid").val(boxChange);
														}
														for (var i = 0, len = $scope.boxchangeList.length; i < len; i++) {
															if ($scope.boxchangeList[i].id == $("#inverterboxchangeid").val()) {
																$scope.boxchanged.selected = { name : $scope.boxchangeList[i].name,
																	id : $scope.boxchangeList[i].id,
																	pstationid : $scope.boxchangeList[i].pstationid,
																	factid : $scope.boxchangeList[i].factid
																};
																$scope.boxChange();
															}
														}
													});
								}
								
								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.manufacturer = null;
								$scope.productd = {};
								$scope.product = null;

								getInverterManufacture = $scope.getInverterManufacture = function() {
									$scope.manufacturer = null;
									$scope.manufacturerd.selected = {manufname : null,id : null};
									$scope.product = null;
									$scope.productd = {};
									$http({method : "POST",
										url : "${ctx}/Manufacturer/selectAll.htm",
												params : {
														devicetype: 2
												}
											}).success(function(result) {$scope.manufacturer = result;
														if ($scope.manufacturer != null&& $scope.manufacturer.length > 0) {
															$scope.manufacturer.unshift({id : "",manufname : '请选择'});
															$scope.manufacturerd.selected = {manufname : $scope.manufacturer[0].manufname,id : $scope.manufacturer[0].id};
														}
														if ($("#invertermanufid").val() != null&& $("#invertermanufid").val() != "") {
															for (var i = 0, len = $scope.manufacturer.length; i < len; i++) {
																if ($scope.manufacturer[i].id == $("#invertermanufid").val()) {
																	$scope.manufacturerd.selected = {manufname : $scope.manufacturer[i].manufname,id : $("#invertermanufid").val()};
																}
															}
															$scope.manufChange();
														} 
													});
								}
								
								$scope.manufChange = function() {
									$("#invertermanufid").val($scope.manufacturerd.selected.id);
									$scope.getProductList();
								}
								$scope.productChange = function() {
									$("#inverterproductid").val($scope.productd.selected.id);
									$("#invertercapacity").val($scope.productd.selected.buildcapacity);
								}
								getProductList = $scope.getProductList = function() {
									$scope.product = null;
									$scope.productd = {};
									$http({
												method : "POST",
												url : "${ctx}/Product/selectByManuf.htm",
												params : {
													manufid : $scope.manufacturerd.selected.id,
													devicetype: 2
												}
											}).success(
													function(resultproduct) {
														$scope.product = resultproduct;
														if ($scope.product != null && $scope.product.length > 0) {
															$scope.product.unshift({id : null,productname : '请选择'});
															$scope.productd.selected = {productname : $scope.product[0].productname,specification : $scope.product[0].specification,id : $scope.product[0].id};
														}
														var clearProductFlag = true;
														if ($("#inverterproductid").val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $("#inverterproductid").val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {productname : $scope.product[i].productname,specification : $scope.product[i].specification,
																		id : $("#inverterproductid").val(),buildcapacity : $scope.product[i].buildcapacity
																	};
																	$("#invertercapacity").val($scope.productd.selected.buildcapacity);
																}
															}
															if (clearProductFlag) {
																$("#inverterproductid").val($scope.productd.selected.id);
																$("#invertercapacity").val($scope.productd.selected.buildcapacity);
															}
														} else {
															$scope.productd.selected = {productname : $scope.product[0].productname,specification : $scope.product[0].specification,id : $scope.product[0].id};
															$("#inverterproductid").val($scope.productd.selected.id);
															$("#invertercapacity").val($scope.productd.selected.buildcapacity);
														}

													});
								}
								//所属厂商、产品---------------------------end----------------------------------
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
					$("#inverterpstationid").val(uerstation.pstationid);
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
