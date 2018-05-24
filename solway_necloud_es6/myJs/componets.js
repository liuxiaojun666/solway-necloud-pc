/*************************************  注意   看这里  *******************************************
 *
 *
 *
 *
 *
 *
 *
 * 
 *
 *
 * 
 *
 *
 * 
 *                         若要修改此文件，请先更改baseUrl  为  注释内容
 * 
 *
 *
 *
 *
 *
 *
 *
 *
 *
 * 
 *
 *
 * 
 *
 * 
 * *************************************  注意   看这里  *******************************************
 */

window.baseUrl = document.getElementById('routerJS').getAttribute('param')
/**
 * [loding动画]
 * params{d-loding="true/false"}
 */
app.directive('dLoding', [() => ({
    restrict: 'A',
    transclude: !0,
    replace: !0,
    scope: {
        dLoding: '='
    },
    template: `
<div>
    <div ng-transclude class="clearfix" style="height:100%;"></div>
    <div class="loding-view" ng-if="dLoding" style="position:absolute;width:100%;height:100%;top:0;left:0;z-index:9999;text-align:center;background:rgba(255,255,255,.8)">
    <div class="spinner">
        <div class="rect1"></div>
        <div class="rect2"></div>
        <div class="rect3"></div>
        <div class="rect4"></div>
        <div class="rect5"></div>
    </div>
    </div>
</div>`,
    link($scope, $element) {
        $($element).css('position', 'relative')
    }
})])
/**
 * [未选择时显示  未选择图片]
 * params{has-content="data"} data为假  显示图片
 */
app.directive('hasContent', [() => ({
    restrict: 'A',
    replace: !0,
    transclude: !0,
    scope: {
        hasContent: '='
    },
    template: `
<div style="height:100%;">
    <div ng-transclude ng-if="hasContent" class="clearfix" style="height:100%;"></div>
    <div ng-if="!hasContent" style="text-align:center;height: 100%;position:relative">
        <img style="position:absolute;top:50%;left:50%;margin-left:-124px;margin-top:-124px;" src="${baseUrl}/theme/images/noMessage.png" alt="" />
    </div>
</div>`,
})])

/**
 * [分页]
 * params{
 * get-data="接口自定义名.getData",  
 * paging="接口返回数据中包含分页信息部分"    
 * pageSize="none"} pageSize为none时不显示每页多少条默认10条
 */
app.directive('myPaging', ['myAjaxData', (myAjaxData) => ({
    restrict: 'E',
    replace: !1,
    templateUrl: baseUrl + '/tpl/publicComponent/paging.jsp',
    scope: {
        getData: '=',
        paging: '=',
        pageSize: '@',
        defaultPageSize: '='
    },
    controller($scope, $element) {
        $scope.mygetData = (obj, arg2) => {
            if (arg2) return
            $scope.getData(obj)
        }
    }
})])



/**
 * 下拉
 */
app.directive('dropDown', ['myAjaxData', myAjaxData => ({
    restrict: 'E',
    templateUrl: baseUrl + '/tpl/publicComponent/dropDown.html',
    replace: true,
    scope: {
        options: '=',
        selected: '=',
        updated: '='
    },
    link($scope, $element) {
        $element.find('.selected').on('click', function () {
            $(this).next('.options').slideToggle(200)
            return false;
        })
        $(document).on('click', () => {
            $element.find('.options').slideUp(200)
        })
    },
    controller($scope) {
        $scope.onSelect = (value) => {
            $scope.selected = value
            $scope.updated && $scope.updated(value)
        }
    }
})])

Date.create = (...arg) => new Date(...arg);
Array.create = (...arg) => new Array(...arg);

/**
 * 该过滤器 值为null 的字符串
 */
app.filter('filter_null', () => text => text == null ? '-' : text)

/**
 * 该过滤器  可以 调用任意 输入值的 任意函数
 * 使用方法   input | self_func: 'substr': 0: 4   //表示 把输入的 input 使用函数 substr 过滤  参数为  （0, 4）
 */
app.filter('self_func', () => (input, funcName, ...arg) => input && input[funcName] && input[funcName](...arg));

/**
 * 该过滤器 使用  传入的函数过滤 （输入的值为参数）
 * 使用方法   input | func: 'Object.keys'
 */
