<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>

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
						//弹出提示信息
						promptObj('success','',json.message);
						//关闭弹出层
						hideModal("manufacturerModal");
						//刷新列表数据
						goPage(1);
					},
					error : function(json) {
						//alert("保存失败,请稍后重试!");
						//promptObj('error','',"保存失败,请稍后重试!");
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
		//	$("#id").val("");
			$(".formData").val("");
		//	return ;
		//}
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
					$("#provinceid").val(msg.provinceid);
					$("#cityid").val(msg.cityid);
					$("#countyid").val(msg.countyid);
					$("#address").val(msg.address);
					$("#postcode").val(msg.postcode);
					$("#presalescall").val(msg.presalescall);
					$("#aftersalescall").val(msg.aftersalescall);
					$("#descp").val(msg.descp);
// 					initRegion(msg.cityid);
				}
			});
		}	
		getSelected();
	}
	
	var getSelected;
	app.controller('AddManufacturerCtrl', ['$http', '$scope', function($http, $scope){
		 getSelected = $scope.getA = function(id){
//		 		地址省市县start	===============================================================
			 $scope.provinced = {};
			 $scope.province = null;
		     $scope.cityd = {};
			 $scope.city = null; 
			 $scope.countyd = {};
			 $scope.county = null; 
			 
			 $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":1,"parentId":1}})
				.success(function (result) {
			    	 $scope.province = result;
			    	 if($("#provinceid").val() != null && $("#provinceid").val() != "" ){
				    	 for(var i=0,len=$scope.province.length;i<len;i++){
							if($scope.province[i].id==  $("#provinceid").val()){
								$scope.provinced.selected= { regionName: $scope.province[i].regionName,id:  $("#provinceid").val()};
							}
						}
			    	 }
			    	 
			    	 $scope.provinceChange= function () {
			    		 var a = angular.copy($scope.provinced.selected.id); 
			    		 $("#provinceid").val(a);
			    		 $scope.cityd.selected = {regionName : null,id : null};
			    		 $scope.countyd.selected = {regionName :null,id : null};
				         $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":2,"parentId":a}})
				         .success(function (resultcity) {
				        	 $scope.city = resultcity;
				        	 for(var i=0,len=$scope.city.length;i<len;i++){
				 					if($scope.city[i].id==  $("#cityid").val()){
				 						$scope.cityd.selected= { regionName: $scope.city[i].regionName,id:  $("#cityid").val()};
				 					}
				 				}
				        	 
					        	 $scope.cityChange= function () {
							        var b = angular.copy($scope.cityd.selected.id); 
							        $("#cityid").val(b);
							        $scope.countyd.selected= { regionName: null,id:  null};
							        
							        $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":3,"parentId":((b==null) || (b==""))?0:b}})
							        .success(function (resultcounty) {
							        	$scope.county = resultcounty;
								        	for(var i=0,len=$scope.county.length;i<len;i++){
			 				 					if($scope.county[i].id==  $("#countyid").val()){
			 				 						$scope.countyd.selected= { regionName: $scope.county[i].regionName,id:  $("#countyid").val()};
			 				 					}
			 				 				}
								         $scope.countyChange= function () {
							        		 $("#countyid").val($scope.countyd.selected.id);
							        	 }
							        });
						       }
				        	 if($("#countyid").val() != null && $("#countyid").val() != "" ){
					    		 $scope.cityChange();
					    	 }
				         }); 
					} 
			    	 if($("#cityid").val() != null && $("#cityid").val() != "" ){
			    		 $scope.provinceChange();
			    	 }
				}); 
// 	地址省市县 end ================================================
		 }
	}]);
	
	
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
<div ng-controller="AddManufacturerCtrl" class="modal fade" id="manufacturerModal" 
tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">厂商信息管理</span> 
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Manufacturer/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">厂商编号</label>
              <div class="col-lg-4">
                <input type="text" id="manufcode" maxlength="20" name="manufcode" class="form-control formData">
              </div>
           </div>
           <div class="form-group">
              <label class="col-lg-2 control-label">厂商名称</label>
              <div class="col-lg-10">
                <input type="text" id="manufname" maxlength="20" name="manufname" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">企业规模</label>
              <div class="col-lg-4">
                <input type="text" id="compscale" name="compscale" maxlength="50" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">市场地位</label>
              <div class="col-lg-4">
                <input type="text" id="marketposition" name="marketposition" maxlength="20" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">企业法人</label>
              <div class="col-lg-4">
                <input type="text" id="regman" maxlength="20" name="regman" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">注册资金</label>
              <div class="col-lg-3">
                <input type="text" id="regmoney" maxlength="20" name="regmoney" class="form-control formData" />
              </div>
              <label class="col-lg-1 control-label p-l-n ">万元</label>
            </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">售前电话</label>
              <div class="col-lg-4">
                <input id="presalescall" name="presalescall" maxlength="18" placeholder="区号-电话-分机" class="form-control formData">
            </div>
              <label class="col-lg-2 control-label">售后电话</label>
              <div class="col-lg-4">
                <input id="aftersalescall" name="aftersalescall"  maxlength="18" placeholder="区号-电话-分机 " class="form-control formData">
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">邮编</label>
              <div class="col-lg-4">
                <input id="postcode" name="postcode" maxlength="6" class="form-control formData">
              </div>
            </div>
               <div class="form-group">
              <label class="col-lg-2 control-label">地址</label>
              
              <div class="col-lg-3">
<!--                 <select id="province" class="form-control formData" onchange="getRegion('2',this.value,'city');"> -->
<!-- 				</select> -->
		          	<input type="hidden" name ="provinceid" id="provinceid"  class="form-control formData"/>
		            <ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in province | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
              </div>
              <div class="col-lg-3">
<!--                 <select id="city" class="form-control formData"  onchange="getRegion('3',this.value,'county');"> -->
<!-- 				</select> -->
					<ui-select ng-model="cityd.selected" theme="bootstrap" ng-change="cityChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="cityd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in city | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
		          	<input type="hidden" name ="cityid" id="cityid"  class="form-control formData"/>
              </div>
              <div class="col-lg-4">
<!--                 <select id="county" class="form-control formData"> -->
<!-- 				</select> -->
					<ui-select ng-model="countyd.selected" theme="bootstrap" ng-change="countyChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="countyd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in county | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
		          	<input type="hidden" name ="countyid" id="countyid"  class="form-control formData"/>
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
              <div class="col-lg-10">
                <textarea id="descp" name="descp" class="form-control formData"></textarea>
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
