<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%!// \b 是单词边界(连着的两个(字母字符 与 非字母字符) 之间的逻辑上的间隔),字符串在编译时会被转码一次,所以是 "\\b"
	// \B 是单词内部逻辑间隔(连着的两个字母字符之间的逻辑上的间隔)

	String androidReg = "\\bandroid|Nexus\\b";
	String iosReg = "ip(hone|od|ad)";

	Pattern androidPat = Pattern.compile(androidReg, Pattern.CASE_INSENSITIVE);
	Pattern iosPat = Pattern.compile(iosReg, Pattern.CASE_INSENSITIVE);

	public boolean likeAndroid(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		// 匹配
		Matcher matcherAndroid = androidPat.matcher(userAgent);
		if (matcherAndroid.find()) {
			return true;
		} else {
			return false;
		}
	}
	public boolean likeIOS(String userAgent) {
		if (null == userAgent) {
			userAgent = "";
		}
		// 匹配
		Matcher matcherIOS = iosPat.matcher(userAgent);
		if (matcherIOS.find()) {
			return true;
		} else {
			return false;
		}
	}%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	//
	String userAgent = request.getHeader("USER-AGENT").toLowerCase();
	if (null == userAgent) {
		userAgent = "";
	}
	if (likeAndroid(userAgent)) {
		response.sendRedirect("http://necloud.solway.cn/necloud-m");
		return;
		//request.getRequestDispatcher("/download.html").forward(request,response);
	} else if (likeIOS(userAgent)) {
		response.sendRedirect("http://necloud.solway.cn/necloud-m");
		return;
		//request.getRequestDispatcher("/index.html").forward(request,response);
	}
%>
<!DOCTYPE html>
<html lang="en" data-ng-app="app">
<head>
<meta charset="utf-8" />
<title></title>
<meta name="description"
	content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1" />
<link type="image/x-icon" rel="shortcut icon"
	href="./theme/images/favicon.ico">
<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/theme/css/animate.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/theme/css/font-awesome.min.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/theme/css/simple-line-icons.css"
	type="text/css" />
