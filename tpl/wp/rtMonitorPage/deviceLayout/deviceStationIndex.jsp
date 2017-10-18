<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<style>
    #tabList {color: #333;padding-top: 15px;margin-bottom: 0;margin-left: 30px;display: inline-block;font-size: 14px;}
    #tabList li {border-bottom: 2px solid transparent;cursor: pointer;margin-right: 15px;padding: 0;}
    #tabList li.active {border-color: #06BEBD;color: #06BEBD;}
    #deviceTabs ul.nav.nav-tabs {display: none;}
</style>
<div ng-controller="DeviceStationCtrl">
    <!-- 头部布局 -->
    <div div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
        <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
        <span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
        <ul class="list-inline" id="tabList">
        </ul>
    </div>
    <div class="row-row" style="padding: 10px;" id="styleDiv">
        <div class="col-xs-12" style="overflow: hidden;    padding: 20px 20px 0;">
            <div id="response_respStatus" class="alert alert-danger" role="alert" style="display:none;">未接收到任何数据。请等待...</div>
            <div id="response_respStatusnull" class="alert alert-danger" role="alert" style="display:none;">返回数据异常！</div>
            <div id="comm_interruptDev" 	class="alert alert-danger" role="alert" style="display:none;">
                通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于
                <span ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
            </div>
            <div id="comm_initDev"  class="alert alert-info" role="alert" style="display:none;">设备初始化，未接收到任何数据。请等待...</div>
        </div>
        <div data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/statisticalData.jsp'"></div>
        <div class="wrapper-md ng-scope col-sm-12">
            <div class=" panel panel-default">
                <div class="pb10 clearfix dib">
                    <input type="text" class="form-control" id="searchWords" style="display: inline-block;width: 180px;float: left;border-right: none;border-top-right-radius: 0;border-bottom-right-radius: 0;" placeholder="请输入设备编号 / 名称">
                    <button class=" btn btn-info pull-left" ng-click="filterSearch()" type="button" style="border-top-left-radius: 0;border-bottom-left-radius: 0;">查询</button>

                    <div class="pull-right">
                        <ul class="pull-right pagination pagination-sm no-padder m-n bg-white2" num-pages="tasks.pageCount" current-page="tasks.currentPage" on-select-page="selectPage(page)" style="background-color: transparent!important;">
                            <li id="prevPage" class="disabled">
                                <a ng-click="prevPage()"><i class="fa fa-angle-left"></i></a>
                            </li>
                            <li>
                                <input class="form-control pull-left text-center" ng-model="goPageNum" id="goPageNum"
                                       style="width: 40px;height: 28px;padding: 0 5px;display: inline-block;" type="text" onKeyUp="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" >
                                <a class="btn" ng-click="goPage()" style="width: 35px;padding: 3px 3px;margin-left:5px;">跳转</a>
                            </li>
                            <li id="nextPage" class="">
                                <a ng-click="nextPage()" style="margin-left:5px;"><i class="fa fa-angle-right"></i></a>
                            </li>
                        </ul>
                        <span class="note_task">
                    <span class=" pull-right ">
                     <small style="float: left;margin-top:8px;" class="text-muted m-l-xs m-r-xs font-h6">每页显示 :</small>
                         <select id="singleNum" style="float: left;width:45px;height:30px;padding:0px" class="form-control">
                            <option checked value="10">10</option>
                            <option value="20">20</option>
                            <option value="30">30</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <small class="text-muted inline m-b-sm m-l-sm m-r-sm font-h6" style="margin-top:8px;">
                          页数<span id="curPage" class="ng-binding"></span> / <span id="pageNums" class="ng-binding"></span>
                        </small>
                    </span>
                    </span>
                    </div>
                </div>

                <div class="col-sm-12 no-padder" id="deviceTabs">
                    <tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
                        <!-- 实时统计开始 -->
                        <tab>
                            <tab-heading>
                                <span class=" wrapper-sm white-1 a-cur-poi to-trigger" ng-click="rtStatistics(0);">测风塔</span>
                            </tab-heading>
                            <div data-ng-include="'${ctx}/tpl/wp/rtMonitorPage/deviceLayout/wpWindTowerData.jsp'"></div>
                        </tab>
                        <tab>
                            <tab-heading>
                                <span class=" wrapper-sm white-1 a-cur-poi to-trigger" ng-click="rtStatistics(1);">风电机组</span>
                            </tab-heading>
                            <div data-ng-include="'${ctx}/tpl/wp/rtMonitorPage/deviceLayout/wpWindTurbineData.jsp'"></div>
                        </tab>
                    </tabset>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
	$('#curPage').text(1);
    $("#tabList").on("click","li", function() {
        $(this).addClass('active').siblings().removeClass('active');
        var htmlValue = $(this).html();
        switch(htmlValue){
            case "测风塔": $('#deviceTabs .to-trigger').eq(0).trigger('click');
                break;
            case "风电机组": $('#deviceTabs .to-trigger').eq(1).trigger('click');
                break;
        }

        $('#curPage').text(1);
        $('#prevPage').addClass('disabled');
        if ($(this).index()==2) {
            $('.shadowBtn').show();
        } else {
            $('.shadowBtn').hide();
        }
    });
    var headTimer;
    var deviceType = "";
    app.controller('DeviceStationCtrl', function($scope, $http, $state, $stateParams) {

        $scope.$on('broadcastSwitchStation', function(event, data) {
            $scope.getDeviceType2();
        });

        //获取设备分类
        $scope.getDeviceType2 = function(){
            $http({
                method : "POST",
                url :"${ctx}/DeviceStation/getWpDeviceType.htm"
            }).success(function (msg) {
                $scope.queryDeviceTypeSuccess(msg);
            });
        };

        //获取设备分类
        $scope.getDeviceType = function(){
            $http({
                method : "POST",
                url :"${ctx}/DeviceStation/getWpDeviceType.htm",
                params: {
                    "stationid": 3000
                }
            }).success(function (msg) {
                $scope.queryDeviceTypeSuccess(msg);
            });
        };
        $scope.getDeviceType();

        $scope.queryDeviceTypeSuccess = function (msg) {
            var list = msg.data;
            var newArr = [];
            if(!list || list.length ==0) {
            	$("#tabList").html('<li></li>');
            	$('#nextPage').addClass('disabled');
            	$('#curPage').text("0");
            	$('#pageNums').text("0");
            	return;
            }
            for(var i in list){
                switch(list[i].devtype){
                    case "风电机组" :
                        newArr.push(list[i]);
                        break;
                    case "测风塔" :
                        newArr.push(list[i]);
                        break;
                }
            }
            newArr = newArr.reverse();
            var liTpl = "";
            for(var i = 0;i < newArr.length;i++){
                liTpl += '<li>'+newArr[i].devtype+'</li>';
            }
            deviceType = newArr[0].devtype;
            $scope.timerFlag = deviceType;

            $("#tabList").html(liTpl);
            $('#tabList li:first-child').addClass("active");

            switch($scope.timerFlag){
                case "测风塔": $('#deviceTabs .to-trigger').eq(0).trigger('click');
                    break;
                case "风电机组": $('#deviceTabs .to-trigger').eq(1).trigger('click');
                    break;
            }
        };

        //分页显示数量
        $('#singleNum').on('change', function() {
            $('#curPage').text(1);
            $scope.broadTab();
        });
        $scope.goPage = function () {
            var goPageNum = $('#goPageNum').val();
            var pageNums = parseInt($('#pageNums').text());
            var curPage = parseInt($('#curPage').text());
            if (goPageNum!=curPage && goPageNum!='' && goPageNum<=pageNums) {
                $('#curPage').text(goPageNum);
                $scope.broadTab()
            }
        }
        //上一页
        $scope.prevPage = function () {
            var curPage = parseInt($('#curPage').text());
            if (curPage > 1 ) {
                curPage = curPage - 1;
                if (curPage<=1) {
                    $('#prevPage').addClass('disabled');
                }
                $('#curPage').text(curPage);
                $scope.broadTab();
            }
        };
        //下一页
        $scope.nextPage = function () {
            var curPage = parseInt($('#curPage').text());
            var pageNums = $('#pageNums').text();
            if (curPage < pageNums) {
                curPage = curPage + 1;
                $('#prevPage').removeClass('disabled');
                $('#curPage').text(curPage);
                $scope.broadTab();
            }
        };

        $scope.broadTab = function () {
            var curTab = $('#tabList li.active').index();
            if ($scope.timerFlag == "测风塔") {
                $scope.$broadcast("filterPageBox", curPage);
            } else if ($scope.timerFlag == "风电机组") {
                $scope.$broadcast("filterPageInvert", curPage);
            }
        };

        $scope.$on('broadcastSwitchStation', function(event, data) {
            $.ajax({
                type:"post",
                url:"${ctx}/UserAuthHandle/getCurrentInfo.htm",
                success:function(msg){
                    if(msg.result){
                        $scope.parentId = msg.currentSTID;
                        $scope.powerStationId = msg.currentSTID;
                        $scope.parentName = msg.currentSTName;
                    }
                }
            });
        });

        if($stateParams.stationId){
            $scope.parentId = $stateParams.stationId;
            $scope.powerStationId = $stateParams.stationId;
            $scope.parentName = $stateParams.stationName;
        }else{
            $.ajax({
                type:"post",
                url:"${ctx}/UserAuthHandle/getCurrentInfo.htm",
                success:function(msg){
                    if(msg.result){
                        $scope.parentId = msg.currentSTID;
                        $scope.powerStationId = msg.currentSTID;
                        $scope.parentName = msg.currentSTName;
                    }
                }
            });
        }
        $scope.$on('$stateChangeStart', function(event) {
            clearInterval(headTimer);
        });

        //仅刷新所停留页面的数据
        $scope.rtStatistics = function(flag) {
            if(flag == 0){
                deviceType = "测风塔";
                $scope.timerFlag = deviceType;
                getWpWindTowerData($scope, $http);
            }else if(flag == 1){
                deviceType = "风电机组";
                $scope.timerFlag = deviceType;
                getWpWindTurbineData($scope,$http);
            }
            $scope.$emit('deviceType', deviceType);
        };
    });
</script>
