app.directive('elDetails', ['myAjaxData', '$ocLazyLoad', (myAjaxData, $ocLazyLoad) => ({
    restrict: 'E',
    template: $('#el-details').html(),
    scope: {
        detail: '='
    },
    link($scope, $element) {

    }
})])


app.directive('elChart', ['myAjaxData', '$ocLazyLoad', (myAjaxData, $ocLazyLoad) => ({
    restrict: 'E',
    scope: {
        detail: '=',
        name: '='
    },
    link($scope, $element, $attrs) {
        const myChart = echarts.init($element[0])
        const renderChart = () => {
            const option = {
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [{
                    name: '损失电量构成',
                    center: ['50%', '50%'],
                    radius: ['25%', '50%'],
                    type: 'pie',
                    data: [30, 50, 34, 6, 34, 74, 23, 26, 4].slice(0, myAjaxData.config[$scope.name].length).map((v, i) => ({
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
                            },
                        },
                        hoverAnimation: false
                    }))
                }]
            }
            myChart.setOption(option)
        }

        renderChart()
    }
})])

ajaxData({
    // 专家库列表
    pageList: {
        name: 'GETExpertLibrary',
        data: {
            powerType: 'PV',
            idType: 1,
            pageIndex: 0,
            pageSize: 10
        }
    },
    detail: {
        name: 'aaa',
        later: true
    },

    // 集团 省份
    province: {
        name: 'POSTSelectProvince',
        data: {
            parentId: 1,
            treeLevel: 1
        }
    },
    // 品牌列表接口  powerType = PV | WP
    selectBypowerType: {
        name: 'GETselectBypowerType',
        data: {
            powerType: 'PV'
        }
    },
    // 故障类型列表接口  光伏：dictType传  FAULT_REAL_TYPE  风电：dictType传  WT_SYSTEM
    basedictionarySelectAll: {
        name: 'GETBasedictionarySelectAll',
        data: {
            dictType: 'FAULT_REAL_TYPE'
        }
    },
}, {
        gzName: ['塔筒及基础', '变桨系统', '测风系统', '电控系统', '机械传动系统', '发电机'],
        ppName: ['西门子', '远景', 'GE', '葛美凤', '华创', '金风'],
        xhName: ['jj-1550', 's2000', 'k2000', 'm500'],
    })('expertLibraryCtrl', ['$scope', 'myAjaxData'], ($scope, myAjaxData) => {
        $scope.dateTime1 = new Date((new Date).setDate((new Date).getDate() - 7))
        $scope.dateTime2 = new Date

        $scope.powerType = 'PV'; // 默认光伏
        $scope.idType = 1; // 集团 省份，默认集团
        // $scope.brandIds = []; // 品牌类型
        // $scope.faultTypeIds = []; // 故障类型
        $scope.switchTab = '1'; // 默认选择  品牌  使用品牌查询
        // 所有省份  + 集团
        $scope.province.promise.then(res => $scope.allIds = res.map(v => ({ [v.id]: v.regionName })).reduce((obj, cur) => ({ ...obj, ...cur }), { 1: '集团' }));

        // 查询  搜索
        $scope.conditionSearch = () => {
            const obj = {
                brandIds: null,
                faultTypeIds: null
            };

            $scope.switchTab === '1'
                ? obj.brandIds = [].filter.call(document.getElementsByName('shortType'), v => v.checked).map(v => v.value).join(',')
                : obj.faultTypeIds = [].filter.call(document.getElementsByName('faultType'), v => v.checked).map(v => v.value).join(',')

            $scope.pageList.getData({
                powerType: $scope.powerType,
                idType: $scope.idType,
                ids: $scope.ids,
                ...obj,
                keyword: $scope.keyword,
                pageIndex: 0,
                pageSize: 6
            }).then(() => $scope.keyword = '');
        };


        //切换电站类型
        $scope.changePowerType = async type => {
            $scope.powerType = type;
            $scope.selectBypowerType.res = null;
            $scope.selectBypowerType.getData({ powerType: type });
            $scope.basedictionarySelectAll.res = null;
            await myAjaxData.timeout(0);
            $scope.basedictionarySelectAll.getData({
                dictType: type === 'PV' ? 'FAULT_REAL_TYPE' : 'WT_SYSTEM'
            });
            $scope.conditionSearch();
        };

        // 改变  范围 执行 函数  重新请求 数据 汇总
        $scope.changeIds = value => {
            if (value === $scope.ids) return;
            const isJT = value == 1; // 选择的是否是集团
            $scope.idType = isJT ? 1 : 2;
            $scope.ids = isJT ? null : value;
            $scope.conditionSearch();
        };

        // 弹出框 详情
        $scope.showDetails = (a, e) => $('.el-details').show();
        $(document).on('click.el', () => $('.el-details').hide());
    });