<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> -->
<script src="/theme/js/controllers/file-upload.js" type="text/javascript"></script>
    <script type="text/javascript">
	$(function() {
		$("#editFormForUserMod").validate( {
			rules : {
				userName:{
					required : true,
				},
				realName:{
					required : true,
				},
				/* isManager:{
					required : true
				},
				userType:{
					required : true
				}, */
				tel:{
					mobile : true
				},
				email:{
					email : true
				}
				/* companyid:{
					required : true
				},
				pstationid:{
					//required : true
				},
				roleId:{
					required : true
				} */
			},
			submitHandler : function(form) {
				updateUserInfo();
			}
		});
	});
	function hideModal(modalId){
		$('#'+modalId).modal('hide');
	}
	function saveFormForUserMod(){
		/* $("#isManager").removeAttr("disabled");
		$("#isManager").removeAttr("disabled");
		$("#isManager").removeAttr("disabled");
		$("#isManager").removeAttr("disabled"); */
		$("#editFormForUserMod").trigger("submit");
	}
	//初始化页面数据
	function initPageDataUserMod(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#userId").val(id);
			 $.ajax({
				type:"post",
				url:"/NECloud/Login/getLoginUser.htm",
				data:{"id":id},
				success:function(msg){
					$("#userName").val(msg.userName);
					$("#realName").val(msg.realName);
					$("#isManager").val(msg.isManager);
					$("#userType").val(msg.userType);
					$("#tel").val(msg.tel);
					$("#emailForModLogin").val(msg.email);
					$("#pstationid").val(msg.pstationid);
					$("#roleId").val(msg.roleId);
					$("#companyid").val(msg.companyid);
					$("#companyName").val(msg.companyName);
					$("#pstationNameForMod").val(msg.pstationName);
					if(msg.isManager==1){				 	
					$("#isManager").val("是");
			 		}else{
			 			$("#isManager").val("否");
			 		}
					if(msg.userType==1){				 	
						$("#userType").val("个人会员");
				 		}else if(msg.userType==2){
				 			$("#userType").val("企业会员");
				 		}
				}
			});
		}else{
			
		}
		
	}
	var updateUserInfo;
	app.controller('UpdateUserInfoCtrl', ['$scope', 'toaster','$http', function($scope, toaster,$http) {
	    updateUserInfo = $scope.saveFormForUserMod = function(){
	    	$http({
				method : "POST",
				url : "/NECloud/AdminUser/updateDataSelective.htm",
				params : {"userId" : $("#userId").val(),
				realName:$("#realName").val(),
				email:$("#emailForModLogin").val(),
				tel:$("#tel").val()}
			}).success(function(result) {
				toaster.pop('success', '', '个人信息修改成功，将在重新登陆后生效!');
				hideModal("userInformationUpdateModel");
			}).error(function(){
				toaster.pop('error', '', '个人信息修改失败!');
			});
		}
	}]);
</script>
<div ng-controller="UpdateUserInfoCtrl" class="modal fade" id="userInformationUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <h3 class="m-t-none m-b font-thin" >修改个人信息</h3>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="/NECloud/AdminUser/updateDataSelective.htm" method="post" id="editFormForUserMod" name="editFormForUserMod">
          <input type="hidden" name="userId" value="" id="userId" class="formData"/>
          <input type="hidden" name="roleIdS" id="roleIdS" class="formData"/>
            <!-- <div class="form-group">
            <label class="col-lg-2 control-label">所属机构</label>
              <div class="col-lg-10">
					<input readonly="readonly" id="companyName" class="form-control formData"> 
              </div>
             </div>
            <div class="form-group">
            <label class="col-lg-2 control-label">所属电站</label>
              <div class="col-lg-10">
          		 <input readonly="readonly" id="pstationNameForMod" class="form-control formData" > 
              </div>
             </div>  -->
          <div class="form-group">
              <label class="col-lg-2 control-label">用户名</label>
              <div class="col-lg-4">
              <input type="text" readonly="readonly" id="userName" name="userName" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">真实姓名</label>
              <div class="col-lg-4">
               <input type="text" id="realName" name="realName" class="form-control formData">
              </div>
            </div>
          <div class="form-group">      
               <label class="col-lg-2 control-label">手机号码</label>
              <div class="col-lg-4">
 					<input type="text" id="tel" name="tel" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">邮箱</label>
              <div class="col-lg-4">
 					<input type="text" id="emailForModLogin" name="email" class="form-control formData">
              </div>
            </div>
             <div class="form-group" hidden="hidden">
              <label class="col-lg-2 control-label">管理员</label>
              <div class="col-lg-4">
              <input readonly="readonly" id="isManager" class="form-control formData" >
              </div>
              <label class="col-lg-2 control-label">用户类型</label>
                <div class="col-lg-4" id="userType_Div">
          			<input readonly="readonly"  id="userType" class="form-control formData"> 
           			 
	              </div>
            </div>
            
             <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">   
                <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                 <button type="button" onclick="saveFormForUserMod();" id="saveUserInformationButton" class="pull-right btn m-b-xs w-xs btn-info"><strong>保 存</strong></button>
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