<link rel="stylesheet" href="${ctx}/theme/css/font.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/theme/css/app.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/theme/css/base.css" type="text/css" />
<script src="${ctx}/vendor/jquery/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
	//window.history.forward(1);
	$(document).ready(function() {
		$.get('${ctx}/Login/getCustom.htm', function(result) {
			var currConfig = result.data;
			document.title = currConfig.os_title;
			$('#curr_logo').attr('src', currConfig.logo_lg);
			if (currConfig.logo_sm_flag === '0') {
				$('#curr_logo_sm_div').show();
				$('#curr_logo_sm').attr('src', currConfig.logo_sm);
			}

		});
		//平台、设备和操作系统
		var system = {
			linux : false,
			win : false,
			mac : false,
			xll : false
		};
		//检测平台
		var p = navigator.platform;
		system.linux = p.indexOf("Linux") == 0;
		system.mac = p.indexOf("Mac") == 0;
		system.ipad = p.indexOf("iPad") == 0;
		system.win = p.indexOf("Win") == 0;

		//跳转语句
		if (system.linux || system.win || system.mac) {
			//转向后台登陆页面
		} else {
			//
			window.location = "http://necloud.solway.cn/necloud-m"
		}
		if (navigator.cookieEnabled) {
		} else {
			alert("当前浏览器禁止使用Cookie，请开启Cookie否则您将无法正常浏览本网站！谢谢合作！！！");
		}
	});
	$(function() {
		if ((top.location + "").indexOf('/login.jsp') < 0) {
			top.location = '${ctx}/login.jsp';
		}
		browserVersion();
	});
	function browserVersion() {
		var browser = navigator.appName
		var b_version = navigator.appVersion
		var version = b_version.split(";");
		var trim_Version = version[1].replace(/[ ]/g, "");
		if (browser == "Microsoft Internet Explorer"
				&& trim_Version == "MSIE6.0") {
			alert("IE 版本过低，请升级IE9及以上版本");
			$("#autoLoginBtn").attr("disabled", "disabled");
			$("#loginBtn").attr("disabled", "disabled");
			return false;
			//window.location.href="http://www.imooc.com/static/html/browser.html";
		} else if (browser == "Microsoft Internet Explorer"
				&& trim_Version == "MSIE7.0") {
			alert("IE 版本过低，请升级IE9及以上版本");
			$("#autoLoginBtn").attr("disabled", "disabled");
			$("#loginBtn").attr("disabled", "disabled");
			return false;
			//	window.location.href="http://www.imooc.com/static/html/browser.html";
		} else if (browser == "Microsoft Internet Explorer"
				&& trim_Version == "MSIE8.0") {
			alert("IE 版本过低，请升级IE9及以上版本");
			$("#autoLoginBtn").attr("disabled", "disabled");
			$("#loginBtn").attr("disabled", "disabled");
			return false;
			//	window.location.href="http://www.imooc.com/static/html/browser.html";s
		}
	}
	//点击  Enter  键  登陆
	document.onkeydown = function(e) {
		var e = window.event ? window.event : e;
		if (e.keyCode == 13) {
			login();
		}
	}
	function login() {
		
		$("#loginMessage").html("");
		
		var username = $("#login_username").val();
		var password = $("#login_pass").val();
		var code = $("#login_code").val();
		if (username == "" || null == username || null == password
				|| password == "") {
			$("#loginMessage").html("用户名和密码不能为空");
			$("#loginMessage").show();
			return false;
		}
		if (code == "" || null == code) {
			$("#loginMessage").html("验证码不能为空");
			$("#loginMessage").show();
			return false;
		}
		$.post("${ctx}/Login/doLogin.htm", {
			"userName" : username,
			"password" : password,
			"randomCode" : code
		}, function(msg) {
			if (msg.status == 2) {
				$("#loginMessage").html("用户名或密码有误!");
				$("#loginMessage").show();
				$("#userImage").attr("src",
						"${ctx}/theme/images/login/userRed.png");
				$("#passwordImage").attr("src",
						"${ctx}/theme/images/login/passwordRed.png");
			} else if (msg.status == 3) {
				$("#loginMessage").html("验证码有误!");
				$("#loginMessage").show();
				$("#codeImage").attr("src",
						"${ctx}/theme/images/login/codeRed.png");
				$("#login_code").val('');
				aRefresh();
			} else if (msg.status == 4) {
				$("#loginMessage").html("用户已被锁定，请联系管理员!");
				$("#loginMessage").show();
			} else if (msg.status == 5) {
				$("#loginMessage").html("用户已被注销，请联系管理员!");
				$("#loginMessage").show();
			} else if (msg.status == 6) {
				$("#loginMessage").html("用户已在其它地方登录!");
				$("#loginMessage").show();
			} else if (msg.status == 1) {
				var storage = window.localStorage;
				storage["hasComInvite"] = 1;
				window.location.href = "${ctx}/index.jsp";
			}
		});
	}
	function dologin(userName) {
		$("#login_username").val(userName);
		$("#login_pass").val("123456");
		login();
	}
	function aRefresh() {
		$("#validateCode").attr("src",
				"Login/randomValidateCode.htm?" + Math.random());
	}
	function forgetPwd() {
		window.location.href = "${ctx}/tpl/registPage/forgetPassword.jsp";
	}

	function goRegistPage() {
		window.location.href = "${ctx}/tpl/registPage/regist.jsp";
	}
