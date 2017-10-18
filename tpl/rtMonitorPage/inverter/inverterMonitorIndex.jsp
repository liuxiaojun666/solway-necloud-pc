<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<!-- 弹出层界面 -->
<div ng-controller="inverterMonitorCtrl" >
		<div  class="bg-light lter b-b wrapper" style="height: 70px;padding-top: 10px;padding-bottom: 10px">
		  <div style="width: 72%;height: 50px;float: left;">
		  <span style="font-size: 22px;color: #1e3e50;line-height: 50px;margin-left: 15px" ng-bind="inverterMonitorData.deviceName"></span>
		  </div>
		   <div style="width: 4%;height: 50px;float: left;">
		   <img alt="" src="${ctx}/theme/images/inverterMonitor/dayPower.png" style="margin-top: 3px">
		  </div>
		   <div style="width: 10%;height: 50px;float: left;">
		   <div>
		   <font style="font-size: 14px;color: #333333">日发电量</font>
		   <br>
		    <font style="font-size: 22px;color: #54A886" ng-bind="inverterMonitorData.dw"></font>
		    <font style="font-size: 14px;color: #333333" ng-bind="inverterMonitorData.dwUnit"></font>
		   </div>
		  </div>
		   <div style="width: 4%;height: 50px;float: left;">
		   <img alt="" src="${ctx}/theme/images/inverterMonitor/sumPower.png" style="margin-top: 3px">
		  </div>
		   <div style="width: 10%;height: 50px;float: left;">
		   <div>
		   <font style="font-size: 14px;color: #333333">总发电量</font>
		   <br>
		    <font style="font-size: 22px;color: #4488BB"  ng-bind="inverterMonitorData.tw"></font>
		    <font style="font-size: 14px;color: #333333"  ng-bind="inverterMonitorData.twUnit"></font>
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
				   <font class="font-h3 black-2" style="line-height: 25px" >当前状态</font>&nbsp;&nbsp;&nbsp;
				   <img id="invImg" alt="" src="" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px"  ng-bind="inverterMonitorData.s1"></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h3 black-2" style="line-height: 25px">设备容量</font>&nbsp;&nbsp;&nbsp;
				   <img alt="" src="${ctx}/theme/images/inverterMonitor/capacity.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px">500kW</font>&nbsp;&nbsp;&nbsp;
				   <font class="font-h4 black-1" style="line-height: 25px">已用</font>
				   <font class="font-h4 " style="color: #005BAC;line-height: 25px">68%</font>&nbsp;&nbsp;
				   </div>
				   <div style="width: 98%;height: 450px">
				   <div id="interverdcu" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="interverdcc" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="interverdcp" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div style="float: left;width: 100%;margin-top: -120px;">
				   <font class="font-h2 " style="color: #005BAC;line-height: 25px">DC</font>&nbsp;&nbsp;
				   <hr style="height:1px;border:none;border-top:1px solid #CCCCCC;" />
				   <font class="font-h2 " style="color: #005BAC;line-height: 25px">AC</font>&nbsp;&nbsp;
				   </div>
				   <div id="interveracu" style="height: 350px;width: 33.3%;float: left;margin-top: -70px;"></div>
				   <div id="interveracc" style="height: 350px;width: 33.3%;float: left;margin-top: -70px;"></div>
				   <div id="interveracp" style="height: 350px;width: 33.3%;float: left;margin-top: -70px;"></div>
				   <div style="width: 98%;margin-top: -80px;height: 50px;float: left;text-align: center;">
				   <font class="font-h2 black-2" >温度</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.t"></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >无功功率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.acq"> </font><font class="font-h2 black-1">kVar</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >效率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.ef"></font><font class="font-h2 black-1">%</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >频率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.f"></font><font class="font-h2 black-1">Hz</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >功率因数</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.pf"></font>&nbsp;&nbsp;
				   </div>
				   </div>

				</div>
				</tab> <!-- 故障发生结束 -->
				<tab> 
					<tab-heading ng-click="getHistoryData()">
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi" >历史数据</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					 </div>
					 	<div class="col-sm-12 wrapper-md b-a panel border-none" style="padding: 0px 0px 0px 0px;overflow-x:auto;">
					 	<div class="row wrapper">
					 	<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">数据时间</button>
						</span> <input style="width: 90px" type="text" ng-model="historyDataTime" id="historyDataTime"
							class="input-sm form-control">
					</div>
				</div>
				<div class="col-sm-1">
					<button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="getHistoryData();" type="button">查询</button>
				</div>
				</div>
					 	<div style="width: 100%;">
					 	<table id="result_table" class="table table-striped b-t b-light bg-table">
					<thead>
						<tr>
							<th width="80px">时间</th>
							<th >当前状态</th>
							<th >设备容量(kW)</th>
							<th >DC电压(V)</th>
							<th >DC电流(A)</th>
							<th >DC功率(kW)</th>
							<th >AC电压(V)</th>
							<th >AC电流(A)</th>
							<th >AC功率(kW)</th>
							<th >温度(C)</th>
							<th >无功功率(kW)</th>
							<th >效率(%)</th>
							<th >频率(Hz)</th>
							<th >功率因数(kW)</th>
							
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in getHistoryData">
						<td ng-bind="vo.dataTime">2015-09-18 14:20:56</td>
						<td ng-bind="vo.statusStr">运行</td>
						<td ></td>
						<td class="blue-3" ng-bind="vo.dcu">222</td>
						<td class="blue-3" ng-bind="vo.dcc">0.76</td>
						<td class="blue-3" ng-bind="vo.dcp">643</td>
						<td class="blue-3" ng-bind="vo.acu">222</td>
						<td class="blue-3" ng-bind="vo.acc">0.76</td>
						<td class="blue-3" ng-bind="vo.acp">643</td>
						<td class="blue-3" ng-bind="vo.t">23.4</td>
						<td class="blue-3" ng-bind="vo.acq">-1.12</td>
						<td class="blue-3" ng-bind="vo.ef">97.3</td>
						<td class="blue-3" ng-bind="vo.f">67</td>
						<td class="blue-3" ng-bind="vo.pf">1.00</td>
					</tbody>
				</table>
					 	</div>
					 </div>
					</tab>
					<tab> 
					<tab-heading>
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi" >事件信息</span> 
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
var inverterStatusArray=new Array("run.png","close.png","unknow.png");
	$('#happenTime').datetimepicker({
		format: "yyyy-mm-dd hh:ii",minView: 0,language: 'zh-CN',
	   	autoclose: true
	});
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
var timer1;
app.controller('inverterMonitorCtrl', function($scope, $http, $state,$stateParams) {
	$scope.devId=$stateParams.devId;
	if(!$scope.devId){
		$scope.devId=171;
	}
	$http.get("${ctx}/InverterMonitor/getInverterData.htm", {
		params : {
			id : $scope.devId
		}
	}).success(function(response) {
		$("#invImg").attr('src','${ctx}/theme/images/inverterMonitor/'+inverterStatusArray[response.statusInt]);
		$scope.inverterMonitorData = response;
		getDCU($scope.inverterMonitorData.dcu);
		getDCC($scope.inverterMonitorData.dcc);
		getDCP($scope.inverterMonitorData.dcp);
		getACU($scope.inverterMonitorData.acu);
		getACC($scope.inverterMonitorData.acc);
		getACP($scope.inverterMonitorData.acp);
		
		
		
	}).error(function(response) {
	});
	timer1 = setInterval(function(){
		$http.get("${ctx}/InverterMonitor/getInverterData.htm", {
			params : {
				id : $scope.devId
			}
		}).success(function(response) {
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.statusInt!=response.statusInt){
				$("#invImg").attr('src','${ctx}/theme/images/inverterMonitor/'+inverterStatusArray[response.statusInt]);
			}
			if($scope.inverterMonitorData.dcu!=response.dcu){
				getDCU(response.dcu);
			}
			if($scope.inverterMonitorData.dcc!=response.dcc){
				getDCC(response.dcc);
			}
			if($scope.inverterMonitorData.dcp!=response.dcp){
				getDCP(response.dcp);
			}
			if($scope.inverterMonitorData.acu!=response.acu){
				getACU(response.acu);
			}
			if($scope.inverterMonitorData.acc!=response.acc){
				getACC(response.acc);
			}
			if($scope.inverterMonitorData.acp!=response.acp){
				getACP(response.acp);
			}
			$scope.inverterMonitorData = response;
		}).error(function(response) {
		});
	}, 5000);
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(timer1);
	});
	$scope.historyData = null;
	$scope.getHistoryData = function(){
		$('#historyDataTime').datetimepicker({
			format: "yyyy-mm-dd",minView: 2,language: 'zh-CN',
		   	autoclose: true
		});
		if(!$("#historyDataTime").val()){
			$("#historyDataTime").val($scope.inverterMonitorData.today);		
		}
		$http.get("${ctx}/InverterMonitor/getHistoryData.htm", {
			params : {
				id : $scope.devId,
				dataTime : $("#historyDataTime").val()
			}
		}).success(function(response) {
			if($scope.historyData==null){
				$scope.inverterMonitorData = response;
			}
		}).error(function(response) {
		});
	}
});
	
