'use strict';

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('colorBlock', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#color-block').html(),
        replace: !0,
        scope: {
            title: "@",
            background: '@',
            icon: '@',
            content: '@'
        }
    };
}.bind(void 0)]);

app.directive('cleaningAdviceChart', ['myAjaxData', function (myAjaxData) {
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

                    $($element).width(window.innerWidth - 220 < 800 ? 800 : window.innerWidth - 220).height(window.innerHeight - 250 < 300 ? 300 : window.innerHeight - 250);
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

                    var data = Array.apply(null, { length: 30 }).map(function (v, i) {
                        _newArrowCheck(this, _this);

                        if (i == 5) {
                            return {
                                value: Math.random() * 20,
                                symbol: 'image://' + 'http://img7.doubanio.com/view/movie_poster_cover/ipst/public/p2497756471.jpg',
                                symbolSize: ['48.75', '75'],
                                name: 'name'
                            };
                        }
                        return Math.random() * 20;
                    }.bind(this)),
                        option = {
                        title: {
                            text: '电站积灰指数'
                        },
                        color: ['#2cc6ff'],
                        tooltip: {
                            trigger: 'axis'
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
                            data: Array.apply(null, { length: 30 }).map(function (v, i) {
                                _newArrowCheck(this, _this);

                                return i + 1 + '';
                            }.bind(this))
                        }],
                        yAxis: [{
                            name: '积灰指数',
                            splitLine: {
                                show: !1
                            },
                            type: 'value'
                        }],
                        series: [{
                            name: '积灰指数',
                            type: 'bar',
                            barWidth: '20',

                            itemStyle: {
                                normal: {
                                    color: function () {
                                        function color(params) {
                                            return params.data > 10 ? '#2cc6ff' : '#7d8284';
                                        }

                                        return color;
                                    }()
                                }
                            },
                            data: data
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
}, {})('cleaningAdviceCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
    $scope.dateTime2 = new Date();
}.bind(void 0));