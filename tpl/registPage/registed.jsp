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
		.panel {width: 660px;height: 340px;position: fixed;top: 50%;left: 50%;margin-top: -170px;margin-left: -330px;}
		.goLoginBtn {color: #fff;background-color: #54a886;padding-left: 30px;padding-right: 30px;}
		.goLoginBtn:hover, .goLoginBtn:focus {color: #fff;}
		.icon-regist-tick {color: #22c1aa;font-size: 26px;margin-right: 15px;}
	</style>
</head>
<body>
	<!-- panel -->
	<div class="panel box-shadow text-center">
		<p class="font-big" style="margin-top: 100px;margin-bottom: 30px;"><i class="iconfont-regist icon-regist-tick"></i>恭喜您，注册成功</p>
		<a href="${ctx}/login.jsp" class="btn goLoginBtn" >马上去登录</a>
	</div>
	<!-- panel END -->
</body>
</html>
