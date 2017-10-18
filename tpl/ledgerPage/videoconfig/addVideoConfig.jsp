<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="addVideoConfigCtrl" class="modal fade" id="addVideoConfigModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content ">
			<div class="modal-body col-sm-12 wrapper panel">
				<div class="wrapper-md ng-scope">
					<div class="panel">
						<div class="wrapper">
							<form class="form-horizontal ng-pristine ng-valid" id="addVideoConfigForm">
								<input type="hidden" name="stId" value="{{pstationid}}" />
								<input type="hidden" name="id" value="{{editData.id}}" />
								<div class="form-group">
									<label class="col-sm-3 control-label">监控点名称</label>
									<div class="col-sm-6">
										<input type="text" maxlength="20" name="monitorPointName" ng-model="editData.monitorPointName"  class="form-control formData" >
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">监控点编号</label>
									<div class="col-sm-6">
										<input type="text" maxlength="2" name="monitorPointNum" ng-model="editData.monitorPointNum" class="form-control formData" >
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label">监控点IP</label>
									<div class="col-sm-6">
										<input type="text" maxlength="20" name="monitorPointIP" ng-model="editData.monitorPointIP" class="form-control formData" >
									</div>
								</div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">监控点源地址</label>
                                    <div class="col-sm-6">
                                        <input type="text" maxlength="80" name="monitorPointSource" ng-model="editData.monitorPointSource" class="form-control formData" >
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label">监控点目标地址</label>
                                    <div class="col-sm-6">
                                        <input type="text" maxlength="80" name="monitorPointDest" ng-model="editData.monitorPointDest" class="form-control formData" >
                                    </div>
                                </div>
								<div class="form-group">
									<label class="col-sm-3 control-label">监控点排序</label>
									<div class="col-sm-6">
										<input type="text" maxlength="11" name="monitorPointSeq" ng-model="editData.monitorPointSeq" class="form-control formData" >
									</div>
								</div>
								<div class="form-group m-t-sm ">
									<div class="col-lg-12 text-center" style="margin-top: 10px;">
										<button type="button" class="btn m-b-xs w-xs btn-info" ng-click="svaeFormData()"><strong>保 存</strong></button>
										<button type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
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

<script type="text/javascript">
	var flushPageList;
	$(function () {
        $("#addVideoConfigForm").validate({
            rules: {
                monitorPointName: {
                    required : true,
                    maxlength : 20
                },
                monitorPointNum: {
                    required : true,
                    range : [0, 99]
                },
                monitorPointIP: {
                    required : true,
                    ip : 20
                },
                monitorPointSource: {
                    required : true
                },
                monitorPointDest: {
                    required : true
                },
                monitorPointSeq: {
                    required : true,
                    number : true,
                    maxlength : 11
                }
            },
            messages:{
                monitorPointName:{
                    required:"必填",
                    maxlength: "监控点名称最长为20个字符"
                },
                monitorPointNum:{
                    required:"必填",
                    range:$.validator.format("请输入一个介于 {0} 和 {1} 之间的值")
                },
                monitorPointIP:{
                    required: "必填",
                    ip: $.validator.format("请输入正确的IP地址")
                },
                monitorPointSource:{
                    required: "必填"
                },
                monitorPointDest:{
                    required: "必填"
                },
                monitorPointSeq:{
                    required: "必填",
                    number : "请输入1-11的位的数字",
                    maxlength : "请输入1-11位的数字"
                }
            },
            submitHandler: function (form) {
                $.ajax({
                    url: "${ctx}/PVideoConfig/updateVideoConfig.htm",
                    dataType:"json",
                    type:"post",
                    data:$("#addVideoConfigForm").serialize(),
                    success:function(data){
						if (data.key == 0){
                            promptObj("success", '',data.msg);
                            hideModal("addVideoConfigModal");
                            flushPageList();
                        }
                    }
				});
            }
        });
    });

    app.controller("addVideoConfigCtrl", function ($scope, $window) {
		$scope.svaeFormData = function () {
            $("#addVideoConfigForm").trigger("submit");
        };
        flushPageList = $scope.flushPageList = function () {
            $scope.onSelectPage(1);
        };

        $scope.$on("editDataEdit", function (event, data) {
			$scope.editData = data;
        });
    });
</script>