app.filter('func', () => (input, funcName, ...arg) => {
    if (!input) return input;
    let func;
    try {
        func = eval(funcName);
    } catch (error) {
        console.error(error);
    }
    if (!func) return input;
    return func(input);
});

/**
 * 该过滤器 过滤html 单标签不能绑定的问题
 */
app.filter('to_trusted', ['$sce', $sce => v => $sce.trustAsHtml(v)])


/**
 * [表格]
 *  column: '=',   列
 *      title       列名
 *      dataIndex   对应数据的字段名
 *      width       列width
 *      align       水平对齐方式
 *      sort        是否排序  布尔值
 *      render(text, record, index) 渲染函数，   text：dataIndex   record: 对应数据（datasource）中当前记录对象   index：当前行（datasource）的index
 *          render 方法 return 可传自定义事件 lxj-click    该事件只接收字符串参数
    datasource: '=',   行
    trClick: '=',    tr-click='点击行要执行的函数'  可不传
    scrollY: '=',   滚动部分的高度  不传不滚动
    trackBy: '@',   默认根据哪个字段排序   不传不排序
    beforeCreate: '=',       类vue生命周期
    created: '=',           类vue生命周期
    beforeMount: '=',       类vue生命周期
    mounted: '=',           类vue生命周期
    beforeUpdate: '=',      类vue生命周期
    updated: '=',           类vue生命周期
    beforeDestroy: '=',     类vue生命周期
    destroyed: '=',         类vue生命周期
 */
app.directive('myTable', ['$timeout', 'myAjaxData', ($timeout, myAjaxData) => ({
    restrict: 'E',
    transclude: !0,
    replace: !0,
    scope: {
        column: '=',
        datasource: '=',
        trClick: '=',
        scrollY: '=',
        trackBy: '@',
        beforeCreate: '=',
        created: '=',
        beforeMount: '=',
        mounted: '=',
        beforeUpdate: '=',
        updated: '=',
        beforeDestroy: '=',
        destroyed: '=',
    },
    templateUrl: baseUrl + '/tpl/publicComponent/myTable.jsp',
    link($scope, $element) {
        $scope.beforeMount && $scope.beforeMount($scope, $element)
        $timeout(() => {
            Array.from($element.find('th')).forEach(dv => {
                const $inputs = () => $element.find(`input[name=${name}]`)
                const { name } = dv.dataset
                if (!name) return
                $(dv).find('input:checkbox').on('click', function (e) {
                    e.stopPropagation()
                    if (this.checked) Array.from($inputs()).forEach(v => v.checked = true)
                    else Array.from($inputs()).forEach(v => v.checked = false)
                })

                $element.on('click', `input[name=${name}]`, e => {
                    e.stopPropagation()
                    $(dv).find('input:checkbox').prop('checked', Array.from($inputs()).every(v => v.checked === true))
                })
            })

            $element.find('[lxj-click]').on('click', function (e) {
                e.stopPropagation()
                const arr = $(this).attr('lxj-click').split('(')
                $scope[arr[0]](...arr[1].split(')')[0].split(','))
            })

            $scope.mounted && $scope.mounted($scope, $element)
            $scope.isMounted = !0
        }, 0)
    },
    controller($scope, $element) {
        $scope.beforeCreate && $scope.beforeCreate($scope, $element)

        $scope.orderBy = !0
        $scope.sort = (sort, dataIndex) => {
            if (void 0 === $scope.datasource[0]) return
            if (!sort) return
            if (dataIndex !== $scope.orderByDataIndex) {
                $scope.orderByDataIndex = dataIndex
                $scope.orderBy = !0
            }
            if (typeof $scope.datasource[0][dataIndex] === 'number') {
                $scope.datasource.sort((a, b) => {
                    return $scope.orderBy ? a[dataIndex] - b[dataIndex] : b[dataIndex] - a[dataIndex]
                })
            } else {
                $scope.orderBy && $scope.datasource.sort((a, b) => {
                    return do {
                        if (null === a[dataIndex] || null === b[dataIndex]) -1
                        else if (a[dataIndex].length == b[dataIndex].length) b[dataIndex].localeCompare(a[dataIndex])
                        else b[dataIndex].length - a[dataIndex].length
                    }
                })
                $scope.datasource.reverse()
            }
            $scope.gen.next($scope.orderByDataIndex)
            $scope.orderBy = !$scope.orderBy
        }

        $scope.$watch('datasource', (newValue, oldValue) => {
            $scope.gen = (function* () {
                $scope.orderByDataIndex = void 0
                $scope.orderByDataIndex = yield
            })()
            $scope.gen.next()
            $timeout(() => {
                if ($scope.orderByDataIndex) return
                $scope.gen.next(void 0)
                if ($scope.trackBy) $scope.sort(!0, $scope.trackBy)
                if ($scope.scrollY) {
                    const _$element = $($element)
                    if (_$element.find('.my-table-body').height() > _$element.find('.my-table-body table').height()) {
                        _$element.find('.my-table-head').css('padding-right', '0px')
                    } else {
                        _$element.find('.my-table-head').css('padding-right', '17px')
                    }
                }
            }, 0)
        })

        $scope.$watchGroup(['datasource', 'column'], async (newValue, oldValue, $scope) => {
            if (!$scope.isMounted) return
            $scope.beforeUpdate && $scope.beforeUpdate($scope, $element)
            await myAjaxData.timeout(0)
            $scope.updated && $scope.updated($scope, $element)
        })

        $element.on('$destroy', async () => {
            $scope.beforeDestroy && $scope.beforeDestroy($scope, $element)
            await myAjaxData.timeout(0)
            $scope.destroyed && $scope.destroyed($scope, $element)
        })

        $scope.created && $scope.created($scope, $element)
    }
})])

