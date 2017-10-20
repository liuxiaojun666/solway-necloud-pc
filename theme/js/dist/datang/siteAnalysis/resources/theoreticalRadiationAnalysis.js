'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('traColorBlock', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#color-block').html(),
        replace: !0,
        scope: {
            title: "@",
            background: '@',
            num: '@',
            company: '@',
            help: '@'
        },
        link: function () {
            function link($scope, $element) {
                if ($scope.help) {
                    $('<div></div>').html($scope.help).addClass('popup').appendTo($element);
                    $element.find('i.icon').on('click', function () {
                        $(this).toggleClass('active');
                        $element.find('.popup').toggle(200);
                        return !1;
                    });
                }
            }

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('traChart', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '='
        },

        link: function () {
            function link($scope, $element, $attrs) {
                var _this = this,
                    setWidthHeight = function () {
                    _newArrowCheck(this, _this);

                    $($element).width(window.innerWidth - 220 < 800 ? 800 : window.innerWidth - 220).height(window.innerHeight - 300 < 300 ? 300 : window.innerHeight - 300);
                }.bind(this);

                setWidthHeight();
                var myChart = echarts.init($element[0]);
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));

                var renderChart = function (resData) {
                    _newArrowCheck(this, _this);

                    var legend = ['理论辐射小时数', '实际辐射小时数', '实际发电小时数'],
                        option = {
                        color: ['#2cc6ff'],
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data: [{ name: '理论辐射小时数' }, { name: '实际辐射小时数' }, { name: '实际发电小时数' }, { name: '光效比' }, { name: '能效比' }],
                            itemWidth: 25,
                            itemGap: 40,
                            height: 15,
                            left: 40,
                            top: 20
                        },
                        grid: {
                            top: '80',
                            left: '20',
                            right: '20',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '',
                            type: 'category',
                            axisLine: {
                                lineStyle: {
                                    color: '#a4a4a4',
                                    width: 1
                                }
                            },
                            data: Array.apply(null, { length: 12 }).map(function (v, i) {
                                _newArrowCheck(this, _this);

                                return i + 1 + '';
                            }.bind(this))
                        }],
                        yAxis: [{
                            name: 'h',
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
                        }, {
                            name: '能效比/光效比',
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
                            _newArrowCheck(this, _this);

                            return {
                                name: v,
                                type: 'bar',
                                barWidth: '20',
                                yAxisIndex: 0,
                                itemStyle: {
                                    normal: {
                                        color: ['#58c7db', '#5896db', '#3954de'][i]
                                    }
                                },
                                data: Array.apply(null, { length: 12 }).map(function (v, i) {
                                    _newArrowCheck(this, _this);

                                    return Math.random() * 20;
                                }.bind(this))
                            };
                        }.bind(this))), [{
                            name: '光效比',
                            type: 'line',

                            symbol: 'circle',
                            yAxisIndex: 1,
                            symbolSize: 10,
                            showSymbol: !0,
                            itemStyle: {
                                normal: {
                                    color: '#22b269'
                                }
                            },
                            data: [220, 182, 191, 134, 150, 120, 110, 125, 145, 122, 165, 122]
                        }, {
                            name: '能效比',
                            type: 'line',

                            symbol: 'circle',
                            yAxisIndex: 1,
                            symbolSize: 10,
                            showSymbol: !0,
                            lineStyle: {
                                normal: {
                                    width: 2
                                }
                            },
                            itemStyle: {
                                normal: {
                                    color: '#f39b1e'

                                }
                            },
                            data: [120, 110, 125, 145, 122, 165, 122, 220, 182, 191, 134, 150]
                        }])
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
}, {})('theoreticalRadiationAnalysisCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
    $scope.dateTime2 = new Date();
}.bind(void 0));