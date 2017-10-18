<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 自动排班 -->
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>

<script type="text/javascript">
//初始化页面数据
function initPageData(id){
	//清空数据
	$(".formData").val(""); 
}
	
	$(function() {
		//验证信息
		$("#editForm").validate({
			rules : {
				code : {
					required : true,
					maxlength : 50
				},
				name : {
					required : true,
					maxlength : 20
				}

			},

			//提交信息
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success', '', "保存成功");
						hideModal("opTeamModal");
						refreshList();
					},
					error : function(json) {
						promptObj('error', '', "保存失败,请稍后重试!");
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
	});
	
	//保存team
	function saveForm() {
		$("#editForm").trigger("submit");
	}

	//刷新team列表
	function refreshList(){
		var appElement = document.querySelector('[ng-controller=MaintenanceCtr]');
		var $scope = angular.element(appElement).scope();
		$scope.loadTeamInfo(false);	
	}
	
</script>
<div class="modal fade" id="opTeamModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog row">
		<div class="modal-content ">
			<div class="modal-body wrapper-lg">
				<div class="row">
					<div class="col-sm-12">
						<h3 class="m-t-none m-b font-thin" id="myModalLabel">班组信息管理</h3>
						<div class="panel-body">
							<form class="bs-example form-horizontal ng-pristine ng-valid"
								action="${ctx}/opTeam/update.htm" method="post"
								id="editForm" name="editForm">
								<input type="hidden" name="id" value="" id="id" class="formData" />
								<div class="form-group">
									<label class="col-lg-2 control-label">班组编号</label>
									<div class="col-lg-10">
										<input type="text" id="teamNo" name="teamNo"
											class="form-control formData">
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-2 control-label">班组名称</label>
									<div class="col-lg-10">
										<input type="text" id="teamName" name="teamName"
											class="form-control formData">
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-offset-2 col-lg-10">
										<button type="button"
											class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"
											data-dismiss="modal">
											<strong>取消</strong>
										</button>
										<button type="button" onclick="saveForm();" id="saveButton"
											class=" pull-right btn m-b-xs w-xs   btn-info">
											<strong>保 存</strong>
										</button>
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
