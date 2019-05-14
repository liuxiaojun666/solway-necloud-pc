ajaxData({
// 获取指标
HighAnalysis_selectFds: {
    name: 'GETHighAnalysis_selectFds',
    data: {},
    later: true
},
}, {
    __serviceName__: 'analysService'
})('analysIndexCtrl', ['$scope', 'analysService', 'actionRecord', '$timeout', 'toaster', 'myAjaxData'], ($scope, _myAjaxData, historicalRecord, $timeout, toaster, parentmyAjaxData) => {

    //获取分析类型 发送的anlsType
    // $scope.$on('anlsType', (item, v) => {
    //     $scope.anlsType = v;
    // })

    //对标分析-> 获取分析对象 发送的dmsType
    $scope.$on('bench_dmsType', () => {
        $scope.dmsType = parentmyAjaxData.config.dmsType;
        $scope.anlsType = parentmyAjaxData.config.anlsType;
        //对标分析-> 获取分析指标的数据
        $scope.HighAnalysis_selectFds.getData({
            stationClass: "01",
            anlsType: parentmyAjaxData.config.anlsType,
            dmsType: parentmyAjaxData.config.dmsType
        })
    })
    
    //趋势分析-> 获取时间纬度 发送的dmsTime
    $scope.$on('trend_dmsTime', (item, v) => {
        $scope.dmsTime = v;
        //趋势分析-> 获取分析指标的数据
        $scope.HighAnalysis_selectFds.getData({
            stationClass: "01",
            anlsType: parentmyAjaxData.config.anlsType,
            dmsType: parentmyAjaxData.config.dmsType,
            dmsTime: $scope.dmsTime
        })
    })

    $scope.HighAnalysis_selectFds.subscribe(res => {
        if (!res.body) {
            toaster.pop('error', '', res.msg);
            return;
        }
        $scope.analysData = res.body;
        var key;
        for(key in $scope.analysData){
            $scope.analysData[key].ll.map((item)=>{
                item.actFdTb = 0;
                item.actFdHb = 0;
            })
        }
        $scope.analysCheckData = [];
        parentmyAjaxData.config.analysFds = [];
        $scope.radioToSelect($scope.analysData.ctg1, 0);

    });

    //排序 源数据
    $scope.sortArr = [
        {
            'key': 'asc',
            'value': '升序'
        },
        {
            'key': 'desc',
            'value': '降序'
        }
    ]

    //搜索功能
    $scope.getList = () => {
        $scope.analysBottom.map((item) => {
            if (item.fdName.includes($scope.keyWords)) {
                item.show = true;
            } else {
                item.show = false;
            }
        })
    }

    //单选框选中-> 更改select的值
    $scope.radioIndex = 0;
    $scope.radioToSelect = (item, index) => {
        $scope.$emit('radioToFather', { 'type': 'analys', 'value': item.v });
        $scope.analysBottom = item.ll;
        //给数据赋初始show值
        $scope.analysBottom.map((item) => {
            item.show = true;
        })
        $scope.radioIndex = index;
        //处理fdStyle 字段
        fdStyleFun();
    }

    //处理fdStyle 字段
    const fdStyleFun = () => {
        var styleKey = {
            1: '曲线',
            2: '折线',
            3: '柱状图',
            4: '散点'
        }
        $scope.analysBottom.map((item) => {
            var result = item.fdStyle.split(",");
            var newFdStyleCopy = [];
            item.newFdStyle = [];
            result.map((item) => {
                var data = {};
                data.key = item - 0;
                data.value = styleKey[item];
                newFdStyleCopy.push(data);
            })
            item.newFdStyle = newFdStyleCopy;
        })
    }

    $scope.analysCheckData = [];
    // $scope.horizonPoint = [];
    // $scope.horizonKpi = [];

    // const key = {
    //     0: 'horizonPoint',
    //     1: 'horizonKpi'
    // }
    //左侧多选按钮-> 右侧 穿梭
    $scope.shuttle = (item, $index) => {
        //点击一个区域 让另一个区域的选中状态置空
        if ($scope.radioIndex == 0) {
            $scope.analysData.ctg2.ll.map((item) => {
                item.checked = false;
            })
        } else {
            $scope.analysData.ctg1.ll.map((item) => {
                item.checked = false;
            })
        }
        //实现单选 和 重复点击取消选中
        if (!item.checked) {
            item.checked = false;
        } else {
            $scope.analysBottom.map((item) => {
                item.checked = false;
            })
            item.checked = true;
        }

        //获取选中的数据
        var filterBottom = $scope.analysBottom.filter(item => item.checked);
        if (filterBottom.length > 0) {
            filterBottom.map((item) => {
                if ($scope.analysCheckData.indexOf(item) == '-1') {
                    $scope.analysCheckData = [];
                    $scope.analysCheckData.push(item);
                }
            })
        } else {
            $scope.analysCheckData = [];
        }

        //获取同比 环比
        $scope.actFdTb = item.actFdTb;
        $scope.actFdHb = item.actFdHb;
    }

    //右侧删除小按钮
    $scope.delRight = (fdKey, index) => {
        $scope.analysData.ctg1.ll.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
            }
        })
        $scope.analysData.ctg2.ll.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
            }
        })
        $scope.analysBottom.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
            }
        })
        $scope.analysCheckData.splice(index, 1);
    }

    //全部删除
    $scope.delRightAll = () => {
        if ($scope.analysCheckData.length == 0) {
            toaster.pop('error', '', '请至少选择一条');
        } else {
            $solway.confirm({ message: '确定全部删除吗？' }, () => {
                $scope.analysCheckData = [];
                $scope.analysData.ctg1.ll.forEach((item) => {
                    item.checked = false;
                })
                $scope.analysData.ctg2.ll.forEach((item) => {
                    item.checked = false;
                })
                $scope.analysBottom.forEach((item) => {
                    item.checked = false;
                })
                $scope.$apply();
            });
        }
    }

    //点击同比 环比
    $scope.tongBi = (v, type) => {
        if (type == 'tong') {
            $scope.analysBottom.map((item) => {
                if (item.fdKey == v.fdKey) {
                    item.actFdTb == 0 ? item.actFdTb = 1 : item.actFdTb = 0;
                    if (v.checked) {
                        $scope.actFdTb = item.actFdTb;
                    }
                }
            })
        } else {
            $scope.analysBottom.map((item) => {
                if (item.fdKey == v.fdKey) {
                    item.actFdHb == 0 ? item.actFdHb = 1 : item.actFdHb = 0;
                    if (v.checked) {
                        $scope.actFdHb = item.actFdHb;
                    }
                }
            })
        }
    }

    //取消
    $scope.cancel = () => {
        $scope.$emit('cancelCallback');
    }

    // 获取select 图表类型 (曲线、柱状图)
    $scope.query = {
        'tableType': 1,
        'sortType': 'asc'
    }
    
    //确定
    $scope.actFdTb = 0;
    $scope.actFdHb = 0;
    $scope.confirm = () => {
        if ($scope.analysCheckData.length == 0) {
            toaster.pop('error', '', '所选数据不能为空');
            return;
        }
        var analysFds_y1 = {
            fdKey: $scope.analysCheckData[0].fdKey,
            fdTb: $scope.actFdTb,
            fdHb: $scope.actFdHb
        }
        parentmyAjaxData.config.benchSort = parentmyAjaxData.config.anlsType==3 ? $scope.analysCheckData[0].fdKey + ',' + $scope.query.sortType : null;
        parentmyAjaxData.config.analysFds[0] = analysFds_y1;
        parentmyAjaxData.config.fdStyle = $scope.query.tableType;
        $scope.$emit('analysFds_fdName',{'fdName': $scope.analysCheckData[0].fdName});
        $scope.$emit('addCallback');
    }
});