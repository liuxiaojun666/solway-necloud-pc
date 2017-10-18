<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%!
// \b 是单词边界(连着的两个(字母字符 与 非字母字符) 之间的逻辑上的间隔),字符串在编译时会被转码一次,所以是 "\\b"
// \B 是单词内部逻辑间隔(连着的两个字母字符之间的逻辑上的间隔)

String androidReg = "\\bandroid|Nexus\\b";
String iosReg = "ip(hone|od|ad)";

Pattern androidPat = Pattern.compile(androidReg, Pattern.CASE_INSENSITIVE);
Pattern iosPat = Pattern.compile(iosReg, Pattern.CASE_INSENSITIVE);

public boolean likeAndroid(String userAgent){
    if(null == userAgent){
        userAgent = "";
    }
    // 匹配
    Matcher matcherAndroid = androidPat.matcher(userAgent);
    if(matcherAndroid.find()){
        return true;
    } else {
        return false;
    }
}
public boolean likeIOS(String userAgent){
    if(null == userAgent){
        userAgent = "";
    }
    // 匹配
    Matcher matcherIOS = iosPat.matcher(userAgent);
    if(matcherIOS.find()){
        return true;
    } else {
        return false;
    }
}

%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//
String userAgent = request.getHeader( "USER-AGENT" ).toLowerCase();
if(null == userAgent){
    userAgent = "";
}
if(likeAndroid(userAgent)){
    response.sendRedirect("http://necloud.solway.cn/necloud-m");
    return;
    //request.getRequestDispatcher("/download.html").forward(request,response);
} else if(likeIOS(userAgent)){
    response.sendRedirect("http://necloud.solway.cn/necloud-m");
    return;
    //request.getRequestDispatcher("/index.html").forward(request,response);
}
%>
<!DOCTYPE html>
<html lang="en" data-ng-app="app">
<head>
  <meta charset="utf-8" />
  <title>大唐登录</title>
  <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link type="image/x-icon" rel="shortcut icon" href="./theme/images/favicon.ico">
  <link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/app.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/datang/loginDatang.css" type="text/css" />
  <script src="${ctx}/vendor/jquery/jquery.min.js" type="text/javascript"></script>
</head>
<body style="overflow: hidden;">
	<div class="dt-login-bg" id="dt-login-bg"></div>
	<div class="clearfix white" style="height:100%;position: absolute;width: 100%;z-index: 2;">
		<div class="pull-left form-container" id="hover-out-area" style="width:45%;background:rgba(0,10,41,0.5);height:100%;">
			<h1 class=" text-center font30">智慧绿色能源管控平台</h1>
			<div class="form-con">
				<div class="input-con webkit-box"><input type="text" name="login_username" placeholder="用户名" id="login_username" class="flex font22"></div>
				<div class="input-con webkit-box"><input type="password" name="login_pass" placeholder="密码" id="login_pass"  class="flex font22" ></div>
				<div class="input-con webkit-box">
					<div class="flex"><input type="text" name="login_code" placeholder="验证码"  id="login_code" class="font22 flex" style="width: 100%;height: 42px;" ></div>
					<div class="validate-con" >
						<img class="validate-x1" id="validateCode" title="点击更换" onclick="javascript:aRefresh();" src="Login/randomValidateCode.htm">
						<a style="display:inline-block;width:50px;" onclick="javascript:aRefresh();" class="validate-x2 font14" href="javascript:void(0);">换一个</a>
					</div>
				</div>
				<!-- <div><input type="checkbox" name="checkRememberPassWord" id="rememberPw"><label for="rememberPw" class="font16  black">记住密码</label></div> -->
				<p id="loginMessage" style="font-size: 14px;color:red;text-align: center;margin-bottom: -10px;display: none;"></p>
				<div style="margin:1rem auto 1.4rem;"><a class="font30 login-btn" onclick="login()">登录</a></div>
			</div>
			<div class="clearfix" style="width: 36%;">
				<div class="pull-left" style="width:50%;"><a class="font16 white" onclick="goRegistPage()">新用户注册</a></div>
				<div class="pull-left text-right" style="width:50%;"><a class="font16 white" onclick="forgetPwd();">忘记密码？</a></div>
			</div>
		</div>
		<div class="pull-right text-right" id="hover-area" style="width:55%;height: 100%;"><img src="${ctx}/theme/images/datang/login/company-logo.png" style="margin-top:50px;margin-right:45px;">
			<div class="slogan form-container">
				<div style="width: 100%;position:relative;height:10rem;">
					<span style="top: 4.8rem;left: 0;"><img src="theme/images/datang/login/quote-left.png" style="width: 2.1rem;"></span>
					<span class="font72" style="left: 10.5%;bottom: -1rem;">务实</span>
					<span class="font42" style="top: 2.5rem; left: 38%;">创新</span>
					<span class="font42" style="bottom: -1.2rem;    right: 29%;">绿色</span>
					<span class="font72" style="top: 0.7rem;right: 9%;">共赢</span>
					<span style="top: 0;right: 0;"><img src="theme/images/datang/login/quote-right.png" style="width: 2.1rem;"></span>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(function(){
	if((top.location+"").indexOf('/login.jsp')<0){
		  top.location = '${ctx}/login.jsp';
	}
	browserVersion();
	$("#hover-area").on("mouseover",function(){
		$("#dt-login-bg").addClass("mouseover");
		/* setTimeout(function(){
			$("#dt-login-bg").removeClass("mouseover");
		},1000); */
	})
	$("#hover-out-area").on("mouseover",function(){
		$("#dt-login-bg").removeClass("mouseover");
	});
	$('input').on('input propertychange',function(){
		
        if( ($.trim($('#login_username').val()) !=="" ) && ($.trim($('#login_pass').val())!=="") && ($.trim($('#login_code').val())!=="")){
	        $('a.login-btn').css('opacity',1);
	    }else{
	        $('a.login-btn').css('opacity',0.5);     
        }
    });
 });
