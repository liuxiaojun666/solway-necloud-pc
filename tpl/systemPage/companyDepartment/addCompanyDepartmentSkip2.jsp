	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css">
	<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

	<style>
		.form-group {padding-left: 2%;padding-right: 2%;}
		.form-group .h5 {margin-left: -2%;margin-right: -2%;}
		.upImgShow {width: 200px;height: 120px;border: 1px solid #ccc;background: url("${ctx}/theme/images/power-index/i_add_list.jpg") no-repeat center;}
		.checkbox_group .btn {background-color: #fff;border: 1px solid #ccc;}
		.btn_crrent, .checkbox_group .btn.active {background-color: #22c1aa;border-color: #22c1aa;color: #fff;}
		.btn_crrent:hover,.btn_crrent:focus {color: #fff;}
		#companytype-error {position: absolute;top: 100%;margin-top: 2px;}
	</style>
	<div ng-controller="addCompanyDepartmentCtrl" class="wrapper-md ng-scope">
		<div ng-controller="RegionCtrl" class="panel panel-default">
			<div class="wrapper">
				<!-- form 开始 -->
				<form class="bs-example form-horizontal ng-pristine ng-valid mhori_none" action="${ctx}/Company/updateInfo.htm" method="post" id="editForm" name="editForm">
					<input type="hidden" name="comId" value="{{$stateParams.cmId}}" id="comId" class="formData"/>
					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">基本信息</div>
						<label class="col-lg-1 control-label">企业编码</label>
						<div class="col-lg-3">
							<input readonly="readonly" type="text" id="comCode" name="comCode" maxlength="30" class="form-control formData" placeholder="请输入企业编码">
						</div>
						<label class="col-lg-1 control-label">企业名称</label>
						<div class="col-lg-3">
							<input type="text" id="comName" name="comName" maxlength="30" class="form-control formData" placeholder="请输入企业名称">
						</div>
						<label class="col-lg-1 control-label">企业简称</label>
						<div class="col-lg-3">
							<input type="text" id="comShortName" name="comShortName" maxlength="30" class="form-control formData" placeholder="请输入企业简介">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label">企业法人</label>
						<div class="col-lg-3">
							<input type="text" id="comCorp" name="comCorp" maxlength="30" class="form-control formData" placeholder="请输入法人名称">
						</div>
						<label class="col-lg-1 control-label">企业性质</label>
						<div class="col-lg-2">
							<!-- <ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
								<ui-select-match placeholder="请选择企业性质" ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
								<ui-select-choices  repeat="item in company | filter: $select.search">
									<div ng-bind-html="item.comName | highlight: $select.search"></div>
								</ui-select-choices>
							</ui-select> -->
							<select id="comBctCode" name="comBctCode" class="form-control formData" ></select>
							<!-- <input type="hidden" id="comBctCode" name="comBctCode" class="form-control formData" /> -->
						</div>
						<label class="col-lg-1 col-lg-offset-1 control-label">注册资金</label>
						<div class="col-lg-3">
							<input type="text" id="regMoney" name="regMoney" maxlength="30" class="form-control formData" placeholder="请输入注册资金">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label" style="white-space: nowrap;">管理员账号</label>
						<div class="col-lg-3">
							<input type="hidden" id="adminuserid" name="adminuserid" maxlength="30" class="form-control formData" placeholder="">
							<input type="text" disabled="disabled"  id="adminuserName" name="adminuserName" maxlength="30" class="form-control formData" placeholder="">
						</div>
						<label class="col-lg-1 control-label spacenowrap">接管时间</label>
						<div class="col-lg-3">
							<input type="text" id="admintime" name="admintime" maxlength="30" class="form-control formData" placeholder="">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label">企业类型</label>
						<div class="col-lg-7">
							<ul class="list-inline checkbox_group pull-left padder-r-sm pr">
								<li>
									<button class="btn checkbox_btn" id="isepc1" type="button">EPC</button>
									<input class="pa vh valid-required" id="isepc" name="companytype" type="checkbox" value="EPC">
								</li>
								<li>
									<button class="btn checkbox_btn" id="isservice1" type="button">运维公司</button>
									<input class="pa vh" name="companytype" id="isservice" type="checkbox" value="运维公司">
								</li>
								<li>
									<button class="btn checkbox_btn" id="isowner1" type="button">电站业主</button>
									<input class="pa vh" name="companytype" id="isowner" type="checkbox" value="电站业主">
								</li>
								<li>
									<button class="btn checkbox_btn" id="ismanu1" type="button">设备厂商</button>
									<input class="pa vh" name="companytype" id="ismanu" type="checkbox" value="设备厂商">
								</li>
								<span style="line-height: 34px;">（可多选）</span>
								<div class="valid-error"></div>
							</ul>
						</div>
					</div>

					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">联系信息</div>
						<label class="col-lg-1 control-label brls4_3">联系人</label>
						<div class="col-lg-3">
							<input type="text" id="comCont" name="comCont" maxlength="20" class="form-control formData" placeholder="请输入联系人名称">
						</div>
						<label class="col-lg-1 control-label">联系电话</label>
						<div class="col-lg-3">
							<input type="text" id="comTel" name="comTel"  maxlength="18" placeholder="请输入联系电话" class="form-control formData">
						</div>
						<label class="col-lg-1 control-label brls4_2" >传真</label>
						<div class="col-lg-3">
							<input type="text" id="comFax" name="comFax" maxlength="18" placeholder="请输入传真" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label">电子邮件</label>
						<div class="col-lg-3">
							<input type="text" id="comEmail" name="comEmail"  maxlength="18" placeholder="请输入电子邮箱" class="form-control formData">
						</div>
						<label class="col-lg-1 control-label">二级域名</label>
						<div class="col-lg-3">
							<input type="text" id="subdomains" name="subdomains" maxlength="50" class="form-control formData" placeholder="请填写二级域名">
						</div>
						<label class="col-lg-1 control-label brls4_2">邮编</label>
						<div class="col-lg-3">
							<input type="text" id="comZip" name="comZip" maxlength="6" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')" placeholder="请输入邮编">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label">系统名称</label>
						<div class="col-lg-3">
							<input type="text" id="os_title" name="os_title"  maxlength="50" placeholder="请填写系统名称" class="form-control formData">
						</div>
						<label class="col-lg-1 control-label">英文名称</label>
						<div class="col-lg-3">
							<input type="text" id="os_en_title" name="os_en_title" maxlength="100" class="form-control formData" placeholder="请填写系统英文名称">
						</div>
						<label class="col-lg-1 control-label brls4_2"></label>
						<div class="col-lg-3">

						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label brls4_2">地址</label>
						<div class="col-lg-2">
							<ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
								<ui-select-match placeholder="选择省" ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
								<ui-select-choices  repeat="item in province | filter: $select.search">
									<div ng-bind-html="item.regionName | highlight: $select.search"></div>
								</ui-select-choices>
							</ui-select>
							<input type="hidden" name ="provinceid" id="provinceid"  class="form-control formData"/>
						</div>
						<div class="col-lg-2">
							<ui-select ng-model="cityd.selected" theme="bootstrap" ng-change="cityChange()">
								<ui-select-match placeholder="选择市" ng-model="cityd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
								<ui-select-choices  repeat="item in city | filter: $select.search">
									<div ng-bind-html="item.regionName | highlight: $select.search"></div>
								</ui-select-choices>
							</ui-select>
							<input type="hidden" name ="cityid" id="cityid"  class="form-control formData"/>
						</div>
						<div class="col-lg-2">
							<ui-select ng-model="countyd.selected" theme="bootstrap" ng-change="countyChange()">
								<ui-select-match placeholder="选择县" ng-model="countyd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
								<ui-select-choices  repeat="item in county | filter: $select.search">
									<div ng-bind-html="item.regionName | highlight: $select.search"></div>
								</ui-select-choices>
							</ui-select>
							<input type="hidden" name ="countyid" id="countyid"  class="form-control formData"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-1 control-label">详细地址</label>
						<div class="col-lg-6">
							<input type="text" id="comAddr" name="comAddr" maxlength="50" class="form-control formData" placeholder="请填写详细地址">
						</div>
					</div>
					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">登录页logo(高:500px*100px,通过二级域名访问时有效)</div>
						<div class="col-lg-3 col-lg-offset-1">
							<div id="logolgBtn" class="upImgShow cp">
								<input class="whp opacity cp" accept="image/gif, image/jpeg, image/png, image/ico" type="file" id="updateLogolg" name="file" class="form-control formData" novalidate/>
							</div>
						</div>
						<div class="col-lg-3" style="line-height: 120px; background-color: gainsboro;">
							<img id="showLogolg" style="max-height: 120px;max-width: 200px;" src="" alt="">
							<a href="javascript:deleteLogo('logolg')" class="btn btn-danger btn-sm">删除</a>
						</div>
					</div>
					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">登录页左上角logo(高为100px,通过二级域名访问时有效)</div>
						<div class="col-lg-11 col-lg-offset-1 lh40">

							<label class="checkbox-inline i-checks ">
								<input type="radio"  name="logo_sm_flag" id="logo_sm_flag0" value="0" onclick="checkLogosm('0')" class="form-control " >  <i></i> 显示
							</label>

							<label class="checkbox-inline i-checks">
								<input type="radio" name="logo_sm_flag" checked="true" id="logo_sm_flag1" value="1" onclick="checkLogosm('1')" class="form-control ">  <i></i> 不显示
							</label>
							<br/>
						</div>
						<div class="col-lg-3 col-lg-offset-1">
							<div id="logosmBtn" class="upImgShow cp">
								<input class="whp opacity cp" accept="image/gif, image/jpeg, image/png, image/ico" type="file" id="updateLogosm" name="file" class="form-control formData" novalidate/>
							</div>
						</div>
						<div class="col-lg-3" style="line-height: 120px; background-color: gainsboro;">
							<img id="showLogosm" style="max-height: 120px;max-width: 200px;" src="" alt="">
							<a href="javascript:deleteLogo('logosm')" class="btn btn-danger btn-sm">删除</a>
						</div>
					</div>
					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">logo(高为50px)</div>
						<div class="col-lg-3 col-lg-offset-1">
							<div id="logoBtn" class="upImgShow cp">
								<input class="whp opacity cp" accept="image/gif, image/jpeg, image/png, image/ico" type="file" id="updateLogo" name="file" class="form-control formData" novalidate/>
							</div>
						</div>
						<div class="col-lg-3" style="line-height: 120px;">
							<img id="showLogo" style="max-height: 120px;max-width: 200px;" src="" alt="">
						</div>
					</div>
					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">证件信息</div>
						<div class="col-lg-3 col-lg-offset-1">
							<div class="upImgShow cp">
								<input class="whp opacity cp" type="file" accept="image/gif, image/jpeg, image/png, image/ico" id="updateIdMsg" name="file" class="form-control formData" novalidate/>
							</div>
							<div class="col-lg-3" style="line-height: 120px;">
								<img id="showIdMsg" style="max-height: 120px;max-width: 200px;" src="" alt="">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="h5 bbdashed pl20 lh40 mb20 fb">其他介绍</div>
						<div class="col-lg-8 col-lg-offset-1">
							<textarea rows="3" id="descp" name="descp" maxlength="300" class="form-control formData"></textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-4">
							<button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="backCompany();"><strong>取消</strong></button>
							<button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
							<input type="hidden" id="clickRoute" ng-click="backCompany()">
						</div>
					</div>
				</form>
				<!-- form 结束 -->
			</div>
		</div>
	</div>
	<script src="${ctx}/vendor/jquery/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
	<script type="text/javascript">
		$('#admintime').datetimepicker({
			format: 'yyyy-mm-dd hh:ii',
			language: 'zh-CN',
			autoclose: true
		});
		function convertImgToBase64(url, callback, outputFormat){
			var canvas = document.createElement('CANVAS'),
				ctx = canvas.getContext('2d'),
				img = new Image;
			img.crossOrigin = 'Anonymous';
			img.onload = function(){
				canvas.height = img.height;
				canvas.width = img.width;
				ctx.drawImage(img,0,0);
				var dataURL = canvas.toDataURL(outputFormat || 'image/png');
//				console.log(dataURL);
				callback.call(this, dataURL);
				canvas = null;
				img.src = dataURL;
			}
		};
		//上传log
		var logoPath, idMsgPath;
		function uploadLogo(){
			$('#updateLogo').change(function() {
				$.ajaxFileUpload({
					url: '${ctx}/uploadImage/uploadImageFrom.htm?nodeId=updateLogo', //用于文件上传的服务器端请求地址
					secureuri: false, //是否需要安全协议，一般设置为false
					fileElementId: 'updateLogo',
					formName: "file",
					dataType: 'json', //返回值类型 一般设置为json
					data: {"nodeId": 'updateLogo'},
					success: function (data, status){
						$("#showLogo").attr("src", '${ctx}/'+data.path);
//						var data = jQuery.parseJSON(data)
						if (data.key==0) {
//							console.log(data.path)
							logoPath = data.path;
						} else {
//							console.log(data.msg)
						}
						uploadLogo();
					},
					error: function (data, status, e){
						uploadLogo();
					}
				});
			});
		}
		uploadLogo();

		var customConfig = {};
		function checkLogosm (v) {
			if (v == 0) {
				customConfig.logo_sm_flag = '0';
				$('#logosmBtn').show();
//				$('#showLogosm').parent().show();
			} else {
				if (customConfig.logo_sm_flag)
					delete customConfig.logo_sm_flag;
				if (customConfig.logo_sm)
					delete customConfig.logo_sm;
				$('#logosmBtn').hide();
				$('#showLogosm').attr('src', '');
				$('#showLogosm').parent().hide();
			}
		}
		function deleteLogo (type) {
			if (type == 'logolg') {
				if (customConfig.logo_lg)
					delete customConfig.logo_lg;
				$('#showLogolg').attr('src', '');
				$('#showLogolg').parent().hide();
			}
			if  (type == 'logosm') {
				if (customConfig.logo_sm_flag == '0') {
					if (customConfig.logo_sm)
						delete customConfig.logo_sm;
					$('#showLogosm').attr('src', '');
					$('#showLogosm').parent().hide();
				}
			}
		}
		$(function(){
			$('#os_title').blur(function() {
				var v = $.trim($(this).val());
				if(v) {
					customConfig.os_title = v;
				} else {
					if (customConfig.os_title)
						delete customConfig.os_title;
				}
			})
			$('#os_en_title').blur(function() {
				var v = $.trim($(this).val());
				if(v) {
					customConfig.os_en_title = v;
				} else {
					if (customConfig.os_en_title)
						delete customConfig.os_en_title;
				}
			})
			$(document).on('change', '#updateLogolg', function() {
				$.ajaxFileUpload({
					url: '${ctx}/uploadImage/uploadImageFrom.htm', //用于文件上传的服务器端请求地址
					secureuri: false, //是否需要安全协议，一般设置为false
					fileElementId: 'updateLogolg',
					formName: "file",
					dataType: 'json', //返回值类型 一般设置为json
					data: {"nodeId": 'updateLogolg'},
					success: function (data){
						if (data.key==0) {
							$("#showLogolg").attr("src", '${ctx}/'+data.path);
							$("#showLogolg").parent().show();
							customConfig.logo_lg = data.path;
						}
					}
				});
			});
			$(document).on('change', '#updateLogosm', function() {
				var logo_sm_flag = $('input:radio[name="logo_sm_flag"]:checked').val();
				if (logo_sm_flag == '0') {
					$.ajaxFileUpload({
						url: '${ctx}/uploadImage/uploadImageFrom.htm', //用于文件上传的服务器端请求地址
						secureuri: false, //是否需要安全协议，一般设置为false
						fileElementId: 'updateLogosm',
						formName: "file",
						dataType: 'json', //返回值类型 一般设置为json
						data: {"nodeId": 'updateLogosm'},
						success: function (data){
							if (data.key==0) {
								$("#showLogosm").attr("src", '${ctx}/'+data.path);
								$("#showLogosm").parent().show();
								customConfig.logo_sm = data.path;
							}
						}
					});
				}
			});
		});
		//上传证件信息
		function uploadIdMsg(){
			$('#updateIdMsg').change(function(event) {
				$.ajaxFileUpload({
					url: '${ctx}/uploadImage/uploadImageFrom.htm?nodeId=updateIdMsg', //用于文件上传的服务器端请求地址
					secureuri: false, //是否需要安全协议，一般设置为false
					fileElementId: 'updateIdMsg', //文件上传域的ID
					formName: "file",
					dataType: 'json', //返回值类型 一般设置为json
					data: {nodeId: 'updateIdMsg'},
					success: function (data, status){
						if (data.key==0) {
//							console.log(data.path)
							idMsgPath = data.path;
							$("#showIdMsg").attr("src", '${ctx}/'+data.path);
						} else {
//							console.log(data.msg)
						}
						uploadIdMsg();
					},
					error: function (data, status, e){
						uploadIdMsg();
					}
				});
			});
		}
		uploadIdMsg();

		var validateCom = $("#editForm").validate( {
			rules : {
				comCode:{
					maxlength : 11
				},
				comName:{
					required : true,
					maxlength : 30
				},
				comShortName:{
					required : true,
					maxlength : 20
				},

				comCorp:{
					maxlength : 10
				},
				comBctCode:{
					maxlength : 11
				},
				regMoney:{
					number:true,
					maxlength : 20
				},
				adminuserid:{
					number:true,
					maxlength : 11
				},

				comCont:{
					maxlength : 10
				},
				comTel:{
					phone:true
				},
				comFax:{
					fax:true
				},
				comEmail:{
					maxlength : 60,
					email: true
				},
				comZip:{
					zipcode:true,
					maxlength : 6
				},
				comAddr:{
					maxlength : 200
				},
				descp:{
					maxlength : 200
				},


				comMobile:{
					maxlength : 11
				},
				comCretBy:{
					maxlength : 20
				},
				comParentId:{
					maxlength : 11,
					required:true
				},
				comRgnCode:{
					maxlength : 6
				},
				comStrCode:{
					maxlength : 10
				},
				comSort:{
					maxlength : 10
				}
			},
			messages: {
				comParentId:{remote:'<img width="16" height="16" src="${ctx}/theme/images/validator/check_n.gif">上级机构不能在此机构的子机构中!'}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});

		//企业类型
		$('.checkbox_group').on('click', '.checkbox_btn', function(event) {
			var $this = $(this);
			var $beInput = $this.next();
			$this.toggleClass('active');
			$beInput.prop('checked',!$beInput.prop('checked'));
			// if ($('input[name="companytype"]:checked').length == 0) {
			// 	validateCom.element($('#isepc'));
			// }
		});
		app.controller('addCompanyDepartmentCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
			$scope.backCompany = function(){
				$state.go('app.companyDepartmentInfo');
			};
		}]);

		function saveForm(){
//			console.info(customConfig);
			//$("#editForm").trigger("submit");
			if(validateCom.form()){
				var oFormData = {};
					oFormData.comId = $("#comId").val()
					oFormData.comCode = $('#comCode').val();
					oFormData.comName = $('#comName').val();
					oFormData.comShortName = $('#comShortName').val();
					oFormData.comCorp = $('#comCorp').val();
					oFormData.comBctCode = $('#comBctCode').val();//企业性质
					oFormData.regMoney = $('#regMoney').val();
					oFormData.adminuserid = $('#adminuserid').val();
					oFormData.admintime = $('#admintime').val();
					oFormData.isepc = Number($('#isepc').prop('checked'));
					oFormData.isservice = Number($('#isservice').prop('checked'));
					oFormData.isowner = Number($('#isowner').prop('checked'));
					oFormData.ismanu = Number($('#ismanu').prop('checked'));
					oFormData.comCont = $('#comCont').val();
					oFormData.comTel = $('#comTel').val();
					oFormData.comFax = $('#comFax').val();
					oFormData.comEmail = $('#comEmail').val();
					oFormData.subdomains = $('#subdomains').val();
					oFormData.comZip = $('#comZip').val();
					oFormData.provinceid = $('#provinceid').val();
					oFormData.cityid = $('#cityid').val();
					oFormData.countyid = $('#countyid').val();
					oFormData.comAddr = $('#comAddr').val();
					oFormData.descp = $('#descp').val();
					oFormData.logo = logoPath;
					//oFormData. = idMsgPath;
				var sFormData = JSON.stringify(oFormData)
//				console.log(sFormData)
				$.post('${ctx}/Company/updateInfo.htm', {
					data: sFormData,
					customConfig : JSON.stringify(customConfig)
				}, function(res) {
//					console.log(res.key)
					if (res.key==3) {//企业名称不合法
						$('.checkbox_group .valid-error').html('<label class="error">企业名称不合法</label>');
					};
					if (res.key==4) {//企业类型至少选一个
						$('.checkbox_group .valid-error').html('<label class="error">校验企业类型必选其一</label>');
					};
					if (res.key==1) {
						$('#clickRoute').trigger('click');
					};
				});
			} else {
				return false;
			}
		}

		function getCompanyType(dictId){
			$("#comBctCode").empty();
			 //['国有企业', '股份制企业', '私营企业', '联营企业', '外商投资企业', '港、澳、台', '股份合作企业', '集体所有制'];
			 var msg = [
			 	{id:32,dictName:'国有企业'},
			 	{id:33,dictName:'股份制企业'},
			 	{id:34,dictName:'私营企业'},
			 	{id:35,dictName:'联营企业'},
			 	{id:36,dictName:'外商投资企业'},
			 	{id:37,dictName:'港、澳、台'},
			 	{id:38,dictName:'股份合作企业'},
			 	{id:39,dictName:'集体所有制'}
			 ];
			$("#comBctCode").append("<option value=''>请选择</option>");
			for(var i=0,len=msg.length;i<len;i++){
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].id+"'";
					if(dictId!=null&&msg[i].id==dictId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].dictName+"</option>";
//					console.log(op)
					$("#comBctCode").append(op);
				}
			}
			// $.ajax({
			// 	type:"post",
			// 	url:"${ctx}/PFaultCode/getCompanyType.htm",
			// 	dataType : "json",
			// 	async: false,
			// 	success:function(msg){
			// 		$("#comBctCode").append("<option value=''>请选择</option>");
			// 		for(var i=0,len=msg.length;i<len;i++){
			// 			for(var i=0,len=msg.length;i<len;i++){
			// 				var op="<option value='"+msg[i].id+"'";
			// 				if(dictId!=null&&msg[i].id==dictId){
			// 					op+=" selected='selected' ";
			// 				}
			// 				op+=">"+msg[i].dictName+"</option>";
			// 				$("#comBctCode").append(op);
			// 			}
			// 		}
			// 	}
			// });
		}
		getCompanyType()

		//初始化页面数据
		$.ajax({
			type:"post",
			url: "${ctx}/Company/baseInfo.htm",
			success: function(msg) {
				if(msg.key==2){
					customConfig = msg.customConfig;
					msg = msg.data;
//					console.log('********');
//					console.log(msg);
					$("#comId").val(msg.comId);
					$("#comCode").val(msg.comCode);//企业编码
					$("#comName").val(msg.comName);//企业名称
					$("#comShortName").val(msg.comShortName);//企业简称

					$("#comCorp").val(msg.comCorp);//企业法人
					$("#comBctCode").val(msg.comBctCode);	//企业性质
					$("#regMoney").val(msg.regMoney);//注册资金

					$("#adminuserid").val(msg.adminuserid);//管理员账号
					$("#adminuserName").val(msg.adminuserName);//管理员账号
					$("#admintime").val(msg.admintime);//接管时间

					$("#isepc"+msg.isepc).addClass('active');
					$("#isepc").prop('checked',msg.isepc==0?false:true);
					$("#isservice"+msg.isservice).addClass('active');
					$("#isservice").prop('checked',msg.isservice==0?false:true);
					$("#isowner"+msg.isowner).addClass('active');
					$("#isowner").prop('checked',msg.isowner==0?false:true);
					$("#ismanu"+msg.ismanu).addClass('active');
					$("#ismanu").prop('checked',msg.ismanu==0?false:true);

					$("#comCont").val(msg.comCont);//联系人
					$("#comTel").val(msg.comTel);//联系电话
					$("#comFax").val(msg.comFax);//传真

					$("#comEmail").val(msg.comEmail);//电子邮件
					//网址
					$("#comZip").val(msg.comZip);//邮编

					$("#provinceid").val(msg.provinceid);//省
					$("#cityid").val(msg.cityid);//市
					$("#countyid").val(msg.countyid);//县

					$("#comAddr").val(msg.comAddr);//详细地址
					$("#subdomains").val(msg.subdomains);//二级域名
					$("#descp").val(msg.descp);//其他介绍

					$("#showLogo").attr("src", msg.logo);//logo
					logoPath = msg.logo;
					//$("#showIdMsg").attr("src", );//证件信息

					$("#comMobile").val(msg.comMobile);
					$("#comCretBy").val(msg.comCretBy);
					$("#comCretDate").val(msg.comCretDate);
					$("#comParentId").val(msg.comParentId);
					$("#comRgnCode").val(msg.comRgnCode);
					$("#comBctCode").val(msg.comBctCode);
					$("#comSort").val(msg.comSort);
					$("#comStatus").val(msg.comStatus);
					$("#begindate").val(msg.begindate);
					$("#enddate").val(msg.enddate);

//					console.info('---------');
//					console.info(customConfig);
					setCustomConfig(customConfig)
				};//成功
			}//success fuc
		});

		function setCustomConfig(v) {
			if (v) {
				if (v.logo_sm_flag && v.logo_sm_flag == '0') {
					$('#logo_sm_flag0').attr('checked', true);
					if (v.logo_sm) {
						$('#showLogosm').attr('src', '${ctx}/' + v.logo_sm).parent().show();
					} else {
						$('#showLogosm').parent().hide();
					}
				} else {
					$('#logo_sm_flag1').attr('checked', true);
					$('#logosmBtn').hide();
					$('#showLogosm').parent().hide();
				}
				if (v.logo_lg) {
					$('#showLogolg').attr('src', '${ctx}/' + v.logo_lg);
				} else {
					$('#showLogolg').parent().hide();
				}

				if (v.os_title) {
					$('#os_title').val(v.os_title);
				}
				if (v.os_en_title) {
					$('#os_en_title').val(v.os_en_title);
				}
			} else {
				customConfig = {};
				$('#logo_sm_flag1').attr('checked', true);
				$('#logosmBtn').hide();
				$('#showLogosm').parent().hide();
				$('#showLogolg').parent().hide();
			}
		}

		getSelected(1)
		function getSelected(comId){
			app.controller('RegionCtrl', ['$http', '$scope', function($http, $scope){
				//地址省市县start	===============================================================
				$scope.provinced = {};
				$scope.province = null;
				$scope.cityd = {};
				$scope.city = null;
				$scope.countyd = {};
				$scope.county = null;

				$http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":1,"parentId":1}})
				.success(function (result) {
					 $scope.province = result;
					 if($("#provinceid").val() != null && $("#provinceid").val() != "" ){
						 for(var i=0,len=$scope.province.length;i<len;i++){
							if($scope.province[i].id==  $("#provinceid").val()){
								$scope.provinced.selected= { regionName: $scope.province[i].regionName,id:  $("#provinceid").val()};
							}
						}
					 }

					 $scope.provinceChange= function () {
						 var a = angular.copy($scope.provinced.selected.id);
						 $("#provinceid").val(a);
						 $scope.cityd.selected = {regionName : null,id : null};
						 $scope.countyd.selected = {regionName :null,id : null};
						 $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":2,"parentId":a}})
						 .success(function (resultcity) {
							 $scope.city = resultcity;
							 for(var i=0,len=$scope.city.length;i<len;i++){
									if($scope.city[i].id==  $("#cityid").val()){
										$scope.cityd.selected= { regionName: $scope.city[i].regionName,id:  $("#cityid").val()};
									}
								}

								 $scope.cityChange= function () {
									var b = angular.copy($scope.cityd.selected.id);
									$("#cityid").val(b);
									$scope.countyd.selected= { regionName: null,id:  null};

									$http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":3,"parentId":((b==null) || (b==""))?0:b}})
									.success(function (resultcounty) {
										$scope.county = resultcounty;
											for(var i=0,len=$scope.county.length;i<len;i++){
												if($scope.county[i].id==  $("#countyid").val()){
													$scope.countyd.selected= { regionName: $scope.county[i].regionName,id:  $("#countyid").val()};
												}
											}
										 $scope.countyChange= function () {
											 $("#countyid").val($scope.countyd.selected.id);
										 }
									});
							   }
							 if($("#countyid").val() != null && $("#countyid").val() != "" ){
								 $scope.cityChange();
							 }
						 });
					}
					if($("#cityid").val() != null && $("#cityid").val() != "" ){
						$scope.provinceChange();
					}
				});
				// 地址省市县 end ================================================

				// 所属机构 start=================================================
				// $scope.companyd = {};
				// $scope.company = null;
				// $http({method:"POST",url:"${ctx}/Company/selectAll.htm",params:{"comId":comId}})
				// .success(function (result) {
				// 	 $scope.company = result;
				// 	 for(var i=0,len=$scope.company.length;i<len;i++){
				// 		if($scope.company[i].comId==  $("#comParentId").val()){
				// 			$scope.companyd.selected= { comName: $scope.company[i].comName,comId:  $("#comParentId").val()};
				// 		}
				// 	}
				// 	$scope.companyChange= function () {
				// 		$("#comParentId").val(angular.copy($scope.companyd.selected.comId));
				// 	}
				// });
				// 所属机构end=======================================================
			}]);
		}

		// function getCom(comId,comParentId){
		// 	$("#comParentId").empty();
		// 	$.ajax({
		// 		type:"post",
		// 		data:{"comId":comId},
		// 		url:"${ctx}/Company/selectAll.htm",
		// 		dataType : "json",
		// 		async: false,
		// 		success:function(msg){
		// 			$("#comParentId").append("<option value=''>请选择</option>");
		// 			for(var i=0,len=msg.length;i<len;i++){
		// 				for(var i=0,len=msg.length;i<len;i++){
		// 					var op="<option value='"+msg[i].comId+"'";
		// 					if(comParentId!=null&&msg[i].comId==comParentId){
		// 						op+=" selected='selected' ";
		// 					}
		// 					op+=">"+msg[i].comName+"</option>";
		// 					$("#comParentId").append(op);
		// 				}
		// 			}
		// 		}
		// 	});
		// }

		// function getRegion(level,parentId,domId,regionId){
		// 	$("#"+domId).empty();
		// 	$.ajax({
		// 		type:"post",
		// 		url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
		// 		data:{"treeLevel":level,"parentId":parentId},
		// 		dataType : "json",
		// 		async: false,
		// 		success:function(msg){
		// 			$("#"+domId).append("<option value=''>请选择</option>");
		// 			for(var i=0,len=msg.length;i<len;i++){
		// 				var op="<option value='"+msg[i].id+"'";
		// 				if(regionId!=null&&msg[i].id==regionId){
		// 					op+=" selected='selected' ";
		// 				}
		// 				op+=">"+msg[i].regionName+"</option>";
		// 				$("#"+domId).append(op);
		// 			}
		// 		}
		// 	});
		// }
	</script>
