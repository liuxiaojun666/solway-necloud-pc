<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<style>
	.nav > .pos-stc > a:hover, .nav > .pos-stc > a:focus {
	    background-color: transparent;
    }
    .word-grey{color:#989898;}
    .per5-1{width:20%;}
    .blue-square{display:inline-block;background:#a8d1f0;width:180px;height:45px;line-height:45px;text-align:center;}
    .modal-body {overflow-y:hidden !important;}
</style>
<div ng-controller="inverterMonitorCtrl" >
		<div class="bg-light col-sm-12 lter padder-l-sm padder-v padding-b-10 " style="padding-bottom:0px">
		  <div class="col-sm-6 no-padder">
		 	 <span class="font-h3 blue-1 m-n text-black" ng-bind="inverterName"></span>
		 	 <span class="font-h3 blue-1 m-n text-black" ng-bind="eventDesc"></span>
		  </div>
	</div>
	<ul class="nav navbar-nav hidden-sm col-sm-12 no-padder" style="margin-top:-45px;">
          <li class="dropdown pos-stc pull-right" dropdown>
            <a href class="dropdown-toggle " dropdown-toggle style="padding: 25px 30px 0px 0px;">
              <span >查看更多信息</span> 
              <span class="caret"></span>
            </a>
            <div class="dropdown-menu  w-full bg-white">
				<div class=" no-padder col-sm-12" id="moreInfo">
	     <div class="hb_parame b-b wrapper">
	    	 <div class="col-sm-12 no-padder">
		 		<span class="m-r-xs">所属箱变</span>
		 		<span id="boxchangeid" class="m-r-md font_weight" ng-class="{'a-cur-poi href-blur' : messageFlag != 1}" ng-bind="boxname" ng-click="toBoxChange(boxchangeid);"></span>
 				<span class="m-r-xs" >位置</span>
 				<span id="address" class="m-r-md font_weight" ng-bind="address"></span>
 				<span class="m-r-xs">逆变器室</span>
 				<span id="inverterroom" class="m-r-md font_weight" ng-bind="inverterroom"></span>
 				<span class="m-r-xs">逆变器组</span>
 				<span id="invertergid" class="m-r-md font_weight" ng-bind="invertergid"></span>
 				<span class="m-r-xs">设备厂商</span>
 				<span id="manufid" class="m-r-md font_weight" ng-bind="manufid"></span>
 				<span class="m-r-xs">产品型号</span>
 				<span id="productid" class="m-r-md font_weight" ng-bind="productid"></span>
 				
		 	</div>
	     </div>
	     <div class="wrapper">
	     <span class="pull-left">主要参数:</span>
	     <span class="pull-left" ng-bind="mainparameter"></span>
	     <span class="m-l">检修工艺卡:</span>
	     <span class="m-l-xs" ng-bind="repaircard"></span>
	     <div class="hb_info col-sm-12 m-t">
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
		 
            </div>
          </li>
        </ul>

	<div class="wrapper-sm col-sm-12  no-border-xs">
		<tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
			<!-- 故障发生开始 --> 
			<tab  ng-click="onSelectPage(1)" class="judgeTabClassInv"> 
				<tab-heading> <span class="wrapper-sm white-1 a-cur-poi" id="deviceInfo">实时数据</span></tab-heading>
				<!-- <div ng-include="intervalDetailPage"></div> -->
				<div ng-show="inverterType != 1" ng-include="'${ctx}/tpl/ledgerPage/inverter/model/inverterRealtimeData.jsp'"></div>
				<div ng-show="inverterType == 1" ng-include="'${ctx}/tpl/ledgerPage/inverter/model/inverterRealtimeDataHasString.jsp'"></div>
			</tab>
			
			<!-- 故障发生结束 -->
				
			<tab  ng-controller="inverpageHistory" active = "defaultTabInv" class="judgeTabClassInv" ng-click="changeViewNotSearch()"> 
				<tab-heading class="wrapper-sm white-1">
					<span id="historyInfoinv"  class="white-1 a-cur-poi">历史数据</span>
					<span class="white-1 a-cur-poi" id="pageHistory"></span> 
				</tab-heading>
			<paging class="col-sm-12 panel no-padder m-b-none">
				<div class="col-sm-12 text-center m-t m-b no-padder">
					<div class="col-sm-6">
						<div class="input-group " style="width: 400px;">
							<input type="text" id="begindatePublicInv" name="begindatePublicInv"
								ng-model="begindatePublicInv" class="form-control"> <span
								class="input-group-addon">至</span> <input type="text"
								id="enddatePublicInv" name="enddatePublicInv"
								ng-model="enddatePublicInv" class="form-control"> <span
								class="input-group-btn padder-l-sm ">
								<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)"
									type="button">查询</button>
							</span> <span class="input-group-btn padder-l-sm ">
								<button class=" btn btn-sm btn-info" ng-click="exportData();"
									type="button">导出</button>
							</span>
						</div>
					</div>
					<!-- 分页 -->
					<div class="col-sm-6 pull-right"><%@ include
							file="/common/pager.jsp"%></div>
				</div>
				<div ng-include="showModelDivInvHistory" ></div>
				</paging>
			</tab>
			
			
			<tab  ng-controller="faultAlarmInv" ng-click="changeViewNotSearchFault()" class="judgeTabClassInv"> 
			<tab-heading class="wrapper-sm">
				<span class="white-1 a-cur-poi">故障信息</span>
				<span class="white-1 a-cur-poi" id="faultalarmTitle" ng-bind="faultalarmTitle"></span> 
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
			
			<tab ng-controller="repairtInv" ng-click="onSelectPage(1)" class="judgeTabClassInv"> 
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
			
			<tab ng-controller="experimentInv" ng-click="onSelectPage(1)" class="judgeTabClassInv"> 
				<tab-heading class="wrapper-sm">
					<span class="white-1 a-cur-poi" >技术监督</span>
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
			
			<tab ng-controller="replacedInv" ng-click="onSelectPage(1)" class="judgeTabClassInv"> 
				<tab-heading class="wrapper-sm">
					<span class="white-1 a-cur-poi" >技术改造</span>
					<span class="white-1 a-cur-poi" id="replacedTitle" ng-bind="replacedTitle" ></span> 
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
<script src="${ctx}/theme/js/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/checkSelected.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>

<script type="text/javascript">
$(".modal-backdrop").css("display","none")
//$("#inverter_result_table").css("height", $(window).height() - 240);
//$("#inverter_result_table").css("width", $("#deviceDatas").width);

var code;
var buildnum=0;
var acp;
var inverterTimer;
var inverterTimer2;
var inverterTimerDCU;
var inverterTimerDCC;
var inverterTimerDCP;
var inverterTimerACU;
var inverterTimerACC;
var inverterTimerACP;

var invfirstFlag= 0;
var invfirstFlagForHS = 0;
app.controller('inverterMonitorCtrl', function($scope, $http, $state, $stateParams) {
	//判断实时数据标签详情页
	function judgeRealtimePage(){
		if($scope.inverterType != 1){
			$scope.intervalDetailPage = '${ctx}/tpl/ledgerPage/inverter/model/inverterRealtimeData.jsp';
		}else if($scope.inverterType == 1){
			$scope.intervalDetailPage = '${ctx}/tpl/ledgerPage/inverter/model/inverterRealtimeDataHasString.jsp';
			refreshdata1($scope, $stateParams,$http,0);
		}
	}
	//获取逆变器带组串的详情页信息数据
	function refreshdata1($scope, $stateParams,$http,flag){
		$http.get("${ctx}/DeviceStation/getSingleRealDataBJunction.htm", {
			params : {
				id : $stateParams.InId,
				serialnumber : $stateParams.serialnumber,
				pstationid : $stateParams.pstationid
			},
			timeout: 5000
		}).success(function(response) {
			if(flag==0){
				$scope.junctionBoxMonitorData = response.data;
			}
		}).error(function(response) {
		});
	}
	
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
				$("#comm_interruptDev2").show();
				$("#comm_initDev2").hide();
				$("#response_respStatus2").hide();
				$("#response_respStatusnull2").hide();
				$scope.commCount = 0;
				$scope.commnullCount = 0;
			} else if (msg.comm == 2) {
				$("#comm_initDev2").show();
				$("#comm_interruptDev2").hide();
				$("#response_respStatus2").hide();
				$("#response_respStatusnull2").hide();
				$scope.commCount = 0;
				$scope.commnullCount = 0;
			} else if (msg.comm == null) {
				$scope.commCount = 0;
				$scope.commnullCount++;
				if($scope.commnullCount > 3){
					$("#comm_initDev2").hide();
					$("#comm_interruptDev2").hide();
					$("#response_respStatus2").hide();
					$("#response_respStatusnull2").show();	
				}
				
			} else {
				$scope.commCount = 0;
				$scope.commnullCount = 0;
				$("#comm_interruptDev2").hide();
				$("#comm_initDev2").hide();
				$("#response_respStatus2").hide();
				$("#response_respStatusnull2").hide();
			}
		}).error(function(msg){
			$scope.commnullCount = 0;
			$scope.commCount++;
			if ($scope.commCount > 3){
				$("#response_respStatus2").show();
				$("#comm_interruptDev2").hide();
				$("#comm_initDev2").hide();
				$("#response_respStatusnull2").hide();
			}
		});
	};
	$scope.getstaDayData();
	var flag=0;	
	$scope.messageFlag=0;
	$scope.$on('deviceStation_parameter', function(event,deviceById,tag) {
		$scope.serialnumber = deviceById.deviceSerialNnumber;
		$scope.pstationid = deviceById.pstationid;
		$scope.InId = deviceById.deviceId;

		$stateParams.InId = deviceById.deviceId;
		$stateParams.pstationid = deviceById.pstationid;
		$stateParams.serialnumber = deviceById.deviceSerialNnumber;
		
		//judgeRealtimePage();
		
		if(deviceById.dStartTime != null && deviceById.dStartTime != ""){
			$stateParams.dstarttime = deviceById.dStartTime;
			var eventTime =new Date($stateParams.dstarttime).Format("yyyy-MM-dd hh:mm:ss");
			 $scope.eventDesc = "(事件发生时间:" + eventTime + ")";
		}

		$scope.messageFlag=1;
		$scope.onSelectPage(1);
		getRtDataInv($scope, $stateParams,$http,0);
		getHoursInverter($scope, $stateParams,$http);		
        var hashUrl = location.hash;
        var hashArr = hashUrl.split("/");
        var lastHash = hashArr[hashArr.length-1];
        if(lastHash != "RtmDeviceLayout"){
            angular.element("#historyInfoinv").trigger("click");
        }
	});
	
	$scope.$on('showDeviceDetail2broad', function(event,deviceById) {		
		$scope.serialnumber = deviceById.deviceSerialNnumber;
		$scope.pstationid = deviceById.pstationid;
		$scope.InId = deviceById.deviceId;

		$stateParams.InId = deviceById.deviceId;
		$stateParams.pstationid = deviceById.pstationid;
		$stateParams.serialnumber = deviceById.deviceSerialNnumber;
		//judgeRealtimePage();
		
		if(deviceById.dStartTime != null && deviceById.dStartTime != ""){
			$stateParams.dstarttime = deviceById.dStartTime;
			var eventTime =new Date($stateParams.dstarttime).Format("yyyy-MM-dd hh:mm:ss");
			 $scope.eventDesc = "(事件发生时间:" + eventTime + ")";
		}
		
		$scope.messageFlag=1;
		$scope.onSelectPage(1);
		getRtDataInv($scope, $stateParams,$http,0);
		getHoursInverter($scope, $stateParams,$http);
		
		$scope.commnullCount = 0;
		$scope.commCount = 0;
		$scope.getstaDayData();
		
		var tabNum=0;
        //是否第一次打开该页面,如果是需要判断默认显示的页面
        invfirstFlagForHS = 0;
	     if(invfirstFlag++ == 0 && deviceById.defaultShowPage == 2){
	    	 //如果默认显示历史数据页面
	    	 $scope.defaultTabInv = true;
	    	 $scope.$broadcast('toTabsInv',2);
	     }else{
	    	 $(".judgeTabClassInv").each(function(index){
	         	tabNum++;
	         	if($(this).hasClass("active")){
	         		$scope.$broadcast('toTabsInv',tabNum);
	         	}
	         	
	         });
	     }
        
	});
	
	/**$scope.$on('changeDeviceTypeNowNull', function(event,deviceById) {
		$scope.deviceTypeNow = "-1";
	});*/
	
	inverterTimer=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			getRtDataInv($scope, $stateParams,$http,1);
			$scope.getstaDayData();
		}
		
	}, 5000);
	/**inverterTimer2=setInterval(function(){
		getHours($scope, $stateParams,$http);
	}, 60000);*/
	
	//设备信息	
	$scope.onSelectPage = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/InverterStanding/inverterCount.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"param" : $stateParams.InId
			},
			timeout: 5000
		}).success(function(result) {
// 			alert(JSON.stringify(result));
			$scope.pstationid=result.inverter.pstationid
			$scope.boxchangeid=result.inverter.boxchangeid;
			$scope.inverterName=result.inverter.name;
			$scope.boxname=result.inverter.boxname;
			$scope.address=result.inverter.address;
			$scope.inverterroom=result.inverter.inverterroom;
			$scope.invertergid=result.inverter.invertergid;
			$scope.manufid=result.inverter.manufname;
			$scope.productid=result.inverter.productname;
			$scope.mainparameter=result.inverter.mainparameter;
			$scope.repaircard=result.inverter.repaircard;
			buildnum=$scope.buildcapacity=result.inverter.realcapacity==null?0: result.inverter.realcapacity;
			$scope.faultalarmTitle="("+result.faultalarm+")";
			$scope.repairtTitle="("+result.repairt+")";
			$scope.experimentTile="("+result.experiment+")";
			$scope.replacedTitle="("+result.replaced+")";
		}).error(function(response) {
		});
	};
	
	
	//历史信息
	app.controller('inverpageHistory', function($scope, $http, $state,$stateParams) {
		$scope.inverterGridOptions = {
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
							cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
						},{
							field : 'dcu',
							displayName : 'DC电压(V)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'dcc',
							displayName : 'DC电流(A)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'dcp',
							displayName : 'DC功率(kW)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'acu',
							displayName : 'AC电压(V)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'acc',
							displayName : 'AC电流(A)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'acp',
							displayName : 'AC功率(kW)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 't',
							displayName : '温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'ef',
							displayName : '效率(%)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'ef\')*100|number:2"></span> '
						}, {
							field : 'f',
							displayName : '频率(Hz)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'pf',
							displayName : '功率因数',
							width : 90,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'dw',
							displayName : '日发电量(kWh)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'tw',
							displayName : '总发电量(kWh)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'c1',
							displayName : '1',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),0)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),0) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c2',
							displayName : '2',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),1)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),1) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c3',
							displayName : '3',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),2)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),2) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c4',
							displayName : '4',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),3)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),3) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c5',
							displayName : '5',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),4)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),4) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c6',
							displayName : '6',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),5)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),5) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c7',
							displayName : '7',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),6)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),6) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c8',
							displayName : '8',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),7)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),7) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c9',
							displayName : '9',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),8)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),8) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c10',
							displayName : '10',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),9)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),9) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c11',
							displayName : '11',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),10)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),10) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c12',
							displayName : '12',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),11)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),11) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c13',
							displayName : '13',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),12)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),12) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c14',
							displayName : '14',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),13)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),13) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c15',
							displayName : '15',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),14)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),14) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c16',
							displayName : '16',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),15)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),15) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c17',
							displayName : '17',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),16)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),16) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c18',
							displayName : '18',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),17)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),17) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c19',
							displayName : '19',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),18)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),18) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}, {
							field : 'c20',
							displayName : '20',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :
								'<div class="ngCellText"><span ng-if="getStrmIsValid(row.getProperty(\'strm\'),19)== \'0\'" class="handle3">'+
								'<span> - </span></span>'+
								'<span ng-if="getStrmIsValid(row.getProperty(\'strm\'),19) !=\'0\'" >'+
								'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span></div>'
						}  ]
			};
	
	
	$scope.$on('toTabsInv', function(event,tabNum) {
		if(tabNum == 2){
			$scope.changeViewNotSearch();
		}
	});
	
	$scope.getStrmIsValid= function (strm , num) {
		if(strm){
        	return strm & (1 << num);
		}else{
			return 0;
		}
	}
	
	$scope.changeViewNotSearch = function() {
		$scope.showModelDivInvHistory="${ctx}/tpl/ledgerPage/inverter/inverterHistoryData.jsp";
		if(invfirstFlagForHS == 0){
			$scope.onSelectPage(1);
			invfirstFlagForHS++;
		}else{
			$("#box_change_result_table").show();
		}
	}
	initTableConfig($scope);
	$scope.onSelectPage  = function(page) {
			if(flag==0){
				$('#begindatePublicInv').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				}).on('changeDate', function(ev){
					$("#enddatePublicInv").val($('#begindatePublicInv').val());
				    $('#enddatePublicInv').datetimepicker('setStartDate', $('#begindatePublicInv').val()).datetimepicker('update').datetimepicker('show');
				});	
				$('#enddatePublicInv').datetimepicker({
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
					$("#begindatePublicInv").val(startDate(new Date() - 5*60*1000));
					$("#enddatePublicInv").val(endDate(new Date() - 5*60*1000));
					$scope.begindatePublicInv = $("#begindatePublicInv").val();
					$scope.enddatePublicInv = $("#enddatePublicInv").val();
				}else{
					var newdate=new Date($stateParams.dstarttime-15*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					var newenddate = (new Date).getTime();
					if(newenddate > ($stateParams.dstarttime + 15*60*1000)){
						newenddate = $stateParams.dstarttime + 15*60*1000;
					}
					var endTime= new Date(newenddate).Format("yyyy-MM-dd hh:mm");
					$("#begindatePublicInv").val(startTime);
					$("#enddatePublicInv").val(endTime);
					$scope.begindatePublicInv = $("#begindatePublicInv").val();
					$scope.enddatePublicInv = $("#enddatePublicInv").val();
				}
				flag++;
			}
		CommonPerson.Base.LoadingPic.PartShow('loadingDivInv');//加载状态
		$("#inverter_result_table").hide();
		if (page == 0) {
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
				'devicetype':2,
				'begindate':$scope.begindatePublicInv,
				'enddate':$scope.enddatePublicInv,
				'stationid':$scope.pstationid,
				'serialnumber': $scope.serialnumber,
				'id' : $stateParams.InId
			}
		}).success(function(result) {
			partHide('loadingDivInv');
			getPaginationDatas($scope,result[0]);
			$("#inverter_result_table").show();
		}).error(function(response) {
		});
		};
		
		
		$scope.exportData = function(){
			CommonPerson.Base.LoadingPic.FullScreenShow("数据导出中，请稍后...");
			var url = "${ctx}/HistoryData/exportHsData.htm";
			url +='?stationid='+$scope.pstationid;
			url +='&serialnumber='+$scope.serialnumber;
			url +='&devicetype='+2;
			url +='&begindate='+$scope.begindatePublicInv;
			url +='&enddate='+$scope.enddatePublicInv;
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
	app.controller('faultAlarmInv', function($scope, $http, $state,$stateParams) {
		var firstFlagFault = 0;
		$scope.changeViewNotSearchFault = function() {
				$scope.onSelectPage(1);
		}
		
		$scope.$on('toTabsInv', function(event,tabNum) {
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
					deviceType :2
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
	app.controller('repairtInv', function($scope, $http, $state,$stateParams) {
		
		$scope.$on('toTabsInv', function(event,tabNum) {
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
	app.controller('experimentInv', function($scope, $http, $state,$stateParams) {
		$scope.$on('toTabsInv', function(event,tabNum) {
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
	app.controller('replacedInv', function($scope, $http, $state,$stateParams) {
		$scope.$on('toTabsInv', function(event,tabNum) {
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
	
	$scope.toBoxChange = function(id,serialnumber,pstationid) {
		if($scope.messageFlag != 1){
			$state.go("app.BoxChangeDetail", {
				InId : id,
				sizeFlag:1
			});
		}
		
	};
	
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(inverterTimer);
		clearInterval(inverterTimer2);
		clearInterval(inverterTimerDCU);
		clearInterval(inverterTimerDCC);
		clearInterval(inverterTimerDCP);
		clearInterval(inverterTimerACU);
		clearInterval(inverterTimerACC);
		clearInterval(inverterTimerACP);
		
	});
});
//实时数据
function getRtDataInv($scope, $stateParams,$http,flag){
	$http.get("${ctx}/DeviceStation/getSingleRealDataBInverter.htm", {
		params : {
			id : $stateParams.InId,
			serialnumber:$scope.serialnumber,
			pstationid : $scope.pstationid
		},
		timeout: 5000
	}).success(function(response) {
		if(response.respStatus==1){
			$scope.serialnumber = response.data.did;
			$scope.pstationid =response.data.sid;
			$scope.dw=response.data.dw[0];
			$scope.tw=response.data.tw[0];
			$scope.dwUnit=response.data.dw[1];
			$scope.twUnit=response.data.tw[1];
			if(response.data.dtime){
				$scope.millisecond=response.data.dtime*1000;//数据时间
			}else{
				$scope.millisecond = 0;
			}
			$scope.inverterMonitorData = response.data;
			acp=$scope.inverterMonitorData.acp;
			numToFixed($scope.inverterType);
			if(flag==0){
				var acuid = 'interveracuStr';
				var accid = 'interveraccStr';
				var acpid = 'interveracpStr';
				
				var ucp = getAVWMaxValueData($scope.inverterType,$scope.inverterMonitorData.acc_kw,$scope.inverterMonitorData.acu);
				
				if($scope.inverterType != 1){
					acuid = 'interveracu';
					accid = 'interveracc';
					acpid = 'interveracp';
					getDCU($scope.inverterMonitorData.dcu,$scope,ucp[3]);
					getDCC($scope.inverterMonitorData.dcc,$scope,ucp[4]);
					getDCP($scope.inverterMonitorData.dcp,$scope,ucp[5]);
				}
				
				getACU($scope.inverterMonitorData.acu,$scope,acuid,ucp[0]);
				getACC($scope.inverterMonitorData.acc,$scope,accid,ucp[1]);
				getACP($scope.inverterMonitorData.acp,$scope,acpid,ucp[2]);
			}
		}
	}).error(function(response) {
	});
}
//小时数数据
function getHoursInverter($scope, $stateParams,$http){
	$http.get("${ctx}/InverterStanding/getInverterHours.htm", {
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
function getDCU(dcu,$scope,ucp){
	var myChart = echarts.init(document.getElementById('interverdcu'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a}  : {c}V"
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
		            center : ['50%','60%'],
		            endAngle:0,
		            max:ucp["A3"],
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[ucp["A1"], '#228b22'],[ucp["A2"], '#48b'],[1, '#ff4500']], 
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
		                    fontSize : 20
		                },
		                offsetCenter: [0, '15%'],
		   			 height: -30
		            },
		            data:[{value: dcu, name: 'DC电压(V)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	window.onresize = myChart.resize;
	inverterTimerDCU=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.dcu!=null){
				option.series[0].data[0].value=$scope.inverterMonitorData.dcu.toFixed(1);
				myChart.setOption(option,true);
			}
		}
	},5000);
}


function getDCC(dcc,$scope,ucp){
		
	var myChart = echarts.init(document.getElementById('interverdcc'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a}  : {c}A"
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
		            max:ucp["A3"],
		            type:'gauge',
		            startAngle:180,
		            radius: 120,
		            center : ['50%','60%'],
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[ucp["A1"], '#228b22'],[ucp["A2"], '#48b'],[1, '#ff4500']], 
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
		                    fontSize : 20
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: dcc, name: 'DC电流(A)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	window.onresize = myChart.resize;
	inverterTimerDCC=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.dcc!=null){
				option.series[0].data[0].value=$scope.inverterMonitorData.dcc.toFixed(1);
				myChart.setOption(option,true);
			}
		}
	},5000);
//});
}

function getDCP(dcp,$scope,ucp){
		
	var myChart = echarts.init(document.getElementById('interverdcp'));

  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a}  : {c}kW"
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
		            max:ucp["A3"],
		            type:'gauge',
		            radius: 120,
		            center : ['50%','60%'],
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[ucp["A1"], '#228b22'],[ucp["A2"], '#48b'],[1, '#ff4500']], 
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
		                    fontSize : 20
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: dcp, name: 'DC功率(kW)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	window.onresize = myChart.resize;
	inverterTimerDCP=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.dcp!=null){
				option.series[0].data[0].value=$scope.inverterMonitorData.dcp.toFixed(1);
				//option.series[0].max=parseInt(buildnum*1.2/10)*10+10;
				myChart.setOption(option,true);
			}
			
		}
	},5000);
}
//得到仪表盘电压电流功率最大值以及各区间段
function getAVWMaxValueData(hasJB,instkw,currentV){
	var reList = [];
	var reMap1 = {};
	var reMap2 = {};
	var reMap3 = {};
	//交流电压
	reMap1["A1"] = (220/400);
	reMap1["A2"] = (380/400);
	reMap1["A3"] = 400;
	//交流功率
	reMap2["A1"] = 0.1;
	reMap2["A3"] = Math.ceil(instkw * 1.1);
	//保证被10整除
	if((reMap2["A3"]%10) > 0){
		reMap2["A3"] = reMap2["A3"] + (10-reMap2["A3"]%10)
	}
	reMap2["A2"] = (instkw/reMap2["A3"]);
	//交流电流
	var ACPmax;
	if(currentV && currentV > 300){
		ACPmax = Math.ceil(reMap2["A3"]*1000/380);
	}else{
		ACPmax = Math.ceil(reMap2["A3"]*1000/220);
	}
	//保证被10整除
	if((ACPmax%10) > 0){
		ACPmax = ACPmax + (10-ACPmax%10)
	}
	reMap3["A1"] = 0.1;
	reMap3["A2"] = 0.9;
	reMap3["A3"] = ACPmax;
	reList.push(reMap1);
	reList.push(reMap3);
	reList.push(reMap2);
	if(hasJB != '1'){
		var reMap4 = {};
		var reMap5 = {};
		var reMap6 = {};
		//直流电压
		reMap4["A1"] = (400/1000);
		reMap4["A2"] = (800/1000);
		reMap4["A3"] = 1000;
		
		//直流电流
		reMap5["A1"] = 0.1;
		reMap5["A2"] = 0.9;
		reMap5["A3"] = Math.ceil(instkw * 1000 / 700);
		//保证被10整除
		if((reMap5["A3"]%10) > 0){
			reMap5["A3"] = reMap5["A3"] + (10-reMap5["A3"]%10)
		}
		
		//直流功率
		reMap6["A1"] = reMap2["A1"];
		reMap6["A2"] = reMap2["A2"];
		reMap6["A3"] = reMap2["A3"];
		reList.push(reMap4);
		reList.push(reMap5);
		reList.push(reMap6);
	}
	
	return reList;
}

function getACU(acu,$scope,acid,ucp){
	var myChart = echarts.init(document.getElementById(acid));
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a}  : {c}V"
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
		            radius: 120,
		            center : ['50%','60%'],
		            startAngle:180,
		            endAngle:0,
		            max:ucp["A3"],
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[ucp["A1"], '#228b22'],[ucp["A2"], '#48b'],[1, '#ff4500']], 
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
		                    fontSize : 20
		                },
		                offsetCenter: [0, '15%'],
		   				 height: -30
		            },
		            data:[{value: acu, name: 'AC电压(V)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	window.onresize = myChart.resize;
	inverterTimerACU=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.acu!=null){
				option.series[0].data[0].value=$scope.inverterMonitorData.acu.toFixed(1);
				myChart.setOption(option,true);
			}
			
		}
	},5000);
}


