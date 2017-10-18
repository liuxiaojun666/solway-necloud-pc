<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-sm-6 text-center m-t"></div>
<div class="col-sm-12 wrapper-md b-a panel border-none">	
	<div id="response_respStatus2" class="alert alert-danger" role="alert" style="display:none;">未接收到任何数据。请等待...</div>
	<div id="response_respStatusnull2" style="display: none;" class="alert alert-danger" role="alert">返回数据异常！</div>
	<div id="comm_interruptDev2" 	class="alert alert-danger" role="alert" style="display:none;" >
		通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于<span
			ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
	</div>
	<div id="comm_initDev2"  class="alert alert-info" role="alert" style="display:none;">设备初始化，未接收到任何数据。请等待...</div>

    <div class="w_a_line_h col-sm-12">
	    <font class="font-h3 black-2 line_height_25">状态</font>&nbsp;&nbsp;&nbsp;
	    <font class="font-h3 black-1 line_height_25" ng-bind="inverterMonitorData.statusDesc"></font>&nbsp;&nbsp;&nbsp;
	    <font class="font-h3 black-2 line_height_25" >容量</font>&nbsp;&nbsp;&nbsp;
	    <font class="font-h3 black-1 line_height_25"><span ng-bind="buildcapacity|number:1"></span>kW</font>&nbsp;&nbsp;&nbsp;
	    <font class="font-h3 black-1 line_height_25" >出力</font>&nbsp;&nbsp;&nbsp;
		<font class="font-h3 c_line_height" id="used">0%</font>&nbsp;&nbsp;
        <font class="font-h3 black-1 line_height_25 m-l-xs">总发电量</font>&nbsp;&nbsp;&nbsp;
        <font ng-bind="tw" class="font-h3 black-1 line_height_25"></font>
        <font ng-bind="twUnit" class="font-h3 black-1 line_height_25"></font>
   		<font class="font-h3 black-1 line_height_25 m-l-xs" >日发电量</font>&nbsp;&nbsp;&nbsp;
    	<font ng-bind="dw" class="font-h3 black-1 line_height_25"></font>
    	<font ng-bind="dwUnit"class="font-h3 black-1 line_height_25"></font>
    	<span class="pull-right">
          	 <font class="font-h4 black-2" style="line-height: 25px"></font>&nbsp;&nbsp;&nbsp;
	         <font class="font-h4 black-1" style="line-height: 25px"><span  ng-bind="millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></font>
		</span>
    </div>
   
   <div class="col-sm-12 no-padder">
	   <div class="col-sm-4 no-padder" id="interverdcu" style="height: 230px;width:33%;float: left;"></div>
	   <div class="col-sm-4 no-padder" id="interverdcc" style="height: 230px;width:33%;float: left;"></div>
	   <div class="col-sm-4 no-padder" id="interverdcp" style="height: 230px;width: 33%;float: left;"></div>
	   <div class="float_w_m2">
	   		<hr class="height_b_t" />
	   </div>
	   <div class="col-sm-4 no-padder" id="interveracu" style="height: 230px;width:33%;float: left;"></div>
	   <div class="col-sm-4 no-padder" id="interveracc" style="height: 230px;width:33%;float: left;"></div>
	   <div class="col-sm-4 no-padder" id="interveracp" style="height: 230px;width:33%;float: left;"></div>
	   <div class="width_m2_h_f_t col-sm-12 ">
		   <font class="font-h2 black-2" >温度</font>&nbsp;&nbsp;
		   <font class="font-h2 black-1" ng-bind="inverterMonitorData.t|number:1"></font><font class="font-h3 black-1">℃</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <font class="font-h2 black-2" >无功功率</font>&nbsp;&nbsp;
		   <font class="font-h2 black-1" ng-bind="inverterMonitorData.acq|number:1"> </font><font class="font-h2 black-1">kVar</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <font class="font-h2 black-2" >效率</font>&nbsp;&nbsp;
		   <font class="font-h2 black-1" ng-bind="inverterMonitorData.ef *100|number:0"></font><font class="font-h2 black-1">%</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <font class="font-h2 black-2" >频率</font>&nbsp;&nbsp;
		   <font class="font-h2 black-1" ng-bind="inverterMonitorData.f|number:2"></font><font class="font-h2 black-1">Hz</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		   <font class="font-h2 black-2" >功率因数</font>&nbsp;&nbsp;
		   <font class="font-h2 black-1" ng-bind="inverterMonitorData.pf|number:2"></font>&nbsp;&nbsp;
	   </div>
   </div>
</div>

				