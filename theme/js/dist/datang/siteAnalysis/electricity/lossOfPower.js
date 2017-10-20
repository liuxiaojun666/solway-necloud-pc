'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('lopChart1', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },
        link: function () {
            function link($scope, $element, $attrs) {
                var _this = this,
                    myChart = echarts.init($element[0]),
                    renderChart = function () {
                    _newArrowCheck(this, _this);

                    var option = {
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        series: [{
                            name: '损失电量比',
                            center: ['50%', '50%'],
                            radius: ['55%', '80%'],
                            type: 'pie',
                            data: [30, 50].map(function (v, i) {
                                _newArrowCheck(this, _this);

                                return {
                                    name: ['总损失电量', '总实发电量'][i],
                                    value: v,
                                    label: {
                                        normal: {
                                            textStyle: {
                                                color: '#3f3f3f',
                                                fontSize: 16
                                            }
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: ['#7accc8', '#bd8cbf'][i]
                                        }
                                    },
                                    hoverAnimation: !1
                                };
                            }.bind(this))
                        }]
                    };
                    myChart.setOption(option);
                }.bind(this);

                renderChart();
            }

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('lopChart2', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },
        link: function () {
            function link($scope, $element, $attrs) {
                var _this2 = this,
                    myChart = echarts.init($element[0]),
                    renderChart = function () {
                    _newArrowCheck(this, _this2);

                    var option = {
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        series: [{
                            name: '损失电量构成',
                            center: ['50%', '50%'],
                            radius: ['55%', '80%'],
                            type: 'pie',
                            data: [30, 50, 34, 6].map(function (v, i) {
                                _newArrowCheck(this, _this2);

                                return {
                                    name: ['计划检修', '电网', '故障', '其他'][i],
                                    value: v,
                                    label: {
                                        normal: {
                                            textStyle: {
                                                color: '#3f3f3f',
                                                fontSize: 16
                                            }
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: ['#f9ad81', '#63c9e3', '#f49ac1', '#7accc8'][i]
                                        }
                                    },
                                    hoverAnimation: !1
                                };
                            }.bind(this))
                        }]
                    };
                    myChart.setOption(option);
                }.bind(this);

                renderChart();
            }

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('lopChartBar', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },

        link: function () {
            function link($scope, $element, $attrs) {
                var _this3 = this,
                    setWidthHeight = function () {
                    _newArrowCheck(this, _this3);

                    $($element).width(window.innerWidth - 220 < 800 ? 800 : window.innerWidth - 220).height(window.innerHeight - 370 < 270 ? 270 : window.innerHeight - 370);
                }.bind(this);

                setWidthHeight();
                var myChart = echarts.init($element[0]);
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this3);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));

                var renderChart = function (resData) {
                    _newArrowCheck(this, _this3);

                    var legend = ['故障', '电网', '计划检修', '其他'],
                        option = {
                        color: ['#2cc6ff'],
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data: [{ name: '故障' }, { name: '电网' }, { name: '计划检修' }, { name: '其他' }],
                            itemWidth: 25,
                            itemGap: 40,
                            height: 15,
                            right: 60,
                            top: 10
                        },
                        grid: {
                            top: '60',
                            left: '20',
                            right: '60',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '时间',
                            type: 'category',
                            axisLine: {
                                lineStyle: {
                                    color: '#a4a4a4',
                                    width: 1
                                }
                            },
                            data: Array.apply(null, { length: 30 }).map(function (v, i) {
                                _newArrowCheck(this, _this3);

                                return i + 1 + '';
                            }.bind(this))
                        }],
                        yAxis: [{
                            name: '电量(kWh)',
                            type: 'value',
                            axisLine: {
                                lineStyle: {
                                    color: '#a4a4a4',
                                    width: 1
                                }
                            },
                            axisTick: {
                                show: !1
                            },
                            splitLine: {
                                show: !1
                            }
                        }],
                        series: [].concat(_toConsumableArray(legend.map(function (v, i) {
                            _newArrowCheck(this, _this3);

                            return {
                                name: v,
                                type: 'bar',
                                barWidth: '20',
                                yAxisIndex: 0,
                                stack: '电量',
                                itemStyle: {
                                    normal: {
                                        color: ['#f49ac1', '#63c9e3', '#f9ad81', '#7accc8'][i]
                                    }
                                },
                                data: Array.apply(null, { length: 30 }).map(function (v, i) {
                                    _newArrowCheck(this, _this3);

                                    return Math.random() * 20;
                                }.bind(this))
                            };
                        }.bind(this))))
                    };

                    myChart.setOption(option);
                }.bind(this);
                renderChart();
            }

            return link;
        }()
    };
}.bind(void 0)]);

ajaxData({
    pageList: {
        name: 'GETanalysisPage',
        data: {
            pageIndex: 0,
            pageSize: 10,
            startDate: new Date(new Date().setDate(new Date().getDate() - 7)).Format('yyyy-MM-dd'),
            endDate: new Date().Format('yyyy-MM-dd')
        }
    },
    detail: {
        name: 'GETselectEqPaintingData',
        later: !0
    },
    deviceType: {
        name: 'GETgetDeviceType',
        data: {}
    }
}, {})('lossOfPowerCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
    $scope.dateTime2 = new Date();
}.bind(void 0));