/**
 * [切换电站头]
 */
app.directive('switchPower', ['myAjaxData', myAjaxData => ({
    restrict: 'E',
    transclude: !0,
    replace: !0,
    scope: !0,
    templateUrl: baseUrl + '/tpl/publicComponent/switchPower.jsp',
    controller($scope) {
        $scope.getCurrentDataName('00', 0, (result) => {
            $scope.currentDataName = result.currentDataName
            myAjaxData.setCurrentStationData(result)
            $scope.switchPowerCallback && $scope.switchPowerCallback()
        })
        $scope.$on('broadcastSwitchStation', (event, data) => {
            $scope.currentDataName = data.dataName
            myAjaxData.setCurrentStationData({ currentDataName: data.dataName, currentSTID: data.dataId })
            $scope.reload()
            $scope.switchPowerCallback && $scope.switchPowerCallback()
        })
    }
})])

/**
 * [切换电站头-公司可点]
 */
app.directive('switchPower1', ['myAjaxData', myAjaxData => ({
    restrict: 'E',
    transclude: !0,
    replace: !0,
    scope: !0,
    templateUrl: baseUrl + '/tpl/publicComponent/switchPower.jsp',
    controller($scope) {
        $scope.getCurrentDataName('00', 1, (result) => {
            $scope.currentDataName = result.currentDataName
            myAjaxData.setCurrentStationData(result)
        })
        $scope.$on('broadcastSwitchStation', (event, data) => {
            $scope.currentDataName = data.dataName
            myAjaxData.setCurrentStationData({ currentDataName: data.dataName, currentSTID: data.dataId })
            $scope.reload()
        })
    }
})])

/**
 * [日历时间]    input样式手动设置
 * dateTime: '=',       初始显示时间   dateTime 添加shouDate属性（显示在页面的字符串）
    endDate: '=',       结束时间
    startDate: '=',     开始时间
    calendarType: '@'   日历类型   (yyyy-MM-dd   yyyy-MM  yyyy等)
    showArrow           是否显示左右箭头
    week                周  需设  calendar-type 为  yyyy-MM-dd
    callback            dateTime改变之后的回调函数(oldValue, newValue)
    input               是否可手动输入   默认false （不可手动输入）
 */
