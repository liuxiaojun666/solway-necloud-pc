ajaxData({
    knowledgeBaseList: {
        name: 'GETknowledgeBaseList',
        data: {},
        later: true,
        onlyLatest: true
    },
    //厂商列表
    manufacturerList: {
        name: 'GETmanufacturerList',
        data: {},
        later: true,
        onlyLatest: true
    },
    //产品型号列表
    selectByManuList: {
        name: 'GETselectByManuList',
        data: {},
        later: true,
        onlyLatest: true
    },
    //设备分类列表
    deviceTypeList: {
        name: 'GETdeviceTypeList',
        data: {},
        later: true,
        onlyLatest: true
    },
}, {
    __serviceName__: 'productInformationKnowledgeService',
})('productInformationKnowledgeCtrl', ['$scope', 'productInformationKnowledgeService', 'actionRecord','$timeout'], ($scope, myAjaxData, historicalRecord,$timeout) => {
    /// 初始化 scope
    $scope.initChildScope($scope, myAjaxData);

    // 主页面初始化完成 回调
    $scope.mainPageInitComplete = async () => {
        // let { tabIndex = 0 } = historicalRecord.get().themeMaintenanceStationMonth || {};
        $('.ng-clock').removeClass('ng-clock');
        $scope.initComplete = true;
        await myAjaxData.timeout(0);
        await $scope.diffGetData();

        $scope.getManufacturerList();
        $scope.getDeviceTypeList();
        initParams();
        // $scope.$apply();
    };


    //获取厂商列表
    $scope.getManufacturerList = ()=>{
        $scope.manufacturerList.getData({
        }).then(res=>{
            $scope.manufacturerList = res;
        });
    }

    //选择某一厂商，获取产品型号列表
    $scope.changemanufacturer = () =>{
		$scope.selectByManuList.getData({
            manufid : $scope.manufacturerId,
        }).then(res=>{
            $scope.productList = res;
        });
    }
    
    //获取设备分类列表
    $scope.getDeviceTypeList = ()=>{
        $scope.deviceTypeList.getData({
        }).then(res=>{
            console.log(res)
            $scope.deviceTypeList = res;
        });
    }

    //设置默认参数
    function initParams(){
        $scope.statusCondition = 1; 
    }


    //取消
    $scope.cancel = () =>{
        $scope.ifShowModel = false;
    }

    //显示查询条件弹框
    $scope.showSearchModel = (e) =>{
        e.stopPropagation();
        $scope.ifShowModel = !$scope.ifShowModel;
    }

    $scope.diffGetData = async() =>{
        if (!$scope.initComplete) return;
        $scope.stationMonthLoading = true;
        await myAjaxData.timeout(0);

        $scope.knowledgeBaseList.getData({
            //公共
            pageIndex: 0,
            pageSize : 9,
            queryType : 'proInfo',
            // sortField : sortField,
            // ascOrDesc : ascOrDesc,
            searchFieldType : searchFieldType,
            searchContent : $scope.searchContent,
            manuFId : $scope.manufacturerId,
            productId : $scope.productId,
            // //产品资料
            // repclass : $scope.repclass,
            // //故障指导，历史检修
            // devicetype : $scope.deviceType
        });
    }

    $scope.knowledgeBaseList.getDataCallback = (success, res) => {
        console.log(res)
    }

  
    // 销毁 事件
    $scope.$on('$destroy', () => {
    });
});