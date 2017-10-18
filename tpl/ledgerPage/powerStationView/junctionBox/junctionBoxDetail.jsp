<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>

<div ng-controller="JunctionBoxMonitorCtrl">
	<div class="bg-light lter b-b padder-v padding-b-10 height_70">
		<span class="font-h3 blue-1 m-n text-black wrapper ng-binding" ng-bind="name"></span>
	</div>
	     <div class="hb_parame b-b wrapper">
	    	 <div class="col-sm-12">
		 		<span class="m-r-xs">所属逆变器</span>
		 		<span id="boxchangeid" class="m-r-md font_weight a-cur-poi href-blur" ng-bind="boxchangename" ng-click="toinverter(invertergid);"></span>
 				<span class="m-r-xs" >位置</span>
 				<span id="address" class="m-r-md font_weight" ng-bind="address"></span>
 				<span class="m-r-xs">设备厂商</span>
 				<span id="manufid" class="m-r-md font_weight" ng-bind="manufid"></span>
 				<span class="m-r-xs">产品型号</span>
 				<span id="productid" class="m-r-md font_weight" ng-bind="productid"></span>
 				<a><span  class="m-r-xs col-sm-28 pull-right" onclick="switchInfo()">查看更多信息</span></a>
		 	</div>
	     </div>
	     <div class="hb_info wrapper" id="moreInfo">
	  	 <span class="pull-left">主要参数:</span>
	     <span class="pull-left" ng-bind="mainparameter"></span>
	     <br>
	     <br>
	     <span class="pull-left">检修工艺卡:</span>
	     <span class="pull-left" ng-bind="repaircard"></span>
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

		<div class="wrapper-sm no-border-xs">
				<tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
				<!-- 故障发生开始 --> 
				<tab> 
				<tab-heading> 
				<span class="wrapper-sm white-1 a-cur-poi" ng-click="onSelectPageBjunction(1)"> 设备信息 </span>
					 </tab-heading>
					 <div class="col-sm-6 text-center m-t">
					 </div>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				   <div style="width: 98%;margin: 0 auto;height: 25px;line-height: 25px">
				   <font class="font-h3 black-2" style="line-height: 25px">开关状态</font>&nbsp;&nbsp;&nbsp;
				   <img id="jbStatusImg" alt="" src="${ctx}/theme/images/junctionBoxMonitor/run.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px" ng-bind="junctionBoxMonitorData.kStr">开启</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h3 black-2" style="line-height: 25px">避雷针状态</font>&nbsp;&nbsp;&nbsp;
				   <img id="arresterStatusImg" alt="" src="${ctx}/theme/images/junctionBoxMonitor/blzRun.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="junctionBoxMonitorData.arresterStr"></span></font>&nbsp;&nbsp;&nbsp;
				   	<span class="pull-right">
	          	   		<font class="font-h3 black-2" style="line-height: 25px"></font>&nbsp;&nbsp;&nbsp;
		           		<font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="junctionBoxMonitorData.millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></font>&nbsp;&nbsp;&nbsp;
          			</span>
				  
				   </div>
				   <div style="width: 98%;margin: 0 auto;height: 350px;">
				   <div id="junctionBox1" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="junctionBox2" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div id="junctionBox3" style="height: 350px;width: 33.3%;float: left;"></div>
				   <div style="width: 100%;height: 300px;float: left;margin-top: -100px">
				   <font class="font-h3 black-2" >&nbsp;光伏组串电流(A)</font>
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
				
				
				<tab ng-controller="junctionpageHistory"> 
					<tab-heading class="wrapper-sm">
						<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">历史信息</span>
						<span class="white-1 a-cur-poi" id="pageHistory"></span> 
					</tab-heading>
				<paging class="col-sm-12 panel no-padder m-b-none">
				<div class="col-sm-12 text-center m-t m-b no-padder">
			<div class="col-sm-9">
			<div class="input-group " style="width: 350px;">
			<input type="text" id="begindate" name="begindate" ng-model="begindate" class="form-control">
         	<span class="input-group-addon">至</span>
         	<input type="text" id="enddate" name="enddate"  ng-model="enddate" class="form-control">
      		 <span class="input-group-btn padder-l-sm ">
         	<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
         	</span>
      		</div>
		    </div>
					     </div>
<div class="row">
	<div class="col-sm-12 pull-right">
		<!-- 分页 -->
		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
	</div>
