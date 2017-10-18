
app.controller('wpMonitoringCtrl', function($scope, $rootScope, $http, $state, $stateParams, $document) {
    
	//打开本页面的日期，进入下一天时自动刷新页面
	$scope.comeDate = new Date();
	
	$scope.getCurrentDataName('00',1);
    $rootScope.posJcvFlag = true;

    $scope.$on('broadcastSwitchStation', function(event, data) {
        $scope.currentDataName = data.dataName;
        $scope.refreshViewDataForHead();
    });

    $scope.getCurrentInfo = function() {
        $http({
            method : "POST",
            url : "./UserAuthHandle/getCurrentInfo.htm"
        }).success(function(msg) {
            $scope.userId = msg.currentRole;
            if(msg.currentSTNum > 1){
                $rootScope.posJcvFlag = false;
            }
        })
    };
    $scope.getCurrentInfo();

    $scope.showPowerIndexData = "";
    $scope.showRealPower=function(flag){
        if($rootScope.posJcvFlag){
            //当前为单个电站
            switch (parseInt(flag)){
                case 1:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/wp/rtMonitorPage/monitor/modal/wpShowWeatherPowerModal.jsp";
                    break;
                case 2:
                    $('#powerIndexModal').modal();
                    if ($scope.dailyJt){
                        $scope.showPowerIndexData="tpl/wp/rtMonitorPage/monitor/modal/wpWindTurbineData.jsp";
                    }else {
                        $scope.showPowerIndexData="tpl/rtMonitorPage/monitor/staTodayPower.jsp";
                    }
                    break;
                case 3:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/wp/rtMonitorPage/monitor/modal/wpStaMonModal.jsp";
                    break;
                case 4:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/wp/rtMonitorPage/monitor/modal/wpStaYearModal.jsp";
                    break;
                default:
                    break;
            }
            $('#powerIndexModal').on('shown.bs.modal', function (e) {});
        }else{
            //当前为多个电站
            switch (parseInt(flag)){
                case 1:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/rtMonitorPage/monitor/mulPowerModel/real_time.jsp";
                    break;
                case 2:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/rtMonitorPage/monitor/mulPowerModel/daily_quantity.jsp";
                    break;
                case 3:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/rtMonitorPage/monitor/mulPowerModel/monthly_quantity.jsp";
                    break;
                case 4:
                    $('#powerIndexModal').modal();
                    $scope.showPowerIndexData="tpl/rtMonitorPage/monitor/mulPowerModel/year_quantity.jsp";
                    break;
                default:
                    break;
            }
            $('#powerIndexModal').on('shown.bs.modal', function (e) {});
        }
    };
    $scope.shows = function(){
        $('#powerIndexModal').modal();
        $scope.showPowerIndexData = "tpl/blocks/switchPower.jsp";
    };

    //关闭弹出层
    $scope.hiddenModal=function(){
        $('#powerIndexModal').modal("hide");
        $scope.showPowerIndexData="";
    };

    $scope.stid = 1;
    //根据日月年，切换日期
    $scope.changeTime = "日";
    var rightDay = new Date();
    //只能取到前一天
    rightDay.setDate(rightDay.getDate());
    $scope.today = rightDay;

    //点击选择时间
    $("#changeTimeIdTimer").datetimepicker({
        language : 'zh-CN',
        format : "yyyy-mm-dd",
        minView : 2,
        autoclose : true,
        todayBtn : true,
        endDate : new Date(),
        pickerPosition : "bottom-left"
    });
    $("#changeTimeIdTimer").on('show',function(ev){
        $(".map-jt").addClass("effiJt");
    });
    $("#changeTimeIdTimer").on('hide',
        function(ev) {
            // 获取某个时间格式的时间戳
            var stringTime = $("#dtp_input2").val();

            if(stringTime){
                var timestamp2 = Date.parse(getDateForStringDate(stringTime));
                $scope.mapTimeDay = timestamp2
                $("#changeTimeId1").text(new Date(timestamp2).Format("yyyy-MM-dd"))
                $scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.today).Format("yyyy-MM-dd"))
            }

            //判断箭头
            $("#leftJt").removeClass("effiJt")
            if ($scope.dailyJt) {
                $("#rightJt").addClass("effiJt");
            } else {
                $("#rightJt").removeClass("effiJt");
            }

            //切换时间后，重新加载整个界面的数据
            $scope.getDataForChangeTime($scope.dailyJt);
            $scope.changeTimer($scope.dailyJt)
        });

    //	}
    if ($stateParams.analData) {//首页带进来的参数
        $scope.mapTimeDay = new Date(parseInt($stateParams.analData)).getTime();

        $scope.mapTimeDayRefresh = new Date(parseInt($stateParams.analData)).Format("yyyy-MM-dd")
    } else {
        $scope.mapTimeDay = $scope.today;
        $scope.mapTimeDayRefresh = $scope.today.Format("yyyy-MM-dd")
    }

    $scope.changeTimeId = 1;

    $scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.today).Format("yyyy-MM-dd"))
    $scope.changeDate = function(changeDateFlag) {
        $scope.changeTimeId = changeDateFlag
        if (changeDateFlag == "1") {//日
            $scope.changeTime = "日";
            $("#changeTimeId1").removeClass("hidden");
            $("#changeTimeId1").siblings().addClass("hidden");
        }
    };
    $scope.dateLeft = function() {
        if ($scope.changeTimeId == "1") {//日
            $scope.mapTimeDay = $scope.mapTimeDay - 1000* 60 * 60 * 24;
        }
        $scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.today).Format("yyyy-MM-dd"))

        //将日期广播出去
        $scope.getDataForChangeTime($scope.dailyJt);
        $scope.changeTimer($scope.dailyJt);
    };
    $scope.dateRight = function() {
        if (new Date($scope.mapTimeDay).Format("yyyy-MM-dd") == new Date($scope.today).Format("yyyy-MM-dd")) {
            return false
        }
        if ($scope.changeTimeId == "1") {//日
            $scope.mapTimeDay = $scope.mapTimeDay + 1000* 60 * 60 * 24;
        }
        $scope.dailyJt = (new Date($scope.mapTimeDay)
                .Format("yyyy-MM-dd")) == (new Date(
                $scope.today).Format("yyyy-MM-dd"));

        //将日期广播出去
        $scope.getDataForChangeTime($scope.dailyJt);
        $scope.changeTimer($scope.dailyJt);
    };
    $scope.commCount = 0;
    $scope.commnullCount = 0;
    //当前界面的获得全部数据
    $scope.getstaDayData=function(){
        $http({
            method : "POST",
            url : "./WpRtmStationMonitor/getRunTimeMonitor.htm",
            timeout: 5000,
            params : {
                'dateString':new Date($scope.mapTimeDay).Format("yyyy-MM-dd"),
                'powerStationId': null //null //$scope.powerStationId
            }
        }).success(function (msg) {
            $scope.statDayData = msg;
            if (msg.comm == 1) {
                //通讯中断
                $("#comm_interruptDev").show();
                $("#comm_initDev").hide();
                $("#response_respStatus").hide();
                $("#response_respStatusnull").hide();
                $scope.commCount = 0;
                $scope.commnullCount = 0;
            } else if (msg.comm == 2) {
                $("#comm_initDev").show();
                $("#comm_interruptDev").hide();
                $("#response_respStatus").hide();
                $("#response_respStatusnull").hide();
                $scope.commCount = 0;
                $scope.commnullCount = 0;
            } else if (msg.comm == null && $scope.dailyJt) {
                $scope.commCount = 0;
                $scope.commnullCount++;
                if($scope.commnullCount > 3){
                    $("#comm_initDev").hide();
                    $("#comm_interruptDev").hide();
                    $("#response_respStatus").hide();
                    $("#response_respStatusnull").show();
                }

            } else {
                $scope.commCount = 0;
                $scope.commnullCount = 0;
                $("#comm_interruptDev").hide();
                $("#comm_initDev").hide();
                $("#response_respStatus").hide();
                $("#getPowerStationRtData").show();
                $("#response_respStatusnull").hide();
            }
            responseHeight();
        }).error(function(msg){
            $scope.commnullCount = 0;
            $scope.commCount++;
            if ($scope.commCount > 3){
                $("#response_respStatus").show();
                $("#comm_interruptDev").hide();
                $("#comm_initDev").hide();
                $("#response_respStatusnull").hide();
            }
            responseHeight();
        });
    };

    $scope.powerStationId = null;
    $scope.pstationName = null;
    $scope.pstationAddress = null;

    //监听电站切换
    $scope.refreshViewDataForHead = function () {
        clearInterval(timer1);
        clearInterval(timer2);
        $scope.getLoginUserPS();
    };
    $scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

    $scope.getAllDataForChangeST = function (daiJt) {

        //得到实时功率
        $scope.getstaDayData();
        if(daiJt){
            //得到实时功率趋势图
            getActPwrLineData2($http, $scope);
        }else{
            //得到历史功率趋势图
            getActPwrLineData($http, $scope);
        }
        //获得定位数据
        getStatisticalData($http, $scope);

    };

    $scope.getDataForChangeTime = function (daiJt) {
        //得到实时功率
        $scope.getstaDayData();
        $scope.$broadcast("dateChangeCtrl", $scope.mapTimeDay);
        if(daiJt){
            //得到实时功率趋势图
            getActPwrLineData2($http, $scope);
        }else{
            //得到历史功率趋势图
            getActPwrLineData($http, $scope);
        }
        $scope.isTodayBoolean = new Date($scope.mapTimeDay).Format("yyyy-MM-dd") == new Date().Format("yyyy-MM-dd");
    };
    $scope.isTodayBoolean = new Date($scope.mapTimeDay).Format("yyyy-MM-dd") == new Date().Format("yyyy-MM-dd");
    //根据当前登陆用户加载数据
    $scope.getLoginUserPS = function() {
        $http.get("./Login/getLoginUser.htm").success(
            function(result) {
                $scope.powerStationId = result.pstationid;
                $scope.parentName = result.pstationName;
                $scope.pstationAddress = result.pstationAddress;
                $scope.getAllDataForChangeST($scope.dailyJt);
                $scope.changeTimer($scope.dailyJt);
                $scope.$broadcast("sationIdChangeCtrl", $scope.powerStationId);
            }).error(function(response) {
        });
    };
    //根据当前用户加载电站列表
    CommonPerson.Base.LoadingPic.PartShow('result_table');//加载状态
    //电站列表
    $scope.stationScopeStr = ""; //切换电站

    //切换电站
    $scope.changeStation = function(id) {
        $scope.powerStationId = id;
        $http.get("./PowerStation/selectByIdForMonitor.htm", {
            params : {
                id : $scope.powerStationId
            }
        }).success(function(result) {
            $scope.pstationAddress = result.address;
            $scope.parentName = result.stationname;
            $("#deviceStationId").show();
            $("#deviceLayoutId").show();
            $scope.getFactList();
            $scope.weatherId = null;
            $scope.serialnumber = null;
            $scope.parentId = null;
        }).error(function(response) {
        });
    };

    //离开当前界面
    $scope.$on('$stateChangeStart', function(event) {
        clearInterval(timer1);
        clearInterval(timer2);
        CommonPerson.Base.LoadingPic.FullScreenHide();
    });
    //获得天气
    $scope.getWeatherData = function(flag) {
        getWeatherData($http, $scope);
        if (flag == 1) {
            getNext3DayWeatherData($http, $scope)
        }
    };
    if ($stateParams.stationId) {
        $scope.getLoginUserPS();
    } else {
        $scope.getLoginUserPS();
        hideGoBackFlag();
    }
    $scope.refreshData = function(){
        $scope.getstaDayData();
        //得到更新时间等数据
        getRtData($http, $scope);
    };
    //根据时间判断定时器
    $scope.changeTimer=function(daiJt){
        if(daiJt){
            timer1 = setInterval(function() {
            	if($scope.comeDate.Format("yyyy-MM-dd") == new Date().Format("yyyy-MM-dd")){
					$scope.refreshData();
				}else{
					location.reload();
				}
            }, 5000);
        }else{
            clearInterval(timer1);
            clearInterval(timer2);
        }

    };
    $document.on('screenfull.raw.fullscreenchange', function () {
        if(responseHeight){responseHeight();};
    });
});
var timer1, timer2;
function getDatas($http, $scope) {
    getRtData($http, $scope);
    getActPwrLineData($http, $scope); //统计图数据
    getStatisticalData($http, $scope); //定位
    getWeatherData($http, $scope);   //天气情况

}

