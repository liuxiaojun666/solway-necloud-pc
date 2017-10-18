<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/tpl/statisticAnalysisPage/js/controllers/staDay.js"></script>
<div class="col-sm-12 norm" ng-controller="staDayCtrl" >
	<!--电站个数大于1-->
	<%--<div class="col-sm-12 no-padder" ng-class="{'hidden':!showRootStation}">--%>
	<!-- 今日数据 -->
	<%--<div class="col-sm-12 wrapper norm-module-red m-b-1 hvr-solway" ng-class="{'hidden':!dailyJt}"  ng-click="showRealPower()">--%>
		<%--<div class="col-sm-6 " style="padding-right:0px">--%>
			<%--<i class="m-r-xs">--%>
				<%--<img src="${ctx}/theme/images/statisticAnalysisPage/blok1-gonglv@2x.png"class="v-middle" style="zoom: 0.4;" />--%>
			<%--</i>--%>
			<%--<span class="text-1-6x opa-8">实时功率</span>--%>
			<%--<div>--%>
				<%--<span  class="text-3x" ng-bind="statDayData.realTimePower[0]|dataNullFilter">-</span>--%>
				<%--<span class="text-2x" ng-bind="statDayData.realTimePower[1]|dataNullFilter">kWh</span>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="col-sm-6 m-t-sm">--%>
			<%--<div class="m-b-xs text-1-3x opa-8">出力比--%>
			<%--<span class="pull-right text-1-4x"><span ng-bind="statDayData.outputPowerRatio|dataNullFilter"></span>%</span></div>--%>
			<%--<div class="progress-xxs col-sm-12 no-padder progress m-b-sm bg-op2" value="25" animate="true" type="warning">--%>
  				<%--<div class="progress-bar bg-white" ng-style="{width: statDayData.outputPowerRatio + '%'}" ></div>--%>
			<%--</div>--%>
			<%--<div class="text-1-2x">--%>
			<%--<span ng-bind="statDayData.powerStationNum|dataNullFilter"></span>个电站,总装机--%>
			<%--<span ng-bind="statDayData.installedCapacity[0]|dataNullFilter">-</span>--%>
			<%--<span ng-bind="statDayData.installedCapacity[1]|dataNullFilter">W</span></div>--%>

		<%--</div>--%>
	<%--</div>--%>
	<!-- 昨天数据开始 -->
	<%--<div class="col-sm-12 wrapper norm-module-red m-b-1 hvr-solway"  ng-class="{'hidden':dailyJt}"  ng-click="showRealPower()">--%>
		<%--<div class="col-sm-6" style="padding-right:0px">--%>
			<%--<i class="m-r-xs">--%>
				<%--<img src="${ctx}/theme/images/statisticAnalysisPage/blok1-gonglv@2x.png"class="v-middle" style="zoom: 0.4;" />--%>
			<%--</i>--%>
			<%--<span class="text-1-6x opa-8">最大功率</span>--%>
			<%--<div  >--%>
				<%--<span class="text-3x" ng-bind="statDayData.maxPower[0]|dataNullFilter">-</span>--%>
				<%--<span class="text-2x" ng-bind="statDayData.maxPower[1]|dataNullFilter">kW</span>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="col-sm-6 m-t-sm">--%>
			<%--<div class="m-b-xs text-1-3x  opa-8">最大出力比--%>
			<%--<span class="pull-right text-1-4x"><span ng-bind="statDayData.maxOutputPowerRatio|dataNullFilter"></span>%</span></div>--%>
			<%--<div class="progress-xxs col-sm-12 no-padder progress m-b-sm  bg-op2" value="25" animate="true" type="warning">--%>
  				<%--<div class="progress-bar bg-white" ng-style="{width: statDayData.maxOutputPowerRatio + '%'}" ></div>--%>
			<%--</div>--%>
			<%--<div class="text-1-2x">--%>
			<%--<span ng-bind="statDayData.powerStationNum|dataNullFilter"></span>个电站,总装机--%>
			<%--<span ng-bind="statDayData.installedCapacity[0]|dataNullFilter">-</span>--%>
			<%--<span ng-bind="statDayData.installedCapacity[1]|dataNullFilter">kWh</span></div>--%>

		<%--</div>--%>
	<%--</div>--%>
	<!-- 昨天数据结束 -->
	<%--</div>--%>
	<!--电站个数大于1-->

	<!--电站个数等于1-->
	<div class="col-sm-12 no-padder" ng-class="{'hidden':showRootStation}">
	<!-- 今日数据 -->
	<%--<div class="col-sm-12 no-padder m-b-1 " ng-class="{'hidden':!dailyJt}" style="padding: 8px 10px;">--%>
		<%--<div class="col-sm-8 b-r-black  norm-module-red hvr-solway" style="padding: 15px 5px 8px;height: 120px;" ng-click="showWeatherPower()">--%>
			<%--<div class="col-sm-12">--%>
				<%--<i class=" m-t-n-xs">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/blok1-gonglv@2x.png" class="v-middle" style="zoom: 0.4;">--%>
				<%--</i>--%>
				<%--<span class="text-1-5x opa-8">实时功率</span>--%>
				<%--<span class="pull-right no-padder">--%>
				<%--<span class="pull-right" ng-show="statDayData.weaterTag=='A'">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/weather/q.png" class="weaPic">--%>
				<%--</span>--%>
				<%--<span class="pull-right"  ng-show="statDayData.weaterTag=='B'">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/weather/y.png" class="weaPic">--%>
				<%--</span>--%>
				<%--<span class="pull-right"  ng-show="statDayData.weaterTag=='C'">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/weather/yu.png" class="weaPic">--%>
				<%--</span>--%>
				<%--<span class="pull-right"  ng-show="statDayData.weaterTag=='D'">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/weather/x.png" class="weaPic">--%>
				<%--</span>--%>
				<%--<span  class="pull-right" ng-show="statDayData.weaterTag=='E'">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/weather/m.png" class="weaPic">--%>
				<%--</span>--%>
				<%--<span class="pull-right"  ng-show="statDayData.weaterTag=='X'">--%>
					<%--<img src="${ctx}/theme/images/statisticAnalysisPage/weather/other.png" class="weaPic">--%>
				<%--</span>--%>
				<%--</span>--%>
				<%--<div class="" >--%>
					<%--<span ng-bind="statDayData.realTimePower[0]|dataNullFilter" class="text-2-8x">0</span>--%>
					<%--<span  ng-bind="statDayData.realTimePower[1]|dataNullFilter" class="text-2-8x">W</span>--%>
					<%--<span><span ng-bind="statDayData.outputPowerRatio|dataNullFilter" class="opa-8 text-1-2x"></span>%</span>--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="col-sm-6">--%>
				<%--<div class="text-1-2x col-sm-12 no-padder  m-t-n-xs" >--%>
					<%--<div class="opa-8">装机容量</div>--%>
					<%--<span ng-bind="statDayData.installedCapacity[0]|dataNullFilter">-</span>--%>
					<%--<span ng-bind="statDayData.installedCapacity[1]|dataNullFilter">W</span>--%>
				<%--</div>--%>
			<%--</div>--%>
			<%--<div class="col-sm-6">--%>
				<%--<div class="pull-right">--%>
					<%--<div class="opa-8">光照强度</div>--%>
					<%--<div ><span ng-bind="statDayData.luminousIntensity[0]|dataNullFilter">-</span>--%>
						<%--<span ng-bind="statDayData.luminousIntensity[1]|dataNullFilter">W/㎡</span>--%>
						<%--</div>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="col-sm-4 no-padder norm-module-scroll " style="height: 120px;"  ng-click="showSyScore()">--%>
			<%--<div class="text-center scoreScroll">--%>
				<%--<div class="text-2-6x m-t-sm"  ng-bind="statDayData.powerStationScores|dataNullFilter">89</div>--%>
				<%--<div class="text-1-6x m-t-n-xs">综合得分</div>--%>
			<%--</div>--%>
		<%--</div>--%>
	<%--</div>--%>
	<!-- 昨天数据开始 -->
	<div class="col-sm-12 no-padder m-b" ng-class="{'hidden':dailyJt}" style="padding: 8px 10px;">
		<div class="col-sm-8 b-r-black  norm-module-red hvr-solway" style="padding: 15px 5px 8px;height: 130px;">
			<div class="col-sm-12 ">
				<i class=" m-t-n-xs">
					<img src="${ctx}/theme/images/statisticAnalysisPage/blok1-gonglv@2x.png" class="v-middle" style="zoom: 0.4;">
				</i>
				<span class="text-1-5x opa-8">最大功率</span>
				<span class="pull-right no-padder">
				<span class="pull-right" ng-show="statDayData.weaterTag=='A'">
					<img src="${ctx}/theme/images/statisticAnalysisPage/weather/q.png" class="weaPic">
				</span>
				<span class="pull-right"  ng-show="statDayData.weaterTag=='B'">
					<img src="${ctx}/theme/images/statisticAnalysisPage/weather/y.png" class="weaPic">
				</span>
				<span class="pull-right"  ng-show="statDayData.weaterTag=='C'">
					<img src="${ctx}/theme/images/statisticAnalysisPage/weather/yu.png" class="weaPic">
				</span>
				<span class="pull-right"  ng-show="statDayData.weaterTag=='D'">
					<img src="${ctx}/theme/images/statisticAnalysisPage/weather/x.png" class="weaPic">
				</span>
				<span  class="pull-right" ng-show="statDayData.weaterTag=='E'">
					<img src="${ctx}/theme/images/statisticAnalysisPage/weather/m.png" class="weaPic">
				</span>
				<span class="pull-right"  ng-show="statDayData.weaterTag=='X'">
					<img src="${ctx}/theme/images/statisticAnalysisPage/weather/other.png" class="weaPic">
				</span>
			</span>
				<div  class="m-b-xs">
					<span ng-bind="statDayData.maxPower[0]|dataNullFilter" class="ng-binding text-2x "></span>
					<span ng-bind="statDayData.maxPower[1]|dataNullFilter" class="ng-binding text-1-8x ">kW</span>
					<span class="text-1-2x"><span  ng-bind="statDayData.maxOutputPowerRatio|dataNullFilter" ></span>%</span>
					<span class="opa-8 text-1-2x" ng-bind="statDayData.maxPowerTime|date:'HH:mm'"></span>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="text-1-1x">
					<div class=" opa-8">装机容量</div>
					<div ><span ng-bind="statDayData.installedCapacity[0]|dataNullFilter">-</span>
						<span ng-bind="statDayData.installedCapacity[1]|dataNullFilter">W</span>

					</div>
				</div>
			</div>
			<div class="col- xs-6">
				<div class="text-1-1x">
					<div class=" opa-8">最大光照</div>
					<div ><span ng-bind="statDayData.maxLuminousIntensity[0]|dataNullFilter">-</span>
						<span ng-bind="statDayData.maxLuminousIntensity[1]|dataNullFilter">W/㎡</span>
						<span ng-bind="statDayData.maxLuminousIntensityTime|date:'HH:mm'"></span>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-4 no-padder norm-module-scroll " style="height: 130px;">
			<div class="text-center scoreScroll">
				<div class="text-2-6x m-t-sm"  ng-bind="statDayData.powerStationScores|dataNullFilter">89</div>
				<div class="text-1-6x m-t-n-xs">综合得分</div>
			</div>
		</div>
	</div>
	<!-- 昨天数据结束 -->
	</div>
	<!--电站个数等于1-->
	<div class="col-sm-4 no-padder ">
		<div class="col-sm-12 no-padder m-b-1">
			<div class="col-sm-6 wrapper text-center norm-module-day b-r-black hvr-solway padding-media">
				<span class="opa-8">日发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs">
					<span class="text-2-4x" ng-bind="statDayData.dayGeneratingPower[0]|dataNullFilter"></span>
					<span class="text-2-2x" ng-bind="statDayData.dayGeneratingPower[1]|dataNullFilter">kWh</span>
				</div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.dayGeneratingPowerIncome[0]|dataNullFilter"></span>
										<span  class="text-1-2x" ng-bind="statDayData.dayGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
			</div>
			<div class="col-sm-6 wrapper text-center norm-module-mon hvr-solway padding-media">
				<span class="opa-8">月发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.monthGeneratingPower[0]|dataNullFilter"></span>
												<span class="text-2-2x" ng-bind="statDayData.monthGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.monthGeneratingPowerIncome[0]|dataNullFilter"></span>
												<span class="text-1-2x" ng-bind="statDayData.monthGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
				<span class="norm-tip"><span ng-bind="statDayData.monthGeneratingPowerHour|dataNullFilter"></span>h</span>
			</div>
		</div>
		<div class="col-sm-12 no-padder">
			<div class="col-sm-6 wrapper text-center norm-module-year b-r-black hvr-solway padding-media">
				<span class="opa-8">年发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.yearGeneratingPower[0]|dataNullFilter"></span>
												<span class="text-2-2x" ng-bind="statDayData.yearGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.yearGeneratingPowerIncome[0]|dataNullFilter"></span>
												<span class="text-1-2x" ng-bind="statDayData.yearGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
				<span class=" norm-tip"><span ng-bind="statDayData.yearGeneratingPowerHour|dataNullFilter"></span>h</span>
			</div>
			<div class="col-sm-6 wrapper text-center norm-module-all hvr-solway padding-media">
				<span class="opa-8">累计发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.accumulateGeneratingPower[0]|dataNullFilter"></span>
												<span class="text-2-2x" ng-bind="statDayData.accumulateGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.accumulateGeneratingPowerIncome[0]|dataNullFilter"></span>
												<span class="text-1-2x" ng-bind="statDayData.accumulateGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
				<span class="norm-tip"><span ng-bind="statDayData.accumulateGeneratingPowerHour|dataNullFilter"></span>h</span>
			</div>
		</div>
	</div>
	<div class="col-sm-8  p-l-sm">
	<div class=" norm-black-bg">
		<span class="text-1-4x col-sm-12 no-padder m-t-xs m-l-sm">功率趋势图</span>
		<div class="col-sm-12 no-padder">
			<div class="col-sm-12 text-center m-t-xs"id="loadFlags">
			 </div>
			<div id="ssglqxDay" style="height:180px;"></div>
		</div>
		<div class="col-sm-6 pull-right m-t">
			<div class="col-sm-4 no-padder text-center">
				<i class="fa fa-circle" style="color: #92aaff"></i> <span
					class="col-9 m-r-xs">应发功率<small>(kW)</small></span>

				</span>
			</div>
			<div class="col-sm-4 no-padder text-center">
				<i class="fa fa-circle" style="color: #f56669"></i> <span
					class="col-9 m-r-xs">实发功率<small>(kW)</small></span>
			</div>
			<div class="col-sm-4 no-padder text-center">
				<span class="pull-right"> <i class="fa fa-circle"
					style="color: #efb800"></i> <span class="col-9">光照强度(W/㎡)</span>
				</span>
			</div>
		</div>
		</div>
	</div>
</div>
	<toaster-container toaster-options="{'position-class': 'toast-top-full-width', 'close-button':true,'time-out':5000000}">
</toaster-container>
