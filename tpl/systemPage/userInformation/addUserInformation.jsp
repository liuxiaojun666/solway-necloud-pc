<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script type="text/javascript">
	//表单验证
    jQuery.validator.formValid('#editForm');
	/*$(function() {
		$("#editForm").validate({
			rules : {
				userName:{
					required : true
				},
				realName:{
					required : true
				},
				roleId:{
					required : true
				},
				tel:{
					mobile : true
				},
				email:{
					email : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						hideModal("userInformationModal");
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"保存失败");
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
	});*/
	function saveForm(){
		$("#editForm").trigger("submit");
	}
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#userIdSys").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/AdminUser/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#userNameSys").val(msg.userName);
					$("#realNameSys").val(msg.realName);
					$("#isManagerSys").val(msg.isManager);
					$("#telSys").val(msg.tel);
					$("#emailSys").val(msg.email);
					$("#pstationid").val(msg.pstationid);
					$("#roleId").val(msg.roleId);
					$("#companyid").val(msg.companyid);
 					//getRole($("#roleIdS").val());


					if(msg.userId==1){
						$("#roledName_Div").hide();
						$("#roledName_adminDiv").show();
						$("#userType_Div").hide();
						$("#userType_adminDiv").show();
					}else{
						$("#roledName_Div").show();
						$("#roledName_adminDiv").hide();
						$("#userType_Div").show();
						$("#userType_adminDiv").hide();
					}
					var userType=msg.userType
			        var ridaolen=document.editForm.userType.length;
			        for(var i=0;i<ridaolen;i++){
			            if(userType==document.editForm.userType[i].value){
			                document.editForm.userType[i].checked=true
			            }
			        }
				 	getSelected(id);
				}
			});
		}else{
			getSelected(null);
		}
	}

	var getSelected;
	app.controller('addUserCtrl', ['$http', '$scope', function($http, $scope){
		 getSelected = $scope.getA = function(id){
			 $scope.companyd = {};
			 $scope.companyd.selected = {};
		    	$scope.company = null;

		    	 $scope.companyChange= function () {
			         $("#companyid").val(angular.copy($scope.companyd.selected.comId));
			         $scope.getStation();
				 }
				$http({method:"POST",url:"${ctx}/Company/selectAll.htm",params:{}})
				.success(function (result) {
			    	 $scope.company = result;
			    	 if($("#companyid").val() != null && $("#companyid").val() != "" ){
			    	 for(var i=0,len=$scope.company.length;i<len;i++){
		 					if($scope.company[i].comId==  $("#companyid").val()){
		 						$scope.companyd.selected= { comName: $scope.company[i].comName,comId:  $("#companyid").val()};
		 						$scope.companyChange();
		 					}
		 				}
			    	 } else if(result.length==1){
			    		 $scope.companyd.selected= { comName: $scope.company[0].comName,comId:  $scope.company[0].comId};
			    		 $scope.companyChange();
			    	 }
			    	 //$scope.getStation();
				});
			 //组织机构end===============================================================
			 //所属电站--------------------------start------------------------------------
			 $scope.stationd = {};
			 $scope.station = null;
			 $scope.getStation = function(){
					$http({method:"POST",url:"${ctx}/PowerStation/selectByParentId.htm",params:{companyid:$("#companyid").val()}})
					.success(function (result) {
				    	 $scope.station = result;
					     $scope.station.unshift({id:"",stationname:'请选择'});
				    	 if($("#pstationid").val() != null && $("#pstationid").val() != "" ){
					    	 for(var i=0,len=$scope.station.length;i<len;i++){
								if($scope.station[i].id==  $("#pstationid").val()){
									$scope.stationd.selected= { stationname: $scope.station[i].stationname,id:  $("#pstationid").val()};
								}
							}
				    	 } else if(result.length==2){
				    		 $scope.stationd.selected= { stationname: $scope.station[1].pstationname,id:  $scope.station[1].pstationid};
				    		 $("#pstationid").val($scope.station[1].id);
				    	 }
				    	 $scope.textChange= function () {
					         $("#pstationid").val($scope.stationd.selected.id);
						}
					});
			 }
			// $scope.getStation();
			 //所属电站-------------------------end------------------------------------
			 //角色类型-------------------------start--------------------------------
			$scope.roled = {};
		    $scope.role = null;
			$http({method:"POST",url:"${ctx}/Role/selectAll.htm",params:{}})
			.success(function (result) {
		    	 $scope.role = result;
		    	 if($("#roleId").val() != null && $("#roleId").val() != "" ){
			    	 for(var i=0,len=$scope.role.length;i<len;i++){
						if($scope.role[i].roleId==  $("#roleId").val()){
							$scope.roled.selected= { roleName: $scope.role[i].roleName,roleId:  $("#roleId").val()};
						}
					}
		    	 } else if(result.length==1){
		    		 $scope.roled.selected= { roleName: $scope.role[0].roleName,roleId:  $scope.role[0].roleId};
		    		 $("#roleId").val($scope.station[0].id);
		    	 }
		    	 $scope.roleChange= function () {
			         $("#roleId").val($scope.roled.selected.roleId);
				}
			});
			 //角色管理----------------------------end---------------------------------
		}
	}]);

	function getStation(parentId,stationcode){
		$("#pstationid").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/PowerStation/selectByParentId.htm",
			data:{"parentId":parentId},
			dataType : "json",
			async: false,
			success:function(msg){
				$("#pstationid").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].id+"'";
					if(stationcode!=null&&msg[i].id==stationcode){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].stationname+"</option>";
					$("#pstationid").append(op);
				}
			}
		});
	}
	function getRole(roleId){
		$("#roleId").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/Role/selectAll.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#roleId").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].roleId+"'";
					 if(roleId!=null&&msg[i].roleId==roleId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].roleName+"</option>";
					$("#roleId").append(op);
				}
			}
		});
	}
