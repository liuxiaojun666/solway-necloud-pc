<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">      
	$(function() {
		$("#editForm").validate( {
			rules : {
				productid:{
					required : true
				},
				faultcode:{
					required : true,
					maxlength : 50,
					remote:{
			               type:"POST",
			               url:"${ctx}/PFaultCode/parentVerify.htm",
			               data:{
			            	   id:function(){return $("#id").val();},
			            	   productid:function(){return $("#productid").val();},
			            	   faultcodeindex:function(){return $("#faultcodeindex").val();},
			            	   faultcode:function(){return $("#faultcode").val();}
			               } 
			        }
				},
				faultdesc:{
					required : true,
					maxlength :50
				},
				standardoper:{
					maxlength : 300
				},
				fclasscodeStr:{
					maxlength : 50
				},
				faultlevelStr:{
					maxlength : 50
				},
				descp:{
					maxlength : 300
				},
				faultcodeindex:{
					required : true,
					number : true
				}
			},messages: {
				faultcode:{remote:'<img width="16" height="16" src="${ctx}/theme/images/validator/check_n.gif">产品型号、索引位置、故障码需唯一!'}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
	});

	var getSelected;
	app.controller('AddFaultCodeCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams',
	                                       function($http, $location, $rootScope, $scope, $state, $stateParams){

		getSelected = $scope.getA = function(id){
			 //产品型号--------------------------start------------------------------------
			$scope.productd = {};
		 	$scope.product = null;
		 	
			$http({method:"POST",url:"${ctx}/Product/selectAll.htm",
				params:{}})
		    .success(function (result) {
	    	 $scope.product = result;
	    	 if(productid != null && productid != "" ){
		    	 for(var i=0,len=$scope.product.length;i<len;i++){
					if($scope.product[i].id==  $("#productid").val()){
						$scope.productd.selected= { productname: $scope.product[i].productname,id:  $("#productid").val(),specification:$scope.product[i].specification};
					}
				}
	    	 }
	    	 $scope.productChange = function () {
			      $("#productid").val(angular.copy($scope.productd.selected.id) );
			      $("#productname").val(angular.copy($scope.productd.selected.productname) );
	         }
			});
		}
		initPageData($stateParams.id);  
		$scope.backFaultCodeList = function(){
			$state.go('app.faultCode');
		}
	}]);
	function saveForm(){
		$("#editForm").trigger("submit");
	}
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/PFaultCode/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#productid").val(msg.productid);
					$("#productname").val(msg.productname);
					$("#faultcodeindex").val(msg.faultcodeindex);
					$("#faultcode").val(msg.faultcode);
					$("#faultdesc").val(msg.faultdesc);
					$("#standardoper").val(msg.standardoper);
					$("#descp").val(msg.descp);
					$("#protocolid").val(msg.protocolid);
// 					getProduct("productid",msg.productid);
					getFaulType(msg.fclasscode);
					getFaultLevel(msg.faultlevel);
					
				}
			});
			 getSelected(id);
		} else {
// 			getProduct("productid");
			getFaulType();
			getFaultLevel();
			getSelected(null);
		}
	}
	function getProduct(domId,pId){
		$("#"+domId).empty();
		$.ajax({
			type:"post",
			url:"${ctx}/Product/selectAll.htm",
			//data:{"treeLevel":level,"parentId":parentId},
			dataType : "json",
			async: false,
			success:function(msg){
				$("#"+domId).append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].id+"'";
					if(pId!=null&&msg[i].id==pId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].productname+"-"+msg[i].specification+"D大调</option>";
					$("#"+domId).append(op);
				}
			}
		});
	}
	
	function getFaultLevel(dictId){
		$("#faultlevel").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/PFaultCode/getFaultLevel.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#faultlevel").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					for(var i=0,len=msg.length;i<len;i++){
						var op="<option value='"+msg[i].id+"'";
						if(dictId!=null&&msg[i].id==dictId){
							op+=" selected='selected' ";
						}
						op+=">"+msg[i].dictName+"</option>";
						$("#faultlevel").append(op);
					}
				}
				//var op='<option value="-1">自定义</option>'
				//$("#faultlevel").append(op);
			}
		});
	}
	function getFaulType(dictId){
		$("#fclasscode").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/PFaultCode/getFaulType.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#fclasscode").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					for(var i=0,len=msg.length;i<len;i++){
						var op='<option value="'+msg[i].id+'"';
						if(dictId!=null&&msg[i].id==dictId){
							op+=' selected="selected" ';
						}
						op+=">"+msg[i].dictName+"</option>";
						$("#fclasscode").append(op);
					}
				}
					var op='<option value="-1">自定义</option>'
					$("#fclasscode").append(op);
			}
		});
	}
	function faultTypeChange(){
		if($("#fclasscode").val()==-1){
			$("#hideStrDiv").show();
			$("#fclasscodeStrDiv").show();
			$("#typeLevelDiv").hide();
		}else{
			$("#fclasscodeStrDiv").hide();
			if($("#faultlevel").val()!=-1){
				$("#hideStrDiv").hide();
			}else{
				$("#typeLevelDiv").show();
			}
		}
	}
	function faultLevelChange(){
		if($("#faultlevel").val()==-1){
			if($("#fclasscode").val()!=-1){
				$("#typeLevelDiv").show();
			}
			$("#hideStrDiv").show();
			$("#faultlevelStrDiv").show();
		}else{
			$("#faultlevelStrDiv").hide();
			if($("#fclasscode").val()!=-1){
				$("#hideStrDiv").hide();
			}
		}
	}
	
