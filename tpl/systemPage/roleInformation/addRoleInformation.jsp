<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">      
	$(function() {
		$("#editForm3").validate( {
			rules : {
				roleCode:{
					required : true,
				},
				roleName:{
					required : true,
				},
				companyid:{
					required : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
// 						alert(json.message);
						hideModal("roleInformationModal");
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"操作失败，请稍后重试");
					}
				};
				$('#editForm3').ajaxSubmit(options);
			}
		});
	});
	function saveForm(){
		$("#editForm3").trigger("submit");
		
	}
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
// 		getCompany();
// 		geParentRole("");
		if(id != "" && id != null){
			 $("#roleId").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Role/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#roleCode").val(msg.roleCode);
					$("#roleName").val(msg.roleName);
					$("#companyid3").val(msg.companyid);
					$("#parentRoleId").val(msg.parentRoleId);
					$("#remark").val(msg.remark);
			 		getSelected(id);
				}
			});
		}else{
			getSelected(null);
		}	
	}
	
	
	var getSelected;
	app.controller('addRoleCtrl', ['$http',  '$scope',  function($http,$scope){
		getSelected = $scope.getA = function(id){
			$scope.companyd = {};
	    	$scope.company = null;
			$http({method:"POST",url:"${ctx}/Company/selectAll.htm",params:{}})
			.success(function (result) {
		    	 $scope.company = result;
		    	 for(var i=0,len=$scope.company.length;i<len;i++){
	 					if($scope.company[i].comId==  $("#companyid3").val()){
	 						$scope.companyd.selected= { comName: $scope.company[i].comName,comId:  $("#companyid3").val()};
	 					}
	 				}
		    	 $scope.companyChange= function () {
			         $("#companyid3").val(angular.copy($scope.companyd.selected.comId));
				} 
			}); 
// 	组织机构end===============================================================
			$scope.parentRoled = {};
	    	$scope.parentRole = null;
			$http({method:"POST",url:"${ctx}/Role/selectAll.htm",params:{"roleId":id}})
			.success(function (result) {
		    	 $scope.parentRole = result;
		    	 for(var i=0,len=$scope.parentRole.length;i<len;i++){
	 					if($scope.parentRole[i].roleId==  $("#parentRoleId").val()){
	 						$scope.parentRoled.selected= { roleName: $scope.parentRole[i].roleName,roleId:  $("#parentRoleId").val()};
	 					}
	 				}
		    	 $scope.parentRoleChange= function () {
			         $("#parentRoleId").val(angular.copy($scope.parentRoled.selected.roleId));
				} 
			}); 
		}
	}]);	
</script>
<div ng-controller="addRoleCtrl"     class="modal fade" id="roleInformationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">角色信息管理</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Role/updateData.htm" method="post" id="editForm3" name="editForm3">
          <input type="hidden" name="roleId" value="" id="roleId" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">角色编码</label>
              <div class="col-lg-4">
              <input type="text" id="roleCode" maxlength="50" name="roleCode" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">角色名称</label>
              <div class="col-lg-4">
               <input type="text" id="roleName" name="roleName" maxlength="20" class="form-control formData">
              </div>
            </div>
            <div class="form-group">
            <label class="col-lg-2 control-label">所属机构</label>
              <div class="col-lg-4">
	          	 <ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
	             <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
	             <ui-select-choices  repeat="item in company | filter: $select.search">
	              <div ng-bind-html="item.comName | highlight: $select.search"></div>
	             </ui-select-choices>
		         </ui-select>
                 <input type="hidden" id="companyid3" name="companyid" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">父角色</label>
              <div class="col-lg-4">
<!--  					<select  id="parentRoleId" name="parentRoleId" class="form-control formData"> -->
<!--  					</select> -->
				<input type="hidden" id="parentRoleId" name="parentRoleId" class="form-control formData">
	          	<ui-select ng-model="parentRoled.selected" theme="bootstrap" ng-change="parentRoleChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="parentRoled.selected.roleName" >{{$select.selected.roleName}}</ui-select-match>
	            <ui-select-choices  repeat="item in parentRole | filter: $select.search">
	            <div ng-bind-html="item.roleName | highlight: $select.search"></div>
	            </ui-select-choices>
		         </ui-select>
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">备注</label>
                 <div class="col-lg-4">
                 <textarea rows="4" cols="55" maxlength="300" id="remark" name="remark" class="formData"></textarea>
              </div>
            </div>
            <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">   
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
