<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en" data-ng-app="app">
<head>
	<meta charset="utf-8" />
	<title>创维互联</title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
	<link type="image/x-icon" rel="shortcut icon" href="./theme/images/favicon.ico">
	<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/animate.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/font-awesome.min.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/simple-line-icons.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/font.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/app.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/theme/css/base.css" type="text/css" />
	<style>
		.login-btn {width: 100%; background-color: rgba(6, 190, 189,0.6); border-radius: 0px; height: 41px; font-size: 20px; color: #fff; line-height: 41px; box-shadow: 0px 1px 1px 1px rgba(6, 190, 189,0.2);}
	</style>
</head>
<body>
	<div class="container" style="padding-top:30px;">
		<div class="m-t-lg col-sm-12 no-padder text-center">
			<p class="font-big-1 black-1">新能云 光伏电站智能运营管理平台--忘记密码</p>
		</div>
		<div class="col-sm-4 col-sm-push-4 no-padder text-center" style="margin-top: 60px;">
			<div class="alert alert-danger pa" style="width: 100%;top: -50px;" hidden="hidden" id="valLoginMessage"></div>
			<div class="col-sm-12"><h6 class="text-right"><a style="cursor:pointer;color:#54a886" href="${ctx}/login.jsp">登录></a></h6></div>
			<form role="form">
				<!-- <div class="form-group">
					<input type="text" class="form-control" id="username" placeholder="用户名">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" id="email" placeholder="邮箱">
				</div> -->
				<div class="form-group">
					<input type="text" class="form-control" id="tel" placeholder="手机号">
				</div>
				<div class="col-sm-12 no-padder form-group">
					<div class="col-sm-7 pos-rlt no-padder">
						<input class="pull-left form-control m-r-sm valid-fourcode" onclick="getRandomCodeFocus('randomCode')" id="randomCode" name="randomCode" type="text" placeholder="校验码是4位数字">
					</div>
					<div class="col-sm-5 randomCodeDiv">
						<img id="randomCodeImg" onclick="getRandomCode('randomCode')" title="点击更换" style="display: none;">
					</div>
				</div>
				<div class="col-sm-12 no-padder form-group">
					<div class="col-sm-7 no-padder">
						 <input type="text" class="form-control" id="code" placeholder="输入验证码"
						 >
					</div>
					<div class="col-sm-5 no-padder">
						 <button id="btnVerifyCode-2" class="btn verifyCode" style="color: #ffffff !important;background-color: #54a886;border-color: #54a886;" type="button">获取验证码</button>
					</div>
				</div>
				<div class="form-group">
					<input type="password" class="form-control" id="psd" placeholder="输入新密码">
				</div>
				<div class="form-group">
					<input type="password" class="form-control" id="againpsd" placeholder="再输一遍">
				</div>
			</form>
			<button id="resetPwdBtn" type="button" class="btn btn-lg btn-block btn-success" style="color: #ffffff !important;background-color: #54a886;border-color: #54a886;" onclick="forgetPwd()">重置密码</button>
		</div>
		<div class="col-sm-4 col-sm-push-4 no-padder text-center m-t-lg none">
			<p style="font-size: 25px; color: rgba(6, 190, 189,1);margin: 100px 0px;">
				<i class="fa fa-check m-r-sm"></i>成功重置密码
			</p>
			<div class="col-sm-12">
				<a class="col-sm-12 no-padder btn login-btn inherited" style="color: #fff;" href="${ctx}/login.jsp">进入新能云</a>
			</div>
		</div>
	</div>
	<script src="${ctx}/vendor/jquery/jquery.min.js" type="text/javascript"></script>
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
	
		var telFilter=/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
		//点击  Enter  键  登陆
		document.onkeydown = function(e){
			var e = window.event ? window.event : e;
			if(e.keyCode == 13){
				forgetPwd();
			}
		}
		function forgetPwd(){
			$("#valLoginMessage").hide();
			// var username = $("#username").val();
			// var email = $("#email").val();
			// if(username==""||null==username||null==email||email==""){
			// 	$("#valLoginMessage").html("请输入用户名和邮箱");
			// 	$("#valLoginMessage").show();
			// 	return false;
			// }
			// if(!confirm('确定要重置密码吗？')){
			// 	return false;
			// }
			// $("#resetPwdBtn").attr("disabled","disabled");
			// $.post(
			// 	"${ctx}/Login/forgetPassword.htm",
			// 	{"userName":username,"email":email},
			// 	function (msg){
			// 		$("#resetPwdBtn").removeAttr("disabled");
			// 		alert(msg);
			// 	});
			$("#valLoginMessage").hide();
			var tel = $("#tel").val();
			var psd = $("#psd").val();
			var againpsd = $("#againpsd").val();
			var code = $("#code").val();
			var randomCode = $("#randomCode").val();
			if(tel==""||null==tel){
				$("#valLoginMessage").html("手机号码不能为空").show();
				return false;
			}else if(!telFilter.test($("#tel").val())){
				$("#valLoginMessage").html("请输入正确的手机格式").show();
				return false;
			}else if(randomCode == "" || randomCode == null){
				$("#valLoginMessage").html("请输入4位数字随机验证码").show();
				return false;
			}else if(psd==""||psd==null){
				$("#valLoginMessage").html("密码不能为空").show();
				return false;
			}else if(psd.length<6){
				$("#valLoginMessage").html("密码不能少于6位").show();
				return false;
			}else if(psd!=againpsd){
				$("#valLoginMessage").html("两次输入密码不一致").show();
				return false;
			}else if(code==""||code==null){
				$("#valLoginMessage").html("验证码不能为空").show();
				return false;
			}
			var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

			$("#resetPwdBtn").attr("disabled","disabled");
			//重置密码
			$.ajax({
				url: '${ctx}/personalReg/resetPersonalPWD.htm',
				type: 'POST',
				data: {
					tel: $("#tel").val(),
					password: $('#psd').val(),
					code: $('#code').val()
				},
			})
			.done(function(data, textStatus, xhr) {
				switch(parseInt(data.key)){
					case 1:
						//验证码不正确
						$("#valLoginMessage").html("验证码有误").show();
						break;
					case 2:
						$("#valLoginMessage").html("重置成功");
						$(".col-sm-push-4").eq(0).hide();
						$(".col-sm-push-4").eq(1).show();
					case 4:
						$("#valLoginMessage").html("该手机号不存在").show();
						break;
					default:
						break;
				}
				$("#resetPwdBtn").removeAttr("disabled");
			})
			.fail(function() {
				$("#resetPwdBtn").removeAttr("disabled");
				console.log("error");
			});
		}

		$("#tel").focus(function() {
			$('#valLoginMessage').hide();
		});
		//校验手机是否重复
		$("#tel").blur(function(event) {
			$this = $(this);
			if( $("#tel").val()=="" || $("#tel").val()==null){
				$("#valLoginMessage").html("该手机号不能为空").show();
				return false
			}else if(!telFilter.test($("#tel").val())){
			  	$("#valLoginMessage").html("请输入正确的手机格式").show();
			    return false;
			}
			$.post('${ctx}/personalReg/checkPhone.htm', {phone: $("#tel").val()}, function(data) {
				if (data.key == '1') {
					//手机号已被注册
					$("#valLoginMessage").html("该手机号未注册").show();
				}
			});
		});

		//短信验证码
		$('#btnVerifyCode-2').click(function() {
			console.log('a')
			$("#valLoginMessage").hide();
			var tel = $("#tel").val();
			var psd = $("#psd").val();
			var code = $("#code").val();
			var randomCode = $("#randomCode").val();
			if(tel==""||null==tel){
				$("#valLoginMessage").html("手机号码不能为空").show();
				return false;
			}else if(!telFilter.test($("#tel").val())){
				$("#valLoginMessage").html("请输入正确的手机号格式").show();
				return false;
			}
			if(randomCode == "" || randomCode == null){
				$("#valLoginMessage").html("请输入4位数字随机验证码").show();
				return false;
			}
			if (!telFilter.test($("#tel").val())){
				$("#valLoginMessage").html("请输入正确的手机号格式").show();
				return false;
			}
			var timer;
			var $this = $(this);
			var num = 60;
			$.post('${ctx}/personalReg/sendResetPWDVerifyCode.htm', {
				tel: $("#tel").val(),
				countryCode: 86,
				busitype: '02',
				randomCode: randomCode
			}, function(data, textStatus, xhr) {
				console.log(data);
				if (data.key != 2) {
					$("#valLoginMessage").html(data.message).show();
					if (data.key == 5) {
						$('#randomCodeImg').click();
					}
				}else{
					$this.html(num+'秒后重新获取')
					//$this.prop('disabled', true);
					$this.addClass('disabled');
					function countdownInter() {
						if (num>1) {
							num = num - 1;
							$this.html(num+'秒后重新获取');
						} else {
							// $this.prop('disabled', false);
							$this.removeClass('disabled');
							$this.html('重新获取验证码');
							clearInterval(timer);
						}

					}
					timer = setInterval(countdownInter, 1000);
				}
			});
			
		});

		$("#psd").focus(function() {
			if (!$("#psd").val()) {
				$("#valLoginMessage").hide();
			}
		});
		//校验密码
		$("#psd").blur(function(event) {
			$this = $(this);
			var psd = $("#psd").val();
			if(psd==""||psd==null){
				$("#valLoginMessage").html("新密码不能为空").show();
				return false;
			}else if(psd.length<6){
				$("#valLoginMessage").html("新密码不能少于6位").show();
				return false;
			 }else{
				 var againpsd = $("#againpsd").val();
					if(againpsd && psd!=againpsd){
						$("#valLoginMessage").html("两次输入密码不一致").show();
						return false;
					}
			 }
			$("#valLoginMessage").hide();
		});
		//校验第二遍输入密码
		$("#againpsd").blur(function(event) {
			$this = $(this);
			var againpsd = $("#againpsd").val();
			var psd = $("#psd").val();
			if(psd!=againpsd){
				$("#valLoginMessage").html("两次输入密码不一致").show();
				return false;
			}
			$("#valLoginMessage").hide();
		});
	</script>
</body>
</html>
