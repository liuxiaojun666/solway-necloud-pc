<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/array.extend.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<div ng-controller="historyData" >
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">历史数据查询</span> -->
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
				<div class="row wrapper">
					<div class="col-sm-1 " id="userType_Div">
						<ui-select ng-model="deviceTyped.selected" theme="bootstrap" ng-change="selectDevice()">
							<ui-select-match placeholder="请选择设备..." ng-model="deviceTyped.selected.devtype" >{{$select.selected.devtype}}</ui-select-match>
							<ui-select-choices  repeat="item in deviceTypeItem | filter: $select.search">
								<div ng-bind-html="item.devtype | highlight: $select.search"></div>
							</ui-select-choices>
						</ui-select>
						<input type="hidden" id="devid" name="devid" class="form-control formData">
					</div>
					<div class="col-sm-2  p-l-n">
			             <ui-select ng-model="deviced.selected" theme="bootstrap" ng-change="deviceChange()">
					          <ui-select-match placeholder="请选择设备..." ng-model="deviced.selected.name" >{{$select.selected.name}}</ui-select-match>
					          <ui-select-choices  repeat="item in device | filter: $select.search">
					              <div ng-bind-html="item.name | highlight: $select.search"></div>
					          </ui-select-choices>
				         </ui-select>
		               	 <input type="hidden" id="serialnumber" name="serialnumber" class="form-control formData">
		            </div>
					<div class="col-sm-5 p-l-n">
						<div class="input-group ">
							<input type="text" id="begindate" name="begindate" class="form-control">
							<span class="input-group-addon">至</span>
							<input type="text" id="enddate" name="enddate" class="form-control">
							 <span class="input-group-btn padder-l-sm ">
								<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button" id="historyData_select">查询</button>
							</span>
							<span class="input-group-btn padder-l-sm ">
								<button class=" btn btn-sm btn-info" ng-click="exportData();" type="button">导出</button>
							</span>
						</div>
				    </div>
				    <div class="col-sm-4  p-l-n">
				    	<%@ include file="/common/pager.jsp"%>
				    </div>
				</div>
			</paging>
		</div>
		<span  class="text-center data-red hidden col-sm-12" id="pointOut" style="position: relative;top: 100px;z-index: 99;">该查询无相关数据!</span>
		<div class="col-sm-12 b-t no-padder" id="deviceDatas">
			<div class="noSearchStat" style="border: 1px #dee5e7 solid;border-top: none;box-shadow: 0 1px 1px rgba(0, 0, 0, .05);"></div>
			<div class="col-sm-12 no-padder" id="loadingDiv"></div>
			<div ng-include="showModelDivBCHistory"></div>	
			<div ng-include="showModelDivJBHistory"></div>
			<div ng-include="showModelDivInvHistory"></div>
			<div ng-include="showModelDivWeatherHistory"></div>
			<div ng-include="showModelDivMeterHistory"></div>		
		</div>
	</div>
</div>
<div class="waterPlaceholder"></div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>

<script type="text/javascript">
//日期控件
$('#begindate').datetimepicker({
	format: "yyyy-mm-dd hh:ii",
	language: 'zh-CN',
	todayHighlight:true,
	todayBtn:true,
   	autoclose: true,
   	endDate:new Date()
}).on('changeDate', function(ev){
	if(Date.parse(ev.date)>Date.parse($("#enddate").val())){
		// $("#enddate").val(ev.date.Format("yyyy-MM-dd"));
		$("#enddate").val($('#begindate').val());
	};
    $('#enddate').datetimepicker('setStartDate', $('#begindate').val()).datetimepicker('update').datetimepicker('show');
});

//日期控件
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
$("#begindate").val(startDate(new Date() - 5*60*1000));
$("#enddate").val(endDate(new Date() - 5*60*1000));

