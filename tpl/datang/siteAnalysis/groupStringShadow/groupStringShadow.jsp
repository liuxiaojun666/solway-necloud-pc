<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/datang/groupStringShadow.css">

<script src="${ctx}/theme/js/api.js" type="text/javascript"></script>

<div ng-controller="groupStringShadowCtrl" class="groupStringShadow">
    <div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
        <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;line-height: 50px;">{{currentDataName | companyInfoFilter:parentName}}</span>
        <span style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
        <div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
    </div>

    <div class="content-body">
        <div class="content-left">
            <content-left></content-left>
        </div>

        <div class="content-right clearfix">

            <div class="chart1">
                <chart1 style="height: 310px;"></chart1>
            </div>

            <div style="display: table;width: 100%;">
                <div class="pie-chart">
                    <pie-chart style="background: #fff;width: 100%;height: 100%;display: block;"></pie-chart>
                </div>

                <div class="text-info">
                    <text-info style="background: #fff;width: 100%;min-height: 320px;display: block;"></text-info>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- 这里是页面消息列表 -->
<script type="text/html" id="content-left">
    <div class="message-remind">
        <div class="search-box">
            <input type="text" placeholder="搜索">
            <i class="fa fa-search"></i>
        </div>

        <div class="my-btn-group">
            <button class="active">全部消息</button>
            <button>已处理</button>
            <button>未处理</button>
        </div>

        <div class="operating">
            <div class="checkbox">
                <input id="000" type="checkbox">
                <label for="000"></label>
            </div>
            <div class="dropdown">
                <p>批量处理 <i class="fa fa-chevron-down"></i></p>
                <ul>
                    <li>全部设为已处理</li>
                    <li>已处理</li>
                    <li>未处理</li>
                </ul>
            </div>
        </div>

        <div class="operating-list">
            <ul>
                <li ng-repeat="item in [2,5,4,5,2,25,25,5,25,5] track by $index" class="{{$index == 0 ? 'active': ''}}">
                    <div class="checkbox">
                        <input id="{{$index}}" type="checkbox">
                        <label for="{{$index}}"></label>
                    </div>
                    <span class="equipment">1号风机</span>
                    <span class="date">2017-08-21</span>
                    <span class="status0">已处理</span>
                </li>
            </ul>
        </div>

        <div class="page-number">
            <span class="page-num">页数1/10</span>
            <span class="page-pre"><i class="fa fa-chevron-left"></i></span>
            <input type="text">
            <span class="page-go">跳转</span>
            <span class="page-next"><i class="fa fa-chevron-right"></i></span>
        </div>
    </div>
</script>
<!-- 这里是页面消息列表 END -->

<!-- 页面左边消息列表js -->
<script type="text/javascript">
    app.directive('contentLeft', function() {
        return{
            restrict: 'E',
            template: $('#content-left').html(),
            replace: false, 
            // transculde: true,
            scope: {
                
            },

            link: function ($scope, $element, $attrs) {
            },

            controller: function ($scope) {
            }
        }
    })
</script>
<!-- 页面左边消息列表js END -->