</script>
<div  ng-controller="addUserCtrl"  class="modal fade" id="userInformationModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">用户信息管理</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/AdminUser/updateData.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="userId" value="" id="userIdSys" class="formData"/>
          <input type="hidden" name="roleIdS" id="roleIdS" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>用户名</label>
              <div class="col-lg-3 pos-rlt">
              <input type="text" id="userNameSys" maxlength="60" name="userName" class="form-control formData valid-required">
              <div class="valid-error"></div>
              </div>
              <label class="col-lg-3 control-label"><i class="fa fa-asterisk text-required"/>真实姓名</label>
              <div class="col-lg-4 pos-rlt">
               <input type="text" id="realNameSys" maxlength="10" name="realName" class="form-control formData valid-required">
               <div class="valid-error"></div>
              </div>
            </div>
            <!-- <div class="form-group">
            <label class="col-lg-2 control-label">所属机构</label>
              <div class="col-lg-10">
	          	 <ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
	             <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
	             <ui-select-choices  repeat="item in company | filter: $select.search">
	              <div ng-bind-html="item.comName | highlight: $select.search"></div>
	             </ui-select-choices>
		         </ui-select>
					<input type="hidden" id="companyid" name="companyid" class="form-control formData">
              </div>
             </div>
            <div class="form-group">
            <label class="col-lg-2 control-label">所属电站</label>
              <div class="col-lg-10">
					<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname" >{{$select.selected.stationname}}</ui-select-match>
		            <ui-select-choices  repeat="item in station | filter: $select.search">
		              <div ng-bind-html="item.stationname | highlight: $select.search"></div>
		            </ui-select-choices>
		            </ui-select>
          	<input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
              </div>
             </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">管理员</label>
              <div class="col-lg-4">
				<select  id="isManagerSys" name="isManager" class="form-control formData">
				<option value="0">否</option>
				<option value="1">是</option>
				</select>
              </div>
            <label class="col-lg-2 control-label">角色</label>
              <div class="col-lg-4" id="roledName_Div">
 			<ui-select ng-model="roled.selected" theme="bootstrap" ng-change="roleChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="roled.selected.roleName" >{{$select.selected.roleName}}</ui-select-match>
		            <ui-select-choices  repeat="item in role | filter: $select.search">
		              <div ng-bind-html="item.roleName | highlight: $select.search"></div>
		            </ui-select-choices>
		        </ui-select>
          		<input type="hidden" id="roleId" name="roleId" class="form-control formData">
              </div> -->
<!--               <div class="col-lg-4" id="roledName_adminDiv" style="padding-top: 6px;"> -->
<!--  					系统管理员 -->
<!--               </div> -->
            </div>
            <!-- <div class="form-group">
            <label class="col-lg-2 control-label" >手机号码</label>
              <div class="col-lg-4 pos-rlt">
 					<input type="text" id="telSys" maxlength="11" placeholder="请输入11位手机号...." name="tel" class="form-control formData valid-tel">
 					<div class="valid-error"></div>
              </div>
              <label class="col-lg-2 control-label" >邮箱</label>
              <div class="col-lg-4 pos-rlt">
 					<input type="text" id="emailSys" maxlength="60" name="email" class="form-control formData valid-email">
 					<div class="valid-error"></div>
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">用户类型</label>
                <div class="col-lg-10" id="userType_Div">
           			 <label class="checkbox-inline i-checks">
           			 <input type="radio" name="userType"  id="userType0" value="1"  class="form-control" >  <i></i> 个人会员
	           		 </label>
	           		 <label class="checkbox-inline i-checks">
           			 <input type="radio" name="userType"  id="userType1" value="2"  class="form-control ">  <i></i> 企业会员
	           		 </label>
	              </div> -->
<!-- 	              <div class="col-lg-10" id="userType_adminDiv" style="padding-top: 6px;"> -->
<!--            			 管理用户 -->
<!-- 	              </div> -->
            </div>

	<div class="form-group">
		<div class="col-lg-offset-2 col-lg-10">
			<button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal" onclick="$('#editForm').validate().resetForm();"><strong>取消</strong></button>
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
