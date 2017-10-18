<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<div ng-controller="JunctionBoxMonitorCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" ng-bind="name"></span>
	</div>
	     <div class="hb_parame b-b wrapper">
	    	 <div class="col-sm-12">
		 		<span class="m-r-xs">所属电站</span>
		 		<span id="boxchangeid" class="m-r-md font_weight" ng-bind="boxchangeid"></span>
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
		
		<div class="wrapper-sm   no-border-xs">
				<tabset class="nav-tabs-alt nav-tabs-power" justified="true">
				<!-- 故障发生开始 --> 
				<tab>
				<tab-heading> 
				<span class="wrapper-sm white-1 a-cur-poi" ng-click="onSelectPage(1)">设备信息 </span>
					 </tab-heading>
					 <div class="col-sm-6 text-center m-t">
					 </div>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				  <div style="width: 98%;margin: 0 auto;height: 25px;line-height: 25px">
				  
				     <div align="left">
				          <span class="pull-right">
				          	   <font class="font-h3 black-2" style="line-height: 25px"></font>&nbsp;&nbsp;&nbsp;
					           <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></font>&nbsp;&nbsp;&nbsp;
			          		</span>
			           </div>
				   </div>
			
				   <div style="width: 98%;margin: 0 auto;height: 350px;">
			
			<table id="result_table" class="table table-striped b-light table-boder" >
			<tr>
			<th><span class="pull-right" style="color: #1caf9a;">水平面光照强度瞬时值</span></th>
					<td class="v-middle "><span ng-bind="lh|number:2"></span>W/㎡</td>
			<th><span class="pull-right" style="color: #1caf9a;">水平面光照日累计</span></th>
			<td class="v-middle "><span ng-bind="lhd|number:2"></span>kWh</td>	
			<th><span class="pull-right" style="color: #1caf9a;">组件温度</span></th>
					<td class="v-middle "><span  ng-bind="tm|number:2"></span>℃</td>
			<th><span class="pull-right" style="color: #1caf9a;">风向</span></th>
					<td class="v-middle "><span  ng-bind="wd|number:2"></span>°</td>
			</tr>
			
			<tr>
			<th><span class="pull-right" style="color: #1caf9a;">散射光照强度瞬时值</span></th>
					<td class="v-middle "><span  ng-bind="ls|number:2"></span>W/㎡</td>
			<th><span class="pull-right" style="color: #1caf9a;">散射光照日累计</span></th>
					<td class="v-middle "><span  ng-bind="lsd|number:2"></span>kWh</td>
			<th><span class="pull-right" style="color: #1caf9a;">环境温度</span></th>
					<td class="v-middle "><span  ng-bind="ta|number:2"></span>℃</td>
			<th><span class="pull-right" style="color: #1caf9a;">风速</span></th>
					<td class="v-middle "><span  ng-bind="ws|number:2"></span>m/s</td>
			</tr>
			
			<tr>
			<th><span class="pull-right" style="color: #1caf9a;">斜面光照强度瞬时值</span></th>
					<td class="v-middle "><span  ng-bind="la|number:2"></span>W/㎡</td>
			<th><span class="pull-right" style="color: #1caf9a;">斜面光照日累计</span></th>
					<td class="v-middle "><span  ng-bind="lad|number:2"></span>kWh</td>
			<th><span class="pull-right" style="color: #1caf9a;">湿度</span></th>
					<td class="v-middle "><span ng-bind="h2o|number:1"></span><span>%</span></td>
			<th><span class="pull-right" style="color: #1caf9a;">气压</span></th>
					<td class="v-middle "><span  ng-bind="p|number:2"></span>kPa</td>
			</tr>
					</table>
				   </div>
				</div>
				</tab> <!-- 故障发生结束 -->				
				<tab ng-controller="otherpageHistory"> 
					<tab-heading class="wrapper-sm">
						<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">历史信息</span>
						<span class="white-1 a-cur-poi" id="pageHistory" ></span> 
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
							<div class="col-sm-12 no-padder"  ng-grid="weatherGridOptions" id="weather_result_table" style="height: 350px;" ></div>
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
							<span class="white-1 a-cur-poi" id="experimentTile" ng-bind="experimentTile" ></span> 
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

