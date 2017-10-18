<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/array.extend.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<div ng-controller="WpHistoryData" >
    <div class="wrapper-md bg-light b-b">
        <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
        <span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
        <!-- <span class="font-h3 blue-1 m-n text-black">历史数据查询</span> -->
    </div>
    <div class="wrapper-md ng-scope">
        <div class="panel panel-default">
            <paging class="col-sm-12 panel no-padder">
                <div class="row wrapper">
                    <div class="col-sm-3">
                        <div class="col-sm-6" id="userType_Div">
                            <ui-select ng-model="deviceTyped.selected" theme="bootstrap" ng-change="selectDevice()">
                                <ui-select-match placeholder="请选择设备..." ng-model="deviceTyped.selected.devtype" >{{$select.selected.devtype}}</ui-select-match>
                                <ui-select-choices  repeat="item in deviceTypeItem | filter: $select.search">
                                    <div ng-bind-html="item.devtype | highlight: $select.search"></div>
                                </ui-select-choices>
                            </ui-select>
                            <input type="hidden" id="devid" name="devid" class="form-control formData">
                        </div>
                        <div class="col-sm-6  p-l-n">
                            <ui-select ng-model="deviced.selected" theme="bootstrap" ng-change="deviceChange()">
                                <ui-select-match placeholder="请选择设备..." ng-model="deviced.selected.name" >{{$select.selected.name}}</ui-select-match>
                                <ui-select-choices  repeat="item in device | filter: $select.search">
                                    <div ng-bind-html="item.name | highlight: $select.search"></div>
                                </ui-select-choices>
                            </ui-select>
                            <input type="hidden" id="serialnumber" name="serialnumber" class="form-control formData">
                        </div>
                    </div>
                    <div class="col-sm-5 p-l-n">
                        <div class="input-group ">
                            <input type="text" id="begindate" name="begindate" class="form-control">
                            <span class="input-group-addon">至</span>
                            <input type="text" id="enddate" name="enddate" class="form-control">
                            <span class="input-group-btn padder-l-sm ">
						<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button" id="historyData_select">查询</button>
					</span>
                    <!--  <span class="input-group-btn padder-l-sm ">
						<button class=" btn btn-sm btn-info" ng-click="exportData();" type="button">导出</button>
					</span> -->
                        </div>
                    </div>
                    <div class="col-sm-4  p-l-n">
                        <%@ include file="/common/pager.jsp"%>
                    </div>
                </div>
        </div>
        <span  class="text-center data-red hidden col-sm-12" id="pointOut" style="position: relative;top: 100px;z-index: 99;">该查询无相关数据!</span>
        <div class="col-sm-12 b-t no-padder" id="deviceDatas">
            <div class="noSearchStat" style="border: 1px #dee5e7 solid;border-top: none;box-shadow: 0 1px 1px rgba(0, 0, 0, .05);"></div>
            <div class="col-sm-12 no-padder" id="loadingDiv"></div>
            <div class="col-sm-12 no-padder result_table" style="height:300px;"ng-grid="windTurbineGridOptions" id="windTurbineResultTable"></div>
            <div class="col-sm-12 no-padder result_table" style="height:300px;" ng-grid="windTowerGridOptions" id="windToweResultTable"></div>
        </div>
        </paging>
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

    var url = {
        "url1":"${ctx}/wpHistoryData/queryBWindTurbine.htm",
        "url2":"${ctx}/wpHistoryData/queryBWindTower.htm"
    };
    var selectDevice;
    var onSelectPage;
    app.controller('WpHistoryData', function($scope, $http, toaster, $state,$stateParams, $document) {
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
                    'pstationid': $("#pstationid").val()
                }
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
        };
        $scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

        if($stateParams.deviceType){
            $("#deviceType").val($stateParams.deviceType);
            $scope.deviceType = $stateParams.deviceType;
        }else{
            $scope.deviceType = $("#deviceType").val();
        }

        $scope.deviceTypeItem = null;
        $scope.deviceTyped = null;
        $scope.getDeviceType = function(){
            $http({
                method : "POST",
                url :"${ctx}/DeviceStation/getWpDeviceType.htm",
                params : {
                    'stationid': $scope.stationListId
                }
            }).success(function (msg) {
                if (msg.key == "0"){
                    $scope.deviceTypeItem = msg.data;
                    $scope.deviceTyped = {};
                    if ($scope.deviceTypeItem.length > 0){
                        $("#devid").val(angular.copy($scope.deviceTypeItem[0].devid));
                        $scope.deviceTyped.selected = {devid:$scope.deviceTypeItem[0].devid, devtype:$scope.deviceTypeItem[0].devtype};
                        $scope.selectDevice();
                    }
                }
            });
        };
        $scope.getDeviceType();

        $scope.deviced = {};
        $scope.device = null;
        //根据类型查询设备
        selectDevice = $scope.selectDevice = function(type){
            $("#devid").val(angular.copy($scope.deviceTyped.selected.devid));
            $scope.deviceType=angular.copy($scope.deviceTyped.selected.devid);
            $http({
                method : "POST",
                url : url["url"+$scope.deviceType],
                params : {
                    'pstationId': $("#pstationid").val()
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
                        $("#serialnumber").val(angular.copy($scope.deviced.selected.serialnumber));
                    }
                }
            })
        };
        $scope.deviceChange= function () {
            $("#serialnumber").val(angular.copy($scope.deviced.selected.serialnumber));
        };