app.directive('calendar', ['$ocLazyLoad', '$timeout', 'myAjaxData', ($ocLazyLoad, $timeout, myAjaxData) => ({
    restrict: 'E',
    transclude: !0,
    replace: !0,
    scope: {
        dateTime: '=',
        endDate: '=',
        startDate: '=',
        calendarType: '@',
        showArrow: '=',
        week: '@',
        input: '=',
        beforeCreate: '=',
        created: '=',
        beforeMount: '=',
        mounted: '=',
        beforeUpdate: '=',
        updated: '=',
        beforeDestroy: '=',
        destroyed: '=',
    },
    template: `
    <div class="calendar" style="position:relative;">
        <span ng-show="showArrow" ng-click="changeDateTime(-1)"><i class="fa fa-angle-left"></i></span>
        <input type="text">
        <span ng-show="showArrow" ng-click="changeDateTime(1)"><i class="fa fa-angle-right"></i></span>
        <p ng-if="week" style="position:absolute;left: 20px;right: 20px;top: 0;bottom: 0;margin: 0;text-align: center;background-color: #fff;pointer-events: none;">
            {{weekStart + '至' + weekEnd}}
        </p>
    </div>`,
    link($scope, $element) {
        $scope.beforeMount && $scope.beforeMount($scope, $element)
        const calendarMap = {
            'yyyy-MM-dd hh:mm:ss': {},
            'yyyy-MM-dd hh:mm': {},
            'yyyy-MM-dd hh': {
                minView: 1,
            },
            'yyyy-MM-dd': {
                minView: 2,
            },
            'yyyy-MM': {
                minView: 3,
                startView: 3,
            },
            'yyyy': {
                minView: 4,
                startView: 4,
            }
        }
        $scope.randomId = (Math.random() + '').substr(2, 10)
        const $input = $($element).find('input').attr('id', $scope.randomId)
        $scope.input || $input.on('focus', () => $input.blur())
        $ocLazyLoad.load([
            baseUrl + '/vendor/bootstrap/css/bootstrap-datetimepicker.min.css',
            baseUrl + '/vendor/bootstrap/js/bootstrap-datetimepicker.js'
        ]).then(() => $ocLazyLoad.load([
            baseUrl + '/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js',
            baseUrl + '/vendor/libs/moment.min.js'
        ])).then(() => {
            const showDate = $scope.dateTime.showDate
            $input.val(showDate)
            $scope.dateTime = new Date($scope.dateTime)
            $scope.dateTime.showDate = showDate
            $('#' + $scope.randomId).datetimepicker({
                format: 'yyyy-mm-dd hh:ii:ss'.substr(0, $scope.calendarType.length),
                language: 'zh-CN',
                todayHighlight: !0,
                todayBtn: !0,
                autoclose: !0,
                endDate: $scope.endDate || new Date,
                startDate: $scope.startDate || new Date('1970', '01', '01'),
                ...calendarMap[$scope.calendarType],
                initialDate: $scope.dateTime,
                pickerPosition: "bottom-left"
            }).on('hide', ev => {
                $scope.dateTime = new Date(ev.date.valueOf() - 28800000)
                $scope.dateTime.showDate = $scope.dateTime.Format($scope.calendarType)
                $scope.showArrow && $scope.disabled()
                $scope.$apply()
            })
            $scope.showArrow && $scope.disabled()
        })
        $timeout(() => $scope.mounted && $scope.mounted($scope, $element), 0)
    },
    controller($scope, $element) {
        $scope.beforeCreate && $scope.beforeCreate($scope, $element)
        if ($scope.week) $scope.calendarType = 'yyyy-MM-dd'
        if ($scope.calendarType.length > 10) $scope.showArrow = false
        if (Object.is(void 0, $scope.dateTime.showDate)) $scope.dateTime.showDate = $scope.dateTime.Format($scope.calendarType)
        let showDate = $scope.dateTime.showDate
        $element.find('input').val(showDate)
        $scope.disabled = (noChange) => {
            const startDate = $scope.startDate || new Date('1970', '01', '01'),
                endDate = $scope.endDate || new Date,
                startDisabled = $scope.week ? (+moment($scope.dateTime).add(-$scope.dateTime.getDay() + 1, 'd')._d <= +startDate) : (+moment([$scope.dateTime.getFullYear(), $scope.dateTime.getMonth(), $scope.dateTime.getDate()].slice(0, $scope.calendarType.split('-').length))._d <= +moment([startDate.getFullYear(), startDate.getMonth(), startDate.getDate()].slice(0, $scope.calendarType.split('-').length))._d),
                nextDisabled = $scope.week ? (+moment($scope.dateTime).add(7 - $scope.dateTime.getDay(), 'd')._d >= +endDate) : (+$scope.dateTime >= +moment([endDate.getFullYear(), endDate.getMonth(), endDate.getDate()].slice(0, $scope.calendarType.split('-').length))._d)
            let num
            if (startDisabled) {
                if (noChange) num = -1
                else $element.find('.fa-angle-left').parent().addClass('disabled')
            } else if (!noChange) $element.find('.fa-angle-left').parent().removeClass('disabled')
            if (nextDisabled) {
                if (noChange) num = Object.is(num, -1) ? 0 : 1
                else $element.find('.fa-angle-right').parent().addClass('disabled')
            } else if (!noChange) $element.find('.fa-angle-right').parent().removeClass('disabled')
            return num
        }
        let changeCount = 0
        $scope.$watch('dateTime', (newValue, oldValue) => {
            if (Object.is(+oldValue, +newValue) && !Object.is(1, ++changeCount)) return
            $scope.beforeUpdate && $scope.beforeUpdate($scope, $element)
            if ($scope.week && window.moment) {
                if (+newValue > +($scope.endDate || new Date)) $scope.dateTime = oldValue
                $scope.showArrow && showDate && $scope.disabled()
                const weekNum = moment($scope.dateTime).day() || 7
                $scope.weekStart = moment($scope.dateTime).add(-weekNum + 1, 'd').format('YYYY-MM-DD')
                const weekEndDate = moment($scope.dateTime).add(6 - weekNum + 1, 'd')._d
                $scope.weekEnd = (+weekEndDate > +($scope.endDate || new Date) ? ($scope.endDate || new Date) : weekEndDate).Format('yyyy-MM-dd')
            }
            showDate = $element.find('input').val() && $scope.dateTime.Format($scope.calendarType)
            $element.find('input').val(showDate)
            $scope.dateTime.showDate = showDate
            $scope.updated && $scope.updated($scope, $element)
        })
        $scope.$watch('startDate', (newValue, oldValue) => {
            if (!Object.is(+newValue, +oldValue)) $('#' + $scope.randomId).datetimepicker('setStartDate', newValue.Format($scope.calendarType))
        })
        $scope.$watch('endDate', (newValue, oldValue) => {
            if (!Object.is(+newValue, +oldValue)) $('#' + $scope.randomId).datetimepicker('setEndDate', newValue.Format($scope.calendarType))
        })
        $scope.changeDateTime = async num => {
            if ([num, 0].includes($scope.disabled(!0))) return
            if ($scope.week) num *= Object.is($scope.dateTime.getDay(), 0) ? 1 : 8 - $scope.dateTime.getDay()
            $scope.dateTime = moment($scope.dateTime).add(num, $scope.calendarType.substr(-1, 1))._d
            await myAjaxData.timeout(0)
            $scope.disabled()
        }
        $element.on('$destroy', async () => {
            $scope.beforeDestroy && $scope.beforeDestroy($scope, $element)
            await myAjaxData.timeout(0)
            $scope.destroyed && $scope.destroyed($scope, $element)
        })
        $scope.created && $scope.created($scope, $element)
    }
})])



