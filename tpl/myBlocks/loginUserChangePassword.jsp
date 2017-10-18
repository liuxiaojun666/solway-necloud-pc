<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<script type="text/javascript">
function submitUserPasswordChangeModelForm(){
	$("#userPasswordChangeModel_Fail").hide();
	var password=$.trim($("#newpwd").val());
	var confirmPassword=$.trim($("#newpwdconfirm").val());
	if(null==password||password=="") {
		$("#userPasswordChangeModel_Fail").html("密码不能为空");
		$("#userPasswordChangeModel_Fail").show();
		return false;
	}
	if(null==confirmPassword||confirmPassword=="") {
		$("#userPasswordChangeModel_Fail").html("确认密码不能为空");
		$("#userPasswordChangeModel_Fail").show();
		return false;
	}
	if(password.length<6) {
		$("#userPasswordChangeModel_Fail").html("密码过短");
		$("#userPasswordChangeModel_Fail").show();
		return false;
	}
	if(confirmPassword.length<6) {
		$("#userPasswordChangeModel_Fail").html("确认密码过短");
		$("#userPasswordChangeModel_Fail").show();
		return false;
	}
	if(confirmPassword!=password) {
		$("#userPasswordChangeModel_Fail").html("两次输入的密码不一致");
		$("#userPasswordChangeModel_Fail").show();
		return false;
	}
	$.ajax({
		type:"post",
		url:"/NECloud/AdminUser/userPasswordChangeModel.htm",
		data:{
			"userId":$.trim($("#userId").val()),
			"oldpwd":$.trim($("#oldpwd").val()),
			"newpwd":password
		},
		success:function(msg){
			if(msg){
				promptObj('success', '','密码修改成功!');
				$("#userPasswordChangeModel").modal('hide');
				$("#oldpwd").val("");
				$("#newpwd").val("");
				$("#newpwdconfirm").val(null);
			}else{
				$("#userPasswordChangeModel_Fail").html("密码修改失败!");		
				$("#userPasswordChangeModel_Fail").show();
			}
		}
	});
}
app.controller('UpdateUserPwdCtrl', ['$scope', 'toaster','$http', function($scope, toaster,$http) {
	$scope.submitUserPasswordChangeModelForm = function(){
		$("#userPasswordChangeModel_Fail").hide();
		var password=$.trim($("#newpwd").val());
		var confirmPassword=$.trim($("#newpwdconfirm").val());
		if(null==password||password=="") {
			$("#userPasswordChangeModel_Fail").html("密码不能为空");
			$("#userPasswordChangeModel_Fail").show();
			return false;
		}
		if(null==confirmPassword||confirmPassword=="") {
			$("#userPasswordChangeModel_Fail").html("确认密码不能为空");
			$("#userPasswordChangeModel_Fail").show();
			return false;
		}
		if(password.length<6) {
			$("#userPasswordChangeModel_Fail").html("密码过短");
			$("#userPasswordChangeModel_Fail").show();
			return false;
		}
		if(confirmPassword.length<6) {
			$("#userPasswordChangeModel_Fail").html("确认密码过短");
			$("#userPasswordChangeModel_Fail").show();
			return false;
		}
		if(confirmPassword!=password) {
			$("#userPasswordChangeModel_Fail").html("两次输入的密码不一致");
			$("#userPasswordChangeModel_Fail").show();
			return false;
		}
    	$http({
			method : "POST",
			url : "/NECloud/AdminUser/userPasswordChangeModel.htm",
			params : {
				"userId":$.trim($("#userId").val()),
				"oldpwd":$.trim($("#oldpwd").val()),
				"newpwd":password
			}
		}).success(function(msg) {
			if(msg){
				toaster.pop('success', '','密码修改成功!');
				$("#userPasswordChangeModel").modal('hide');
				$("#oldpwd").val("");
				$("#newpwd").val("");
				$("#newpwdconfirm").val(null);
			}else{
				$("#userPasswordChangeModel_Fail").html("密码修改失败!");		
				$("#userPasswordChangeModel_Fail").show();
			}
		}).error(function(){
			//toaster.pop('error', '', '密码修改失败!');
		});
	}
}]);
</script>
<div ng-controller="UpdateUserPwdCtrl" class="modal fade" id="userPasswordChangeModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog row">
<div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
<div class="col-sm-12">

	<h3 class="m-t-none m-b font-thin" id="myModalLabel">用户密码修改</h3>
	<div class="panel-body">
	<form class="bs-example form-horizontal ng-pristine ng-valid" id="userPasswordChangeModelForm" name="userPasswordChangeModelForm">
		<input type="hidden" name="userId" value="" id="userId" class="formData"/>
		<div class="form-group">
			<label class="col-lg-3 control-label">旧密码</label>
			<div class="col-lg-8">
				<input autocomplete="off" type="password" id="oldpwd" name="oldpwd" class="form-control formData">
			</div>
		</div>	
		<div class="form-group">
			<label class="col-lg-3 control-label">新密码</label>
			<div class="col-lg-8">
				<input autocomplete="off" type="password" id="newpwd" name="newpwd" class="form-control formData" placeholder="长度至少6位">
			</div>
		</div>
		<div class="form-group">
			<label class="col-lg-3 control-label">确认密码</label>
			<div class="col-lg-8">
				<input autocomplete="off" type="password" id="newpwdconfirm" name="newpwdconfirm" class="form-control formData" placeholder="长度至少6位">
			</div>
		</div>
		<div class="form-group">
			<div class="col-lg-offset-2 col-lg-10"> 
				<button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取 消</strong></button>
				<button type="button" ng-click="submitUserPasswordChangeModelForm();" id="changePasswordButton" class=" pull-right btn m-b-xs w-xs btn-info"><strong>修 改</strong></button>
			</div>
		</div>
	</form>
	</div>
	<div class="alert alert-danger text-center" hidden="hidden" id="userPasswordChangeModel_Fail">密码修改失败</div>

</div>
</div>
</div>
</div>
</div>
</div>
