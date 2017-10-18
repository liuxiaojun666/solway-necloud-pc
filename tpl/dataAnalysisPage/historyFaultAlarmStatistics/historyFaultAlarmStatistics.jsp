<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<div class="wrapper-md bg-light b-b">
	<span class="font-h3 blue-1 m-n text-black">历史故障情况统计</span>
</div>
<div class="wrapper-md  row m-n" ng-controller="FaultAlarmAnalysisCtrl">
	<!-- 筛选条件开始 -->
	<div class="col-sm-12 no-padder">
		<div class="col-sm-6 padder-r-xs">
			<div class="panel panel-info ">
				<div class="panel-heading ">
					<span class="font-h1">选择时间</span> <span class="pull-right imgdiv">
						<img alt="" src="${ctx}/theme/images/inverterMonitor/run.png">
					</span> <span class="pull-right ">
						<ul class="nav nav-tabs " ng-init="time.activeTab=2">
							<li ng-class="{active: time.activeTab == 1}"><a
								href="javascript:;"
								ng-click="selectTimeType(1);time.activeTab = 1">按时段</a></li>
							<li ng-class="{active: time.activeTab == 2}"><a
								href="javascript:;"
								ng-click="selectTimeType(2);time.activeTab = 2">按月</a></li>
							<li ng-class="{active: time.activeTab == 3}"><a
								href="javascript:;"
								ng-click="selectTimeType(3);time.activeTab = 3">按季度</a></li>
							<li ng-class="{active: time.activeTab == 4}"><a
								href="javascript:;"
								ng-click="selectTimeType(4);time.activeTab = 4">按年</a></li>
						</ul>
					</span>
				</div>
				<div class="panel-body">
					<div class="tab-content tab-bordered">
						<div class="tab-panel" ng-show="time.activeTab == 1">
							<div class="col-sm-12  text-center ">
								<div class="form-group v-middle">
									<label class="col-lg-3 control-label">统计时段</label>
									<div class="col-lg-4">
										<input type="text" id="startTime" ng-model="startTime"
											class="form-control formData" ng-change="selectStartTime();" />
									</div>
									<label class="col-lg-1 control-label">-</label>
									<div class="col-lg-4">
										<input type="text" id="endTime" name="endTime"
											class="form-control formData" />
									</div>
								</div>

							</div>
						</div>
						<div class="tab-panel" ng-show="time.activeTab == 2">
							<!-- 按照月开始 -->
							<div class="col-sm-2 no-padder text-center year b-r">
								<p>
									<a class="yearActive" ng-click="selectYear1(yearList[0]);"><span
										ng-bind="yearList[0]">2015</span>年</a>
								</p>
								<p ng-click="selectYear1(yearList[1]);">
									<a><span ng-bind="yearList[1]">2015</span>年</a></a>
								</p>
								<p class="line-xs" ng-click="selectYear1(yearList[2]);">
									<a><span ng-bind="yearList[2]">2015</span>年</a>
								</p>
							</div>
							<div class="col-sm-10  text-center  month">
								<div ng-repeat="vo in monthList" onclick="monthClick(this);" class="col-sm-2 no-padder" ng-click="selectMonth(vo);">
									<a ng-class="{true:'monthActive',false:'11'}[month==vo]"><span ng-bind="vo"></span>月</a>
								</div>
							</div>
							<!-- 按照月结束 -->
						</div>
						<div class="tab-panel" ng-show="time.activeTab == 3">
							<!-- 按照季度开始 -->
							<div class="col-sm-2 no-padder text-center year b-r">
								<p ng-click="selectYear2(yearList[0]);">
									<a class="yearActive"><span ng-bind="yearList[0]">2015</span>年</a>
								</p>
								<p ng-click="selectYear2(yearList[1]);">
									<a><span ng-bind="yearList[1]">2015</span>年</a></a>
								</p>
								<p class="line-xs" ng-click="selectYear2(yearList[2]);">
									<a><span ng-bind="yearList[2]">2015</span>年</a>
								</p>
							</div>
							<div class="col-sm-10  text-center  m-t-md quarter">
								<div class="col-sm-2 no-padder " ng-click="selectQuarter(1);">
									<a>1季度</a>
								</div>
								<div class="col-sm-2 no-padder " ng-click="selectQuarter(2);">
									<a class="quarterActive">2季度</a>
								</div>
								<div class="col-sm-2 no-padder " ng-click="selectQuarter(3);">
									<a>3季度</a>
								</div>
								<div class="col-sm-2 no-padder" ng-click="selectQuarter(4);">
									<a>4季度</a>
								</div>
							</div>
							<!-- 按照季度结束 -->
						</div>
						<div class="tab-panel" ng-show="time.activeTab == 4">
							<!-- 按照年开始 -->
							<div class="year wrapper-sm">
								<span class="m-r-lg" ng-click="selectYear3(yearList[0]);">
									<a class="yearActive"><span ng-bind="yearList[0]">2015</span>年</a>
								</span> <span class="m-r-lg" ng-click="selectYear3(yearList[1]);">
									<a><span ng-bind="yearList[1]">2015</span>年</a>
								</span> <span class="m-r-lg" ng-click="selectYear3(yearList[2]);">
									<a><span ng-bind="yearList[2]">2015</span>年</a>
								</span>
							</div>
							<!-- 按照年结束 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-6 padder-l-xs">
			<div class="panel panel-success">
				<div class="panel-heading">
					<span class="font-h1 ">选择区</span> <span class="pull-right imgdiv">
						<img alt="" src="${ctx}/theme/images/inverterMonitor/run.png">
					</span>
				</div>
				<div class="panel-body area">
					<div class="col-sm-2 no-padder text-center areaTitle">
						<div class="m-t-sm " ng-click="selectCompany(-1);">
							<a class="areaActive">全部</a>
						</div>
					</div>
					<div class="col-sm-10 areaDiv">
						<div ng-repeat="vo in companyList" class="col-sm-2 no-padder"
							onclick="areaClick(this)" ng-click="selectCompany({{vo.comId}});">
							<a ng-bind="vo.comShortName"></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 筛选条件结束 -->
	<!-- 报表开始 -->
	<div class="col-sm-12 panel wrapper m-n b-b ">
		<div class="col-sm-3 no-padder">
			<div class="col-sm-12  text-center  m-t-md dataType">
				<div id="timeDataType" class="col-sm-3 no-padder "
					ng-click="selectDataType(1);">
					<a class="dataTypeActive">按时间</a>
				</div>
				<div id="companyDataType" class="col-sm-3 no-padder "
					ng-click="selectDataType(2);">
					<a>按区域</a>
				</div>
				<div class="col-sm-3 no-padder " ng-click="selectDataType(3);">
					<a>按电站</a>
				</div>
			</div>
			<div class="col-sm-9 no-padder " ng-click="selectDataType(3);">
				<a ng-bind="tableData.title"></a>
			</div>
		</div>
	</div>
	<!-- 报表结束 -->
	<!-- table开始 -->
	<div class="col-sm-12 panel wrapper m-n">
		<table id="result_table" class="table table-striped b-t b-light">
			<thead>
				<tr>
					<th class="v-middle" ng-repeat="head in tableData.tableHead1" ng-bind="head.name" colspan="{{head.col}}" rowspan="{{head.row}}"></th>
				</tr>
				<tr>
					<th ng-repeat="head in tableData.tableHead2" ng-bind="head.name"></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="vo in tableData.tableBody">
					<td ng-repeat="da in vo" ng-bind="da.data"></td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- table结束 -->
