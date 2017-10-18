<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-sm-6 text-center m-t">
</div>
<div class="col-sm-12 wrapper-md b-a border-none">

	<div id="response_respStatus2" class="alert alert-danger" role="alert" style="display:none;">未接收到任何数据。请等待...</div>
	<div id="response_respStatusnull2" style="display: none;"
	class="alert alert-danger" role="alert">返回数据异常！</div>
	<div id="comm_interruptDev2" 	class="alert alert-danger" role="alert" style="display:none;" >
		通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于<span
			ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
	</div>
	<div id="comm_initDev2"  class="alert alert-info" role="alert" style="display:none;">设备初始化，未接收到任何数据。请等待...</div>
	<div class="text-right">
	    <font class="font16 word-grey" style="line-height: 25px"><span  ng-bind="millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></font>
	</div>
    <div class="w_a_line_h clearfix font16" style="margin: 5px auto;">
   		<div class="pull-left per5-1">
   			<font class=" word-grey line_height_25">状态：</font>
	   		<font class=" black-1 line_height_25" ng-bind="inverterMonitorData.statusDesc"></font>&nbsp;&nbsp;&nbsp;
   		</div>
   		<div class="pull-left per5-1">
   			<font class=" word-grey line_height_25" >容量：</font>
	   		<font class=" black-1 line_height_25"><span ng-bind="buildcapacity|number:1"></span>kW</font>&nbsp;&nbsp;&nbsp;
   		</div>
   		<div class="pull-left" style="width:18%;">
   			<font class=" word-grey line_height_25" >出力：</font>
	   		<font class="c_line_height " id="used1" style="color:#333;">0%</font>&nbsp;&nbsp;
   		</div>
   		<div class="pull-left " style="width:22%">
   			<font class=" word-grey line_height_25 m-l-xs">总发电量：</font>
       		<font ng-bind="tw" class=" black-1 line_height_25"></font>
       		<font ng-bind="twUnit" class=" black-1 line_height_25"></font>
   		</div>
   		<div class="pull-left per5-1">
   			<font class=" word-grey line_height_25 m-l-xs" >日发电量：</font>
	    	<font ng-bind="dw" class=" black-1 line_height_25"></font>
	    	<font ng-bind="dwUnit" class="black-1 line_height_25"></font>
   		</div>
   </div>
   <div class="w_a_line_h clearfix font16"  style="margin: 10px auto 30px;">
   		<div class="pull-left per5-1">
   			<font class=" word-grey line_height_25">温度：</font>
	   		<font class=" black-1 line_height_25" ng-bind="inverterMonitorData.t|number:1"></font><font class="font-h3 black-1">℃</font>
   		</div>
   		<div class="pull-left per5-1">
   			<font class=" word-grey line_height_25" >无功功率：</font>
	   		<font class=" black-1 line_height_25"><span ng-bind="inverterMonitorData.acq|number:1"></span>kVar</font>
   		</div>
   		<div class="pull-left" style="width:18%;">
   			<font class=" word-grey line_height_25" >效率：</font>
	   		<font class="c_line_height "><span ng-bind="inverterMonitorData.ef *100|number:0"></span>%</font>
   		</div>
   		<div class="pull-left " style="width:22%">
   			<font class=" word-grey line_height_25 m-l-xs">频率：</font>
       		<font class=" black-1 line_height_25"><span ng-bind="inverterMonitorData.f|number:2"></span>Hz</font>
   		</div>
   		<div class="pull-left per5-1">
   			<font class=" word-grey line_height_25 m-l-xs" >功率因数：</font>
	    	<font ng-bind="inverterMonitorData.pf|number:2" class=" black-1 line_height_25"></font>
   		</div>
   </div>
   <div class="col-sm-12 no-padder clearfix">
	   <div class="col-sm-4 no-padder" id="interveracuStr" style="height: 200px;width:260px;"></div>
	   <div class="col-sm-4 no-padder" id="interveraccStr" style="height: 200px;width:260px;"></div>
	   <div class="col-sm-4 no-padder" id="interveracpStr" style="height: 200px;width:260px;"></div>
   </div>
   <div class="w_a_line_h col-sm-12 clearfix">
	   <div class="col-sm-4 text-center"><span class="blue-square black-1 font18">DC电压: <font ng-bind="inverterMonitorData.dcu|number:1"></font>(V)</span></div>
	   <div class="col-sm-4 text-center"><span class="blue-square black-1 font18">DC电流: <font ng-bind="inverterMonitorData.dcc|number:1"></font>(A)</span></div>
	   <div class="col-sm-4 text-center"><span class="blue-square black-1 font18">DC功率: <font ng-bind="inverterMonitorData.dcp|number:1"></font>(kW)</span></div>
   </div>
	<!-- <div class="w_a_line_h col-sm-12 clearfix">
	   <div class="col-sm-4 text-center"><span class="blue-square black-1 font18">电压: <font ng-bind="junctionBoxMonitorData.u|number:1"></font>(V)</span></div>
	   <div class="col-sm-4 text-center"><span class="blue-square black-1 font18">电流: <font ng-bind="junctionBoxMonitorData.c|number:1"></font>(A)</span></div>
	   <div class="col-sm-4 text-center"><span class="blue-square black-1 font18">功率: <font ng-bind="junctionBoxMonitorData.p|number:1"></font>(kW)</span></div>
   </div> -->
   <div class="col-sm-12 no-padder clearfix" style="height: 220px;margin-top:50px;">
	   <div><font class="font18 black-2" style="color:#444343;">光伏组串电流(A)</font></div>
	   <br>
	   <br>
	   <div ng-repeat="vo in inverterMonitorData.cList" style="width: 16%;height: 30px;margin:0px 2% 15px 2% ;text-align: center;float: left;">
		   <div style="width: 30px;background-color: #1C2B36;float: left;">
		   		<font class="font-h3 white-1" style="line-height: 30px;"><span ng-bind="$index+1"></span></font>
		   </div>
		   <div style="width: 70%;float: left;border-bottom:1px solid #ccc;">
			 <div ng-class="{'coverDiv':vo.shadowFlag==1}">
			   	<font class="font-big blue-3" style="line-height: 30px;" >
					<span ng-if="vo.statuFlag=='0'" class="handle3">
						-
					</span>
					<span ng-if="vo.statuFlag=='1'" class="data-red">
						<span ng-bind="vo.c"></span>
					</span>
					<span ng-if="vo.statuFlag=='2'" class="data-yellow">
						<span ng-bind="vo.c"></span>
					</span>
					<span ng-if="vo.statuFlag=='3'">
						<span ng-bind="vo.c"></span>
					</span>
			   	</font>
			 </div>
		  </div>
	 </div>
  </div>
</div>