function getStatisticalData($http, $scope) {
    $http.get("./UserAuthHandle/getCurrentStationInfo.htm", {
    }).success(function(response) {
        $scope.stationData = response;
    }).error(function(response, msg) {

    });
}
//气象数据
function getWeatherData($http, $scope) {
}
//未来三天的气象数据
function getNext3DayWeatherData($http, $scope) {
    $http.get("./PowerStationMonitor/getNext3DayWeatherData.htm", {
        params : {
            id : $scope.powerStationId,
            cityName : $scope.cityName
        }
    }).success(function(response) {
        $scope.cityName = response.cityName;
        if (response.respStatus == 1) {
            $scope.next3DayWeatherData = response.weatherData;
        }
    }).error(function(response) {
    });
}
//功率等实时数据
function getRtData($http, $scope) {
}
//功率趋势图  $scope.powerStationId
function getActPwrLineData($http, $scope) {
    $http({
        method : "POST",
        url : "./MobileHmDeviceMonitor/getDayChartRealTimePower.htm",
        params : {
            'userId':1,
            'dateString':new Date($scope.mapTimeDay).Format("yyyy-MM-dd"),
            //'powerStationId':$scope.powerStationId
        }
    })
        .success(function (msg) {
            if(!$scope.dailyJt){
                if(msg.echarts_xaxisTime==null){
                    getPowerV([],[],[],[])
                }else{
                    getPowerV(msg.echarts_xaxisTime,msg.echarts_predictPower,msg.echarts_power,msg.echarts_luminousIntensity,$http, $scope);
                }
            }
        }).error(function(msg){
    });
}
var  myChart;
function getPowerV(echarts_xaxisTime,echarts_predictPower,echarts_realTimePower,echarts_luminousIntensity,$http, $scope) {
	myChart = echarts.init(document.getElementById('ssglqx'))
    window.addEventListener("resize", function() {
        myChart.resize();
    });
    option = {
        title : {
            text : '功率趋势图',
            textStyle : {
                fontSize : 14,
                color : "#666",
                fontFamily : '微软雅黑',
                fontWeight : 'normal'
            }
        },
        tooltip : {
            trigger : 'axis',
            axisPointer : {
                type : 'line',
                lineStyle : {
                    color : '#bbb',
                    width : 1,
                    type : 'solid'
                }
            },
            formatter: function (params,ticket,callback) {
                var res = params[0].name;
                for (var i = 0, l = params.length; i < l; i++) {
                    if(params[i].value!=""&&!isNaN(params[i].value)){
                        res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
                        if(i==2){
                            //res += "m/s";
                        }else{
                            //res += "kW";
                        }
                    } else if(params[i].value==""){
                        res += '<br/>' + params[i].seriesName + ' : N/A';
                    }
                }
                return res;
            }
        },
        legend : {
            x : 'right',
            orient : 'horizontal',
            data : [ '应发功率', '实发功率', '光照强度' ]

        },
        noDataLoadingOption:{
            text : '暂无数据',
            effect :function(params,callback){
                return "暂无数据"
            }
        },
        calculable : true,
        grid : {
            borderWidth : '0px',
            x : '50px',
            x2 : '40px',
            y : "50px",
            y2 : "20px"
        },
        xAxis : [ {
            axisTick : {
                show : false
            },
            axisLabel : {
                interval : 59,
                textStyle : {
                    color : '#bbb',
                    fontSize : 12
                }
            },
            type : 'category',
            axisLine : {
                lineStyle : {
                    color : '#bbb',
                    width : 1
                }
            },
            splitLine : {
                show : false
            },
            boundaryGap : false,
            data : echarts_xaxisTime
        } ],
        yAxis : [ {
            axisLabel : {
                textStyle : {
                    color : '#bbb',
                    fontSize : 12
                }
            },
            name : 'kW',
            //name : powerVstr.name1,
            font : {
                color : '#bbb'
            },
            axisLine : {
                lineStyle : {
                    color : '#bbb',
                    width : 1
                }
            },
            splitLine : {
                show : false
            },
            type : 'value'
        }, {
            name : 'm/s',
            //name : powerVstr.name2,
            font : {
                color : '#bbb'
            },
            axisLine : {
                lineStyle : {
                    color : '#bbb',
                    width : 1
                }
            },
            splitLine : {
                show : false
            },
            type : 'value',
            axisLabel : {
                textStyle : {
                    color : '#bbb',
                    fontSize : 12
                },
                formatter : function(v) {
                    return v;
                }
            }
        } ],
        series : [{
            symbol : 'none',
            name : '应发功率',
            type : 'line',
            z : 1,
            itemStyle : {
                normal : {
                    color : 'rgb(66,139,202)',
                    areaStyle : {
                        color : 'transparent'
                    },
                    lineStyle : {
                        /* 	type : 'none',
                         width:2, */
                        color : 'rgba(66,139,202,.9)',
                        width : 1
                    }
                }
            },
            data : echarts_predictPower
        }, {
            symbol : 'none',
            name : '实发功率',
            type : 'line',
            z : 2,
            itemStyle : {
                normal : {
                    color : 'rgb(217, 83, 79)',
                    areaStyle : {
                        color : 'transparent'
                    },
                    lineStyle : {
                        /* 	type : 'none',
                         width:2, */
                        color : 'rgba(217, 83, 79,.9)',
                        width : 1
                    }
                }
            },
            data : echarts_realTimePower
        }, {
            symbol : 'none',
            name : '光照强度',
            type : 'line',
            z : 3,
            yAxisIndex : 1,
            itemStyle : {
                normal : {
                    color : '#f0ad4e',
                    areaStyle : {
                        color : 'transparent'
                    },
                    lineStyle : {
                        color : '#f0ad4e',
                        width : 1
                    }
                }
            },
            data : echarts_luminousIntensity
        }
        ]
    };
    myChart.setOption(option);
}
// 实时功率
function getPowerVForRT(echarts_xaxisTime,echarts_predictPower,echarts_power,echarts_windSpeed,$http, $scope) {

    myChart = echarts.init(document.getElementById('ssglqx'));
    window.addEventListener("resize", function() {
        myChart.resize();
    });
    option = {
        title : {
            text : '功率趋势图',
            textStyle : {
                fontSize : 14,
                color : "#666",
                fontFamily : '微软雅黑',
                fontWeight : 'normal'
            }
        },
        noDataLoadingOption:{
            text : '暂无数据',
            effect :function(params,callback){
                return "暂无数据"
            }
        },
        tooltip : {
            trigger: 'axis',
            zlevel:3,
            z:8,
            axisPointer:{
                type: 'line',
                lineStyle: {
                    color: '#bbb',
                    width: 1,
                    type: 'solid'
                }
            } ,
            formatter: function (params,ticket,callback) {
                var res = params[0].name;
                for (var i = 0, l = params.length; i < l; i++) {
                    if(params[i].value!=""&&!isNaN(params[i].value)){

                        res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
                        /*if(i==1){
                         res += powerVstr.name2;
                         }else{
                         res += powerVstr.name1;
                         }*/
                    } else if(params[i].value==""){
                        res += '<br/>' + params[i].seriesName + ' : N/A';
                    }
                }
                return res;
            }
        },
        legend : {
            x : 'right',
            orient : 'horizontal',
            data : [ '应发功率', '实发功率', '风速' ]

        },
        calculable : true,
        grid : {
            borderWidth : '0px',
            x : '50px',
            x2 : '40px',
            y : "50px",
            y2 : "20px"
        },
        xAxis : [ {
            axisTick : {
                show : false
            },
            //position : 'top',//X 轴显示的方位
            type : 'category',
            axisLine : {
                lineStyle : {
                    color : '#bbb',
                    width : 1
                },
            	onZero : false
            },
            axisLabel : {
                interval:59,
                axisLabel : 5,
                textStyle : {
                    color : '#bbb',
                    fontSize : 12
                }
            },
            splitLine : {
                show : false,
            },
            boundaryGap : false,
            show: true,
            data : echarts_xaxisTime
        } ],
        yAxis : [ {
            axisLabel : {
                textStyle : {
                    color : '#bbb',
                    fontSize : 12
                }
            },
            name : 'kW',
            // nameLocation:'start',
            font : {
                color : '#bbb'
            },
            axisLine : {
                lineStyle : {
                    color : '#bbb',
                    width : 1
                },
            },
            splitLine : {
                show : false
            },
            type : 'value'
        }, {
            show:true,
            name : 'm/s',
            // nameLocation:'start',
            font : {
                color : '#bbb'
            },
            axisLine : {
                lineStyle : {
                    color : '#bbb',
                    width : 1
                },
            },
            splitLine : {
                show : false
            },
            type : 'value',
            axisLabel : {
                textStyle : {
                    color : '#bbb',
                    fontSize : 12
                },
                formatter : function(v) {
                    return v;
                }
            }
        } ],
        series : [{
            symbol : 'none',
            name : '应发功率',
            type : 'line',

            z : 1,
            itemStyle : {
                normal : {
                    color : 'rgb(66,139,202)',
                    areaStyle : {
                        color : 'transparent'
                    },
                    lineStyle : {
                        /* 	type : 'none',
                         width:2, */
                        color : 'rgba(66,139,202,.9)',
                        width : 1
                    }
                }
            },
            data : echarts_predictPower
        }, {
            name : '实发功率',
            type : 'line',
            z : 1,
            itemStyle : {
                normal : {
                    color : 'rgb(217, 83, 79)',
                    areaStyle : {
                        color : 'transparent'
                    },
                    lineStyle : {
                        color : 'rgba(217, 83, 79,.9)',
                        width : 1
                    }
                }
            },
            symbol : 'none',
            data : echarts_power
        }, {
            name : '风速',
            type : 'line',
            yAxisIndex : 1,
            z : 2,
            itemStyle : {
                normal : {
                    color : '#f0ad4e',
                    areaStyle : {
                        color : 'transparent'
                    },
                    lineStyle : {
                        color : '#f0ad4e',
                        width : 1
                    }
                }
            },
            symbol : 'none',
            data : echarts_windSpeed
        }
        ]
    };
    myChart.setOption(option);

    timer2 = setInterval(function(){
        $http.get("./WpRtmStationMonitor/getRunTimeChartPower.htm",
            {params : {},timeout: 5000
            }).success(function(response) {
            option.series[2].data = response.echarts_windSpeed;
            option.series[1].data = response.echarts_power;
            option.series[0].data = response.echarts_predictPower;
            myChart.setOption(option,true);
        }).error(function(response) {
        });
    },6000);
}