function getACC(acc,$scope,acid,ucp){
		
	var myChart = echarts.init(document.getElementById(acid));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a}  : {c}A"
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
		            max:ucp["A3"],
		            type:'gauge',
		            radius: 120,
		            center : ['50%','60%'],
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[ucp["A1"], '#228b22'],[ucp["A2"], '#48b'],[1, '#ff4500']], 
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
		                    fontSize : 20
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: acc, name: 'AC电流(A)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	window.onresize = myChart.resize;
	inverterTimerACC=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.acc!=null){
				option.series[0].data[0].value=$scope.inverterMonitorData.acc.toFixed(1);
				myChart.setOption(option,true);
			}
		}
			
	},5000);
}

function getACP(acp,$scope,acid,ucp){
		
	var myChart = echarts.init(document.getElementById(acid));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
			animation: false,
		    tooltip : {
		        formatter: "{a}  : {c}kW"
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
		            max:ucp["A3"],
		            type:'gauge',
		            radius: 120,
		            center : ['50%','60%'],
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[ucp["A1"], '#228b22'],[ucp["A2"], '#48b'],[1, '#ff4500']], 
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
		                    fontSize : 20
		                },
		                offsetCenter: [0, '15%'],
		    			height: -30
		            },
		            data:[{value: acp, name: 'AC功率(kW)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	window.onresize = myChart.resize;
	inverterTimerACP=setInterval(function(){
		if($scope.deviceTypeNow == '2'){
			if($scope.inverterMonitorData==null||$scope.inverterMonitorData.acp!=null){
				option.series[0].data[0].value=$scope.inverterMonitorData.acp.toFixed(1);
				//option.series[0].max=parseInt(acp*1.2/10)*10+10;
				myChart.setOption(option,true);
			}
			
		}
			
	},5000);
}


function dateFormat(date){
    var time = new Date(date).Format("yyyy-MM-dd HH:mm:ss"); 
    return time;
}
	var tab=0;

	function numToFixed(inverterType){
		if(buildnum!=0 && acp !=0){
			var number=(acp/buildnum)*100;
			var value=number.toFixed(1)+"%";
			if(inverterType == 1){
				$("#used1").html(value);	
			}else{
				$("#used").html(value);	
			}
		}else{
			if(inverterType == 1){
				$("#used1").html("0%");	
			}else{
				$("#used").html("0%");	
			}
		}
	}
</script>

