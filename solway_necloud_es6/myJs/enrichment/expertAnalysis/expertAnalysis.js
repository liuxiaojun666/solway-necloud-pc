ajaxData({
// 分析类型
HighAnalysis_selectAnlsType: {
    name: 'GETHighAnalysis_selectAnlsType',
    data: {
        stationClass: '01'
    }
},
// 获取echarts图表
...((() => {
    const o = {};
    ['1', '2', '3'].forEach(v => {
        ['1', '2', '3', '401', '402', '403', '404', '405', '417', '418', '5', '101', '102'].forEach(vv => {
            ['0', '1', '2', '3', '4', '5'].forEach(vvv => {
                o['analysis_selectAnlsType' + v + vv + vvv] = {
                    name: `analysis_selectAnlsType${v}${vv}${vvv}`,
                    data: {},
                    later: true
                }
            })
        })
    });
    return o;
})()),

}, {
    anlsType: null,   //分析类型
    herizonData: {},  //横轴数据 纵轴数据
    dmsType: null,    //分析对象参数
    dmsTypeBs: [],    //电站|区域(部门)|集团  接口需要的数据
    dmsTypeAs: [],    //设备 参数
    dmsTimeDates: [], //时间 参数 时间数据
    fdX: {            //横轴指标字段 参数
        key: '',
        name: ''
    },
    fdY: {            //纵轴指标字段 参数
        key: '',
        name: ''
    },
    fds: [],          //横轴、纵轴指标 参数
    analysFds: [],    //分析指标 参数
    benchSort: null,  //对标分析 分析指标 排序
    fdStyle: null,
    bIdToName: {}     //busiId 和 name的映射

})('expertAnalysisCtrl', ['$scope', 'myAjaxData', 'actionRecord', '$interval', 'toaster'], ($scope, myAjaxData, historicalRecord, $interval, toaster) => {

    historicalRecord.init();// 历史记录 初始化
    $scope.beforeLoading = true; // 页面loading
    $scope.moduleName = '专家分析';//当前页面名称；
    $scope.endDate = new Date((+new Date) - 1000 * 60 * 60 * 24); // 日历可选 的截止日期
    historyInitCallback();

    // 当前页面行为记录初始化回调 获取行为记录
    async function historyInitCallback() {
        const historiData = historicalRecord.get();
        const { } = historiData;
        $scope.beforeLoading = false;
        await myAjaxData.timeout(0);
        $scope.$apply();
    };

    // 分析类型下拉框的数据获取
    $scope.HighAnalysis_selectAnlsType.subscribe(res => {
        $scope.selectData = res.body;
        analysisObjFun();
    });

    // 选中第一个下拉框 动态改变其他的下拉框
    $scope.queryData = {
        'analysisType': 1
    }

    //获取分析对象的数据
    function analysisObjFun() {
        //获取不同分析类型的数据
        var key;
        for (key in $scope.selectData) {
            if ($scope.queryData.analysisType == $scope.selectData[key].k) {
                $scope.analysObDataOld = $scope.selectData[key].ll;
            }
        }
        //将设备 和 其他数据分离
        $scope.analysObDataNew = $scope.analysObDataOld.filter((item) => {
            return item.k.substr(0, 1) != "4";
        })

        $scope.analysObDataNewDevice = $scope.analysObDataOld.filter((item) => {
            return item.k.substr(0, 1) == "4";
        })

        //向分析对象发送数据
        $scope.$broadcast('analysObDataNew', { 'analysObDataNew': $scope.analysObDataNew, 'analysObDataNewDevice': $scope.analysObDataNewDevice });

        //向横轴指标发送anlsType
        myAjaxData.config.anlsType = $scope.queryData.analysisType;
    }

    // $scope.hoverChart = 0;
    // function hoverChartFun() {
    //     var dd = document.getElementsByClassName('table1');
    //     for (let i = 0; i < dd.length; i++) {    
    //         dd[i].addEventListener('mouseover', function () {
    //             $scope.hoverChart = i;
    //         })
    //     }
    // }

    //---------------------------------关联分析 ->散点图方法组
    //获取 x轴和 y轴的 名字和单位
    function indexName() {
        $scope['xname' + $scope.checkChart] = myAjaxData.config.fdX.name;
        $scope['yname' + $scope.checkChart] = myAjaxData.config.fdY.name;
        var key;
        for (key in $scope.tableData.units) {
            if (key == myAjaxData.config.fdX.key) {
                $scope['xunits' + $scope.checkChart] = $scope.tableData.units[key];
            }
            if (key == myAjaxData.config.fdY.key) {
                $scope['yunits' + $scope.checkChart] = $scope.tableData.units[key];
            }
        }
    }
    //获取最大值 最小值
    function extreme(newArr) {
        if (newArr.length > 0) {
            var xArr = [];
            var yArr = [];
            newArr.map((item) => {
                xArr.push(item[0]);
                yArr.push(item[1]);
            })
            $scope.maxX = xArr.sort((a, b) => {
                return b - a;
            })[0];

            $scope.minX = xArr.sort((a, b) => {
                return a - b;
            })[0];

            $scope.maxY = yArr.sort((a, b) => {
                return b - a;
            })[0];
            $scope.minY = yArr.sort((a, b) => {
                return a - b;
            })[0];
            if ($scope.maxX > 0) {
                $scope.maxX = $scope.maxX * 1.1;
                $scope.maxX = $scope.maxX.toFixed(2);
            } else {
                $scope.maxX = $scope.maxX * 0.8;
                $scope.maxX = $scope.maxX.toFixed(2);
            }
            if ($scope.minX > 0) {
                $scope.minX = 0;
            } else {
                $scope.minX = $scope.minX * 1.1;
            }
            if ($scope.maxY > 0) {
                $scope.maxY = $scope.maxY * 1.1;
                $scope.maxY = $scope.maxY.toFixed(2);
            } else {
                $scope.maxY = $scope.maxY * 0.8;
                $scope.maxY = $scope.maxY.toFixed(2);
            }
            if ($scope.minY > 0) {
                $scope.minY = 0;
            } else {
                $scope.minY = $scope.minY * 1.1;
            }
        } else {
            $scope.minX = 0;
            $scope.minY = 0;
            $scope.maxX = 100;
            $scope.maxY = 100;
        }

    }
    //图表的setOption
    function chartOption(i, legend, series) {
        echarts.init(document.getElementById('container' + i)).setOption({
            color: [
                '#dd4444', '#fec42c', '#80F1BE', '#ff0000', '#ff6a00', '#d8ff00', '#7aff00', '#00ffdc', '#00ffff', '#7a00ff', '#c000ff', '#ff00e0', '#ff008d', '#ff0023'
            ],
            legend: legend,
            tooltip: {
                trigger: 'axis',
                formatter: function (params) {
                    var tooltipFormatter;
                    var xunits = $scope['xunits' + $scope.checkChart] ? $scope['xunits' + $scope.checkChart] : '';
                    if (params[0].axisValue != null) {
                        tooltipFormatter = `<div style="font-size: 12px;">${params[0].axisValue}${xunits}</div>`;
                    }
                    params.map(item => {
                        if (item.data[1] != null) {
                            var yunits = $scope['yunits' + $scope.checkChart] ? `(${$scope['yunits' + $scope.checkChart]})` : '';
                            tooltipFormatter += `<div style="font-size: 12px;">${item.seriesName} ${$scope['yname' + i]}${yunits}: ${item.data[1]} 时间:${item.data[2]}<br/></div>`;
                        }
                    })
                    return tooltipFormatter;
                },
                position: function (point, params, dom, rect, size) {
                    // 鼠标坐标和提示框位置的参考坐标系是：以外层div的左上角那一点为原点，x轴向右，y轴向下
                    // 提示框位置
                    var x = 0; // x坐标位置
                    var y = 0; // y坐标位置

                    // 当前鼠标位置
                    var pointX = point[0];
                    var pointY = point[1];

                    // 提示框大小
                    var boxWidth = size.contentSize[0];
                    var boxHeight = size.contentSize[1];

                    // boxWidth > pointX 说明鼠标左边放不下提示框
                    if (boxWidth > pointX) {
                        x = 5;
                    } else { // 左边放的下
                        x = pointX - boxWidth;
                    }

                    // boxHeight > pointY 说明鼠标上边放不下提示框
                    if (boxHeight > pointY) {
                        y = 5;
                    } else { // 上边放得下
                        y = pointY - boxHeight;
                    }

                    return [x, y];
                }
            },
            xAxis: {
                name: $scope['xunits' + $scope.checkChart] ? `${$scope['xname' + $scope.checkChart]}(${$scope['xunits' + $scope.checkChart]})` : `${$scope['xname' + $scope.checkChart]}`,
                min: $scope.minX,
                max: $scope.maxX
            },
            yAxis: {
                name: $scope['yunits' + $scope.checkChart] ? `${$scope['yname' + $scope.checkChart]}(${$scope['yunits' + $scope.checkChart]})` : `${$scope['yname' + $scope.checkChart]}`,
                min: $scope.minY,
                max: $scope.maxY
            },
            series: series
        })
        echarts.getInstanceByDom(document.getElementById('container' + i)).resize();
    }

    //分析指标发送 fdName
    $scope.$on('analysFds_fdName', (event, data) => {
        $scope.analysfdName = data.fdName;
    })

    var tableStyle = {
        1: 'line',
        3: 'bar'
    }
    //调接口前 判空
    function judgeBeforeAjax() {
        if ((($scope.queryData.analysisObjectK == 1 || $scope.queryData.analysisObjectK == 2 || $scope.queryData.analysisObjectK == 3 || $scope.queryData.analysisObjectK == 5) && myAjaxData.config.dmsTypeBs.length == 0) || ($scope.queryData.analysisObjectK == 99 && myAjaxData.config.dmsTypeAs.length == 0)) {
            toaster.pop('error', '', '请选择分析对象');
            return false;
        } else if (!$scope.queryData.timeLat && $scope.queryData.analysisType != 3) {
            toaster.pop('error', '', '请选择时间纬度');
            return false;
        } else if (myAjaxData.config.dmsTimeDates.length == 0) {
            toaster.pop('error', '', '请选择统计时间');
            return false;
        } else if (!myAjaxData.config.fdX.key && $scope.queryData.analysisType == 1) {
            toaster.pop('error', '', '请选择横轴指标');
            return false;
        } else if (!myAjaxData.config.fdY.key && $scope.queryData.analysisType == 1) {
            toaster.pop('error', '', '请选择纵轴指标');
            return false;
        } else if (myAjaxData.config.analysFds.length == 0 && $scope.queryData.analysisType != 1) {
            toaster.pop('error', '', '请选择分析指标');
            return false;
        } else {
            return true;
        }
    }
    //查询接口 传的参数
    function ajaxParams() {
        var dataJ = {
            dmsTypeAs: myAjaxData.config.dmsTypeAs.length > 0 ? myAjaxData.config.dmsTypeAs : null,
            dmsTypeBs: myAjaxData.config.dmsTypeBs.length > 0 ? myAjaxData.config.dmsTypeBs : null,
            dmsTime: {
                dateType: $scope.dmsTimeDateType,
                dates: myAjaxData.config.dmsTimeDates
            },
            fds: $scope.queryData.analysisType == 1 ? myAjaxData.config.fds : $scope.queryData.analysisType != 1 ? myAjaxData.config.analysFds : '',
            sort: myAjaxData.config.benchSort
        }
        // if ($scope.queryData.analysisType == 1) {
        //     var dataJ = {
        //         dmsTypeAs: myAjaxData.config.dmsTypeAs.length > 0 ? myAjaxData.config.dmsTypeAs : null,
        //         dmsTypeBs: myAjaxData.config.dmsTypeBs.length > 0 ? myAjaxData.config.dmsTypeBs : null,
        //         dmsTime: {
        //             dateType: $scope.dmsTimeDateType,
        //             dates: myAjaxData.config.dmsTimeDates
        //         },
        //         fds: myAjaxData.config.fds
        //     }
        // } else {
        //     var dataJ = {
        //         dmsTypeAs: myAjaxData.config.dmsTypeAs.length > 0 ? myAjaxData.config.dmsTypeAs : null,
        //         dmsTypeBs: myAjaxData.config.dmsTypeBs.length > 0 ? myAjaxData.config.dmsTypeBs : null,
        //         dmsTime: {
        //             dateType: $scope.dmsTimeDateType,
        //             dates: myAjaxData.config.dmsTimeDates
        //         },
        //         fds: myAjaxData.config.analysFds
        //     }
        // }
        return dataJ;
    }

    // 最终的 查询按钮
    $scope.search = () => {
        $scope['fdStyle' + $scope.checkChart] = myAjaxData.config.fdStyle;
        var judge = judgeBeforeAjax();
        if (!judge) {
            return;
        }
        var dataJ = ajaxParams();
        //接口调用
        $scope.queryData.timeLat = $scope.queryData.analysisType == 3 ? 0 : $scope.queryData.timeLat;
        $scope['analysis_selectAnlsType' + $scope.queryData.analysisType + myAjaxData.config.dmsType + $scope.queryData.timeLat].getData(dataJ).then((res) => {
            if (res.code == 500){
                toaster.pop('error', '', res.code);
                return;
            } else if (!res.body || !res.body.data) {
                toaster.pop('error', '', res.msg);
                return;
            } else if (Object.keys(res.body.data).length == 0) {
                toaster.pop('error', '', '图表无数据');
                return;
            }
            $scope.tableData = res.body;
            if (myAjaxData.config.fdStyle == 4) {
                //获取 x轴和 y轴的 名字和单位
                indexName();
                //处理 接口的数据 -> echarts需要的数据
                var key;
                var newArr = [];
                var newArrKey = [];
                var newArrVal = [];
                for (key in $scope.tableData.data) {
                    newArr.push(...$scope.tableData.data[key]);
                    newArrVal.push($scope.tableData.data[key]);
                    newArrKey.push(myAjaxData.config.bIdToName[key]);
                }
                //获取 series
                var series = [];
                newArrKey.map((item, i) => {
                    series.push(
                        {
                            name: item,
                            data: newArrVal[i],
                            type: 'scatter',
                            symbolSize: 6,
                            opacity: 1,
                            shadowBlur: 2,
                            shadowOffsetX: 0,
                            shadowOffsetY: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    )
                })
                //获取 legend
                var legend = {
                    y: 'top',
                    data: newArrKey,
                    type: 'scroll',
                    width: 450,
                    itemWidth: 12,
                    left: 'center',
                    textStyle: {
                        color: '#fff',
                        fontSize: 12,
                        height: 20,
                        lineHeight: 20,
                        padding: [3, 0, 0, 0]
                    }
                }
                //获取最大值 最小值
                extreme(newArr);
                //图表的 setoption
                chartOption($scope.checkChart, legend, series);
            } else {
                // 获取y轴的名字
                $scope['yname' + $scope.checkChart] = $scope['yunits' + $scope.checkChart] ? $scope.analysfdName + '(' + $scope['yunits' + $scope.checkChart] + ')' : $scope.analysfdName;
                // 获取各项数据
                var key;
                var key2;
                $scope['newArrName' + $scope.checkChart] = [];
                $scope['tableType' + $scope.checkChart] = [];
                $scope['colors' + $scope.checkChart] = [];
                $scope['xdata' + $scope.checkChart] = [];
                $scope['ydatas' + $scope.checkChart] = [[]];
                $scope['stack' + $scope.checkChart] = [];
                //图表 颜色的预设
                var colorsAry = ['#D2E058', '#F29958', '#71cf53', '#35c4ee', '#FF7070', '#70C7FF', '#FF0072', '#3c763d', '#a94442', '#777777', '#7266ba', '#fad733', '#a733ff', '#e033ff', '#ff33c0', '#ff3362'];
                if ($scope.queryData.analysisType == 3){
                    //-------------------------------------对标分析 数据处理
                    for (key in $scope.tableData.data){
                        if(key == myAjaxData.config.analysFds[0].fdKey){
                            $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key]);
                        } else {
                            $scope.tableData.data[key].map((item)=>{
                                $scope['xdata' + $scope.checkChart].push(myAjaxData.config.bIdToName[item]);
                            })
                        }
                    }
                    $scope['tableType' + $scope.checkChart].push(tableStyle[myAjaxData.config.fdStyle]);
                    $scope['colors' + $scope.checkChart].push('#D2E058'); 
                    $scope['newArrName' + $scope.checkChart].push('对标分析');
                } else {
                //获取 xdata
                $scope['xdata' + $scope.checkChart] = $scope.tableData.data.dtime;
                delete $scope.tableData.data.dtime;
                //获取 yunits
                for (key in $scope.tableData.units) {
                    if (key == myAjaxData.config.analysFds[0]['fdKey']) {
                        $scope['yunits' + $scope.checkChart] = $scope.tableData.units[key];
                    }
                }
                
                //判断 是否点击 同比 环比
                var judge = myAjaxData.config.analysFds[0].fdTb.toString() + myAjaxData.config.analysFds[0].fdHb.toString();
                switch(judge){
                    case '10':
                    for (key in $scope.tableData.data) {
                        $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key]);
                        for (key2 in $scope.tableData.data[key]) {
                            if (key2.toLowerCase().indexOf('hb') == -1 && key2.toLowerCase().indexOf('tb') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                            } else if (key2.toLowerCase().indexOf('tb') != -1 && key2.toLowerCase().indexOf('rate') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                                $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key] + '同比');
                            }
                        }
                    }
                    $scope['ydatas' + $scope.checkChart][0].map(() => {
                        $scope['tableType' + $scope.checkChart].push(tableStyle[myAjaxData.config.fdStyle]);
                    })
                    break;
                    case '01':
                    for (key in $scope.tableData.data) {
                        $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key]);
                        for (key2 in $scope.tableData.data[key]) {
                            if (key2.toLowerCase().indexOf('hb') == -1 && key2.toLowerCase().indexOf('tb') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                            } else if (key2.toLowerCase().indexOf('hb') != -1 && key2.toLowerCase().indexOf('rate') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                                $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key] + '环比');
                            }
                        }
                    }
                    $scope['ydatas' + $scope.checkChart][0].map(() => {
                        $scope['tableType' + $scope.checkChart].push(tableStyle[myAjaxData.config.fdStyle]);
                    })
                    break;
                    case '11':
                    for (key in $scope.tableData.data) {
                        $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key]);
                        for (key2 in $scope.tableData.data[key]) {
                            if (key2.toLowerCase().indexOf('hb') == -1 && key2.toLowerCase().indexOf('tb') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                            } else if (key2.toLowerCase().indexOf('hb') != -1 && key2.toLowerCase().indexOf('rate') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                                $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key] + '环比');
                            } else if (key2.toLowerCase().indexOf('tb') != -1 && key2.toLowerCase().indexOf('rate') == -1) {
                                $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                                $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key] + '同比');
                            }
                        }
                    }
                    $scope['ydatas' + $scope.checkChart][0].map(() => {
                        $scope['tableType' + $scope.checkChart].push(tableStyle[myAjaxData.config.fdStyle]);
                    })
                    break;
                    case '00':
                    for (key in $scope.tableData.data) {
                        $scope['newArrName' + $scope.checkChart].push(myAjaxData.config.bIdToName[key]);
                        $scope['tableType' + $scope.checkChart].push(tableStyle[myAjaxData.config.fdStyle]);
                        for (key2 in $scope.tableData.data[key]) {
                            $scope['ydatas' + $scope.checkChart][0].push($scope.tableData.data[key][key2]);
                        }
                    }
                    break;
                }
                //柱状图的 stack
                if (myAjaxData.config.fdStyle == 3) {
                    $scope['stack' + $scope.checkChart] = $scope['tableType' + $scope.checkChart];
                } else {
                    $scope['stack' + $scope.checkChart] = [];
                }
                //曲线或者柱状图 颜色 的获取
                $scope['tableType' + $scope.checkChart].map((item, i) => {
                    if(colorsAry[i]){
                        $scope['colors' + $scope.checkChart].push(colorsAry[i]);
                    } else {
                        colorsAry[i] = '#' + ('00000' + (Math.random() * 0x1000000 << 0).toString(16)).substr(-6);
                        $scope['colors' + $scope.checkChart].push(colorsAry[i]);
                    }
                })
              }
            }
        })
    }

    // 切换图表排列方式
    $scope.chartSortIndex = 4;
    $scope.chartSort = (index) => {
        $scope.chartSortIndex = index;
        if ($scope.chartSortIndex == 1) {
            $scope.chartStyle = { 'width': '100%', 'height': '100%' }
        } else if ($scope.chartSortIndex == 2) {
            $scope.chartStyle = { 'width': '100%', 'height': '49%' }
        } else if ($scope.chartSortIndex == 3) {
            $scope.chartStyle = { 'width': '49%', 'height': '100%' }
        } else if ($scope.chartSortIndex == 4) {
            $scope.chartStyle = { 'width': '49%' }
        }
    }

    // 图表的点击
    $scope.checkChartFun = (index) => {
        $scope.checkChart = index;
    }
    $scope.checkChartFun(0);

    //图表函数组
    function chartsInit() {
        var myChart0 = echarts.init(document.getElementById("container0"));
        var myChart1 = echarts.init(document.getElementById("container1"));
        var myChart2 = echarts.init(document.getElementById("container2"));
        var myChart3 = echarts.init(document.getElementById("container3"));
        var option = null;
        option = {
            xAxis: {
                name: '',
                min: 0,
                max: 100,
                nameTextStyle: {
                    color: '#fff',
                    fontSize: 12
                },
                //改变x轴字体颜色为白色
                axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                //去掉x轴分隔线
                splitLine: {
                    show: false
                },
                //设置轴线的属性
                axisLine: {
                    lineStyle: {
                        color: 'rgba(68, 150, 255, 1)'
                    }
                }
            },
            yAxis: {
                name: '',
                min: 0,
                max: 100,
                nameTextStyle: {
                    color: '#fff',
                    fontSize: 12
                },
                //改变y轴字体颜色为白色
                axisLabel: {
                    show: true,
                    textStyle: {
                        color: '#fff'
                    }
                },
                //设置y轴分隔线
                splitLine: {
                    lineStyle: {
                        color: 'rgba(68, 150, 255, 1)'
                    }
                },
                //设置轴线的属性
                axisLine: {
                    show: false
                },
                //去掉刻度线
                axisTick: {
                    show: false
                }
            },
            series: [],
            grid: {
                top: "26%",
                right: "18%",
                bottom: "18%"
            }
        };
        if (option && typeof option === "object") {
            myChart0.setOption(option, true);
            myChart1.setOption(option, true);
            myChart2.setOption(option, true);
            myChart3.setOption(option, true);
        }
    }
    chartsInit();

    //resize图表
    var myChart0 = echarts.getInstanceByDom(document.getElementById("container0"));
    var myChart1 = echarts.getInstanceByDom(document.getElementById("container1"));
    var myChart2 = echarts.getInstanceByDom(document.getElementById("container2"));
    var myChart3 = echarts.getInstanceByDom(document.getElementById("container3"));
    $('.table1').resize(function () {
        myChart0.resize();
        myChart1.resize();
        myChart2.resize();
        myChart3.resize();
    });

    //点击 弹出框
    $scope.analysisObjectModel = true;
    $scope.horizonIndexChange = (param) => {
        if (param == 1) {
            // 纵轴指标弹出
            if ($scope.queryData.timeLat && $scope.horizonNan != 1) {
                //向纵轴指标发送数据
                $scope.$broadcast('verticalData');
                $scope.verticalIndexModel = true;
            } else if (!$scope.queryData.timeLat)  {
                toaster.pop('error', '', '请选择时间纬度');
            } else if ($scope.horizonNan == 1) {
                toaster.pop('error', '', '纵轴指标无数据');
            }
        } else if (param == 2) {
            // 横轴指标弹出
            if ($scope.queryData.timeLat && $scope.horizonNan != 1) {
                //监听横轴指标页面打开
                $scope.$broadcast('horizonOpen');
                $scope.horizonIndexModel = true;
            } else if (!$scope.queryData.timeLat) {
                toaster.pop('error', '', '请选择时间纬度');
            } else if ($scope.horizonNan == 1) {
                toaster.pop('error', '', '横轴指标无数据');
            }
        } else if (param == 3) {
            // 统计时间弹出
            $scope.countTimeModel = true;
        } else if (param == 4) {  //时间纬度 弹出
            if (!$scope.queryData.timeLat) {
                $scope.queryData.horizonIndexV = '请选择';
                $scope.queryData.verticalIndexV = '请选择';
            } else {
                //向横轴指标发送数据
                if($scope.queryData.analysisType == 1){
                    $scope.$broadcast('dmsTime', $scope.queryData.timeLat);
                } else if($scope.queryData.analysisType == 2){
                    $scope.$broadcast('trend_dmsTime', $scope.queryData.timeLat);
                }
            }
        } else if (param == 5) {
            // 分析对象弹出
            if ($scope.analysObDataNew) {
                $scope.analysisObjectModel = true;
            }
        } else if (param == 6) {
            // 分析类型下拉框 选中处理数据
            analysisObjFun();
            // if (!$scope.queryData.analysisType) {
            //     $scope.analysObDataNew = null;
            //     $scope.analysObDataNewDevice = null;
            //     $scope.queryData.analysisObjectV = '请选择';
            //     $scope.timeLat = null;
            //     $scope.queryData.timeLat = '';
            //     $scope.queryData.horizonIndexV = '请选择';
            // } else {

            // }
        } else if (param == 7) {
            if ($scope.queryData.timeLat && myAjaxData.config.anlsType == 2) {
                // 分析指标弹出
                $scope.analysIndexModel = true;
            } else if (myAjaxData.config.anlsType == 3){
                $scope.analysIndexModel = true;
            }
        }
    }

    //给按钮赋初始值
    $scope.queryData.analysisObjectV = '请选择';
    $scope.queryData.timeLatV = '请选择';
    $scope.queryData.countTimeV = '请选择';
    $scope.queryData.horizonIndexV = '请选择';
    $scope.queryData.verticalIndexV = '请选择';
    $scope.queryData.analysIndexV = '请选择';

    //获取子级发送的数据(被选择的radio)
    $scope.$on('radioToFather', (event, data) => {
        if (data.type == 'horizon') {
            //选择的是横轴指标
            $scope.queryData.horizonIndexK = data.k;
            $scope.queryData.horizonIndexV = data.value;
        } else if (data.type == 'countTime') {
            $scope.queryData.countTimeV = data.name;
            $scope.dmsTimeDateType = data.dateType;
        } else if (data.type == 'analysisObject') {
            $scope.queryData.analysisObjectK = data.k;
            $scope.queryData.analysisObjectV = data.value;
            //对标分析-> 取dmsType
            if($scope.queryData.analysisType == 3){
                $scope.$broadcast('bench_dmsType');
            }
            // 取时间纬度的数据
            $scope.queryData.timeLat = '';
            if ($scope.analysObDataNew) {
                $scope.analysObDataNew.map((item) => {
                    if (item.k == $scope.queryData.analysisObjectK) {
                        $scope.timeLat = item.ll;
                        $scope.changeTime = 1;
                        $scope.queryData.horizonIndexV = '请选择';
                        $scope.queryData.verticalIndexV = '请选择';
                        myAjaxData.config.fdX.key = null;
                        myAjaxData.config.fdY.key = null;
                    }
                })
            }
        } else if (data.type == 'vertical') {
            //选择的是纵轴指标
            $scope.queryData.verticalIndexV = data.value;
        } else if (data.type == 'analys') {
            //选择的是分析指标
            $scope.queryData.analysIndexV = data.value;
        }
    })

    // 逆变器 汇流箱 点击 特殊处理 时间纬度的数据
    $scope.$on('deviceTimeLat', (item, v) => {
        $scope.timeLat = v;
        //对标分析-> 取dmsType
        if($scope.queryData.analysisType == 3){
            $scope.$broadcast('bench_dmsType');
        }
    })

    //横轴指标没有数据的 标志符
    $scope.$on('horizonNan', (item, v) => {
        $scope.horizonNan = v.data;
    })

    //取消 新增后的回调
    $scope.analysisObjectModel = false;
    $scope.$on('cancelCallback', () => {
        $scope.analysisObjectModel = false;
        $scope.countTimeModel = false;
        $scope.horizonIndexModel = false;
        $scope.verticalIndexModel = false;
        $scope.analysIndexModel = false;
    });

    $scope.$on('addCallback', () => {
        $scope.analysisObjectModel = false;
        $scope.countTimeModel = false;
        $scope.horizonIndexModel = false;
        $scope.verticalIndexModel = false;
        $scope.analysIndexModel = false;
    });
});

