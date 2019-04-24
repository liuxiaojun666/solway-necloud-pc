ajaxData({
    // 分析类型
    HighAnalysis_selectAnlsType: {
        name: 'GETHighAnalysis_selectAnlsType',
        data: {
            stationClass: '01'
        }
    },
    ...((() => {
        const o = {};
        ['1', '2', '3'].forEach(v => {
            ['1', '2', '3', '401', '402', '403', '404', '405', '417', '418', '11', '12', '13'].forEach(vv => {
                ['1', '2', '3', '4', '5'].forEach(vvv => {
                    o['analysis_selectAnlsType' + v + vv + vvv] = {
                        name: `analysis_selectAnlsType${v}${vv}${vvv}`,
                        data: {}
                    }
                })
            })
        });
        return o;
    })()),

}, {
        herizonData: {},  //横轴数据 纵轴数据
        dmsType: null,    //分析对象参数
        dmsTypeBs: [], //电站|区域(部门)|集团  接口需要的数据
        dmsTypeAs: [], //设备 参数
        dmsTimeDates: [], //时间 参数 时间数据
        fdX: {             //横轴指标字段 参数
            key: '',
            name: ''
        },
        fdY: {             //纵轴指标字段 参数
            key: '',
            name: ''
        }

    })('expertAnalysisCtrl', ['$scope', 'myAjaxData', 'actionRecord', '$interval', 'toaster'], ($scope, myAjaxData, historicalRecord, $interval, toaster) => {

        historicalRecord.init();// 历史记录 初始化
        $scope.beforeLoading = true; // 页面loading
        $scope.moduleName = '专家分析';//当前页面名称；
        $scope.endDate = new Date((+new Date) - 1000 * 60 * 60 * 24); // 日历可选 的截止日期
        historyInitCallback();

        // 当前页面行为记录初始化回调 获取行为记录
        async function historyInitCallback() {
            const historiData = historicalRecord.get();
            const {
                startDate = new Date(Date.now() - 1000 * 60 * 60 * 24),
                endDate = new Date(Date.now() - 1000 * 60 * 60 * 24),
            } = historiData;
            $scope.startDate = startDate;
            $scope.endDate = endDate;
            $scope.beforeLoading = false;
            await myAjaxData.timeout(0);
            $scope.$apply();
        };

        //获取 x轴和 y轴的 名字和单位
        function indexName() {
            $scope.xname = myAjaxData.config.fdX.name;
            $scope.yname = myAjaxData.config.fdY.name;
            var key;
            for (key in $scope.tableData.units) {
                if (key == myAjaxData.config.fdX.key) {
                    $scope.xunits = $scope.tableData.units[key];
                }
                if (key == myAjaxData.config.fdY.key) {
                    $scope.yunits = $scope.tableData.units[key];
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
                } else {
                    $scope.maxX = $scope.maxX * 0.8;
                }
                if ($scope.minX > 0) {
                    $scope.minX = $scope.minX * 1.1;
                } else {
                    $scope.minX = $scope.minX * 0.8;
                }
                if ($scope.maxY > 0) {
                    $scope.maxY = $scope.maxY * 1.1;
                } else {
                    $scope.maxY = $scope.maxY * 0.8;
                }
                if ($scope.minY > 0) {
                    $scope.minY = $scope.minY * 1.1;
                } else {
                    $scope.minY = $scope.minY * 0.8;
                }
            } else {
                $scope.minX = 0;
                $scope.minY = 0;
                $scope.maxX = 100;
                $scope.maxY = 100;
            }

        }

        // 最终的 查询按钮
        $scope.search = () => {
            //调接口前 判空
            if ((($scope.queryData.analysisObjectK == 1 || $scope.queryData.analysisObjectK == 2 || $scope.queryData.analysisObjectK == 3) && myAjaxData.config.dmsTypeBs.length == 0) || ($scope.queryData.analysisObjectK == 99 && myAjaxData.config.dmsTypeAs.length == 0)) {
                toaster.pop('error', '', '分析对象不能为空');
                return;
            } else if (!$scope.queryData.timeLat) {
                toaster.pop('error', '', '时间纬度不能为空');
                return;
            } else if (myAjaxData.config.dmsTimeDates.length == 0) {
                toaster.pop('error', '', '统计时间不能为空');
                return;
            } else if (!myAjaxData.config.fdX.key) {
                toaster.pop('error', '', '横轴指标不能为空');
                return;
            } else if (!myAjaxData.config.fdY.key) {
                toaster.pop('error', '', '纵轴指标不能为空');
                return;
            }
            //接口调用
            $scope['analysis_selectAnlsType' + $scope.queryData.analysisType + myAjaxData.config.dmsType + $scope.queryData.timeLat].getData({
                dmsTypeAs: myAjaxData.config.dmsTypeAs,
                dmsTypeBs: myAjaxData.config.dmsTypeBs,
                dmsTime: {
                    dateType: $scope.dmsTimeDateType,
                    dates: myAjaxData.config.dmsTimeDates
                },
                fds: [
                    { fdKey: myAjaxData.config.fdX.key, isx: 1 },
                    { fdKey: myAjaxData.config.fdY.key, isx: 0 }
                ]
            }).then((res) => {
                if (!res.body || !res.body.data) {
                    toaster.pop('error', '', res.msg);
                    return;
                }
                $scope.tableData = res.body;
                indexName();
                var newArr = [];
                var key;
                for (key in $scope.tableData.data) {
                    newArr.push(...$scope.tableData.data[key]);
                }
                if ($scope.checkChart == 1) {
                    extreme(newArr);
                    myChart.setOption({
                        xAxis: {
                            name: $scope.xunits ? `${$scope.xname}(${$scope.xunits})` : `${$scope.xname}`,
                            min: $scope.minX,
                            max: $scope.maxX
                        },
                        yAxis: {
                            name: $scope.yunits ? `${$scope.yname}(${$scope.yunits})` : `${$scope.yname}`,
                            min: $scope.minY,
                            max: $scope.maxY
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            data: newArr
                        }]
                    })
                } else if ($scope.checkChart == 2) {
                    extreme(newArr);
                    myChart2.setOption({
                        xAxis: {
                            name: $scope.xunits ? `${$scope.xname}(${$scope.xunits})` : `${$scope.xname}`,
                            min: $scope.minX,
                            max: $scope.maxX
                        },
                        yAxis: {
                            name: $scope.yunits ? `${$scope.yname}(${$scope.yunits})` : `${$scope.yname}`,
                            min: $scope.minY,
                            max: $scope.maxY
                        },
                        series: [{
                            // 根据名字对应到相应的系列
                            data: newArr
                        }]
                    })
                }
            })
        }

        // 分析类型下拉框的数据获取
        $scope.HighAnalysis_selectAnlsType.subscribe(res => {
            $scope.selectData = res.body;
            analysisObjFun();
        });

        // 选中第一个下拉框 动态改变其他的下拉框
        $scope.queryData = {
            'analysisType': 1
        }

        //获取分析对象的数据方法
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
            $scope.$broadcast('anlsType', $scope.queryData.analysisType);
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
        $scope.checkChartFun(1);

        //图表函数组
        function chartsOne() {
            var dom = document.getElementById("container1");
            var myChart = echarts.init(dom);
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
                series: [{
                    type: 'scatter',
                    symbolSize: 5,
                    data: [],
                    itemStyle: {
                        normal: {
                            color: 'rgb(255, 255, 255)'
                        }
                    }
                }
                ],
                grid: {
                    top: "17%",
                    left: "10%",
                    right: "15%",
                    bottom: "18%"
                }
            };
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
        }
        chartsOne();

        function chartsTwo() {
            var dom = document.getElementById("container2");
            var myChart = echarts.init(dom);
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
                series: [{
                    type: 'scatter',
                    symbolSize: 5,
                    data: [],
                    itemStyle: {
                        normal: {
                            color: 'rgb(255, 255, 255)'
                        }
                    }
                }
                ],
                grid: {
                    top: "17%",
                    left: "10%",
                    right: "15%",
                    bottom: "18%"
                }
            };
            if (option && typeof option === "object") {
                myChart.setOption(option, true);
            }
        }
        chartsTwo();

        //resize图表
        var myChart = echarts.getInstanceByDom(document.getElementById("container1"));
        var myChart2 = echarts.getInstanceByDom(document.getElementById("container2"));
        $('.table1').resize(function () {
            myChart.resize();
            myChart2.resize();
        });

        //点击 弹出框
        $scope.analysisObjectModel = true;
        $scope.horizonIndexChange = (param) => {
            if (param == 1) {
                //向纵轴指标发送数据
                $scope.$broadcast('verticalData');
                // 纵轴指标弹出
                if ($scope.queryData.timeLat) {
                    $scope.verticalIndexModel = true;
                }
            } else if (param == 2) {
                // 横轴指标弹出
                if ($scope.queryData.timeLat) {
                    $scope.horizonIndexModel = true;
                }
            } else if (param == 3) {
                // 统计时间弹出
                $scope.countTimeModel = true;
            } else if (param == 4) {  //时间纬度 数据处理
                if (!$scope.queryData.timeLat) {
                    $scope.queryData.horizonIndexV = '请选择';
                    $scope.queryData.verticalIndexV = '请选择';
                } else {
                    //向横轴指标发送数据
                    $scope.$broadcast('dmsTime', $scope.queryData.timeLat);
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
                //     var key;
                //     for (key in $scope.selectData) {
                //         if ($scope.queryData.analysisType == $scope.selectData[key].k) {
                //             $scope.analysObDataOld = $scope.selectData[key].ll;
                //         }
                //     }
                //     $scope.analysObDataNew = $scope.analysObDataOld.filter((item) => {
                //         return item.k.substr(0, 1) != "4";
                //     })
                //     $scope.analysObDataNewDevice = $scope.analysObDataOld.filter((item) => {
                //         return item.k.substr(0, 1) == "4";
                //     })
                // }

                // //向分析对象发送数据
                // $scope.$broadcast('analysObDataNew', { 'analysObDataNew': $scope.analysObDataNew, 'analysObDataNewDevice': $scope.analysObDataNewDevice });

                //向横轴指标发送anlsType
                // $scope.$broadcast('anlsType', $scope.queryData.analysisType);
            } else if (param == 7) {
                // 分析指标弹出
                $scope.analysIndexModel = true;
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
                // 取时间纬度的数据
                if ($scope.analysObDataNew) {
                    $scope.analysObDataNew.map((item) => {
                        if (item.k == $scope.queryData.analysisObjectK) {
                            $scope.timeLat = item.ll;
                        }
                    })
                }
                //横轴指标获取dmsType
                $scope.$broadcast('dmsType');
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
        })

        //取消 新增后的回调
        $scope.analysisObjectModel = false;
        $scope.$on('cancelCallback', () => {
            $scope.analysisObjectModel = false;
            $scope.countTimeModel = false;
            $scope.horizonIndexModel = false;
            $scope.verticalIndexModel = false;
        });

        $scope.$on('addCallback', () => {
            $scope.analysisObjectModel = false;
            $scope.countTimeModel = false;
            $scope.horizonIndexModel = false;
            $scope.verticalIndexModel = false;
        });
    });

