<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder panel fault-rt-b-t" ng-controller="WindTurbineCtrl">
    <div id="windTurbine-table2"></div>
    <div class="col-sm-12 no-padder" ng-grid="gridOptions" id="windTurbine-table"></div>
</div>

<script type="text/javascript">
    var bcTimer;
    app.controller('WindTurbineCtrl', function($scope, $http, $state, $document) {
        $document.on('screenfull.raw.fullscreenchange', function () {
            if(responseHeight){responseHeight();};
        });
        //过滤
        $scope.$on("filterPageBox", function (event, msg) {
            getWpWindTurbineData($scope, $http);
        });

        $scope.$on('refreshViewDataForHead', function(event, data) {
            clearInterval($scope.bcTimer);
            getWpWindTurbineData($scope, $http);
            $scope.bcTimer = setInterval(function() {
                if($scope.timerFlag == "风电机组" ){
                    getWpWindTurbineData($scope, $http);
                }
            }, 5000);
        });

        $scope.$on('$stateChangeStart', function(event) {
            clearInterval($scope.bcTimer);
        });

        $scope.bcTimer = setInterval(function() {
            if($scope.timerFlag == "风电机组" ){
                getWpWindTurbineData($scope, $http);
            }
        }, 5000);

        $scope.startInit = function () {
            if($scope.timerFlag == "风电机组"){
                getWpWindTurbineData($scope, $http);
            }
        };
        $scope.startInit();

        $scope.gridOptions = {
            data : 'myDataWindTurbine',
            enablePinning : true,
            enableCellSelection : true,
            columnDefs : [
                {
                    field : 'statusDesc',
                    displayName : '状态',
                    width : 80,
                    pinned : true,
                    cellClass : 'text-center',
                    cellTemplate: 'tpl/rtMonitorPage/deviceStation/colourOf-COMM_STATUS.html'
                },
                {
                    field : 'did',
                    displayName : '编号',
                    width : 60,
                    pinned : true
                },
                {
                    field : 'name',
                    displayName : '名称',
                    width : 150,
                    pinned : true,
                    cellTemplate : ' <span class="nowrap href-blur" data-toggle="tooltip" data-placement="bottom" style="line-height: 40px;" title="{{row.getProperty(col.field)}}" ng-click="showWindTurbineData(row.getProperty(\'id\'),row.getProperty(\'did\'),row.getProperty(\'sid\'));">{{row.getProperty(col.field)}}</span>'
                },
                {
                    field : 'dtime',
                    displayName : '时间',
                    width : 150,
                    cellFilter : 'date:"yyyy-MM-dd HH:mm:ss"',
                    pinned : true,
                    cellClass : 'text-center'
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
    });
    function cleanbBoxChangeData($scope) {
        $scope.myDataBC = null;
    }

    var windTurbineflag = 0;
    function getWpWindTurbineData($scope, $http, callback) {
        if(windTurbineflag == 0){
            $("#windTurbine-table").hide();
            CommonPerson.Base.LoadingPic.PartShow('windTurbine-table2');
        }
        $http({
            method : "POST",
            url : "${ctx}/WpDeviceStation/getRealtimeWindTurbine.htm",
            params : {
                pstationid: 3000, //$scope.powerStationId,
                pageIndex: $('#curPage').text(),
                pageSize: $('#singleNum').val(),
                search: $('#searchWords').val()
            }
        }).success(function(result) {
            if(windTurbineflag == 0){
                partHide('windTurbine-table2');
                $("#windTurbine-table").show();
            }
            windTurbineflag = 1;
            var pageNums = Math.ceil(result.total/result.pageSize);
            $('#pageNums').text(pageNums);
            if ($('#prevPage')<=1) {$('#nextPage').addClass('disabled');}
            if (pageNums > $('#curPage').text()) {
                $('#nextPage').removeClass('disabled');
            } else {
                $('#nextPage').addClass('disabled');
            }
            if (result.data !== null) {
                for (var i = 0; i < result.data.length; i++) {
                    result.data[i].dtime = parseInt(result.data[i].dtime)*1000;
                }
            }
            $scope.RealData = result.data;
            $scope.myDataWindTurbine = $scope.RealData;
        });
    }
    function responseHeight3(){
        $("#windTurbine-table").css("height", $(window).height() - 210);
        $("#windTurbine-table").css("width", $("#deviceTabs").width());
    }
    responseHeight3();
    window.addEventListener("resize", function() {
        responseHeight3();
    });
</script>