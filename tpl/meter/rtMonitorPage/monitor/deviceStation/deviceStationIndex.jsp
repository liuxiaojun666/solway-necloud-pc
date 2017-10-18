<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<style>
	#deviceTabs ul.nav.nav-tabs {display: none;}
</style>
<div ng-controller="meterDeviceStationCtrl">
	<!-- 头部布局 -->
	<div div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;line-height: 50px;">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
    <!-- nabar right -->
    <ul class="nav navbar-nav navbar-right m-r-xxl" name="selectListLegend">
        <a class="btn no-shadow navbar-btn normalBtn" ng-click="selectListLegend('normalBtn')">
            <i class="fa fa-circle-o"  style="display: none;color: #3fad22;"/><i class="fa fa-check-circle-o" style="color: #3fad22;" /> 正常
            <input type="hidden" value="" name="normal_deviceId_jqselect"/>
        </a>
        <a class="btn no-shadow navbar-btn errorBtn" ng-click="selectListLegend('errorBtn')">
            <i class="fa fa-circle-o" style="display: none;color: #db412f;"/><i class="fa fa-check-circle-o" style="color: #db412f;" /> 故障
            <input type="hidden" value="" name="error_deviceId_jqselect"/>
        </a>
        <a class="btn no-shadow navbar-btn alertBtn" ng-click="selectListLegend('alertBtn')">
            <i class="fa fa-circle-o" style="display: none;color: #f90;"/><i class="fa fa-check-circle-o" style="color: #f90;" /> 报警
            <input type="hidden" value="" name="alert_deviceId_jqselect"/>
        </a>
        <a class="btn no-shadow navbar-btn breakBtn" ng-click="selectListLegend('breakBtn')">
            <i class="fa fa-circle-o" style="display: none;color: #999;"/><i class="fa fa-check-circle-o" style="color: #999;" /> 中断
            <input type="hidden" value="" name="break_deviceId_jqselect"/>
        </a>
    </ul>
    <ul class="nav navbar-nav navbar-right m-r-xxl" name="selectListLegend_All">
        <i class="fa fa-hourglass-half" name="zuchuanLoading" style="display: none;"/>
        <a class="btn no-shadow navbar-btn allBtn" ng-click="selectListLegend_All('allBtn')">
            <i class="fa fa-circle-o" style="display: none;"/><i class="fa fa-check-circle" style="color: #333"/> 全选
            <input type="hidden" value="" name="all_deviceId_jqselect"/>
        </a>
    </ul>
    <!-- / navbar right -->
</div>
<div class="row-row" style="padding: 10px;" id="styleDiv">
	<div class="col-xs-12" style="overflow: hidden;">
		<div id="response_respStatus" class="alert alert-danger" role="alert" style="margin: 20px 0;display:none;">未接收到任何数据。请等待...</div>
		<div id="response_respStatusnull" class="alert alert-danger" role="alert" style="margin: 20px  0;display:none;">返回数据异常！</div>
		<div id="comm_interruptDev" 	class="alert alert-danger" role="alert" style="margin: 20px 0;display:none;">
			通讯中断故障！已中断<span ng-bind="statDayData.commInterruptTime"></span>，最后更新于
			<span ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss'"></span>
		</div>
		<div id="comm_initDev"  class="alert alert-info" role="alert" style="margin: 20px 0;display:none;">设备初始化，未接收到任何数据。请等待...</div>
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
                <tab>
                    <div id="bBoxChangeData" data-ng-include="'${ctx}/tpl/meter/rtMonitorPage/monitor/deviceStation/bBoxChangeData.jsp'"></div>
                </tab>
            </div>
    </div>
</div>
</div>
<script type="text/javascript">
	$('#curPage').text(1);

function showfilterArr() {
    var filterArr = [];
    if ($(".allBtn .fa-check-circle").is(':visible')){//全选
        filterArr.push('00');
    }
    if ($('.normalBtn .fa-check-circle-o').is(':visible')) {//正常运行
        filterArr.push('01');
    }
    if ($('.errorBtn .fa-check-circle-o').is(':visible')) {//"故障"
        filterArr.push('02');
    }
    if ($('.alertBtn .fa-check-circle-o').is(':visible')) {//"报警"
        filterArr.push('03');
    }
    if ($('.breakBtn .fa-check-circle-o').is(':visible')) {//"中断"
        filterArr.push('04');
    }
    return filterArr;
}

var headTimer;
    var deviceType = "";
