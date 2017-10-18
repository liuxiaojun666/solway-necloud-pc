<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<div ng-controller="generatingEfficiencyCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">发电效率分析</span>
	</div>
	<div class="wrapper-md  row m-n">
		<!-- 筛选条件开始 -->
		<div class="col-sm-12 no-padder">
			<div class="col-sm-6 padder-r-xs">
				<div class="panel panel-info ">
					<div class="panel-heading ">
						<span class="font-h3">选择时间</span> <span class="pull-right imgdiv">
							<img alt="" src="${ctx}/theme/images/inverterMonitor/ge-time.png">
						</span> <span class="pull-right ">
							<ul class="nav nav-tabs " ng-init="time.activeTab=3">
								<li ng-class="{active: time.activeTab == 4}"><a
									href="javascript:;"
									ng-click="selectTimeType(4);time.activeTab = 4">按时段</a></li>
								<li ng-class="{active: time.activeTab == 3}"><a
									href="javascript:;"
									ng-click="selectTimeType(3);time.activeTab = 3">按月</a></li>
								<li ng-class="{active: time.activeTab == 2}"><a
									href="javascript:;"
									ng-click="selectTimeType(2);time.activeTab = 2">按季度</a></li>
								<li ng-class="{active: time.activeTab == 1}"><a
									href="javascript:;"
									ng-click="selectTimeType(1);time.activeTab = 1">按年</a></li>
							</ul>
						</span>
					</div>
					<div class="panel-body">
						<div class="tab-content tab-bordered">
							<div class="tab-panel" ng-show="time.activeTab == 4">
								<div class="col-sm-12  text-center ">
									<div class="form-group v-middle">
										<div class="col-sm-1"></div>
										<div class="col-sm-4 no-padder">
											<input type="text" id="startTime" name="startTime"
												class="form-control formData" ng-model="val" ng-change="selectStartTime();" placeholder="开始时间"/>
										</div>
										<div class="col-sm-1 no-padder" style="line-height:30px;">至</div>
										<div class="col-sm-4 no-padder">
											
											<input type="text" id="endTime" name="endTime"
												class="form-control formData" placeholder="结束时间"/>
										</div>
										<div class="col-sm-2"></div>
									</div>
								</div>
							</div>
							<div class="tab-panel" ng-show="time.activeTab == 3">
								<!-- 按照月开始 -->
								<div class="col-sm-2 no-padder text-center year b-r">
									<p>
										<a class="yearActive" ng-click="selectYear1(yearList[0]);" ><span
											ng-bind="yearList[0]">2015</span>年</a>
									</p>
									<p ng-click="selectYear1(yearList[1]);">
										<a><span ng-bind="yearList[1]">2015</span>年</a></a>
									</p>
									<p class="line-xs" ng-click="selectYear1(yearList[2]);">
										<a ><span ng-bind="yearList[2]">2015</span>年</a>
									</p>
								</div>
								<div class="col-sm-10  text-center  month" >
									<div class="col-sm-2 no-padder" ng-click="selectMonth(1);">
										<a id="month1">1月</a>
									</div>
									<!-- 										 <div ng-repeat="vo in monthList" class="col-sm-2 no-padder" ng-click="selectMonth(vo);"> -->
									<!-- 										 	<a ><span ng-bind="vo"></span>月</a> -->
									<!-- 										 </div> -->
									<div class="col-sm-2 no-padder" ng-click="selectMonth(2);" >
										<a id="month2">2月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(3);">
										<a id="month3">3月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(4);">
										<a id="month4">4月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(5);">
										<a id="month5">5月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(6);">
										<a id="month6">6月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(7);">
										<a id="month7">7月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(8);">
										<a id="month8">8月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(9);">
										<a id="month9">9月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(10);">
										<a id="month10">10月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(11);">
										<a id="month11">11月</a>
									</div>
									<div class="col-sm-2 no-padder" ng-click="selectMonth(12);">
										<a id="month12">12月</a>
									</div>
								</div>
								<!-- 按照月结束 -->
							</div>
							<div class="tab-panel" ng-show="time.activeTab == 2">
								<!-- 按照季度开始 -->
								<div class="col-sm-2 no-padder text-center year b-r">
									<p>
										<a ng-click="selectYear2(yearList[0]);"><span
											ng-bind="yearList[0]">2015</span>年</a>
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
										<a>2季度</a>
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
							<div class="tab-panel" ng-show="time.activeTab == 1">
								<!-- 按照年开始 -->
								<div class="year wrapper-sm">
									<span class="m-r-lg" ng-click="selectYear3(yearList[0]);">
										<a ><span ng-bind="yearList[0]">2015</span>年</a>
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
						<span class="font-h3 ">选择区</span> <span class="pull-right imgdiv">
							<img alt="" src="${ctx}/theme/images/inverterMonitor/ge-area.png">
						</span>
					</div>
					<div class="panel-body area">
						<div class="col-sm-2 no-padder text-center areaTitle">
							<div class="m-t-sm ">
								<a class="areaActive" ng-click="selectCompany(0);">全部</a>
							</div>
						</div>
						<div class="col-sm-10 areaDiv">
							<div ng-repeat="vo in companyList" class="col-sm-2 no-padder"
								onclick="areaClick(this)"
								ng-click="selectCompany(vo.comId);">
								<a ng-bind="vo.comShortName"></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 筛选条件结束 -->
		<!-- 数据开始 -->
		<div class="col-sm-12 panel wrapper b-b m-n">
			<div class="col-sm-4  font-h4 black-2" ng-bind="GEtitle"></div>
			<div class="col-sm-2 font-h4 black-4">
				理论发电量 <span class="m-l-sm  font-h4 black-2" ng-bind="theoryPower"></span>
			</div>
			<div class="col-sm-2 font-h4 black-4" style="color:#999999">
				实际发电量 <span class="m-l-sm  font-h4 black-2" ng-bind="actualPower"></span>
			</div>
			<div class="col-sm-4 font-h4 black-4">
				<div class="col-sm-4 no-padder " style="color:#999999">
					发电效率 <span class="m-l-sm  font-h4 black-2" ng-bind="ger | number:0"></span>%
				</div>
				<div class="col-sm-8 no-padder progress-xs  progress m-t-xs m-b-xs" style="margin-top:6px;">
					<div class="progress-bar data-bg-red" role="progressbar"
						aria-valuemin="0" aria-valuemax="100" ng-style="{width:ger + '%'}"></div>
					
				</div>

			</div>
				
			</div>
		</div>
		<!-- 数据结束 -->
		<!-- 报表开始 -->
		<div class="wrapper-md  row m-n" style="margin-top:-30px!important">
		<div class="panel col-sm-12 wrapper-md b-b">
			<div class="col-sm-6 no-padder" id="11"
				style="height: 318px; float: left;"></div>
			<div class="col-sm-6 " style="height: 318px; float: left;">
				<div class="col-sm-6 dataType" >
					<div id="companyDataType" class="col-sm-3 no-padder "
						ng-click="selectRegionType(1);">
						<a class="dataTypeActive">按区域</a>
					</div>
					<div id="stationDataType" class="col-sm-3 no-padder " ng-click="selectRegionType(2);">
						<a >按电站</a>
					</div>
				</div>
				<div class="col-sm-12 no-padder">
					<div id="12" style="height: 300px;"></div>
				</div>
			</div>
		</div>
		</div>
		<!-- 报表结束 -->
		<!-- table开始 -->
		<div class="col-sm-12 panel wrapper m-n">
		<div class="col-sm-6 no-padder">
			<table id="result_table1" class="table table-striped b-t b-light">
				<thead >
					<tr style="height: 60px;">
					<th ng-repeat="head1 in tableData1.tableHead" ng-bind="head1"></th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="vo in tableData1.tableBody">
					<td ng-repeat="da in vo track by $index" ng-bind="da"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-sm-6">
			<table id="result_table2" class="table table-striped b-t b-light">
			<thead>
				<tr style="height: 60px;">
				<th ng-repeat="head2 in tableData2.tableHead" ng-bind="head2"></th>
				</tr>
			</thead>
			<tbody>
				<tr ng-repeat="vo in tableData2.tableBody ">
				<td ng-repeat="da in vo track by $index" ng-bind="da"></td>
				</tr>
			</tbody>
		</table>
		</div>
		
	</div>
		<!-- table结束 -->
	</div>
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
	//区域选中
	var area = "全部";//区域
	$(".areaDiv div").click(function() {
		$(".areaTitle div").children().removeClass("areaActive");
		changeCheck(this, "areaActive");
	});
	
	//选中统计类型
	$(".dataType div").click(function() {
		changeCheck(this, "dataTypeActive");
	});
	
	function areaClick(obj) {
		$(".areaTitle div").children().removeClass("areaActive");
		changeCheck(obj, "areaActive");
	}
	
	$(".areaTitle div").click(function() {
		$(".areaDiv div").children().removeClass("areaActive");
		changeCheck(this, "areaActive");
	});

	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
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

	function drawMonthChart11(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('11'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
						tooltip : {
							trigger : 'axis',
							formatter : "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期','去年同期' ]

						},
						calculable : true,
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						xAxis : [ {
							type : 'category',
							data : faultDatas.data1.time,
							//axisLabel : {
								//formatter : function(value) {
									// Function formatter
									//return value
								//}
							//},
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value  + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'line',
							data : faultDatas.data1.currentGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						},
						{
							name : '去年同期',
							type : 'line',
							data : faultDatas.data1.lastYearGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#999999'
					            }
					        }
						},

						]
					};
					myChart.setOption(option);
				});
	}
	function drawMonthChart12(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('12'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {

						tooltip : {
							trigger : 'axis',
							formatter: "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期', '上期' ]
						},
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						calculable : true,
						xAxis : [ {
							type : 'category',
							data : faultDatas.data2.region
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'bar',
							data : faultDatas.data2.currentGe,
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						}, 
						{
							name : '上期',
							type : 'bar',
							data : faultDatas.data2.lastPeriodGe,
							itemStyle: {
					            normal: {
					            	color:	'#FFC400'
					            }
					        }
						},  
						{
							name : '',
							type : 'line',
							data : faultDatas.data2.avgGe,
							symbol: 'none',
							markLine : {
								itemStyle : {
		                            normal: {
		                                label:{
		                                    formatter:function(params){
		                                        return params.value + "%";
		                                    },
		                                },
		                                color:	'#ff0000',
		                                lineStyle : {
										type : 'solid',
										}
		                            }
		                         },
					             data : [
					               {type : 'average', name: '平均值'}
					             ],
					             symbol : [ 'none', 'none' ],
					        },
					        itemStyle: {
					            normal: {
					            	lineStyle:	'solid'
					            }
					        }
						},
						]
					};
					myChart.setOption(option);
				});
	}
	
	function drawMonthChart21(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('11'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
						tooltip : {
							trigger : 'axis',
							formatter : "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期','去年同期' ]

						},
						calculable : true,
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						xAxis : [ {
							type : 'category',
							data : faultDatas.data1.time,
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value  + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'line',
							data : faultDatas.data1.currentGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						},
						{
							name : '去年同期',
							type : 'line',
							data : faultDatas.data1.lastYearGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#999999'
					            }
					        }
						},

						]
					};
					myChart.setOption(option);
				});
	}
	function drawMonthChart22(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('12'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {

						tooltip : {
							trigger : 'axis',
							formatter: "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%<br/>{a2}:{c2}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期', '上期','去年同期']
						},
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						calculable : true,
						xAxis : [ {
							type : 'category',
							data : faultDatas.data2.region
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'bar',
							data : faultDatas.data2.currentGe,
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						}, 
						{
							name : '上期',
							type : 'bar',
							data : faultDatas.data2.lastPeriodGe,
							itemStyle: {
					            normal: {
					            	color:	'#FFC400'
					            }
					        }
						},  
						{
							name : '去年同期',
							type : 'bar',
							data : faultDatas.data2.lastYearGe,
							smooth : true,
							itemStyle: {
					            normal: {
					            	color:	'#999999'
					            }
					        }
						},
						{
							name : '平均值',
							type : 'line',
							data : faultDatas.data2.avgGe,
							symbol: 'none',
							markLine : {
								itemStyle : {
		                            normal: {
		                                label:{
		                                    formatter:function(params){
		                                        return params.value + "%";
		                                    },
		                                },
		                                color:	'#ff0000',
		                                lineStyle : {
										type : 'solid',
										}
		                            }
		                         },
					             data : [
					               {type : 'average', name: '平均值'}
					             ],
					             symbol : [ 'none', 'none' ],
					        },
					        itemStyle: {
					            normal: {
					            	lineStyle:	'solid'
					            }
					        }
						},
						]
					};
					myChart.setOption(option);
				});
	}
	
	function drawMonthChart31(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('11'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
						tooltip : {
							trigger : 'axis',
							formatter : "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期','去年同期' ]

						},
						calculable : true,
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						xAxis : [ {
							type : 'category',
							data : faultDatas.data1.time,
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value  + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'line',
							data : faultDatas.data1.currentGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						},
						{
							name : '去年同期',
							type : 'line',
							data : faultDatas.data1.lastYearGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#999999'
					            }
					        }
						},

						]
					};
					myChart.setOption(option);
				});
	}
	function drawMonthChart32(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('12'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {

						tooltip : {
							trigger : 'axis',
							formatter: "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%<br/>{a2}:{c2}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期', '上期','去年同期' ]
						},
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						calculable : true,
						xAxis : [ {
							type : 'category',
							data : faultDatas.data2.region
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'bar',
							data : faultDatas.data2.currentGe,
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						}, 
						{
							name : '上期',
							type : 'bar',
							data : faultDatas.data2.lastPeriodGe,
							itemStyle: {
					            normal: {
					            	color:	'#FFC400'
					            }
					        }
						},  
						{
							name : '去年同期',
							type : 'bar',
							data : faultDatas.data2.lastYearGe,
							smooth : true,
							itemStyle: {
					            normal: {
					            	color:	'#999999'
					            }
					        }
						},
						{
							name : '',
							type : 'line',
							data : faultDatas.data2.avgGe,
							symbol: 'none',
							markLine : {
								itemStyle : {
		                            normal: {
		                                label:{
		                                    formatter:function(params){
		                                        return params.value + "%";
		                                    },
		                                },
		                                color:	'#ff0000',
		                                lineStyle : {
										type : 'solid',
										}
		                            }
		                         },
					             data : [
					               {type : 'average', name: '平均值'}
					             ],
					             symbol : [ 'none', 'none' ],
					        },
					        itemStyle: {
					            normal: {
					            	lineStyle:	'solid'
					            }
					        }
						},
						]
					};
					myChart.setOption(option);
				});
	}
	
	function drawMonthChart41(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('11'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {
						tooltip : {
							trigger : 'axis',
							formatter : "{b0}<br/>{a0}:{c0}%<br/>{a1}:{c1}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期','去年同期' ]

						},
						calculable : true,
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						xAxis : [ {
							type : 'category',
							data : faultDatas.data1.time,
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value  + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'line',
							data : faultDatas.data1.currentGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						},
						{
							name : '去年同期',
							type : 'line',
							data : faultDatas.data1.lastYearGe,
							smooth : true,
							symbol : 'circle',
							itemStyle: {
					            normal: {
					            	color:	'#999999'
					            }
					        }
						},

						]
					};
					myChart.setOption(option);
				});
	}
	function drawMonthChart42(faultDatas) {
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line' ],
				function(ec) {
					var myChart = ec.init(document.getElementById('12'));
					window.addEventListener("resize", function() {
						myChart.resize();
					});
					option = {

						tooltip : {
							trigger : 'axis',
							formatter: "{b0}<br/>{a0}:{c0}%",
							backgroundColor : 'rgba(0,0,0,0.1)',
							textStyle : {
								color : '#333'
							}
						},
						legend : {
							data : [ '本期' ]
						},
						grid : {
							x : 40,
							y : 40,
							x2 : 40,
							y2 : 40
						},
						calculable : true,
						xAxis : [ {
							type : 'category',
							data : faultDatas.data2.region
						} ],
						yAxis : [ {
							type : 'value',
							axisLabel : {
								formatter : function(value) {
									return value + '%'
								}
							},
						} ],
						series : [ {
							name : '本期',
							type : 'bar',
							data : faultDatas.data2.currentGe,
							itemStyle: {
					            normal: {
					            	color:	'#ABDB7B'
					            }
					        }
						}, 
						{
							name : '',
							type : 'line',
							data : faultDatas.data2.avgGe,
							symbol: 'none',
							markLine : {
								itemStyle : {
		                            normal: {
		                                label:{
		                                    formatter:function(params){
		                                        return params.value + "%";
		                                    },
		                                },
		                                color:	'#ff0000',
		                                lineStyle : {
										type : 'solid',
										}
		                            }
		                         },
					             data : [
					               {type : 'average', name: '平均值'}
					             ],
					             symbol : [ 'none', 'none' ],
					        },
					        itemStyle: {
					            normal: {
					            	lineStyle:	'solid'
					            }
					        }
						},
						]
					};
					myChart.setOption(option);
				});
	}
	
	//map 对应{},数组对应[]
	var goPage = null;
	app
			.controller(
					'generatingEfficiencyCtrl',
					function($scope, $http, $state) {
						//默认显示页面参数
						$scope.timeType = 3;
						$scope.regionType = 1;
						$scope.year=-1;
						$scope.year1=-1;
						$scope.year2=-1;
						$scope.year3=-1;
						$scope.quarter=-1;
						$scope.month=-1;
						$scope.beginDateStr='';
						$scope.endDateStr='';
						$scope.region=0;
						$scope.regionName='';
						
						//查询当前用户下的大区
						$http(
								{
									method : "POST",
									url : "${ctx}/GeneratingEfficiencyAnalysis/getDistrictListByCustomerId.htm"
								}).success(
								function(result) {
									$scope.companyList = result;
									if ($scope.companyList == null
											|| $scope.companyList.length == 0) {
										$scope.hideCompanyDataType();
									}
									
								});
						
						
						//时间类型（4按时段，3按月，2按季度，1按年）
						$scope.selectTimeType = function(timeType) {
							$scope.timeType = timeType;
							if(timeType == 1){
								if($scope.year1 !=-1 && typeof($scope.year1)!='undefined'){
									$scope.onSelectPage(1);
								}
							}
							if(timeType == 2){
								if($scope.year2 !=-1 && typeof($scope.year2)!='undefined'
										&& $scope.quarter !=-1 && typeof($scope.quarter)!='undefined'){
									$scope.onSelectPage(1);
								}
							}
							if(timeType == 3){
								if($scope.year3 !=-1 && typeof($scope.year3)!='undefined'
										&& $scope.month !=-1 && typeof($scope.month)!='undefined'){
									$scope.onSelectPage(1);
								}
							}
							if(timeType == 4){
								if($("#startTime").val() !='' && $("#startTime").val() !='' ){
									$scope.onSelectPage(1);
								}
							}
						}
						
						$scope.selectStartTime = function() {
						}
						//按月，选择年
						$scope.selectYear1 = function(year) {
							$scope.timeType=3;
							$scope.year3 = year;
							if($scope.month==-1 || typeof($scope.month)=='undefined'){
								return;
							}
							$scope.onSelectPage(1);
						}
						//按月，选择月
						$scope.selectMonth = function(month) {
							$scope.timeType=3;
							$scope.month = month;
							if($scope.year3==-1 || typeof($scope.year3)=='undefined'){
								return;
							}
							$scope.onSelectPage(1);
						}
						//按季度，选择年
						$scope.selectYear2 = function(year) {
							$scope.timeType=2;
							$scope.year2 = year;
							if($scope.quarter==-1 || typeof($scope.quarter)=='undefined'){
								return;
							}
							$scope.onSelectPage(1);
						}
						//按季度，选择季度
						//$scope.quarter = 1;
						$scope.selectQuarter = function(quarter) {
							$scope.timeType=2;
							$scope.quarter = quarter;
							if($scope.year2==-1 || typeof($scope.year2)=='undefined'){
								return;
							}
							$scope.onSelectPage(1);
						}
						
						//按年
						$scope.selectYear3 = function(year) {
							$scope.timeType=1;
							$scope.year1 = year;
							$scope.onSelectPage(1);
						}
						
						//按任意时间
						$scope.selectTime = function(time,type) {
							
							$scope.timeType=4;
							if(type==1){
								$scope.beginDateStr=time;
								if($scope.endDateStr=='' || typeof($scope.endDateStr)=='undefined'){
									return;
								}
								$scope.onSelectPage(1);
							}
							if(type==2){
								$scope.endDateStr=time;
								if($scope.beginDateStr=='' || typeof($scope.beginDateStr)=='undefined'){
									return;
								}
								$scope.onSelectPage(1);
							}
						}
						
						//选中大区
						$scope.selectCompany = function(companyId) {
							$scope.region = companyId;
							if ($scope.companyList == null
									|| $scope.companyList.length == 0
									|| companyId == 0) {
								//$scope.hideCompanyDataType();
								//隐藏按区域和按电站按钮
								$("#companyDataType").show();
							} else {
								$("#companyDataType").children().removeClass(
								"dataTypeActive");
								$("#stationDataType").children().addClass(
								"dataTypeActive");
								$("#companyDataType").hide();
								$scope.regionType = 2;
							}
							$scope.onSelectPage(1);
						}
						//按区域维度还是电站维度统计，区域：1，电站：2
						//选中统计类型
						$scope.selectRegionType = function(regionType) {
							$scope.regionType = regionType;
							if($scope.timeType==1&&$scope.year==-1){
								return;
							}
							if($scope.timeType==2&&($scope.year==-1||$scope.quarter==-1)){
								return;
							}
							if($scope.timeType==3&&($scope.year==-1||$scope.month==-1)){
								return;
							}
							if($scope.timeType==4&&($("#startTime").val()==''||$("#endTime").val()=='')){
								return;
							}
							
							$scope.onSelectPage(2);
						}
						
						//查询方法
						goPage = $scope.onSelectPage = function(flag) {
							if($scope.timeType == 1){
								$scope.year=$scope.year1;
							}
							if($scope.timeType == 2){
								$scope.year=$scope.year2;
							}
							if($scope.timeType == 3){
								$scope.year=$scope.year3;
							}
							$http(
									{
										method : "POST",
										url : "${ctx}/GeneratingEfficiencyAnalysis/searchGeneratingEfficiencyData.htm",
										params : {
											'timeType' : $scope.timeType,
											'regionType' : $scope.regionType,
											'year' : $scope.year,
											'quarter' : $scope.quarter,
											'month' : $scope.month,
											'beginDateStr' : $("#startTime").val(),
											'endDateStr' : $("#endTime").val(),
											'regionName' : $scope.regionName,
											'region' : $scope.region
										}
									}).success(function(result) {
								if($scope.timeType == 1) {
									$scope.GEtitle=result.title;
									$scope.theoryPower=result.sumTheoryPower;
									$scope.actualPower=result.sumActualPower;
									$scope.ger=result.ge;
									$scope.tableData2 = result.tableData2;
									if(flag==1){
										$scope.tableData1 = result.tableData1;
										drawMonthChart11(result);
									}
									drawMonthChart12(result);
									
								}else if($scope.timeType == 2){
									$scope.GEtitle=result.title;
									$scope.theoryPower=result.sumTheoryPower;
									$scope.actualPower=result.sumActualPower;
									$scope.ger=result.ge;
									$scope.tableData2 = result.tableData2;
									if(flag==1){
										$scope.tableData1 = result.tableData1;
										drawMonthChart21(result);
									}
									drawMonthChart22(result);
								}else if($scope.timeType == 3){
									$scope.GEtitle=result.title;
									$scope.theoryPower=result.sumTheoryPower;
									$scope.actualPower=result.sumActualPower;
									$scope.ger=result.ge;
									$scope.tableData2 = result.tableData2;
									if(flag==1){
										$scope.tableData1 = result.tableData1;
										drawMonthChart31(result);
									}
									drawMonthChart32(result);
									
								}else if($scope.timeType == 4){
									$scope.GEtitle=result.title;
									$scope.theoryPower=result.sumTheoryPower;
									$scope.actualPower=result.sumActualPower;
									$scope.ger=result.ge;
									$scope.tableData2 = result.tableData2;
									if(flag==1){
										$scope.tableData1 = result.tableData1;
										drawMonthChart41(result);
									}
									drawMonthChart42(result);
									
								}
								
								
							});
						};
						
						//隐藏按区域统计
						$scope.hideRegionType = function() {
							$("#companyDataType").hide();
							$("#stationDataType").hide();
							if ($scope.regionType == 2) {
								$scope.regionType = 1;
								$("#companyDataType").children().removeClass(
										"dataTypeActive");
								$("#timeDataType").children().addClass(
										"dataTypeActive");
							}
						}
						
						//图形初始化
						$http(
								{
									method : "POST",
									url : "${ctx}/GeneratingEfficiencyAnalysis/getLatestYearList.htm"
								}).success(function(result) {
							$scope.yearList = result.yearList;
							//$scope.year1 = result[0];
							//$scope.year2 = result[0];
							//$scope.year3 = result[0];
							//$scope.year1=result[0];
							$scope.month=result.month;
							$scope.year3=result.year;
							$scope.year=result.year;
							var monthId="#"+"month"+$scope.month+"";
							var yearId="#"+$scope.yearList[0]+"";
							$(monthId).addClass("monthActive");
							//$scope.month2.addClass("monthActive");
							
							$scope.onSelectPage(1);
						});
						//默认显示页面
						
					});
</script>
