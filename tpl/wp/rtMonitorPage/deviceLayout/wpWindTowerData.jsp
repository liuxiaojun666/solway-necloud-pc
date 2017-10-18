<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder panel fault-rt-b-t" ng-controller="WindTowerCtrl">
    <div id="windTower-table2"></div>
    <div class="col-sm-12 no-padder" ng-grid="gridOptions" id="windTower-table"></div>
</div>

<script type="text/javascript">
    var bcTimer;
    app.controller('WindTowerCtrl', function($scope, $http, $state, $document) {
        $document.on('screenfull.raw.fullscreenchange', function () {
            if(responseHeight){responseHeight();};
        });
        //过滤
        $scope.$on("filterPageBox", function (event, msg) {
            getWpWindTowerData($scope, $http);
        });

        $scope.$on('refreshViewDataForHead', function(event, data) {
            clearInterval($scope.bcTimer);
            getWpWindTowerData($scope, $http);
            $scope.bcTimer = setInterval(function() {
                if($scope.timerFlag == "测风塔" ){
                    getWpWindTowerData($scope, $http);
                }
            }, 5000);
        });

        $scope.$on('$stateChangeStart', function(event) {
            clearInterval($scope.bcTimer);
        });

        $scope.bcTimer = setInterval(function() {
            if($scope.timerFlag == "测风塔" ){
                getWpWindTowerData($scope, $http);
            }
        }, 5000);

        $scope.startInit = function () {
            if($scope.timerFlag == "测风塔"){
                getWpWindTowerData($scope, $http);
            }
        };
        $scope.startInit();

        $scope.gridOptions = {
            data : 'myDataWindTower',
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
                    cellTemplate : ' <span class="nowrap href-blur" data-toggle="tooltip" data-placement="bottom" style="line-height: 40px;" title="{{row.getProperty(col.field)}}" ng-click="showWindTowerData(row.getProperty(\'id\'),row.getProperty(\'did\'),row.getProperty(\'sid\'));">{{row.getProperty(col.field)}}</span>'
                },
                {
                    field : 'dtime',
                    displayName : '时间',
                    width : 150,
                    cellFilter : 'date:"yyyy-MM-dd HH:mm:ss"',
                    pinned : true,
                    cellClass : 'text-center'
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
                }]
        };
    });

    function cleanbBoxChangeData($scope) {
        $scope.myDataBC = null;
    }

    var windTowerflag = 0;
    function getWpWindTowerData($scope, $http, callback) {
        if(windTowerflag == 0){
            $("#windTower-table").hide();
            CommonPerson.Base.LoadingPic.PartShow('windTower-table2');
        }
        $http({
            method : "POST",
            url : "${ctx}/WpDeviceStation/getRealtimeWindTower.htm",
            params : {
                pstationid: 3000, //$scope.powerStationId,
                pageIndex: $('#curPage').text(),
                pageSize: $('#singleNum').val(),
                search: $('#searchWords').val()
            }
        }).success(function(result) {
            if(windTowerflag == 0){
                partHide('windTower-table2');
                $("#windTower-table").show();
            }
            windTowerflag = 1;
            var curTab = $('#tabList li.active').index();
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
            $scope.myDataWindTower = $scope.RealData;
        });
    }
    function responseHeight3(){
        $("#windTower-table").css("height", $(window).height() - 210);
        $("#windTower-table").css("width", $("#deviceTabs").width());
    }
    responseHeight3();
    window.addEventListener("resize", function() {
        responseHeight3();
    });
</script>