</div>	
				 		<div class="col-sm-12 no-padder " id="deviceDatas">
				 		<div class="col-sm-12 no-padder" id="loadingDiv"></div>
							<div class="col-sm-12 no-padder"  ng-grid="junctionBoxGridOptions" id="junction_box_result_table" style="height: 350px;" ></div>
						</div>
						</paging>
				</tab>
				
				<tab ng-controller="faultAlarm"> 
					<tab-heading class="wrapper-sm">
						<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">故障信息</span>
						<span class="white-1 a-cur-poi" id="faultalarmTitle" ng-bind="faultalarmTitle" ></span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					 	<paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
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
					
					<tab ng-controller="repairt"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">检修维护</span>
							<span class="white-1 a-cur-poi" id="repairtTitle" ng-bind="repairtTitle" ></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
						<paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
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
					
					<tab ng-controller="experiment"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">技术监督</span>
							<span class="white-1 a-cur-poi" id="experimentTile" ng-bind="experimentTile"></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					  <paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
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
					
					<tab ng-controller="replaced"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">技术改造</span>
							<span class="white-1 a-cur-poi" id="replacedTitle" ng-bind="replacedTitle"></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					 <paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
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
<script type="text/javascript">
var tab=0;
$("#moreInfo").hide();
function switchInfo(){
	if(tab==0){
		tab=1;
		$("#moreInfo").show();
	}else{
		tab=0;
		$("#moreInfo").hide();
	}
}

