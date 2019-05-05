ajaxData({
    AddbaseDictionary: {
        name: 'AddbaseDictionary',
        data: {},
        later: true
    }
}, {
        __serviceName__: 'countTimeService'
    })('countTimeCtrl', ['$scope', 'countTimeService', 'actionRecord', '$timeout', 'toaster', 'myAjaxData'], ($scope, _myAjaxData, historicalRecord, $timeout, toaster, parentmyAjaxData) => {

        //获取父级发送的横轴指标 选择的option
        $scope.$on('countTimeNum', (item, index) => {
            $scope.selectIndex = index;
            $scope.radioIndex = index;
        })

        //重新设置 日历切换的按钮
        var btnFunction = () => {
            //日 下一个按钮
            $scope.nextD = () => {
                setTimeout(() => {
                    $('#cander1 .laydate-icon.laydate-next-m').click();
                }, 0)
            }

            //日 上一个按钮
            $scope.preD = () => {
                setTimeout(() => {
                    $('#cander1 .laydate-icon.laydate-prev-m').click();
                }, 0)
            }

            //月 下一个按钮
            $scope.nextM = () => {
                setTimeout(() => {
                    $('#cander2 .laydate-icon.laydate-next-y').click();
                }, 0)
            }

            //月 上一个按钮
            $scope.preM = () => {
                setTimeout(() => {
                    $('#cander2 .laydate-icon.laydate-prev-y').click();
                }, 0)
            }

            //月 下一个按钮
            $scope.nextY = () => {
                setTimeout(() => {
                    $('#cander3 .laydate-icon.laydate-next-y').click();
                }, 0)
            }

            //月 上一个按钮
            $scope.preY = () => {
                setTimeout(() => {
                    $('#cander3 .laydate-icon.laydate-prev-y').click();
                }, 0)
            }
        }
        btnFunction();

        // layui日历
        var myDate = new Date();
        var maxYear = myDate.getFullYear();
        var Month = myDate.getMonth() + 1;
        var maxMonth = maxYear + '-' + Month;
        var maxDay = maxMonth + '-' + myDate.getDate();

        //日
        laydate.render({
            elem: '#cander1', //指定元素
            position: 'static',
            showBottom: true,
            btns: ['now'],
            theme: '#245182',
            max: maxDay.toString(),
            ready(date) {
                $('#layui-laydate1 .laydate-btns-now').html('今日');
            },
            done: function (value, date) {
                if ($scope[key[$scope.radioIndex]].indexOf(value) == '-1') {
                    $scope[key[$scope.radioIndex]].push(value);
                }
                $scope.$apply();
            }
        });

        //月
        laydate.render({
            elem: '#cander2', //指定元素
            position: 'static',
            showBottom: true,
            btns: ['now', 'confirm'],
            type: 'month',
            theme: '#245182',
            max: maxMonth.toString(),
            ready(date) {
                $('#layui-laydate2 .laydate-btns-now').html('本月');
                $('#layui-laydate2').on('click', 'ul.layui-laydate-list.laydate-month-list li', () => {
                    setTimeout(() => {
                        $('#layui-laydate2 .laydate-btns-confirm').click();
                    }, 0)
                })
            },
            done: function (value, date) {
                if ($scope[key[$scope.radioIndex]].indexOf(value) == '-1') {
                    $scope[key[$scope.radioIndex]].push(value);
                }
                $scope.$apply();
            }
        });

        //年
        laydate.render({
            elem: '#cander3', //指定元素
            position: 'static',
            showBottom: true,
            btns: ['now', 'confirm'],
            type: 'year',
            theme: '#245182',
            max: maxYear.toString(),
            ready(date) {
                $('#layui-laydate3 .laydate-btns-now').html('今年');
                $('#layui-laydate3').on('click', 'ul.layui-laydate-list.laydate-year-list li', () => {
                    setTimeout(() => {
                        $('#layui-laydate3 .laydate-btns-confirm').click();
                    }, 0)
                })
            },
            done: function (value, date) {
                if ($scope[key[$scope.radioIndex]].indexOf(value) == '-1') {
                    $scope[key[$scope.radioIndex]].push(value);
                }
                $scope.$apply();
            }
        });

        //单选框选中-> 更改select的值
        $scope.selectIndex = 1;
        $scope.radioToSelect = (name, dateType) => {
            var radioIndex = document.querySelectorAll('[name=cTime]'):: [].filter(item => item.checked).map(item => item.dataset.index);
            $scope.$emit('radioToFather', { 'name': name, 'type': 'countTime', 'dateType': dateType });
            $scope.radioIndex = radioIndex.length > 0 ? radioIndex[0] : 1;
        }
        $scope.radioToSelect('日', 3);

        $scope.timeGroupDay = [];
        $scope.timeGroupMonth = [];
        $scope.timeGroupYear = [];
        $scope.timeGroupUser = [];
        $scope.GroupUser = {
            date: new Date,
            startDate: new Date,
            endDate: new Date
        }

        //确定按钮
        var arr = [];
        $scope.oneAdd = () => {
            //页面显示用的json
            var groupJson = {
                startDate: $scope.GroupUser.startDate.showDate,
                endDate: $scope.GroupUser.endDate.showDate
            }
            // 未去重的数据
            $scope.timeGroupUser.push(groupJson);
            // 数组格式转换 (后台要的数据格式)
            var i = `${groupJson.startDate},${groupJson.endDate}`;
            arr.push(i);
            // 数组去重
            $scope.newtimeGroupUser = [...new Set(arr)];
            //整理 显示到页面的数据格式
            $scope.timeGroupUser = [];
            $scope.newtimeGroupUser.map((item) => {
                var m = item.split(",");
                $scope.timeGroupUser.push({ 'startDate': m[0], 'endDate': m[1] });
            })
        }

        const key = {
            1: 'timeGroupDay',
            2: 'timeGroupMonth',
            3: 'timeGroupYear',
            4: 'timeGroupUser',
        }

        //右侧删除小按钮
        $scope.delRight = (id, index) => {
            $scope[key[$scope.radioIndex]].splice(index, 1);
            if ($scope[key[$scope.radioIndex]].length == 0) {
                parentmyAjaxData.config.dmsTimeDates = [];
            }
        }

        //全部删除
        $scope.delRightAll = () => {
            if ($scope[key[$scope.radioIndex]].length == 0) {
                toaster.pop('error', '', '请至少选择一条');
            } else {
                $solway.confirm({ message: '确定全部删除吗？' }, () => {
                    $scope[key[$scope.radioIndex]] = [];
                    parentmyAjaxData.config.dmsTimeDates = [];
                    $scope.$apply();
                });
            }
        }

        //取消
        $scope.cancel = () => {
            $scope.$emit('cancelCallback');
        }

        //确定
        $scope.confirm = () => {
            if ($scope[key[$scope.radioIndex]].length == 0) {
                toaster.pop('error', '', '所选数据不能为空');
                return;
            }
            if ($scope.radioIndex == 4) {
                parentmyAjaxData.config.dmsTimeDates = $scope.newtimeGroupUser;
            } else {
                parentmyAjaxData.config.dmsTimeDates = $scope[key[$scope.radioIndex]];
            }
            $scope.$emit('addCallback');
        }
    });