function aRefresh() {
	$("#validateCode").attr("src", "Login/randomValidateCode.htm?" + Math.random());
}
document.onkeydown = function(e){
   var e = window.event   ?   window.event   :   e;
   if(e.keyCode == 13){
	   login();
	}
}
function login(){
	 $("#loginMessage").hide();
	  var username = $("#login_username").val();
	  var password = $("#login_pass").val();
	  var code = $("#login_code").val();
	  if(username==""||null==username||null==password||password=="")
	  {
		  	  $("#loginMessage").html("用户名、密码、验证码不能为空").show();
		      return false;
	  }
	  if(code==""||null==code)
	  {
		  	  $("#loginMessage").html("验证码不能为空").show();
		      return false;
	  }
	  $.post("${ctx}/Login/doLogin.htm",
			{"userName":username,"password":password,"randomCode":code},function (msg){
				 if(msg.status==2){
					 $("#loginMessage").html("用户名或密码有误!");
					 $("#loginMessage").show();
				 }else if(msg.status==3){
					 $("#loginMessage").html("验证码有误!");
					 $("#loginMessage").show();
					 $("#login_code").val('');
					 aRefresh();
				 }else if(msg.status==4){
					 $("#loginMessage").html("用户已被锁定，请联系管理员!").show();
				 }else if(msg.status==5){
					 $("#loginMessage").html("用户已被注销，请联系管理员!").show();
				 }else if(msg.status==6) {
					 $("#loginMessage").html("用户已在其它地方登录!").show();
				 } else if(msg.status==1){
					var storage = window.localStorage;
					storage["hasComInvite"]= 1;
				 	window.location.href="${ctx}/index.jsp";
				 }
		  });
}
function forgetPwd(){
	  window.location.href="${ctx}/tpl/registPage/forgetPassword.jsp";
}

function goRegistPage(){
	  window.location.href="${ctx}/tpl/registPage/regist.jsp";
}
$(document).ready(function(){
	  
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

 function browserVersion(){
	  var browser=navigator.appName
	  var b_version=navigator.appVersion
	  var version=b_version.split(";");
	  var trim_Version=version[1].replace(/[ ]/g,"");
	  if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0")
	  {
	  	alert("IE 版本过低，请升级IE9及以上版本");
	  	$("#autoLoginBtn").attr("disabled","disabled");
	  	$("#loginBtn").attr("disabled","disabled");
	  	return false;
	  }
	  else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0")
	  {
		  alert("IE 版本过低，请升级IE9及以上版本");
		  $("#autoLoginBtn").attr("disabled","disabled");
		  	$("#loginBtn").attr("disabled","disabled");
		  	return false;
	  }
	  else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE8.0")
	  {
		  alert("IE 版本过低，请升级IE9及以上版本");
		  $("#autoLoginBtn").attr("disabled","disabled");
		  	$("#loginBtn").attr("disabled","disabled");
		  	return false;
	  }
 }
</script>
</body>
</html>
