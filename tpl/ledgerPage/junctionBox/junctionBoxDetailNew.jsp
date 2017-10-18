    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<style>
	.nav > .pos-stc > a:hover, .nav > .pos-stc > a:focus {
    background-color: transparent;
}
	.state-icon{
		height:38px;
	}
	.state-value{
        font-size: 23px;
	}
	.state-name{
	font-size:12px;
	}
.state-img{
	position:absolute;    left: -30px;top: -4px;
	}
	.state-img >img{transform: scale(0.5);}
	p{
	margin:0;
	}
	.stopped{background: #999;border-radius:50%;width: 14px;height: 14px;display: block;}
	.trouble{background: #db412f;border-radius:50%;width: 14px;height: 14px;display: block;}
	.alarm{background:#f90;border-radius:50%;width: 14px;height: 14px;display: block;}
	.normal{background: #3fad22;border-radius:50%;width: 14px;height: 14px;display: block;}
</style>
<div ng-controller="JunctionBoxMonitorCtrl">
	<div class="bg-light lter b-b padder-v padding-b-10 height_70">
		<span class="font-h3 blue-1 m-n text-black wrapper ng-binding" ng-bind="name"></span>
		<span class="font-h3 blue-1 m-n text-black" ng-bind="eventDesc"></span>
	</div>
	<ul class="nav navbar-nav hidden-sm col-sm-12" style="margin-top:-40px;">
          <li class="dropdown pos-stc pull-right" dropdown>
            <a href class="dropdown-toggle " dropdown-toggle style="padding:10px;">
              <span >查看更多信息</span> 
              <span class="caret"></span>
            </a>
            <div class="dropdown-menu  w-full bg-white">
             	 <div class="hb_parame b-b wrapper">
	    	 <div class="col-sm-12 no-padder">
		 		<span class="m-r-xs">所属逆变器</span>
		 		<span id="boxchangeid" class="m-r-md font_weight" ng-class="{'a-cur-poi href-blur' : messageFlag != 1}" ng-bind="boxchangename" ng-click="toinverter(invertergid);"></span>
 				<span class="m-r-xs" onclick="text()">位置</span>
 				<span id="address" class="m-r-md font_weight" ng-bind="address"></span>
 				<span class="m-r-xs">设备厂商</span>
 				<span id="manufid" class="m-r-md font_weight" ng-bind="manufid"></span>
 				<span class="m-r-xs">产品型号</span>
 				<span id="productid" class="m-r-md font_weight" ng-bind="productid"></span>
 				
		 	</div>
	     </div>
	     <div class=" wrapper" >
		  	 <span class="pull-left">主要参数:</span>
		     <span class="pull-left" ng-bind="mainparameter">-</span>
		     <span class="m-l">检修工艺卡:</span>
		     <span class="m-l-xs" ng-bind="repaircard">-</span>
	     </div>
	      <div class="hb_info wrapper">
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder text-center">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Tools.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>安装时间</p>
		 			<div id="installDate" ng-bind="installDate"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Speedometer.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>已运行时间</p>
		 			<div id="runhour" ng-bind="runhour"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Clock.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>累计工作时间</p>
		 			<div id="totalHour" ng-bind="totalHour"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Timer.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>正常工作时间</p>
		 			<div id="workHour" ng-bind="workHour"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder v-middle">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Hourglass.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>故障时间</p>
		 			<div id="faultHour" ng-bind="faultHour"></div>
		 		</div>
		 	</div>
		 </div>
            </div>
          </li>
        </ul>
	    
		<div class="wrapper-sm no-border-xs">
				<tabset class="nav-tabs-alt nav-tabs-power2" justified="true"> 
				<tab ng-click="onSelectPageBjunction(1)" class="judgeTabClassJB" id="realDataJB"> 
				<tab-heading> 
				<span class="wrapper-sm white-1 a-cur-poi"> 实时数据 </span>
				</tab-heading>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				
				<div id="response_respStatus1" class="alert alert-danger" role="alert" style="display:none;">未接收到任何数据。请等待...</div>
				<div id="response_respStatusnull1" style="display: none;"
					class="alert alert-danger" role="alert">返回数据异常！</div>
				<div id="comm_interruptDev1" 	class="alert alert-danger" role="alert" style="display:none;" >
					通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于<span
						ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
				</div>
				<div id="comm_initDev1"  class="alert alert-info" role="alert" style="display:none;">设备初始化，未接收到任何数据。请等待...</div>
				
				   <div class="col-sm-12 text-right" style="color:black;">{{millisecond | date:'yyyy-MM-dd HH:mm:ss'}}</div>
				   <div class="col-sm-12" style="color:black;">
				   		<div class="col-sm-4 text-center">
				   			<p class="state-icon">
								<span style="position:relative;">
									<span class="state-value">{{junctionBoxMonitorData.statusDesc}}</span>
									<span  class="state-value" ng-if="junctionBoxMonitorData.statusIsValid == 1">(状态位无效)</span>
									<span ng-if="junctionBoxMonitorData.comm == 1 || junctionBoxMonitorData.comm == 2 || junctionBoxMonitorData.status == -99" class="state-img" >
										<i class="stopped"></i>
									</span>
									<span ng-if="junctionBoxMonitorData.comm != 1 && junctionBoxMonitorData.comm != 2 && junctionBoxMonitorData.status == 1" class="state-img" >
										<i class="trouble"></i>
									</span>
									<span ng-if="junctionBoxMonitorData.comm != 1 && junctionBoxMonitorData.comm != 2 && junctionBoxMonitorData.status == 2" class="state-img" >
										<i class="alarm"></i>
									</span>
									<span ng-if="junctionBoxMonitorData.comm != 1 && junctionBoxMonitorData.comm != 2 && junctionBoxMonitorData.status != 1 && junctionBoxMonitorData.status != 2 && junctionBoxMonitorData.status != -99" class="state-img" >
										<i class="normal"></i>
									</span>
								</span>
							</p>
				   			<p class="state-name">当前状态</p>
						</div>
				   		<div class="col-sm-4 text-center">
				   			<p class="state-icon">
							<span style="position:relative;">
					   			<span ng-if="junctionBoxMonitorData.jbStatus=='0'" class="state-img" style="top: -10px;left: -43px;">
									<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/close.png">
								</span>
						   		<span ng-if="junctionBoxMonitorData.jbStatus=='1'" class="state-img" style="top: -10px;left: -43px;">
									<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/run.png">
								</span>
						   		<span ng-if="junctionBoxMonitorData.jbStatus=='2'" class="state-img" style="top: -10px;left: -43px;">
						   			<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/unknow.png" >
								</span>
								<span class="state-value">{{junctionBoxMonitorData.kStr}}</span>
							</span>
							</p>
				   			<p class="state-name">开关状态</p>
						</div>
				   		<div class="col-sm-4 text-center">
					   		<p class="state-icon">
							<span style="position:relative;">
					   			<span ng-if="junctionBoxMonitorData.arresterStatus=='0'" class="state-img" style="left: -36px; top: -16px;">
									<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/blzRun.png">
								</span>
						   		<span ng-if="junctionBoxMonitorData.arresterStatus=='1'" class="state-img" style="left: -36px; top: -16px;">
									<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/blzFault.png">
								</span>
						   		<span ng-if="junctionBoxMonitorData.arresterStatus=='2'" class="state-img" style="left: -36px; top: -16px;">
									<img alt="" src="${ctx}/theme/images/junctionBoxMonitor/blzUnknow.png">
								</span>
					   			<span class="state-value">{{junctionBoxMonitorData.arresterStr}}</span>
							</span>
					   		</p>
					   		<p class="state-name">防雷器状态</p></div>
					   </div>
				   
				   <div style="width: 98%;margin: 0 auto;height: 350px;">
				   <div id="junctionBox1" style="height: 250px;width:33%;float: left;"></div>
		 		   <div id="junctionBox2" style="height: 250px;width:33%;float: left;"></div>
				   <div id="junctionBox3" style="height: 250px;width:33%;float: left;"></div>
				   <div style="width: 100%;height: 300px;float: left;margin-top: -80px">
				   <font class="font-h3 black-2" >&nbsp;光伏组串电流(A)</font>
				   <br>
				   <br>
				   <div ng-repeat="vo in junctionBoxMonitorData.cList" style="width: 16%;height: 30px;margin:0px 2% 40px 2% ;text-align: center;float: left;">
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
				</div>
				</tab> 
				
				
				<tab ng-controller="junctionpageHistory" id="historyInfojb"  active="defaultTabJB" ng-click="changeViewNotSearch()" class="judgeTabClassJB"> 
					<tab-heading class="wrapper-sm">
						<span  class="white-1 a-cur-poi">历史数据</span>
						<span class="white-1 a-cur-poi" id="pageHistory"></span> 
					</tab-heading>
				<paging class="col-sm-12 panel no-padder m-b-none">
					<div class="col-sm-12 text-center m-t m-b no-padder">
						<div class="col-sm-6">
						<div class="input-group " style="width: 400px;">
						<input type="text" id="begindatePublicJB" name="begindatePublicJB" ng-model="begindatePublicJB" class="form-control">
			         	<span class="input-group-addon">至</span>
			         	<input type="text" id="enddatePublicJB" name="enddatePublicJB"  ng-model="enddatePublicJB" class="form-control">
			      		 <span class="input-group-btn padder-l-sm ">
			         	<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
			         	</span>
			         	<span class="input-group-btn padder-l-sm ">
			         	<button class=" btn btn-sm btn-info" ng-click="exportData();" type="button">导出</button>
			         	</span>
			      		</div>
			      		
					    </div>
			      		<div class="col-sm-6 pull-right"><%@ include file="/common/pager.jsp"%></div>
				     </div>
				     <div ng-include="showModelDivJBHistory" ></div>
						</paging>
				</tab>
				
				<tab ng-controller="faultAlarmJB" ng-click="changeViewNotSearchFault()" class="judgeTabClassJB"> 
					<tab-heading class="wrapper-sm">
						<span class="white-1 a-cur-poi">故障信息</span>
						<span class="white-1 a-cur-poi" id="faultalarmTitle" ng-bind="faultalarmTitle" ></span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					 	<paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-6 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="breakdown" class="table table-striped b-t b-light bg-table">
					 		<thead>
							 	<tr>
									 <th width="15%" class="text-left">发生时间</th>
									 <th width="15%" class="text-left">结束时间</th>
					                 <th class="text-left">故障级别</th>
					                 <th class="text-left">故障描述</th>
					                 <th class="text-left">结果</th>
					                 <th>人工处理状态</th>
					            </tr>
			                 </thead>
						 <tbody>
			      				<tr ng-repeat="vo in data">
					      			<td ng-bind="vo.sStartTime|date:'yyyy-MM-dd HH:mm'"></td>
									<td ng-bind="vo.sEndTime|date:'yyyy-MM-dd HH:mm'"></td>
					      			<td class="blue-3 text-left" ng-bind="vo.faultlevelStr"></td>
					      			<td class="blue-3 text-left" ng-bind="vo.eventDesc"></td>
					      			<td class="blue-3 text-left" ><span  ng-if="vo.sEndTime==null">报告</span><span  ng-if="vo.sEndTime!=null">关闭</span></td>
					      			<td ng-bind="vo.handstatusStr "></td>
			      				</tr>
	      				</tbody>
					 	
					 	</table>
						 </paging>
					</tab>
					
					<tab ng-controller="repairtJB" ng-click="onSelectPage(1)"  class="judgeTabClassJB"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi">检修维护</span>
							<span class="white-1 a-cur-poi" id="repairtTitle" ng-bind="repairtTitle" ></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
						<paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-6 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="maintenance" class="table table-striped b-t b-light bg-table">
					 		   	
						<thead>
						    <tr>
							    <th width="15%">维护时间</th>
				                <th width="15%">维护人</th>
				                <th>维护内容</th>
				                <th width="15%">结果</th>
				            </tr>
				       </thead>
				                	
				     	<tbody>
					   		<tr ng-repeat="vo in maintenance">
					   			<td class="blue-3" ng-bind="vo.repairdate | date:'yyyy-MM-dd HH:mm:ss'"></td>
					   			<td class="blue-3" ng-bind="vo.operator"></td>
					   			<td class="blue-3" ng-bind="vo.repaircontent"></td>
					   			<td class="blue-3" ng-bind="vo.repairresult"></td>
				   			</tr>
		   				</tbody>      
			
					 	</table>
						 </paging>
					</tab>
					
					<tab ng-controller="experimentJB" ng-click="onSelectPage(1)" class="judgeTabClassJB"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi">技术监督</span>
							<span class="white-1 a-cur-poi" id="experimentTile" ng-bind="experimentTile"></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					  <paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-6 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="supervise" class="table table-striped b-t b-light bg-table">
					
					<thead>
				    	<tr>
					   		<th width="15%">监督时间</th>
		                	<th width="15%">监督人</th>
		                	<th>监督内容</th>
	               		</tr>
	               </thead>	
	        		
	        	  <tbody>
		   				<tr ng-repeat="vo in supervise">
				   			<td class="blue-3" ng-bind="vo.experidate | date:'yyyy-MM-dd HH:mm:ss'"></td>
				   			<td class="blue-3" ng-bind="vo.operator"></td>
				   			<td class="blue-3" ng-bind="vo.expericontent"></td>
		   				</tr>
		  		</tbody>
					 </table>
					</paging>
					</tab>
					
					<tab ng-controller="replacedJB" ng-click="onSelectPage(1)" class="judgeTabClassJB"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi">技术改造</span>
							<span class="white-1 a-cur-poi" id="replacedTitle" ng-bind="replacedTitle"></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					 <paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-6 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="reform" class="table table-striped b-t b-light bg-table">
				<thead>
				    <tr>
				    	<th width="15%">维护时间</th>
	                	<th width="15%">实施人</th>
	                	<th>改造内容</th>
	               </tr>
	            </thead>	
	            <tbody>
		   			<tr ng-repeat="vo in reform">
		   				<td class="blue-3" ng-bind="vo.replaceddate"></td>
		   				<td class="blue-3" ng-bind="vo.operator"></td>
		   				<td class="blue-3" ng-bind="vo.replacedcontent"></td>
		   			</tr>
		   		</tbody>
					</table>
					</paging>
					</tab>
				
					</tabset>
			</div>

</div>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript">
$(".modal-backdrop").css("display","none")
var tab=0;
//定义各种状态的对应图片
var jbStatusArray=new Array("close.png","run.png","unknow.png");
var arresterStatusArray=new Array("blzRun.png","blzFault.png","blzUnknow.png");

//$("#junction_box_result_table").css("height", $(window).height() - 240);
//定义定时器
var junctionRT;
var junctionV;
var junctionA;
var junctionP;
var junction2;

var jbfirstFlagForHS = 0;
var jbfirstFlag = 0;
app.controller('JunctionBoxMonitorCtrl', function($scope, $http, $state,$stateParams) {

	//当前界面的获得全部数据
	$scope.commnullCount = 0;
	$scope.commCount = 0;
	$scope.getstaDayData=function(){
		$http({
			method : "POST",
			url : "./MobileRtmStationStatus/getRtmSingleStationComm.htm",
			timeout: 5000,
			params : {
				'dateString':new Date().Format("yyyy-MM-dd"),
			}
		}).success(function (msg) {
			$scope.statDayData=msg;
			if (msg.comm == 1) {
				//通讯中断
				$("#comm_interruptDev1").show();
				$("#comm_initDev1").hide();
				$("#response_respStatus1").hide();
				$("#response_respStatusnull1").hide();
				$scope.commCount = 0;
				$scope.commnullCount = 0;
			} else if (msg.comm == 2) {
				$("#comm_initDev1").show();
				$("#comm_interruptDev1").hide();
				$("#response_respStatus1").hide();
				$("#response_respStatusnull1").hide();
				$scope.commCount = 0;
				$scope.commnullCount = 0;
			} else if (msg.comm == null) {
				$scope.commCount = 0;
				$scope.commnullCount++;
				if($scope.commnullCount > 3){
					$("#comm_initDev1").hide();
					$("#comm_interruptDev1").hide();
					$("#response_respStatus1").hide();
					$("#response_respStatusnull1").show();	
				}
				
			} else {
				$scope.commCount = 0;
				$scope.commnullCount = 0;
				$("#comm_interruptDev1").hide();
				$("#comm_initDev1").hide();
				$("#response_respStatus1").hide();
				$("#response_respStatusnull1").hide();
			}
		}).error(function(msg){
			$scope.commnullCount = 0;
			$scope.commCount++;
			if ($scope.commCount > 3){
				$("#response_respStatus1").show();
				$("#comm_interruptDev1").hide();
				$("#comm_initDev1").hide();
				$("#response_respStatusnull1").hide();
			}
		});
	};
	$scope.messageFlag=0;
	//监听父类 ctr 传过来的值，并执行相对应的方法
	$scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
		$scope.serialnumber = deviceById.deviceSerialNnumber;
		$scope.pstationid = deviceById.pstationid;
		$scope.InId = deviceById.deviceId;

		$stateParams.InId = $scope.InId;
		$stateParams.pstationid = $scope.pstationid;
		$stateParams.serialnumber = $scope.serialnumber;
		if(deviceById.dStartTime != null && deviceById.dStartTime != ""){
			$stateParams.dstarttime = deviceById.dStartTime;

			var eventTime =new Date($stateParams.dstarttime).Format("yyyy-MM-dd hh:mm:ss");
			$scope.eventDesc = "(事件发生时间:" + eventTime + ")";
		}

		$scope.messageFlag=1;
		getHoursJB($scope, $stateParams,$http);
		refreshdata($scope, $stateParams,$http,0);
		$scope.onSelectPage(1);
        var hashUrl = location.hash;
        var hashArr = hashUrl.split("/");
        var lastHash = hashArr[hashArr.length-1];
        if(lastHash != "RtmDeviceLayout"){
		    angular.element("#historyInfojb").trigger("click");
        }
	});

	$scope.$on('showDeviceDetail1broad', function(event,deviceById) {
		$scope.serialnumber = deviceById.deviceSerialNnumber;
		$scope.pstationid = deviceById.pstationid;
		$scope.InId = deviceById.deviceId;
		
		$stateParams.InId = $scope.InId;
		$stateParams.pstationid = $scope.pstationid;
		$stateParams.serialnumber = $scope.serialnumber;
		if(deviceById.dStartTime != null && deviceById.dStartTime != ""){
			$stateParams.dstarttime = deviceById.dStartTime;

			var eventTime =new Date($stateParams.dstarttime).Format("yyyy-MM-dd hh:mm:ss");
			$scope.eventDesc = "(事件发生时间:" + eventTime + ")";
		}
		
		var tabNum=0;
		jbfirstFlagForHS = 0;
        //是否第一次打开该页面,如果是需要判断默认显示的页面
	     if(jbfirstFlag++ == 0 && deviceById.defaultShowPage == 2){
	    	 //如果默认显示历史数据页面
	    	 $scope.defaultTabJB = true;
	    	 $scope.$broadcast('toTabsJB',2);
	     }else{
	    	 $(".judgeTabClassJB").each(function(index){
	         	tabNum++;
	         	if($(this).hasClass("active")){
	         		$scope.$broadcast('toTabsJB',tabNum);
	         	}
	         	
	         });
	     }
		
		$scope.messageFlag=1;
		getHoursJB($scope, $stateParams,$http);
		refreshdata($scope, $stateParams,$http,0);
		
		$scope.commnullCount = 0;
		$scope.commCount = 0;
		$scope.getstaDayData();
		
		$scope.onSelectPage(1);
		/**junction2=setInterval(function(){
			getHours($scope, $stateParams,$http);
		},60000);*/
        
	});
	
	junctionRT=setInterval(function(){
		if($scope.deviceTypeNow == '1'){
			refreshdata($scope, $stateParams,$http,1);
			$scope.getstaDayData();
		}
	},5000);
	
	$scope.serialnumber = $stateParams.serialnumber;
	$scope.pstationid = $stateParams.pstationid;
	
	//跳转到逆变器
	$scope.toinverter = function(id) {
		//当在消息中心时不允许跳转
		if($scope.messageFlag != 1){
			$state.go("app.inverterDetail", {
				InId : id
			});
		}
	};

	//设备信息	
	$scope.onSelectPage = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/BjunctionStanding/bjunctionCount.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				'param' : $stateParams.InId
			},
			timeout: 5000
		}).success(function(result) {
			$scope.name=result.bjunctionBox.name;
			$scope.boxchangename=result.bjunctionBox.boxname;
			$scope.address=result.bjunctionBox.address;
			$scope.inverterroom=result.bjunctionBox.inverterroom;
			$scope.invertergid=result.bjunctionBox.inverterid;
			$scope.manufid=result.bjunctionBox.manufname;
			$scope.productid=result.bjunctionBox.productname;
			$scope.mainparameter=result.bjunctionBox.mainparameter;
			$scope.repaircard=result.bjunctionBox.repaircard;
			$scope.faultalarmTitle="("+result.faultalarm+")";
			$scope.repairtTitle="("+result.repairt+")";
			$scope.experimentTile="("+result.experiment+")";
			$scope.replacedTitle="("+result.replaced+")";
		}).error(function(response) {
		});
	};
	
	//历史信息
	app.controller('junctionpageHistory', function($scope, $http, $state,$stateParams) {
		$("#junction_box_result_table").css("width", $("#deviceDatas").width);
		$scope.junctionBoxGridOptions = {
				data : 'deviceData',
				enablePinning : true,
				enableCellSelection : true,
				
				columnDefs : [
					
						{
							field : 'dtime',
							displayName : '时间',
							width : 120,
							pinned : true,
							minWidth:850,
							cellClass : 'text-center',
							cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
						}, {
							field : 'k',
							displayName : '开关',
							width : 60,
							minWidth:850,
							pinned : true,
							cellClass : 'text-center',
							cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'k\')==\'0\'">无效</span> <span'+
							' ng-if="row.getProperty(\'k\')==\'1\'">无效</span> <span'+
							' ng-if="row.getProperty(\'k\')==\'2\'">闭合</span> <span'+
							' ng-if="row.getProperty(\'k\')==\'3\'">开启</span></span> '
						}, {
							field : 'arrester',
							displayName : '防雷器',
							width : 60,
							minWidth:850,
							pinned : true,
							cellClass : 'text-center',
							cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'arrester\')==\'0\'">无效</span> <span'+
							' ng-if="row.getProperty(\'arrester\')==\'1\'">无效</span> <span'+
							' ng-if="row.getProperty(\'arrester\')==\'2\'">正常</span> <span'+
							' ng-if="row.getProperty(\'arrester\')==\'3\'">异常</span></span> '
						}, {
							field : 'u',
							displayName : '电压(V)',
							width : 80,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c',
							displayName : '电流(A)',
							width : 80,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'p',
							displayName : '功率(kW)',
							width : 80,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c1',
							displayName : '1',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c2',
							displayName : '2',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c3',
							displayName : '3',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c4',
							displayName : '4',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c5',
							displayName : '5',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c6',
							displayName : '6',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c7',
							displayName : '7',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c8',
							displayName : '8',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c9',
							displayName : '9',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c10',
							displayName : '10',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c11',
							displayName : '11',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c12',
							displayName : '12',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c13',
							displayName : '13',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c14',
							displayName : '14',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c15',
							displayName : '15',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c16',
							displayName : '16',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c17',
							displayName : '17',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c18',
							displayName : '18',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c19',
							displayName : '19',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c20',
							displayName : '20',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, ]
			};
		
		$scope.$on('toTabsJB', function(event,tabNum) {
			if(tabNum == 2){
				$scope.changeViewNotSearch(1);
			}
		});
		$scope.changeViewNotSearch = function(page) {
			$scope.showModelDivJBHistory="${ctx}/tpl/ledgerPage/junctionBox/junctionBoxHistoryData.jsp";
			if(jbfirstFlagForHS == 0){
				$scope.onSelectPage(1);
				jbfirstFlagForHS++;
			}else{
				$("#junction_box_result_table").show();
			}
		};
		var flag=0;
		$scope.initHs = function(){
			if(flag==0){
				$('#begindatePublicJB').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				}).on('changeDate', function(ev){
					$("#enddatePublicJB").val($('#begindatePublicJB').val());
				    $('#enddatePublicJB').datetimepicker('setStartDate', $('#begindatePublicJB').val()).datetimepicker('update').datetimepicker('show');
				});	
				$('#enddatePublicJB').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				});
				function startDate(date){
					var newdate=new Date(date-24*60*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					return startTime;
				}
				function endDate(date){
					var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
					return endTime;
				}
				if($stateParams.dstarttime == null){
					$("#begindatePublicJB").val(startDate(new Date()));
					$("#enddatePublicJB").val(endDate(new Date()));
					$scope.begindatePublicJB = $("#begindatePublicJB").val();
					$scope.enddatePublicJB = $("#enddatePublicJB").val();
				}else{
					var newdate=new Date($stateParams.dstarttime-15*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					var newenddate = (new Date).getTime();
					if(newenddate > ($stateParams.dstarttime + 15*60*1000)){
						newenddate = $stateParams.dstarttime + 15*60*1000;
					}
					var endTime= new Date(newenddate).Format("yyyy-MM-dd hh:mm");
					$("#begindatePublicJB").val(startTime);
					$("#enddatePublicJB").val(endTime);
					$scope.begindatePublicJB = $("#begindatePublicJB").val();
					$scope.enddatePublicJB = $("#enddatePublicJB").val();
				}
				flag++;
			}
		}
	var flag=0;	
	initTableConfig($scope);
	$scope.onSelectPage  = function(page) {
		if(flag==0){
			$('#begindatePublicJB').datetimepicker({
				format: "yyyy-mm-dd hh:ii",
				language: 'zh-CN',
				todayHighlight:true,
				todayBtn:true,
				autoclose: true,
				endDate:new Date()
			}).on('changeDate', function(ev){
				$("#enddatePublicJB").val($('#begindatePublicJB').val());
				$('#enddatePublicJB').datetimepicker('setStartDate', $('#begindatePublicJB').val()).datetimepicker('update').datetimepicker('show');
			});
			$('#enddatePublicJB').datetimepicker({
				format: "yyyy-mm-dd hh:ii",
				language: 'zh-CN',
				todayHighlight:true,
				todayBtn:true,
				autoclose: true,
				endDate:new Date()
			});
			function startDate(date){
				var newdate=new Date(date-24*60*60*1000);
				var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
				return startTime;
			}
			function endDate(date){
				var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
				return endTime;
			}
			if($stateParams.dstarttime == null || $stateParams.dstarttime == ""){
				$("#begindatePublicJB").val(startDate(new Date() - 5*60*1000));
				$("#enddatePublicJB").val(endDate(new Date() - 5*60*1000));
				$scope.begindatePublicJB = $("#begindatePublicJB").val();
				$scope.enddatePublicJB = $("#enddatePublicJB").val();
			}else{
				var newdate=new Date($stateParams.dstarttime-15*60*1000);
				var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
				var newenddate = (new Date).getTime();
				if(newenddate > ($stateParams.dstarttime + 15*60*1000)){
					newenddate = $stateParams.dstarttime + 15*60*1000;
				}
				var endTime= new Date(newenddate).Format("yyyy-MM-dd hh:mm");
				$("#begindatePublicJB").val(startTime);
				$("#enddatePublicJB").val(endTime);
				$scope.begindatePublicJB = $("#begindatePublicJB").val();
				$scope.enddatePublicJB = $("#enddatePublicJB").val();
			}
			flag++;
		}
		CommonPerson.Base.LoadingPic.PartShow('loadingDiv');//加载状态
		$("#junction_box_result_table").hide();
		if (page == 0) {
			page = 1;
			$scope.currentPage=1;
		}
		$http({
			method : "POST",
			url : "${ctx}/HistoryData/getNewHistoryData.htm",
			params : {
				'pageIndex' : page ,
				'pageSize' : $scope.pageSizeSelect,
				'devicetype':1,
				'begindate':$scope.begindatePublicJB,
				'enddate':$scope.enddatePublicJB,
				'stationid':$scope.pstationid,
				'serialnumber' : $scope.serialnumber,
				'id' : $stateParams.InId
			}
		}).success(function(result) {
			partHide('loadingDiv');
			getPaginationDatas($scope,result[0]);
			$("#junction_box_result_table").show();
		}).error(function(response) {
		});
		};
		
		$scope.exportData = function(){
			CommonPerson.Base.LoadingPic.FullScreenShow("数据导出中，请稍后...");
			var url = "${ctx}/HistoryData/exportHsData.htm";
			url +='?stationid='+$scope.pstationid;
			url +='&serialnumber='+$scope.serialnumber;
			url +='&devicetype='+1;
			url +='&begindate='+$scope.begindatePublicJB;
			url +='&enddate='+$scope.enddatePublicJB;
			window.location.href = url;
			getSessionValueByKey("ExportHistoryData");
		}

	});
	
	function getSessionValueByKey(key){
		var tt = setInterval(function(){
			$.ajax({
		   		type:"post",
		   		url:"${ctx}/Login/getSessionvalueByKey.htm",
		   		data:{key:key},
		   		success:function(msg){
		   			if(msg == "1"){
		   				clearInterval(tt);	
			   			CommonPerson.Base.LoadingPic.FullScreenHide();
		   			}
		   		}
		   	});
		},1000);
	}
	
	function initPaginationDatas($scope){
		$scope.deviceData = null;
		$scope.currentPage = 0;
		$scope.numPages = 1;
		$scope.pageSize = 1800000;
		$scope.pages = [];
		$scope.showStart = null;
		$scope.showEnd = null;
		$scope.totalPage = 0;
		$scope.pageSizeSelect=1800000;
		$scope.startTimeInMillis=null;
		$scope.endTimeInMillis=null;
	}
	function getPaginationDatas($scope,result){
		$(window).trigger('resize');
		$scope.deviceData = result.data;
		$scope.numPages = result.totalPage;
		$scope.showStart = result.showStart;
		$scope.showEnd = result.showEnd;
		$scope.total = result.total;
		$scope.totalPage=result.totalPage;
		$scope.startTimeInMillis=result.startTimeInMillis;
		$scope.endTimeInMillis=result.endTimeInMillis;
		if($scope.totalPage==0){
			$scope.currentPage=0;
		}else{
			$scope.currentPage=result.pageIndex;		
		}
	}
	
	//故障信息
	app.controller('faultAlarmJB', function($scope, $http, $state,$stateParams) {
		var firstFlagFault = 0;
		$scope.changeViewNotSearchFault = function() {
			$scope.onSelectPage(1);
		}
		$scope.$on('toTabsJB', function(event,tabNum) {
			if(tabNum == 3){
				$scope.onSelectPage(1);
			}
		});
		$scope.onSelectPage  = function(page) {
			if (page == 0) {
				page = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/FaultAlarm/faultAlarmList.htm",
				params : {
					'pageIndex': page - 1,
					'pageSize' : $scope.pageSizeSelect,
					"deviceId" : $stateParams.InId,
					deviceType :1
				},
				timeout: 10000
			}).success(function(result) {
				getTableData($scope,result);
			}).error(function(response) {
			});
		};
		initTableConfig($scope);
	});
	
	
	//检修维护
	app.controller('repairtJB', function($scope, $http, $state,$stateParams) {
		$scope.$on('toTabsJB', function(event,tabNum) {
			if(tabNum == 4){
				$scope.onSelectPage(1);
			}
		});
		$scope.onSelectPage  = function(page) {
			if (page == 0) {
				page = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/Repair/repairtList.htm",
				params : {
					'pageIndex': page - 1,
					'pageSize' : $scope.pageSizeSelect,
					"param" : $stateParams.InId,
				},
				timeout: 5000
			}).success(function(result) {
				$scope.maintenance=result.data
			}).error(function(response) {
			});
		};	
		initTableConfig($scope);
	});
	
	
	//技术监督
	app.controller('experimentJB', function($scope, $http, $state,$stateParams) {
		$scope.$on('toTabsJB', function(event,tabNum) {
			if(tabNum == 5){
				$scope.onSelectPage(1);
			}
		});
		$scope.onSelectPage  = function(page) {
			if (page == 0) {
				page = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/Experiment/experimentList.htm",
				params : {
					'pageIndex': page - 1,
					'pageSize' : $scope.pageSizeSelect,
					"param" : $stateParams.InId,
				},
				timeout: 5000
			}).success(function(result) {
				$scope.supervise=result.data
			}).error(function(response) {
			});
		};
		initTableConfig($scope);
	});
	
	
	//技术改造
	app.controller('replacedJB', function($scope, $http, $state,$stateParams) {
		$scope.$on('toTabsJB', function(event,tabNum) {
			if(tabNum == 6){
				$scope.onSelectPage(1);
			}
		});
		$scope.onSelectPage  = function(page) {
			if (page == 0) {
				page = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/Replaced/replacedList.htm",
				params : {
					'pageIndex': page - 1,
					'pageSize' : $scope.pageSizeSelect,
					"param" : $stateParams.InId,
					serialnumber:$scope.serialnumber,
					pstationid : $stateParams.pstationid
				},
				timeout: 5000
			}).success(function(result) {
				$scope.reform=result.data
			}).error(function(response) {
			});
		};
		initTableConfig($scope);
	});
	
	
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(junctionRT);
		clearInterval(junction2);
		
		clearInterval(junctionV);
		clearInterval(junctionA);
		clearInterval(junctionP);
	});
});
//实时数据
function refreshdata($scope, $stateParams,$http,flag){
	$http.get("${ctx}/DeviceStation/getSingleRealDataBJunction.htm", {
		params : {
			id : $stateParams.InId,
			serialnumber : $stateParams.serialnumber,
			pstationid : $stateParams.pstationid
		},
		timeout: 5000
	}).success(function(response) {
		if(response.respStatus==1){
		$scope.serialnumber = response.data.did;
		$scope.pstationid = response.data.sid;
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.jbStatus!=response.data.jbStatus){
			$("#jbStatusImg").attr('src','${ctx}/theme/images/junctionBoxMonitor/'+jbStatusArray[response.data.jbStatus]);
		}
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.blzStatus!=response.data.blzStatus){
			$("#arresterStatusImg").attr('src','${ctx}/theme/images/junctionBoxMonitor/'+arresterStatusArray[response.data.arresterStatus]);
		}
		if(flag==0){
			getScoreV(1,response.data.u,'电压(V)',1000,$scope);
			getScoreA(2,response.data.c,'电流(A)',200,$scope);
			getScoreP(3,response.data.p,'功率(kW)',200,$scope);
		}
		if(response.data.dtime){
			$scope.millisecond=response.data.dtime*1000;//数据时间
		}else{
			$scope.millisecond = 0;
		}
		$scope.junctionBoxMonitorData = response.data;
		
		}
	}).error(function(response) {
	});
}
//小时数数据
function getHoursJB($scope, $stateParams,$http){
	$http.get("${ctx}/BjunctionStanding/getJunctionBoxHours.htm", {
		params : {
			id : $stateParams.InId
		},
		timeout: 5000
	}).success(function(result) {
		$scope.installDate=result.begindate;	
		$scope.runhour=result.runhour+"h";
		$scope.totalHour=result.totalHour+"h";
		$scope.workHour=result.workHour+"h";
		$scope.faultHour=result.faultHour+"h";
	}).error(function(response) {
		
	});
}
//电压
function getScoreV(j,dataValue,dataName,max,$scope){
	var myChartV;
	myChartV = echarts.init(document.getElementById('junctionBox1'));
	if(dataValue){
		dataValue =dataValue.toFixed(1) 
	}
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a} : {c}V"
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
		            radius: 120,
		            center : ['50%','55%'],
		            endAngle:0,
		            min:0,
		            max:max,
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
		            	formatter: function (value) {
		            		if(value){
		            			return value.toFixed(1);
		            		}else{
		            			return value;
		            		}
		            	    
		            	},
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder',
		                    fontSize : 18
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: dataValue, name: dataName}]
		        }
		    ]
		};
    myChartV.setOption(option,true);
	window.onresize = myChartV.resize;
	clearInterval(junctionV);
	junctionV=setInterval(function(){
		if($scope.deviceTypeNow == '1'){
			if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.u!=null){
				option.series[0].data[0].value=$scope.junctionBoxMonitorData.u.toFixed(1);
				myChartV.setOption(option,true);
			}
		}
	},5000);
}
//电流
function getScoreA(j,dataValue,dataName,max,$scope){
	var myChartA;
	if(dataValue){
		dataValue =dataValue.toFixed(2) 
	}
	myChartA = echarts.init(document.getElementById('junctionBox2'));
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a} : {c}A"
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
		            radius: 120,
		            center : ['50%','55%'],
		            endAngle:0,
		            min:0,
		            max:max,
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
		            	formatter: function (value) {
		            		if(value){
		            			return value.toFixed(1);
		            		}else{
		            			return value;
		            		}
		            	},
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder',
		                    fontSize : 18
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: dataValue, name: dataName}]
		        }
		    ]
		};
	myChartA.setOption(option,true);
	window.onresize = myChartA.resize;
	clearInterval(junctionA);
	junctionA=setInterval(function(){
		if($scope.deviceTypeNow == '1'){
			if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.c!=null){
				option.series[0].data[0].value=$scope.junctionBoxMonitorData.c.toFixed(2);
				myChartA.setOption(option,true);
			}
		}
	},5000);
}
//功率
function getScoreP(j,dataValue,dataName,max,$scope){
	var myChartP;
	if(dataValue){
		dataValue =dataValue.toFixed(1) 
	}
	myChartP = echarts.init(document.getElementById('junctionBox3'));
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a} : {c}kW"
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
		            radius: 120,
		            center : ['50%','55%'],
		            endAngle:0,
		            min:0,
		            max:max,
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
		            	formatter: function (value) {
		            		if(value){
		            			return value.toFixed(1);
		            		}else{
		            			return value;
		            		}
		            	},
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder',
		                    fontSize : 18
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: dataValue, name: dataName}]
		        }
		    ]
		};
	myChartP.setOption(option,true);
	window.onresize = myChartP.resize;
	clearInterval(junctionP);
	junctionP=setInterval(function(){
		if($scope.deviceTypeNow == '1'){
			if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.p!=null){
				option.series[0].data[0].value=$scope.junctionBoxMonitorData.p.toFixed(1);
				myChartP.setOption(option,true);
			}
			
		}
	},5000);
	
}
</script>