$("#weather_result_table").css("height", $(window).height() - 425);
$("#weather_result_table").css("width", $("#deviceDatas").width);

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
var weatherTimer;
var weatherTimer1;
app.controller('JunctionBoxMonitorCtrl', function($scope, $http, $state,$stateParams) {
	$scope.serialnumber = $stateParams.serialnumber;
	$scope.pstationid = $stateParams.pstationid;
	
	//设备信息	
	$scope.onSelectPage = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/OtherDevice/otherdeviceCount.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"param" : $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
// 			alert(JSON.stringify(result))
			$scope.name=result.otherDevice.name;
			$scope.boxchangeid=result.otherDevice.stationname;
			$scope.address=result.otherDevice.address;
			$scope.inverterroom=result.otherDevice.inverterroom;
			$scope.invertergid=result.otherDevice.invertergid;
			$scope.manufid=result.otherDevice.manufname;
			$scope.productid=result.otherDevice.productname;
			$scope.mainparameter=result.otherDevice.mainparameter;
			$scope.repaircard=result.otherDevice.repaircard;
			$scope.faultalarmTitle="("+result.faultalarm+")";
			$scope.repairtTitle="("+result.repairt+")";
			$scope.experimentTile="("+result.experiment+")";
			$scope.replacedTitle="("+result.replaced+")";
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求气象仪数据超时!');
// 			}else{
// 				promptObj('error','','请求气象仪数据出错!');
// 			}
		});
	};
	
	//历史信息
	app.controller('otherpageHistory', function($scope, $http, $state,$stateParams) {
		$scope.weatherGridOptions = {
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
							field : 'lh',
							displayName : '水平面光照强度瞬时值(W/㎡)',
							width : 180,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'ls',
							displayName : '散射光照强度瞬时值(W/㎡)',
							width : 180,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'la',
							displayName : '斜面光照强度瞬时值(W/㎡)',
							width : 180,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'lhd',
							displayName : '水平面光照日累计(kWh)',
							width : 180,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'lsd',
							displayName : '散射光照日累计(kWh)',
							width : 180,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'lad',
							displayName : '斜面光照日累计(kWh)',
							width : 180,
							pinned : true,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'tm',
							displayName : '组件温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'ta',
							displayName : '环境温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'ws',
							displayName : '风速(m/s)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'wd',
							displayName : '风向(°)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} , {
							field : 'h2o',
							displayName : '湿度(5)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'h2o\')*100|number:2"></span> '
						} , {
							field : 'p',
							displayName : '气压(kPa)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}  ]
			};
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
		$("#weather_result_table").hide();
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
				'devicetype':5,
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
			$("#weather_result_table").show();
//				breakdown(result.data);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求气象仪历史数据超时!');
// 			}else{
// 				promptObj('error','','请求气象仪历史数据出错!');
// 			}
		});
		}
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
				deviceType :5
			},
			timeout: 5000
		}).success(function(result) {
			getTableData($scope,result);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求气象仪故障信息数据超时!');
// 			}else{
// 				promptObj('error','','请求气象仪故障信息数据出错!');
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
// 				promptObj('error','','请求气象仪检修维护数据超时!');
// 			}else{
// 				promptObj('error','','请求气象仪检修维护数据出错!');
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
// 				promptObj('error','','请求气象仪技术监督数据超时!');
// 			}else{
// 				promptObj('error','','请求气象仪技术监督数据出错!');
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
// 				promptObj('error','','请求气象仪技术改造数据超时!');
// 			}else{
// 				promptObj('error','','请求气象仪技术改造数据出错!');
// 			}
		});
	};
	});

	initTableConfig($scope);
	$scope.onSelectPage(1);	
	getHours($scope, $stateParams,$http);
	getRtData($scope, $stateParams,$http);
	weatherTimer=setInterval(function(){
		getRtData($scope, $stateParams,$http);
	},5000);
	weatherTimer1=setInterval(function(){
		getHours($scope, $stateParams,$http);
	},60000);
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(weatherTimer);
		clearInterval(weatherTimer1);
	});
});
//实时数据
function getRtData($scope, $stateParams,$http){

	
}
//小时数数据
function getHours($scope, $stateParams,$http){
	$http.get("${ctx}/OtherDevice/getWeatherHours.htm", {
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
