<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 弹出层界面 -->
<div ng-controller="WpDevicelogCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
	</div>
	<div class="wrapper-md row ng-scope">
			<paging class="col-sm-12 wrapper  no-padder">
              <input type="hidden"  id="dictValue" name="dictValue">
		      <input type="hidden"  id="dictV">
			 <div class="col-sm-1 " id="userType_Div" >
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
                <input type="hidden" id="deviceid" name="deviceid" class="form-control formData">
              </div>

		 <div class="col-sm-4 p-l-n">
				<div class="input-group " style="width: 350px;">
				<input type="text" id="sStartTime" name="sStartTime" class="form-control">
	         	<span class="input-group-addon">至</span>
	         	<input type="text" id="sEndTime" name="sEndTime" class="form-control">
	      		 <span class="input-group-btn padder-l-sm ">
	         	<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
	         	</span>
	      		</div>
		    </div>

         	<div class="col-sm-5 pull-right">
    		<%@ include file="/common/pager.jsp"%>
    		</div>
</div>
			<!-- tab切换开始 -->
			<div class="wrapper-md pt5">
				<div class="panel panel-default">
					<tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
						<tab ng-click="onSelectPage(1,-1)" >
							<tab-heading class="wrapper-sm">
								<span class="white-1 a-cur-poi" >全部</span>
							</tab-heading>
							</tab>
						<tab ng-click="onSelectPage(1,-9)" >
							<tab-heading class="wrapper-sm">
								<span class="white-1 a-cur-poi" >通讯中断</span>
							</tab-heading>
                        </tab>
						<tab ng-click="onSelectPage(1,1)"  >
							<tab-heading class="wrapper-sm">
								<span class="white-1 a-cur-poi" >故障</span>
							</tab-heading>
                        </tab>
						<tab ng-click="onSelectPage(1,2)" >
							<tab-heading class="wrapper-sm">
								<span class="white-1 a-cur-poi" >报警</span>
							</tab-heading>
                        </tab>
						<tab ng-click="onSelectPage(1,99)">
                            <tab-heading class="wrapper-sm">
                                <span class="white-1 a-cur-poi" >正常运行</span>
                            </tab-heading>
                        </tab>
						<tab ng-click="onSelectPage(1,11)"  >
                            <tab-heading class="wrapper-sm">
                                <span class="white-1 a-cur-poi" >待机</span>
                            </tab-heading>
                        </tab>
						<tab ng-click="onSelectPage(1,12)" >
                            <tab-heading class="wrapper-sm">
                                <span class="white-1 a-cur-poi" >启动中</span>
                            </tab-heading>
                        </tab>
						<tab  ng-click="onSelectPage(1,13)">
                            <tab-heading class="wrapper-sm">
                                <span class="white-1 a-cur-poi" >关机中</span>
                            </tab-heading>
                        </tab>
						<tab ng-click="onSelectPage(1,14)"  >
                            <tab-heading class="wrapper-sm">
                                <span class="white-1 a-cur-poi" >停机</span>
                            </tab-heading>
						</tab>
					</tabset>
				</div>
				<div class="panel panel-default" style="margin-bottom:0;">
					<div class="col-sm-12  b-a panel border-none ng-scope">
						<table id="result_table" class="table table-striped b-t b-light">
							<thead>
								<tr>
									<th width="15%">开始时间</th>
									<th width="15%">结束时间</th>
									<th width="15%">设备名称</th>
									<th>事件内容</th>
									<th width="10%">事件类型</th>
									<th id="handle" width="10%">处理详情</th>
								</tr>
							</thead>
							<tbody >
								<tr ng-repeat="vo in data ">
									<td ng-bind="vo.sStartTime |date:'yyyy-MM-dd HH:mm:ss'"></td>
									<td ng-bind="vo.sEndTime |date:'yyyy-MM-dd HH:mm:ss' "></td>
									<td>
										<span ng-if="vo.deviceType!=4">
											<a ng-bind="vo.devicename"  ng-click="showInformation(vo.deviceId,vo.deviceSerialNnumber,vo.deviceType,vo.pstationid);" class="href-blur"></a>
										</span>
										<span ng-if="vo.deviceType==4">
											<span ng-bind="vo.devicename"></span>
										</span>
										<span ng-if="vo.devicename==null">
											<span>({{vo.pstationname}})</span>
										</span>
									</td>
									<td class="" ng-bind="vo.eventDesc"></td>
									<td class="" ng-bind="vo.faultlevelStr"></td>
									<td>
										<a ng-if="(vo.eventType==1||vo.eventType==2||vo.eventType==-9||vo.eventType==-99)&&(vo.isValid != 0)" class="text-info"><i class="icon-wrench" ng-click="showFaultList(vo.id);" ></i></a>
										<a ng-if="vo.eventType==1||vo.eventType==2||vo.eventType==-9||vo.eventType==-99" class="text-info"><i class="icon-note" ng-click="noteDetails(0,'00',vo.id);" ></i></a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- tab切换关闭 -->
    </paging>
    <div ng-include="'${ctx}/tpl/rtMonitorPage/devicelog/messageDetail.jsp'">
	</div>
	<!-- 查看事件日志详情 -->
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails00.jsp'"></div>
	<!-- 查看任务详情 -->
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails01.jsp'"></div>
	<!-- 查看事件处理详情 -->
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails02.jsp'"></div>
	<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData.jsp'"></div>