app.controller('meterDeviceStationCtrl', function($scope, $http, $state, $stateParams) {

	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.getDeviceType2();
	});
	
	 //获取设备分类
    $scope.getDeviceType2 = function(){
        $http({
                method : "POST",
                url :"${ctx}/DeviceStation/getDeviceType.htm"
            }).success(function (msg) {
                var list = msg.data;
                var newArr = [];
                for(var i in list){
                    switch(list[i].devtype){
                        case "汇流箱" : newArr.push(list[i])
                                    break;
                        case "逆变器" : newArr.push(list[i])
                                    break;
                        case "箱变" : newArr.push(list[i])
                                    break;
                    }
                }
                newArr = newArr.reverse();
                var liTpl = "";
                for(var i = 0;i < newArr.length;i++){
                    liTpl += '<li>'+newArr[i].devtype+'</li>';
                }
                
                deviceType = newArr[0].devtype;
                $scope.timerFlag =deviceType;
        });
    };
	
    //过滤搜索
    $scope.filterSearch = function () {
        $scope.broadTab();
    }
    //状态选择
    $scope.selectListLegend = function(legendICO){
        legendICO = $("."+legendICO);
        if($(legendICO).find('i:eq(0)').is(":visible")==true){
            $(legendICO).find('i:eq(0)').hide();
            $(legendICO).find('i:eq(1)').show();
            if($(legendICO).siblings().find('i:eq(0)').is(":visible")==true){
                $(legendICO).parent().next().children().find('i:eq(0)').show();
                $(legendICO).parent().next().children().find('i:eq(1)').hide();
            }else{
                $(legendICO).parent().next().children().find('i:eq(0)').hide();
                $(legendICO).parent().next().children().find('i:eq(1)').show();
            }
        }else{
            $(legendICO).find('i:eq(0)').show();
            $(legendICO).find('i:eq(1)').hide();
            $(legendICO).parent().next().children().find('i:eq(0)').show();
            $(legendICO).parent().next().children().find('i:eq(1)').hide();
        };
        $scope.broadTab();
    }
    //全选
    $scope.selectListLegend_All = function(){
        legendICO = $('.allBtn');
        if($(legendICO).find('i:eq(0)').is(":visible")==true){
            $(legendICO).find('i:eq(0)').hide();
            $(legendICO).find('i:eq(1)').show();
            $(legendICO).parent().prev().children().find('i:eq(0)').hide();
            $(legendICO).parent().prev().children().find('i:eq(1)').show();
        }else{
            $(legendICO).find('i:eq(0)').show();
            $(legendICO).find('i:eq(1)').hide();
            $(legendICO).parent().prev().children().find('i:eq(0)').show();
            $(legendICO).parent().prev().children().find('i:eq(1)').hide();
        };
        $scope.broadTab();
    }
    //分页显示数量
    $('#singleNum').on('change', function() {
        $('#curPage').text(1)
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
        };
    };

    $scope.broadTab = function () {
        if ($scope.timerFlag == "箱变") {
            $scope.$broadcast("filterPageBox", curPage);
        } else if ($scope.timerFlag == "逆变器") {
            $scope.$broadcast("filterPageInvert", curPage);
        } else if ($scope.timerFlag == "汇流箱") {
            $scope.$broadcast("filterPageJunction", curPage);
        }
    }

    $scope.getWeatherData = function(flag) {
        getWeatherData($http, $scope);
        if(flag==1){
            getNext3DayWeatherData($http, $scope)
        }
    }
    $scope.$on('broadcastSwitchStation', function(event, data) {
        //getStatisticalData($http, $scope);
        //$scope.getWeatherData();
        //getRtData($http, $scope);
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
    //getStatisticalData($http, $scope);
    //$scope.getWeatherData();
    //getRtData($http, $scope)
    $scope.$on('$stateChangeStart', function(event) {
        clearInterval(headTimer);
    });

    //仅刷新所停留页面的数据
   
    $scope.rtStatistics = function(flag) {
        if(flag == 0){
            deviceType = "箱变";$scope.timerFlag =deviceType;
            getbBoxChangeData($scope,$http);
            //cleanbInverterData($scope);
            //cleanbJunctionData($scope);
        }else if(flag == 1){
            deviceType = "逆变器";$scope.timerFlag =deviceType;
            getbInverterDate($scope,$http);
            //cleanbBoxChangeData($scope);
            //cleanbJunctionData($scope);
        }else if(flag == 2){
            deviceType = "汇流箱";$scope.timerFlag =deviceType;
            getbJunctionData($scope,$http);
            //cleanbInverterData($scope);
            //cleanbBoxChangeData($scope);
        }
        //$scope.timerFlag = flag;
    $scope.$emit('deviceType',deviceType);
    }

    $scope.exportRTData = function(){
        CommonPerson.Base.LoadingPic.FullScreenShow("数据导出中，请稍后...");
        var url = "${ctx}/HistoryData/exportRTData.htm";
        url +='?stationid='+$scope.powerStationId;
        url +='&stationname='+$scope.parentName;
        var devicetype=3;
        if($scope.timerFlag == "箱变" ){
            devicetype = 2;
        }else if($scope.timerFlag == "逆变器" ){
            devicetype = 1;
        }
        url +='&devicetype='+devicetype;
        window.location.href = url;
        getSessionValueByKey("ExportRTData");
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

//装机统计数据
function getStatisticalData($http, $scope) {
    $http.get("${ctx}/PowerStationMonitor/getPowerStationTotalData.htm",
                    {
                        params : {
                            id : $scope.powerStationId
                        }
                    }).success(function(response) {
                $scope.totleData = response;
            }).error(function(response) {
});
}
//气象数据
function getWeatherData($http, $scope) {
}
//功率等实时数据
function getRtData($http, $scope) {
    $http.get(
                    "${ctx}/PowerStationMonitor/getPowerStationRtData.htm",
                    {
                        params : {
                            id : $scope.powerStationId
                        },timeout: 5000
                    }).success(function(response) {
                        if(response.respStatus==1){
                            $scope.powerData = response;
                            //$scope.stationLh = response.lh;
                        }
            }).error(function(response) {
                /*if(response==null){
                    promptObj('error','','请求累计发电量数据超时!');
                }else{
                    promptObj('error','','请求累计发电量数据出错!');
                }*/
            });
}
//未来三天的气象数据
function getNext3DayWeatherData($http, $scope) {
    $http.get("${ctx}/PowerStationMonitor/getNext3DayWeatherData.htm",
            {
                params : {
                    id : $scope.powerStationId,
                    cityName : $scope.cityName
                }
            }).success(function(response) {
                $scope.cityName = response.cityName;
                if(response.respStatus==1){
                    $scope.next3DayWeatherData = response.weatherData;
                }
    }).error(function(response){
    });
}
</script>
