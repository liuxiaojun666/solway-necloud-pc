var urlPre = document.getElementById('routerJS').getAttribute('param')
app.directive('barChart', function() {
    // 将对象return出去
    return{
        restrict: 'E',
        template: '<div style="background-color: #fff;height:100%;">' +
                    '<div w-bar-chart style="width: 100%;height:100%;"></div>' +
                '</div>',
        replace: false, 
        transculde: true,

        scope: {
            
        },

        link: function ($scope, $element, $attrs) {
            // body...
        },

        controller: function ($scope) {

            $scope.data = [
                            {value:335, name:'直接访问'},
                            {value:310, name:'邮件营销'},
                            {value:234, name:'联盟广告'},
                            {value:135, name:'视频广告'},
                            {value:1548, name:'搜索引擎'}
                        ]
        }
    }
})

app.directive('wBarChart', function($timeout) {
    // 将对象return出去
    return{
        restrict: 'A',
        scope: false,
        link: function ($scope, $element, $attrs) {
            $timeout(function () {
                var myChart = echarts.init($element[0])

                var option = {
                    // backgroundColor: '#faf6f3',
                    // animation: false,
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow',
                        }
                    },
                    grid: {
                        top: 60,
                        bottom: 30
                    },
                    xAxis: {
                        type: 'value',
                        position: 'bottom',
                        splitLine: {
                            lineStyle: {
                                type: 'solid',
                                color: '#cfc3bd'
                            }
                        },
                    },
                    yAxis: {
                        splitNumber: 25,
                        type: 'category',
                        axisLine: {
                            lineStyle: {
                                type: 'solid',
                            }
                        },
                        axisLabel: {
                            show: true,
                            rotate: 0,
                            textStyle: {
                                color: '#682d19'
                            }
                        },
                        axisTick: {
                            show: true
                        },
                        splitLine: {
                            lineStyle: {
                                type: 'solid',
                                color: '#cfc3bd'
                            }
                        },
                        data: ['Oct', 'Sep', 'Aug', 'July', 'June', 'May', 'Apr', 'Mar', 'Feb', 'Jan']
                    },
                    series: [{
                        name: '月开支',
                        type: 'bar',
                        barGap: '-100%',
                        label: {
                            normal: {
                                textStyle: {
                                    color: '#682d19'
                                },
                                position: 'left',
                                show: false,
                                formatter: '{b}'
                            }
                        },
                        itemStyle: {
                            normal: {
                                color: '#1FBCD2',
                            }
                        },
                        data: [1900, 1029, 1602, 2004, 1100, 1800, 2800, 1407, 2200, 900]
                    }, 
                    // {
                    //     type: 'line',
                    //     silent: true,
                    //     barGap: '-100%',
                    //     data: [100, 1000, 800, 1070, 900, 300, 1200, 900, 1200, 200],
                    //     itemStyle: {
                    //         normal: {
                    //             color: '#FEDC6E',

                    //         }
                    //     },

                    // }
                    ]
                }

                myChart.setOption(option)

                function randomData() {
                    return Math.round(Math.random()*1000);
                }

                myChart.on('click', function (params) {
                    console.log(params)
                })
            }, 0)
        },

        controller: function ($scope) {

            
        }
    }
})