    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<style>
	.nav > .pos-stc > a:hover, .nav > .pos-stc > a:focus {
    background-color: transparent;
}
	#statusDescHidden{
	    position: absolute;
    background: rgba(0, 0, 0,0.5);
    height: 100%;
    width: 98%;
    }
</style>
<div ng-controller="JunctionBoxMonitorCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" ng-bind="boxchangename"></span>
		<span class="font-h3 blue-1 m-n text-black" ng-bind="eventDesc"></span>
		<!-- <a><span  class="m-r-xs col-sm-28 pull-right" onclick="switchInfo()">查看更多信息</span></a> -->
		
	</div>
	  <ul class="nav navbar-nav hidden-sm col-sm-12" style="margin-top:-40px;">
          <li class="dropdown pos-stc pull-right" dropdown>
            <a href class="dropdown-toggle " dropdown-toggle style="padding:10px;">
              <span >查看更多信息</span> 
              <span class="caret"></span>
            </a>
            <div class="dropdown-menu  w-full bg-white">
             	 <div class=" col-sm-12 no-padder" id="moreInfo">
	      <div class="hb_parame b-b wrapper col-sm-12">
	    	 <div class="col-sm-12 no-padder">
		 		<span class="m-r-xs">所属电站</span>
		 		<span id="boxchangeid" class="m-r-md font_weight" ng-bind="boxchangeid"></span>
 				<span class="m-r-xs" >位置</span>
 				<span id="address" class="m-r-md font_weight" ng-bind="address"></span>
 				<span class="m-r-xs">设备厂商</span>
 				<span id="manufid" class="m-r-md font_weight" ng-bind="manufid"></span>
 				<span class="m-r-xs">产品型号</span>
 				<span id="productid" class="m-r-md font_weight" ng-bind="productid"></span>
 			
		 	</div>
	     </div>
	     <span class="pull-left col-sm-12 m-t-xs">主要参数:</span>
	     <span class="pull-left col-sm-12" id="mainparameter" ng-bind="mainparameter"></span>
	     <br>
	     <br>