</script>
<div ng-controller="AddFaultCodeCtrl">
<div class="wrapper-md bg-light">
		<span class="font-h3 m-n font-thin h3">状态码管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PFaultCode/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <input type="hidden" name="protocolid" value="" id="protocolid" class="formData"/>
          <div class="form-group">
               <label class="col-lg-2 control-label">产品型号</label>
              <div class="col-lg-3">
               <ui-select  ng-model="productd.selected" theme="bootstrap" ng-change="productChange()">
				<ui-select-match placeholder="请输入关键字..." ng-model="productd.selected.productname" >{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
			    <ui-select-choices repeat="item in product | filter: $select.search">
			    <div ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
			    </ui-select-choices>
				</ui-select>
				 <input type="hidden" id="productname" name="productname" class="form-control formData"/>
             	<input type="hidden" name ="productid" id="productid" class="form-control formData"/>
              </div>
           </div>
          <div class="form-group">
          	 <label class="col-lg-2 control-label ">索引位置</label>
              <div class="col-lg-3">
                <input type="text" id="faultcodeindex" maxlength="6" name="faultcodeindex" class="form-control formData">
              </div>
              
              <label class="col-lg-2 control-label">状态码值</label>
              <div class="col-lg-3">
                <input type="text" id="faultcode" maxlength="50" name="faultcode" class="form-control formData">
              </div>
            </div>
           <div class="form-group">
          	 <label class="col-lg-2 control-label">故障分类</label>
              <div class="col-lg-3">
	              <select id="fclasscode" name="fclasscode" class="form-control formData" onchange="faultTypeChange();">
             	</select>
              </div>
              
           	<label class="col-lg-2 control-label">故障级别</label>
              <div class="col-lg-3">
              	<select id="faultlevel" name="faultlevel" class="form-control formData" onchange="faultLevelChange();">
             	</select>
              </div>
            </div> 
            <div class="form-group editTitle" id="hideStrDiv">
            <label class="col-lg-2 control-label"></label>
              <div class="col-lg-3 editTitle" id="fclasscodeStrDiv">
	              <input type="text" id="fclasscodeStr" name="fclasscodeStr" class="form-control formData"  placeholder="请输入自定义故障分类 "/>
              </div>
              <div class="col-lg-3 editTitle" id="typeLevelDiv">
              </div>
              <label class="col-lg-2 control-label"></label>
              <div class="col-lg-3 editTitle" id="faultlevelStrDiv">
	              <input type="text" id="faultlevelStr" name="faultlevelStr" class="form-control formData" placeholder="请输入自定义故障级别"/>
              </div>
            </div>
          <div class="form-group">
              <label class="col-lg-2 control-label">状态描述</label>
              <div class="col-lg-8">
                <input type="text" id="faultdesc" maxlength="300" name="faultdesc" class="form-control formData">
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">维修建议</label>
              <div class="col-lg-8">
                <textarea id="standardoper" maxlength="300" name="standardoper" class="form-control formData"></textarea>
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">其它介绍</label>
              <div class="col-lg-8">
                <textarea id="descp" name="descp" maxlength="300" class="form-control formData"></textarea>
              </div>
            </div>
             <div class="form-group">
            <div class="col-lg-offset-2 col-lg-8">   
                <button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="backFaultCodeList();"><strong>取消</strong></button>
                 <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 </div>
   			 </div>
          </form>
        </div>
    </div>
    </div>
    </div>
