var urlPre = document.getElementById('routerJS').getAttribute('param')
app.directive('wLine', function() {
    // 将对象return出去
    return{
        restrict: 'E',
        template: '<div style="background-color: #f9f5ec;height:100%;">' +
                    '<div w-line-chart style="width: 100%;height:100%;"></div>' +
                '</div>',
        replace: true, 
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

app.directive('wLineChart', function($timeout) {
    // 将对象return出去
    return{
        restrict: 'A',
        scope: false,
        link: function ($scope, $element, $attrs) {
            $timeout(function () {
                var myChart = echarts.init($element[0])

                var option = {
                    tooltip: {
                        show: false,
                        trigger: 'axis'
                    },
                    color: [
                    '#c23531','#2f4554', '#61a0a8','#c23531','#2f4554', '#61a0a8','#c23531','#2f4554', '#61a0a8'
                    ],
                    legend: {
                        bottom: '10%',
                        data:['远景', 'GE', '西门子', '哇哈哈']
                    },
                    grid: {
                        left: '10%',
                        top: '30%',
                        bottom: '30%',
                        right: '10%',
                        containLabel: true
                    },
                    toolbox: {
                        show: false,
                        feature: {
                            saveAsImage: {}
                        }
                    },
                    xAxis: {
                        name: '日期',
                        type: 'category',
                        boundaryGap: true,
                        splitLine: {
                            show: true,
                            lineStyle: {
                                color: ['#D4DFF5']
                            }
                        },
                        data: ['1月','2月','3月','4月','5月','6月','7月','8月','9月','10月','11月','12月']
                    },
                    yAxis: {
                        name: '故障率',
                        type: 'value',
                        max: 100,
                        splitLine: {
                            show: false
                        },
                    },
                    series: [
                        {   
                            name: '远景',
                            type:'line',
                            data:[2,92,83,55,54,48,4,75,56,59,86,58]
                        },{   
                            name: 'GE',
                            type:'line',
                            data:[92,23,5,83,55,54,48,75,56,59,86,58]
                        },{   
                            name: '西门子',
                            type:'line',
                            data:[2,92,83,55,54,48,75,56,6,59,86,58]
                        },{   
                            name: '哇哈哈',
                            type:'line',
                            data:[92,83,55,54,0,48,75,56,59,86,7,58]
                        },
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