</div>
<script>
	var searchObj;
	//点击年切换
	$(".year p").click(function() {
		changeCheck(this, "yearActive");
	});
	//点击年获得值
	$(".year span").click(function() {
		changeCheck(this, "yearActive");
	});
	//选中月份
	$(".month div").click(function() {
		changeCheck(this, "monthActive");
	});
	//选中季度
	$(".quarter div").click(function() {
		changeCheck(this, "quarterActive");
	});
	//选中统计类型
	$(".dataType div").click(function() {
		changeCheck(this, "dataTypeActive");
	});
	//区域选中
	var area = "全部";//区域
	$(".areaDiv div").click(function() {
		$(".areaTitle div").children().removeClass("areaActive");
		changeCheck(this, "areaActive");
	});
	function areaClick(obj) {
		$(".areaTitle div").children().removeClass("areaActive");
		changeCheck(obj, "areaActive");
	}
	$(".areaTitle div").click(function() {
		$(".areaDiv div").children().removeClass("areaActive");
		changeCheck(this, "areaActive");
	});
	$(function() {
		$('#startTime').datetimepicker({
			format : "yyyy-mm-dd",
			minView : 2,
			language : 'zh-CN',
			autoclose : true
		});
		$('#endTime').datetimepicker({
			format : "yyyy-mm-dd",
			minView : 2,
			language : 'zh-CN',
			autoclose : true
		});
		require.config({
			paths : {
				echarts : 'vendor/echarts'
			}
		});
	});
	app
			.controller(
					'FaultAlarmAnalysisCtrl',
					function($scope, $http, $state, $stateParams) {
						$scope.timeType = 2;
						//查询最近三年
						$http(
								{
									method : "POST",
									url : "${ctx}/HistoryFaultAlarmStatistics/getLatestYearList.htm"
								}).success(function(result) {
									$scope.yearList = result.yearList;
									$scope.year1 = result.yearList[0];
									$scope.year2 = result.yearList[0];
									$scope.year3 = result.yearList[0];
									$scope.month = result.currentMonth;
									$scope.faultAlarmAnalysis();
									$scope.monthList=[1,2,3,4,5,6,7,8,9,10,11,12];
						});
						//查询当前用户下的大区
						$http(
								{
									method : "POST",
									url : "${ctx}/HistoryFaultAlarmStatistics/getDistrictListByCustomerId.htm"
								}).success(
								function(result) {
									$scope.companyList = result;
									if ($scope.companyList == null
											|| $scope.companyList.length == 0) {
										$scope.hideCompanyDataType();
									}
								});
						//时间类型（1按时段，2按月，3按季度，4按年）
						$scope.selectTimeType = function(timeType) {
							$scope.timeType = timeType;
							$scope.faultAlarmAnalysis();
						}
						//选择开始时间
						$scope.selectStartTime = function() {
							$scope.faultAlarmAnalysis();
						}
						//选择年
						$scope.selectYear1 = function(year) {
							$scope.year1 = year;
							$scope.faultAlarmAnalysis();
						}
						//选择年
						$scope.selectYear2 = function(year) {
							$scope.year2 = year;
							$scope.faultAlarmAnalysis();
						}
						//选择年
						$scope.selectYear3 = function(year) {
							$scope.year3 = year;
							$scope.faultAlarmAnalysis();
						}
						//选择月
						$scope.selectMonth = function(month) {
							$scope.month = month;
							$scope.faultAlarmAnalysis();
						}
						//选择季度
						$scope.quarter = 1;
						$scope.selectQuarter = function(quarter) {
							$scope.quarter = quarter;
							$scope.faultAlarmAnalysis();
						}
						//选中大区
						$scope.selectCompany = function(companyId) {
							$scope.companyId = companyId;
							$scope.faultAlarmAnalysis();
							if ($scope.companyList == null
									|| $scope.companyList.length == 0
									|| companyId > 0) {
								$scope.hideCompanyDataType();
							} else {
								$("#companyDataType").show();
							}
						}
						$scope.dataType = 1;
						//选中统计类型
						$scope.selectDataType = function(dataType) {
							$scope.dataType = dataType;
							$scope.faultAlarmAnalysis();
						}

						//隐藏按区域统计
						$scope.hideCompanyDataType = function() {
							$("#companyDataType").hide();
							if ($scope.dataType == 2) {
								$scope.dataType = 1;
								$("#companyDataType").children().removeClass(
										"dataTypeActive");
								$("#timeDataType").children().addClass(
										"dataTypeActive");
							}
						}
						//查询统计数据
						$scope.faultAlarmAnalysis = function() {
							$http(
									{
										method : "POST",
										url : "${ctx}/HistoryFaultAlarmStatistics/getFaultAlarmAnalysisData.htm",
										params : {
											timeType : $scope.timeType,
											startTime : $("#startTime").val(),
											endTime : $("#endTime").val(),
											year1 : $scope.year1,
											month : $scope.month,
											year2 : $scope.year2,
											quarter : $scope.quarter,
											year3 : $scope.year3,
											companyId : $scope.companyId,
											dataType : $scope.dataType
										}
									}).success(function(result) {
								$scope.tableData = result.tableData;
							});
						}
						$scope.faultAlarmAnalysis();
					});
</script>
