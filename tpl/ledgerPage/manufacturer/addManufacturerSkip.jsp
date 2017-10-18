<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
			rules : {
				manufcode:{
					required : true,
					maxlength : 20
				},
				manufname:{
					required : true,
					maxlength : 20
				},
				compscale:{
					maxlength : 50
				},
				marketposition:{
					maxlength : 20
				},
				regman:{
					maxlength : 20
				},
				regmoney:{
					number:true
				},
				citycode:{
					maxlength : 20
				},
				address:{
					maxlength : 50
				},
				postcode:{
					zipcode : true
				},
				presalescall:{
					phone : true
				},
				aftersalescall:{
					phone : true
				},
				descp:{
					maxlength : 300
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						//hideModal("manufacturerModal");
						//$('#manufacturerModal').modal('hide');
						//goPage(0);
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
						promptObj('error', '',"保存失败,请稍后重试!");
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
		app.controller('ManufacturerAddCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams',
		                                       function($http, $location, $rootScope, $scope, $state, $stateParams){
			initPageData($stateParams.manId);  
			$scope.backManufacturer = function(){
				$state.go('app.manufacturer');
			  }
		}]);
	});
	function saveForm(){
		if($("#county").val()!=null&&$("#county").val()!=""){
			$("#cityid").val($("#county").val());
		}else if($("#city").val()!=null&&$("#city").val()!=""){
			$("#cityid").val($("#city").val());
		}else {
			$("#cityid").val($("#province").val());
		}
		$("#editForm").trigger("submit");
	}
	//初始化页面数据
	function initPageData(id){
		getRegion("1","","province");
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Manufacturer/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#manufcode").val(msg.manufcode);
					$("#manufname").val(msg.manufname);
					$("#compscale").val(msg.compscale);
					$("#marketposition").val(msg.marketposition);
					$("#regman").val(msg.regman);
					$("#regmoney").val(msg.regmoney);
					$("#cityid").val(msg.cityid);
					$("#address").val(msg.address);
					$("#postcode").val(msg.postcode);
					$("#presalescall").val(msg.presalescall);
					$("#aftersalescall").val(msg.aftersalescall);
					$("#descp").val(msg.descp);
					initRegion(msg.cityid);
				}
			});
		}		
	}
	function getRegion(level,parentId,domId,regionId){
		$("#"+domId).empty();
		$.ajax({
			type:"post",
			url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
			data:{"treeLevel":level,"parentId":parentId},
			dataType : "json",
			async: false,
			success:function(msg){
				$("#"+domId).append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].id+"'";
					if(regionId!=null&&msg[i].id==regionId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].regionName+"</option>";
					$("#"+domId).append(op);
				}
			}
		});
	}
	function initRegion(rid){
		$.ajax({
			type:"post",
			url:"${ctx}/BaseRegion/selectById.htm",
			data:{"id":rid},
			success:function(msg){
				if(msg.treeLevel=='1'){
					$("#province").val(msg.id);
				}else if(msg.treeLevel=='2'){
					getRegion('2',msg.parentId,'city',msg.id);
					$("#city").val(msg.id);
					initRegion(msg.parentId);
				}else if(msg.treeLevel=='3'){
					getRegion('3',msg.parentId,'county',msg.id);
					$("#county").val(msg.id);
					initRegion(msg.parentId);
				}
			}
		});
	}
	
</script>
<div ng-controller="ManufacturerAddCtrl">
	<div class="wrapper-md bg-light b-b">
		<h1 class="m-n font-thin h3">厂商信息管理</h1>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="panel-heading">厂商信息表</div>
		<div class="row wrapper">
		<!-- form 开始 -->
		<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/Manufacturer/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="{{$stateParams.manId}}" id="id" class="formData"/>
          <input type="hidden" name="cityid" class="formData" value="" id="cityid"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">厂商编号</label>
              <div class="col-lg-3">
                <input type="text" id="manufcode" name="manufcode" maxlength="20" class="form-control formData">
              </div>
            </div>
            <div class="form-group">
              <label class="col-lg-2 control-label">厂商名称</label>
              <div class="col-lg-8">
                <input type="text" id="manufname" name="manufname" maxlength="20" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">企业规模</label>
              <div class="col-lg-3">
                <input type="text" id="compscale" name="compscale" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">市场地位</label>
              <div class="col-lg-3">
                <input type="text" id="marketposition" name="marketposition" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
              <label class="col-lg-2 control-label" >企业法人</label>
              <div class="col-lg-3">
                <input type="text" id="regman" maxlength="20" name="regman" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">注册资金</label>
              <div class="col-lg-3">
                <input type="text" id="regmoney" name="regmoney" class="form-control formData" />
              </div>
              <label class="col-lg-1 no-padder p-l-n">万元</label>
            </div>
               <div class="form-group">
              <label class="col-lg-2 control-label" >售前电话</label>
              <div class="col-lg-3">
                <input id="presalescall" name="presalescall" maxlength="18" placeholder="区号-电话-分机 " class="form-control formData">
            </div>
              <label class="col-lg-2 control-label">售后电话</label>
              <div class="col-lg-3">
                <input id="aftersalescall" name="aftersalescall" maxlength="18" placeholder="区号-电话-分机  "class="form-control formData">
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">邮编</label>
              <div class="col-lg-6">
                <input id="postcode" name="postcode" maxlength="6" class="form-control formData">
              </div>
            </div>
               <div class="form-group">
              <label class="col-lg-2 control-label">地址</label>
<!--               <label class="col-lg-2 control-label">省</label> -->
              <div class="col-lg-2">
                <select id="province" class="form-control formData" onchange="getRegion('2',this.value,'city');">
					
				</select>
              </div>
<!--               <label class="col-lg-2 control-label">市</label> -->
              <div class="col-lg-2">
                <select id="city" class="form-control formData"  onchange="getRegion('3',this.value,'county');">
					
				</select>
              </div>
<!--               <label class="col-lg-2 control-label">县</label> -->
              <div class="col-lg-2">
                <select id="county" class="form-control formData">
					
				</select>
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">详细地址</label>
              <div class="col-lg-10">
                <input id="address" name="address" maxlength="50" class="form-control formData"></input>
              </div>
            </div>
          
             <div class="form-group">
              <label class="col-lg-2 control-label">其它介绍</label>
              <div class="col-lg-8">
                <textarea id="descp" name="descp" class="form-control formData" cols="4"></textarea>
              </div>
            </div>
             <div class="form-group m-t-lg">
            <div class="col-lg-8">   
                <button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="backManufacturer();"><strong>取消</strong></button>
                 <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 </div>
   			 </div>
          </form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
