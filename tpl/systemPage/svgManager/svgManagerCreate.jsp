<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="SvgManagerCreateCtrl">
    <%--<iframe src="${ctx}/vendor/svgdraw/index.jsp" allowtransparency="true" style="background-color:transparent"></iframe>--%>
    <div class="vbox">
        <div class="row-row">
            <iframe ng-src="${ctx}/vendor/svgdraw/index.jsp" width="100%" name="svgIframe" height="550"></iframe>
        </div>
    </div>
</div>
<script type="text/javascript">
    var saveSvgDataToDataBase, cancelSvgClick, queryWindTurbine, queryWindTower, pStationSelectChange;
    app.controller('SvgManagerCreateCtrl', function($http, $scope, $stateParams, $state, $interval) {
        $scope.init = function () {
            if (svgIframe.window.svgCanvas == undefined) return;
            $interval.cancel($scope.time);
            if ($stateParams.id){
                $scope.dataInitEdit();
            }else {
                $scope.dataInitCreate();
            }
        };
        $scope.time = $interval($scope.init, 100);

        pStationSelectChange = $scope.pStationSelectChange = function (pstationId) {
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryBJunctionBox.htm", pstationId, "HLX");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryBInverter.htm", pstationId, "NBQ");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryBInverter.htm?hasJb=1", pstationId, "NBQHLX");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryBBoxChange.htm", pstationId, "XB");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryBWindTurbine.htm", pstationId, "windTurbine");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryBWindTower.htm", pstationId, "windTower");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryVideoConfig.htm", pstationId, "videoImage");
            $scope.queryDeviceSelectData("${ctx}/BLayoutConfig/queryMeterConfig.htm", pstationId, "Meter");
        };

        $scope.queryDeviceSelectData = function (url, pstationId, type) {
            $http({
                method: "POST",
                url: url,
                params: {
                    "pstationId": pstationId
                }
            }).success(function (res) {
                if (res.key == 0){
                    svgIframe.window.dataInitSelect(res, type);
                }
            });
        };

        $scope.dataInitEdit = function () {
            $http({
                method: "POST",
                url: "${ctx}/BLayoutConfig/queryBLayoutSvgById.htm",
                params: {
                    "id": $stateParams.id
                }
            }).success(function (res) {
                if (res.key == 0){
                    svgIframe.window.setDataWithEdit(res.data);
                }
            });
        };

        $scope.dataInitCreate = function () {
            $http({
                method: "POST",
                url: "${ctx}/BLayoutConfig/queryBPowerStation.htm",
                params: {}
            }).success(function (res) {
                if (res.key == 0){
                    svgIframe.window.setDataWithCreate(res);
                }
            });
        };

        saveSvgDataToDataBase = $scope.saveSvg = function (data) {
            var svgCanvas = svgIframe.window.svgCanvas;
            var blob = new Blob([svgCanvas.getSvgString()], {type:"text/xml"});
            var formData = new FormData();
            formData.append("id", data.id);
            formData.append("entityId", data.entityId);
            formData.append("name", data.name);
            formData.append("file", blob);
            formData.append("isDisplay", data.isDisplay);
            console.info(blob, data, formData);
            $.ajax({
                type:'POST',
                url: '${ctx}/BLayoutConfig/updateBLayoutConfig.htm',
                processData: false,
                cache: false,
                contentType: false,
                data: formData,
                success: function(result){
                    if (result.key == 0){
                        promptObj('success','',result.msg);
                        $scope.cancelSvg();
                        return;
                    }
                    promptObj('error','',result.msg);
                    $scope.cancelSvg();
                }
            });
        };

        cancelSvgClick = $scope.cancelSvg = function () {
            $state.go("app.svgManager");
        }
    });
</script>