//定义各种状态的对应图片
var jbStatusArray=new Array("close.png","run.png","unknow.png");
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
$("#junction_box_result_table").css("height", $(window).height() - 430);
$("#junction_box_result_table").css("width", $("#deviceDatas").width);
var junction;
var junctionV;
var junctionA;
var junctionP;
var junction2;
app.controller('JunctionBoxMonitorCtrl', function($scope, $http, $state,$stateParams) {
	$scope.toinverter = function(id) {
		$state.go("app.inverterDetail", {
			InId : id,
		});
	}
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
				"param" : $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
// 			alert(JSON.stringify(result))
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
// 			if(response==null){
// 				promptObj('error','','请求汇流箱信息数据超时!');
// 			}else{
// 				promptObj('error','','请求汇流箱信息数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	$scope.onSelectPage(1);	
	
	//历史信息
	app.controller('junctionpageHistory', function($scope, $http, $state,$stateParams) {
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
							cellClass : 'text-center',
							cellTemplate :'<span ng-if="row.getProperty(\'dtime\')!=null"><span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span></span> '
						}, {
							field : 'k',
							displayName : '开关',
							width : 60,
							pinned : true,
							cellClass : 'text-center',
							cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'k\')==\'0\'">无效</span> <span'+
							' ng-if="row.getProperty(\'k\')==\'1\'">无效</span> <span'+
							' ng-if="row.getProperty(\'k\')==\'2\'">闭合</span> <span'+
							' ng-if="row.getProperty(\'k\')==\'3\'">开启</span></span> '
						}, {
							field : 'arrester',
							displayName : '避雷器',
							width : 60,
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
		var flag=0;
		$scope.initHs = function(){
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
				function startDate(date){
					var newdate=new Date(date-24*60*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					return startTime;
				}
				function endDate(date){
					var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
					return endTime;
				}
				$("#begindate").val(startDate(new Date()));
				$("#enddate").val(endDate(new Date()));
				$scope.begindate = $("#begindate").val();
				$scope.enddate = $("#enddate").val();
			//$("#boxChange-table").css("height", $(window).height() - 265);
			//$(".result_table").css("width", $("#deviceDatas").width);
			//alert($("#boxChange-table").css("height"));
			flag++;
			}
		}
	var flag=0;	
	initTableConfig($scope);
	$scope.onSelectPage  = function(page) {
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
				function startDate(date){
					var newdate=new Date(date-24*60*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					return startTime;
				}
				function endDate(date){
					var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
					return endTime;
				}
				$("#begindate").val(startDate(new Date()));
				$("#enddate").val(endDate(new Date()));
				$scope.begindate = $("#begindate").val();
				$scope.enddate = $("#enddate").val();
			//$("#boxChange-table").css("height", $(window).height() - 265);
			//$(".result_table").css("width", $("#deviceDatas").width);
			//alert($("#boxChange-table").css("height"));
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
			//url : "${ctx}/HistoryData/getHsData.htm",
			url : "${ctx}/HistoryData/getNewHistoryData.htm",
			params : {
				'pageIndex' : page ,
				'pageSize' : $scope.pageSizeSelect,
				'devicetype':1,
				'begindate':$scope.begindate,
				'enddate':$scope.enddate,
				'stationid':$scope.pstationid,
				"serialnumber" : $scope.serialnumber,
				"id" : $stateParams.InId
			}
// 			,timeout: 5000
		}).success(function(result) {
			getPaginationDatas($scope,result[0]);
			partHide('loadingDiv');
			$("#junction_box_result_table").show();
//				breakdown(result.data);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求汇流箱历史信息数据超时!');
// 			}else{
// 				promptObj('error','','请求汇流箱历史信息数据出错!');
// 			}
		});
		};
	});
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
	app.controller('faultAlarm', function($scope, $http, $state,$stateParams) {
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
			timeout: 5000
		}).success(function(result) {
			getTableData($scope,result);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求汇流箱故障信息数据超时!');
// 			}else{
// 				promptObj('error','','请求汇流箱故障信息数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	});
	
	
	//检修维护
	app.controller('repairt', function($scope, $http, $state,$stateParams) {
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
// 				promptObj('error','','请求汇流箱检修维护数据超时!');
// 			}else{
// 				promptObj('error','','请求汇流箱检修维护数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	});
	
	
	//技术监督
	app.controller('experiment', function($scope, $http, $state,$stateParams) {
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
// 				promptObj('error','','请求汇流箱技术监督数据超时!');
// 			}else{
// 				promptObj('error','','请求汇流箱技术监督数据出错!');
// 			}
		});
		};
		initTableConfig($scope);
	});
	
	
	//技术改造
	app.controller('replaced', function($scope, $http, $state,$stateParams) {
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
// 				promptObj('error','','请求技术改造数据超时!');
// 			}else{
// 				promptObj('error','','请求技术改造数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	});
	
	
	$scope.serialnumber = $stateParams.serialnumber;
	$scope.pstationid = $stateParams.pstationid;
	refreshdata($scope, $stateParams,$http,0);
	getHours($scope, $stateParams,$http);
	junction=setInterval(function(){
		refreshdata($scope, $stateParams,$http,1);
	},5000);
	junction2=setInterval(function(){
		getHours($scope, $stateParams,$http);
	},60000);
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(junction);
		clearInterval(junction2);
		clearInterval(junctionV);
		clearInterval(junctionA);
		clearInterval(junctionP);
	});
});
//实时数据
function refreshdata($scope, $stateParams,$http,flag){
	$http.get("${ctx}/BjunctionStanding/getJunctionBoxRtData.htm", {
		params : {
			id : $stateParams.InId,
			serialnumber : $scope.serialnumber,
			pstationid : $scope.pstationid
		},
		timeout: 5000
	}).success(function(response) {
		if(response.respStatus==1){
		$scope.serialnumber = response.serialnumber;
		$scope.pstationid = response.pstationid;
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.jbStatus!=response.jbStatus){
			$("#jbStatusImg").attr('src','${ctx}/theme/images/junctionBoxMonitor/'+jbStatusArray[response.jbStatus]);
		}
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.blzStatus!=response.blzStatus){
			$("#arresterStatusImg").attr('src','${ctx}/theme/images/junctionBoxMonitor/'+arresterStatusArray[response.arresterStatus]);
		}
		if(flag==0){
			getScoreV(1,response.u,'电压(V)',1000,$scope);
			getScoreA(2,response.c,'电流(A)',200,$scope);
			getScoreP(3,response.p,'功率(kW)',200,$scope);
		}
// 		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.u!=response.u){
// 			getScoreV(1,response.u,'电压(V)',1000);
// 		}
// 		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.c!=response.c){
// 			getScoreA(2,response.c,'电流(A)',200);
// 		}
// 		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.p!=response.p){
// 			getScoreP(3,response.p,'功率(kW)',200);
// 		}
		$scope.junctionBoxMonitorData = response;
		}
	}).error(function(response) {
// 		if(response==null){
// 			promptObj('error','','请求汇流箱数据超时!');
// 		}else{
// 			promptObj('error','','请求汇流箱数据出错!');
// 		}
	});
}
//小时数数据
function getHours($scope, $stateParams,$http){
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
	var myChart;
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
	myChart = ec.init(document.getElementById('junctionBox'+j));
	var option = {
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
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dataValue.toFixed(1), name: dataName}]
		        }
		    ]
		};
    myChart.setOption(option,true);
	window.onresize = myChart.resize;
	junctionV=setInterval(function(){
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.u!=null){
			option.series[0].data[0].value=$scope.junctionBoxMonitorData.u.toFixed(1);
			myChart.setOption(option,true);
		}
	},5000);
});
}
//电流
function getScoreA(j,dataValue,dataName,max,$scope){
	var myChart;
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
	myChart = ec.init(document.getElementById('junctionBox'+j));
	var option = {
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
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dataValue.toFixed(2), name: dataName}]
		        }
		    ]
		};
    myChart.setOption(option,true);
	window.onresize = myChart.resize;
	junctionA=setInterval(function(){
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.c!=null){
			option.series[0].data[0].value=$scope.junctionBoxMonitorData.c.toFixed(2);
			myChart.setOption(option,true);
		}
	},5000);
});
}
//功率
function getScoreP(j,dataValue,dataName,max,$scope){
	var myChart;
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
	myChart = ec.init(document.getElementById('junctionBox'+j));
	var option = {
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
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dataValue.toFixed(1), name: dataName}]
		        }
		    ]
		};
    myChart.setOption(option,true);
	window.onresize = myChart.resize;
	junctionP=setInterval(function(){
		if($scope.junctionBoxMonitorData==null||$scope.junctionBoxMonitorData.p!=null){
			option.series[0].data[0].value=$scope.junctionBoxMonitorData.p.toFixed(1);
			myChart.setOption(option,true);
		}
	},5000);
});
}
</script>
