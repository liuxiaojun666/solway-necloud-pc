<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div ng-controller="approvalController">
    <div ng-include="targetView"></div>
</div>
<script>
    app.controller('approvalController', function($scope, $http, $state, paramsData) {
//        $scope.commonParams = commonData;
//        $scope.commonParams = paramsData.get('commonData', false);
//
//        console.log($scope.commonParams);
        $scope.commonData = paramsData.get('commonData', false);
        $scope.init = function() {
            $http({
                method : "get",
                url : '${ctx }/snaker/flow/approval.htm',
                params : $scope.commonData
            }).success(function(result) {
                var readFlag = $('#' + '${param.nodeName}').attr('data-read-flag');
                <%--console.log('nodeName', '${param.nodeName}', angular.equals(readFlag, 'true'))--%>
                $scope.items = result.data.approvals;
                if (!angular.equals(readFlag, 'true')) {
                    $scope.targetView = '/snaker/flow/approvalFlowSub.jsp';
                } else {
                    $scope.targetView = '/snaker/flow/approvalFlowView.jsp';
                }
            });
        }
        $scope.init();

        $scope.goBack = function () {
            $state.go("app.activityTask", {
                taskType : 0,
                processId : $scope.commonData.processId,
            });
        }
    });
</script>
