<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">      
	$(function() {
		$("#editForm").validate( {
			rules : {
				productcode:{
					required : true,
					maxlength : 50
				},
				buildcapacity:{
					maxlength : 12,
					number:true
				},
				productname:{
					required : true,
					maxlength : 20
				},
				specification:{
					maxlength : 20
				},
				perfrating:{
					maxlength : 20
				},
				mainparameter:{
					maxlength : 50
				},
				descp:{
					maxlength : 300
				},
				normalcode:{
					number:true,
					maxlength : 20
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						hideModal("productModal");
						//$('#manufacturerModal').modal('hide');
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
		//if(flag==0){
			//getManuf();
			//$("#id").val("");
		$(".formData").val("");
			//return ;
		//}
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Product/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#productcode").val(msg.productcode);
					$("#buildcapacity").val(msg.buildcapacity);
					$("#productname").val(msg.productname);
					$("#specification").val(msg.specification);
					$("#manufid").val(msg.manufid);
					$("#perfrating").val(msg.perfrating);
					$("#mainparameter").val(msg.mainparameter);
					$("#descp").val(msg.descp);
// 					$("#normalcode").val(msg.normalcode);
					
// 					var faultdiagnosistype=msg.faultdiagnosistype
// 			        var ridaolen=document.editForm.faultdiagnosistype.length;
// 			        for(var i=0;i<ridaolen;i++){
// 			            if(faultdiagnosistype==document.editForm.faultdiagnosistype[i].value){
// 			                document.editForm.faultdiagnosistype[i].checked=true
// 			            }
// 			        }
					var devicetype=msg.devicetype
			        var ridaolen2=document.editForm.devicetype.length;
			        for(var i=0;i<ridaolen2;i++){
			            if(devicetype==document.editForm.devicetype[i].value){
			                document.editForm.devicetype[i].checked=true
			            }
			        }
				}
			});
			 getSelected(id);
		}else{
			getSelected(null);
		}	
	}
	
	var getSelected;
	app.controller('addProductCtrl', ['$http',  '$scope',  function($http,$scope){
		getSelected = $scope.getA = function(id){
			 //所属厂商--------------------------start------------------------------------
			$scope.manus = {};
		 	$scope.manuf = null;
		 	
			$http({method:"POST",url:"${ctx}/Manufacturer/selectAll.htm",
				params:{}})
		    .success(function (result) {
	    	 $scope.manuf = result;
	    	 
	    	 if(manufid != null && manufid != "" ){
		    	 for(var i=0,len=$scope.manuf.length;i<len;i++){
					if($scope.manuf[i].id==  $("#manufid").val()){
						$scope.manus.selected= { manufname: $scope.manuf[i].manufname,id:  $("#manufid").val()};
					}
				}
	    	 }
	    	 $scope.manufChange = function () {
	    		  a = angular.copy($scope.manus.selected.id); 
			      $("#manufid").val(a);
	             }
			});
		}
	}]);

</script>
<div   ng-controller="addProductCtrl"   class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">产品信息管理</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Product/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">产品编号</label>
              <div class="col-lg-4">
                <input type="text" id="productcode" name="productcode" maxlength="50" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">产品容量</label>
              <div class="col-lg-3">
                <input type="text" id="buildcapacity" name="buildcapacity" maxlength="10" class="form-control formData">
              </div>
                <label class="col-lg-1 control-label p-l-n ">kW</label>
           </div>
           <div class="form-group">
              <label class="col-lg-2 control-label">产品名称</label>
              <div class="col-lg-10">
                <input type="text" id="productname" name="productname" maxlength="20" class="form-control formData">
              </div>
            </div>
        	 <div class="form-group">
            	<label class="col-sm-2  control-label">产品类型</label>
                	<div class="col-sm-10 p-l-n" id="userType_Div">
                		<div class="col-sm-3">
	           				<label class="checkbox-inline i-checks">
	           			 		<input type="radio"  name="devicetype"  id="deviceType1" value="3"  class="form-control" >  <i></i> 箱变
		           		 	</label>
		           		 </div>
		           		 <div class="col-sm-3">
			           		 <label class="checkbox-inline i-checks">
		           			 	<input type="radio" name="devicetype"  id="deviceType2" value="2"  class="form-control">  <i></i> 逆变器
			           		 </label>
		           		 </div>
		           		 
		           		  <div class="col-sm-3">
		           		  	  <label class="checkbox-inline i-checks">
	           			 		<input type="radio" name="devicetype"  id="deviceType3" value="1"  class="form-control" >  <i></i> 汇流箱
		           			  </label>
		           		 </div>
		           		 <div class="col-sm-3">
			           		 <label class="checkbox-inline i-checks">
		           			 	<input type="radio" name="devicetype"  id="deviceType5" value="5"  class="form-control">  <i></i> 气象仪
			           		 </label>
			           	 </div>	 
			           	
			           	 <div class="col-sm-3">
		           		 	 <label class="checkbox-inline i-checks">
	           			 		<input type="radio" name="devicetype"  id="deviceType4" value="4"  class="form-control">  <i></i> 电能表
		           		 	</label>
		           		 </div>
		           		 
		           		 <div class="col-sm-3">
			           		  <label class="checkbox-inline i-checks">
		           				 <input type="radio" name="devicetype"  id="deviceType7" value="7"  class="form-control">  <i></i> 电池板
			           		 </label>
		           		 </div>
		           		 
		           		  <div class="col-sm-3">
		           		   	<label class="checkbox-inline i-checks">
	           			 		<input type="radio" name="devicetype"  id="deviceType6" value="6"  class="form-control">  <i></i> 其它
		           		 	</label>
		           		 </div>
	              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">规格型号</label>
              <div class="col-lg-4">
                <input type="text" id="specification" name="specification" maxlength="20" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">性能评级</label>
              <div class="col-lg-4">
                <input type="text" id="perfrating" name="perfrating" maxlength="20" class="form-control formData">
              </div>
             </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">生产厂商</label>
              <div class="col-lg-10">
             	<ui-select  ng-model="manus.selected" theme="bootstrap" ng-change="manufChange()">
				<ui-select-match placeholder="请输入关键字..." ng-model="manus.selected.manufname" >{{$select.selected.manufname}}</ui-select-match>
			    <ui-select-choices repeat="item in manuf | filter: $select.search">
			    <div ng-bind-html="item.manufname | highlight: $select.search"></div>
			    </ui-select-choices>
				</ui-select>
             	<input type="hidden" name ="manufid" id="manufid" class="form-control formData"/>
              </div>
            </div>
            <div class="form-group">
              
              <label class="col-lg-2 control-label">主要参数</label>
              <div class="col-lg-10">
                <input type="text" id="mainparameter" name="mainparameter" maxlength="50" class="form-control formData" >
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
