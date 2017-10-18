'use strict';

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg), value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('contentLeft2', ['$timeout', 'myAjaxData', function ($timeout, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#content-left2').html(),
        replace: !1,
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
                    $(".content-body .content-right").height(windowHeight - 100 < 700 ? 700 : windowHeight - 100);
                    $scope.tableScrollY = windowHeight - 275 < 525 ? 525 : windowHeight - 275;
                }.bind(this);

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
                        pageIndex: 0
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
                    title: '设备',
                    dataIndex: 'deviceName',
                    width: '20%',
                    sort: !0
                }, {
                    title: '时间',
                    dataIndex: 'beginTime',
                    width: '25%',
                    align: 'center',
                    sort: !0,
                    render: function () {
                        function render(text, record, index) {
                            if (text) {
                                return new Date(text).Format('yyyy-MM-dd');
                            }
                        }

                        return render;
                    }()
                }, {
                    title: '年衰减率',
                    dataIndex: 'eqreduce',
                    width: '25%',
                    align: 'right',
                    sort: !0
                }, {
                    title: '累计衰减率',
                    dataIndex: 'eqreduce',
                    width: '30%',
                    align: 'right',
                    sort: !0
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

app.directive('chart11', ['$timeout', 'myAjaxData', function ($timeout, myAjaxData) {
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

                    if (newValue.res != oldValue.res) renderChart();
                }.bind(this), !0);
                var setWidthHeight = function () {
                    _newArrowCheck(this, _this3);

                    $($element).width((window.innerWidth - 535 < 800 ? 800 : window.innerWidth - 535) + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = echarts.init($element[0]);
                renderChart();
                function renderChart() {
                    var _this4 = this,
                        data = [220, 182, 191, 234, 190, 330, 310, 50, 200],
                        cha = (data[0] - data[data.length - 1]) / data.length,
                        lineData = data.map(function (v, i) {
                        _newArrowCheck(this, _this4);

                        if (i == data.length - 1) {
                            return data[data.length - 1];
                        }
                        return data[0] - cha * i;
                    }.bind(this)),
                        option = {
                        tooltip: {},
                        legend: {
                            data: ['趋势', '功率']
                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '60',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: {
                            name: '点数',
                            boundaryGap: !1,
                            data: ['10', '20', '30', '40', '50', '60', '70', '80', '90']
                        },
                        yAxis: {
                            name: '功率/趋势',
                            splitNumber: 2,
                            splitLine: {
                                show: !1
                            }
                        },
                        series: [{
                            name: '功率',
                            type: 'line',
                            data: data,
                            itemStyle: {
                                normal: {
                                    color: '#35a6ff'
                                }
                            }
                        }, {
                            name: '趋势',
                            type: 'line',
                            symbol: 'none',
                            data: lineData,
                            itemStyle: {
                                normal: {
                                    color: '#ffae00'
                                }
                            }
                        }]
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
        }(),
        controller: function () {
            function controller($scope) {}

            return controller;
        }()
    };
}.bind(void 0)]);

app.directive('chart22', ['$timeout', 'myAjaxData', function ($timeout, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },

        link: function () {
            function link($scope, $element, $attrs) {
                var _this5 = this;

                $scope.$watch("detail", function (newValue, oldValue) {
                    _newArrowCheck(this, _this5);

                    if (newValue.res != oldValue.res) {
                        renderChart(newValue.res.data);
                    }
                }.bind(this), !0);
                var setWidthHeight = function () {
                    _newArrowCheck(this, _this5);

                    $($element).width((window.innerWidth - 535 < 800 ? 800 : window.innerWidth - 535) + 'px');
                }.bind(this);
                setWidthHeight();
                var myChart = echarts.init($element[0]);
                renderChart();
                function renderChart(resData) {

                    var option = {
                        color: ['#999'],
                        tooltip: {
                            trigger: 'axis'
                        },
                        grid: {
                            top: '40',
                            left: '20',
                            right: '60',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '点数',
                            type: 'category',
                            data: ['10', '20', '30', '40', '50', '60', '70', '80', '90']
                        }],
                        yAxis: [{
                            name: '灰尘影响率',
                            splitLine: {
                                show: !1
                            },
                            type: 'value'
                        }],
                        series: [{
                            name: '灰尘影响率',
                            type: 'bar',
                            barWidth: '1',
                            data: [0.023, -0.34, 0.53, 0.234, -0.190, 0.330, 0.310, -0.50, 0.200]
                        }]
                    };

                    myChart.setOption(option);
                }
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this5);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));
            }

            return link;
        }(),
        controller: function () {
            function controller($scope) {}

            return controller;
        }()
    };
}.bind(void 0)]);

app.directive('chart33', ['$timeout', 'myAjaxData', function ($timeout, myAjaxData) {
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

                    if (newValue.res != oldValue.res) renderChart();
                }.bind(this), !0);

                var setWidthHeight = function () {
                    _newArrowCheck(this, _this6);

                    $($element).width((window.innerWidth - 535 < 800 ? 800 : window.innerWidth - 535) + 'px').height((window.innerHeight - 420 < 225 ? 225 : window.innerHeight - 420) + 'px');
                }.bind(this),
                    myChart = echarts.init($element[0]);

                renderChart();

                function renderChart() {

                    var data = [0, 23, 34, 56, 76, 89, 114, 164, 220],
                        option = {
                        tooltip: {},
                        grid: {
                            top: '40',
                            left: '20',
                            right: '60',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: {
                            name: '点数',
                            boundaryGap: !1,
                            data: ['10', '20', '30', '40', '50', '60', '70', '80', '90']
                        },
                        yAxis: {
                            name: '衰减率',
                            splitNumber: 2,
                            splitLine: {
                                show: !1
                            }
                        },
                        series: [{
                            name: '功率',
                            type: 'line',
                            data: data,
                            itemStyle: {
                                normal: {
                                    color: '#f94050'
                                }
                            }
                        }]
                    };

                    myChart.setOption(option);
                }
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this6);

                    $($element).width(window.innerWidth - 200 - 315 - 20 + 'px');
                    myChart.resize();
                }.bind(this));
            }

            return link;
        }(),
        controller: function () {
            function controller($scope) {}

            return controller;
        }()
    };
}.bind(void 0)]);

ajaxData({
    pageList: {
        name: 'GETanalysisPage',
        data: {
            pageIndex: 0,
            pageSize: 10
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
})('deviceAttenuationCtrl', ['$scope', 'myAjaxData', '$timeout'], function ($scope, myAjaxData, $timeout) {
    _newArrowCheck(void 0, void 0);
}.bind(void 0));