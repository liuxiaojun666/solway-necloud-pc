<div ng-controller="detailFaultProtocolCtrl" class="modal fade" id="faultProtocolDetailModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
        <div class="modal-content ">
            <div class="modal-body wrapper-lg">
                <div class="row">
                    <div class="col-sm-12">
                        <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">故障码配置</span>
                        <div class="panel-body">
                            <table class="table table-bordered">
                                <tr>
                                    <td class="col-lg-2" ng-if="itemDetailData.faultCode != null && itemDetailData.faultCode != ''">故障代码</td>
                                    <td class="col-lg-4" ng-if="itemDetailData.faultCode != null && itemDetailData.faultCode != ''">{{itemDetailData.faultCode}}</td>
                                    <td class="col-lg-2" ng-if="itemDetailData.faultCodeIndex != null && itemDetailData.faultCodeIndex != ''">故障索引</td>
                                    <td class="col-lg-4" ng-if="itemDetailData.faultCodeIndex != null && itemDetailData.faultCodeIndex != ''">{{itemDetailData.faultCodeIndex}}</td>
                                    <td class="col-lg-2">故障分类</td>
                                    <td class="col-lg-4">{{itemDetailDictData.dictName}}</td>
                                </tr>
                                <tr>
                                    <td class="col-lg-2">故障中文描述</td>
                                    <td class="col-lg-4">{{itemDetailData.faultDescCH}}</td>
                                    <td class="col-lg-2">故障英文描述</td>
                                    <td class="col-lg-4">{{itemDetailData.faultDescEN}}</td>
                                </tr>
                                <tr>
                                    <td class="col-lg-2">故障原因及处理流程</td>
                                    <td class="col-lg-10" colspan="4">{{itemDetailData.faultCodeIndex}}</td>
                                </tr>
                                <tr>
                                    <td class="col-lg-2">备注</td>
                                    <td class="col-lg-10" colspan="4" ng-bind-html="itemDetailData.faultHandle | replaceBrFilter"></td>
                                </tr>
                                <tr>
                                    <td class="col-lg-2">推荐意见</td>
                                    <td class="col-lg-10" colspan="4">
                                        <div ng-repeat="item in itemDetailData.realAdvices">{{item.content}}</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="col-lg-2">附件</td>
                                    <td class="col-lg-10" colspan="4">

                                        <a ng-if="itemDetailData.file1 != '' && itemDetailData.file1 != null" class="text-info" title="{{itemDetailData.fileName1}}">
                                            <i class="fa fa-paperclip" ng-click="download({{itemDetailData.id }}, '1')"></i> 附件1
                                        </a>
                                        <span ng-if="!(itemDetailData.file1 != '' && itemDetailData.file1 != null)" class="text-muted">
                                            <i class="fa fa-paperclip"></i> 附件1
                                        </span>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a ng-if="itemDetailData.file2 != '' && itemDetailData.file2 != null" class="text-info" title="{{itemDetailData.fileName2}}">
                                            <i class="fa fa-paperclip" ng-click="download({{itemDetailData.id }}, '2')"></i> 附件2
                                        </a>
                                        <span ng-if="!(itemDetailData.file2 != '' && itemDetailData.file2 != null)" class="text-muted">
                                            <i class="fa fa-paperclip"></i> 附件2
                                        </span>
                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                        <a ng-if="itemDetailData.file3 != '' && itemDetailData.file3 != null"class="text-info" title="{{itemDetailData.fileName3}}">
                                            <i class="fa fa-paperclip" ng-click="download({{itemDetailData.id }}, '3')"></i> 附件3
                                        </a>
                                        <span ng-if="!(itemDetailData.file3 != '' && itemDetailData.file3 != null)"class="text-muted">
                                            <i class="fa fa-paperclip"></i> 附件3
                                        </span>
                                    </td>
                                </tr>
                            </table>
                            <div class="row">
                                <div class="col-lg-12 text-center">
                                    <button type="button" class="m-l-sm btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>关闭</strong></button>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

//初始化数据
function initSlaveDetailData(id) {
    var $scope = angular.element(document.getElementById("faultProtocolDetailModal")).scope();
    $scope.initData(id)
};

app.controller('detailFaultProtocolCtrl', function($http, $scope, $stateParams){

    $scope.initData = function(slaveId) {
        $scope.itemDetailData = null;
        var protocolID = $("#id").val();
        if(slaveId != '' && slaveId != null && protocolID != '' && protocolID != null) {
            $http({
                method : "POST",
                url : "${ctx}/PFaultCodeReal/selectById.htm",
                params : {
                    id: slaveId,
                    protocolID: protocolID,
                    type: 'detail'
                }
            }).success(function(data) {
                $scope.itemDetailData = data;
                if (data.faultType != null && data.faultType != '') {
                    $http({
                        method : "POST",
                        url : "${ctx}/Basedictionary/selectAll.htm",
                        params : {
                            dictType: "FAULT_REAL_TYPE"
                        }
                    }).success(function(dictData) {
                        angular.forEach(dictData, function(v){
                            $scope.itemDetailDictData = v;
                        });
                    });
                }
            });
        }
    }

});
</script>