function getDCU(dcu){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interverdcu'));
	//alert('interver'+i)
	
  	 window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
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
		            data:[{value: dcu, name: '电压'}]
		        }
		    ]
		};
	myChart.setOption(option);
});
}


function getDCC(dcc){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interverdcc'));
	//alert('interver'+i)
	
  	 window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
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
		            name:'电流',
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
		            data:[{value: dcc, name: '电流'}]
		        }
		    ]
		};
	myChart.setOption(option);
});
}

function getDCP(dcp){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interverdcp'));
	//alert('interver'+i)
	
  	 window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
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
		            name:'功率',
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
		            data:[{value: dcp, name: '功率'}]
		        }
		    ]
		};
	myChart.setOption(option);
});
}



function getACU(acu){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interveracu'));
	//alert('interver'+i)
	
  	 window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
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
		            data:[{value: acu, name: '电压'}]
		        }
		    ]
		};
	myChart.setOption(option);
});
}


function getACC(acc){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interveracc'));
	//alert('interver'+i)
	
  	 window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
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
		            name:'电流',
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
		            data:[{value: acc, name: '电流'}]
		        }
		    ]
		};
	myChart.setOption(option);
});
}

function getACP(acp){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interveracp'));
	//alert('interver'+i)
	
  	 window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
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
		            name:'功率',
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
		            data:[{value: acp, name: '功率'}]
		        }
		    ]
		};
	myChart.setOption(option);
});
}
</script>
