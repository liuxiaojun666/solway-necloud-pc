<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.modal-open {
    overflow-y: auto;
}
</style>
<div ng-controller="FaultAlarmCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">故障报警</span> -->
	</div>
	<div class="wrapper-sm bg-light m-b-sm">
	<!-- 按级别 -->
		<div class="col-sm-3 col-xs-12  no-padder">
			<div class="col-sm-4 col-xs-12 data-bg-red-2 no-padder v-middle faultRtStatics">
				<div class="bg-black-05 faultRtStatics text-center-xs">
				<div class="text-center-xs padder-t">
				<span class="font-h4 text-black">
					<a class="text-info"><img src="./theme/images/solway/icon/anjibie.png" width="24" height="24"></a>
				</span>
				</div>
				<span class="font-h4 white-1 m">按级别</span>
				</div>
			</div>
			<div class="col-sm-4 col-xs-12 v-middle text-center-xs faultRtStatics data-bg-red-2 no-padder" >
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">故障</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.seriousCount">0</span>
			</div>
			<div class="col-sm-4 col-xs-12 faultRtStatics data-bg-red-2 text-center-xs no-padder" >
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">报警</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.normalCount">0</span>
			</div>
		</div>
		<!-- 按设备 -->
		<div class="col-sm-4 col-xs-12  ">
			<div class="col-sm-2 col-xs-12 no-padder faultRtStatics bg-blue-1 ">
				<div class="bg-black-05 faultRtStatics text-center-xs">
				<div class="text-center-xs padder-t">
				<span class="font-h1 text-black " >
					<a class="text-info"><img src="./theme/images/solway/icon/anshebei.png" width="24" height="24"></a>
				</span>
				</div>
				<span class="font-h4 white-1 ">按设备</span>
				</div>
			</div>
			
			<div class="col-sm-3 col-xs-12 bg-blue-1 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">汇流箱</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.junctionBoxCount">0</span>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-1 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">逆变器</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.inverterCount">0</span>
			</div>
			<div class="col-sm-2 col-xs-12 bg-blue-1 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">箱变</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.boxChangeCount">0</span>
			</div>
			<div class="col-sm-2 col-xs-12 bg-blue-1 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">其他</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.otherCount"></span>
			</div>
		</div>
		<!-- 按时间 -->
		<div class="col-sm-5 col-xs-12  no-padder">
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics no-padder">
				<div class="bg-black-05 faultRtStatics text-center-xs">
				<div class="text-center-xs padder-t">
				<span class="font-h1 text-black">
					<a class="text-info"><img src="./theme/images/solway/icon/anshijian.png" width="24" height="24"></a>
				</span>
				</div>
				<span class="font-h4 white-1 m">按时间</span>
				</div>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">4小时以上</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.above4Count">0</span>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">2小时以上</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.above2Count">0</span>
			</div>
			<div class="col-sm-3 col-xs-12 bg-blue-2 faultRtStatics text-center-xs no-padder">
				<div class="padder-t text-center-xs">
					<span class="font-h4 white-1">2小时以内</span>
				</div>
				<span class="m-b-xs m-n white-1 font-big"  ng-bind="totalStatistics.below2Count">0</span>
			</div>
		</div>
	</div>
	<div class="wrapper-md ng-scope">
		<paging>
			<div class="col-sm-5 pull-right" style="margin: 10px 0;">
				<%@ include file="/common/pager.jsp"%>
			</div>
			<div class="wrapper-sm  no-border-xs panel" style="overflow:auto;width:100%;">
				<table class="table table-striped b-t b-light bg-table" id="t">
					<tr>
						<th style="text-align: center;" width="5%">设备名称</th>
						<th style="text-align: center;" width="5%">故障类型</th>
						<th style="text-align: center;" width="5%">设备类型</th>
						<th style="text-align: center;" width="10%">故障发生时间</th>
						<th style="text-align: center;" width="10%">故障描述</th>
						<th style="text-align: center;" width="5%">持续时间</th>
						<th style="text-align: center;" width="5%">处理详情</th>
					</tr>
					<tr ng-repeat="vo in data">
						<td style="text-align: center;">
							<span ng-show="vo.deviceTypeCode == 1 || vo.deviceTypeCode == 2 || vo.deviceTypeCode == 3">
								<a ng-bind="vo.name"  ng-click="showInformation(vo.deviceId,vo.deviceSerialNnumber,vo.deviceTypeCode,vo.pstationid,vo.hasJB);" class="href-blur"></a>
							</span>
							<span ng-show="vo.deviceTypeCode != 1 && vo.deviceTypeCode != 2 && vo.deviceTypeCode != 3" ng-bind="vo.name" ></span>
						</td>
						<!-- <td  style="text-align: center;">
							<span>
								<a ng-bind="vo.name"  ng-click="showInformation(vo.deviceId,vo.deviceSerialNnumber,vo.deviceTypeCode,vo.pstationid);" class="href-blur"></a>
							</span>
						</td> -->
						<td style="text-align: center;" ng-bind="vo.eventType"></td>
						<td style="text-align: center;" ng-bind="vo.deviceType"></td>
						<td style="text-align: center;" ng-bind="vo.sStartTime"></td>
						<td style="text-align: center;" ng-bind="vo.eventDesc"></td>
						<td style="text-align: center;" ng-bind="vo.hours"></td>
						<td class="text-center">
							<a class="text-info"><i class="icon-wrench" ng-click="showFaultList(vo.id);" ></i></a>
							<a class="text-info"><i class="icon-note" ng-click="noteDetails(0,'00',vo.id);" ></i></a>
						</td>
					</tr>
				</table>
			</div>
		</paging>
	</div>
	<div ng-include="'${ctx}/tpl/rtMonitorPage/devicelog/messageDetail.jsp'">
	</div>
	<!-- 查看事件日志详情 -->
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails00.jsp'"></div>
	<!-- 查看任务详情 -->
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails01.jsp'"></div>
	<!-- 查看事件处理详情 -->
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails02.jsp'"></div>
	
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp'" ></div>
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData2.jsp'" ></div>
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData3.jsp'" ></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">
    app.controller('FaultAlarmCtrl', function ($scope, $rootScope,$http,$state,$stateParams) {
    	$scope.getCurrentDataName('00',0);
    	$scope.$on('broadcastSwitchStation', function(event, data) {
    		$scope.currentDataName = data.dataName;
			$scope.refreshViewDataForHead();
	    });
    	$scope.totalStatistics=null;
    	
    	$scope.refreshViewDataForHead = function () {
    		$http({method:"POST",url:"${ctx}/FaultAlarm/faultAlarmTotalStatistics.htm"
        	}).success(function (result) {
    	    	$scope.totalStatistics=result;
    		});
    		$scope.rtStatistics(1);
    	};
    	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);
    	
    	$scope.faultLevelList = [{'dictName':'故障'},{'dictName':'报警'}];
		$scope.faultLevelCount = 2;
    	$scope.rtStatisticsData = null;
    	
    	$http({method:"POST",url:"${ctx}/FaultAlarm/faultAlarmTotalStatistics.htm"
    	}).success(function (result) {
	    	$scope.totalStatistics = result;
		});

		initTableConfig($scope);
		$scope.onSelectPage = $scope.rtStatistics = function (page) {
			if(page == 0){
				page = 1;
			}
			$http({
				method:"POST",
				url:"${ctx}/FaultAlarm/getStationFaultAlarmRtData.htm",
				params : {
					'pageIndex': page - 1,
					'pageSize': $scope.pageSizeSelect
				}
			}).success(function (result) {
				getTableData($scope, result);
			});
        };
		$scope.onSelectPage(1);
		
		$scope.showFaultList=function(id){
			$http({method:"POST",url:"${ctx}/BaseMessage/selectPIdByBusiTypeAndBusiNo.htm",
         		params:{busiNo:id,busiType:'00'}}).success(function (result) {
         			if(result == 0){
             			alert("无法找到相关消息!");
         			}else{
         				$http({
         					method : "POST",
         					url : "${ctx}/BaseMessage/getTopBaseMessageDetail.htm",
         					params : {
         						'pageIndex'	:0,//pageFaultIndex+1,
         						'pageSize'	:10,
         						'parentid':result,
         					}
         				}).success(function(result) {
         					var readids="";
         					$scope.faultList=result.data;
         					//判断状态来获得时间
       						if($scope.faultList[0].handstatus=='03'){
           						$scope.usedTilte="共耗时"
           						$scope.usedDate=countTime($scope.faultList[0].cretime,$scope.faultList[result.data.length-1].cretime);
           					}else{
           						$scope.usedTilte="已耗时"
           						$scope.usedDate=countTime($scope.faultList[0].cretime,(new Date).getTime());
           					}

         					//隐藏未读数量
         			    	var msh;
         			    	if($scope.faultList[0].handstatus=='03'){
         			    		msh="<small class='handle3'>已关闭</small>"
         			    	}else if($scope.faultList[0].handstatus=='00'){
         			    		msh="<small class='handle1'>待确认</small>"
         			    	}else if($scope.faultList[0].handstatus=='01'){
         			    		msh="<small class='handle1'>待受理</small>"
         			    	}else if($scope.faultList[0].handstatus=='02'){
         			    		msh="<small class='handle2'>待处理</small>"
         			    	}
         			    	$("#unread_num"+id).addClass("hidden");
         					$("#mhs"+id).html(msh);
         					$scope.isSkip="0";
         				});
         				//默认赋一个默认高度
         				var screenHeight=document.body.clientHeight;
         				$('#messageDetailmodal').css("height",screenHeight-200)
         				$('#messageDetail').modal({backdrop: 'static', keyboard: false});
         			}
   			});
		}
		
		$scope.showInformation = function(deviceid,deviceSerialNnumber,deviceType,pstationid,hasJB) {
			
			var res = {};
			res.deviceSerialNnumber = deviceSerialNnumber;
			res.deviceId = deviceid;
			res.pstationid = pstationid;
			res.deviceTypeNow = deviceType;
			$scope.deviceTypeNow = deviceType;
			$scope.inverterType = hasJB;
			if(deviceType == '3'){
				$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});
				//$scope.$emit("showDeviceDetail3", res);
				$scope.$broadcast("showDeviceDetail3broad", res);
			}else if(deviceType == '2'){
				$('#taskList_historyData2').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail2broad", res);
				//$scope.$emit("showDeviceDetail2", res);
			}else if(deviceType == '1'){
				$('#taskList_historyData1').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail1broad", res);
				//$scope.$emit("showDeviceDetail1", res);
			}
			
			//测试
        	//$scope.showHistoryData_byRTMDeviceLogId(1,1,146,'1');
    	
		};
		
		/*查看设备运行数据*/ //单击按钮事件 关闭 "待加载链接地址"弹出页面
		 $scope.closeHistoryData_byRTMDeviceLogId=function(msg){
			$scope.deviceTypeNow = "-1";
		 }
		
		$scope.getEventDetailById=function(eventid){
			$http({method:"POST",url:"${ctx}/FaultHand/getFaultAlarmById.htm",params:{id:eventid}})
			.success(function (msg) {
				$("#stationDiv00").text(msg.pstationname);
				$("#deviceTypeSp00").text((msg.devicetypeStr==null||msg.devicetypeStr=="") ?"-":msg.devicetypeStr);
				$("#deviceNameSp00").text((msg.devicename==null||msg.devicename=="") ?"-":msg.devicename);
				if(msg.faultlevelStr){
					$("#faultLevelSp00").text(msg.faultlevelStr);
				}else if(msg.eventType==-9){
					$("#faultLevelSp00").text("通讯中断");
				}
				$("#faultStatusSp00").text(msg.sysstatusStr);
				$("#sStartTime00").text(msg.sysrptdateStr);
				$("#dStartTime00").text(msg.dStartTimeStr);
				$("#dEndTime00").text(msg.dEndTimeStr);
				$("#faultLevelTd00").text((msg.faultlevelStr==null||msg.faultlevelStr=="") ?"-":msg.faultlevelStr);
				$("#devicenameTd00").text((msg.devicename==null||msg.devicename=="") ?"-":msg.devicename);
				$("#faultcodeTd00").text((msg.eventCode==null||msg.eventCode=="") ?"-":msg.eventCode);
				$("#faultclassTd00").text((msg.faultclassStr==null||msg.faultclassStr=="") ?"-":msg.faultclassStr);
				$("#faultdescTd00").text((msg.eventDesc==null||msg.eventDesc=="") ?"-":msg.eventDesc);

				//msg.handStatus = '04';
			});
		}
		
		//查看详情
		$scope.noteDetails=function(messageId,busitype,busino){

			if(busitype=='00'){
				$scope.getEventDetailById(busino);
				//$scope.getMessageDetailById(messageId);
				$('#noteDetails00').modal({backdrop: 'static', keyboard: false});
			}else if(busitype=='01'){
				$scope.getTaskDetailById(busino);
				//$scope.getMessageDetailById(messageId);
				$('#noteDetails01').modal({backdrop: 'static', keyboard: false});
			}else if(busitype=='02'){
				$scope.getEventHandleDetailById(busino);
				//$scope.getMessageDetailById(messageId);
				$('#noteDetails02').modal({backdrop: 'static', keyboard: false});
			}
		}
		
		
		
    });
    function countTime(time1,time2){
		var countDate;
		var date1=time1;  //开始时间
		var date2=time2;    //结束时间
		var date3=date2-date1  //时间差的毫秒数
		//计算出相差天数
		var days=Math.floor(date3/(24*3600*1000))

		//计算出小时数
		var leave1=date3%(24*3600*1000)    //计算天数后剩余的毫秒数
		var hours=Math.floor(leave1/(3600*1000))
		//计算相差分钟数
		var leave2=leave1%(3600*1000)        //计算小时数后剩余的毫秒数
		var minutes=Math.floor(leave2/(60*1000))

		//计算相差秒数
		var leave3=leave2%(60*1000)      //计算分钟数后剩余的毫秒数
		var seconds=Math.round(leave3/1000);

		if(date3<=0){
			countDate="0 分钟 0 秒";
			console.log(countDate)
		}else{
			if(days=="0"){
				if(hours=="0"){
					countDate=minutes+" 分钟"+seconds+" 秒"
				}else{
					countDate=hours+"小时 "+minutes+" 分钟"+seconds+" 秒"
				}
			}else{
				countDate=days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒"
			}
		}

		return countDate;
	}
</script>
