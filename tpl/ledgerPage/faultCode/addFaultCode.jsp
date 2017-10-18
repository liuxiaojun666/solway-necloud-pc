<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">      
	$(function() {
		$("#editForm").validate( {
			rules : {
				productid:{
					required : true
				},
				productname:{
					required : true
				},
				faultcode:{
					required : true,
					maxlength : 50
				},
				faultdesc:{
					required : true,
					maxlength :50
				},
				standardoper:{
					maxlength : 300
				},
				descp:{
					maxlength : 300
				},
				faultcodeindex:{
					number : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
// 						alert(json.message);
						promptObj('success','',json.message);
						hideModal("faultCodeModal");
						//$('#productacturerModal').modal('hide');
						goPage(0);
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
					$("#faultcode").val(msg.faultcode);
					$("#faultdesc").val(msg.faultdesc);
					$("#standardoper").val(msg.standardoper);
					$("#descp").val(msg.descp);
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
					op+=">"+msg[i].productname+"</option>";
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
						var op="<option value='"+msg[i].id+"'";
						if(dictId!=null&&msg[i].id==dictId){
							op+=" selected='selected' ";
						}
						op+=">"+msg[i].dictName+"</option>";
						$("#fclasscode").append(op);
					}
				}
			}
		});
	}
	
	var getSelected;
	app.controller('addProductCtrl', ['$http',  '$scope',  function($http,$scope){
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
						$scope.productd.selected= { productname: $scope.product[i].productname,id:  $("#productid").val()};
					}
				}
	    	 }
	    	 $scope.productChange = function () {
			      $("#productid").val(angular.copy($scope.productd.selected.id) );
			      $("#productname").val(angular.copy($scope.productd.selected.productname) );
	             }
			});
		}
	}]);
	
</script>
<div   ng-controller="addProductCtrl"  class="modal fade" id="faultCodeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <h3 class="m-t-none m-b font-thin" id="myModalLabel">状态码管理</h3>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PFaultCode/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <div class="form-group">
               <label class="col-lg-2 control-label">产品型号</label>
              <div class="col-lg-4">
               <ui-select  ng-model="productd.selected" theme="bootstrap" ng-change="productChange()">
				<ui-select-match placeholder="请输入关键字..." ng-model="productd.selected.productname" >{{$select.selected.productname}}</ui-select-match>
			    <ui-select-choices repeat="item in product | filter: $select.search">
			    <div ng-bind-html="item.productname | highlight: $select.search"></div>
			    </ui-select-choices>
				</ui-select>
				 <input type="hidden" id="productname" name="productname" class="form-control formData"/>
             	<input type="hidden" name ="productid" id="productid" class="form-control formData"/>
              </div>
           </div>
          <div class="form-group">
          	 <label class="col-lg-2 control-label">索引位置</label>
              <div class="col-lg-4">
                <input type="text" id="faultcodeindex" name="faultcodeindex" maxlength="6" class="form-control formData">
              </div>
              
              <label class="col-lg-2 control-label">状态码值</label>
              <div class="col-lg-4">
                <input type="text" id="faultcode" name="faultcode" maxlength="30" class="form-control formData">
              </div>
            </div>
           <div class="form-group">
          	 <label class="col-lg-2 control-label">故障分类</label>
              <div class="col-lg-4">
	              <select id="fclasscode" name="fclasscode" class="form-control formData">
             	</select>
              </div>
              
              <label class="col-lg-2 control-label">故障级别</label>
              <div class="col-lg-4">
              	<select id="faultlevel" name="faultlevel"   class="form-control formData">
             	</select>
              </div>
            </div> 
            
          <div class="form-group">
              <label class="col-lg-2 control-label">状态描述</label>
              <div class="col-lg-10">
                <input type="text" id="faultdesc" name="faultdesc" maxlength="50" class="form-control formData">
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">维修建议</label>
              <div class="col-lg-10">
                <textarea id="standardoper" name="standardoper" maxlength="300" class="form-control formData"></textarea>
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">其它介绍</label>
              <div class="col-lg-10">
                <textarea id="descp" name="descp" maxlength="300" class="form-control formData"></textarea>
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
