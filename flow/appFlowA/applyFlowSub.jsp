<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div class="wrapper-md">
    <div class="panel panel-default">
        <div ng-controller="applySubController">
        <form id="dataForm" action="${ctx }/appFlowA/update.htm" method="post">
            <input type="hidden" name="processId" value="{{commonData.processId }}" />
            <input type="hidden" name="orderId" value="{{commonData.orderId }}" />
            <input type="hidden" name="taskId" value="{{commonData.taskId }}" />
            <input type="hidden" name="id" value="{{item.id }}" />
            <table class="table table-bordered">
                <tr>
                    <td>内容1</td>
                    <td>
                        <input type="text" id="content1" name="content1" value="{{item.content1 }}" />
                    </td>
                </tr>
                <tr>
                    <td>内容2</td>
                    <td>
                        <input type="text" id="content2" name="content2" value="{{item.content2 }}" />
                    </td>
                </tr>
                <tr>
                    <td>内容3</td>
                    <td>
                        <input type="text" id="content3" name="content3" value="{{item.content3 }}" />
                    </td>
                </tr>
                <tr>
                    <td>内容4</td>
                    <td>
                        <input type="text" id="content4" name="content4" value="{{item.content4 }}" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <a id="formSub" class="btn btn-primary">提交</a>
                        &nbsp;&nbsp;
                        <a id="goBack" class="btn" ng-click="goBack();">返回</a>
                    </td>
                </tr>
            </table>
        </form>
        </div>
    </div>
</div>
<script>
    app.controller('applySubController', function($scope, $http, $state, paramsData) {

        $scope.commonData = paramsData.get('commonData', false);

        $('#formSub').click(function(){
            var options = {
                dataType : "json",
                success : function(result) {
                    if (result.code == "0") {
                        //设置返回参数
                        if (result.data.updateFlag == 0) {
                            $scope.commonData.orderId = result.data.orderId;
                            paramsData.put('commonData', $scope.commonData);
                        }
                        promptObj('success','',"保存成功");
                       $("#goBack").trigger("click");
                    } else {
                        promptObj('error', '',"保存失败");
                    }
                },
                error : function(result) {
                    $("#errorFlag").trigger('click');
                }
            };
            $('#dataForm').ajaxSubmit(options);
        })
    });
</script>