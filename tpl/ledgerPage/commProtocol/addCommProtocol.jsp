<div ng-controller="AddCommProtocolCtrl">
	<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/CommProtocol/update.htm" method="post" id="editForm" name="editForm">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h4 blue-1 m-n text-black">通讯规约管理</span>
	</div>
	<div class="wrapper-md ng-scope">
 	<div class="col-sm-12 wrapper panel">
 	<input type="hidden" id="id" name="id">
	            <div class="form-group col-sm-12" >
            	<label class="col-sm-1  control-label ">名称</label>
                	<div class="col-lg-4">
                		<input type="text" id="name" name="name" maxlength="50" class="form-control formData">
              		</div>
              	<label class="col-lg-1 control-label ">版本号</label>
              		<div class="col-lg-4">
                		<input type="text" id="version" name="version" maxlength="20" class="form-control formData">
              	</div>
	          </div>
	          <div class="form-group col-sm-12">
              <label class="col-lg-1 control-label">描述</label>
              <div class="col-lg-9">
                <textarea id="descp" name="descp" maxlength="300" class="form-control formData"></textarea>
              </div>
            </div>
	</div>
</div>	
	
	<div class="wrapper-md ng-scope">
		<div class="col-sm-12 wrapper panel">
			<div class="form-group col-sm-12">
  			  	<span class="font-h4 blue-1 m-n text-black"> 库文件</span>
  			 </div>
  			 <div class="form-group col-sm-12">
	  			  <label class="col-sm-1 control-label">Linux</label>
	  			  <div class="col-sm-2">
				      <input type="text" readonly="readonly" id="liblinux" name="liblinux" class="form-control formData">
				  </div>
			      <div class="col-sm-2">
				      <input type="file" id="file0" name="file0">
			      </div>
				  
				  <label class="col-sm-1 control-label">Linux嵌入</label>
				  <div class="col-sm-2">
				      <input type="text" readonly="readonly" id="libem" name="libem" class="form-control formData">
				  </div>
				  <div class="col-sm-2">
				       <input type="file" id="file1" name="file1">
				  </div>
  			 </div>
  			 
  			 <div class="form-group col-sm-12">
  			 	<label class="col-sm-1 control-label">Windows</label>
				  <div class="col-sm-2">
				      <input type="text" readonly="readonly" id="libwin" name="libwin" class="form-control formData">
				  </div>
			  	  <div class="col-sm-2">
			  		  <input type="file" id="file2" name="file2">
			  	  </div>
  			 </div>
		</div>
	</div>
		    <div class="form-group m-t-sm">
							<div class="col-lg-12 text-center">
								<button type="button" onclick="saveForm();" id="saveButton"
									class="  btn m-b-xs w-xs   btn-info">
									<strong>保 存</strong>
								</button>
								<button id="cancelBtn" type="button"
									class=" m-l-sm  btn m-b-xs w-xs btn-default"
									 ng-click="goCommProtocol();">
									<strong>取消</strong>
								</button>
							</div>
						</div>
 </form>
 </div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

$(function() {
	$("#editForm").validate( {
		rules : {
			name:{
				required : true,
				maxlength : 50
			},
			version:{
				required : true,
				maxlength : 30
			},
			descp:{
				maxlength : 300
			}
			
		},
		submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(json) {
					promptObj(json.type,'',json.message);
					$("#cancelBtn").trigger("click");
				},
				error : function(json) {
					promptObj('error','',json.message);
					$("#errorFlag").trigger('click');
				}
			};
			$('#editForm').ajaxSubmit(options);
		}
	});
	
});
var tr = null;
function saveForm(){
	
	if($("#file2").val()==""){
		$("#file2").attr("disabled","disabled");
	}
	if($("#file1").val()==""){
		$("#file1").attr("disabled","disabled");
	}
	if($("#file0").val()==""){
		$("#file0").attr("disabled","disabled");
	}
	$("#editForm").trigger("submit");
}
//初始化页面数据
function initPageData(id){
	$(".formData").val("");
	if(id != "" && id != null){
		 $("#id").val(id);
		 $.ajax({
			type:"post",
			url:"${ctx}/CommProtocol/selectById.htm",
			data:{"id":id},
			success:function(msg){
				$("#name").val(msg.name);
				$("#version").val(msg.version);
				$("#descp").val(msg.descp);
				$("#liblinux").val(msg.liblinux);
				$("#libem").val(msg.libem);
				$("#libwin").val(msg.libwin);
			}
		});
	}else{
	}	
}
app.controller('AddCommProtocolCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', 
                                   function($http,$location,$rootScope,$scope,$state,$stateParams){
	
	//返回List
	$scope.goCommProtocol=function(){
		$state.go('app.commProtocol');
	}
		
	initPageData($stateParams.InId);
}]);

</script>
