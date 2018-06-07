/**
 * [切换电站头]
 */
app.directive('switchPowerEnrich', ['myAjaxData', (myAjaxData) => ({
    restrict: 'E',
    transclude: !0,
    replace: !0,
    scope: !0,
    templateUrl: baseUrl + '/tpl/enrichment/monitoringSummary/components/switchPower.html',
    controller($scope) {
        myAjaxData.getData({
            name: 'GETgetCurrentInfoNew',
            data: { currentView: '00', isGroup: 0 }
        }).then(result => {
            $scope.currentDataName = result.currentDataName
            myAjaxData.setCurrentStationData(result)
            $scope.switchPowerCallback && $scope.switchPowerCallback()
        })

        $scope.$on('broadcastSwitchStation', (event, data) => {
            $scope.currentDataName = data.dataName
            myAjaxData.setCurrentStationData({ currentDataName: data.dataName, currentSTID: data.dataId })
            $scope.reload()
            $scope.switchPowerCallback && $scope.switchPowerCallback()
        })
    }
})])