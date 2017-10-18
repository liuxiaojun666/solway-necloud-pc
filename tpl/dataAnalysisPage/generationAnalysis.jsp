<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"  type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">发电量分析</span>
	</div>
	<div class="wrapper-md  row m-n" ng-controller="FaultAlarmAnalysisCtrl">
		<!-- 筛选条件开始 -->
		<div class="col-sm-12 no-padder">
			<div class="col-sm-6 padder-r-xs">
					<div class="panel panel-info ">
						<div class="panel-heading ">
							<span class="font-h3" >选择时间</span><span class="pull-right imgdiv">
						<img alt="" src="${ctx}/theme/images/solway/icon/icontime@2x.png">
						
							</span>	<span class="pull-right ">
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
									<a class="yearActive"><span
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
										 	<a >1季度</a>
										 </div>
										 <div class="col-sm-2 no-padder " ng-click="selectQuarter(2);">
										 	<a class="quarterActive">2季度</a>
										 </div>
										 <div class="col-sm-2 no-padder " ng-click="selectQuarter(3);">
										 	<a >3季度</a>
										 </div>
										 <div class="col-sm-2 no-padder" ng-click="selectQuarter(4);">
										 	<a >4季度</a>
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
			<div class="col-sm-6 padder-l-xs" >
			<div class="panel panel-success">
				<div class="panel-heading">
					<span class="font-h3 " >选择区</span><span class="pull-right imgdiv">
						<img alt="" src="${ctx}/theme/images/solway/icon/iconqu@2x.png" style="margin-top:-2px">
					</span>
				</div>
				<div class="panel-body area">
				    <div class="col-sm-2 no-padder text-center areaTitle">
						<div class="m-t-sm "  ng-click="selectCompany(-1);">
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
	<div class="col-sm-12 panel wrapper b-b m-n">
		<div class="col-sm-3 no-padder">
			<div class="col-sm-12  text-center  dataType black-2 font-h4">
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
		</div>
			<div class="col-sm-2 font-h4 black-4">
				理论发电量 <span class="m-l-sm  font-h4 black-2" ng-bind="xPlanSum"></span>MWh
			</div>
			<div class="col-sm-2 font-h4 black-4" style="color:#999999">
				实际发电量 <span class="m-l-sm  font-h4 black-2" ng-bind="realitySum"></span>MWh
			</div>
			<div class="col-sm-4 font-h4 black-4">
				<div class="col-sm-4 no-padder " style="color:#999999">
					发电效率 <span class="m-l-sm  font-h4 black-2" ng-bind="twratioSum | number:0"></span>%
				</div>
				<div class="col-sm-8 no-padder progress-xs  progress m-t-xs m-b-xs" style="margin-top:6px;">
					<div class="progress-bar data-bg-red" role="progressbar"
						aria-valuemin="0" aria-valuemax="100" ng-style="{width:twratioSum + '%'}"></div>
					
				</div>

			</div>
				
	</div>

			
		
		<!-- 数据结束 -->
		<!-- 报表开始 -->
		<div class="col-sm-12 panel wrapper m-n">
			<div class="col-sm-3 no-padder" >
				<div id="chartPie" style="height: 350px;"></div>
			</div>		
				<div class="col-sm-9">
				<div id="chartbar" style="height: 350px;"></div>
			</div>
		</div>
		<!-- 报表结束 -->
		<!-- table开始 -->
		<div class="col-sm-12 panel ni-padder m-n">
			<table  class="table table-striped b-t b-light">
				<thead>
				<tr style="height: 60px;">
				<th ng-repeat="head in tableData.tableHead" ng-bind="head"></th>
				</thead>
				<tbody>
					<tr ng-repeat="vo in tableData.tableBody">
					<td ng-repeat="d in vo" ng-bind="d.data"></td>
				</tr>
				</tbody>
			</table>
		</div>
		<!-- table结束 -->
