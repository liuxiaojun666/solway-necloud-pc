'use strict';

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('chartWd1', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },
        link: function () {
            function link($scope, $element, $attrs) {
                var _this = this;

                $scope.$watch("detail", function (newValue, oldValue) {
                    _newArrowCheck(this, _this);

                    newValue.res && renderChart();
                }.bind(this), !0);
                var setWidthHeight = function () {
                    _newArrowCheck(this, _this);

                    $($element).width((window.innerWidth - 535 < 800 ? 800 : window.innerWidth - 535) + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = echarts.init($element[0]),
                    renderChart = function () {
                    _newArrowCheck(this, _this);

                    for (var data1 = [23, 24, 25, 23, 26, 27, 28, 30, 27, 28, 26, 25, 24, 26, 23, 23, 25, 26, 27, 30, 26, 24, 20, 23], data2 = [], _iterator = data1, _isArray = Array.isArray(_iterator), _i = 0, _iterator = _isArray ? _iterator : _iterator[Symbol.iterator]();;) {
                        if (_isArray) {
                            if (_i >= _iterator.length) break;
                            data2[data2.length] = _iterator[_i++];
                        } else {
                            _i = _iterator.next();
                            if (_i.done) break;
                            data2[data2.length] = _i.value;
                        }

                        data2[data2.length - 1] += 2;
                    }var option = {
                        tooltip: {
                            trigger: 'axis'
                        },
                        color: ['#65cc32', '#59adff'],
                        legend: {
                            data: myAjaxData.config.lineName
                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '80',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: {
                            name: '小时(h)',
                            boundaryGap: !1,
                            data: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24']
                        },
                        yAxis: {
                            name: myAjaxData.config.yName,
                            splitNumber: 2,
                            splitLine: {
                                show: !1
                            },
                            type: 'value'
                        },
                        series: [{ name: myAjaxData.config.lineName[0],
                            type: 'line',
                            stack: '总量',
                            data: data1
                        }, {
                            name: myAjaxData.config.lineName[1],
                            type: 'line',
                            stack: '总量',
                            data: data2
                        }]
                    };
                    myChart.setOption(option);
                }.bind(this);

                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));
            }

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('chartWd2', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },
        link: function () {
            function link($scope, $element, $attrs) {
                var _this2 = this;

                $scope.$watch("detail", function (newValue, oldValue) {
                    _newArrowCheck(this, _this2);

                    newValue.res && renderChart();
                }.bind(this), !0);
                var setWidthHeight = function () {
                    _newArrowCheck(this, _this2);

                    $($element).width((window.innerWidth - 535 < 800 ? 800 : window.innerWidth - 535) + 'px').height((window.innerHeight - 420 < 220 ? 220 : window.innerHeight - 420) + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = echarts.init($element[0]),
                    renderChart = function () {
                    _newArrowCheck(this, _this2);

                    var option = {
                        tooltip: {
                            trigger: 'axis',
                            position: function () {
                                function position(pt) {
                                    return [pt[0], '20%'];
                                }

                                return position;
                            }(),
                            formatter: function () {
                                function formatter(params) {
                                    var res = params[0].name + '<br/>';

                                    return res;
                                }

                                return formatter;
                            }()
                        },
                        legend: {
                            data: ['超限报警', '异常报警']
                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '80',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '日期',
                            type: 'category',
                            splitLine: {
                                show: !1
                            },
                            axisLabel: {
                                interval: 1,
                                textStyle: {
                                    fontSize: 12
                                }
                            },
                            boundaryGap: !1,
                            data: Array.apply(null, { length: 30 }).map(function (v, i) {
                                _newArrowCheck(this, _this2);

                                return '8月' + (i + 1) + '日';
                            }.bind(this))
                        }],
                        yAxis: [{
                            type: 'value',
                            interval: 1,
                            splitLine: {
                                show: !1
                            },
                            nameTextStyle: {
                                fontSize: 14,
                                rotation: 2
                            }
                        }],
                        series: [{
                            xAxisIndex: [0],
                            yAxisIndex: [0],
                            type: 'line',
                            showAllSymbol: !0,
                            symbol: 'none',
                            lineStyle: {
                                normal: {
                                    width: 5,
                                    color: '#f8606d'
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: '#333'
                                },
                                emphais: {
                                    color: '#333'
                                }
                            },
                            data: Array.apply(null, { length: 30 }).map(function (v, i) {
                                _newArrowCheck(this, _this2);

                                return i % 4 == 0 ? '' : 1;
                            }.bind(this))
                        }, {
                            xAxisIndex: [0],
                            yAxisIndex: [0],
                            type: 'line',
                            showAllSymbol: !0,
                            symbol: 'none',
                            lineStyle: {
                                normal: {
                                    width: 5,
                                    color: '#f2c007'
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: '#333'
                                },
                                emphais: {
                                    color: '#333'
                                }
                            },
                            data: Array.apply(null, { length: 30 }).map(function (v, i) {
                                _newArrowCheck(this, _this2);

                                return i % 3 == 0 ? '' : 2;
                            }.bind(this))
                        }, {
                            name: '超限报警',
                            type: 'bar',
                            itemStyle: {
                                normal: {
                                    color: '#f8606d'
                                }
                            }
                        }, {
                            name: '异常报警',
                            type: 'bar',
                            itemStyle: {
                                normal: {
                                    color: '#f2c007'
                                }
                            }
                        }]
                    };
                    myChart.setOption(option);
                }.bind(this);

                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this2);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));
            }

            return link;
        }()
    };
}.bind(void 0)]);