<!-- 	     <span class="pull-left">检修工艺卡:</span> -->
<!-- 	     <span class="pull-left"  id="repaircard" ng-bind="repaircard"></span> -->
 		<div class="hb_info wrapper col-sm-12">
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
            </div>
          </li>
        </ul>
	    

		<div class="wrapper-sm col-sm-12 no-border-xs" >
				<tabset class="nav-tabs-alt nav-tabs-power2" justified="true" id="widthFlag">
				<tab ng-click="onSelectPage(1)"> 
				<tab-heading class="wrapper-sm" > 
				<span id="deviceInfo" class="white-1 a-cur-poi" >实时数据</span>
				<span class="white-1 a-cur-poi"></span>
					 </tab-heading>
					 <div class="col-sm-6 text-center m-t">
					 </div>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				
					<div id="response_respStatus3" class="alert alert-danger" role="alert" style="display:none;">未接收到任何数据。请等待...</div>
					<div id="response_respStatusnull3" style="display: none;"
					class="alert alert-danger" role="alert">返回数据异常！</div>
					<div id="comm_interruptDev3" 	class="alert alert-danger" role="alert" style="display:none;" >
						通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于<span
							ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
					</div>
					<div id="comm_initDev3"  class="alert alert-info" role="alert" style="display:none;">设备初始化，未接收到任何数据。请等待...</div>
					
				   <div style="width: 98%;margin: 0 auto;height: 25px;line-height: 25px">
				  <div id="statusDescHidden" class="hidden"></div>
				     <div align="left">
				    
				           <font class="font-h3 black-2 line_height_25">当前状态</font>&nbsp;&nbsp;&nbsp;
						   <font class="font-h3 black-1 line_height_25" ng-bind="rtData.statusDesc"></font>&nbsp;&nbsp;&nbsp;
				           <font class="font-h3 black-2" style="line-height: 25px" >A相温度</font>&nbsp;&nbsp;&nbsp;
				           <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="rtData.ta|number:1"></span></font>&nbsp;&nbsp;&nbsp;℃&nbsp;&nbsp;&nbsp;
				       
				           <font class="font-h3 black-2" style="line-height: 25px">B相温度</font>&nbsp;&nbsp;&nbsp;
				           <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="rtData.tb|number:1"></span></font>&nbsp;&nbsp;&nbsp;℃&nbsp;&nbsp;&nbsp;
				       
				           <font class="font-h3 black-2" style="line-height: 25px">C相温度</font>&nbsp;&nbsp;&nbsp;
				           <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="rtData.tc|number:1"></span></font>&nbsp;&nbsp;&nbsp;℃&nbsp;&nbsp;&nbsp;
			          	   	<span class="pull-right">
				          	   <font class="font-h3 black-2" style="line-height: 25px"></font>&nbsp;&nbsp;&nbsp;
					           <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></font>&nbsp;&nbsp;&nbsp;
			          		</span>
			           </div>
				   </div>
				   <br>
				   <div style="width: 98%;margin: 0 auto;height: 350px;">
			
			<table id="result_table" class="table table-striped b-light table-boder" >
					<thead>
					<tr>
					<th></th>
					<th>有功功率(kW)</th>
					<th>无功功率(kVar)</th>
					<th>电流(A)</th>
					<th>电压(V)</th>
					</tr>
					</thead>
					
					<tbody>
						<tr>
							<td class="v-middle " >1A</td>
							<td class="v-middle " ng-bind="rtData.pa1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.qa1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.ca1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.ua1 | number:2"></td>
						</tr>
						<tr>
							<td class="v-middle " >1B</td>
							<td class="v-middle " ng-bind="rtData.pb1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.qb1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.cb1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.ub1 | number:2"></td>
						</tr>
						<tr>
							<td class="v-middle " >1C</td>
							<td class="v-middle " ng-bind="rtData.pc1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.qc1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.cc1 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.uc1 | number:2"></td>
						</tr>
						<tr>
							<td class="v-middle " >2A</td>
							<td class="v-middle " ng-bind="rtData.pa2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.qa2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.ca2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.ua2 | number:2"></td>
						</tr>
						<tr>
							<td class="v-middle " >2B</td>
							<td class="v-middle " ng-bind="rtData.pb2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.qb2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.cb2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.ub2 | number:2"></td>
						</tr>
							<tr>
							<td class="v-middle " >2C</td>
							<td class="v-middle " ng-bind="rtData.pc2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.qc2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.cc2 | number:2"></td>
							<td class="v-middle " ng-bind="rtData.uc2 | number:2"></td>
						</tr>
					</tbody>
					</table>
				 
				   </div>
				</div>
				</tab> 
				
				
				<tab ng-controller="boxChangepageHistory" ng-click="changeViewNotHistorySearchbc()"> 
					<tab-heading class="wrapper-sm" >
						<span id="historyInfobc22" class="white-1 a-cur-poi"  >历史信息</span>
						<span class="white-1 a-cur-poi" id="pageHistory"></span> 
					</tab-heading>
					<paging class="col-sm-12 panel no-padder m-b-none">
						<div class="col-sm-12 no-padder m-t">
							<div class="col-sm-6">
								<div class="input-group " style="width: 400px;">
									<input type="text" id="begindate" name="begindate" ng-model="begindate" class="form-control">
					         	<span class="input-group-addon">至</span>
					         		<input type="text" id="enddate" name="enddate"  ng-model="enddate" class="form-control">
					      		 <span class="input-group-btn padder-l-sm ">
					         		<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
					         	</span>
					         	<span class="input-group-btn padder-l-sm ">
					         	<button class=" btn btn-sm btn-info" ng-click="exportData();" type="button">导出</button>
					         	</span>
					      		</div>
						    </div>
							<!-- 分页 -->
							<div class="col-sm-6 pull-right"><%@ include file="/common/pager.jsp"%></div>
						</div>
				 		<div class="col-sm-12 no-padder " id="deviceDatas">
				 			<div class="col-sm-12 no-padder" id="loadingDiv"></div>
							<div class="col-sm-12 no-padder" ng-grid="boxChangeGridOptions" id="box_change_result_table" style="height: 350px;width: 100%" ></div>
						</div>
						</paging>
				</tab>
			
				<tab ng-controller="faultAlarmBC" ng-click="changeViewNotSearchFault()"> 
					<tab-heading class="wrapper-sm">
						<span id="faultalarmInfo" class="white-1 a-cur-poi" >故障信息</span>
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
					
					<tab ng-controller="repairtBC" ng-click="onSelectPage(1)"> 
						<tab-heading class="wrapper-sm">
							<span id="repairtInfo" class="white-1 a-cur-poi" >检修维护</span>
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
					
					<tab ng-controller="experimentBC" ng-click="onSelectPage(1)"> 
						<tab-heading class="wrapper-sm">
							<span id="experimentInfo" class="white-1 a-cur-poi" >技术监督</span>
							<span class="white-1 a-cur-poi" id="experimentTile" ng-bind="experimentTile" ></span> 
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
					
					<tab ng-controller="replacedBC" ng-click="onSelectPage(1)"> 
						<tab-heading class="wrapper-sm">
							<span id="replacedInfo" class="white-1 a-cur-poi" >技术改造</span>
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
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript">
$(".modal-backdrop").css("display","none")
var tab=0;
var bcfirstFlag = 0;

