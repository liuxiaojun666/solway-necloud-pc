<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<div ng-controller="JunctionBoxMonitorCtrl">
<div>
		<div class="bg-light lter b-b wrapper" style="height: 70px;padding-top: 10px;padding-bottom: 10px">
		  <div style="width: 72%;height: 50px;float: left;">
		  <span style="font-size: 22px;color: #1e3e50;line-height: 50px;margin-left: 15px" ng-bind="junctionBoxMonitorData.deviceName"></span>
		  </div>
		  </div>
		</div>
		
		<div class="wrapper-lg   no-border-xs">
				<tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
				<!-- 故障发生开始 --> 
				<tab> 
				<tab-heading> 
				<span class="wrapper-sm white-1 a-cur-poi"> 设备信息 </span>
					 </tab-heading>
					 <div class="col-sm-6 text-center m-t">
					 </div>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				   <div style="width: 98%;margin: 0 auto;height: 25px;line-height: 25px">
				   <font class="font-h3 black-2" style="line-height: 25px">开关状态</font>&nbsp;&nbsp;&nbsp;
				   <img id="jbStatusImg" alt="" src="${ctx}/theme/images/junctionBoxMonitor/run.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px" ng-bind="junctionBoxMonitorData.kStr">开启</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h3 black-2" style="line-height: 25px">防雷器状态</font>&nbsp;&nbsp;&nbsp;
				   <img id="arresterStatusImg" alt="" src="${ctx}/theme/images/junctionBoxMonitor/blzOpen.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="junctionBoxMonitorData.arresterStr"></span></font>&nbsp;&nbsp;&nbsp;
				   </div>
				   <div style="width: 98%;margin: 0 auto;height: 350px;">
				   <div id="junctionBox1" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="junctionBox2" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="junctionBox3" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div style="width: 100%;height: 300px;float: left;margin-top: -100px">
				   <font class="font-h3 black-2" >&nbsp;光伏组串电流</font>
				   <br>
				   <br>
				   <div ng-repeat="vo in junctionBoxMonitorData.cList" style="width: 16%;height: 30px;margin:0px 2% 40px 2% ;text-align: center;float: left;">
				   <div style="width: 30px;background-color: #1C2B36;float: left;">
				   <font class="font-h3 white-1" style="line-height: 30px;"><span ng-bind="$index+1"></span></font>
				   </div>
				   <div style="width: 132px;float: left;border-bottom:1px solid #ccc;">
				   <font class="font-big blue-3" style="line-height: 30px;" ><span ng-bind="vo.c"></span></font>
				   </div>
				   </div>
				   </div>
				   </div>
				   

				</div>
				</tab> <!-- 故障发生结束 -->
				<tab> 
					<tab-heading ng-click="getHistoryData()">
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi" id="repairTabTitle">历史数据</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					 </div>
					 <div class="col-sm-12 wrapper-md b-a panel border-none" style="padding: 0px 0px 0px 0px;overflow-x:auto;">
					 	<div style="width: 140%;">
					 	<table id="result_table" class="table table-striped b-t b-light bg-table">
					<thead>
						<tr>
							<th width="80px">时间</th>
							<th width="80px">开关状态</th>
							<th width="120px">防雷器状态</th>
							<th width="80px">电压(V)</th>
							<th width="80px">电流(A)</th>
							<th width="80px">功率(kW)</th>
							<%for(int i=1;i<=20;i++){ %>
							<th><%=i %></th>
							<%} %>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in getHistoryData">
						<td  ng-bind="vo.dataTime">2015-09-18 14:20:56</td>
						<td ng-bind="vo.kStr">开启</td>
						<td ng-bind="vo.arresterStr">正常</td>
						<td ng-bind="vo.u">22</td>
						<td ng-bind="vo.c">0.56</td>
						<td ng-bind="vo.p">746</td>
						<td class="blue-3" ng-bind="vo.c1">
						<td class="blue-3" ng-bind="vo.c2">
						<td class="blue-3" ng-bind="vo.c3">
						<td class="blue-3" ng-bind="vo.c4">
						<td class="blue-3" ng-bind="vo.c5">
						<td class="blue-3" ng-bind="vo.c6">
						<td class="blue-3" ng-bind="vo.c7">
						<td class="blue-3" ng-bind="vo.c8">
						<td class="blue-3" ng-bind="vo.c9">
						<td class="blue-3" ng-bind="vo.c10">
						<td class="blue-3" ng-bind="vo.c11">
						<td class="blue-3" ng-bind="vo.c12">
						<td class="blue-3" ng-bind="vo.c13">
						<td class="blue-3" ng-bind="vo.c14">
						<td class="blue-3" ng-bind="vo.c15">
						<td class="blue-3" ng-bind="vo.c16">
						<td class="blue-3" ng-bind="vo.c17">
						<td class="blue-3" ng-bind="vo.c18">
						<td class="blue-3" ng-bind="vo.c19">
						<td class="blue-3" ng-bind="vo.c20">
						</tr>
					</tbody>
				</table>
					 	</div>
					 </div>
					</tab>
					<tab> 
					<tab-heading>
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi" id="repairTabTitle">事件信息</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					 </div>
					  <div class="col-sm-12 wrapper-md b-a panel border-none" style="padding: 0px 0px 0px 0px;overflow-x:auto;height: 60px">
					  <div style="width: 20%;height: 60;float: left;border-width: 0px">
					  	<div style="width: 60px;height: 60px;background-color: #4596CE;text-align: center;float: left;">
					    	<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/Tools.png" style="margin-top: 10px">
					    </div>
					    <div style="float: left;height: 60px;width: 71%;padding: 10px">
					    <font class="blue-2 font-h4">安装时间</font>
					    <br>
					    <font class="font-h4" style="color: #4596CE">2015-09-20 10:23:59</font>
					    </div>
					  </div>
					  <div style="width: 20%;height: 60;float: left;">
					  	<div style="width: 60px;height: 60px;background-color: #BB78BD;text-align: center;float: left;">
					    	<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/Speedometer.png" style="margin-top: 9px">
					    </div>
					    <div style="float: left;height: 60px;width: 70%;padding: 10px">
					    <font class="blue-2 font-h4">运行时间</font>
					    <br>
					    <font class="font-h4" style="color: #BB78BD">23467h</font>
					    </div>
					  </div>
					  <div style="width: 20%;height: 60;float: left;">
					  	<div style="width: 60px;height: 60px;background-color: #42B4BF;text-align: center;float: left;">
					    	<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/Clock.png" style="margin-top: 9px">
					    </div>
					    <div style="float: left;height: 60px;width: 70%;padding: 10px">
					    <font class="blue-2 font-h4">累计工作时间</font>
					    <br>
					    <font class="font-h4" style="color: #42B4BF">23314h</font>
					    </div>
					  </div>
					  <div style="width: 20%;height: 60;float: left;">
					  	<div style="width: 60px;height: 60px;background-color: #4DAD92;text-align: center;float: left;">
					    	<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/Timer.png" style="margin-top: 9px">
					    </div>
					    <div style="float: left;height: 60px;width: 70%;padding: 10px">
					    <font class="blue-2 font-h4">正常工作时间</font>
					    <br>
					    <font class="font-h4" style="color: #4DAD92">23131h</font>
					    </div>
					  </div>
					  <div style="width: 20%;height: 60;float: left;">
					  	<div style="width: 60px;height: 60px;background-color: #D98082;text-align: center;float: left;">
					    	<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/Hourglass.png" style="margin-top: 9px">
					    </div>
					    <div style="float: left;height: 60px;width: 70%;padding: 10px">
					    <font class="blue-2 font-h4">故障时间</font>
					    <br>
					    <font class="font-h4" style="color: #D98082">5423h</font>
					    </div>
					  </div>
					  </div>
					  <div class="col-sm-12 wrapper-md b-a panel border-none" style="padding: 0px 0px 0px 0px;overflow-x:auto;">
					  	<div class="m-b-lg m-bg-re white-1 font-h4" style="float: left;margin: 15px;background-color: #2AB2EE">
					  	2015-09-20
					  	</div>
					  	<div style="float: right;">
					  	<div style="margin: 15px;height: 34px;float: left;">
					  		<font class="black-1 font-h4" style="line-height: 34px">事件时间</font>
					  	</div>
					  	<div style="margin: 15px;height: 34px;float: left;width: 200px">
					  		 <input type="text" id="happenTime" name="happenTime" class="form-control formData" />
					  	</div>
					  	</div>
					  	<br>
						<div class="padder" style="margin-top: 50px">
						<div class="streamline b-l b-info m-l-xl m-b padder-v">
					        <div >
          						<a class="pull-left avatar m-l-n-sm">
            				    <img src="${ctx}/theme/images/junctionBoxMonitor/circlesmall.png"  alt="..." style="text-align: center;">
          						</a>
          					<div class="m-l-lg">
          					    <div class="m-b-xs">
              					<a href class="h5 blue-4">2015-09-20</a>
            					</div>
            					<div class="m-b-lg m-bg-re white-1 font-h4">
              					<div>直流正负极接反</div>
            					</div>
          					</div>
        					</div>
        						<div >
          						<a class="pull-left avatar m-l-n-sm">
            				    <img src="${ctx}/theme/images/junctionBoxMonitor/circlesmall.png"  alt="...">
          						</a>
          					<div class="m-l-lg">
          					    <div class="m-b-xs">
              					<a href class="h5 blue-4">2015-09-19</a>
            					</div>
            					<div class="m-b-lg m-bg-re white-1 font-h4">
              					<div>直流正负极接反</div>
            					</div>
          					</div>
        					</div>
        						<div >
          						<a class="pull-left avatar m-l-n-sm">
            				    <img src="${ctx}/theme/images/junctionBoxMonitor/circlesmall.png"  alt="...">
          						</a>
          					<div class="m-l-lg">
          					    <div class="m-b-xs">
              					<a href class="h5 blue-4">2015-09-18</a>
            					</div>
            					<div class="m-b-lg m-bg-re white-1 font-h4">
              					<div>直流正负极接反</div>
            					</div>
          					</div>
        					</div>
        						<div >
          						<a class="pull-left avatar m-l-n-sm">
            				    <img src="${ctx}/theme/images/junctionBoxMonitor/circlesmall.png"  alt="...">
          						</a>
          					<div class="m-l-lg">
          					    <div class="m-b-xs">
              					<a href class="h5 blue-4">2015-09-17</a>
            					</div>
            					<div class="m-b-lg m-bg-re white-1 font-h4">
              					<div>直流正负极接反</div>
            					</div>
          					</div>
        					</div>
					</div>
					</div>					  
					</div>
					</tab>
					</tabset>
			</div>

