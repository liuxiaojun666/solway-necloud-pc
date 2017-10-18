'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg), value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('contentLeft', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#content-left').html(),
        replace: !0,
        scope: {
            pageList: '=',
            detail: '=',
            deviceType: '='
        },

        link: function () {
            function link($scope, $element, $attrs) {
                var _this = this;

                $scope.setTableHeight();
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this);

                    $scope.setTableHeight();
                    $scope.$apply();
                }.bind(this));
            }

            return link;
        }(),
        controller: function () {
            function controller($scope, $element) {
                var _this2 = this;

                $scope.setTableHeight = function () {
                    _newArrowCheck(this, _this2);

                    var windowHeight = window.innerHeight;
                    $(".content-body").height(windowHeight - 100 < 545 ? 545 : windowHeight - 100);
                    $scope.tableScrollY = windowHeight - 393 < 245 ? 245 : windowHeight - 393;
                }.bind(this);

                $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
                $scope.dateTime2 = new Date();

                $scope.getDeviceName = function () {
                    _newArrowCheck(this, _this2);

                    var _ref = _asyncToGenerator(regeneratorRuntime.mark(function () {
                        function _callee(i) {
                            return regeneratorRuntime.wrap(function () {
                                function _callee$(_context) {
                                    while (1) {
                                        switch (_context.prev = _context.next) {
                                            case 0:
                                                _newArrowCheck(this, _this2);

                                                $scope.deviceName = '';

                                                if (!(i < 0)) {
                                                    _context.next = 4;
                                                    break;
                                                }

                                                return _context.abrupt('return', $scope.deviceNames = []);

                                            case 4:
                                                _context.next = 6;
                                                return myAjaxData.getData({
                                                    name: myAjaxData.config.url[i],
                                                    data: {}
                                                });

                                            case 6:
                                                $scope.deviceNames = _context.sent;

                                                $scope.$apply();

                                            case 8:
                                            case 'end':
                                                return _context.stop();
                                        }
                                    }
                                }

                                return _callee$;
                            }(), _callee, this);
                        }

                        return _callee;
                    }()));

                    return function (_x) {
                        return _ref.apply(this, arguments);
                    };
                }.bind(this)().bind(this);

                $scope.search = function () {
                    _newArrowCheck(this, _this2);

                    $scope.pageList.getData({
                        deviceId: $scope.deviceName,
                        deviceType: $scope.deviceTypeVal,
                        pageIndex: 0,
                        startDate: $scope.dateTime1.Format('yyyy-MM-dd'),
                        endDate: $scope.dateTime2.Format('yyyy-MM-dd')
                    });
                }.bind(this);

                var activeIndex = 0;

                $scope.loadDetail = function () {
                    _newArrowCheck(this, _this2);

                    var _ref2 = _asyncToGenerator(regeneratorRuntime.mark(function () {
                        function _callee2(data) {
                            var index = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : 0;
                            return regeneratorRuntime.wrap(function () {
                                function _callee2$(_context2) {
                                    while (1) {
                                        switch (_context2.prev = _context2.next) {
                                            case 0:
                                                _newArrowCheck(this, _this2);

                                                activeIndex = index;

                                                if (data) {
                                                    _context2.next = 5;
                                                    break;
                                                }

                                                $scope.detail.res = null;
                                                return _context2.abrupt('return', $scope.detail.isLoding = !1);

                                            case 5:
                                                _context2.next = 7;
                                                return $scope.detail.getData({
                                                    stId: myAjaxData.currentStationData.currentSTID,
                                                    deviceId: data.deviceId,
                                                    dtime: new Date(data.beginTime).Format("yyyy-MM-dd")
                                                });

                                            case 7:
                                                $($element).find('tbody tr').removeClass('active').eq(index).addClass('active');

                                            case 8:
                                            case 'end':
                                                return _context2.stop();
                                        }
                                    }
                                }

                                return _callee2$;
                            }(), _callee2, this);
                        }

                        return _callee2;
                    }()));

                    return function (_x2) {
                        return _ref2.apply(this, arguments);
                    };
                }.bind(this)().bind(this);

                $scope.$watch('pageList', function (newValue, oldValue) {
                    _newArrowCheck(this, _this2);

                    if (void 0 === newValue.res) return;
                    if (void 0 === newValue.res.data.data[0]) return $scope.loadDetail();
                    var _newValue = newValue.res.data.data;
                    $($element).find('tbody tr').removeClass('active');
                    if (oldValue.res) {
                        for (var _oldValue = oldValue.res.data.data, i = 0, len = _newValue.length; i < len; i++) {
                            if (_oldValue[activeIndex] && _newValue[i].deviceId == _oldValue[activeIndex].deviceId) {
                                $($element).find('tbody tr').eq(i).addClass('active');
                                return activeIndex = i;
                            }
                        }
                    }
                    activeIndex = 0;
                    $scope.loadDetail(_newValue[0]);
                }.bind(this), !0);

                $scope.column = [{
                    title: '设备名称',
                    dataIndex: 'deviceName',
                    width: '35%',
                    align: 'center',
                    sort: !0
                }, {
                    title: '时间',
                    dataIndex: 'beginTime',
                    width: '35%',
                    align: 'center',
                    sort: !0,
                    render: function () {
                        function render(text, record, index) {
                            return text && new Date(text).Format('yyyy-MM-dd');
                        }

                        return render;
                    }()
                }, {
                    title: '损失比例',
                    dataIndex: 'eqreduce',
                    width: '30%',
                    align: 'right',
                    sort: !0,
                    render: function () {
                        function render(text, record) {
                            return text + '%';
                        }

                        return render;
                    }()
                }];

                $scope.$watch('deviceType', function () {
                    _newArrowCheck(this, _this2);

                    var _ref3 = _asyncToGenerator(regeneratorRuntime.mark(function () {
                        function _callee3(newValue, oldValue) {
                            return regeneratorRuntime.wrap(function () {
                                function _callee3$(_context3) {
                                    while (1) {
                                        switch (_context3.prev = _context3.next) {
                                            case 0:
                                                _newArrowCheck(this, _this2);

                                                _context3.next = 3;
                                                return myAjaxData.timeout(0);

                                            case 3:
                                                $scope.deviceTypeVal = '2';
                                                $scope.deviceName = '';
                                                $scope.getDeviceName(1);
                                                $scope.$apply();

                                            case 7:
                                            case 'end':
                                                return _context3.stop();
                                        }
                                    }
                                }

                                return _callee3$;
                            }(), _callee3, this);
                        }

                        return _callee3;
                    }()));

                    return function (_x4, _x5) {
                        return _ref3.apply(this, arguments);
                    };
                }.bind(this)().bind(this), !0);_asyncToGenerator(regeneratorRuntime.mark(function () {
                    function _callee4() {
                        return regeneratorRuntime.wrap(function () {
                            function _callee4$(_context4) {
                                while (1) {
                                    switch (_context4.prev = _context4.next) {
                                        case 0:
                                            _newArrowCheck(this, _this2);

                                            _context4.next = 3;
                                            return $scope.pageList.promise;

                                        case 3:
                                            _context4.next = 5;
                                            return myAjaxData.timeout(0);

                                        case 5:
                                            $scope.loadDetail($scope.pageList.res.data.data[0]);

                                        case 6:
                                        case 'end':
                                            return _context4.stop();
                                    }
                                }
                            }

                            return _callee4$;
                        }(), _callee4, this);
                    }

                    return _callee4;
                }())).bind(this)();
            }

            return controller;
        }()
    };
}.bind(void 0)]);

