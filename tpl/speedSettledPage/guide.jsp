<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="description" content="">
<meta name="author" content="">
<title>创维互联</title>
<!-- Bootstrap core CSS -->
<script src="${ctx}/vendor/jquery/jquery.min.js"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap.min.js"></script>
<link href="${ctx}/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="${ctx}/speedSettled/css/common.css" rel="stylesheet" type="text/css">
<link href="${ctx}/theme/css/app.css" rel="stylesheet" type="text/css">
<!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
<!--[if lt IE 9]>
<script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Custom styles for this template -->
</head>
<body style="background-color: #F0F0F0">
<div class="container">

	<center class="col-sm-12">
		<h2 style="padding-bottom: 40px;">快速入驻</h2>
		<ul class="list-inline">
			<li><img src="${ctx}/theme/images/speedSettled/circle1.png"/></li>
			<li>填写电站信息</li>
			<li class="hr-top"></li>
			<li><img src="${ctx}/theme/images/speedSettled/circle2.png"/></li>
			<li>填写厂区信息</li>
			<li class="hr-top b-b-black5"></li>
			<li><img src="${ctx}/theme/images/speedSettled/circle3.png"/></li>
			<li>填写设备信息</li>
		</ul>
	</center>
    
    <form>
	<div class="col-sm-12 m-l-llg p-r-llg m-sm">
		<ul class="list-inline">
			<li>电站编号</li>
			<li><input class="form-control" type="text" placeholder="例如：120345" ></li>
			<li>电站名称</li>
			<li><input class="form-control" type="text" placeholder="请输入电站名称" ></li>
			<li>所属企业</li>
			<li><input class="form-control" type="text" placeholder="请选择所属企业" ></li>
			<li>负责人</li>
			<li><input class="form-control" type="text" placeholder="请选择负责人" ></li>
			<li>总装机量</li>
			<li><input class="form-control" type="text" placeholder="例如：111" ></li>
			<li>投产时间</li>
			<li><input class="form-control" type="text" placeholder="" ></li>
			<li>停产时间</li>
			<li><input class="form-control" type="text" placeholder="" ></li>
		</ul>
	</div>
	<!-- 分割线 -->
	<div class="col-sm-12 m-b-md no-padder dotted-hr"/></div>
	
	<div class="col-sm-12 m-l-llg p-r-llg m-sm">
		<ul class="list-inline">
			<li>地址</li>
			<li>
				<select class="form-control" id="province" onchange="setCity(this.value);getArea()" name="province">
					<option value="" selected="selected">选择省</option>
				</select></li>
			<li>
				<select class="form-control" id="city" onchange="setCounty(this.value);getArea()" name="city" style="display:;">
					<option value="" selected="selected">选择市</option>
				</select></li>
			<li>	
				<select class="form-control" id="county" name="county" onchange="getArea()" style="display:;">
					<option value="" selected="selected">选择县</option>
				</select></li>
			<li>经度</li>
			<li><input class="form-control" type="text" placeholder="经度" ></li>
			<li>纬度</li>
			<li><input class="form-control" type="text" placeholder="纬度" ></li>
			<li><input class="form-control" type="text" placeholder="请填写详细地址" ></li>
		</ul>
		<input class="form-control" type="text" name="area" id="area" placeholder="地区编码" onchange="setArea();">
		<input type="button" value="转" onclick="setArea();" hidden="h">
		<script type="text/javascript" src="${ctx}/speedSettled/js/local.js" ></script>
	</div>
	<!-- 分割线 -->
	<div class="col-sm-12 m-b-md no-padder dotted-hr"/></div>
	
	<div class="col-sm-12 m-l-llg p-r-llg">
		<ul class="list-inline">
			<li>实景图片</li>
			<li><img src="theme/images/p0.jpg"/></li>
			<li><img src="theme/images/p0.jpg"/></li>
			<li><img src="theme/images/p0.jpg"/></li>
			
			<li class="m-l-xl">其他介绍</li>
			<li><textarea class="form-control" style="padding: 30px;" rows="1"></textarea></li>
		</ul>
	</div>
	</form>

	<center class="m-t-xxl col-sm-12 ">
		<button class="btn size-lg btn-green ">放弃 [进入系统]</button>
		<a class="btn btn-blue" href="success.html">下一步</a>
	</center>

</div>
</body>
</html>