/**
 * echarts 图   柱状图   
 */
app.directive('commonChartBar', ['myAjaxData', (myAjaxData) => ({
    restrict: 'E',
    scope: {
        width: '=',
        height: '=',
        xName: '=',
        yName: '=',
        y: '=',
        data: '=',
        colors: '=',
    },

    link($scope, $element, $attrs) {
        const setWidthHeight = () => {
            $($element).height($scope.height)
        }
        let myChart
        setTimeout(() => {
            setWidthHeight()
            myChart = echarts.init($element[0])
            window.addEventListener('resize', resizeFun)
            $scope.$watch('data', (newValue, oldValue) => {
                if (!newValue) return
                if (Object.is(newValue, oldValue)) return
                const option = {
                    tooltip: {},
                    grid: {
                        top: '60',
                        left: '20',
                        right: '60',
                        bottom: '20',
                        containLabel: true
                    },
                    xAxis: {
                        name: $scope.xName || '',
                        type: 'value',
                        splitNumber: 3,
                        axisLine: {
                            lineStyle: {
                                color: '#999'
                            }
                        },
                        axisTick: {
                            show: false
                        }
                    },
                    yAxis: {
                        name: $scope.yName,
                        type: 'category',
                        axisLine: {
                            lineStyle: {
                                color: '#999'
                            }
                        },
                        axisTick: {
                            show: false
                        },
                        data: $scope.y
                    },
                    series: [
                        {
                            type: 'bar',
                            barWidth: '15',
                            label: {
                                normal: {
                                    show: true,
                                    position: 'right',
                                    textStyle: {
                                        color: $scope.colors[$scope.colors.length - 1]
                                    }
                                },
                            },
                            data: $scope.data.reverse().map((value, i, arr) => ({
                                value,
                                itemStyle: {
                                    normal: {
                                        color: $scope.colors[(value / Math.max(...arr) * ($scope.colors.length - 1)).toFixed()],
                                    }
                                }
                            }))
                        },
                    ]
                }
                myChart.setOption(option)
            })
        }, 0);
        const resizeFun = async () => {
            await myAjaxData.timeout(0)
            setWidthHeight()
            myChart.resize()
        }
        $scope.$on('$destroy', () => {
            window.removeEventListener('resize', resizeFun)
            myChart.dispose()
            myChart = null
        })
    }
})])
/**
 * 公共图表  曲线图
 */
