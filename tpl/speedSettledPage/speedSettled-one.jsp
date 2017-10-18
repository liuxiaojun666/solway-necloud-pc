<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#stationIdFlag{display: none}
</style>
<center>
	<ul class="list-inline">
		<li><img src="${ctx}/theme/images/speedSettled/circle1.png"/></li>
		<li>填写电站信息</li>
		<li class="hr-top b-b-black5"></li>
		<li><img src="${ctx}/theme/images/speedSettled/circle2-g.png"/></li>
		<li>填写厂区信息</li>
		<li class="hr-top b-b-black5"></li>
		<li><img src="${ctx}/theme/images/speedSettled/circle3-g.png"/></li>
		<li>填写设备信息</li>
	</ul>
</center>
<div>
<div class="col-sm-12">
	<!-- --------------------------------------------------------------------------------------------------- -->
	<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStation/addPowerStationSkip-core.jsp'"></div>
	<!-- --------------------------------------------------------------------------------------------------- -->
</div>
<nav class="navbar navbar-default  bg-white b-t col-sm-12 navbar-footer-solway" role="navigation" style="height:80px">
 	<div class="navbar-header  navbar-header-black ng-scope ">
       <a href="#/" class="navbar-brand font-h2">&nbsp;</a>
     </div>
     <center class="m-t-md">
     	<button class="btn btn-next " onclick="saveForm('#/app/speedSettled/speedSettled-two','0');">
			下一步 <i class="fa fa-chevron-right m-l-xs"></i><!-- 设置未完成并保存&session赋值 -->
		</button>
		<a class="m-l-md" onclick="window.location.href='${ctx}/index.jsp'" style="color:#999">
			暂不填写，<span class="href-blur">跳过 <i class="fa fa-angle-right"></i></span>
		</a>
	</center>
</nav>
