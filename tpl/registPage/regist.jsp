<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>创维互联</title>
	<meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
	<link type="image/x-icon" rel="shortcut icon" href="${ctx}/theme/images/favicon.ico">
	<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/fonts/regist/iconfont.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/app.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/base.css" type="text/css" />
	<style type="text/css">
		.nav_heipad h1 {margin: 0;}
		.form_pannel {margin-top: 60px;width: 780px;margin-left: auto;margin-right: auto;}
		.reg_choice li {background-color: #f2f2f2;cursor: pointer;}
		.reg_choice li, .panel-header .iconfont-regist {font-size: 24px;}
		.reg_choice li.active {color: #fff;background-color: #22c1aa;}
		.reg_choice li.active .caret {display: inline-block;position: absolute;top: 100%;left: 50%;margin-left: -5px;border-width: 10px;border-top-color: #22c1aa;}
		.panel.box-shadow {border: 1px solid #e7e7e7;border-radius: 5px;}
		label.col-sm-3 {line-height: 34px;}
		.checkbox_group .btn {background-color: #fff;border: 1px solid #ccc;}
		.btn_crrent, .checkbox_group .btn.active {background-color: #22c1aa;border-color: #22c1aa;color: #fff;}
		.btn_crrent:hover,.btn_crrent:focus {color: #fff;}
		.call_center, .call_center:hover {position: absolute;color: #005bac;right: 50px;bottom: 95px;}
		.default-blue:hover, .default-blue:focus {color: #06bebd;}
	</style>
	<script src="${ctx}/vendor/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="${ctx}/vendor/jquery/validate/jquery.form.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/jquery/validate/jquery.validate.min.js"></script>
	<script src="${ctx}/vendor/jquery/validate/jquery.validate.solway.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/jquery/validate/messages_cn.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/jquery/validate/jquery.validate.work.js"></script>
</head>
<body>
	<!-- navbar navbar-fixed-top-->
	<div class="app-header navbar box-shadow bg-white-only nav_heipad" style="z-index: 1;">
		<div class="container-fluid">
			<div class="navbar-header m-l-xxl">
				<h1 class="logo font-h2 navbar-brand">
					<span><img src="${ctx}/theme/images/solway/pc_header_logo.png" alt="." style="width: 25px;"></span>
					<span class="hidden-folded m-l-xs opa-7">新能云</span>
				</h1>
			</div>
			<ul class="pull-right nav navbar-nav text-md">
				<li><a href="${ctx}/index.jsp#/">进入官网</a></li>
				<li><a href="${ctx}/index.jsp#/">演示电站</a></li>
				<li><a href="">客户端下载</a></li>
			</ul>
		</div>
	</div>
	<!-- / navbar -->
	<!-- panel -->
	<div ng-controller="registCtrl" class="form_pannel">
		<div class="panel box-shadow">
			<div class="panel-header reg_choice">
				<ul class="list-unstyled clearfix text-center">
					<!-- <li ng-click="userCompanyShow=flase;" ng-class="{'active': !userCompanyShow}" class="col-sm-6 padder-v pos-rlt">
						<i class="iconfont-regist icon-user-person"></i>
						个人用户
						<span class="caret none"></span>
					</li>
					<li ng-click="userCompanyShow=true;" ng-class="{'active': userCompanyShow}" class="col-sm-6 padder-v pos-rlt">
						<i class="iconfont-regist icon-user-company"></i>
						企业用户
						<span class="caret none"></span>
					</li> -->
					<li class="active col-sm-6 padder-v pos-rlt">
						<i class="iconfont-regist icon-user-person"></i>
						个人注册
						<span class="caret none"></span>
					</li>
					<li class="col-sm-6 padder-v pos-rlt">
						<i class="iconfont-regist icon-user-company"></i>
						企业注册
						<span class="caret none"></span>
					</li>
				</ul>
			</div>
			<div class="panel-body pos-rlt padder-b-60">
				<div class="text-right">已有账号，<a class="default-blue" href="${ctx}/login.jsp">直接登录&gt;</a></div>
				<!-- 个人注册表单 -->
				<form class="form-horizontal" id="personForm" role="form">
					<div class="form-group">
						<label class="col-sm-3 text-right no-padder" for="tel-per">手机号</label>
						<!-- <div class="dropdown pull-left">
							<button class="btn btn-default dropdown-toggle" type="button">
								86&nbsp;
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="">86</a></li>
							</ul>
						</div> -->
						<div class="col-sm-4 pr">
							<input class="form-control valid-required valid-tel" id="tel-per" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" name="tel-per" type="text" placeholder="请输入您的手机号码">
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right no-padder" for="name-per">姓名</label>
						<div class="col-sm-4 pr">
							<input class="form-control valid-required" id="name-per" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" name="name-per" type="text" placeholder="请输入您的姓名">
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="password-per" class="col-sm-3 text-right no-padder">密码</label>
						<div class="col-sm-4">
							<input class="form-control valid-minlengthPass" id="password-per" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" name="password-per" type="text" placeholder="密码至少6位">
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="randomCode" class="col-sm-3 text-right no-padder">验证码</label>
						<div class="pull-left pos-rlt padder">
							<input class="pull-left form-control m-r-sm valid-fourcode" onclick="getRandomCodeFocus('randomCode')" style="width: 130px;" id="randomCode" name="randomCode" type="text" placeholder="校验码是4位数字">
							<div class="pull-left randomCodeDiv">
								<img id="randomCodeImg" onclick="getRandomCode('randomCode')" title="点击更换" style="display: none;">
							</div>
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="verifyCode" class="col-sm-3 text-right no-padder">短信检验码</label>
						<div class="pull-left pos-rlt padder">
							<input class="pull-left form-control m-r-sm valid-sixcode" style="width: 130px;" id="verifyCode" name="verifyCode" type="text" placeholder="校验码是6位数字">
							<button class="pull-left btn verifyCode" id="btnVerifyCode" type="button">获取验证码</button>
							<div class="valid-error"></div>
						</div>
					</div>
					<!-- <div class="form-group">
						<label for="verifyCode" class="col-sm-3 text-right no-padder">短信检验码</label>
						<div class="col-sm-4 pos-rlt" style="padding-right: 116px !important;">
							<input class="form-control valid-required" id="verifyCode" type="text" placeholder="校验码是6位数字">
							<button class="btn verifyCode" disabled>获取验证码</button>
							<div class="valid-error"></div>
						</div>
					</div> -->
					<div class="form-group">
						<div class="col-sm-9 col-sm-offset-3">
							<div class="checkbox">
								<label class="pos-rlt padder wrapper-xs">
									<input type="checkbox" name="agree" id="personAgree" class="valid-required" style="margin-top: 2px;">同意
									<div class="valid-error"></div>
									<a class="a_policy">《隐私权政策》</a>
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-9 col-sm-offset-3">
							<button id="submitPerson" class="btn btn_crrent padder-lg" type="submit">提交</button>
						</div>
					</div>
				</form>
				<!-- 个人注册表单 END -->
				<!-- 企业注册表单 -->
				<form class="form-horizontal none" id="companyForm" role="form">
					<div class="form-group">
						<label class="col-sm-3 text-right no-padder" for="companyName">企业名称</label>
						<div class="col-sm-4">
							<input type="text" id="companyName" name="companyName" class="form-control valid-required valid-companyLength">
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right no-padder">企业类型</label>
						<div class="col-sm-7">
							<ul class="list-inline checkbox_group pull-left pr">
								<!-- <li ng-repeat="company in companyType">
									<button class="btn checkbox_btn" type="button">{{company.name}}</button>
									<input class="pa vh" ng-class="{'valid-required': company.name==companyType[0].name}" name="companytype" type="checkbox" value="company.name">
								</li> -->
								<!-- <li ng-repeat="company in companyType">
									<button ng-click="company.type = !company.type" ng-class="{'active': company.type}" class="btn checkbox_btn" type="button">{{company.name}}</button>
									<input class="none" ng-class="{'valid-required': company.name==companyType[0].name}" ng-checked="company.type" name="companytype" type="checkbox" value="company.name">
								</li> -->
								<li>
									<button class="btn checkbox_btn" type="button">EPC</button>
									<input class="pa vh valid-required" name="companytype" type="checkbox" value="EPC">
								</li>
								<li>
									<button class="btn checkbox_btn" type="button">运维公司</button>
									<input class="pa vh" name="companytype" type="checkbox" value="运维公司">
								</li>
								<li>
									<button class="btn checkbox_btn" type="button">电站业主</button>
									<input class="pa vh" name="companytype" type="checkbox" value="电站业主">
								</li>
								<li>
									<button class="btn checkbox_btn" type="button">设备厂商</button>
									<input class="pa vh" name="companytype" type="checkbox" value="设备厂商">
								</li>
								<span style="line-height: 34px;white-space: nowrap;">（可多选）</span>
								<div style="margin-left: 10px;" class="valid-error"></div>
							</ul>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 text-right no-padder" for="tel-com">管理员账号</label>
						<!-- <div class="dropdown pull-left m-r-sm">
							<button class="btn btn-default dropdown-toggle">
								86&nbsp;
								<span class="caret"></span>
							</button>
							<ul class="dropdown-menu">
								<li><a href="">86</a></li>
							</ul>
						</div> -->
						<div class="col-sm-4">
							<input type="text" id="tel-com" name="tel-com" class="form-control valid-required valid-tel" placeholder="请输入您的手机号码">
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="password-com" class="col-sm-3 text-right no-padder">密码</label>
						<div class="col-sm-4">
							<input class="form-control valid-minlengthPass" type="password" id="password-com" name="password-com" placeholder="密码至少6位">
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="randomCode-com" class="col-sm-3 text-right no-padder">验证码</label>
						<div class="pull-left pos-rlt padder">
							<input class="pull-left form-control m-r-sm valid-fourcode" onclick="getRandomCodeFocus('randomCodeCom')" style="width: 130px;" id="randomCode-com" name="randomCode-com" type="text" placeholder="校验码是4位数字">
							<div class="pull-left randomCodeComDiv">
								<img id="randomCodeComImg" onclick="getRandomCode('randomCodeCom')" title="点击更换" style="display: none;">
							</div>
							<div class="valid-error"></div>
						</div>
					</div>
					<div class="form-group">
						<label for="verifyCode-com" class="col-sm-3 text-right no-padder">短信检验码</label>
						<div class="pull-left pos-rlt padder">
							<input class="pull-left form-control m-r-sm valid-sixcode" style="width: 130px;" id="verifyCode-com" type="text" name="verifyCode-com" placeholder="校验码是6位数字">
							<button id="btnVerifyCode-2" class="pull-left btn verifyCode" type="button">获取验证码</button>
							<div class="valid-error"></div>
						</div>
					</div>
					<!-- <div class="form-group">
						<label for="" class="col-sm-3 text-right no-padder">短信检验码</label>
						<div class="col-sm-4 pos-rlt" style="padding-right: 116px !important;">
							<input type="text" class="form-control valid-required" placeholder="校验码是6位数字">
							<button class="btn verifyCode">获取验证码</button>
							<div class="valid-error"></div>
						</div>
					</div> -->
					<div class="form-group">
						<div class="col-sm-3 col-sm-offset-3">
							<div class="checkbox">
								<label class="pos-rlt wrapper-xs padder">
									<input class="valid-required" name="agreeCom" type="checkbox" style="margin-top: 2px;">
									同意
									<a class="a_policy">《隐私权政策》</a>
									<div class="valid-error"></div>
								</label>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-3 col-sm-offset-3">
							<button id="submitCompany" class="btn btn_crrent padder-lg" type="submit">提交</button>
						</div>
					</div>
				</form>
				<!-- 企业注册表单 END -->
				<span class="call_center text-base">
					<i class="iconfont-regist icon-service-tel text-base"></i>
					<span>客服电话：010-8280 0866-8010</span>
				</span>
			</div>
		</div>
	</div>
	<!-- panel END -->

	<!-- 隐私权政策 -->
	<div class="modal fade" id="policies" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="z-index: 99999;">
		<div class="modal-dialog row" style="width: 1000px;max-width: 1000px">
		<div class="modal-content">
			<div class="modal-body wrapper-lg">
			<div class="row">
			<center>
				<h3>创维互联 隐私权和条款</h3>
			</center>
				<div class="col-sm-12">
					<div class="panel-body">

		<div class="maia-article" role="article">
		<div class="maia-teleport" id="content"></div>
		<h1>创维互联 服务条款</h1>
		<h2>欢迎使用 创维互联产品和服务！</h2>
		<p>感谢您使用我们的产品和服务（下称“服务”）。服务由创维互联（北京）新能源科技有限公司（下称“创维互联”）提供，总部地址为：北京市海淀区知春路6号锦秋国际大厦A座2003。
		</p><p>您使用我们的服务即表示您已同意本条款。请仔细阅读。
		</p><p>我们的服务范围非常广泛，因此有时还会适用一些附加条款或产品要求。附加条款将会与相关服务一同提供，并且在您使用这些服务后，成为您与我们所达成的协议的一部分。
		</p><h2 id="toc-services">使用服务</h2>
		<p>您必须遵守服务中提供的所有政策。
		</p><p>请勿滥用我们的服务。举例而言，请勿干扰我们的服务或尝试使用除我们提供的界面和指示以外的方法访问这些服务。如果您不遵守我们的条款或政策，或者我们在调查可疑的不当行为，我们可以暂停或停止向您提供服务。
		</p><p>使用我们的服务并不让您拥有我们的服务或您所访问的内容的任何知识产权。除非您获得相关内容所有者的许可或通过其他方式获得法律的许可，否则您不得使用服务中的任何内容。本条款并未授予您使用我们服务中所用的任何商标或标志的权利。请勿删除、隐藏或更改我们服务上显示的或随服务一同显示的任何法律声明。
		</p><p>我们的部分服务可在移动设备上使用。在使用此类服务时，请勿因此而分散注意力和违反交通或安全法。
		</p><h2 id="toc-account">创维互联 帐户</h2>
		<p>为了使用我们的某些服务，您可能需要一个创维互联帐户。您可以创建自己的创维互联帐户或者由管理员为您分配创维互联帐户。
		</p><p>为保护您的创维互联帐户，请务必保管好您的密码并对外保密。您应对自己创维互联帐户上发生的活动或通过该帐户进行的活动负责。尽量不要在第三方应用中使用与创维互联帐户相同的密码。
		</p><h2 id="toc-protection">隐私与版权保护</h2>
		<p>创维互联的隐私权政策保证您在使用我们的服务时，我们会保护您的数据和您的隐私。使用我们的服务即表示您同意 创维互联 可以按照我们的隐私权政策使用您的数据。
		</p><h2 id="toc-software">关于我们服务中的软件</h2>
		<p>您不得复制、修改、发布、出售或出租我们的服务或所含软件的任何部分，也不得进行反向工程或试图提取该软件的源代码，除非法律禁止上述限制或您已获得 创维互联的书面许可。
		</p><h2 id="toc-modification">修改和终止服务</h2>
		<p>我们始终在不断更新和改进我们的服务。我们可能会增加或删除功能， 如果我们停止某项服务，我们会向用户发出合理的提前通知。
		</p><h2 id="toc-about">关于本条款</h2>
		<p>如果本条款与附加条款有冲突，以附加条款为准。
		</p><p>本条款约束 创维互联与您之间的关系。
		</p></div>
					<div class="col-lg-offset-2 col-lg-10">
					<button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default close_btn" data-dismiss="modal"><strong>关 闭</strong></button>
					</div>
					</div>
				</div>
			</div>
			</div>
		</div>
		</div>
	</div>
	<!-- 隐私权政策 END -->

	<script type="text/javascript">
		var randomCodeUrl = '${ctx}/Login/randomValidateCode.htm';
		function getRandomCodeFocus(target) {
			$('#' + target).val('');
			if($("#" + target + 'Img').is(":hidden")){
				getRandomCode(target)
				$('#' + target + 'Img').show()
			}
		}
		function getRandomCode(target) {
			$('#' + target + 'Img').attr("src", randomCodeUrl + '?' + Math.random());
		}

		$('#password-per').keydown(function(event) {
			if ($(this).val=='') {
				$(this).attr('type', 'text');
			} else {
				$(this).attr('type', 'password');
			}
		});
		jQuery.extend(jQuery.validator.messages, {
			//required:'必填项',
			email: '请检查电子邮件',
			mobile: '您输入手机号码不合法',
			fourcode: '请输入4位数字随机验证码',
			sixcode: '请输入6位数字短信验证码'
		});
		//个人用户表单验证
		var validatorPer = $('#personForm').validate({
			messages: {
				'tel-per': {
					required: '请输入您的手机号码'
				},
				'name-per': {
					required: '请输入您的姓名'
				},
				'password-per': {
					required: '请输入您的密码'
				},
				'randomCode': {
					required: '请输入4位数字随机验证码'
				},
				'verifyCode': {
					required: '请输入6位数字短信验证码'
				},
				'agree': {
					required: '请同意隐私权策略'
				}
			},
			//错误提示位置
			errorPlacement: function (error, ele) {
				if (ele.siblings('.valid-error').length>0) {
		    		var $validError = ele.siblings('.valid-error');
				} else {
					var $validError = ele.parent().siblings('.valid-error');
				}
				$validError.html(error);
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						//promptObj('success','',json.message);
						hideModal("userInformationModal");
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"保存失败");
					}
				};
				$(form).ajaxSubmit(options);
			}
		});
		//var validatorPer = jQuery.validator.formValid('#personForm');
		$('#personForm input').focus(function() {
			var $prevControl = $(this).parents('.form-group').prevAll('.form-group').find('.form-control');
			$prevControl.each(function(index, el) {
				validatorPer.element($(this));
			});
		});
		$("#personAgree").click(function(event) {
			if (!$(this).prop('checked')) {
				validatorPer.element($(this));
			}
		});
		//校验手机是否重复
		$("#tel-per").blur(function(event) {
			$this = $(this);
			var $showmsg = $('<label class="error">该手机号码已被注册</label>');
			$.post('${ctx}/personalReg/checkPhone.htm', {phone:$this.val()}, function(data) {
				if (data.key > 1) {
					//手机号已被注册
					$this.addClass('error').removeClass('valid');
					$this.siblings('.valid-error').html($showmsg);
				}
			});
		});
		//验证码
		$('#btnVerifyCode:enabled').click(function() {
			var timer;
			var $this = $(this);
			var num = 60;
			
			if (validatorPer.element($('#tel-per'))) {
				$.post('${ctx}/personalReg/sendVerifyCode.htm', {
					phone: $("#tel-per").val(),
					countryCode: 86,
					busitype: '00',
					randomCode: $('#randomCode').val()
				}, function(data, textStatus, xhr) {
					if (data.key != 2) {
						if (data.key == 5) {
							$('#randomCode').siblings('.valid-error').html('<label class="error">随机验证码不正确</label>');
							$('#randomCodeImg').click();
						}
						var $showmsg = $('<label class="error">'+data.message+'</label>');
						$this.siblings('#verifyCode').addClass('error').removeClass('valid');
						$this.siblings('.valid-error').html($showmsg);
					}else{
						$this.html(num+'秒后重新获取')
						$this.prop('disabled', true);
						function countdownInter() {
							if (num>1) {
								num = num - 1;
								$this.html(num+'秒后重新获取');
							} else {
								$this.prop('disabled', false);
								$this.html('重新获取验证码');
								clearInterval(timer)
							}

						}
						timer = setInterval(countdownInter, 1000);
					}
				});
			}
		});
		//新增个人用户
		$('#submitPerson').click(function() {
			if(validatorPer.form()){
				$.post('${ctx}/personalReg/updatePersonal.htm', {
					tel: $("#tel-per").val(),
					realName: $("#name-per").val(),
					password: $('#password-per').val(),
					randomCode: $('#randomCode').val(),
					code: $('#verifyCode').val()
				}, function(data, textStatus, xhr) {
//					console.log("表单返回："+data.key)
					switch(parseInt(data.key)){
						case 1:
							//验证码不正确
							$('#verifyCode').siblings('.valid-error').html('<label class="error">手机验证码不正确</label>');
							break;
						case 2:
							//添加成功
							location.href = "${ctx}/tpl/registPage/registed.jsp"
							break;
						case 4:
							$("#tel-per").siblings('.valid-error').html('<label class="error">该手机号码已被注册</label>');
							//手机号已被注册
							break;
						case 5:
							//验证码不正确
							$('#randomCode').siblings('.valid-error').html('<label class="error">随机验证码不正确</label>');
							$('#randomCodeImg').click();
							break;
						default:
							break;
					}
				});
			} else {
				console.log(validatorPer.form());
				return false;
			}
		});

		//企业用户表单验证
		var validatorCom = $('#companyForm').validate({
			messages: {
				'companyName': {
					required: '请输入企业名称'
				},
				'companytype': {
					required: '请至少选择一个企业类型'
				},
				'tel-com': {
					required: '请输入您的手机号码'
				},
				'password-com': {
					required: '请输入您的密码'
				},
				'randomCode-com': {
					required: '请输入4位数字随机验证码'
				},
				'verifyCode-com': {
					required: '请输入6位数字验证码'
				},
				'agreeCom': {
					required: '请同意隐私权策略'
				}
			},
			//错误提示位置
			errorPlacement: function (error, ele) {
				if (ele.siblings('.valid-error').length>0) {
		    		var $validError = ele.siblings('.valid-error');
				} else {
					var $validError = ele.parent().siblings('.valid-error');
				}
				$validError.html(error);
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						//promptObj('success','',json.message);
						hideModal("userInformationModal");
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"保存失败");
					}
				};
				$(form).ajaxSubmit(options);
			}
		});
		// var validatorCom = jQuery.validator.formValid('#companyForm');
		$('#companyForm input').focus(function() {
			var $prevControl = $(this).parents('.form-group').prevAll('.form-group').find('.form-control');
			$prevControl.each(function(index, el) {
				validatorCom.element($(this));
			});
			var $prevControlcheckbox = $(this).parents('.form-group').prevAll('.form-group').find('.checkbox_group .valid-required');
			validatorCom.element($prevControlcheckbox);
		});
		//校验企业名称
		$('#companyName').blur(function(event) {
			$this = $(this);
			var $showmsg = $('<label class="error">该企业已被注册</label>');
			$.post('${ctx}/enterpriseReg/checkEnterpriseName.htm', {
				enterpriseName:$this.val()
			}, function(data) {
				console.log('企业名称'+data.key)
				if (data.key == 1) {
					$this.addClass('error').removeClass('valid');
					$this.siblings('.valid-error').html($showmsg);
				}
				if (data.key == 2) {
					$this.siblings('.valid-error').html('');
				}
			});
		});
		//企业类型
		$('.checkbox_group').on('click', '.checkbox_btn', function(event) {
			validatorCom.element($('#companyName'));
			var $this = $(this);
			var $beInput = $this.next();
			$this.toggleClass('active');
			$beInput.prop('checked',!$beInput.prop('checked'));
			//if ($('input[name="companytype"]:checked').length == 0) {
				validatorCom.element($('.checkbox_group .valid-required'));
			//}
		});
		//管理员账号
		//如是则提示：手机号已注册个人用户，请直接输入密码。如否则提示：手机号未注册个人用户，将自动注册成个人用户。
		$("#tel-com").blur(function(event) {
			$this = $(this);
			$.post('${ctx}/personalReg/checkPhone.htm', {phone:$this.val()}, function(data) {
				console.log('手机号'+data.key)
				if (data.key == 1) {
					$this.addClass('error').removeClass('valid');
					$this.siblings('.valid-error').html('<label class="error" style="color: #333">手机号未注册个人用户，将自动注册成个人用户</label>');
				}
				if (data.key == 2) {
					$this.addClass('error').removeClass('valid');
					$this.siblings('.valid-error').html('<label class="error" style="color: #333">手机号已注册个人用户，请直接输入密码</label>');
				}
				if (data.key == 3) {
					$this.addClass('error').removeClass('valid');
					$this.siblings('.valid-error').html('<label class="error">手机号已成为其他企业管理员</label>');
				}
			});
		});
		//短信验证码
		$('#btnVerifyCode-2:enabled').click(function() {
			var timer;
			var $this = $(this);
			var num = 60;
			if (validatorCom.element($('#tel-com'))) {
				$.post('${ctx}/personalReg/sendVerifyCode.htm', {
					phone: $("#tel-com").val(),
					countryCode: 86,
					busitype: '01',
					randomCode: $('#randomCode-com').val()
				}, function(data, textStatus, xhr) {
					if (data.key != 2) {
						if (data.key == 5) {
							$('#randomCode-com').siblings('.valid-error').html('<label class="error">随机验证码不正确</label>');
							$('#randomCodeComImg').click();
						}
						var $showmsg = $('<label class="error">'+data.message+'</label>');
						$this.siblings('#verifyCode-2').addClass('error').removeClass('valid');
						$this.siblings('.valid-error').html($showmsg);
					}else{
						$this.html(num+'秒后重新获取')
						$this.prop('disabled', true);
						function countdownInter() {
							if (num>1) {
								num = num - 1;
								$this.html(num+'秒后重新获取');
							} else {
								$this.prop('disabled', false);
								$this.html('重新获取验证码');
								clearInterval(timer);
							}

						}
						timer = setInterval(countdownInter, 1000);
					}
				});
			}
		});
		//新增企业用户
		$('#submitCompany').click(function() {
			function getTypeState(num) {
				return Number($('input[name="companytype"]').eq(num).prop('checked'));
			}
			if(validatorCom.form()){
				$.post('${ctx}/enterpriseReg/updateEnterprise.htm', {
					comName: $('#companyName').val(),	//企业名称
					isepc: getTypeState(0),				//是否EPC 0:否,1:是
					isservice: getTypeState(1),			//是否运维服务商 0:否,1:是
					isowner: getTypeState(2),			//是否业主 0:否,1:是
					ismanu: getTypeState(3),			//是否设备商 0:否,1:是
					comTel: $("#tel-com").val(),		//手机号码
					password: $('#password-com').val(),	//密码
					code: $('#verifyCode-com').val(),	//验证码
					randomCode: $('#randomCode-com').val()
				}, function(data, textStatus, xhr) {
					console.log('企业类型:'+"epc:"+getTypeState(0))
					console.log("表单返回："+data.key)
					switch(parseInt(data.key)){
						case 1:
							//校验企业类型必选其一
							$('.checkbox_group .valid-error').html('<label class="error">请至少选择一个企业类型</label>');
							break;
						case 2:
							//验证码不正确
							$('#verifyCode-com').siblings('.valid-error').html('<label class="error">验证码不正确</label>');
							break;
						case 3:
							//校验企业名称不可用
							$('#companyName').siblings('.valid-error').html('<label class="error">输入企业名称不可用</label>');
							break;
						case 4:
							//校验密码错误
							$('#password-com').siblings('.valid-error').html('<label class="error">输入密码错误</label>');
							break;
						case 5:
							//添加成功
							location.href = "${ctx}/tpl/registPage/registed.jsp"
							break;
						case 6:
							//已注册为企业用户21
							if ($('#companyName').val()) {
								$('#companyName').siblings('.valid-error').html('<label class="error">已经注册为企业用户</label>');
							}
							break;
						case 7:
							//验证码不正确
							$('#randomCode-com').siblings('.valid-error').html('<label class="error">随机验证码不正确</label>');
							$('#randomCodeComImg').click();
							break;
						default:
							break;
					}
				});
			} else {
				console.log(validatorCom.form());
				return false;
			}
		});
		$(".reg_choice li").click(function() {
			$(this).addClass("active").siblings().removeClass("active")
			$("form").eq( $(this).index() ).show().siblings('form').hide();
			validatorPer.resetForm();
			validatorCom.resetForm();
		});
		$('button.verifyCode').prop("disabled", false);
	</script>
	<script>
		console.log(location.href.indexOf('#independ'))
		if (location.href.indexOf('#independ') != -1) {
			$('#policies').modal({
				backdrop: "static",
				keyboard: false
			});
			$('#policies').css('background-color', '#fff');
			$('.close_btn').hide();
			$('#policies .modal-dialog').css({
				"width": "auto"
			});
		} else {
			$('#policies').modal('hide');
		}

		$('.a_policy').click(function(event) {
			if (location.href.indexOf('#policy') == -1) {
				location.href += '#policy';
			}
			$('#policies').modal('show');
		});
	</script>
</body>
</html>