app.directive('commonChartLine', ['myAjaxData', '$timeout', (myAjaxData, $timeout) => ({
    restrict: 'E',
    scope: {
        width: '=',
        height: '=',
        ynames: '=',
        linenames: '=',
        xdata: '=',
        ydatas: '=',
        colors: '=',
        backgroundColor: '=',
        datazoom: '='
    },
    link($scope, $element) {
        let myChart;
        $timeout(() => {
            $element.css('display', 'block')
            setWidthHeight();
            myChart = echarts.init($element[0]);
            $scope.$watch('xdata', (newValue, oldValue) => {
                if (!Array.isArray(newValue)) return;
                drawing();
            });
        }, 0);

        const drawing = () => {
            const { backgroundColor, linenames, ynames, xdata, ydatas, colors, datazoom } = $scope;

            const option = {
                backgroundColor,
                tooltip: {
                    trigger: 'axis', //触发类型。[ default: 'item' ] :数据项图形触发，主要在散点图，饼图等无类目轴的图表中使用;'axis'坐标轴触发，主要在柱状图，折线图等会使用类目轴的图表中使用
                    axisPointer: {
                        lineStyle: {
                            color: '#57617B'
                        }
                    }
                },
                legend: {
                    icon: 'rect',
                    itemWidth: 20,
                    itemHeight: 4,
                    itemGap: 20, //图例每项之间的间隔。横向布局时为水平间隔，纵向布局时为纵向间隔。[ default: 10 ] 
                    data: linenames.reduce((a, b) => a.concat(b), []),
                    right: 100,
                    top: 30,
                    textStyle: {
                        fontSize: 12,
                        color: '#666'
                    }
                },
                grid: {
                    top: '60',
                    left: '20',
                    right: '20',
                    bottom: '19',
                    containLabel: true //grid 区域是否包含坐标轴的刻度标签[ default: false ] 
                },
                xAxis: [{
                    type: 'category',
                    boundaryGap: false, //坐标轴两边留白策略，类目轴和非类目轴的设置和表现不一样
                    axisLine: {
                        lineStyle: {
                            color: '#393a34' //坐标轴线线的颜色。
                        }
                    },
                    axisLabel: {
                        textStyle: {
                            color: '#747474'
                        }
                    },
                    axisTick: {
                        inside: true
                    },
                    data: xdata
                }],
                yAxis: ynames.map(name => ({
                    type: 'value',
                    name,
                    nameTextStyle: {
                        color: '#a4a4a4'
                    },
                    axisTick: {
                        show: false //是否显示坐标轴刻度
                    },
                    axisLine: {
                        lineStyle: {
                            color: '#393a34' //坐标轴线线的颜色
                        }
                    },
                    axisLabel: {
                        margin: 5, //刻度标签与轴线之间的距离
                        // inside: true,
                        textStyle: {
                            color: '#747474',
                            fontSize: 12 //文字的字体大小
                        }
                    },
                    splitLine: {
                        lineStyle: {
                            color: '#393a34', //分隔线颜色设置
                            type: 'dashed'
                        }
                    }
                })),
                dataZoom: datazoom && [{
                    type: 'slider',
                    xAxisIndex: 0,
                    filterMode: 'empty'
                }],
                series: ydatas.map((v, i) => {
                    return v.map((data, xi) => ({
                        name: linenames[i][xi],
                        type: 'line',
                        yAxisIndex: i,
                        smooth: true,
                        showSymbol: false,
                        data: data.map(v => {
                            if (!Number.isNaN(v + '' - 0)) return (+v).toFixed(1) - 0;
                            return v === null ? '-' : v;
                        }),
                        itemStyle: {
                            normal: {
                                color: colors[i][xi],
                                borderColor: colors[i][xi],
                                borderWidth: 12
                            }
                        },
                    }))
                }).reduce((a, b) => a.concat(b), [])
            };
            myChart.setOption(option);
        };

        // 设置宽高
        const setWidthHeight = () => $element.width($scope.width).height($scope.height);

        // 宽高改变  重新画
        const resizeFunc = async () => {
            await myAjaxData.timeout(0);
            setWidthHeight();
            myChart.resize();
            drawing();
        };
        window.addEventListener('resize', resizeFunc);
        $scope.$on('$destroy', () => {
            window.removeEventListener('resize', resizeFunc);
            myChart.dispose();
            myChart = null;
        });
    }
})]);

