var urlPre = document.getElementById('routerJS').getAttribute('param')
app.directive('wMap', function() {
    // 将对象return出去
    return{
        restrict: 'E',
        template: '<div style="background-color: #e3f0f6;height:100%;">' +
                    '<div w-map-chart style="width: 100%;height:100%;"></div>' +
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

app.directive('wMapChart', function($timeout) {
    // 将对象return出去
    return{
        restrict: 'A',
        scope: false,
        link: function ($scope, $element, $attrs) {
            $timeout(function () {
                var myChart = echarts.init($element[0])
                var yearArr = [2013,2014,2015];
                var yearIndex = 2;
                var selectedRange = null;
                var option = null;
                var str = "";
                var data = [];
                var mapFeatures = echarts.getMap('china').geoJson.features;
                mapFeatures.forEach(function(v){
                    var name = v.properties.name;
                    var x = v.properties.cp[0];
                    var y = v.properties.cp[1];
                    str = str + "'"+ name + "':" + "[" + x + "," + y + "],";
                    if(name == '北京' || name =='山西'){
                        data.push({
                            "name":name,"value":[
                                {name:"2013",value:Math.round(Math.random() * 100 + 10)},
                                {name:"2014",value:Math.round(Math.random() * 100 + 10)},
                                {name:"2015",value:Math.round(Math.random() * 100 + 10)}
                                ]
                        })
                    }
                });

                var geoCoordMap = eval("({"+str+"})");

                function convertMapDta(year,data){
                    var mapDta = [];
                    data.forEach(function(v){
                        v.value.forEach(function(v1){
                            if(String(v1.name) === String(year)){
                                mapDta.push({
                                    "name":v.name,"value":v1.value,selected: false,
                                    itemStyle: {
                                        normal: {
                                            areaColor:"#20668e",//区域颜色
                                        },
                                        emphasis: {
                                            areaColor:"#20668e",//区域颜色
                                        }
                                    }
                                })
                            }
                        })   
                    });
                    mapDta.push({
                        name: '南海诸岛',
                        itemStyle: {
                            normal: {
                                opacity:0
                            }
                        },
                        label: {
                            normal: {
                                show: false
                            }
                        }
                    });
                    return mapDta;
                }

                function resetPie(myChart,params,geoCoordMap,yearIndex){
                    var op = myChart.getOption();
                    var ops = op.series;
                    ops.forEach(function(v,i){
                        if(i > 0){
                            var geoCoord = geoCoordMap[v.name];
                            var p = myChart.convertToPixel({seriesIndex: 0}, geoCoord);
                            v.center = p; 
                            if(params != 0 && params.zoom){
                                v.radius = v.radius * params.zoom;
                            }
                            if(params != 0 && params.selected){
                                var rangeFirstNumber = params.selected[0];
                                var rangeSecondNumber = params.selected[1];
                                var pd = v.data[yearIndex].value;
                                if(pd < rangeFirstNumber || pd > rangeSecondNumber){
                                    v.itemStyle.normal.opacity = 0;
                                }else{
                                    v.itemStyle.normal.opacity = 1;
                                }
                            }
                        }
                    });
                    myChart.setOption(op,true);
                }

                function addPie(chart,data) {
                    var op = chart.getOption();
                    var sd = option.series;
                    for (var i = 0; i < data.length; i++) {
                        var randomValue = Math.round(Math.random() * 30);
                        var radius = randomValue <= 10 ? 10 : randomValue;
                        var geoCoord = geoCoordMap[data[i].name];
                        if (geoCoord) {
                            var vr = [];
                            (data[i].value).map(function(v,j){
                                vr.push({name:v.name,value:v.value});
                            });
                            var p = chart.convertToPixel({seriesIndex: 0}, geoCoord);
                            sd.push(
                                {
                                    name:data[i].name,
                                    type:'pie',
                                    tooltip:{
                                        formatter:function(params){
                                            return params.seriesName + "<br/>" + params.name + " : " + params.value;
                                        }
                                    },
                                    radius : radius,
                                    center: p,
                                    data:vr,
                                    zlevel:4,
                                    label: {
                                        normal: {
                                            show: false,
                                        },
                                    },
                                    labelLine: {
                                        normal: {
                                            show: false
                                        }
                                    },
                                    itemStyle:{
                                        mormal:{
                                           opacity:1 
                                        }
                                    }
                                }
                            );
                        }
                    }
                    return sd;
                };

                option = {
                    title: {
                        text: 'test',
                        left: 'center',
                        textStyle: {
                            color: '#fff'
                        }
                    },
                    tooltip : {
                        trigger: 'item',
                        formatter:function(params){
                            if(params.value){
                                return params.name + "<br/>"+ yearArr[yearIndex] +": "+ params.value;
                            }
                        }
                    },
                    // visualMap: {
                    //     min: 0,
                    //     max: 120,
                    //     left: 'left',
                    //     top: 'bottom',
                    //     seriesIndex:0,
                    //     text: ["高", "低"],
                    //     calculable: true,
                    //     color: ['#c05050','#e5cf0d','#5ab1ef'],
                    // },
                    series : [{
                        name: 'chinaMap',
                        type: 'map',
                        mapType: 'china',
                        roam:true,
                        label: {
                            normal: {
                                show: false
                            },
                            emphasis: {
                                show: false
                            }
                        },
                        itemStyle:{
                            normal: {
                                borderWidth: .5,//区域边框宽度
                                borderColor: '#fff',//区域边框颜色
                                areaColor:"#60b4a4",//区域颜色
                            },
                            emphasis: {
                                borderWidth: .5,//区域边框宽度
                                borderColor: '#fff',//区域边框颜色
                                areaColor:"#60b4a4",//区域颜色
                            }
                        },
                        data:convertMapDta(yearArr[yearIndex],data),
                        zlevel:3
                    }]
                };

                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }

                addPie(myChart,data);
                myChart.setOption(option,true);

                myChart.on('georoam', function (params) {
                    resetPie(myChart,params,geoCoordMap,yearIndex);
                });

                myChart.on('datarangeselected', function (params) {
                    resetPie(myChart,params,geoCoordMap,yearIndex);
                });

                window.addEventListener("resize",function(){
                    myChart.resize();
                    resetPie(myChart,0,geoCoordMap);
                })



                // myChart.on('click', function (params) {
                //     console.log(params)
                // })
            }, 0)
        },

        controller: function ($scope) {

            
        }
    }
})