var urlPre = document.getElementById('routerJS').getAttribute('param')
app.directive('wBrand', function() {
    // 将对象return出去
    return{
        restrict: 'E',
        template: '<div style="background-color: #fff;height:100%;">' +
                    '<p style="position: absolute;left: 20px;top: 20px;font-size: 16px;">风机品牌</p>' +
                    '<div w-brand-chart style="width: 100%;height:100%;"></div>' +
                '</div>',
        replace: false, 
        transculde: true,

        scope: {
            
        },

        link: function ($scope, $element, $attrs) {
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

app.directive('wBrandChart', function() {
    // 将对象return出去
    return{
        restrict: 'A',
        scope: false,
        link: function ($scope, $element, $attrs) {
            var myChart = echarts.init($element[0])

            var option = {
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series : [
                    {
                        name: '访问来源',
                        type: 'pie',
                        radius : '55%',
                        center: ['50%', '50%'],
                        data: $scope.data,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            myChart.setOption(option)

            myChart.on('click', function (params) {
                console.log(params)
            });
        },

        controller: function ($scope) {

            
        }
    }
})