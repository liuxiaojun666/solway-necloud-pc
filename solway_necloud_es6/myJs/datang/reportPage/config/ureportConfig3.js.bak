ajaxData({
    pageList: {
        name: 'GETopReportLaySelectByCom',
        data: {}
    },
}, {})('ureportConfig3Ctrl', ['$scope', 'myAjaxData'], ($scope, myAjaxData) => {
    $scope.hasSwitchPower = false;
    $scope.wapHeader = false;
    
    
    // 列表数据 
    $scope.pageList.getDataCallback = (success, res) => {
        if (!success) return;
        $scope.datasource = res.body;
    };

    $scope.editRequired = [
        '一、此记录由管理员填写。',
    ]

    // 表格  列配置
    const column = [
        {
            title: '报表名称',
            dataIndex: 'layName',
            width: '',
            align: 'left'
        }, {
            title: '是否发送邮件',
            dataIndex: 'mailAble',
            width: '',
            align: 'left',
            render(text) {
                return `<span>${['否','是'][text]}</span>`
            }
        }, {
            title: '发送邮件时间',
            dataIndex: 'mailCron',
            width: '',
            align: 'left'
        }
    ];











    /* ****************************************************************** 下面的不用改 ****************************************************************** */




    // 需要将table表格内  自定义事件（lxj-click）绑定函数挂载到table组件上
    // lxj-click 绑定的函数只接收 字符串参数
    $scope.tableListBeforeCreated = (scope, element) => {
        scope.editFunc = $scope.editFunc
    };
    //编辑当前记录不变代码  不要改
    $scope.editFunc = (id, index) => {
        $scope.isEdit = true;
        $scope.toEdit = true;
        $scope.newRecord = false;
        // editFunc(id, index);
        $scope.$apply();
    };
    $scope.column = [
        ...column,
        {
            title: '操作',
            dataIndex: 'id',
            width: '74px',
            align: 'center',
            render(text, record, index) {
                return `<i style="cursor: pointer;" class="icon-note  font16" lxj-click="editFunc(${text},${index})"></i>`
            }
        },
    ];
})