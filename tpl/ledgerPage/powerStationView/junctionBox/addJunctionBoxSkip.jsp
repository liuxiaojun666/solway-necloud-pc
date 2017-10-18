<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="JunctionBoxAddCtrl" class="modal fade" id="junctionBoxModal" tabindex="-1" role="dialog" aria-labelledby="inverterModal" aria-hidden="true">
 <div class="modal-dialog modal-lg">
      <div class="modal-content ">
		<div class="modal-body">
	<div class="">
		<span class="font-h4 blue-1 m-n text-black">编辑汇流箱信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/JunctionBox/update.htm" method="post" id="juneditForm" name="juneditForm">
					<input type="hidden" name="id" id="junidJB"  class="formData" />
					<input type="hidden" name="maskCode" id="maskCodeJB"  class="formData" />
					<input type="hidden" id="junbatterygcount" name="batterygcount" class="formData">
					<input type="hidden" id="junserialnumber" value="" name="serialnumber" class="formData" />
					<div class="form-group">
						<label class="col-lg-2 control-label">设备编号</label>
						<div class="col-lg-4">
							<input type="text" id="juncode" maxlength="50" name="code"
								class="form-control formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/\D/g,'')">
						</div>
						<label class="col-lg-2 control-label">设备名称</label>
						<div class="col-lg-4">
							<input type="text" id="junname" maxlength="20" name="name"
								class="form-control formData" onkeyup="value=value.replace(/^\s*$/g,'')">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">所属厂区</label>
						<div class="col-lg-4">
							<ui-select ng-model="factd.selected" theme="bootstrap"
								ng-change="junfactChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="factd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices repeat="item in fact | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
						</div>
						<input type="hidden" id="junpstationid" name="pstationid" >
						<input type="hidden" id="junfactid" name="factid" class="formData">

						<label class="col-lg-2 control-label">所属逆变器</label>
						<div class="col-lg-4">
							<ui-select ng-model="inverterd.selected" theme="bootstrap"ng-change="inverterChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="inverterd.selected.name">{{$select.selected.name}}</ui-select-match>
							<ui-select-choices repeat="item in inverter | filter: $select.search">
							<div ng-bind-html="item.name | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="juninverterid" name="inverterid" class="form-control formData">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">设备厂商</label>
						<div class="col-lg-4">
							<ui-select ng-model="manufacturerd.selected" theme="bootstrap"
								ng-change="manufChange(1)"> <ui-select-match
								placeholder="请输入关键字..."
								ng-model="manufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices
								repeat="item in manufacturer | filter: $select.search">
							<div ng-bind-html="item.manufname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="junmanufid" name="manufid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">产品型号</label>
						<div class="col-lg-4">
							<ui-select ng-model="productd.selected" theme="bootstrap"
								ng-change="productChange(1)"> <ui-select-match
								placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
							<ui-select-choices
								repeat="item in product | filter: $select.search">
							<div
								ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden"  id="junproductid" name="productid" class="form-control formData">
						</div>
					</div>
					
					<!-- <div class="form-group">
						<label class="col-lg-2 control-label">组串数</label>
						<div class="col-lg-4">
							<input type="text" id="junbatterygcount" maxlength="11"
								name="batterygcount" class="form-control formData">
						</div>
					</div> -->
					<div class="form-group">
						<label class="col-lg-2 control-label">组串掩码</label>
						<div class="col-lg-10">
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="0"  class="form-control">  <i></i> 1
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="1"  class="form-control">  <i></i> 2
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="2"  class="form-control" >  <i></i> 3
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB"  value="3"  class="form-control">  <i></i> 4
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="4"  class="form-control">  <i></i> 5
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="5"  class="form-control">  <i></i> 6
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="6"  class="form-control" >  <i></i> 7
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB"  value="7"  class="form-control">  <i></i> 8
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="8"  class="form-control" >  <i></i> 9
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB"  value="9"  class="form-control">  <i></i> 10
							 </label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label"></label>
						<div class="col-lg-10">
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="10"  class="form-control">  <i></i> 11
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="11"  class="form-control">  <i></i> 12
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="12"  class="form-control" >  <i></i> 13
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB"  value="13"  class="form-control">  <i></i> 14
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="14"  class="form-control">  <i></i> 15
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="15"  class="form-control">  <i></i> 16
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="16"  class="form-control" >  <i></i> 17
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB"  value="17"  class="form-control">  <i></i> 18
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB" value="18"  class="form-control" >  <i></i> 19
							 </label>
							 <label class="checkbox-inline i-checks col-lg-1">
								 <input type="checkbox" name="maskCodeCheckJB"  value="19"  class="form-control">  <i></i> 20
							 </label>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">安装时间</label>
						<div class="col-lg-4">
							<input type="text" id="junbegindate" name="begindate"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">停用时间</label>
						<div class="col-lg-4">
							<input type="text" id="junenddate" name="enddate"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">安装位置</label>
						<div class="col-lg-4">
							<input type="text" id="junaddress" maxlength="20" name="address" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">光伏组件</label>
						<div class="col-lg-4">
							<label class="checkbox-inline i-checks"> <input
								type="radio" name="materialtype" id="junmaterialtype0" value="00"
								class="form-control"> <i></i> 单晶
							</label> <label class="checkbox-inline i-checks"> <input
								type="radio" name="materialtype" id="junmaterialtype1" value="01"
								class="form-control "> <i></i> 多晶
							</label> <label class="checkbox-inline i-checks"> <input
								type="radio" name="materialtype" id="junmaterialtype2" value="02"
								class="form-control "> <i></i> 薄膜
							</label>

						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">电池板厂商</label>
						<div class="col-lg-4">
							<ui-select ng-model="batterymanufacturerd.selected" theme="bootstrap"
								ng-change="manufChange(7)"> <ui-select-match
								placeholder="请输入关键字..."
								ng-model="batterymanufacturerd.selected.manufname">{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices
								repeat="item in batterymanufacturer | filter: $select.search">
							<div ng-bind-html="item.manufname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="junbatterymanufid" maxlength="11"
								name="batterymanufid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">电池板型号</label>
						<div class="col-lg-4">
							<ui-select ng-model="batteryproductd.selected" theme="bootstrap"
								ng-change="productChange(7)"> <ui-select-match
								placeholder="请输入关键字..." ng-model="batteryproductd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
							<ui-select-choices
								repeat="item in batteryproduct | filter: $select.search">
							<div
								ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="junbatteryprodid" name="batteryprodid" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">电池板功率(kW)</label>
						<div class="col-lg-4">
							<input type="text" id="junbatterypower" name="batterypower"
								class="form-control formData">
						</div>
						<!--                <label class="col-lg-1 control-label p-l-n ">kw</label> -->
						<label class="col-lg-2 control-label">每串电池板数</label>
						<div class="col-lg-4">
							<input  type="text" id="junbatterycount" name="batterycount" maxlength="11"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">采集周期</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="5000" id="juncycle" name="cycle" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label text-left">毫秒</label>
              			<label class="col-lg-2 control-label">超时时间</label>
              			<div class="col-lg-3">
               	 			<input type="text" value="3000" id="juntimeout" name="timeout" maxlength="11" class="form-control formData" placeholder="请输入整数" onkeyup="value=value.replace(/\D/g,'')">
              			</div>
              			<label class="col-lg-1 control-label text-left">毫秒</label>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">主要参数</label>
						<div class="col-lg-10">
							<textarea rows="2" id="junmainparameter" maxlength="20"
								name="mainparameter" class="form-control formData"></textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">检修工艺卡</label>
						<div class="col-lg-10">
							<textarea rows="2" id="junstandardoper" maxlength="20"
								name="standardoper" class="form-control formData"></textarea>
						</div>
					</div>

					<div class="form-group m-t-sm">
					<div id="junnotonly"  class="hidden text-center m-b-sm"><font color="#FF0000">所属逆变器下，设备编号必须唯一</font></div>
						<div class="col-lg-12 text-center">
							<button type="button" onclick="saveFormJunction();" id="saveButton" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
							<button id="cancelBtn" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"> <strong>取消</strong> </button>
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
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	$(function() {
		$("#juneditForm").validate({
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
				inverterid : {
					required : true,
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
					required : true,
					number : true,
					maxlength : 10
				},
				deviationrange: {
					required : true,
					number : true,
					maxlength : 10
				},
				
				batterygcount : {
					number : true
				},
				batteryprodparameter : {
					maxlength : 20
				},
				checkstartdate : {
					required : true,
					dateVerify:true
				},
				checkenddate : {
					required : true,
					dateVerify:true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.type == "error") {
							$("#junnotonly").removeClass('hidden');
						}else{
							hideModal("junctionBoxModal");
							promptObj(json.type, '',json.message);
							$("#searchjunBtn").trigger("click");
						}
					},
					error : function(json) {
						hideModal("junctionBoxModal");
						$("#searchjunBtn").trigger("click");
					}
				};
				var relist = maskCodeParseJBRe();
				$("#junbatterygcount").val(relist[0]);
				$("#maskCodeJB").val(relist[1]);
				$('#juneditForm').ajaxSubmit(options);
			}
		});
	});

	function saveFormJunction() {
		$("#juneditForm").trigger("submit");
	}


	//初始化页面数据
	function initJunctionData(id) {
		$(".formData").val("");
		if (id != "" && id != null) {
			$("#id").val(id);
			   $.ajax({
						type : "post",
						url : "${ctx}/JunctionBox/selectById.htm",
						data : {
							"id" : id
						},success : function(msg) {
							$("#junidJB").val(msg.id);
							$("#juncode").val(msg.code);
							$("#jundevicename").val(msg.name);
							$("#junname").val(msg.name);
							$("#junpstationid").val(msg.pstationid);
							$("#junfactid").val(msg.factid);
							$("#juninverterid").val(msg.inverterid);
							$("#junaddress").val(msg.address);
							$("#junmanufid").val(msg.manufid);
							$("#junproductid").val(msg.productid);
							$("#junmainparameter").val(msg.mainparameter);
							$("#junstatus").val(msg.status);
							$("#junstandardoper").val(msg.standardoper);
							$("#junbatterypower").val(msg.batterypower);
							$("#junbatterycount").val(msg.batterycount);
							$("#junbatterygcount").val(msg.batterygcount);
							$("#junmaterialtype").val(msg.materialtype);
							$("#junbatterymanufid").val(msg.batterymanufid);
							$("#junbatteryprodid").val(msg.batteryprodid);
							$("#junbatteryprodparameter").val(msg.batteryprodparameter);
							$("#junserialnumber").val(msg.serialnumber);
							$("#junhostaddr").val(msg.hostaddr);
							$("#junbusid").val(msg.busid);
							$("#juncycle").val(msg.cycle);
							$("#juntimeout").val(msg.timeout);
							if(msg.begindate){
							$("#junbegindate").val(dateFormat(msg.begindate));
							}
							if(msg.enddate){
							$("#junenddate").val(dateFormat(msg.enddate));
							}
							var materialtype = msg.materialtype
							var ridaoleng = document.juneditForm.materialtype.length;
							for (var i = 0; i < ridaoleng; i++) {
								if (materialtype == document.juneditForm.materialtype[i].value) {
									document.juneditForm.materialtype[i].checked = true
								}
							}
							var maskCode = msg.maskCode;
							if(maskCode){
								maskCodeParseJB(maskCode);
							}else{
								maskCodeParseJB(0);
							}
							getjunStation();
							getjunManufactureList(1);
							getjunManufactureList(7);
							getjunFactory();
							getjunInverterList();
						}
					});
		} else {
			//默认选中前16串
			maskCodeParseJB(65535);
			getjunStation();
			getjunManufactureList(1);
			getjunManufactureList(7);
			getjunFactory();
			getjunInverterList();
		}
	}
	//根据组串掩码整型值选中复选框
	function maskCodeParseJB(maskCode){
		for(var i=0;i<20;i++){
			if(((1<<i)&maskCode)>0){
				$("input[name='maskCodeCheckJB'][value='"+i+"']").prop("checked", true);
			}else{
				$("input[name='maskCodeCheckJB'][value='"+i+"']").prop("checked", false);
			}
		}
	}
	
	//根据选中复选框得到整型值及有效组串数
	function maskCodeParseJBRe(){
		var arrayObj = new Array();
		var maskCodeInt=0;
		var i=0;
		$("input[name=maskCodeCheckJB]:checked").each(function(){
			i++;
			maskCodeInt += Math.pow(2,parseInt($(this).val()));
	    });
		arrayObj[0]=i;
		arrayObj[1]=maskCodeInt;
		return arrayObj;
	}
	//日期控件
	$('#junbegindate')
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
	$('#junenddate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		startDate : new Date(),
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});

	function getjunStation() {
		$.ajax({
			type : "post",
			url : "${ctx}/Login/getLoginUser.htm",
			dataType : "json",
			async : false,
			success : function(uerstation) {
				if (uerstation.dataScope != "1"
						&& uerstation.pstationid != null) {
					$("#junpstationid").val(uerstation.pstationid);
				}
			}
		});
	}
	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd");
		return time;
	}
	var  getManufactureList = null, getProductList = null;
    var getjunInverterList;
	var getjunManufactureList; var getjunFactory;
	app.controller('JunctionBoxAddCtrl',['$http','$location','$rootScope','$scope','$state','$stateParams',
							function($http, $location, $rootScope, $scope,$state, $stateParams) {

		$scope.junfactChange = function() {
			b = angular.copy($scope.factd.selected.id);
			$("#junfactid").val(b);
		}

		//选择厂区
  		getjunFactory = $scope.getjunFactory = function() {
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
					    "parentid":$("#junpstationid").val()
						}
					}).success(
							function(result) {
								$scope.fact = result;
								if ($("#junfactid").val()) {
									$scope.fact.unshift({pstationid : "",stationname : '请选择'});
									$scope.factd.selected = {stationname : $scope.fact[0].pstationname,id : $scope.fact[0].id};
									for (var i = 0, len = $scope.fact.length; i < len; i++) {
										if ($scope.fact[i].id == $("#junfactid").val()) {
											$scope.factd.selected = {stationname : $scope.fact[i].stationname,id : $("#junfactid").val()};
										}
									}
								}
							});
							}



								$scope.inverterd = {};
								$scope.inverter = null;
								$scope.inverterChange = function() {
									$("#juninverterid").val(angular.copy($scope.inverterd.selected.id));
									$("#junfactid").val(angular.copy($scope.inverterd.selected.factid));
									$("#junpstationid").val(angular.copy($scope.inverterd.selected.pstationid));
								}

								getjunInverterList = $scope.getInverterList = function() {
									$scope.inverterd.selected = {name : null,id : null,pstationid : null,factid : null};
									$scope.inverter = null;
									$http({
												method : "POST",
												url : "${ctx}/Inverter/selectByStationNoXiaoNi.htm",
												params : {
													pstationid : $("#junpstationid").val()
												}
											}).success(
													function(result) {
														$scope.inverter = result;
														for (var i = 0, len = $scope.inverter.length; i < len; i++) {
															if ($scope.inverter[i].id == $("#juninverterid").val()) {
																$scope.inverterd.selected = {
																		name : $scope.inverter[i].name,id : $("#juninverterid").val(),pstationid :
																		$scope.inverter[i].pstationid,factid : $scope.inverter[i].factid
																};
																$scope.inverterChange();
															}
														}
													});
								}
								//所属厂商、产品---------------------------start----------------------------------
								$scope.manufacturerd = {};
								$scope.manufacturer = null;
								$scope.productd = {};
								$scope.product = null;
								$scope.batteryproductd={};
								$scope.batterymanufacturerd=null;
								$scope.batterymanufacturerd={};
								getjunManufactureList = $scope.getManufactureList = function(type) {
									$scope.manufacturer = null;
									$scope.batterymanufacturer = null;
									$scope.manufacturerd.selected = {manufname : null,id : null};
									$scope.product = null;
									$scope.productd.selected = {productname : null,id : null};

									$http({
												method : "POST",
												url : "${ctx}/Manufacturer/selectAll.htm",
												params : {
													devicetype: type
												}
											}).success(
													function(result) {
														if(type==1){
														$scope.manufacturer = result;
														if ($scope.manufacturer != null && $scope.manufacturer.length > 0) {
															$scope.manufacturer.unshift({id : "",manufname : '请选择'});
														}
														if ($("#junmanufid").val() != null && $("#junmanufid").val() != "") {
															for (var i = 0, len = $scope.manufacturer.length; i < len; i++) {
																if ($scope.manufacturer[i].id == $("#junmanufid").val()) {
																	$scope.manufacturerd.selected = {
																		manufname : $scope.manufacturer[i].manufname,id : $("#junmanufid").val()
																	};
																}
															}
															$scope.manufChange(type);
														} else {
															$scope.manufacturerd.selected = {manufname : $scope.manufacturer[0].manufname,id : $scope.manufacturer[0].id};
														}
														}else if(type==7){
															$scope.batterymanufacturer = result;
															if ($scope.batterymanufacturer != null && $scope.batterymanufacturer.length > 0) {
																$scope.batterymanufacturer.unshift({id : "",manufname : '请选择'});
															}

															if ($("#junbatterymanufid").val() != null && $("#junbatterymanufid").val() != "") {
																for (var i = 0, len = $scope.batterymanufacturer.length; i < len; i++) {
																	if ($scope.batterymanufacturer[i].id == $("#junbatterymanufid").val()) {
																		$scope.batterymanufacturerd.selected = {
																			manufname : $scope.batterymanufacturer[i].manufname,id : $("#junbatterymanufid").val()
																		};
																	}
																}
																$scope.manufChange(type);
															} else {
																$scope.batterymanufacturerd.selected = {manufname : $scope.batterymanufacturer[0].manufname,id : $scope.batterymanufacturer[0].id};
															}
														}
													});
													}


								$scope.manufChange = function(type) {
									if(type==1){
									$("#junmanufid").val($scope.manufacturerd.selected.id);
									$scope.getProductList(type);
									}else if(type==7){
									$("#junbatterymanufid").val($scope.batterymanufacturerd.selected.id);
									$scope.getProductList(type);
									}
								}
								$scope.productChange = function(type) {
									if(type==1){
									$("#junproductid").val($scope.productd.selected.id);
									}else if(type==7){
									$("#junbatteryprodid").val($scope.batteryproductd.selected.id);
									}
									}

								getProductList = $scope.getProductList = function(type) {
									if(type==1){
										$scope.manufid=$scope.manufacturerd.selected.id
									}else if(type==7){
										$scope.manufid=$scope.batterymanufacturerd.selected.id
										if($scope.manufid =="" || $scope.manufid==null){
											$("#junbatteryprodid").val("");
										}
									}
									$scope.product = null;
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
														if ($("#junproductid").val()) {
															for (var i = 0, len = $scope.product.length; i < len; i++) {
																if ($scope.product[i].id == $("#junproductid").val()) {
																	clearProductFlag = false;
																	$scope.productd.selected = {productname : $scope.product[i].productname,
																		specification : $scope.product[i].specification,
																		id : $("#junproductid").val()
																	};
																}
															}
														} else {
															$scope.productd.selected = {
																productname : $scope.product[0].productname,
																specification : $scope.product[0].specification,
																id : $scope.product[0].id
															};
														}
														}else if(type==7){
															$scope.batteryproduct = resultproduct;
															if ($scope.batteryproduct) {
															$scope.batteryproduct.unshift({id : null,productname : '请选择'});
															}

															if ($("#junbatteryprodid").val()) {
																for (var i = 0, len = $scope.batteryproduct.length; i < len; i++) {
																	if ($scope.batteryproduct[i].id == $("#junbatteryprodid").val()) {
																		$scope.batteryproductd.selected = {productname : $scope.batteryproduct[i].productname,
																			specification : $scope.batteryproduct[i].specification,id : $("#junbatteryprodid").val()};
																	}
																}
															}else {
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


								$scope.backJunctionBox = function() {
									$state.go('app.junctionBox');
								}
							} ]);
</script>
