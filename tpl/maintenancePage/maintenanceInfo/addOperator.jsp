<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 添加班组信息 -->
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>

<script type="text/javascript">
	//初始化页面数据
	function initPageData(id){
		//清空数据
		$(".formData").val(""); 
	}
	
	$(function() {
		//验证信息
		$("#operatorForm").validate({
			rules : {
				realName : {
					required : true,
					maxlength : 20
				}, 
				tel : {
					//required : true,
					mobile : true
				},
				entrytime : {
					required : true
				},
				isteamleader : {
					required : true
				},
				tel : {
					required : true,
					maxlength : 20
				},
				major : {
					required : true,
					maxlength : 50
				},
				skills : {
					required : true,
					maxlength : 50
				},
				remarks : {
					maxlength : 200
				}	
			},

			//提交信息
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success', '', "保存成功");
						hideModal("opOperatorModal");
						refreshList();
					},
					error : function(json) {
						promptObj('error', '', "保存失败,请稍后重试!");
						$("#errorFlag").trigger('click');
					}
				};
				$('#operatorForm').ajaxSubmit(options);
			}
		});
	});
	
	//保存
	function saveOperator() {
		$("#operatorForm").trigger("submit");
	}

	//刷新列表
	function refreshList(){
		var appElement = document.querySelector('[ng-controller=MaintenanceCtr]');
		var $scope = angular.element(appElement).scope();
		$scope.loadOperatorInfo(opTeamId);	
	}
	
	//同时注册用户
	function registerUser(value){
		if(value){
			$("#registerDiv").slideDown("slow");
		}else{
			$("#registerDiv").slideUp("slow");
		}
	}

  	app.controller('OperatorCtrl', ['$http', '$scope', function($http, $scope){
 		$scope.opTeamId = opTeamId;
	}]);  
	
</script>
<div  ng-controller="OperatorCtrl" class="modal fade" id="opOperatorModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog row">
		<div class="modal-content ">
			<div class="modal-body wrapper-lg">
				<div class="row">
					<div class="col-sm-12">
						<h3 class="m-t-none m-b font-thin" id="myModalLabel1">运维人员信息管理</h3>
						<div class="panel-body">
							<form class="bs-example form-horizontal ng-pristine ng-valid"
								action="${ctx}/opOperator/update.htm" method="post"
								id="operatorForm" name="operatorForm">
								<input type="hidden" name="id" value=""  class="formData" />
								<input type="hidden" name="opTeamId" id="opTeamId" value="{{opTeamId}}" />
								<input type="hidden" name="userName" id="userName" value="{{tel}}"/>
								<input type="hidden" name="password" id="password" value="{{tel.substr(5,6)}}"/>
								
								<div class="form-group">
									<label class="col-lg-2 control-label">姓名</label>
									<div class="col-lg-4">
										<input type="text" id="realName" name="realName"
											class="form-control formData">
									</div>
									
									<label class="col-lg-2 control-label">手机号</label>
									<div class="col-lg-4">
										<input type="text" ng-model="tel" id="tel" name="tel" class="form-control formData">
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-lg-2 control-label">入职时间</label>
									<div class="col-lg-4">
									    <input  type="date" id="entrytime" name="entrytime" class="form-control formData" >
									</div>
									
									<label class="col-lg-2 control-label">是否班长</label>
									<div class="col-lg-4">
				 					<select  id="isteamleader" name="isteamleader" class="form-control">
					 					<option value="0">否</option>
					 					<option value="1">是</option>
				 					</select>
									</div>
								</div>
						
								<div class="form-group">
									<label class="col-lg-2 control-label">专业名称</label>
									<div class="col-lg-4">
										<input type="text" id="major" name="major"
											class="form-control formData">
									</div>
									<label class="col-lg-2 control-label">特长</label>
									<div class="col-lg-4">
										<input type="text" id="skills" name="skills"
											class="form-control formData">
									</div>
								</div>		
					            <div class="form-group">
					                 <label class="col-lg-2 control-label">备注</label>
						             <div class="col-lg-10">
						           		 <textarea rows="2"  id="remarks" name="remarks" class="form-control formData"></textarea>
						             </div>
						         </div>	
						         
						         <div class="form-group">
					                 <label class="col-lg-3 control-label">是否创建账号</label>
						             <div class="col-lg-8">
						           		<label class="i-checks m-b-none"> 
											<input name="isRegister" type="checkbox" onclick="registerUser(this.checked);"/> <i></i>
										</label> 
						             </div>
						         </div>	
						        </div>
						        
						     	<!-- 注册用户控件 （隐藏层） -->
						         <div id="registerDiv" class="hideSearchDiv">
						         	<div class="form-group">
										<label class="col-lg-12 control-label">用户名默认为手机号，密码为手机号后六位！</label>
									</div>
								</div>	

								<div class="form-group">
									<div class="col-lg-offset-2 col-lg-10">
										<button type="button"
											class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"
											data-dismiss="modal">
											<strong>取消</strong>
										</button>
										<button type="button" onclick="saveOperator();" id="saveButton"
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