</script>
</head>
<body
	style="background-image: url('${ctx}/theme/images/login/loginBg.jpg');">
	<div style="width: 100%" class="container w-xxl w-auto-xs"
		ng-controller="SigninFormController"
		ng-init="app.settings.container = false;">

		<div id="curr_logo_sm_div"
			style="position: absolute; top: 20px; left: 20px; display: none;">
			<img alt="" id="curr_logo_sm" height="100px">
		</div>
		<div
			style="width: 500px; margin: 0 auto; height: 100px; margin-top: 5%">
			<%--<img alt="" id="curr_logo" src="${ctx}/theme/images/login/solwayCloud.png" style="width: 100%">--%>
			<img alt="" id="curr_logo" style="width: 100%; height: 100%">
			<!-- <p style="font-size: 18px;color: white;font-family: '黑体';text-align: center;margin-top: 10px">创维互联光伏电站智能运营云平台</p> -->
		</div>
		<div
			style="width: 35%; margin: 0 auto; background-color: white; margin-top: 5%">
			<div style="width: 90%; margin: 0 auto; padding-top: 25px">
				<p style="font-size: 22px; font-family: '黑体'; color: #666666">登录</p>
				<form name="form" class="form-validation">
					<table style="width: 100%">
						<tr style="height: 15px">
							<td style="width: 10%"><img id="userImage" alt=""
								src="${ctx}/theme/images/login/username.png"
								style="transform: scale(0.8);"></td>
							<td><input type="text" id="login_username" placeholder="用户名"
								class="form-control no-border" ng-model="user.email" required>
							</td>
						</tr>
					</table>
					<hr style="margin-top: 5px; margin-bottom: 5px;">
					<table style="width: 100%">
						<tr style="height: 15px">
							<td style="width: 10%"><img id="passwordImage" alt=""
								src="${ctx}/theme/images/login/password.png"
								style="transform: scale(0.8);"></td>
							<td><input id="login_pass" type="password" placeholder="密码"
								class="form-control no-border" ng-model="user.password" required>
							</td>
							<td style="width: 90px"><a onclick="forgetPwd();"
								style="font-size: 15px; color: #118C8E; text-align: center;">忘记密码?</a>
							</td>
						</tr>
					</table>
					<hr style="margin-top: 5px; margin-bottom: 5px;">
					<table style="width: 100%">
						<tr style="height: 15px">
							<td style="width: 10%"><img id="codeImage" alt=""
								src="${ctx}/theme/images/login/code.png"
								style="transform: scale(0.8);"></td>
							<td><input id="login_code" type="text" placeholder="验证码"
								class="form-control no-border" ng-model="user.logincode"
								required></td>
							<td style="width: 150px"><img class="validate-x1"
								id="validateCode" title="点击更换" onclick="javascript:aRefresh();"
								src="Login/randomValidateCode.htm"> <a
								onclick="javascript:aRefresh();" class="validate-x2"
								href="javascript:void(0);">换一张</a></td>
						</tr>
					</table>
					<hr style="margin-top: 5px; margin-bottom: 5px;">
					<p id="loginMessage"
						style="font-size: 14px; font-family: '黑体'; color: red; text-align: center; margin-bottom: -10px; display: none;"></p>
					<div style="width: 40%; margin: 0 auto; margin-top: 20px;">
						<button id="loginBtn"
							style="height: 45px; background-color: #00838F; border-color: #00838F;"
							type="button" class="btn btn-lg btn-primary btn-block"
							onclick="login()" ng-disabled='form.$invalid'>登 录</button>

					</div>
					<a class="pull-right"
						style="margin-top: -20px; font-size: 15px; color: #118C8E;"
						onclick="goRegistPage()">注册新用户</a>
					<div style="height: 20px"></div>
				</form>
			</div>
		</div>
	</div>
	<div style="text-align: center; margin-top: 20px;" align="center">
		<table
			style="width: 150px; color: #fff; font-size: 16px; margin: 0 auto;">
			<tr>
				<!-- <td style="text-align: center;padding: 5px;"><button id="autoLoginBtn" style="height: 45px;background-color:#00838F" type="button" class="btn btn-lg btn-block" onclick="dologin('demo')" >演示电站</button></td> -->
		</table>

	</div>
</body>
</html>
