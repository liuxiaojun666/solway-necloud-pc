ajaxData({
    //电站列表
    allSTListForPCBySession: {
        name: 'GETAllSTListForPCBySession',
        data: {},
        later:true
    },
    //添加电站
    updateBatch:{
        name:'POSTupdateBatch',
        data: {},
        later:true
    }
}, {
    __serviceName__: 'stationListTplCtrlService'
})('stationListTplCtrl', ['$scope', 'stationListTplCtrlService','$timeout','toaster'], ($scope, myAjaxData,$timeout,toaster) => {

    $scope.$on('userId',(e,v)=>{
        $scope.userId = v;

        //获取电站列表
        $scope.allSTListForPCBySession.getData({
        }).then(res =>{
            console.log(res)
            $scope.stationList = res
        })
    })
    

    //确定---添加电站
    $scope.addStation = () =>{
        const stationIdsArr = [];
        $("input[name='stationIds']:checked").map((index,v)=>{
            stationIdsArr.push(v.value)
        })
        
        $scope.updateBatch.getData({
            userId:$scope.userId,
            stationIds:stationIdsArr.join(',')
        }).then(res =>{
            debugger
            if(res.code == "0"){
                toaster.pop('success', '',res.msg);
                $scope.$parent.$parent.ifStationListTpl = false;
                $scope.$emit('addStationSuccessful');
            }else{
                toaster.pop('error', "",res.msg)
            }
        })
    }

    //取消
    $scope.$on('$destroy', () => {
        $scope.userId = ''
    });

});