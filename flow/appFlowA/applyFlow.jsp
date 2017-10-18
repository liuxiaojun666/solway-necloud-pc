<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div ng-controller="applyController">
    <div ng-include="targetView"></div>
</div>
<script>
    app.controller('applyController', function($scope, $http, $state, paramsData) {
//        $scope.commonParams = commonData;

        $scope.commonData = paramsData.get('commonData', false);

        $scope.init = function() {
            $http({
                method : "get",
                url : '${ctx }/appFlowA/apply.htm',
                params : $scope.commonData
            }).success(function(result) {
                var readFlag = $('#' + '${param.nodeName}').attr('data-read-flag');
                <%--console.log('nodeName', '${param.nodeName}', angular.equals(readFlag, 'true'))--%>
                $scope.item = result.item;
                if (!angular.equals(readFlag, 'true')) {
                    $scope.targetView = '/flow/appFlowA/applyFlowSub.jsp';
                } else {
                    $scope.targetView = '/flow/appFlowA/applyFlowView.jsp';
                }
            });
        }
        $scope.init();

        $scope.goBack = function () {
            $scope.commonData = paramsData.get('commonData', false);
            console.info($scope.commonData)
            $state.go("app.flowAccess", $scope.commonData);
        }
    });
</script>
