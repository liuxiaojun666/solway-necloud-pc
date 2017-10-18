'use strict';

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('eeionBlock', ['myAjaxData', function (myAjaxData) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#eeion-block').html(),
        replace: !0,
        scope: {
            title: "@",
            content: '@',
            icon: '@'
        }
    };
}.bind(void 0)]);

app.directive('eeionChart', ['myAjaxData', function (myAjaxData) {
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
                    var option = {
                        backgroundColor: '#fff',
                        tooltip: {
                            trigger: 'axis'
                        },
                        legend: {
                            data: ['发电收益', '设备支出', '人员支出'],
                            x: 'right',
                            y: '20'
                        },
                        grid: {
                            left: '20',
                            right: '80',
                            bottom: '20',
                            top: '80',
                            containLabel: !0
                        },
                        xAxis: [{
                            name: '时间',
                            type: 'category',
                            data: ['2015', '2016', '2017']
                        }],
                        yAxis: [{
                            name: '费用/（万）',
                            type: 'value',
                            splitLine: {
                                show: !1
                            }
                        }],
                        color: ['#f65050', '#45bba0', '#b0d047'],
                        series: [{
                            name: '发电收益',
                            type: 'line',
                            data: [700, 800, 700]
                        }, {
                            name: '人员支出',
                            type: 'bar',
                            stack: '搜索引擎',
                            data: [120, 132, 101]
                        }, {
                            name: '设备支出',
                            type: 'bar',
                            barWidth: 20,
                            stack: '搜索引擎',
                            data: [620, 732, 701]
                        }]
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
}, {})('economicEvaluationCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date();
}.bind(void 0));