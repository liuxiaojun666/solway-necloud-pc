ajaxData({
AddbaseDictionary: {
    name: 'AddbaseDictionary',
    data: {},
    later: true
},
// 获取指标
HighAnalysis_selectFds: {
    name: 'GETHighAnalysis_selectFds',
    data: {},
    later: true
},
}, {
    __serviceName__: 'horizonService'
})('horizonIndexCtrl', ['$scope', 'horizonService', 'actionRecord', '$timeout', 'toaster', 'myAjaxData'], ($scope, _myAjaxData, historicalRecord, $timeout, toaster, parentmyAjaxData) => {

    //获取分析类型 发送的anlsType
    $scope.$on('anlsType', (item, v) => {
        $scope.anlsType = v;
    })
    //获取分析对象 发送的dmsType
    $scope.$on('dmsType', () => {
        $scope.dmsType = parentmyAjaxData.config.dmsType;
    })
    //获取时间纬度 发送的dmsTime
    $scope.$on('dmsTime', (item, v) => {
        $scope.dmsTime = v;
        $scope.HighAnalysis_selectFds.getData({
            stationClass: "01",
            anlsType: $scope.anlsType,
            dmsType: $scope.dmsType,
            dmsTime: $scope.dmsTime
        })
    })

    $scope.HighAnalysis_selectFds.subscribe(res => {
        $scope.herizonData = res.body;
        if (!res.body) {
            toaster.pop('error', '', res.msg);
            return;
        }
        $scope.radioToSelect($scope.herizonData.ctg1, 0);

    });

    //搜索功能
    $scope.getList = () => {
        $scope.herizonBottom.map((item) => {
            if (item.fdName.includes($scope.keyWords)) {
                item.show = true;
            } else {
                item.show = false;
            }
        })
    }

    //单选框选中-> 更改select的值
    $scope.radioToSelect = (item, index) => {
        $scope.$emit('radioToFather', { 'type': 'horizon', 'k': item.k, 'value': item.v });
        $scope.herizonBottom = item.ll;
        //给数据赋初始show值
        $scope.herizonBottom.map((item) => {
            item.show = true;
        })
        $scope.radioIndex = index;
        //处理fdStyle 字段
        fdStyleFun();
        //往纵轴指标发送数据
        parentmyAjaxData.config.herizonData = $scope.herizonData;
    }

    //处理fdStyle 字段
    const fdStyleFun = () => {
        var styleKey = {
            1: '曲线',
            2: '折线',
            3: '柱状图',
            4: '散点'
        }
        $scope.herizonBottom.map((item) => {
            var result = item.fdStyle.split(",");
            var newFdStyleCopy = [];
            item.newFdStyle = [];
            result.map((item) => {
                var data = {};
                data.key = item;
                data.value = styleKey[item];
                newFdStyleCopy.push(data);
            })
            item.newFdStyle = newFdStyleCopy;
        })
    }

    $scope.horizonCheckData = [];
    // $scope.horizonPoint = [];
    // $scope.horizonKpi = [];

    const key = {
        0: 'horizonPoint',
        1: 'horizonKpi'
    }

    //左侧多选按钮-> 右侧 穿梭
    $scope.shuttle = (item, $index) => {
        //点击一个区域 让另一个区域的选中状态置空
        if ($scope.radioIndex == 0) {
            $scope.herizonData.ctg2.ll.map((item) => {
                item.checked = false;
            })
        } else {
            $scope.herizonData.ctg1.ll.map((item) => {
                item.checked = false;
            })
        }
        //实现单选 和 重复点击取消选中
        if (!item.checked) {
            item.checked = false;
        } else {
            $scope.herizonBottom.map((item) => {
                item.checked = false;
            })
            item.checked = true;
        }

        //获取选中的数据
        var filterBottom = $scope.herizonBottom.filter(item => item.checked && !item.checkedV);
        if (filterBottom.length > 0) {
            filterBottom.map((item) => {
                item.checkedH = item.checked;
                if ($scope.horizonCheckData.indexOf(item) == '-1') {
                    $scope.horizonCheckData = [];
                    $scope.horizonCheckData.push(item);
                }
            })
        } else {
            $scope.horizonCheckData = [];
        }

    }

    //右侧删除小按钮
    $scope.delRight = (fdKey, index) => {
        $scope.herizonData.ctg1.ll.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
            }
        })
        $scope.herizonData.ctg2.ll.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
            }
        })
        $scope.herizonBottom.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
            }
        })
        $scope.horizonCheckData.splice(index, 1);
    }

    //全部删除
    $scope.delRightAll = () => {
        if ($scope.horizonCheckData.length == 0) {
            toaster.pop('error', '', '请至少选择一条');
        } else {
            $solway.confirm({ message: '确定全部删除吗？' }, () => {
                $scope.horizonCheckData = [];
                $scope.herizonData.ctg1.ll.forEach((item) => {
                    item.checked = false;
                })
                $scope.herizonData.ctg2.ll.forEach((item) => {
                    item.checked = false;
                })
                // $scope.herizonBottom.forEach((item) => {
                //     item.checked = false;
                // })
                $scope.$apply();
            });
        }
    }

    //点击同比 环比
    $scope.tongBi = (fdKey, type) => {
        if (type == 'tong') {
            $scope.herizonBottom.map((item) => {
                if (item.fdKey == fdKey) {
                    item.fdTb == 0 ? item.fdTb = 1 : item.fdTb = 0;
                }
            })
        } else {
            $scope.herizonBottom.map((item) => {
                if (item.fdKey == fdKey) {
                    item.fdHb == 0 ? item.fdHb = 1 : item.fdHb = 0;
                }
            })
        }
    }

    //取消
    $scope.cancel = () => {
        $scope.$emit('cancelCallback');
        if ($scope.horizonCheckData.length == 0) {
            parentmyAjaxData.config.fdX.key = '';
            parentmyAjaxData.config.fdX.name = '';
        }
    }

    //确定
    $scope.confirm = () => {
        if ($scope.horizonCheckData.length == 0) {
            toaster.pop('error', '', '所选数据不能为空');
            return;
        }
        parentmyAjaxData.config.fdX.key = $scope.horizonCheckData[0].fdKey;
        parentmyAjaxData.config.fdX.name = $scope.horizonCheckData[0].fdName;
        $scope.$emit('addCallback');
    }
});