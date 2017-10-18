<%--
  User: GreenBook
  Date: 2017/7/3
  Time: 18:08
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<div ng-controller="flowController">
    <div id="flow">
        <div ng-include="item.url" id="{{item.name}}" data-read-flag="{{item.readFlag}}" ng-repeat="item in items"></div>
        <div ng-if="commonData.processId && commonData.orderId">

            <div class="wrapper-md">
                <a href="${ctx}/snaker/process/processDiagram.jsp?processId={{commonData.processId}}&orderId={{commonData.orderId}}" class="btn btn-info" target="diagram">查看流程图</a>
            </div>
        </div>
        <%--<div ng-include="processDiagramView"></div>--%>
    </div>
</div>


<script type="text/javascript">
    app.controller('flowController', function($scope, $http, $state, $stateParams, paramsData) {
        $scope.commonData = {};
        if ($stateParams.processId) $scope.commonData.processId = $stateParams.processId;
        if ($stateParams.orderId) $scope.commonData.orderId = $stateParams.orderId;
        if ($stateParams.taskId) $scope.commonData.taskId = $stateParams.taskId;
        if ($stateParams.taskName) $scope.commonData.taskName = $stateParams.taskName;
        if ($stateParams.taskKey) $scope.commonData.taskKey = $stateParams.taskKey;
        <%-- 改用新页面方式 --%>
        <%--
        $scope.getProcessView = function () {
            if ($scope.commonData.processId && $scope.commonData.orderId) {
                $scope.processDiagramView = '${ctx}/snaker/process/processDiagram.jsp?' + 'processId=' + $scope.commonData.processId +  '&orderId=' + $scope.commonData.orderId
            }
        };
        $scope.getProcessView();
        --%>
        //获取节点数据
        $scope.getNode = function () {
            paramsData.put("commonData", $scope.commonData);
            $http({
                method : "get",
                url : '${ctx}/snaker/flow/nodes.htm',
                params : $scope.commonData
            }).success(function(result) {
                if(result.code != 0) {
                    alert(result.message);
                }
                $scope.currNodeKey = result.data.currNodeKey;
                $scope.items = result.data.items;
            });

        };
        $scope.getNode();

    });
</script>