</div>
<script type="text/javascript">
//定义各种状态的对应图片
var jbStatusArray=new Array("run.png","close.png","unknow.png");
var arresterStatusArray=new Array("blzRun.png","blzFault.png","blzUnknow.png");
$(function() {
	$('#happenTime').datetimepicker({
		format: "yyyy-mm-dd",minView: 0,language: 'zh-CN',
	   	autoclose: true
	});
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
});
var timer1;
app.controller('JunctionBoxMonitorCtrl', function($scope, $http, $state,$stateParams) {
	$scope.devId=$stateParams.devId;
	showGoBackFlag();
	refreshdata($scope, $http);
	timer1=setInterval(function(){
		refreshdata($scope, $http);
	},5000);
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(timer1);
		hideGoBackFlag();
	});
	$scope.historyData = null;
	$scope.getHistoryData = function(){
		$http.get("${ctx}/JunctionBox/getHistoryData.htm", {
			params : {
				id : $scope.devId
			}
		}).success(function(response) {
			if($scope.historyData==null){
				$scope.inverterMonitorData = response;
			}
		}).error(function(response) {
		});
	}
});
function refreshdata($scope, $http){
	$http.get("${ctx}/JunctionBox/getJunctionBoxData.htm", {
		params : {
			id : $scope.devId
		}
	}).success(function(response) {
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.jbStatus!=response.jbStatus){
			$("#jbStatusImg").attr('src','${ctx}/theme/images/junctionBoxMonitor/'+jbStatusArray[response.jbStatus]);
		}
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.blzStatus!=response.blzStatus){
			$("#arresterStatusImg").attr('src','${ctx}/theme/images/junctionBoxMonitor/'+arresterStatusArray[response.arresterStatus]);
		}
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.u!=response.u){
			getScore(1,response.u,'电压');
		}
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.c!=response.c){
			getScore(2,response.c,'电流');
		}
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.p!=response.p){
			getScore(3,response.p,'功率');
		}
		$scope.junctionBoxMonitorData = response;
	}).error(function(response) {
	});
}
function getScore(j,dataValue,dataName){
	var myChart;
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
	myChart = ec.init(document.getElementById('junctionBox'+j));
		//alert('junctionBox'+j)
	
  	/*  window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	}); */
	option = {
		    tooltip : {
		        formatter: "{a} <br/>{b} : {c}%"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'电压',
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dataValue, name: dataName}]
		        }
		    ]
		};
    myChart.setOption(option,true);
	window.onresize = myChart.resize;
});
}
</script>
