<div ng-controller="AddFaultProtocolCtrl" class="modal fade" id="faultProtocolModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
        <div class="modal-content ">
            <div class="modal-body wrapper-lg">
                <div class="row">
                    <div class="col-sm-12">
                        <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">故障码配置</span>
                        <div class="panel-body">
                            <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PFaultCodeReal/update.htm" method="post" id="editSlaveForm" name="editSlaveForm">
                                <input type="hidden" name="id" id="faultProtocolId" class="formData"/>
                                <input type="hidden" name="protocolID" id="protocolID" class="formData"/>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label" ng-if="faultCodeReal"><i class="fa fa-asterisk text-required"/>故障代码</label>
                                    <div class="col-lg-4" ng-if="faultCodeReal">
                                        <input type="text" id="faultCode" name="faultCode" class="form-control formData valid-required" maxlength="50" dicts="true"><div class="valid-error"></div>
                                    </div>
                                    <label class="col-lg-2 control-label" ng-if="!faultCodeReal"><i class="fa fa-asterisk text-required"/>故障索引</label>
                                    <div class="col-lg-4" ng-if="!faultCodeReal">
                                        <input type="text" id="faultCodeIndex" name="faultCodeIndex" class="form-control formData valid-required" maxlength="50"><div class="valid-error"></div>
                                    </div>
                                    <label class="col-lg-2 control-label">故障分类</label>
                                    <div class="col-lg-4">
                                        <ui-select ng-model="dicts.selected" theme="bootstrap" ng-change="dictsChange()">
                                            <ui-select-match placeholder="请输入故障分类">{{$select.selected.dictName}}</ui-select-match>
                                            <ui-select-choices repeat="item in dicts | filter: $select.search">
                                                <div ng-bind-html="item.dictName | highlight: $select.search"></div>
                                            </ui-select-choices>
                                        </ui-select>
                                        <input type="hidden" name="faultType" id="faultType" class="formData"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>故障中文描述</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="faultDescCH" name="faultDescCH" maxlength="50" class="form-control formData valid-required"><div class="valid-error"></div>
                                    </div>
                                    <label class="col-lg-2 control-label">故障英文描述</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="faultDescEN" name="faultDescEN" maxlength="20" class="form-control formData">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">故障原因及处理流程</label>
                                    <div class="col-lg-10">
                                        <textarea id="faultHandle" name="faultHandle" class="form-control formData" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">备注</label>
                                    <div class="col-lg-10">
                                        <textarea id="descp" name="descp" class="form-control formData" rows="3"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-2"></div>
                                    <table id="data-list" class="table table-bordered col-lg-2">
                                        <tr>
                                            <td><a class="btn btn-info btn-xs" id="add-tr"><i class="fa fa-plus" aria-hidden="true"></i>添加</a>  推荐意见</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>


                                <!-- 文件上传 -->
                                <div class="form-group">
                                    <div class="f-box">
                                        <label class="col-lg-2 control-label">附件1</label>
                                        <div class="col-lg-4">
                                            <input type="text" readonly name="fileName1" id="fileName1" placeholder="请上传附件" class="form-control formData" />
                                            <input type="hidden" readonly name="file1" id="file1" class="form-control formData"/>
                                        </div>
                                        <div class="col-lg-2 f-pos">
                                            <button type="button" class="btn btn-link">上传</button>
                                            <input type="file" name="file" id="file11" data-target="1" class="f-file fileupload" />
                                        </div>
                                        <div class="col-lg-2 f-pos f-op">
                                            <a class="text-info f-op-info">
                                                <i class="fa fa-paperclip" ng-click="download(faultCodeRealId, 1)"></i>
                                            </a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a class="text-danger f-op-danger">
                                                <i class="icon-trash" ng-click="deleteFile(1);"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="f-box">
                                        <label class="col-lg-2 control-label">附件2</label>
                                        <div class="col-lg-4">
                                            <input type="text" readonly name="fileName2" id="fileName2" placeholder="请上传附件" class="form-control formData" />
                                            <input type="hidden" readonly name="file2" id="file2" class="form-control formData"/>
                                        </div>
                                        <div class="col-lg-2 f-pos">
                                            <button type="button" class="btn btn-link">上传</button>
                                            <input type="file" name="file" id="file12" data-target="2" class="f-file fileupload" />
                                        </div>
                                        <div class="col-lg-2 f-pos f-op">
                                            <a class="text-info f-op-info">
                                                <i class="fa fa-paperclip" ng-click="download(faultCodeRealId, 2)"></i>
                                            </a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a class="text-danger f-op-danger">
                                                <i class="icon-trash" ng-click="deleteFile(2);"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="f-box">
                                        <label class="col-lg-2 control-label">附件3</label>
                                        <div class="col-lg-4">
                                            <input type="text" readonly name="fileName3" id="fileName3" placeholder="请上传附件" class="form-control formData" />
                                            <input type="hidden" readonly name="file3" id="file3" class="form-control formData"/>
                                        </div>
                                        <div class="col-lg-2 f-pos">
                                            <button type="button" class="btn btn-link">上传</button>
                                            <input type="file" name="file" id="file13" data-target="3" class="f-file fileupload" />
                                        </div>
                                        <div class="col-lg-2 f-pos f-op">
                                            <a class="text-info f-op-info">
                                                <i class="fa fa-paperclip" ng-click="download(faultCodeRealId, '3')"></i>
                                            </a>
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <a class="text-danger f-op-danger">
                                                <i class="icon-trash" ng-click="deleteFile(3);"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                                        <button type="button" ng-click="saveSlaveForm();" id="saveSlaveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
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

