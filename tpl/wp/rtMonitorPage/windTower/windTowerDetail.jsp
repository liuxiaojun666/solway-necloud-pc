<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<div ng-controller="WindTowerDetailCtr">
    <div class="wrapper-md bg-light b-b">
        <span class="font-h3 blue-1 m-n text-black" ng-bind="windTowerData.windTower.name"></span>
        <span class="font-h3 blue-1 m-n text-black" ng-bind="eventDesc"></span>
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
                            <span id="boxchangeid" class="m-r-md font_weight" ng-bind="windTowerData.windTower.stationName"></span>
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
                                <th>测点高度</th>
                                <th>测点环境温度</th>
                                <th>测点湿度</th>
                                <th>测点压力</th>
                                <th>测点风速</th>
                                <th>测点风速均值</th>
                                <th>测点风向</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td class="v-middle " >测点1</td>
                                <td class="v-middle " ng-bind="rtData.sh1 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ta1 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.h2o1 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.p1 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ws1 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wsa1 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wd1 | number:2"></td>
                            </tr>
                            <tr>
                                <td class="v-middle " >测点2</td>
                                <td class="v-middle " ng-bind="rtData.sh2 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ta2 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.h2o2 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.p2 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ws2 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wsa2 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wd2 | number:2"></td>
                            </tr>
                            <tr>
                                <td class="v-middle " >测点3</td>
                                <td class="v-middle " ng-bind="rtData.sh3 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ta3 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.h2o3 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.p3 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ws3 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wsa3 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wd3 | number:2"></td>
                            </tr>
                            <tr>
                                <td class="v-middle " >测点4</td>
                                <td class="v-middle " ng-bind="rtData.sh4 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ta4 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.h2o4 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.p4 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ws4 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wsa4 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wd4 | number:2"></td>
                            </tr>
                            <tr>
                                <td class="v-middle " >测点5</td>
                                <td class="v-middle " ng-bind="rtData.sh5 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ta5 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.h2o5 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.p5 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ws5 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wsa5 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wd5 | number:2"></td>
                            </tr>
                            <tr>
                                <td class="v-middle " >测点6</td>
                                <td class="v-middle " ng-bind="rtData.sh6 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ta6 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.h2o6 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.p6 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.ws6 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wsa6 | number:2"></td>
                                <td class="v-middle " ng-bind="rtData.wd6 | number:2"></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </tab>

            <!-- 历史信息 -->
            <tab ng-controller="WindTowerHistoryCtrl" ng-click="changeViewNotHistorySearch()">
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
                        <div class="col-sm-12 no-padder" ng-grid="windTowerGridOptions" id="box_change_result_table" style="height: 350px;width: 100%" ></div>
                    </div>
                </paging>
            </tab>

            <!-- 故障信息 -->
            <tab ng-controller="WindTowerFaultAlarmCtrl" ng-click="changeViewNotSearchFault()">
                <tab-heading class="wrapper-sm">
                    <span id="faultalarmInfo" class="white-1 a-cur-poi" >故障信息</span>
                    <span class="white-1 a-cur-poi" id="faultalarmTitle">
                        (<span ng-bind="windTowerData.faultalarm"></span>)
                    </span>
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

            <!-- 检修维护 -->
            <tab ng-controller="WindTowerRepairtCtrl" ng-click="onSelectPage(1)">
                <tab-heading class="wrapper-sm">
                    <span id="repairtInfo" class="white-1 a-cur-poi" >检修维护</span>
                    <span class="white-1 a-cur-poi" id="repairtTitle">
                        (<span ng-bind="windTowerData.repairt"></span>)
                    </span>
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

            <!-- 技术监督 -->
            <tab ng-controller="WindTowerExperimentCtrl" ng-click="onSelectPage(1)">
                <tab-heading class="wrapper-sm">
                    <span id="experimentInfo" class="white-1 a-cur-poi" >技术监督</span>
                    <span class="white-1 a-cur-poi" id="experimentTile">
                        (<span ng-bind="windTowerData.experiment"></span>)
                    </span>
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

            <!-- 技术改造 -->
            <tab ng-controller="WindTowerReplacedCtrl" ng-click="onSelectPage(1)">
                <tab-heading class="wrapper-sm">
                    <span id="replacedInfo" class="white-1 a-cur-poi" >技术改造</span>
                    <span class="white-1 a-cur-poi" id="replacedTitle">
                        (<span ng-bind="windTowerData.replaced"></span>)
                    </span>
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
    app.controller("WindTowerDetailCtr", function ($scope, $http, $state, $stateParams) {
        $scope.deviceIds = {};
        $scope.$on('deviceStation_parameter', function(event, deviceById, tag) {
            $("#box_change_result_table").css("height", $(window).height() - 230);
            $scope.serialnumber = deviceById.deviceSerialNnumber;
            $scope.pstationid = deviceById.pstationid;

            $stateParams.InId = deviceById.deviceId;
            $stateParams.pstationid = deviceById.pstationid;
            if(deviceById.dStartTime != null && deviceById.dStartTime != ""){
                $stateParams.dstarttime = deviceById.dStartTime;
                var eventTime =new Date($stateParams.dstarttime).Format("yyyy-MM-dd hh:mm:ss");
                $scope.eventDesc = "(事件发生时间:" + eventTime + ")";

            }
            getRealData($scope, $http);
//            getHours($scope, $stateParams,$http);
            $scope.initPageData();
//            var hashUrl = location.hash;
//            var hashArr = hashUrl.split("/");
//            var lastHash = hashArr[hashArr.length-1];
//            if(lastHash != "RtmDeviceLayout"){
//                angular.element("#historyInfobc22").trigger("click");
//            }

        });

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

        //设备信息
        $scope.initPageData = function() {
            $http({
                method : "POST",
                url : "${ctx}/WpWindTower/queryBWindTowerInfoById.htm",
                params : {
                    'id' : $scope.serialnumber
                },
                timeout: 10000
            }).success(function(result) {
                $scope.windTowerData = result;
            }).error(function(response) {});
        };

        $scope.getDeviceIdBySerialNumber = function (serialnumber) {
            if ($scope.deviceIds[serialnumber] != null){
                return $scope.deviceIds[serialnumber];
            }
            $.ajax({
                type: "post",
                url : "${ctx}/WpWindTower/queryDeviceIdBySerialnumber.htm",
                async: false,
                data: {'serialnumber': serialnumber},
                success: function (result) {
                    if (result.key == 0){
                        $scope.deviceIds[serialnumber] = result.data.id;
                    }
                }
            });
            return $scope.deviceIds[serialnumber];
        };
    });

    //历史信息
    app.controller("WindTowerHistoryCtrl", function ($scope, $http, $stateParams) {
        $scope.flag = 0;
        $scope.onSelectPage = function(page) {
            if($scope.flag == 0){
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
                $scope.flag = 1;
            }

            CommonPerson.Base.LoadingPic.PartShow('loadingDiv'); //加载状态
            $("#box_change_result_table").hide();
            if(page == 0){
                page = 1;
                $scope.currentPage=1;
            }

            $http({
                method : "POST",
                url : "${ctx}/wpHistoryData/getWpHistoryData.htm",
                params : {
                    'pageIndex' : page,
                    'pageSize' : $scope.pageSizeSelect,
                    'devicetype': 2,
                    'begindate': $scope.begindate,
                    'enddate': $scope.enddate,
                    'stationid': $scope.pstationid,
                    "serialnumber" : $scope.serialnumber
                }
            }).success(function(result) {
                partHide('loadingDiv');
                getPaginationDatas($scope, result[0]);
                $("#box_change_result_table").show();
            }).error(function(response) {});
        };

        $scope.firstFlag = 0;
        $scope.changeViewNotHistorySearch = function() {
            if($scope.firstFlag == 0){
                $scope.onSelectPage(1);
                $scope.firstFlag = 1;
            }else{
                $("#box_change_result_table").show();
            }
        };

        $scope.windTowerGridOptions = {
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
                    field : 'sh1',
                    displayName : '测点1高度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ta1',
                    displayName : '测点1环境温度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'h2o1',
                    displayName : '测点1湿度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'p1',
                    displayName : '测点1压力',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ws1',
                    displayName : '测点1风速',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wsa1',
                    displayName : '测点1风速均值',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wd1',
                    displayName : '测点1风向',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'sh2',
                    displayName : '测点2高度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ta2',
                    displayName : '测点2环境温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'h2o2',
                    displayName : '测点2湿度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'p2',
                    displayName : '测点2压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ws2',
                    displayName : '测点2风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wsa2',
                    displayName : '测点2风速均值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wd2',
                    displayName : '测点2风向',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'sh3',
                    displayName : '测点3测点高度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ta3',
                    displayName : '测点3环境温度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'h2o3',
                    displayName : '测点3湿度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'p3',
                    displayName : '测点3压力',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ws3',
                    displayName : '测点3风速',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wsa3',
                    displayName : '测点3风速均值',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wd3',
                    displayName : '测点3风向',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'sh4',
                    displayName : '测点4高度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ta4',
                    displayName : '测点4环境温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'h2o4',
                    displayName : '测点4湿度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'p4',
                    displayName : '测点4压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ws4',
                    displayName : '测点4风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wsa4',
                    displayName : '测点4风速均值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wd4',
                    displayName : '测点4风向',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'sh5',
                    displayName : '测点5测点高度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ta5',
                    displayName : '测点5环境温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o5',
                    displayName : '测点5湿度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                } , {
                    field : 'p5',
                    displayName : '测点5压力',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                } , {
                    field : 'ws5',
                    displayName : '测点5风速',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                } , {
                    field : 'wsa5',
                    displayName : '测点5风速均值',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                } , {
                    field : 'wd5',
                    displayName : '测点5风向',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                } , {
                    field : 'sh6',
                    displayName : '测点6测点高度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ta6',
                    displayName : '测点6环境温度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o6',
                    displayName : '测点6湿度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p6',
                    displayName : '测点6压力',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws6',
                    displayName : '测点6风速',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wsa6',
                    displayName : '测点6风速均值',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wd6',
                    displayName : '测点6风向',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                } ]
        };
    });

    //故障信息
    app.controller("WindTowerFaultAlarmCtrl", function ($scope, $http) {
        $scope.changeViewNotSearchFault = function() {
            $scope.onSelectPage(1);
        };

        $scope.onSelectPage  = function(page) {
            if (page == 0) {
                page = 1;
            }
            $http({
                method : "POST",
                url : "${ctx}/WpRtmFaultAlarm/faultAlarmList.htm",
                params : {
                    'pageIndex': page - 1,
                    'pageSize' : $scope.pageSizeSelect,
                    "deviceId" : $scope.getDeviceIdBySerialNumber($scope.serialnumber),
                    deviceType : 2
                },
                timeout: 10000
            }).success(function(result) {
                getTableData($scope, result);
            }).error(function(response) {});
        };
        initTableConfig($scope);
    });

    //检修维护
    app.controller("WindTowerRepairtCtrl", function ($scope, $http) {
        $scope.onSelectPage = function(page) {
            if (page == 0) {
                page = 1;
            }
            $http({
                method : "POST",
                url : "${ctx}/Repair/repairtList.htm",
                params : {
                    'pageIndex': page - 1,
                    'pageSize' : $scope.pageSizeSelect,
                    "param" : $scope.getDeviceIdBySerialNumber($scope.serialnumber)
                },
                timeout: 5000
            }).success(function(result) {
                $scope.maintenance = result.data
            }).error(function(response) {});
        };
        initTableConfig($scope);
    });

    //技术监督
    app.controller("WindTowerExperimentCtrl", function ($scope, $http) {
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
                    "param" : $scope.getDeviceIdBySerialNumber($scope.serialnumber)
                },
                timeout: 5000
            }).success(function(result) {
                $scope.supervise = result.data
            }).error(function(response) {});
        };
        initTableConfig($scope);
    });

    //技术改造
    app.controller("WindTowerReplacedCtrl", function ($scope, $http) {
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
                    "param" : $scope.getDeviceIdBySerialNumber($scope.serialnumber),
                    serialnumber: $scope.serialnumber,
                    pstationid : $stateParams.pstationid
                },
                timeout: 5000
            }).success(function(result) {
                $scope.reform = result.data
            }).error(function(response) {});
        };
        initTableConfig($scope);
    });

    //实时数据
    function getRealData($scope, $http){
        $http.get("${ctx}/WpDeviceStation/getSingleRealtimeWindTower.htm", {
            params : {
                serialnumber:$scope.serialnumber,
                pstationid : $scope.pstationid
            },
            timeout: 5000
        }).success(function(result) {
            if (result.key == 0){
                $scope.serialnumber = result.data.did;
                $scope.pstationid = result.data.sid;
                $scope.rtData = result.data;
                if(result.data.comm==1 || result.data.comm==2){
                    $("#statusDescHidden").removeClass("hidden")
                }
                $scope.millisecond = result.data.dtime*1000;
            }
        }).error(function(response) {});
    }

    function startDate(date){
        var newdate=new Date(date-24*60*60*1000);
        var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
        return startTime;
    }

    function endDate(date){
        var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
        return endTime;
    }

    function getPaginationDatas($scope, result){
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
</script>