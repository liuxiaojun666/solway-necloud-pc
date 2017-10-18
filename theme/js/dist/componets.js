'use strict';

var _extends = Object.assign || function (target) { for (var i = 1, source; i < arguments.length; i++) { source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };

function _asyncToGenerator(fn) { return function () { var gen = fn.apply(this, arguments); return new Promise(function (resolve, reject) { function step(key, arg) { try { var info = gen[key](arg), value = info.value; } catch (error) { reject(error); return; } if (info.done) { resolve(value); } else { return Promise.resolve(value).then(function (value) { step("next", value); }, function (err) { step("throw", err); }); } } return step("next"); }); }; }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

var baseUrl = document.getElementById('routerJS').getAttribute('param')
app.directive('dLoding', [function () {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'A',
        transclude: !0,
        replace: !0,
        scope: {
            dLoding: '='
        },
        template: '\n<div>\n    <div ng-transclude class="clearfix" style="height:100%;"></div>\n    <div class="loding-view" ng-if="dLoding" style="position:absolute;width:100%;height:100%;top:0;left:0;z-index:9999;text-align:center;background:rgba(255,255,255,.8)">\n    <div class="spinner">\n        <div class="rect1"></div>\n        <div class="rect2"></div>\n        <div class="rect3"></div>\n        <div class="rect4"></div>\n        <div class="rect5"></div>\n    </div>\n    </div>\n</div>',
        link: function () {
            function link($scope, $element) {
                $($element).css('position', 'relative');
            }

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('hasContent', [function () {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'A',
        replace: !0,
        transclude: !0,
        scope: {
            hasContent: '='
        },
        template: '\n<div style="height:100%;">\n    <div ng-transclude ng-if="hasContent" class="clearfix" style="height:100%;"></div>\n    <div ng-if="!hasContent" style="text-align:center;height: 100%;position:relative">\n        <img style="position:absolute;top:50%;left:50%;margin-left:-124px;margin-top:-124px;" src="' + baseUrl + '/theme/images/noMessage.png" alt="" />\n    </div>\n</div>'
    };
}.bind(void 0)]);

app.directive('myPaging', [function () {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        replace: !1,
        templateUrl: baseUrl + '/tpl/publicComponent/paging.jsp',
        scope: {
            getData: '=',
            paging: '=',
            pageSize: '@'
        },
        controller: function () {
            function controller($scope, $element) {
                var _this = this;

                $scope.showPageSize = 10;
                $scope.mygetData = function (obj, arg2) {
                    _newArrowCheck(this, _this);

                    if (arg2) return;
                    $scope.getData(obj);
                }.bind(this);
            }

            return controller;
        }()
    };
}.bind(void 0)]);

app.directive('myTable', ['$timeout', 'myAjaxData', function ($timeout, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        transclude: !0,
        replace: !0,
        scope: {
            column: '=',
            datasource: '=',
            trClick: '=',
            scrollY: '=',
            trackBy: '@',
            beforeCreate: '=',
            created: '=',
            beforeMount: '=',
            mounted: '=',
            beforeUpdate: '=',
            updated: '=',
            beforeDestroy: '=',
            destroyed: '='
        },
        templateUrl: baseUrl + '/tpl/publicComponent/myTable.jsp',
        link: function () {
            function link($scope, $element) {
                var _this2 = this;

                $scope.beforeMount && $scope.beforeMount($scope, $element);
                $timeout(function () {
                    _newArrowCheck(this, _this2);

                    $scope.mounted && $scope.mounted($scope, $element);
                    $scope.isMounted = !0;
                }.bind(this), 0);
            }

            return link;
        }(),
        controller: function () {
            function controller($scope, $element) {
                var _this3 = this;

                $scope.beforeCreate && $scope.beforeCreate($scope, $element);

                $scope.orderBy = !0;
                $scope.sort = function (sort, dataIndex) {
                    _newArrowCheck(this, _this3);

                    if (void 0 === $scope.datasource[0]) return;
                    if (!sort) return;
                    if (dataIndex !== $scope.orderByDataIndex) {
                        $scope.orderByDataIndex = dataIndex;
                        $scope.orderBy = !0;
                    }
                    if (typeof $scope.datasource[0][dataIndex] == 'number') {
                        $scope.datasource.sort(function (a, b) {
                            _newArrowCheck(this, _this3);

                            return $scope.orderBy ? a[dataIndex] - b[dataIndex] : b[dataIndex] - a[dataIndex];
                        }.bind(this));
                    } else {
                        $scope.orderBy && $scope.datasource.sort(function (a, b) {
                            _newArrowCheck(this, _this3);

                            return null === a[dataIndex] || null === b[dataIndex] ? -1 : a[dataIndex].length == b[dataIndex].length ? b[dataIndex].localeCompare(a[dataIndex]) : b[dataIndex].length - a[dataIndex].length;
                        }.bind(this));
                        $scope.datasource.reverse();
                    }
                    $scope.gen.next($scope.orderByDataIndex);
                    $scope.orderBy = !$scope.orderBy;
                }.bind(this);

                $scope.$watch('datasource', function (newValue, oldValue) {
                    _newArrowCheck(this, _this3);

                    $scope.gen = regeneratorRuntime.mark(function () {
                        function _callee() {
                            return regeneratorRuntime.wrap(function () {
                                function _callee$(_context) {
                                    while (1) {
                                        switch (_context.prev = _context.next) {
                                            case 0:
                                                $scope.orderByDataIndex = void 0;
                                                _context.next = 3;
                                                return;

                                            case 3:
                                                $scope.orderByDataIndex = _context.sent;

                                            case 4:
                                            case 'end':
                                                return _context.stop();
                                        }
                                    }
                                }

                                return _callee$;
                            }(), _callee, this);
                        }

                        return _callee;
                    }())();
                    $scope.gen.next();
                    $timeout(function () {
                        _newArrowCheck(this, _this3);

                        if ($scope.orderByDataIndex) return;
                        $scope.gen.next(void 0);
                        if ($scope.trackBy) $scope.sort(!0, $scope.trackBy);
                        if ($scope.scrollY) {
                            var _$element = $($element);
                            if (_$element.find('.my-table-body').height() > _$element.find('.my-table-body table').height()) {
                                _$element.find('.my-table-head').css('padding-right', '0px');
                            } else {
                                _$element.find('.my-table-head').css('padding-right', '17px');
                            }
                        }
                    }.bind(this), 0);
                }.bind(this));

                $scope.$watchGroup(['datasource', 'column'], function () {
                    _newArrowCheck(this, _this3);

                    var _ref = _asyncToGenerator(regeneratorRuntime.mark(function () {
                        function _callee2(newValue, oldValue, $scope) {
                            return regeneratorRuntime.wrap(function () {
                                function _callee2$(_context2) {
                                    while (1) {
                                        switch (_context2.prev = _context2.next) {
                                            case 0:
                                                _newArrowCheck(this, _this3);

                                                if ($scope.isMounted) {
                                                    _context2.next = 3;
                                                    break;
                                                }

                                                return _context2.abrupt('return');

                                            case 3:
                                                $scope.beforeUpdate && $scope.beforeUpdate($scope, $element);
                                                _context2.next = 6;
                                                return myAjaxData.timeout(0);

                                            case 6:
                                                $scope.updated && $scope.updated($scope, $element);

                                            case 7:
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

                    return function (_x, _x2, _x3) {
                        return _ref.apply(this, arguments);
                    };
                }.bind(this)().bind(this));

                $element.on('$destroy', _asyncToGenerator(regeneratorRuntime.mark(function () {
                    function _callee3() {
                        return regeneratorRuntime.wrap(function () {
                            function _callee3$(_context3) {
                                while (1) {
                                    switch (_context3.prev = _context3.next) {
                                        case 0:
                                            _newArrowCheck(this, _this3);

                                            $scope.beforeDestroy && $scope.beforeDestroy($scope, $element);
                                            _context3.next = 4;
                                            return myAjaxData.timeout(0);

                                        case 4:
                                            $scope.destroyed && $scope.destroyed($scope, $element);

                                        case 5:
                                        case 'end':
                                            return _context3.stop();
                                    }
                                }
                            }

                            return _callee3$;
                        }(), _callee3, this);
                    }

                    return _callee3;
                }())).bind(this));

                $scope.created && $scope.created($scope, $element);
            }

            return controller;
        }()
    };
}.bind(void 0)]);

app.directive('switchPower', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        transclude: !0,
        replace: !0,
        scope: !0,
        templateUrl: baseUrl + '/tpl/publicComponent/switchPower.jsp',
        controller: function () {
            function controller($scope) {
                var _this4 = this;

                $scope.getCurrentDataName('00', 0, function (result) {
                    _newArrowCheck(this, _this4);

                    $scope.currentDataName = result.currentDataName;
                    myAjaxData.setCurrentStationData(result);
                }.bind(this));
                $scope.$on('broadcastSwitchStation', function (event, data) {
                    _newArrowCheck(this, _this4);

                    $scope.currentDataName = data.dataName;
                    myAjaxData.setCurrentStationData({ currentDataName: data.dataName, currentSTID: data.dataId });
                    $scope.reload();
                }.bind(this));
            }

            return controller;
        }()
    };
}.bind(void 0)]);

app.directive('calendar', ['$ocLazyLoad', '$timeout', function ($ocLazyLoad, $timeout) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        transclude: !0,
        replace: !0,
        scope: {
            dateTime: '=',
            endDate: '=',
            startDate: '=',
            calendarType: '@',
            showArrow: '='
        },
        template: '\n    <div class="calendar">\n        <span ng-if="showArrow" ng-click="changeDateTime(-1)"><i class="fa fa-angle-left"></i></span>\n        <input type="text" value="{{showDate}}" ng-model="showDate">\n        <span ng-if="showArrow" ng-click="changeDateTime(1)"><i class="fa fa-angle-right"></i></span>\n    </div>',
        link: function () {
            function link($scope, $element) {
                var _this5 = this,
                    calendarMap = {
                    "yyyy-MM-dd": {
                        minView: 2
                    },
                    "yyyy-MM": {
                        minView: 3,
                        startView: 3
                    },
                    yyyy: {
                        minView: 4,
                        startView: 4
                    }
                };

                $scope.randomId = (Math.random() + '').substr(2, 10);
                $($element).find('input').attr('id', $scope.randomId);
                $ocLazyLoad.load([baseUrl + '/vendor/bootstrap/css/bootstrap-datetimepicker.min.css', baseUrl + '/vendor/bootstrap/js/bootstrap-datetimepicker.js']).then(function () {
                    _newArrowCheck(this, _this5);

                    return $ocLazyLoad.load([baseUrl + '/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js', baseUrl + '/vendor/libs/moment.min.js']);
                }.bind(this)).then(function () {
                    _newArrowCheck(this, _this5);

                    $('#' + $scope.randomId).datetimepicker(_extends({
                        format: $scope.calendarType.toLocaleLowerCase(),
                        language: 'zh-CN',
                        todayHighlight: !0,
                        todayBtn: !0,
                        autoclose: !0,
                        endDate: $scope.endDate || new Date(),
                        startDate: $scope.startDate || new Date('1970', '01', '01')
                    }, calendarMap[$scope.calendarType], {
                        initialDate: $scope.dateTime,
                        pickerPosition: "bottom-left"
                    })).on('hide', function (ev) {
                        _newArrowCheck(this, _this5);

                        $scope.dateTime = ev.date;
                        $scope.$apply();
                    }.bind(this)).on('changeDate', function (ev) {
                        _newArrowCheck(this, _this5);

                        $scope.showArrow && $scope.disabled();
                    }.bind(this));
                }.bind(this));
                $timeout(function () {
                    _newArrowCheck(this, _this5);

                    return $scope.showArrow && $scope.disabled();
                }.bind(this), 0);
            }

            return link;
        }(),
        controller: function () {
            function controller($scope, $element) {
                var _this6 = this;

                $scope.disabled = function (noChange) {
                    _newArrowCheck(this, _this6);

                    var showDateLastNumber = +$scope.showDate.split('-').slice(-1),
                        startLastNumber = '',
                        endLastNumber = '',
                        startDate = $scope.startDate || new Date('1970', '01', '01'),
                        endDate = $scope.endDate || new Date();

                    switch ($scope.calendarType.substr(-1, 1)) {
                        case 'y':
                            startLastNumber = startDate.getFullYear();
                            endLastNumber = endDate.getFullYear();
                            break;
                        case 'M':
                            startLastNumber = startDate.getMonth() + 1;
                            endLastNumber = endDate.getMonth() + 1;
                            break;
                        case 'd':
                            startLastNumber = startDate.getDate();
                            endLastNumber = endDate.getDate();
                            break;
                    }
                    var num = 0;
                    if (showDateLastNumber === startLastNumber) {
                        if (noChange) num = -1;else $($element).find('.fa-angle-left').parent().addClass('disabled');
                    } else {
                        if (!noChange) $($element).find('.fa-angle-left').parent().removeClass('disabled');
                    }
                    if (showDateLastNumber === endLastNumber) {
                        if (noChange) num = 1;else $($element).find('.fa-angle-right').parent().addClass('disabled');
                    } else {
                        if (!noChange) $($element).find('.fa-angle-right').parent().removeClass('disabled');
                    }
                    return num;
                }.bind(this);
                $scope.$watch('showDate', function (newValue, oldValue) {
                    _newArrowCheck(this, _this6);

                    if (void 0 === window.moment) return;
                    if (newValue != oldValue) {
                        var newDateTime = moment(newValue)._d;
                        if ((newDateTime + '').toLocaleLowerCase() == "invalid date") {
                            return promptObj("error", "", "error" + "\n" + "您输入的日期或时间格式错误");
                        }
                        $scope.dateTime = newDateTime;
                    }
                }.bind(this));
                $scope.$watch('dateTime', function (newValue, oldValue) {
                    _newArrowCheck(this, _this6);

                    $scope.showDate = $scope.dateTime.Format($scope.calendarType);
                }.bind(this));
                $scope.$watch('startDate', function (newValue, oldValue) {
                    _newArrowCheck(this, _this6);

                    if (newValue != oldValue) $('#' + $scope.randomId).datetimepicker('setStartDate', newValue.Format($scope.calendarType));
                }.bind(this));
                $scope.$watch('endDate', function (newValue, oldValue) {
                    _newArrowCheck(this, _this6);

                    if (newValue != oldValue) $('#' + $scope.randomId).datetimepicker('setEndDate', newValue.Format($scope.calendarType));
                }.bind(this));
                $scope.changeDateTime = function (num) {
                    _newArrowCheck(this, _this6);

                    if (num === $scope.disabled(!0)) return;
                    $scope.dateTime = moment($scope.dateTime).add(num, $scope.calendarType.substr(-1, 1))._d;
                    $timeout(function () {
                        _newArrowCheck(this, _this6);

                        return $scope.disabled();
                    }.bind(this), 0);
                }.bind(this);
            }

            return controller;
        }()
    };
}.bind(void 0)]);