app.directive('commonChartPie', ['myAjaxData', '$ocLazyLoad', (myAjaxData, $ocLazyLoad) => ({
    restrict: 'E',
    scope: {
        width: '=',
        height: '=',
        detail: '=',
        chartName: '@',
        chartData: '=',
        colors: '='
    },
    link($scope, $element, $attrs) {
        const setWidthHeight = () => {
            $($element).height($scope.height)
        }
        let myChart
        setTimeout(() => {
            setWidthHeight()
            myChart = echarts.init($element[0])
            window.addEventListener('resize', resizeFun)
            $scope.$watch('chartData', (newValue, oldValue) => {
                if (!newValue) return
                if (Object.is(newValue, oldValue)) return
                const option = {
                    tooltip: {
                        trigger: 'item',
                        formatter: "{a} <br/>{b} : {c} ({d}%)"
                    },
                    series: [{
                        name: $scope.chartName,
                        center: ['50%', '50%'],
                        radius: ['45%', '70%'],
                        type: 'pie',
                        data: $scope.chartData.names.map((v, i) => ({
                            name: v,
                            value: $scope.chartData.values[i],
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
                                    color: $scope.colors[i]
                                },
                            },
                            hoverAnimation: false
                        }))
                    }]
                }
                myChart.setOption(option)
            })
        }, 0);
        const resizeFun = async () => {
            await myAjaxData.timeout(0)
            setWidthHeight()
            myChart.resize()
        }
        $scope.$on('$destroy', () => {
            window.removeEventListener('resize', resizeFun)
            myChart.dispose()
            myChart = null
        })
    }
})])

app.directive('amoutLimit', ['myAjaxData', '$ocLazyLoad', (myAjaxData, $ocLazyLoad) => ({
    restrict: 'A',
    scope: {
    },
    link($scope, $element, $attrs) {
        $element.attr("data-maxAmout",500)
    }
})])

/**
 * 增删改查 模板
 */
app.directive('editForm', ['myAjaxData', myAjaxData => ({
    restrict: 'E',
    templateUrl: window.baseUrl + '/tpl/publicComponent/editForm.html',
    replace: !0,
    transclude: !0,
    scope: !1,
})])
/**
 * 元素复制
 */
app.directive('copyEle', ['$timeout', $timeout => ({
    restrict: 'A',
    scope: !1,
    link($scope, $element) {
        $timeout(() => {
            $element.after(`
            <div class="clearfix">
                <a class="pull-right copy-ele">
                    <span style="width: 26px; height: 26px; text-align: center; color: white; font-size: 29px; border-radius: 50%; background: #1cb09a; display: inline-block; line-height: 26px; margin-right: 10px;" class="add-input-icon">+</span>
                    <span style="    color: #1cb09a; line-height: 26px; height: 26px; display: inline-block; vertical-align: super;" class="add-input-tip">添加</span>
                </a>
            </div>`)
            const copyFunc = function () {
                $(this).parent().before($element[0].outerHTML)
            }
            $element.next().find('a.copy-ele').on('click', copyFunc)
            $scope.$on('$destroy', () => $element.next().find('a.copy-ele').off('click', copyFunc))
        }, 0)
    }
})])
