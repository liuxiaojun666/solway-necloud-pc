ajaxData({
    
}, {})('dataExportCtrl', ['$scope', 'myAjaxData', 'actionRecord'], ($scope, myAjaxData, historicalRecord) => {
    historicalRecord.init();// 历史记录 初始化
    $scope.beforeLoading = true; // 页面loading
    $scope.moduleName = '数据导出';//当前页面名称；
    $scope.endDate = new Date((+new Date) - 1000 * 60 * 60 * 24); // 日历可选 的截止日期
    historyInitCallback();
    // 当前页面行为记录初始化回调 获取行为记录
    async function historyInitCallback() {
        const historiData = historicalRecord.get();
        const {
            startDate = new Date(Date.now() - 1000 * 60 * 60 * 24),
            endDate = new Date(Date.now() - 1000 * 60 * 60 * 24),
            createDate = new Date(Date.now() - 1000 * 60 * 60 * 24)
        } = historiData;
        $scope.startDate = startDate;
        $scope.endDate = endDate;
        $scope.createDate = createDate;
        $scope.createDate.showDate = '';
        $scope.beforeLoading = false;
        // getTabData();
        await myAjaxData.timeout(0);
        $scope.$apply();
    };

    $scope.column = [
        {
            title: '级别',
            dataIndex: 'a',
            sort: 'true',
            render(text) {
                return '日级'
            }
        },
        {
            title: '电站',
            dataIndex: 'b',
            sort: 'true',
            render(text) {
                return 'hello world'
            }
        },
        {
            title: '类型',
            dataIndex: 'c',
            sort: 'true',
            render(text) {
                return '逆变器'
            }
        },
        {
            title: '时间段',
            dataIndex: 'd',
            align: 'center',
            render(text) {
                return '2018-10-15 至 2018-11-05'
            }
        },
        {
            title: '创建时间',
            dataIndex: 'e',
            align: 'center',
            sort: 'true',
            render(text) {
                return '2018-10-15'
            }
        },
        {
            title: '过期时间',
            dataIndex: 'f',
            sort: 'true',
            align: 'center',
            render(text) {
                return '2018-10-15'
            }
        },
        {
            title: '操作',
            dataIndex: 'h',
            render(text) {
                return '下载'
            }
        },
    ]

});