var url={
		"url1":"${ctx}/HistoryData/getJunctionBox.htm",
		"url2":"${ctx}/HistoryData/getInverter.htm",
		"url3":"${ctx}/HistoryData/getBoxchange.htm",
		"url4":"${ctx}/HistoryData/getAmmeter.htm",
		"url5":"${ctx}/HistoryData/getAerograph.htm",
}
var selectDevice;
var onSelectPage;
app.controller('historyData', function($scope, $http, toaster, $state,$stateParams, $document) {
	$scope.getCurrentDataName('00',0);
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		$scope.getDeviceType();
		$scope.deviceData = null;
		initTableConfig($scope);
	});

	$document.on('screenfull.raw.fullscreenchange', function () {
		  if(responseHeight){responseHeight();};
	});
	$scope.refreshViewDataForHead = function () {
		var type = $scope.deviceType;
		$http({
			method : "POST",
			url : url["url"+type],
			params : {
			'pstationid': $("#pstationid").val(),
		},
		}).success(function(result) {
			$scope.device = result;
			if($scope.device.length>0){
				if($stateParams.deviceId){
					for(var i=0;i<$scope.device.length;i++){
						if($stateParams.deviceId == $scope.device[i].id){
							$scope.deviced.selected= { name: $scope.device[i].name,serialnumber:  $scope.device[i].serialnumber};
							break;
						}

					}
				}else {
					$scope.deviced.selected= {name: $scope.device[0].name,serialnumber:  $scope.device[0].serialnumber};
				}
			}else{
				$scope.deviced.selected.name = "";
			}
			$("#serialnumber").val(angular.copy($scope.deviced.selected.serialnumber));
			$scope.onSelectPage(1);

		})
	}
	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

		$scope.deviceTypeItem = null;
		$scope.deviceTyped = null;
		$scope.getDeviceType = function(){
			$http({
				method : "POST",
				url :"${ctx}/DeviceStation/getDeviceType.htm",
				params : {
					'stationid': $scope.stationListId
				}
			}).success(function (msg) {
				if (msg.key == "0"){
					$scope.deviceTypeItem = msg.data;
					$scope.deviceTyped = {};
					if ($scope.deviceTypeItem.length > 0){
						$("#devid").val(angular.copy($scope.deviceTypeItem[0].divid));
						$scope.deviceTyped.selected = {devid:$scope.deviceTypeItem[0].devid, devtype:$scope.deviceTypeItem[0].devtype};
						$scope.selectDevice();
					}
				}
			});
		};

		$scope.deviceType = null;
		//查询电站
		$scope.stationd = {};
		$scope.station = null;
		$scope.selectPower = function() {
			$http({
				method : "POST",
				url : "${ctx}/PowerStation/selectAll.htm",
				params : {
					'pstationid': $("#pstationid").val(),
				},
			}).success(function(result) {
				$scope.station = result;
				if($scope.station.length>0){
					console.log("$scope.deviceType:" + $scope.deviceType);
					$scope.getDeviceType();
				}
			})
		};

	 $scope.textChange= function () {
         $("#pstationid").val(angular.copy($scope.stationd.selected.id));
	}

	if($stateParams.deviceType){
		$("#deviceType").val($stateParams.deviceType);
		$scope.deviceType = $stateParams.deviceType;
	}else{
		$scope.deviceType = $("#deviceType").val();
	}

	$scope.deviced = {};
	$scope.device = null;
	//根据类型查询设备
	selectDevice = $scope.selectDevice = function(type){
		$scope.deviceType=angular.copy($scope.deviceTyped.selected.devid);
		$http({
			method : "POST",
			url : url["url"+$scope.deviceType],
			params : {
			'pstationid': $("#pstationid").val(),
		},
		}).success(function(result) {
			$scope.device = result;
			if($scope.device.length>0){
				if($stateParams.deviceId){
					for(var i=0;i<$scope.device.length;i++){
						if($stateParams.deviceId == $scope.device[i].id){
							$scope.deviced.selected= { name: $scope.device[i].name,serialnumber:  $scope.device[i].serialnumber};
							break;
						}

					}
				} else {
					$scope.deviced.selected= {name: $scope.device[0].name,serialnumber:  $scope.device[0].serialnumber};
				}
				$("#serialnumber").val(angular.copy($scope.deviced.selected.serialnumber));
			}
		})

	};
	$scope.deviceChange= function () {
         $("#serialnumber").val(angular.copy($scope.deviced.selected.serialnumber));
	}

	$scope.selectPower();
	initGridOptions($scope);
	initTableConfig($scope);
	//当前页
	$scope.currentPageOld = 0;
	//查询历史数据
	onSelectPage=$scope.onSelectPage = function(page){
		if(!$("#begindate").val()){
			toaster.pop('error','','请选择时间!');
			return false;
		}
		if(!$("#enddate").val()){
			toaster.pop('error','','请选择结束时间!');
			return false;
		}

		var begindate = Date.parse($("#begindate").val());
		var enddate = Date.parse($("#enddate").val());
		if(enddate<begindate){
			toaster.pop('error','','结束时间必须不能小于开始时间!');
			return false;
		}

		if( (enddate-begindate) > (7*24*3600*1000) ){
			toaster.pop('error','','查询时间不能超过7天!');
			return false;
		}
		var nowToday = new Date().Format("yyyy-MM-dd hh:mm:ss");
		if (enddate >= Date.parse(nowToday)) {
			toaster.pop('error','','结束时间不能超过当前时间!');
			return false;
		}

		$(".result_table").hide();
		$(".noSearchStat").hide();
		CommonPerson.Base.LoadingPic.PartShow('loadingDiv');//加载状态
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}
		if($scope.deviceType==3){
			$scope.showModelDivBCHistory="${ctx}/tpl/rtMonitorPage/historyData/boxChangeHistoryData.jsp";
		}else if($scope.deviceType==2){
			$scope.showModelDivInvHistory="${ctx}/tpl/rtMonitorPage/historyData/invHistoryData.jsp";
		}else if($scope.deviceType==1){
			$scope.showModelDivJBHistory="${ctx}/tpl/rtMonitorPage/historyData/junctionBoxHistoryData.jsp";
		}else if($scope.deviceType==5){
			$scope.showModelDivWeatherHistory="${ctx}/tpl/rtMonitorPage/historyData/weatherHistoryData.jsp";
		}else if($scope.deviceType==4){
			$scope.showModelDivMeterHistory="${ctx}/tpl/rtMonitorPage/historyData/meterHistoryData.jsp";
		}
		$("#pointOut").addClass("hidden");
		$http({
			method : "POST",
			//url : "${ctx}/HistoryData/getHsData.htm",
			url : "${ctx}/HistoryData/getNewHistoryData.htm",
			params : {
				'pageIndex' : page,
				'pageSize' : $scope.pageSizeSelect,
				'stationid': $("#pstationid").val(),
				'serialnumber':$("#serialnumber").val(),
				'devicetype':$scope.deviceType,
				'begindate':$("#begindate").val(),
				'enddate':$("#enddate").val()
			}
		}).success(function(result) {
			partHide('loadingDiv');
			if($scope.deviceType==3){
				$("#box_change_result_table").show();
			}else if($scope.deviceType==2){
				$("#inverter_result_table").show();
			}else if($scope.deviceType==1){
				$("#junction_box_result_table").show();
			}else if($scope.deviceType==5){
				$("#weather_result_table").show();
			}else if($scope.deviceType==4){
				$("#energy_meter_result_table").show();
			}
			getPaginationDatas($scope,result[0]);
			$(window).trigger('resize');
		})
	};
	//initData();
	function initData(){
	setTimeout('onSelectPage();',5000);
	}
	$scope.exportData = function(){
		CommonPerson.Base.LoadingPic.FullScreenShow("数据导出中，请稍后...");
		var stId = 0;
		if($("#pstationid").val()){
			stId = $("#pstationid").val();
		}
		var url = "${ctx}/HistoryData/exportHsData.htm";
		url +='?stationid='+stId;
		url +='&serialnumber='+$("#serialnumber").val();
		url +='&devicetype='+$scope.deviceType;
		url +='&begindate='+$("#begindate").val();
		url +='&enddate='+$("#enddate").val();
		window.location.href = url;
		getSessionValueByKey("ExportHistoryData");
	}
	
	$scope.getStrmIsValid= function (strm , num) {
		if(strm){
        	return strm & (1 << num);
		}else{
			return 0;
		}
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
function getPaginationDatas($scope,result){
	$scope.deviceData = result.data;
	if(result.data.length==0){
		$("#pointOut").removeClass("hidden");
	}else{
		$("#pointOut").addClass("hidden");
	}
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
function initGridOptions($scope){

	//箱变
	$scope.boxChangeGridOptions = {
			data : 'deviceData',
			enablePinning : true,
			enableCellSelection : true,
			columnDefs : [
					//  {
					// 	field : '',
					// 	displayName : '状态',
					// 	width : 60,
					// 	pinned : true,
					// 	cellClass : 'text-center'
					// },
					{
						field : 'dtime',
						displayName : '时间',
						width : 120,
						pinned : true,
						cellClass : 'text-center',
						cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
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
	//逆变器
	$scope.inverterGridOptions = {
			data : 'deviceData',
			enablePinning : true,
			enableCellSelection : true,
			columnDefs : [
					//  {
					// 	field : '',
					// 	displayName : '状态',
					// 	width : 60,
					// 	pinned : true,
					// 	cellClass : 'text-center'
					// },
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
						displayName : '日发电量(度)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'tw',
						displayName : '总发电量(度)',
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
					} ]
		};
	//汇流箱
	$scope.junctionBoxGridOptions = {
			data : 'deviceData',
			enablePinning : true,
			enableCellSelection : true,
			columnDefs : [
					// {
					// 	field : 'k',
					// 	displayName : '状态',
					// 	width : 60,
					// 	pinned : true,
					// 	cellClass : 'text-center',
					// 	cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'k\')==\'0\'"><i'+
					// 	' class=" icon icon-close"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'1\'"><i'+
					// 	' class="data-red1 icon-close"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'2\'"><i'+
					// 	' class="icon icon-info"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'3\'"><i'+
					// 	' class="icon icon-check"></i></span></span> '
					// },
					{
						field : 'dtime',
						displayName : '时间',
						width : 120,
						pinned : true,
						cellClass : 'text-center',
						cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
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
						displayName : '防雷器',
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
	//气象仪
	$scope.weatherGridOptions = {
			data : 'deviceData',
			enablePinning : true,
			enableCellSelection : true,
			columnDefs : [
					// {
					// 	field : 'k',
					// 	displayName : '状态',
					// 	width : 60,
					// 	pinned : true,
					// 	cellClass : 'text-center',
					// 	cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'k\')==\'0\'"><i'+
					// 	' class=" icon icon-close"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'1\'"><i'+
					// 	' class="data-red1 icon-close"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'2\'"><i'+
					// 	' class="icon icon-info"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'3\'"><i'+
					// 	' class="icon icon-check"></i></span></span> '
					// },
					{
						field : 'dtime',
						displayName : '时间',
						width : 120,
						pinned : true,
						cellClass : 'text-center',
						cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
					}, {
						field : 'lh',
						displayName : '水平面光照强度瞬时值(W/㎡)',
						width : 180,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'ls',
						displayName : '散射光照强度瞬时值(W/㎡)',
						width : 180,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'la',
						displayName : '斜面光照强度瞬时值(W/㎡)',
						width : 180,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'lhd',
						displayName : '水平面光照日累计(kWh)',
						width : 180,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'lsd',
						displayName : '散射光照日累计(kWh)',
						width : 180,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'lad',
						displayName : '斜面光照日累计(kWh)',
						width : 180,
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
						displayName : '湿度(%)',
						width : 80,
						cellFilter : 'number:2',
						cellClass : 'text-right',
						cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'h2o\')|number:2"></span> '
					} , {
						field : 'p',
						displayName : '气压(kPa)',
						width : 80,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}  ]
		};
	//电能表
	$scope.energyMeterGridOptions = {
			data : 'deviceData',
			enablePinning : true,
			enableCellSelection : true,
			columnDefs : [
					// {
					// 	field : 'k',
					// 	displayName : '状态',
					// 	width : 60,
					// 	pinned : true,
					// 	cellClass : 'text-center',
					// 	cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'k\')==\'0\'"><i'+
					// 	' class=" icon icon-close"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'1\'"><i'+
					// 	' class="data-red1 icon-close"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'2\'"><i'+
					// 	' class="icon icon-info"></i></span> <span'+
					// 	' ng-if="row.getProperty(\'k\')==\'3\'"><i'+
					// 	' class="icon icon-check"></i></span></span> '
					// },
					{
						field : 'dtime',
						displayName : '时间',
						width : 120,
						pinned : true,
						cellClass : 'text-center',
						cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
					},{
						field : 'p',
						displayName : '瞬时总有功功率(kW)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'q',
						displayName : '瞬时总无功功率(kVar)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 's',
						displayName : '瞬时总视在功率(kW)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'wp',
						displayName : '组合有功总电能(kWh)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'wpp',
						displayName : '正向有功总电能(kWh)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'wpn',
						displayName : '反向有功总电能(kWh)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'wqp',
						displayName : '正向无功总电能(kWh)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'wqn',
						displayName : '反向无功总电能(kWh)',
						width : 140,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}]
		};
}
responseHeight();
$(".result_table").hide();
function responseHeight(){
	$(".noSearchStat").css("height", $(window).height() - 225);
	$(".result_table").css("height", $(window).height() - 225);
	$(".result_table").css("width", $("#deviceDatas").width);
}
window.addEventListener("resize", function() {
	responseHeight();
});

// $(".result_table").each(function(){
// 	$(this).hide();
// });
</script>
