<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.inputDate{
		background: transparent;
	    border: transparent;
	    font-size: 18px;
	    width: 90px;
	    margin: 0px 8px 0px 15px;
	}
</style>
<div class="bg-light lter b-b col-sm-12" id="head-title"
		style="padding: 15px 0px">
		<div class="col-sm-6 col-xs-12 no-padder">
			<span class="href-blur col-sm-12 no-padder text-muted ">
				<ul class="col-sm-12 m-n nav navbar-nav">
					<li class="m-l-md m-t-xs"><span
						class="font-h5 black-1  text-black m-t-xs" ng-click="goBack();">
							<i class="fa  fa-chevron-left m-r-xs a-cui-poi"></i>返回
					</span></li>
					<li class="dropdown" dropdown><a href
						class="dropdown-toggle clear no-padder font-h3 blue-1  text-black  m-l m-r"
						style="margin-top: 3px" dropdown-toggle> <i
							class="fa fa-calendar m-r-xs"></i>切换 <span ng-bind="changeTime"></span>
							<b class="caret"></b>
					</a>
						<ul class="dropdown-menu animated fadeInRight">
							<!-- <li><a ng-click="changeDate('1')">切换日</a></li> -->
							<li><a ng-click="changeDate('2')">切换月</a></li>
							<!-- 	<li class="divider"></li>
								<li><a ng-click="changeDate('3')">切换年</a></li> -->
						</ul>
					<li><a class="no-padder"> <i
							class="fa fa-angle-left map-jt " id="leftJt"
							style="color: #fff !important" class="m-r-xs"
							ng-click="dateLeft()"></i> <span
							class="input-append date form_datetime" id="changeTimeIdTimer"
							data-link-field="dtp_input2"> <input type="hidden"
								value="" readonly> <span id="changeTimeId1"
								class="m-l m-r  font-h2" ng-bind="mapTimeDay| date:'yyyy-MM-dd'"></span>
						</span> <input type="hidden" id="dtp_input2" value="" /> <i id="rightJt"
							class="fa fa-angle-right map-jt" ng-class="{'effiJt':dailyJt}"
							style="color: #fff !important" class="m-r-xs"
							ng-click="dateRight()"></i>
					</a></li>
				</ul>
			</span>
		</div>
		<div class="col-sm-6 text-right">
			<!-- <span class="font-h3 blue-1 text-black "><img style="width:20px;height:20px;margin-right:5px;" src="${ctx}/theme/images/icon/upLoad.png">导出数据 PDF</span> -->
		</div>
	</div>