app.directive('pgsChart', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },
        link: function () {
            function link($scope, $element, $attrs) {
                var _this3 = this;

                $scope.$watch("detail", function (newValue, oldValue) {
                    _newArrowCheck(this, _this3);

                    newValue.res && renderChart();
                }.bind(this), !0);

                var setWidthHeight = function () {
                    _newArrowCheck(this, _this3);

                    return $($element).width(window.innerWidth - 490 < 800 ? 800 : window.innerWidth - 490 + 'px');
                }.bind(this);

                setWidthHeight();
                var myChart = echarts.init($element[0]),
                    renderChart = function () {
                    _newArrowCheck(this, _this3);

                    var option = {
                        tooltip: {
                            trigger: 'item',
                            formatter: function () {
                                function formatter(params, ticket, callback) {
                                    return params.seriesName + ': ' + params.percent + '%';
                                }

                                return formatter;
                            }()
                        },
                        series: [{
                            name: 'PBA',
                            center: ['25.0%', '50%'],
                            radius: ['80%', '55%'],
                            type: 'pie',

                            label: {
                                normal: {
                                    position: 'center'
                                }
                            },
                            labelLine: {
                                normal: {
                                    show: !1
                                }
                            },
                            data: [{
                                value: 80,
                                label: {
                                    normal: {
                                        formatter: 'PBA',
                                        textStyle: {
                                            color: '#3f3f3f',
                                            fontSize: 30
                                        }
                                    }
                                },
                                tooltip: {
                                    show: !1
                                },
                                itemStyle: {
                                    normal: {
                                        color: '#a186be'
                                    },
                                    emphasis: {
                                        color: '#a186be'
                                    }
                                },
                                hoverAnimation: !1
                            }, {
                                value: 20,
                                label: {
                                    normal: {
                                        formatter: '\n{d} %',
                                        textStyle: {
                                            color: '#605f5f',
                                            fontSize: 20
                                        }
                                    }
                                },
                                itemStyle: {
                                    normal: {
                                        color: '#7accc8'
                                    },
                                    emphasis: {
                                        color: '#7accc8'
                                    }
                                }
                            }]
                        }, {
                            name: 'PR',
                            center: ['75.0%', '50%'],
                            radius: ['80%', '55%'],
                            type: 'pie',

                            label: {
                                normal: {
                                    position: 'center'
                                }
                            },
                            labelLine: {
                                normal: {
                                    show: !1
                                }
                            },
                            data: [{
                                value: 80,
                                label: {
                                    normal: {
                                        formatter: 'PR',
                                        textStyle: {
                                            color: '#3f3f3f',
                                            fontSize: 30
                                        }
                                    }
                                },
                                tooltip: {
                                    show: !1
                                },
                                itemStyle: {
                                    normal: {
                                        color: '#f9ad81'
                                    },
                                    emphasis: {
                                        color: '#f9ad81'
                                    }
                                },
                                hoverAnimation: !1
                            }, {
                                value: 20,
                                label: {
                                    normal: {
                                        formatter: '\n{d} %',
                                        textStyle: {
                                            color: '#605f5f',
                                            fontSize: 20
                                        }
                                    }
                                },
                                itemStyle: {
                                    normal: {
                                        color: '#7accc8'
                                    },
                                    emphasis: {
                                        color: '#7accc8'
                                    }
                                }
                            }]
                        }]
                    };
                    myChart.setOption(option);
                }.bind(this);


                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this3);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));
            }

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('pgsChart2', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },

        link: function () {
            function link($scope, $element, $attrs) {
                var _this4 = this;

                $scope.$watch("detail", function (newValue, oldValue) {
                    _newArrowCheck(this, _this4);

                    if (newValue.res) renderChart(newValue.res.data);
                }.bind(this), !0);
                var setWidthHeight = function () {
                    _newArrowCheck(this, _this4);

                    $($element).width(window.innerWidth - 490 < 800 ? 800 : window.innerWidth - 490 + 'px').height(window.innerHeight - 370 < 275 ? 275 : window.innerHeight - 370 + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = echarts.init($element[0]);

                function renderChart(resData) {

                    var option = {
                        backgroundColor: '#fff',
                        tooltip: {
                            trigger: 'axis',
                            backgroundColor: 'rgba(255,255,255,0.8)',
                            extraCssText: 'box-shadow: 0 0 8px rgba(0, 0, 0, 0.3);',
                            textStyle: {
                                color: '#6a717b'
                            }

                        },
                        legend: {
                            x: 'right',
                            y: '10',
                            align: 'left',
                            data: ['平均稳定度', '稳定度']

                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '80',
                            bottom: '10',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '辐照度',
                            type: 'category',
                            data: ['5-21', '5-22', '5-23', '5-24', '5-25', '5-26', '5-27', '6-14', '6-15'],

                            axisLine: {
                                lineStyle: {
                                    color: '#666'
                                }
                            },
                            axisLabel: {
                                margin: 10,
                                textStyle: {
                                    fontSize: 12,
                                    color: '#666'
                                }
                            },
                            splitLine: {
                                lineStyle: {
                                    color: '#fff'
                                }
                            }
                        }],
                        yAxis: [{
                            name: '发电稳定性系数',
                            type: 'value',
                            axisLine: {
                                lineStyle: {
                                    color: '#666'
                                }
                            },
                            axisLabel: {
                                margin: 10,
                                textStyle: {
                                    fontSize: 12,
                                    color: '#666'
                                }
                            },
                            splitLine: {
                                lineStyle: {
                                    color: '#fff'
                                }
                            }
                        }],
                        series: [{
                            name: '平均稳定度',
                            type: 'line',

                            symbol: 'circle',
                            symbolSize: 10,
                            showSymbol: !0,
                            itemStyle: {
                                normal: {
                                    color: 'rgb(99,208,251)'
                                }
                            },
                            areaStyle: {
                                normal: {
                                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                        offset: 0,
                                        color: 'rgba(99,208,251, 0.3)'
                                    }, {
                                        offset: 0.8,
                                        color: 'rgba(99,208,251, 0.2)'
                                    }, {
                                        offset: 1,
                                        color: 'rgba(99,208,251, 0.2)'
                                    }], !1),
                                    shadowColor: 'rgba(0, 0, 0, 0.1)',
                                    shadowBlur: 10
                                }
                            },

                            data: [220, 182, 191, 134, 150, 120, 110, 125, 145, 122, 165, 122]
                        }, {
                            name: '稳定度',
                            type: 'line',

                            symbol: 'circle',
                            symbolSize: 10,
                            showSymbol: !0,
                            lineStyle: {
                                normal: {
                                    width: 2
                                }
                            },
                            areaStyle: {
                                normal: {
                                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                        offset: 0,
                                        color: 'rgba(250,146,146, 0.3)'
                                    }, {
                                        offset: 0.8,
                                        color: 'rgba(250,146,146, 0.2)'
                                    }, {
                                        offset: 1,
                                        color: 'rgba(250,146,146, 0.2)'
                                    }], !1),
                                    shadowColor: 'rgba(0, 0, 0, 0.1)',
                                    shadowBlur: 10
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: 'rgb(250,146,146)'

                                }
                            },
                            data: [120, 110, 125, 145, 122, 165, 122, 220, 182, 191, 134, 150]
                        }]
                    };
                    myChart.setOption(option);
                }

                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this4);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));
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
}, {
    url: ["GETgetJunctionBox", "GETgetInverter", "GETgetBoxchange", "GETgetAmmeter", "GETgetAerograph"]
})('powerGenerationStabilityCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);
}.bind(void 0));