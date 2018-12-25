ajaxData(
    {
        opWorkTicketList: {
            name: 'GETopWorkTicketList',
            data: {},
            later: true
        },
        // 电站id  查询  电站人员
        selectAllUserBySTID: {
            name: 'GETselectAllUserBySTID',
            data: {},
            later: true,
            onlyLatest: true,
            cache: true
        },
        loginUserInfo: {
            name: 'GETloginUserInfo',
            data: {},
            later: true
        },
        opWorkTicketHandle: {
            name: 'opWorkTicketHandle',
            data: {},
            later: true
        },

    }, {
        __serviceName__: 'chatPanelService'
    }
)('chatPanelCtrl', ['$scope', 'chatPanelService', 'toaster'], ($scope, myAjaxData, toaster) => {

    $scope.$on('chatPanelObj', async (event, obj) => {
        $scope.stid = obj.stationId;
        if (!$scope.loginUserInfo.res) await $scope.loginUserInfo.getData();
        $scope.opWorkTicketList.getData({ workId: obj.id });
    });

    $scope.opWorkTicketList.subscribe(res => {
        $scope.handleId = res.body[res.body.length - 1].id;
    });

    $scope.opWorkTicketHandle.subscribe(res => {

    });

});