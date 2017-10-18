<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#stationIdFlag{display: none}
</style>
<center>
	<ul class="list-inline">
		<li><img src="${ctx}/theme/images/speedSettled/circle1.png"/></li>
		<li>填写电站信息</li>
		<li class="hr-top"></li>
		<li><img src="${ctx}/theme/images/speedSettled/circle2-b.png"/></li>
		<li>填写厂区信息</li>
		<li class="hr-top b-b-black5"></li>
		<li><img src="${ctx}/theme/images/speedSettled/circle3-g.png"/></li>
		<li>填写设备信息</li>
	</ul>
</center>
<div class="col-sm-12 ">
	
	<!-- --------------------------------------------------------------------------------------------------- -->
	<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStation/powerStationList.jsp'"></div>
	<!-- --------------------------------------------------------------------------------------------------- -->
</div>
<nav class="navbar navbar-default navbar-footer-solway bg-white b-t" role="navigation">
 	<div class="navbar-header  navbar-header-black ng-scope ">
       <a href="#/" class="navbar-brand font-h2">&nbsp;</a>
     </div>
     <center class="m-t-md">
     	<button class="btn btn-prev m-r-sm" onclick="window.location.href='#/app/speedSettled/speedSettled-one'">
			<i class="fa fa-chevron-left green m-r-xs"></i> 上一步
		</button>
     	<button class="btn btn-next " onclick="window.location.href='#/app/speedSettled/speedSettled-three'">
			下一步 <i class="fa fa-chevron-right m-l-xs"></i><!-- 设置未完成并保存&session赋值 -->
		</button>
		<a class="m-l-md" onclick="window.location.href='${ctx}/index.jsp'" style="color:#999">
			暂不填写，<span class="href-blur">跳过 <i class="fa fa-angle-right"></i></span>
		</a>
	</center>
</nav>