//        $scope.selectPower();
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
            
            $("#pointOut").addClass("hidden");
            $http({
                method : "POST",
                url : "${ctx}/wpHistoryData/getWpHistoryData.htm",
                params : {
                    'pageIndex' : page,
                    'pageSize' : $scope.pageSizeSelect,
                    'stationid': $("#pstationid").val(),
                    'serialnumber': $("#serialnumber").val(),
                    'devicetype': $scope.deviceType,
                    'begindate': $("#begindate").val(),
                    'enddate': $("#enddate").val()
                }
            }).success(function(result) {
                partHide('loadingDiv');
                if($scope.deviceType==1){
                    $("#windTurbineResultTable").show();
                }else if($scope.deviceType==2){
                    $("#windToweResultTable").show();
                }
                getPaginationDatas($scope, result[0]);
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
        $scope.windTurbineGridOptions = {
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
                    field : 'ws',
                    displayName : '机舱外风速',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 't_out',
                    displayName : '机舱外温度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 't_in',
                    displayName : '机舱内温度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'wa',
                    displayName : '风向夹角',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'rs',
                    displayName : '叶轮转速',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'a1',
                    displayName : '叶片1桨距角',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'a2',
                    displayName : '叶片2桨距角',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'a3',
                    displayName : '叶片3桨距角',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'grs',
                    displayName : '发电机转速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'p',
                    displayName : '有功功率',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'v',
                    displayName : '无功功率',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'gt',
                    displayName : '发电机最高绕组温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'hz',
                    displayName : '频率值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'pf',
                    displayName : '功率因数',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'bt1',
                    displayName : '齿轮箱高速轴驱动端轴承温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'bt0',
                    displayName : '齿轮箱高速轴非驱动端轴承温度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'boilt',
                    displayName : '齿轮箱油温',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'ywdir',
                    displayName : '偏航角度',
                    width : 150,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'dw',
                    displayName : '有功发电量日计',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'tw',
                    displayName : '有功发电量总计',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'turst',
                    displayName : '风机状态',
                    width : 160,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                },{
                    field : 'limwst',
                    displayName : '风机限功率状态',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }]
        };
        //测风塔
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
                    cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span>'
                },{
                    field : 'sh1',
                    displayName : '测点1高度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ta1',
                    displayName : '测点1环境温度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o1',
                    displayName : '测点1湿度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p1',
                    displayName : '测点1压力',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws1',
                    displayName : '测点1风速',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wsa1',
                    displayName : '测点1风速均值',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wd1',
                    displayName : '测点1风向',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'sh2',
                    displayName : '测点2高度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right',
                    cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'ef\')*100|number:2"></span> '
                }, {
                    field : 'ta2',
                    displayName : '测点2环境温度',
                    width : 80,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o2',
                    displayName : '测点2湿度',
                    width : 90,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p2',
                    displayName : '测点2压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws2',
                    displayName : '测点2风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
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
                }, {
                    field : 'ta3',
                    displayName : '测点3环境温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o3',
                    displayName : '测点3湿度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p3',
                    displayName : '测点3压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws3',
                    displayName : '测点3风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wsa3',
                    displayName : '测点3风速均值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wd3',
                    displayName : '测点3风向',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'sh4',
                    displayName : '测点4高度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ta4',
                    displayName : '测点4环境温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o4',
                    displayName : '测点4湿度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p4',
                    displayName : '测点4压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws4',
                    displayName : '测点4风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wsa4',
                    displayName : '测点4风速均值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
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
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p5',
                    displayName : '测点5压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws5',
                    displayName : '测点5风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wsa5',
                    displayName : '测点5风速均值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wd5',
                    displayName : '测点5风向',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'sh6',
                    displayName : '测点6测点高度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ta6',
                    displayName : '测点6环境温度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'h2o6',
                    displayName : '测点6湿度',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'p6',
                    displayName : '测点6压力',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'ws6',
                    displayName : '测点6风速',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wsa6',
                    displayName : '测点6风速均值',
                    width : 120,
                    cellFilter : 'number:2',
                    cellClass : 'text-right'
                }, {
                    field : 'wd6',
                    displayName : '测点6风向',
                    width : 120,
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
</script>
