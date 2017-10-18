<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    .carousel-inner {
        height: 300px;
    }
    .second-div {
        position: absolute;
    }
    .simThead.inverterTable th, .simThead-table.inverterTable td {width: 20%;}
    .status-stopped{background: #999;border-radius:50%;width: 10px;height: 10px;display: inline-block;}
    .status-trouble{background: #db412f;border-radius:50%;width: 10px;height: 10px;display: inline-block;}
    .status-alarm{background:#f90;border-radius:50%;width: 10px;height: 10px;display: inline-block;}
    .status-normal{background: #3fad22;border-radius:50%;width: 10px;height: 10px;display: inline-block;}
</style>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />

<div ng-controller="meterMonitoringCtrl">
    <input type="hidden" id="stationId" value="123">
    <div class="hbox hbox-auto-xs hbox-auto-sm"
         ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;">
        <!-- main -->
        <div class="col">
            <!-- main header -->
            <div data-ng-include="'${ctx}/tpl/meter/rtMonitorPage/monitor/model/statisticalData.jsp'"></div>
            <!-- 时间切换 -->
            <div class="col-sm-4 no-padder" style="margin-top: -63px;margin-left: 440px;">
                <a class="no-padder">
                    <i class="fa fa-angle-left map-jt " id="leftJt"
                       style="color: #fff !important" class="m-r-xs" ng-click="dateLeft()"></i>
                    <span class="input-append date form_datetime" id="changeTimeIdTimer" data-link-field="dtp_input2">
								<input type="hidden" value="" readonly>
								<span id="changeTimeId1" class="m-l m-r  font-h2" ng-bind="mapTimeDay| date:'yyyy-MM-dd'"></span>
							</span>
                    <input type="hidden" id="dtp_input2" value="" />
                    <i id="rightJt" class="fa fa-angle-right map-jt" ng-class="{'effiJt':dailyJt}"
                       style="color: #fff !important" class="m-r-xs"ng-click="dateRight()"></i>
                </a>
            </div>
            <!-- 时间切换 -->
            <!-- / main header -->

            <div class ="col-sm-12" id="autoHeight" style="padding: 20px 20px 20px 25px;">
                <div id="response_respStatus" style="display: none;"
                     class="alert alert-danger" role="alert">未接收到任何数据。请等待...</div>
                <div id="response_respStatusnull" style="display: none;"
                     class="alert alert-danger" role="alert">返回数据异常！</div>
                <div id="comm_interruptDev" style="display: none;"
                     class="alert alert-danger" role="alert">
                    通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于<span
                        ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
                </div>
                <div id="comm_initDev" style="display: none;"
                     class="alert alert-info" role="alert">设备初始化，未接收到任何数据。请等待...</div>
                <div id="getPowerStationRtData" class="row row-xs m-b-sm">
                    <!-- 今日数据 -->
                    <div class="col-xs-3 panel-stat" ng-class="{'hidden':!dailyJt}">
                        <div class="m-b-1 panel-danger">
                            <!-- <div class="col-xs-12 b-r-black panel-heading panel-green cp" style="padding: 15px 5px 8px;height: 140px;" ng-click="showRealPower('1')"> -->
                            <div class="col-xs-12 b-r-black panel-heading panel-green cp" style="padding: 15px 5px 8px;height: 140px;">
                                <div class="stat">
                                    <div class="col-xs-12 no-padder">
                                        <div class="col-xs-3 no-padder">
                                            <img src="./theme/images/solway/icon/blok1-gonglv@2x.png"class="v-middle" style="width: 100%;max-width: 60px;" />
                                        </div>
                                        <div class="col-xs-9 no-padder">
											<span class="pull-right no-padder weaterTip">
													<span class="pull-right font-big" ng-show="statDayData.weaterTag=='A'">
														<i class="ico-family ico-sun"></i>
													</span>
													<span class="pull-right font-big" ng-show="statDayData.weaterTag=='B'">
														<i class="ico-family ico-yin"></i>
													</span>
													<span class="pull-right font-big" ng-show="statDayData.weaterTag=='C'">
														<i class="ico-family ico-rain"></i>
													</span>
													<span class="pull-right font-big" ng-show="statDayData.weaterTag=='D'">
														<i class="ico-family ico-snow"></i>
													</span>
													<span class="pull-right font-big" ng-show="statDayData.weaterTag=='E'">
														<i class="ico-family ico-smog"></i>
													</span>
													<span class="pull-right font-big"ng-show="statDayData.weaterTag=='X'">
														<i class="ico-family ico-weatherelse"></i>
													</span>
											</span>
                                            <span class="" >
												<span class="text-1-5x opa-8">实时功率</span>
												<h1 class="m-n">
													<span ng-bind="statDayData.realTimePower[0]|dataNullFilter" class=""></span>
													<small class="font_white" ng-bind="statDayData.realTimePower[1]|dataNullFilter" class=""></small>
												</h1>
											</span>
                                        </div>
                                    </div>
                                    <div class="col-xs-12 no-padder m-t-mmd " ng-show="posJcvFlag">
                                        <div class="col-xs-6 no-padder">
                                            <div class="text-1-2x col-xs-12 no-padder  m-t-n-xs" >
                                                <div class="opa-8">出力比</div>
                                                <h4 class="m-n">
                                                    <span ng-bind="statDayData.outputPowerRatio|dataNullFilter"></span>%
                                                </h4>
                                            </div>
                                        </div>
                                        <div class="col-xs-4 text-center hidden">
                                            <div class="text-1-2x col-xs-12 no-padder  m-t-n-xs" >
                                                <div class="opa-8">装机容量</div>
                                                <h4 class="m-n">
                                                    <span ng-bind="statDayData.installedCapacity[0]|dataNullFilter">-</span>
                                                    <span ng-bind="statDayData.installedCapacity[1]|dataNullFilter">W</span>
                                                </h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 昨天数据开始 -->
                    <div class="col-xs-3 panel-stat" ng-class="{'hidden':dailyJt}">
                        <div class="m-b-1 panel-danger">
                            <!-- <div class="col-xs-12 b-r-black  panel-heading panel-green cp" style="padding: 15px 5px 8px;height: 140px;" ng-click="showRealPower('1')"> -->
                            <div class="col-xs-12 b-r-black  panel-heading panel-green cp" style="padding: 15px 5px 8px;height: 140px;">
                                <div class="col-xs-12 no-padder">
                                    <div class="col-xs-3 no-padder">
                                        <img src="./theme/images/solway/icon/blok1-gonglv@2x.png" class="v-middle"  style="width:100%;max-width: 60px;"/>
                                    </div>
                                    <div class="col-xs-9 no-padder">
									 <span class="pull-right no-padder weaterTip">
											<span class="pull-right font-big" ng-show="statDayData.weaterTag=='A'">
												<i class="ico-family ico-sun"></i>
											</span>
											<span class="pull-right font-big" ng-show="statDayData.weaterTag=='B'">
												<i class="ico-family ico-yin"></i>
											</span>
											<span class="pull-right font-big" ng-show="statDayData.weaterTag=='C'">
												<i class="ico-family ico-rain"></i>
											</span>
											<span class="pull-right font-big" ng-show="statDayData.weaterTag=='D'">
												<i class="ico-family ico-snow"></i>
											</span>
											<span class="pull-right font-big" ng-show="statDayData.weaterTag=='E'">
												<i class="ico-family ico-smog"></i>
											</span>
											<span class="pull-right font-big"ng-show="statDayData.weaterTag=='X'">
												<i class="ico-family ico-weatherelse"></i>
											</span>
									</span>
                                        <span class="" >
										<span class="text-1-5x opa-8">最大功率</span>
										<span class="opa-8 text-1-2x m-l" ng-bind="statDayData.maxPowerTime|date:'HH:mm'" style="font-size:14px;"></span>
											<h1 class="m-n">
												<span ng-bind="statDayData.maxPower[0]|dataNullFilter" ></span>
												<small class="font_white"   ng-bind="statDayData.maxPower[1]|dataNullFilter"></small>
										</h1>
										</span>
                                    </div>
                                </div>
                                <div class="col-xs-12 no-padder m-t-mmd " ng-show="posJcvFlag">
                                    <div class="col-xs-4 no-padder" >
                                        <div class="text-1-1x m-t-n-xs">
                                            <div class=" opa-8">出力比</div>
                                            <h4 class="m-n">
                                                <span ng-bind="statDayData.outputPowerRatio|dataNullFilter">-</span>%
                                            </h4>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 hidden">
                                        <div class="text-1-1x m-t-n-xs">
                                            <div class=" opa-8">装机容量</div>
                                            <h4 class="m-n"><span ng-bind="statDayData.installedCapacity[0]|dataNullFilter">-</span>
                                                <span ng-bind="statDayData.installedCapacity[1]|dataNullFilter">W</span>

                                            </h4>
                                        </div>
                                    </div>
                                    <div class="col-xs-8 no-padder" ng-show="posJcvFlag">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 昨天数据结束 -->
                    <!--电站个数等于1-->
                    <div class="col-sm-6 col-md-3">
                        <!-- <div class="cp panel-success panel-stat" ng-click="showRealPower('2')"> -->
                        <div class="cp panel-success panel-stat">
                            <div class="panel-heading">

                                <div class="stat">
                                    <div class="row">
                                        <div class="col-xs-3 no-padder">
                                            <img src="./theme/images/solway/icon/icon_day.png" alt="">
                                        </div>
                                        <div class="col-xs-9 no-padder">
                                            <small class="stat-label">日用电量</small>
                                            <h1>
                                                <span ng-bind="statDayData.dayGeneratingPower[0]|dataNullFilter" class="ng-binding">0.00</span>
                                                <small class="m-l-xs">
                                                    <span ng-bind="statDayData.dayGeneratingPower[1]|dataNullFilter" class="ng-binding">kWh</span></small>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <!-- stat -->
                            </div>
                            <!-- panel-heading -->
                        </div>
                        <!-- panel -->
                    </div>
                    <!-- col-sm-6 -->
                    <div class="col-sm-6 col-md-3">
                        <!-- <div class="panel-primary panel-stat panel-stat-notoday cp" ng-click="showRealPower('3')"> -->
                        <div class="panel-primary panel-stat panel-stat-notoday cp">
                            <div class="panel-heading">
                                <div class="stat">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <img src="./theme/images/solway/icon/icon_month.png" alt="">
                                        </div>
                                        <div class="col-xs-8 no-padder">
                                            <small class="stat-label">月累计用电量</small>
                                            <h1>
                                                <span ng-bind="statDayData.monthGeneratingPower[0]|dataNullFilter" class="ng-binding">0.00</span><small
                                                    class="m-l-xs"><span ng-bind="statDayData.monthGeneratingPower[1]|dataNullFilter"
                                                                         class="ng-binding">kWh</span></small>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                               	<div class="clearfix" style="margin:18px;">
                               		<div class="col-sm-6 no-padder ">最大功率<span>100kW</span></div>
                               		<div class="col-sm-6 no-padder text-right">最小功率<span>10kW</span></div>
                               	</div>
                            </div>
                            <!-- panel-heading -->
                        </div>
                        <!-- panel -->
                    </div>
                    <!-- col-sm-6 -->
                    <div class="col-sm-6 col-md-3">
                       <!--  <div class="panel-dark panel-stat panel-stat-notoday cp" ng-click="showRealPower('4')"> -->
                        <div class="panel-dark panel-stat panel-stat-notoday cp">
                            <div class="panel-heading">
                                <div class="stat">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <img src="./theme/images/solway/icon/icon_year.png" alt="">
                                        </div>
                                        <div class="col-xs-8 no-padder">
                                            <small class="stat-label">年累计用电量</small>
                                            <h1>
                                                <span ng-bind="statDayData.yearGeneratingPower[0]|dataNullFilter" class="ng-binding">0.00</span><small
                                                    class="m-l-xs"><span ng-bind="statDayData.yearGeneratingPower[1]|dataNullFilter"
                                                                         class="ng-binding">kWh</span></small>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="clearfix" style="margin:18px;color: white;">
                               		<div class="col-sm-6 no-padder ">最大功率<span>100kW</span></div>
                               		<div class="col-sm-6 no-padder text-right">最小功率<span>10kW</span></div>
                               	</div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 第一排开始 -->
                <div class="row row-sm" id="first-div">
                    <div class="col-sm-12">
                        <div class="panel wrapper">
                            <div id="ssglqx" style="min-height: 237px;"></div>
                        </div>
                    </div>
                </div>
                <div data-ng-include="'${ctx}/tpl/meter/rtMonitorPage/monitor/model/powerModal.jsp'"></div>
            </div>
        </div>
    </div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div class="waterPlaceholder"></div>
<script src="${ctx}/theme/js/powerMeter/meterMonitoring.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script>
function responseHeight(){
	var het = 380;
	$(".alert").each(function(){
		if($(this).is(":visible")){
			het = 450;
		}
	});
	$("#ssglqx").css("height", $(window).height() - het);
	if(myChart){
		myChart.resize();
	}
}
window.addEventListener("resize", function() {
	responseHeight();
});
responseHeight();
$('.simThead_inverter').scroll(function(event) {
	$('.simThead_inverter .simThead').css('top', $(this).scrollTop());
});
$(".modal-backdrop").css("display", "none")
//改变table 的样式
function fullScreen() {
	$("#first-div").slideUp("slow", function() {
		//var height = $(window).height()- 267;
		//$("#table-div").css("height", height);
		$("#fullScreen").addClass("hover-action");
		$("#closeFullScreen").removeClass("hover-action");

	});
}
//退出全屏样式修改
function closeFullScreen() {
	//var height = $(window).height()- (77 + $("#first-div").height() + 70 + 70  + 50);
	//$("#table-div").css("height", height);
	$("#first-div").slideDown("slow", function() {
		$("#fullScreen").removeClass("hover-action");
		$("#closeFullScreen").addClass("hover-action");
	});
}
</script>
