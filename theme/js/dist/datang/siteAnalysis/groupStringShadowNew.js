'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

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
                                                $scope.deviceTypeVal = '';
                                                $scope.deviceName = '';
                                                $scope.deviceNames = [];
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

app.directive('chart1', ['myAjaxData', function (myAjaxData) {
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

                    if (newValue.res) renderChart();
                }.bind(this), !0);

                var setWidthHeight = function () {
                    _newArrowCheck(this, _this3);

                    $($element).width((window.innerWidth - 490 < 800 ? 800 : window.innerWidth - 490) + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = null;
                function renderChart() {
                    var _this4 = this;

                    myChart = echarts.init($element[0]);

                    for (var allTime = [], i = 0; i < 24; i++) {
                        for (var j = 0, J; j < 60; j++) {
                            J = j < 10 ? '0' + j : j;

                            allTime.push(i + ':' + J);
                        }
                    }
                    var computDataArr = function (data) {
                        _newArrowCheck(this, _this4);

                        var arr = [];
                        arr.length = 1440;
                        var startTimeArr = [],
                            endTimeArr = [];

                        data.times.forEach(function (v, i) {
                            _newArrowCheck(this, _this4);

                            startTimeArr.push(allTime.indexOf(v[0]));
                            endTimeArr.push(allTime.indexOf(v[1]));
                        }.bind(this));
                        startTimeArr.forEach(function (outerV, outerIndex) {
                            _newArrowCheck(this, _this4);

                            for (var _i = 0; _i < arr.length; _i++) {
                                if (_i >= startTimeArr[outerIndex] && _i <= endTimeArr[outerIndex]) {
                                    arr[_i] = data.stringId;
                                    continue;
                                }
                            }
                        }.bind(this));
                        return arr;
                    }.bind(this),
                        seriesData = $scope.detail.res.data.map(function (v, i) {
                        _newArrowCheck(this, _this4);

                        var color = v.property == 'AbnormalShadow' ? "yellow" : v.property == 'AlwaysShadow' ? "blue" : '#999';
                        return {
                            name: '组串编号',
                            xAxisIndex: [0],
                            yAxisIndex: [0],
                            type: 'line',
                            showAllSymbol: !0,
                            symbol: 'none',
                            lineStyle: {
                                normal: {
                                    color: color,
                                    width: 5
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
                            data: computDataArr(v)
                        };
                    }.bind(this));


                    seriesData = [].concat(_toConsumableArray(seriesData), [{
                        name: '持续阴影',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: 'blue'
                            }
                        }
                    }, {
                        name: '异常阴影',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: 'yellow'
                            }
                        }
                    }, {
                        name: '普通阴影　　　　　',
                        type: 'bar',
                        itemStyle: {
                            normal: {
                                color: '#999'
                            }
                        }
                    }]);
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
                                    var _this5 = this,
                                        res = params[0].name + '<br/>';

                                    params.slice(0, -3).reverse().forEach(function (v) {
                                        _newArrowCheck(this, _this5);

                                        res += v.seriesName + ':' + (v.value || '') + '<br/>';
                                    }.bind(this));
                                    return res;
                                }

                                return formatter;
                            }()
                        },
                        legend: {
                            data: ['持续阴影', '异常阴影', '普通阴影　　　　　'],
                            x: 'right',
                            selectedMode: !1
                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '80',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '时间',
                            type: 'category',
                            splitLine: {
                                show: !1
                            },
                            axisLabel: {
                                interval: 119,
                                textStyle: {
                                    fontSize: 12
                                }
                            },
                            boundaryGap: !1,
                            data: allTime
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
                            },
                            name: '组串编号'
                        }],
                        series: seriesData
                    };
                    myChart.setOption(option);
                }

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

app.directive('chart2', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },

        link: function () {
            function link($scope, $element, $attrs) {
                var _this6 = this;

                $scope.$watch("detail", function (newValue, oldValue) {
                    _newArrowCheck(this, _this6);

                    if (newValue.res) renderChart(newValue.res.data);
                }.bind(this), !0);
                var setWidthHeight = function () {
                    _newArrowCheck(this, _this6);

                    $($element).width((window.innerWidth - 490 < 800 ? 800 : window.innerWidth - 490) + 'px').height((window.innerHeight - 420 < 225 ? 225 : window.innerHeight - 420) + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = echarts.init($element[0]),
                    renderChart = function (resData) {
                    _newArrowCheck(this, _this6);

                    resData.sort(function (a, b) {
                        _newArrowCheck(this, _this6);

                        return a.stringId - b.stringId;
                    }.bind(this));

                    var xValue = [],
                        xData = resData.map(function (v, i) {
                        _newArrowCheck(this, _this6);

                        xValue.push(v.reduce);
                        return v.stringId;
                    }.bind(this)),
                        option = {
                        color: ['#2cc6ff'],
                        tooltip: {
                            trigger: 'axis'
                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '80',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '组串编号',
                            type: 'category',
                            data: xData
                        }],
                        yAxis: [{
                            name: '损失比例(%)',
                            splitLine: {
                                show: !1
                            },
                            type: 'value'
                        }],
                        series: [{
                            name: '损失比例（%）',
                            type: 'bar',
                            barWidth: '20',
                            data: xValue
                        }]
                    };

                    myChart.setOption(option);
                }.bind(this);

                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this6);

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
})('groupStringShadowCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);
}.bind(void 0));