<style type="text/css">
    .f-pos{position:relative;overflow: hidden;}
    .f-file{position: absolute;top: 0px;height: 30px;opacity: 0;cursor: pointer;}
    .f-op-info,.f-op-danger{display: none}
</style>
<script src="${ctx}/vendor/jquery/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
<script type="text/javascript">
    var tpl =
            '<tr class="data-tr">' +
                '<td class="col-lg-11">' +
                    '<input type="hidden" name="adviceId" data-skip-falsy="true" class="form-control formData adviceId">' +
                    '<input type="text" name="adviceContent" data-skip-falsy="true" maxlength="200" class="form-control formData required adviceContent">' +
                '</td>' +
                '<td class="col-lg-1"><a class="del-tr"><i class="icon-trash"></i></a></td>' +
            '</tr>';
$(function () {
    $(document).on('click', '#add-tr',function(){
        $('#data-list').append(tpl);
    });
    $(document).on('click', '.del-tr',function(){
        var $tr = $(this).parents('tr');
        $tr.remove();
    });
});
//初始化数据
function initSlavePageData(id) {
    $('#faultProtocolModal').find(".formData").val("");
    var $scope = angular.element(document.getElementById("faultProtocolModal")).scope();
    $scope.initData(id)
};

var dictsFuc = null;
app.controller('AddFaultProtocolCtrl', function($http, $scope, $stateParams){
    //初始化故障码类型
    $scope.$on('faultCodeReal', function(event,data) {
        $scope.faultCodeReal = data;
    });
    //初始化故障码分类
    dictsFuc = $scope.getDicts = function(){
        //类别字典
        $http({
            method : "POST",
            url : "${ctx}/Basedictionary/selectAll.htm",
            params : {
                dictType: "FAULT_REAL_TYPE"
            }
        }).success(function(result) {
            $scope.dicts = result;
            $scope.dicts.unshift({dictValue : null,dictName : '请选择'});
            $scope.dicts.selected = result[0];
            if ($("#faultType").val() != null) {
                angular.forEach($scope.dicts, function(data){
                    if (data.dictValue == $("#faultType").val()) {
                        $scope.dicts.selected = data;
                    }
                });
            }
            $scope.dictsChange = function () {
                $("#faultType").val(angular.copy($scope.dicts.selected.dictValue));
            };
        });
    }

    $scope.initData = function(slaveId) {
        $('#data-list').find('.data-tr').remove();
        $("#protocolID").val($("#id").val());
        if(slaveId != '' && slaveId != null) {
            $http({
                method : "POST",
                url : "${ctx}/PFaultCodeReal/selectById.htm",
                params : {
                    id: slaveId
                }
            }).success(function(data) {
                $('#faultProtocolId').val(data.id);
                $('#protocolID').val(data.protocolID);
                $('#faultCode').val(data.faultCode);
                $('#faultCodeIndex').val(data.faultCodeIndex);
                $('#faultDescCH').val(data.faultDescCH);
                $('#faultDescEN').val(data.faultDescEN);
                $('#faultType').val(data.faultType);
                $('#faultHandle').val(data.faultHandle);
                $('#descp').val(data.descp);

                $('#file1').val(data.file1);
                $('#fileName1').val(data.fileName1);
                $('#file2').val(data.file2);
                $('#fileName2').val(data.fileName2);
                $('#file3').val(data.file3);
                $('#fileName3').val(data.fileName3);

                $scope.faultCodeRealId = data.id;

                if(data.fileName1 != null && data.fileName1 != ''){
                    $('.f-op-info').eq(0).show();
                    $('.f-op-danger').eq(0).show();
                }
                if(data.fileName2 != null && data.fileName2 != ''){
                    $('.f-op-info').eq(1).show();
                    $('.f-op-danger').eq(1).show();
                }
                if(data.fileName3 != null && data.fileName3 != ''){
                    $('.f-op-info').eq(2).show();
                    $('.f-op-danger').eq(2).show();
                }
                if(data.realAdvices) {
                    console.info(data.realAdvices);
                    for(var i= 0, lng=data.realAdvices.length; i<lng; i++) {
                        $('#data-list').append(tpl);
                        var $dataTr = $('#data-list').find('.data-tr').last();
                        $dataTr.find('input[name="adviceId"]').val(data.realAdvices[i].id);
                        $dataTr.find('input[name="adviceContent"]').val(data.realAdvices[i].content);
                    }
                }
            });
        }
        dictsFuc();
    }

    /* ---------- 保存表单 ---------- */
    $scope.saveSlaveForm = function() {
        $form = $('#editSlaveForm');
        //表单验证
        $form.validate({
            success: function (element) {
            },
            submitHandler: function(form) {
                var adviceArray = [];
                $('.data-tr').each(function (i,v) {
                    adviceArray.push({
                        id: $(this).find('input[name="adviceId"]').val(),
                        content: $(this).find('input[name="adviceContent"]').val()
                    })
                });
                var formStr = $form.serialize() + '&adviceStr=' + JSON.stringify(adviceArray);
                $.post('${ctx}/PFaultCodeReal/update.htm', formStr, function(data) {
                    if(data.code == 0){
                        hideModal("faultProtocolModal");
                        promptObj('succes', '',"保存成功");
                    } else {
                        promptObj('error', '',"保存失败");
                    }
                    //刷新列表
                    goSlavePage();
                });
            }
        });
		$form.trigger("submit");
    }

    $scope.deleteFile = function(index){
        $("input[name='file" + index + "']").eq(index - 1).val('');
        $("input[name='fileName" + index + "']").eq(index - 1).val('');
        $('.f-op-info').eq(index - 1).hide();
        $('.f-op-danger').eq(index - 1).hide();
    }
});


//文件上传操作
$(function(){
    $(".fileupload").on("change", function(){
        ajaxFileUpload($(this).attr("id"));
    });
});
function ajaxFileUpload(fileId) {
    $.ajaxFileUpload ({
        url: '${ctx}/PFaultCodeReal/fileUpload.htm',
        secureuri: false,
        fileElementId: fileId,
        formName: "file",
        dataType: 'json',
        success: function (data) {
            if(data.key != 0){
                var dataTarget = $("#"+fileId).attr('data-target');
                $('#file' + dataTarget).val(data.data.fileName);
                $('#fileName' + dataTarget).val(data.data.originalFilename);
                promptObj('success', "","上传成功");
                $('.f-op-danger').eq(dataTarget - 1).show();
                return;
            }
            promptObj('error', "","上传失败");
        },
        error: function (data, status, e) {
            promptObj('error', "","上传失败");
        }
    })
}
</script>