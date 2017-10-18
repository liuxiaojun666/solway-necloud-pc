<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>

<script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
            rules : {
                dictType:{
                    required : true,
                    maxlength : 50
                },
                dictName:{
                    required : true,
                    maxlength : 50
                },
                dictCode:{
                    maxlength : 20
                },
                dictEnName:{
                    maxlength : 20
                },
                description:{
                    maxlength : 300
                },
                dictValue:{
                    number: true,
                    maxlength: 11
                }
            },
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
                        if (json.key == 0){
                            //弹出提示信息
                            promptObj('success','',json.msg);
                            //关闭弹出层
                            hideModal("baseDictionaryCtrlModal");
                            //刷新列表数据
                            goPage(1);
                            return;
                        }
                        promptObj('error','',json.msg);
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
	});
	function saveForm(){
		$("#editForm").trigger("submit");
	}

	//初始化页面数据
	function initPageData(id){
        initPageData(id);
	}

	var initPageData;
	app.controller('AddBaseDictionaryCtrl', ['$http', '$scope', function($http, $scope){
        $scope.editData = null;
        initPageData = $scope.initPageData = function (id) {
            $scope.editData = null;
            if (id == null) return;
            $http({
                method : "POST",
                url : "${ctx}/Basedictionary/selectByPrimaryKey.htm",
                params : {
                    "id": id
                }
            }).success(function(result) {
                if (result.key == 0){
                    $scope.editData = result.data;
                    return;
                }
                promptObj('error','',result.msg);
            });
        }
	}]);

</script>
<div ng-controller="AddBaseDictionaryCtrl" class="modal fade" id="baseDictionaryCtrlModal"
tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">字典管理</span>
        <div class="panel-body">
            <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Basedictionary/updateBaseDictionary.htm" method="post" id="editForm" name="editForm">
                <input type="hidden" name="id" value="{{editData.id}}" />
                <div class="form-group">
                    <label class="col-lg-2 control-label">字典类型</label>
                    <div class="col-lg-4">
                        <input type="text" name="dictType" value="{{editData.dictType}}" class="form-control formData">
                    </div>
                    <label class="col-lg-2 control-label">字典名</label>
                    <div class="col-lg-4">
                        <input type="text" name="dictName" value="{{editData.dictName}}" class="form-control formData">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-2 control-label">字典编码</label>
                    <div class="col-lg-4">
                        <input type="text" name="dictCode" value="{{editData.dictCode}}" class="form-control formData">
                    </div>
                    <label class="col-lg-2 control-label">字典英文名</label>
                    <div class="col-lg-4">
                        <input type="text" name="dictEnName" value="{{editData.dictEnName}}" class="form-control formData">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-2 control-label">描述</label>
                    <div class="col-lg-4">
                        <input type="text" name="description" value="{{editData.description}}" class="form-control formData">
                    </div>
                    <label class="col-lg-2 control-label">字典值</label>
                    <div class="col-lg-3">
                        <input type="text" name="dictValue" value="{{editData.dictValue}}" class="form-control formData" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-8" style="margin-top: 10px;">
                        <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                        <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
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
