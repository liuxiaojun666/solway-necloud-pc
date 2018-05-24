app.directive('endDateWarning', ['$ocLazyLoad', '$http', ($ocLazyLoad, $http) => ({
    restrict: 'E',
    transclude: !0,
    replace: !0,
    scope: {
       
    },
    templateUrl: 'tpl/blocks/endDateWarningModel.html',
    link($scope, $element) {
      
        $scope.showNoticeAlert = false;//默认弹框不显示
        const getNewRoleEndDate = () =>{
            $http({
                method: "GET",
                url: window.baseUrl + "/PowerStation/getServiceAgreement.htm",
                params: {}
            }).success(function (result) {

                if (result.body && result.body.length) {
                    changeRoleIdsValue();
                    $scope.noticeList = result.body;
                    $scope.showNoticeAlert = true;
                }
                
            });
        }
        
        const changeRoleIdsValue = () =>{
            let storage = JSON.parse(localStorage['roleIds']);
            for(let i=0;i<storage.length;i++){
                if ($scope.currentRoleID == storage[i].roleId){
                    storage[i].defineVal = 1;
                }
            }

            localStorage['roleIds'] = JSON.stringify(storage);
        }
       
        const getRoleData = () =>{
            $http({
                method: "POST",
                url: window.baseUrl +"/UserAuthHandle/getRoleListForPC.htm"
            }).success(function (res) {
                $scope.rolelist = res.rolelist;	
                $scope.currentRoleID = res.currentRole;

                //将当前用户的所有角色存入。（默认首次值均为0，若当前角色协议有过期项，值变为1，下次切换，若为1，则不再提醒）
                //先判断是否已经存入
                if (localStorage['roleIds'] == undefined){
                    const roleIdsArr = []
                    for (let i = 0, list = $scope.rolelist; i < list.length; i++) {
                        roleIdsArr.push({ roleId: list[i].roleId, defineVal: 0 })
                    }
                    localStorage['roleIds'] = JSON.stringify(roleIdsArr);
                    getNewRoleEndDate();
                }else{
                    let storage = JSON.parse(localStorage['roleIds']);
                    for(let i=0;i<storage.length;i++){
                        if ($scope.currentRoleID == storage[i].roleId && !storage[i].defineVal){
                            getNewRoleEndDate();
                            break;
                        }
                    }
                }
                
                
            });
        }

        getRoleData();
     
        $scope.aluso = () =>{
            $scope.showNoticeAlert = false;
        }
    }
})])
