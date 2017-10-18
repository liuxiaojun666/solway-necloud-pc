<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/checkSelected.js" type="text/javascript"></script>
<!-- <script src="http://apps.bdimg.com/libs/angular.js/1.3.9/angular.min.js"></script> -->
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript">
$(function() {
	$('#happenTime').datetimepicker({
		format: "yyyy-mm-dd hh:ii",minView: 0,language: 'zh-CN',
	   	autoclose: true
	});
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
for(var j = 1;j <=6 ;j++){
getScore(j);
}
});
function openDetail(){
	if($("#detail").css("display")=='none'){
	$("#detail").show();
	$("#mainDetail").height(190);
	}else{
		$("#detail").hide();
		$("#mainDetail").height(110);
	}
}
function getScore(i){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interver'+i));
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
		            data:[{value: 50, name: '电压'}]
		        }
		    ]
		};
	clearInterval(timeTicket);
	var timeTicket = setInterval(function (){
	    option.series[0].data[0].value = (Math.random()*100).toFixed(2) - 0;
	    myChart.setOption(option,true);
	},5000);
	myChart.setOption(option);
});
}
</script>
<!-- 弹出层界面 -->
<div >
		<div class="bg-light lter b-b wrapper" style="height: 70px;padding-top: 10px;padding-bottom: 10px">
		  <div style="width: 72%;height: 50px;float: left;">
		  <span style="font-size: 22px;color: #1e3e50;line-height: 50px;margin-left: 15px">逆变器设备</span>
		  </div>
		   <div style="width: 4%;height: 50px;float: left;">
		   <img alt="" src="${ctx}/theme/images/inverterMonitor/dayPower.png" style="margin-top: 3px">
		  </div>
		   <div style="width: 10%;height: 50px;float: left;">
		   <div>
		   <font style="font-size: 14px;color: #333333">日发电量</font>
		   <br>
		    <font style="font-size: 22px;color: #54A886">5123</font>
		    <font style="font-size: 14px;color: #333333">MWh</font>
		   </div>
		  </div>
		   <div style="width: 4%;height: 50px;float: left;">
		   <img alt="" src="${ctx}/theme/images/inverterMonitor/sumPower.png" style="margin-top: 3px">
		  </div>
		   <div style="width: 10%;height: 50px;float: left;">
		   <div>
		   <font style="font-size: 14px;color: #333333">总发电量</font>
		   <br>
		    <font style="font-size: 22px;color: #4488BB">3423</font>
		    <font style="font-size: 14px;color: #333333">GWh</font>
		   </div>
		  </div>
		</div>
		<br>
		<div id="mainDetail" class="no-border-xs panel" style="margin: 0px 30px;height: 110px">
		<div style="padding: 15px;height: 50px;font-size: 14px">
		<font>所属箱变</font>&nbsp;
		<font>1箱变</font>&nbsp;&nbsp;&nbsp;&nbsp;
		<font>位置</font>&nbsp;
		<font>10小室</font>&nbsp;&nbsp;&nbsp;&nbsp;
		<font>逆变器组</font>&nbsp;
		<font>1小组</font>&nbsp;&nbsp;&nbsp;&nbsp;
		<font>设备厂商</font>&nbsp;
		<font>康佳运营商</font>&nbsp;&nbsp;&nbsp;&nbsp;
		<font>产品型号</font>&nbsp;
		<font>SKDSU1280</font>
		<a style="float: right;" class="accordion-toggle"  onclick="openDetail()">
		查看更多信息
		<i class="pull-right fa ng-scope fa-angle-down" ng-class="{'fa-angle-down': status.open, 'fa-angle-right': !status.open}"></i>
		</a>
		</div>
		<hr style="margin: 0px">
		<div id="detail" style="padding: 15px;height: 80px;font-size: 14px;display: none;">
		<table>
		<tr style="height: 25px">
		<td>
		主要参数
		</td>
		<td>
		</td>
		</tr>
		<tr style="height: 25px">
		<td>
		检修工艺卡
		</td>
		<td>
		</td>
		</tr>
		</table>
		</div>
		<div class="col-sm-12 wrapper-md b-a panel border-none" style="padding: 0px 0px 0px 0px;height: 60px">
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
		</div>
		<div class="wrapper-lg   no-border-xs">
				<tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
				<!-- 故障发生开始 --> 
				<tab> 
				<tab-heading> 
				<span class="text-md wrapper-sm"> 设备信息 </span>
					 </tab-heading>
					 <div class="col-sm-6 text-center m-t">
					 </div>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				   <div style="width: 98%;margin: 0 auto;height: 25px;line-height: 25px">
				   <font class="font-h3 black-2" style="line-height: 25px">当前状态</font>&nbsp;&nbsp;&nbsp;
				   <img alt="" src="${ctx}/theme/images/inverterMonitor/run.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px">运行</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h3 black-2" style="line-height: 25px">设备容量</font>&nbsp;&nbsp;&nbsp;
				   <img alt="" src="${ctx}/theme/images/inverterMonitor/capacity.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px">500kW</font>&nbsp;&nbsp;&nbsp;
				   <font class="font-h4 black-1" style="line-height: 25px">已用</font>
				   <font class="font-h4 " style="color: #005BAC;line-height: 25px">68%</font>&nbsp;&nbsp;
				   </div>
				   <div style="width: 98%;height: 450px">
				   <div id="interver1" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="interver2" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="interver3" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div style="float: left;width: 100%;margin-top: -120px;">
				   <font class="font-h2 " style="color: #005BAC;line-height: 25px">DC</font>&nbsp;&nbsp;
				   <hr style="height:1px;border:none;border-top:1px solid #CCCCCC;" />
				   <font class="font-h2 " style="color: #005BAC;line-height: 25px">AC</font>&nbsp;&nbsp;
				   </div>
				   <div id="interver4" style="height: 350px;width: 33.3%;float: left;margin-top: -70px;"></div>
				   <div id="interver5" style="height: 350px;width: 33.3%;float: left;margin-top: -70px;"></div>
				   <div id="interver6" style="height: 350px;width: 33.3%;float: left;margin-top: -70px;"></div>
				   <div style="width: 98%;margin-top: -80px;height: 50px;float: left;text-align: center;">
				   <font class="font-h2 black-2" >温度</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" >23.6</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >无功功率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" >-1.12kVar</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >效率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" >97.34%</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >频率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" >50.50Hz</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >功率因数</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" >1.00</font>&nbsp;&nbsp;
				   </div>
				   </div>

				</div>
				</tab> <!-- 故障发生结束 -->
				<tab> 
					<tab-heading>
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi " id="repairTabTitle">故障信息</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					 </div>
					 <div class="col-sm-12 wrapper-md b-a panel border-none" style="padding: 0px 0px 0px 0px;overflow-x:auto;">
					 	<div style="width: 100%;">
					 	<table id="result_table" class="table table-striped b-t b-light bg-table">
					<thead>
						<tr>
							<th width="150px">时间</th>
							<th >故障描述</th>
							<th >故障诊断</th>
							<th >故障处理</th>
							<th >结果</th>
						</tr>
					</thead>
					<tbody>
						<%for(int j=1;j<=10;j++){ %>
						<tr>
						<td >2015-09-18 14:20:56</td>
						<td >温度过高</td>
						<td >
						小王 2015-09-18 14:20:56
						<br>
						故障诊断故障诊断故障诊断故障诊断故障诊断故障诊断
						</td>
						<td class="blue-3">
						小王 2015-09-18 14:20:56
						<br>
						故障处理故障处理故障处理故障处理故障处理故障处理
						</td>
						<td class="blue-3">已完成</td>
						<%} %>
					</tbody>
				</table>
					 	</div>
					 </div>
					</tab>
					<tab> 
					<tab-heading>
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi " id="repairTabTitle">检修维护</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					</div>
					</tab>
					<tab> 
					<tab-heading>
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi " id="repairTabTitle">技术监督</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					</div>
					</tab>
					<tab> 
					<tab-heading>
						<span class="pull-left"></span><span class="wrapper-sm white-1 a-cur-poi " id="repairTabTitle">技术改造</span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t">
					</div>
					</tab>
					</tabset>
			</div>

</div>
