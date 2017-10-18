<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="bg-light lter b-b col-sm-12" id="head-title"style="padding: 15px 0px">
	<div class="col-sm-6 col-xs-12 no-padder">
		<span class="href-blur col-sm-12 no-padder text-muted ">
			<ul class="col-sm-12 m-n nav navbar-nav">
				<li class="m-l-md"><span class="font-h2 blue-1  text-black">演示电站</span>
				</li>
				<li class="dropdown" dropdown>
					<a href class="dropdown-toggle clear no-padder font-h3 blue-1  text-black  m-l m-r" style="margin-top:3px"
						dropdown-toggle>
						<i class="fa fa-calendar m-r-xs"></i>切换 <span ng-bind="changeTime"></span>
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu animated fadeInRight">
						<li><a ng-click="changeDate('2')">切换月</a></li>
						<li><a ng-click="changeDate('1')">切换日</a></li>
					</ul> 
				<li>
					<a class="no-padder"> 
						<i class="fa fa-angle-left map-jt " style="color:#fff!important"class="m-r-xs"ng-click="dateLeft()"></i>
						<span id="changeTimeId2" class="m-l m-r  font-h2"ng-bind="mapTimeMonth"></span>
						<i class="fa fa-angle-right map-jt"style="color:#fff!important" class="m-r-xs"ng-click="dateRight()"></i>
					</a>
				</li>
			</ul>
		</span>
	</div>
	<div class="col-sm-6 text-right">
	<span class="font-h3 blue-1 text-black ">导出数据</span>
	</div>
</div>