<!-- 图1阴影遮挡 -->
<script type="text/javascript">
    app.directive('chart1', function() {
        return{
            restrict: 'E',
            scope: {
                
            },

            link: function ($scope, $element, $attrs) {
                $($element).width(window.innerWidth - 200 -270 - 20 + 'px')
                var myChart = echarts.init($element[0])

                var option = {
                    xAxis: [{
                        type: 'category',
                        splitLine: {
                            show: false
                        },
                        boundaryGap: false,
                        interval: 1,
                        data: ['0:00', '1:00', '2:00', '3:00', '4:00', '5:00', '6:00', '7:00', '8:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', '0:00', ]
                    }],
                    yAxis: [{
                        type: 'value',
                        splitLine: {
                            show: false
                        },
                        nameTextStyle: {
                            fontSize: 14,
                            rotation: 2
                        },
                        name: '线路'
                    }],
                    series: [{
                        name: '邮件营销',
                        xAxisIndex: [0],
                        yAxisIndex: [0],
                        type: 'line',
                        showAllSymbol: true,
                        symbol: 'circle',
                        symbolSize: '8',
                        lineStyle: {
                            normal: {
                                color: '#999'
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
                        data: ['-', 1, 1, '-', 1, 1, '-', '-', '-', 1, 1, 1, '-']
                    }, {
                        name: '邮件营销',
                        xAxisIndex: [0],
                        yAxisIndex: [0],
                        type: 'line',
                        showAllSymbol: true,
                        symbol: 'circle',
                        symbolSize: '8',
                        lineStyle: {
                            normal: {
                                color: '#999'
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
                        data: ['-', '-', 2, 2, '-', 2, 2, '-', '-', '-', 2, 2, 2]
                    }, {
                        name: '邮件营销',
                        xAxisIndex: [0],
                        yAxisIndex: [0],
                        type: 'line',
                        showAllSymbol: true,
                        symbol: 'circle',
                        symbolSize: '8',
                        lineStyle: {
                            normal: {
                                color: '#999'
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
                        data: ['-', '-', 3, 3, '-', 3, 3, '-', '-', '-', 3, 3, 3]
                    }, {
                        name: '邮件营销',
                        xAxisIndex: [0],
                        yAxisIndex: [0],
                        type: 'line',
                        showAllSymbol: true,
                        symbol: 'circle',
                        symbolSize: '8',
                        lineStyle: {
                            normal: {
                                color: '#999'
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
                        data: ['-', '-', 4, 4, '-', 4, 4, '-', '-', '-', 4, 4, 4]
                    }]
                }
                myChart.setOption(option)
                window.onresize = function () {
                    myChart.resize();
                };
            },

            controller: function ($scope) {
            }
        }
    })
</script>
<!-- 图1阴影遮挡 END -->


<!-- 饼图 -->
<script type="text/javascript">
    app.directive('pieChart', function() {
        return{
            restrict: 'E',
            replace: false,
            scope: {
                
            },
            template: '<div style="width: 400px;height: 300px;margin: 0 auto;"></div>',

            link: function ($scope, $element, $attrs) {
                var myChart = echarts.init($element.children()[0])

                var option;

                var originalData = [{
                             value: 55,
                             name: '阴影组串数'
                         }, {
                             value: 70,
                             name: '正常组串数'
                         }]

                echarts.util.each(originalData, function(item, index) {
                 item.itemStyle = {
                     normal: {
                         color: ['#676e71', '#72bcd8',][index]
                     }
                 };
                });

                option = {
                    legend: {
                        y: 'bottom',
                        data: ['阴影组串数', '正常组串数'],
                        formatter:function(name){
                            var oa = option.series[0].data;
                            var num = oa[0].value + oa[1].value
                            for(var i = 0; i < option.series[0].data.length; i++){
                                if(name==oa[i].name){
                                    return name + '     ' + (oa[i].value / num * 100).toFixed(2) + '%';
                                }
                            }
                        }
                },
                 series: [{
                     hoverAnimation: false, //设置饼图默认的展开样式
                     radius: [40, 90],
                     name: 'pie',
                     type: 'pie',
                     selectedMode: 'single',
                     selectedOffset: 16, //选中是扇区偏移量
                     clockwise: true,
                     startAngle: 90,
                     label: {
                         normal: {
                             textStyle: {
                                 fontSize: 12,
                                 color: '#999'
                             }
                         }
                     },
                     labelLine: {
                         normal: {
                             lineStyle: {
                                 color: '#999',

                             }
                         }
                     },
                     data: originalData
                 }]
                };
                myChart.setOption(option, true);
                window.onresize = function () {
                    myChart.resize();
                };
            },

            controller: function ($scope) {
            }
        }
    })
</script>
<!-- 饼图 END -->

<!-- 文字信息 -->
<script type="text/html" id="text-info">
    <div>
        <div class="info-list">
            <h4 class="bg1">华为JC01A-5-A-06汇流箱</h4>
            <ul>
                <li><i class="bg1"></i><span>10%的组串存在阴影遮挡情况</span></li>
                <li><i class="bg1"></i><span>13号组串阴影遮挡周期</span> <br/><span>10:00-10:59</span></li>
                <li><i class="bg1"></i><span>13号组串阴影遮挡周期</span> <br/><span>10:00-10:59</span></li>
            </ul>
        </div>
        <div class="info-status">
            <h4 class="bg1">建议咨询华为运检专家xxx/汇流箱运检专家xxx 进行检查</h4>
            <div class="clearfix">
                
                <p ng-if="true">
                    <span class="pull-left color1">未处理</span>
                    <span class="pull-right" style="cursor: pointer;">设为已处理</span>
                </p>

                <p ng-if="false">
                    <span class="pull-left color0">已处理</span>
                    <span class="pull-right">处理人：张三</span> <br/>
                    <span class="color0">处理时间：2017-08-01</span>
                </p>

            </div>
        </div>
    </div>
</script>
<!-- 文字信息 END -->

<!-- 文字信息js -->
<script type="text/javascript">
    app.directive('textInfo', function() {
        return{
            restrict: 'E',
            replace: false,
            scope: {
                
            },
            template: $('#text-info').html(),

            link: function ($scope, $element, $attrs) {},

            controller: function ($scope) {}
        }
    })
</script>
<!-- 文字信息js END -->

<!-- 这里是主控制器 -->
<script type="text/javascript">
    ajaxData({
        data1: {
            name: 'getStationFaultData2',
            data: {
                id:1,
                bidss:'2001,2002,2003,2004,2005,2006,2007,2008,2009',
                iidss:'1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19',
                jidss:'146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145',
                quickSelect:false
            }
        }
    },{

    })('groupStringShadowCtrl', ['$scope', 'myAjaxData', '$timeout'], function ($scope, myAjaxData, $timeout) {
        $scope.getCurrentDataName('00', 0)
        $scope.$on('broadcastSwitchStation', function(event, data) {
            console.log('换电站啦', data)
        });

        $timeout(function () {
            $scope.data1.getData({
                id: 111
            })
        },10000)
    })
</script>
<!-- 这里是主控制器 END -->