//定义各种状态的对应图片
var jbStatusArray=new Array("run.png","close.png","unknow.png");
var arresterStatusArray=new Array("blzRun.png","blzFault.png","blzUnknow.png");

//TODO:静态加载
//$(function() {
//	require.config({
//		paths : {
//			echarts : 'vendor/echarts'
//		}
//	});
//});

$("#box_change_result_table").css("height", $(window).height() -220);
$("#box_change_result_table").css("width", $("widthFlag").width);
var junction;
var junction2;
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
				$("#comm_interruptDev3").show();
				$("#comm_initDev3").hide();
				$("#response_respStatus3").hide();
				$("#response_respStatusnull3").hide();
				$scope.commCount = 0;
				$scope.commnullCount = 0;
			} else if (msg.comm == 2) {
				$("#comm_initDev3").show();
				$("#comm_interruptDev3").hide();
				$("#response_respStatus3").hide();
				$("#response_respStatusnull3").hide();
				$scope.commCount = 0;
				$scope.commnullCount = 0;
			} else if (msg.comm == null) {
				$scope.commCount = 0;
				$scope.commnullCount++;
				if(commnullCount > 3){
					$("#comm_initDev3").hide();
					$("#comm_interruptDev3").hide();
					$("#response_respStatus3").hide();
					$("#response_respStatusnull3").show();	
				}
			} else {
				$scope.commCount = 0;
				$scope.commnullCount = 0;
				$("#comm_interruptDev3").hide();
				$("#comm_initDev3").hide();
				$("#response_respStatus3").hide();
				$("#response_respStatusnull3").hide();
			}
		}).error(function(msg){
			$scope.commnullCount = 0;
			$scope.commCount++;
			if ($scope.commCount > 3){
				$("#response_respStatus3").show();
				$("#comm_interruptDev3").hide();
				$("#comm_initDev3").hide();
				$("#response_respStatusnull3").hide();
			}
		});
	};
	$scope.getstaDayData();
	var flag=0;
	if($stateParams.sizeFlag==1){
		$(".girdWidth").css("width","100%")
		$(".ngGrid").css("width","100%")
	}
	$scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
		$("#box_change_result_table").css("height", $(window).height() - 230);
		    $scope.serialnumber = deviceById.deviceSerialNnumber
			$scope.pstationid = deviceById.pstationid
			$scope.InId = deviceById.deviceId
			
			$stateParams.InId = deviceById.deviceId
			$stateParams.pstationid = deviceById.pstationid
			if(deviceById.dStartTime != null && deviceById.dStartTime != ""){
				$stateParams.dstarttime = deviceById.dStartTime;
			    var eventTime =new Date($stateParams.dstarttime).Format("yyyy-MM-dd hh:mm:ss");
			    $scope.eventDesc = "(事件发生时间:" + eventTime + ")";
				
			}
			getRtDataBC($scope, $stateParams,$http);
			getHours($scope, $stateParams,$http);
			$scope.onSelectPage(1);
            var hashUrl = location.hash;
            var hashArr = hashUrl.split("/");
            var lastHash = hashArr[hashArr.length-1];
            if(lastHash != "RtmDeviceLayout"){
			    angular.element("#historyInfobc22").trigger("click");
            }

	});
	$scope.serialnumber = $stateParams.serialnumber;
	$scope.pstationid = $stateParams.pstationid;
	$scope.InId = $stateParams.InId;
	
	//设备信息
	$scope.onSelectPage = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/BboxChange/bboxChangeCount.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				'param' : $stateParams.InId
			},
			timeout: 10000
		}).success(function(result) {
			$scope.boxchangename=result.bboxChange.name;
			$scope.boxchangeid=result.bboxChange.stationname;
			$scope.pstationid=result.bboxChange.pstationid;
			$scope.address=result.bboxChange.address;
			$scope.inverterroom=result.bboxChange.inverterroom;
			$scope.invertergid=result.bboxChange.invertergid;
			$scope.manufid=result.bboxChange.manufname;
			$scope.productid=result.bboxChange.productname;
			$scope.mainparameter=result.bboxChange.mainparameter;
			$scope.repaircard=result.bboxChange.repaircard;
			$scope.faultalarmTitle="("+result.faultalarm+")";
			$scope.repairtTitle="("+result.repairt+")";
			$scope.experimentTile="("+result.experiment+")";
			$scope.replacedTitle="("+result.replaced+")";
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求箱变信息数据超时!');
// 			}else{
// 				promptObj('error','','请求箱变信息数据出错!');
// 			}
		});
		
		
	};
	initTableConfig($scope);
	if($stateParams.InId){
		$scope.onSelectPage(1);	
	}

	//历史信息 deviceStation_parameterlishi
	app.controller('boxChangepageHistory', function($scope, $http, $state,$stateParams) {
		$scope.boxChangeGridOptions = {
				data : 'deviceData',
				enablePinning : true,
				enableCellSelection : true,
				columnDefs : [
						{
							field : 'dtime',
							displayName : '时间',
							width : 120,
							pinned : true,
							cellClass : 'text-center',
							cellTemplate :'<span  class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
						},{
							field : 'pa1',
							displayName : '绕组1A相有功功率(kW)',
							width : 150,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'pb1',
							displayName : '绕组1B相有功功率(kW)',
							width : 150,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'pc1',
							displayName : '绕组1C相有功功率(kW)',
							width : 150,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'qa1',
							displayName : '绕组1A相无功功率(kVar)',
							width : 160,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'qb1',
							displayName : '绕组1B相无功功率(kVar)',
							width : 160,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'qc1',
							displayName : '绕组1C相无功功率(kVar)',
							width : 160,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'ca1',
							displayName : '绕组1A相电流(A)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'cb1',
							displayName : '绕组1B相电流(A)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'cc1',
							displayName : '绕组1C相电流(A)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'ua1',
							displayName : '绕组1A相电压(V)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'ub1',
							displayName : '绕组1B相电压(V)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'uc1',
							displayName : '绕组1C相电压(V)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'f1',
							displayName : '绕组1频率(Hz)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'pf1',
							displayName : '绕组1功率因数',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'w1',
							displayName : '绕组1电量(kWh)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'pa2',
							displayName : '绕组2A相有功功率(kW)',
							width : 150,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'pb2',
							displayName : '绕组2B相有功功率(kW)',
							width : 150,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'pc2',
							displayName : '绕组2C相有功功率(kW)',
							width : 150,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'qa2',
							displayName : '绕组2A相无功功率(kVar)',
							width : 160,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'qb2',
							displayName : '绕组2B相无功功率(kVar)',
							width : 160,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'qc2',
							displayName : '绕组2C相无功功率(kVar)',
							width : 160,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'ca2',
							displayName : '绕组2A相电流(A)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'cb2',
							displayName : '绕组2B相电流(A)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'cc2',
							displayName : '绕组2C相电流(A)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'ua2',
							displayName : '绕组2A相电压(V)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'ub2',
							displayName : '绕组2B相电压(V)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'uc2',
							displayName : '绕组2C相电压(V)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						},{
							field : 'f2',
							displayName : '绕组2频率(Hz)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'pf2',
							displayName : '绕组2功率因数',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'w2',
							displayName : '绕组2电量(kWh)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'ta',
							displayName : 'A相温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'tb',
							displayName : 'B相温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'tc',
							displayName : 'C相温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 't',
							displayName : '温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} ]
			};
		
		//历史数据
		initTableConfig($scope);

		$scope.onSelectPage  = function(page) {
			function startDate(date){
				var newdate=new Date(date-24*60*60*1000);
				var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
				return startTime;
			}
			function endDate(date){
				var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
				return endTime;
			}
			//$("#begindate").val(startDate(new Date()));
			//$("#enddate").val(endDate(new Date()));
			if(flag==0){
				$('#begindate').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				}).on('changeDate', function(ev){
					$("#enddate").val($('#begindate').val());
				    $('#enddate').datetimepicker('setStartDate', $('#begindate').val()).datetimepicker('update').datetimepicker('show');
				});	
				$('#enddate').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				});
				
				if($stateParams.dstarttime == null || $stateParams.dstarttime == ""){
					$("#begindate").val(startDate(new Date()- 5*60*1000));
					$("#enddate").val(endDate(new Date()- 5*60*1000));
					$scope.begindate = $("#begindate").val();
					$scope.enddate = $("#enddate").val();
				}else{
					var newdate=new Date($stateParams.dstarttime-15*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					var newenddate = (new Date).getTime();
					if(newenddate > ($stateParams.dstarttime + 15*60*1000)){
						newenddate = $stateParams.dstarttime + 15*60*1000;
					}
					var endTime= new Date(newenddate).Format("yyyy-MM-dd hh:mm");
					$("#begindate").val(startTime);
					$("#enddate").val(endTime);
					$scope.begindate = $("#begindate").val();
					$scope.enddate = $("#enddate").val();
				}
				//$("#boxChange-table").css("height", $(window).height() - 265);
				//$(".result_table").css("width", $("#deviceDatas").width);
				//alert($("#boxChange-table").css("height"));
				flag++;
				
				
				}
			
			CommonPerson.Base.LoadingPic.PartShow('loadingDiv');//加载状态
			$("#box_change_result_table").hide();
			if(page==0){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				//url : "${ctx}/HistoryData/getHsData.htm",
				url : "${ctx}/HistoryData/getNewHistoryData.htm",
				params : {
					'pageIndex' : page,
					'pageSize' : $scope.pageSizeSelect,
					'devicetype':3,
					'begindate':$scope.begindate,
					'enddate':$scope.enddate,
					'stationid':$scope.pstationid,
					"serialnumber" : $scope.serialnumber,
					"id" : $stateParams.InId
				}
//	 			,timeout: 5000
			}).success(function(result) {
				partHide('loadingDiv');
				getPaginationDatas($scope,result[0]);
				$("#box_change_result_table").show();
			}).error(function(response) {
//	 			if(response==null){

//	 				promptObj('error','','请求箱变历史信息数据超时!');
//	 			}else{
//	 				promptObj('error','','请求箱变历史信息数据出错!');
//	 			}
			});
			
		
		
		};
		
		$scope.changeViewNotHistorySearchbc = function() {
			if(bcfirstFlag == 0){
				$scope.onSelectPage(1);
				bcfirstFlag++;
			}else{
				$("#box_change_result_table").show();
			}
		}
		
		$scope.exportData = function(){
			CommonPerson.Base.LoadingPic.FullScreenShow("数据导出中，请稍后...");
			var url = "${ctx}/HistoryData/exportHsData.htm";
			url +='?stationid='+$scope.pstationid;
			url +='&serialnumber='+$scope.serialnumber;
			url +='&devicetype='+3;
			url +='&begindate='+$scope.begindate;
			url +='&enddate='+$scope.enddate;
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
	app.controller('faultAlarmBC', function($scope, $http, $state,$stateParams) {
		var firstFlagFault = 0;
		$scope.changeViewNotSearchFault = function() {
			$scope.onSelectPage(1);
		}
		
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
				deviceType :3
			},
			timeout: 10000
		}).success(function(result) {
//			$scope.breakdown=result.data
			getTableData($scope,result);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求箱变故障信息数据超时!');
// 			}else{
// 				promptObj('error','','请求箱变故障信息数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
/* 	$scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
		if(tag==3){
			$scope.serialnumber = deviceById.deviceSerialNnumber
			$scope.pstationid = deviceById.pstationid
			$scope.InId = deviceById.id
			getRtData($scope, $stateParams,$http);
			getHours($scope, $stateParams,$http);
			$scope.onSelectPage(1);
			angular.element("#faultalarmInfo").trigger("click");
		}
		}); */
	});
	
	
	//检修维护
	app.controller('repairtBC', function($scope, $http, $state,$stateParams) {
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
// 			if(response==null){
// 				promptObj('error','','请求箱变检修维护数据超时!');
// 			}else{
// 				promptObj('error','','请求箱变检修维护数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	/* $scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
		if(tag==4){
			$scope.serialnumber = deviceById.deviceSerialNnumber
			$scope.pstationid = deviceById.pstationid
			$scope.InId = deviceById.id
			getRtData($scope, $stateParams,$http);
			getHours($scope, $stateParams,$http);
			$scope.onSelectPage(1);
			angular.element("#repairtInfo").trigger("click");
		}
		}); */
	});
	
	
	//技术监督
	app.controller('experimentBC', function($scope, $http, $state,$stateParams) {
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
// 			if(response==null){
// 				promptObj('error','','请求箱变技术监督数据超时!');
// 			}else{
// 				promptObj('error','','请求箱变技术监督数据出错!');
// 			}
		});
		};
		initTableConfig($scope);
