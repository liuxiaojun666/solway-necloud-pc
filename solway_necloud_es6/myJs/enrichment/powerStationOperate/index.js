ajaxData({
    
}, {})('powerStationOperateCtrl', ['$scope', 'myAjaxData', 'actionRecord', '$timeout','toaster','$interval'], ($scope, myAjaxData, historicalRecord, $timeout,toaster,$interval) => {
    $scope.moduleName = '电站运行';//当前页面名称；

    //头部折叠框 显示
    $timeout(() => {
        $('.ng-clock').removeClass('ng-clock');
    }, 2000);

    // 按照集团显示
    $scope.isGroupShow = true;
    $scope.changeInputAbsent = ()=>{
        $scope.isGroupShow = !$scope.isGroupShow;
    }

    $scope.addEvent = false;
    //点击电站方块 - 弹出添加事件组件
    $scope.addEventFun = ()=>{
        $scope.addEvent = true;
    }
});