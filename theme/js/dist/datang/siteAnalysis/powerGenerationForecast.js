'use strict';

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('pgfBlock', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#pgf-block').html(),
        replace: !0,
        scope: {
            title: "@",
            content: '@'
        }
    };
}.bind(void 0)]);

app.directive('pgfChart', ['myAjaxData', function (myAjaxData) {
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

                    $($element).width((window.innerWidth - 220 < 800 ? 800 : window.innerWidth - 220) + 'px').height((window.innerHeight - 250 < 300 ? 300 : window.innerHeight - 250) + 'px');
                }.bind(this);

                setWidthHeight();
                var myChart = echarts.init($element[0]);
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));

                renderChart();
                function renderChart(resData) {
                    var _this2 = this,
                        items = ['月发电量', '预测月发电量', '去年同期月发电量　　　　　'],
                        colors = ['#32bca7', '#ffad1e', '#86a5a0'],
                        option = {
                        backgroundColor: '#fff',
                        legend: {
                            data: items,
                            x: 'right',
                            y: '30'
                        },
                        grid: {
                            top: '80',
                            left: '20',
                            right: '80',
                            bottom: '20',
                            containLabel: !0
                        },
                        xAxis: {
                            name: '时间',
                            data: Array.apply(null, { length: 12 }).map(function (v, i) {
                                _newArrowCheck(this, _this2);

                                return i + 1 + '月';
                            }.bind(this))
                        },
                        yAxis: {
                            name: '电量',
                            splitLine: {
                                show: !1
                            }
                        },
                        series: items.map(function (v, i) {
                            _newArrowCheck(this, _this2);

                            return {
                                name: v,
                                type: 'bar',
                                itemStyle: {
                                    normal: {
                                        color: colors[i],
                                        label: {
                                            show: !0,
                                            position: 'top',
                                            textStyle: {
                                                fontSize: 12
                                            }
                                        }
                                    }
                                },
                                data: Array.apply(null, { length: 12 }).map(function (v, i) {
                                    _newArrowCheck(this, _this2);

                                    return Math.ceil(Math.random() * 10000);
                                }.bind(this))
                            };
                        }.bind(this))
                    };

                    myChart.setOption(option);
                }
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
    }
}, {})('powerGenerationForecastCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date();
}.bind(void 0));