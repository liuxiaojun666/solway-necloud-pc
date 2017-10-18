<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/tpl/statisticAnalysisPage/js/controllers/staMon.js"></script>
<div class="col-sm-12 norm" ng-controller="staMonCtrl" >
	<!--电站个数等于1-->
	<div class="col-sm-4 no-padder ">
		<div class="col-sm-12 no-padder m-b-1">
			<div class="col-sm-6 wrapper text-center norm-module-day b-r-black hvr-solway padding-media">
				<span class="opa-8 ">
					<span id="maxDay" ng-bind="statDayData.maxDayGeneratingPowerTime|date:'dd'"></span>日发电量最高/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.maxDayGeneratingPower[0]|dataNullFilter"></span>
												<span class="text-2-2x"  ng-bind="statDayData.maxDayGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.maxDayGeneratingPowerIncome[0]|dataNullFilter"></span>
												<span class="text-1-2x" ng-bind="statDayData.maxDayGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
			</div>
			<div class="col-sm-6 wrapper text-center norm-module-mon hvr-solway padding-media">
				<span class="opa-8">月发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.monthGeneratingPower[0]|dataNullFilter"></span>
												<span class="text-2-2x"  ng-bind="statDayData.monthGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.monthGeneratingPowerIncome[0]|dataNullFilter"></span>
												<span class="text-1-2x" ng-bind="statDayData.monthGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
				<span class=" norm-tip"><span ng-bind="statDayData.monthGeneratingPowerHour|dataNullFilter"></span>h</span>
			</div>
		</div>
		<div class="col-sm-12 no-padder">
			<div class="col-sm-6 wrapper padding-media text-center norm-module-year b-r-black hvr-solway">
				<span class="opa-8">年发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.yearGeneratingPower[0]|dataNullFilter"></span>
					<span class="text-2-2x"  ng-bind="statDayData.yearGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.yearGeneratingPowerIncome[0]|dataNullFilter"></span>
					<span class="text-1-2x" ng-bind="statDayData.yearGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
				<span class=" norm-tip"><span ng-bind="statDayData.yearGeneratingPowerHour|dataNullFilter"></span>h</span>
			</div>
			<div class="col-sm-6 wrapper padding-media text-center norm-module-all hvr-solway">
				<span class="opa-8">累计发电量/收入</span>
				<div class=" m-t-n-xs m-b-xs"><span class="text-2-4x" ng-bind="statDayData.accumulateGeneratingPower[0]|dataNullFilter"></span>
					<span class="text-2-2x"  ng-bind="statDayData.accumulateGeneratingPower[1]|dataNullFilter">kWh</span></div>
				<div class=" m-t-n-xs">￥<span class="text-1-4x" ng-bind="statDayData.accumulateGeneratingPowerIncome[0]|dataNullFilter"></span>
					<span class="text-1-2x" ng-bind="statDayData.accumulateGeneratingPowerIncome[1]|dataNullFilter">元</span></div>
				<span class=" norm-tip"><span ng-bind="statDayData.accumulateGeneratingPowerHour|dataNullFilter"></span>h</span>
			</div>
		</div>
	</div>
	<div class="col-sm-8 p-l-sm">
		<div class="norm-black-bg">
		<span class="text-1-4x col-sm-12 no-padder m-t-xs m-l-sm">月发电量分析</span>
		<div class="col-sm-12 no-padder" id="kwhTotalMReportDiv" style="overflow: auto;">
			<div class="col-sm-12 text-center m-t-xs"id="loadFlags">
			 </div>
			<div id="kwhTotalMReportModal" style="height:180px;"></div>
		</div>
		<div class="col-sm-6 pull-right m-t-sm">
			<div class="col-sm-6 no-padder text-center">
				<i class="fa fa-circle" style="color: #ffc700"></i> <span
					class="col-9 m-r-xs">应发电量<small>(kWh)</small></span> 
			</div>
			<div class="col-sm-6 no-padder text-center">
				<i class="fa fa-circle" style="color: #ff9a00"></i> <span
					class="col-9 m-r-xs">实发电量<small>(kWh)</small></span>

				</span>
			</div>
		</div>
	</div>
	</div>
</div>
	<toaster-container toaster-options="{'position-class': 'toast-top-full-width', 'close-button':true,'time-out':5000000}">
</toaster-container>	
