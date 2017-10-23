'use strict';

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.directive('wpoMap', ['myAjaxData', '$ocLazyLoad', function (myAjaxData, $ocLazyLoad) {
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

                    $($element).width(window.innerWidth - 630 < 300 ? 300 : window.innerWidth - 630).height(window.innerHeight - 140 < 470 ? 470 : window.innerHeight - 140);
                }.bind(this);

                setWidthHeight();
                var myChart = echarts.init($element[0]);
                window.addEventListener('resize', function () {
                    _newArrowCheck(this, _this);

                    setWidthHeight();
                    myChart.resize();
                }.bind(this));

                $ocLazyLoad.load([document.getElementById('routerJS').getAttribute('param') + '/vendor/echarts/china.js']).then(function () {
                    _newArrowCheck(this, _this);

                    var option = {

                        series: [{
                            name: 'chinaMap',
                            type: 'map',
                            mapType: 'china',
                            roam: !0,
                            label: {
                                normal: {
                                    show: !1
                                },
                                emphasis: {
                                    show: !1
                                }
                            },
                            itemStyle: {
                                normal: {
                                    borderWidth: .5,
                                    borderColor: '#fff',
                                    areaColor: "#60b4a4" },
                                emphasis: {
                                    borderWidth: .5,
                                    borderColor: '#fff',
                                    areaColor: "#60b4a4" }
                            },
                            data: [].concat(_toConsumableArray([{ name: '山西', value: 1 }, { name: '新疆', value: 1 }, { name: '内蒙古', value: 1 }, { name: '北京', value: 1 }, { name: '广东', value: 1 }].map(function (v) {
                                _newArrowCheck(this, _this);

                                return {
                                    name: v.name,
                                    value: v.value,
                                    selected: !1,
                                    itemStyle: {
                                        normal: {
                                            areaColor: "#20668e" },
                                        emphasis: {
                                            areaColor: "#20668e" }
                                    }
                                };
                            }.bind(this))), [{
                                name: '南海诸岛',
                                itemStyle: {
                                    normal: {
                                        opacity: 0
                                    }
                                },
                                label: {
                                    normal: {
                                        show: !1
                                    }
                                }
                            }]),
                            zlevel: 3
                        }]
                    };
                    myChart.setOption(option);
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
}, {})('windPowerOperationsCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
    $scope.dateTime2 = new Date();
}.bind(void 0));