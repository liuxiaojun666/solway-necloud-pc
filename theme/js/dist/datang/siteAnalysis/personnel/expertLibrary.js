'use strict';

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('elDetails', ['myAjaxData', '$ocLazyLoad', function (myAjaxData, $ocLazyLoad) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        template: $('#el-details').html(),
        scope: {
            detail: '='
        },
        link: function () {
            function link($scope, $element) {}

            return link;
        }()
    };
}.bind(void 0)]);

app.directive('elChart', ['myAjaxData', '$ocLazyLoad', function (myAjaxData, $ocLazyLoad) {
    _newArrowCheck(void 0, void 0);

    return {
        restrict: 'E',
        scope: {
            detail: '=',
            name: '='
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
                            name: '损失电量构成',
                            center: ['50%', '50%'],
                            radius: ['25%', '50%'],
                            type: 'pie',
                            data: [30, 50, 34, 6, 34, 74, 23, 26, 4].slice(0, myAjaxData.config[$scope.name].length).map(function (v, i) {
                                _newArrowCheck(this, _this);

                                return {
                                    name: myAjaxData.config[$scope.name][i],
                                    value: v,
                                    label: {
                                        normal: {
                                            textStyle: {
                                                color: '#3f3f3f',
                                                fontSize: 14
                                            }
                                        }
                                    },
                                    itemStyle: {
                                        normal: {
                                            color: ['#ffc275', '#fff075', '#7ede44', '#4fbfe3', '#656cf8', '#cd80e9'][i]
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
    gzName: ['塔筒及基础', '变桨系统', '测风系统', '电控系统', '机械传动系统', '发电机'],
    ppName: ['西门子', '远景', 'GE', '葛美凤', '华创', '金风'],
    xhName: ['jj-1550', 's2000', 'k2000', 'm500']
})('expertLibraryCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
    $scope.dateTime2 = new Date();

    $scope.showDetails = function (a, e) {
        _newArrowCheck(void 0, void 0);

        $('.el-details').show();
    }.bind(void 0);
    $(document).on('click.el', function () {
        _newArrowCheck(void 0, void 0);

        return $('.el-details').hide();
    }.bind(void 0));
}.bind(void 0));