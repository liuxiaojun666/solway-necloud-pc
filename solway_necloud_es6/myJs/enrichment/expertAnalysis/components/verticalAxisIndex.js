ajaxData({
AddbaseDictionary: {
    name: 'AddbaseDictionary',
    data: {},
    later: true
}
}, {
    __serviceName__: 'verticalService'
})('verticalIndexCtrl', ['$scope', 'verticalService', 'actionRecord', '$timeout', 'toaster', 'myAjaxData'], ($scope, _myAjaxData, historicalRecord, $timeout, toaster, parentmyAjaxData) => {

    // 监测时间纬度的变化
    $scope.$on('dmsTime', (item, v) => {
        $scope.verticalCheckData = [];
    })

    // 获取纵轴指标的数据
    $scope.$on('verticalData', () => {
        $scope.verticalData = parentmyAjaxData.config.herizonData;
        //获取以前 checked 的数据 -> 重现到左侧列表
        if($scope.verticalCheckData.length > 0){
            var key;
            for(key in $scope.verticalData){
                $scope.verticalData[key].ll.map((son)=>{
                    if(son.fdKey == $scope.verticalCheckData[0].fdKey){
                        son.checked = true;
                    }
                })
            }
        }
        $scope.radioToSelect($scope.verticalData.ctg1, 0);
    })

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
    $scope.radioIndex = 0;
    $scope.radioToSelect = (item, index) => {
        $scope.$emit('radioToFather', { 'type': 'vertical', 'k': item.k, 'value': item.v });
        $scope.verticalBottom = item.ll;
        $scope.radioIndex = index;
    }

    $scope.verticalCheckData = [];
    // $scope.verticalPoint = [];
    // $scope.verticalKpi = [];

    const key = {
        0: 'verticalPoint',
        1: 'verticalKpi'
    }
    //左侧多选按钮-> 右侧 穿梭
    $scope.shuttle = (item, $index) => {
        //点击一个区域 让另一个区域的选中状态置空
        if ($scope.radioIndex == 0) {
            $scope.verticalData.ctg2.ll.map((item) => {
                item.checked = false;
            })
        } else {
            $scope.verticalData.ctg1.ll.map((item) => {
                item.checked = false;
            })
        }
        //实现单选 和 重复点击取消选中
        if (!item.checked) {
            item.checked = false;
            item.checkedV = item.checked;
        } else {
            $scope.verticalBottom.map((item) => {
                item.checked = false;
                item.checkedV = item.checked;
            })
            item.checked = true;
            item.checkedV = item.checked;
        }

        //获取选中的数据
        var filterBottom = $scope.verticalBottom.filter(item => item.checked && !item.checkedH);
        if (filterBottom.length > 0) {
            filterBottom.map((item) => {
                // item.checkedV = item.checked;
                if ($scope.verticalCheckData.indexOf(item) == '-1') {
                    $scope.verticalCheckData = [];
                    $scope.verticalCheckData.push(item);
                }
            })
        } else {
            $scope.verticalCheckData = [];
        }

    }

    //右侧删除小按钮
    $scope.delRight = (fdKey, index) => {
        $scope.verticalData.ctg1.ll.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
                item.checkedV = false;
            }
        })
        $scope.verticalData.ctg2.ll.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
                item.checkedV = false;
            }
        })
        $scope.verticalBottom.forEach((item) => {
            if (item.fdKey == fdKey) {
                item.checked = false;
                item.checkedV = false;
            }
        })
        $scope.verticalCheckData.splice(index, 1);
        parentmyAjaxData.config.fdY.key = '';
        parentmyAjaxData.config.fdY.name = '';
    }

    //全部删除
    $scope.delRightAll = () => {
        if ($scope.verticalCheckData.length == 0) {
            toaster.pop('error', '', '请至少选择一条');
        } else {
            $solway.confirm({ message: '确定全部删除吗？' }, () => {
                $scope.verticalCheckData = [];
                $scope.verticalData.ctg1.ll.forEach((item) => {
                    item.checked = false;
                    item.checkedV = false;
                })
                $scope.verticalData.ctg2.ll.forEach((item) => {
                    item.checked = false;
                    item.checkedV = false;
                })
                $scope.verticalBottom.forEach((item) => {
                    item.checked = false;
                    item.checkedV = false;                    
                })
                parentmyAjaxData.config.fdY.key = '';
                parentmyAjaxData.config.fdY.name = '';
                $scope.$apply();
            });
        }
    }

    //点击同比 环比
    $scope.tongBi = (fdKey, type) => {
        if (type == 'tong') {
            $scope.verticalBottom.map((item) => {
                if (item.fdKey == fdKey) {
                    item.fdTb == 0 ? item.fdTb = 1 : item.fdTb = 0;
                }
            })
        } else {
            $scope.verticalBottom.map((item) => {
                if (item.fdKey == fdKey) {
                    item.fdHb == 0 ? item.fdHb = 1 : item.fdHb = 0;
                }
            })
        }
    }

    //取消
    $scope.cancel = () => {
        $scope.$emit('cancelCallback');
    }

    //确定
    $scope.confirm = () => {
        if ($scope.verticalCheckData.length == 0) {
            toaster.pop('error', '', '所选数据不能为空');
            return;
        }
        parentmyAjaxData.config.fdY.key = $scope.verticalCheckData[0].fdKey;
        parentmyAjaxData.config.fdY.name = $scope.verticalCheckData[0].fdName;
        $scope.$emit('addCallback');
    }
});