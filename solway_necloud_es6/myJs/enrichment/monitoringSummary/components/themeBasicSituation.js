ajaxData({}, {
    __serviceName__: themeBasicSituationAjaxData
})('themeBasicSituationCtrl', ['$scope', 'themeBasicSituationAjaxData'], ($scope, myAjaxData) => {

    $scope.expenseHeight = 100;//费用 高

    const a = $scope.$parent.$parent.dateUpdated;
    $scope.$parent.$parent.dateUpdated = (b,c) =>{
        a && a(b, c);
        debugger

    }
});