function getActPwrLineData2($http, $scope) {
    $http.get(
        "./WpRtmStationMonitor/getRunTimeChartPower.htm",
        {
            params : {
                powerStationId :  3000, //$scope.powerStationId,
                dateString: new Date($scope.mapTimeDay).Format("yyyy-MM-dd")
            }
        }).success(function(response) {
        if(response.echarts_xaxisTime==null){
            getPowerVForRT([],[],[],[]);
        }else{
            getPowerVForRT(response.echarts_xaxisTime, response.echarts_predictPower, response.echarts_power, response.echarts_windSpeed, $http, $scope);
        }
    }).error(function(response) {
    });
}

function FormatDate(strTime) {
    var date = new Date(strTime);
    return date.getFullYear() + "年" + (date.getMonth() + 1) + "月"
        + date.getDate() + "日";
}
Date.prototype.Format = function(fmt) { //author: meizz
    var o = {
        "M+" : this.getMonth() + 1, //月份
        "d+" : this.getDate(), //日
        "h+" : this.getHours(), //小时
        "m+" : this.getMinutes(), //分
        "s+" : this.getSeconds(), //秒
        "q+" : Math.floor((this.getMonth() + 3) / 3), //季度
        "S" : this.getMilliseconds()
        //毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    for ( var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
                : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
function getDateForStringDate(strDate){
    //切割年月日与时分秒称为数组
    var s = strDate.split(" ");
    var s1 = s[0].split("-");
    var s2 = s[1].split(":");
    if(s2.length==2){
        s2.push("00");
    }
    return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
}