</div>
<script>
	
	var searchObj;
	//点击年切换
	$(".year p").click(function(){
		changeCheck(this,"yearActive");
	});
	//点击年获得值
	$(".year span").click(function(){
		changeCheck(this,"yearActive");
	});
	//选中月份
	$(".month div").click(function(){
		changeCheck(this,"monthActive");
	});
	function monthClick(obj) {
		changeCheck(obj, "monthActive");
	}
	//选中季度
	$(".quarter div").click(function(){
		changeCheck(this,"quarterActive");
	});
	//选中统计类型
	$(".dataType div").click(function() {
		changeCheck(this, "dataTypeActive");
	});
	//区域选中
	var area="全部";//区域
	$(".areaDiv div").click(function(){
		$(".areaTitle div").children().removeClass("areaActive");
		changeCheck(this,"areaActive");
	});
	function areaClick(obj) {
		$(".areaTitle div").children().removeClass("areaActive");
		changeCheck(obj, "areaActive");
	}
	$(".areaTitle div").click(function(){
		$(".areaDiv div").children().removeClass("areaActive");
		changeCheck(this,"areaActive");
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
	
	app.controller(
			'FaultAlarmAnalysisCtrl',
			function($scope, $http, $state, $stateParams) {
			$scope.timeType = 2;
			//时间类型（1按时段，2按月，3按季度，4按年）
			$scope.selectTimeType = function(timeType) {
				$scope.timeType = timeType;
				$scope.faultAlarmAnalysis();
			}
					//查询最近三年
						$http(
								{
									method : "POST",
									url : "${ctx}/FaultAlarmAnalysis/getLatestYearList.htm"
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
									url : "${ctx}/FaultAlarmAnalysis/getDistrictListByCustomerId.htm"
								}).success(
								function(result) {
									$scope.companyList = result;
									if ($scope.companyList == null
											|| $scope.companyList.length == 0) {
										$scope.hideCompanyDataType();
									}
								});
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
						url : "${ctx}/GenerationAnalysis/getFaultAlarmAnalysis.htm",
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
// 						alert(JSON.stringify(result))
						$scope.tableData = result.tableData; 	
						$scope.pigData = result.piData.pigData; 
// 						$scope.twratio = result.barData.twratio;         //发电效率
						$scope.xPlan = result.barData.xPlan;             //计划发电量 
						$scope.xReality = result.barData.xReality;       //实际发电量
						$scope.xLstYear = result.barData.xLstYear;       //去年同期	
						$scope.xPercentage = result.barData.xPercentage; //计划达成率	
						$scope.yTime = result.barData.yTime;             //时间
						powerPie($scope.pigData)
						$scope.realitySum=0;
						$scope.xPlanSum=0;
						$scope.twratioSum=0;
						if($scope.xReality){
							$scope.realitySum=sum($scope.xReality);	
						}
						if($scope.xPlan){
							$scope.xPlanSum=sum($scope.xPlan);	
						}
						if($scope.twratio){
							$scope.twratioSum=sum($scope.twratio);
						}
						if($scope.xPlanSum && $scope.realitySum){
							$scope.twratioSum=$scope.realitySum/$scope.xPlanSum*100
						}
						powerBar($scope.xPlan,$scope.xReality,
						$scope.xLstYear,$scope.xPercentage,$scope.yTime);
			});
		};
	
	});	
function sum(parame){
	var sum=0;
	for (var i=0;i<parame.length;i++){
	sum =sum+parame[i]
	}
	return sum;
}
	
function powerPie(param){		
	// 路径配置
    require.config({
        paths: {
        	echarts : 'vendor/echarts'
        }
    });
    
    // 使用
    require(
        [ 'echarts', 'echarts/chart/pie'],// 使用柱状图就加载pie模块，按需加载
       
        function (ec) {
            // 基于准备好的dom，初始化echarts图表
        var myChart = ec.init(document.getElementById('chartPie')); 
  		var option = {
  				title: {
  			        text: '占比分析',
  			        sublink: 'http://e.weibo.com/1341556070/AhQXtjbqh',
  			        x: 'center',
  			        y: 'center',
  			        itemGap: 20,
  			        textStyle : {
  			            color : '#999',
  			            fontFamily : '微软雅黑',
  			            fontSize : 22
  			         
  			        }
  			    },
  			    series : [
  			        {
  			            name:'访问来源',
  			            type:'pie',
  			            radius : ['40%', '75%'],
  			            itemStyle : {
  			                normal : {
  			                    label : {
  			                    	position : 'inner'
  			                    },
  			                    labelLine : {
  			                        show : false
  			                    }
  			                },
  			                emphasis : {
  			                    label : {
  			                        show : true,
  			                        position : 'right',
  			                        textStyle : {
  			                            fontSize : '30'
  			                        }
  			                    }
  			                }
  			            },
  			            data:param
  			        }
  			    ]
  			};
  		myChart.setOption(option);
    }
    );  
}
    
