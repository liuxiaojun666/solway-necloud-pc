<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>

<script type="text/javascript">

    //初始化页面数据
    function initPageData(id){
        initPageData(id);
    }

    var initPageData;
    app.controller('DetailSystemOperationLogCtrl', ['$http', '$scope', function($http, $scope){
        $scope.detailData = null;
        initPageData = $scope.initPageData = function (id) {
            if (id == null) return;
            $http({
                method : "POST",
                url : "${ctx}/SystemOperationLog/querySystemOperationLogById.htm",
                params : {
                    "id": id
                }
            }).success(function(result) {
                if (result.key == 0){
                    $scope.detailData = result.data;
                    return;
                }
                promptObj('error','',result.msg);
            });
        }
    }]);

</script>
<div ng-controller="DetailSystemOperationLogCtrl" class="modal fade" id="DetailSystemOperationLogModal"
     tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog row">
        <div class="modal-content ">
            <div class="modal-body wrapper-lg">
                <div class="row">
                    <div class="col-sm-12">
                        <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">操作日志管理</span>
                        <div class="panel-body">
                            <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Basedictionary/updateBaseDictionary.htm" method="post" id="editForm" name="editForm">
                                <input type="hidden" name="id" value="{{editData.id}}" />
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">操作用户</label>
                                    <div class="col-lg-4">
                                        <span class="form-control formData">{{detailData.userName}}</span>
                                    </div>
                                    <label class="col-lg-2 control-label">操作IP</label>
                                    <div class="col-lg-4">
                                        <span class="form-control formData">{{detailData.operationIP}}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">操作模块</label>
                                    <div class="col-lg-4">
                                        <span class="form-control formData">{{detailData.operationModule}}</span>
                                    </div>
                                    <label class="col-lg-2 control-label">操作方法</label>
                                    <div class="col-lg-4">
                                        <span class="form-control formData">{{detailData.operationMethod}}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">操作时间</label>
                                    <div class="col-lg-4">
                                        <span class="form-control formData">{{detailData.operationTime}}</span>
                                    </div>
                                    <label class="col-lg-2 control-label">操作类型</label>
                                    <div class="col-lg-3">
                                        <span class="form-control formData">{{detailData.operation}}</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">内容</label>
                                    <div class="col-lg-10" style="word-break: break-all;" ng-bind-html="detailData.content">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-7" style="margin-top: 10px;">
                                        <button type="button" class="pull-right btn m-b-xs w-xs btn-info" data-dismiss="modal"><strong>关闭</strong></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
