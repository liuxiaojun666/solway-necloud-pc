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
            // $scope.getHerizonData();
        })

        //获取横轴指标的数据
        $scope.HighAnalysis_selectFds.getData({
            stationClass: "01",
            anlsType: $scope.anlsType,
            dmsType: $scope.dmsType,
            dmsTime: $scope.dmsTime
        })

        $scope.HighAnalysis_selectFds.subscribe(res => {
            $scope.herizonData = res.body;
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
        $scope.radioIndex = 0;
        $scope.radioToSelect = (item, index) => {
            $scope.$emit('radioToFather', { 'type': 'analys', 'value': item.v });
            $scope.herizonBottom = item.ll;
            //给数据赋初始show值
            $scope.herizonBottom.map((item) => {
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


        $scope.horizonPoint = [];
        $scope.horizonKpi = [];

        const key = {
            0: 'horizonPoint',
            1: 'horizonKpi'
        }
        //左侧多选按钮-> 右侧 穿梭
        $scope.shuttle = () => {
            $scope[key[$scope.radioIndex]] = [];
            $scope.herizonBottom.filter(item => item.checked && !item.checkedV).map((item, index) => {
                item.checkedH = item.checked;
                if ($scope[key[$scope.radioIndex]].indexOf(item) == '-1') {
                    $scope[key[$scope.radioIndex]].push(item);
                }
            })
        }

        //右侧删除小按钮
        $scope.delRight = (fdKey, index) => {
            $scope.herizonBottom.forEach((item) => {
                if (item.fdKey == fdKey) {
                    item.checked = false;
                }
            })
            $scope[key[$scope.radioIndex]].splice(index, 1);
        }

        //全部删除
        $scope.delRightAll = () => {
            if ($scope[key[$scope.radioIndex]].length == 0) {
                toaster.pop('error', '', '请至少选择一条');
            } else {
                $solway.confirm({ message: '确定全部删除吗？' }, () => {
                    $scope[key[$scope.radioIndex]] = [];
                    $scope.herizonBottom.forEach((item) => {
                        item.checked = false;
                    })
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
        }

        //确定
        $scope.confirm = () => {
            $scope.$emit('addCallback');
        }
    });