function powerBar(xPlan,xReality,xLstYear,xPercentage,yTime){
    require.config({
        paths: {
        	echarts : 'vendor/echarts'
        }
    });
   
    // 使用
    require(
        [
            'echarts',
            'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
            'echarts/chart/line'
            ],
        function (ec) {
            // 基于准备好的dom，初始化echarts图表
            var myChart = ec.init(document.getElementById('chartbar')); 
            	myChart.on('click',function(param){
            		showPowerChart(param.name);
            	});
            	option = {
            		    title : {
            		        text: '2015年各大区发电量分析',
            		    },
            		    tooltip : {
            		        trigger: 'axis'
            		    },
            		    legend: {
            		    	x : 'right',
            		        data:[
								     '实际发电量','计划发电量',
            		                 '去年同期','计划达成率'
            		        ]
            		    },
            		    calculable : true,
            		    grid: {y: 70, 
	            		    	y2:30, 
	            		    	x2:20,
	            		    	borderWidth:0
            		    	},
            		    xAxis : [{
            		    		axisLine:{
	            		        	lineStyle:{
	            		        		color:"#eee",
	            		        		width:1 
	            		        	}
            		        },
            		            type : 'category',
            		          	splitLine : {
            							show : false
            						},
            		            data : yTime
            		        },
            		        {
            		            type : 'category',
            		            axisLine: {show:false},
            		            axisTick: {show:false},
            		            axisLabel: {show:false},
            		            splitArea: {show:false},
            		            splitLine: {show:false},
            		            data : yTime
            		        }
            		    ],
            		    yAxis : [
            		        {
                		    		axisLine:{
    	            		        	lineStyle:{
    	            		        		color:"#eee",
    	            		        		width:1 
    	            		        	}
                		        },
            		            type : 'value',
            		          	splitLine : {
            							show : false
            						},
            		            axisLabel:{formatter:'{value} MWh'}
            		        }
            		    ],
            		    series : [

            		        {
            		            name:'实际发电量',
            		            type:'bar',
            		          	barWidth : 15,
            		            itemStyle: {normal: {color:'rgba(181,195,52,1)', label:{show:false,textStyle:{color:'#27727B'}}}},
            		            data:xReality,
            		        },
            		        {
            		            name:'去年同期',
            		            type:'bar',
            		          	barWidth : 15,
            		            itemStyle: {normal: {color:'rgba(252,206,16,1)', label:{show:false,textStyle:{color:'#E87C25'}}}},
            		            data:xLstYear,
            		        },
            		    
            		        {
            		            name:'计划发电量',
            		            type:'bar',
            		          	barWidth : 15,
            		            xAxisIndex:1,
            		            itemStyle: {normal: {color:'rgba(181,195,52,0.5)', label:{show:false}}},
            		            data:xPlan,
            		 
            		        },
            		      
            		        {
            		            name:'ECharts1 - 20w数据',
            		            type:'bar',
            		            xAxisIndex:1,
            		            itemStyle: {normal: {color:'rgba(252,206,16,0.5)', label:{show:false,formatter:function(p){return p.value > 0 ? (p.value +'+'):'';}}}},
            		            data:[0,0]
            		        },
            		        {
           		        	   name:'计划达成率',
           		               type:'line',
           		               yAxisIndex: 0,
           		               data:xPercentage
            			} 
            		  
            		        ]};
        		myChart.setOption(option);
            }
		 );
}  
	</script>