/* 		$scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
			if(tag==5){
				$scope.serialnumber = deviceById.deviceSerialNnumber
				$scope.pstationid = deviceById.pstationid
				$scope.InId = deviceById.id
				getRtData($scope, $stateParams,$http);
				getHours($scope, $stateParams,$http);
				$scope.onSelectPage(1);
				angular.element("#experimentInfo").trigger("click");
			}
		}); */
	});
	
	
	//技术改造
	app.controller('replacedBC', function($scope, $http, $state,$stateParams) {
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
// 				"id": $stateParams.InId,
// 				"deviceid": $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
			$scope.reform=result.data
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求箱变技术改造数据超时!');
// 			}else{
// 				promptObj('error','','请求箱变技术改造数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
/* 	$scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
		if(tag==6){
			$scope.serialnumber = deviceById.deviceSerialNnumber
			$scope.pstationid = deviceById.pstationid
			$scope.InId = deviceById.id
			getRtData($scope, $stateParams,$http);
			getHours($scope, $stateParams,$http);
			$scope.onSelectPage(1);
			angular.element("#replacedInfo").trigger("click");
		}
	}); */
	});
	if($stateParams.InId){
		getHours($scope, $stateParams,$http);
		getRtDataBC($scope, $stateParams,$http);
	}
	junction=setInterval(function(){
		if($stateParams.InId){
			getRtDataBC($scope, $stateParams,$http);
			$scope.getstaDayData();
		}
		
	},5000);
	junction2=setInterval(function(){
		getHours($scope, $stateParams,$http);
	},60000);
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(junction);
		clearInterval(junction2);
	});
});

//实时数据
function getRtDataBC($scope, $stateParams,$http){
	$http.get("${ctx}/DeviceStation/getSingleRealDataBBoxChange.htm", {
		params : {
			id : $stateParams.InId,
			serialnumber:$scope.serialnumber,
			pstationid : $scope.pstationid
		},
		timeout: 5000
	}).success(function(result) {
		if(result.respStatus==1){
			$scope.serialnumber = result.data.did;
			$scope.pstationid =result.data.sid;
			$scope.rtData=result.data;
			if(result.data.comm==1||result.data.comm==2){
				$("#statusDescHidden").removeClass("hidden")				
			}
			$scope.millisecond=result.data.dtime*1000;
		}
	}).error(function(response) {
// 		if(response==null){
// 			promptObj('error','','请求箱变实时数据超时!');
// 		}else{
// 			promptObj('error','','请求箱变实时数据出错!');
// 		}
	});
}
//小时数数据
function getHours($scope, $stateParams,$http){
	$http.get("${ctx}/BboxChange/getBoxChangeHours.htm", {
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
</script>