</div>

<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript">
	function goPage(pageIndex) {
		$("#searchBtn").trigger("click");
	}

	//日期控件
	$('#sEndTime').datetimepicker({
		format: "yyyy-mm-dd hh:ii",
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true,
	   	endDate:new Date()
	});

	//日期控件
	$('#sStartTime').datetimepicker({
		format: "yyyy-mm-dd hh:ii",
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true,
	   	endDate:new Date()
	});

	//设备查询地址
	var url={
		"url1":"${ctx}/wpHistoryData/queryBWindTurbine.htm",
		"url2":"${ctx}/wpHistoryData/queryBWindTower.htm"
	};
    var selectDevice;
	app.controller('WpDevicelogCtrl', function($scope, $http, $state,$stateParams) {
		$scope.getCurrentDataName('00',0);
		$scope.$on('broadcastSwitchStation', function(event, data) {
			$scope.currentDataName = data.dataName;
			$scope.device = null;
			$("#deviceType option:first").prop("selected", 'selected');
			//$scope.onSelectPage(1);
			 $scope.getDeviceType();
		});

		$scope.$on('refreshViewDataForHead', function(event, data) {
			$scope.device = null;
			$("#deviceType option:first").prop("selected", 'selected');
			$scope.onSelectPage(1);
	    });

        //获取设备类型种类
        $scope.deviceTypeItem = null;
        $scope.deviceTyped = null;
        $scope.getDeviceType = function(){
            $http({
                method : "POST",
                url :"${ctx}/DeviceStation/getWpDeviceType.htm",
                params : {
                }
            }).success(function (msg) {
                if (msg.key == "0"){
                    $scope.deviceTypeItem = msg.data;
                    $scope.deviceTyped = {};
                    if ($scope.deviceTypeItem.length > 0){
                        $("#devid").val(angular.copy($scope.deviceTypeItem[0].divid));
                        $scope.deviceType = angular.copy($scope.deviceTypeItem[0].divid);
                        $scope.deviceTyped.selected = {devid:$scope.deviceTypeItem[0].devid, devtype:$scope.deviceTypeItem[0].devtype};
                        $scope.selectDevice();
                    }
                }
            });
        };
        $scope.getDeviceType();

        //根据设备类型查询设备---------------------------Start------------------------------------------------
        $scope.deviced = {};
        $scope.device = null;
        selectDevice = $scope.selectDevice = function(){
            $scope.deviceType=angular.copy($scope.deviceTyped.selected.devid);
            $("#devid").val($scope.deviceType);
            if($scope.deviceType==""){
                $("#deviceid").val("");
                $scope.deviced.selected= {name: $scope.device.length="",serialnumber:  $scope.device.length=""};
            }
            $http({
                method : "POST",
                url : url["url"+$scope.deviceType],
                params : {
                    pstationid: $("#pstationid").val()
                }
            }).success(function(result) {
                if (result.key == 0){
                    $scope.device = result.data;
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
                        $("#deviceid").val(angular.copy($scope.deviced.selected.serialnumber));
                    }
                }
            })
        };
        $scope.deviceChange = function () {
            $("#deviceid").val(angular.copy($scope.deviced.selected.serialnumber));
        };

        //查询字典表中事件---------------------------Start------------------------------------------------
        initTableConfig($scope);
        $scope.onSelectPage = function(page, dictValue) {
            if(dictValue){
                $("#dictValue").val(dictValue);
            }
            var	dicthd=$("#dictValue").val();
            if(dicthd == -1){
                $("#dictValue").val("");
                $("#handle").show();
            }else if(dicthd == 99 || dicthd == 11 || dicthd == 12 || dicthd == 13 || dicthd == 14){
                $("#handle").hide();
            }else{
                $("#handle").show();
            }
            if (page == 0) {
                page = 1;
            }
            $http({
                method : "POST",
                url : "${ctx}/wpDeviceLog/wpDeviceRunList.htm",
                params : {
                    'pageIndex' : page - 1,
                    'pageSize' : $scope.pageSizeSelect,
                    'pstationid' : $("#pstationid").val(),
                    'deviceId' :  $("#deviceid").val(),
                    'sStartTime' : $("#sStartTime").val(),
                    'sEndTime' : $('#sEndTime').val(),
                    'eventType': $("#dictValue").val(),
                    'deviceType': $("#devid").val()
                }
            }).success(function(result) {
                getTableData($scope, result);
            });
        };
        $scope.onSelectPage(1);

        $scope.showFaultList = function(id){
            $http({
                method:"POST",
                url:"${ctx}/BaseMessage/selectPIdByBusiTypeAndBusiNo.htm",
                params:{
                    busiNo: id,
                    busiType: '00'
                }
            }).success(function (result) {
                if(result == 0){
                    alert("无法找到相关消息!");
                }else{
                    $http({
                        method : "POST",
                        url : "${ctx}/BaseMessage/getTopBaseMessageDetail.htm",
                        params : {
                            'pageIndex': 0,
                            'pageSize': 10,
                            'parentid': result
                        }
                    }).success(function(result) {
                        var readids="";
                        $scope.faultList = result.data;
                        //判断状态来获得时间
                        if($scope.faultList[0].handstatus=='03'){
                            $scope.usedTilte="共耗时";
                            $scope.usedDate = countTime($scope.faultList[0].cretime,$scope.faultList[result.data.length-1].cretime);
                        }else{
                            $scope.usedTilte="已耗时";
                            $scope.usedDate = countTime($scope.faultList[0].cretime,(new Date).getTime());
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
        };

        //查看详情
        $scope.noteDetails = function(messageId, busitype, busino){
            if(busitype=='00'){
                $scope.getEventDetailById(busino);
                $('#noteDetails00').modal({backdrop: 'static', keyboard: false});
            }else if(busitype=='01'){
                $scope.getTaskDetailById(busino);
                $('#noteDetails01').modal({backdrop: 'static', keyboard: false});
            }else if(busitype=='02'){
                $scope.getEventHandleDetailById(busino);
                $('#noteDetails02').modal({backdrop: 'static', keyboard: false});
            }
        };

        $scope.getEventDetailById = function(eventid){
            $http({
                method:"POST",
                url:"${ctx}/FaultHand/getFaultAlarmById.htm",
                params:{
                    id:eventid
                }
            })
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
            });
        };

        $scope.getTaskDetailById = function(taskid){
            $http({
                method:"POST",
                url:"${ctx}/Optask/selectById.htm",
                params:{
                    id: taskid
                }
            })
            .success(function (msg) {
                if(msg.pstationname){
                    $("#stationnameStr").text(msg.pstationname);
                }else{
                    $("#stationnameStr").text("");
                }
                if(msg.distManName){
                    $("#distmanStr").text(msg.distManName);
                }else{
                    $("#distmanStr").text("");
                }
                if(msg.respManName){
                    $("#respmanStr").text(msg.respManName);
                }else{
                    $("#respmanStr").text("");
                }
                if(msg.distdate){
                    $("#distdateStr").text(dateFormat(new Date(msg.distdate)));
                }else{
                    $("#distdateStr").text("");
                }
                if(msg.expectedtime){
                    $("#expectedtimeStr").text(dateFormat(new Date(msg.expectedtime)));
                }else{
                    $("#expectedtimeStr").text("");
                }
                if(msg.remindtimeStr){
                    $("#remindtimeStr").text(msg.remindtimeStr);
                }else{
                    $("#remindtimeStr").text("");
                }
                if(msg.taskcontent){
                    $("#taskcontentStr").text(msg.taskcontent);
                }else{
                    $("#taskcontentStr").text("");
                }
                if(msg.taskstatusStr){
                    $("#taskstatusStr").text(msg.taskstatusStr);
                }else{
                    $("#taskstatusStr").text("");
                }
                if(msg.finishcontent){
                    $("#finishcontentStr").text(msg.finishcontent);
                }else{
                    $("#finishcontentStr").text("");
                }
                if(msg.finishdate){
                    $("#finishdateStr").text(dateFormat(new Date(msg.finishdate)));
                }else{
                    $("#finishdateStr").text("-");
                }
                if(msg.finishedstatus){
                    $("#finishedstatusStr").text(msg.finishedstatus);
                }else{
                    $("#finishedstatusStr").text("-");
                }
                if(msg.refimage1){
                    $("#billImg5").attr("src","${imgPath}/document/faultHand/"+msg.refimage1);
                }else{
                    $("#imgdiv1").remove();
                }
                if(msg.refimage2){
                    $("#billImg6").attr("src","${imgPath}/document/faultHand/"+msg.refimage2);
                }else{
                    $("#imgdiv2").remove();
                }
                if(msg.refimage3){
                    $("#billImg7").attr("src","${imgPath}/document/faultHand/"+msg.refimage3);
                }else{
                    $("#imgdiv3").remove();
                }
            });
        };

        $scope.getEventHandleDetailById = function(ehid){
            $http({
                method:"POST",
                url:"${ctx}/EventHandle/getEventHandleDetailById.htm",
                params:{
                    id: ehid
                }
            })
            .success(function (msg) {
                $("#processUser02").text(msg.real_name);
                $("#processMethod02").text(msg.processmethodStr);
                $("#processTime02").text(msg.processtimeStr);
                $("#notProceReason02").text(msg.notprocereason_desc);
            });
        };

        $scope.showInformations = function(deviceId,serialnumber,deviceType,pstationid) {
            //1:测风塔  2:风电机组
            if(deviceType == 1){
                $scope.showHistoryDataByRTMDeviceLogId(pstationid,deviceId,serialnumber,'1');
            }else if(deviceType == 2){
                $scope.showHistoryData_byRTMDeviceLogId(pstationid,deviceId,serialnumber,'2');
            }
        };

        /*查看设备运行数据*/
        $scope.showHistoryDataByRTMDeviceLogId = function(pstationid, deviceid, deviceSerialNnumber, deviceType){
            var msg={deviceType:"0",deviceSerialNnumber:"0",pstationid:"0",id:"0",dStartTime:""};
            msg.deviceType = deviceType;
            msg.deviceSerialNnumber = deviceSerialNnumber;
            msg.deviceId = deviceid;
            msg.pstationid = pstationid;
            msg.dStartTime = "";
            //根据设备类型设置准备加载页面连接
            switch(msg.deviceType) {
                case "1":
                    $scope.showHistoryData_byRTMDeviceLogId_incloud = "${ctx}/tpl/ledgerPage/junctionBox/junctionBoxDetail.jsp";
                    $("#junction_box_result_table").css("width",'850px');
                    break;
                case "2":
                    $scope.showHistoryData_byRTMDeviceLogId_incloud = "${ctx}/tpl/ledgerPage/inverter/inverterDetail.jsp";
                    break;
                default:
                    $scope.showHistoryData_byRTMDeviceLogId_incloud = "";
                    break;
            }
            //传递查询结果
            $scope.showHistoryData_byRTMDeviceLogId.msg = msg;
        }





	});

	function countTime(time1,time2){
		var countDate;
		var date1 = time1;  //开始时间
		var date2 = time2;    //结束时间
		var date3 = date2-date1;  //时间差的毫秒数
		//计算出相差天数
		var days = Math.floor(date3/(24*3600*1000));
		//计算出小时数
		var leave1 = date3%(24*3600*1000) ;   //计算天数后剩余的毫秒数
		var hours = Math.floor(leave1/(3600*1000));
		//计算相差分钟数
		var leave2=leave1%(3600*1000);      //计算小时数后剩余的毫秒数
		var minutes=Math.floor(leave2/(60*1000));
		//计算相差秒数
		var leave3 = leave2%(60*1000);      //计算分钟数后剩余的毫秒数
		var seconds = Math.round(leave3/1000);
		if(date3 <= 0){
			countDate = "0 分钟 0 秒";
		}else{
			if(days == "0"){
				if(hours == "0"){
					countDate=minutes+" 分钟"+seconds+" 秒";
				}else{
					countDate=hours+"小时 "+minutes+" 分钟"+seconds+" 秒";
				}
			}else{
				countDate=days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒";
			}
		}
		return countDate;
	}

	function dateFormat(date) {
        return new Date(date).Format("yyyy-MM-dd hh:mm");
	}
</script>
