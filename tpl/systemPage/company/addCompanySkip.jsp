<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
    <script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
			rules : {
				comCode:{
					required : true,
					maxlength : 8
				},
				comName:{
					required : true,
					maxlength : 30
				},
				comShortName:{
					required : true,
					maxlength : 20
				},
				comAddr:{
					maxlength : 200
				},
				comZip:{
					zipcode:true,
					maxlength : 6
				},
				comFax:{
					fax:true
				},
				comCorp:{
					maxlength : 20
				},
				comCont:{
					maxlength : 20
				},
				comTel:{
					phone:true
				},
				comMobile:{
					maxlength : 11
				},
				regMoney:{
					number:true,
					min : 0,
					max : 100000000,
					maxlength : 10
				},
				comCretBy:{
					maxlength : 20
				},
				comParentId:{
					maxlength : 11,
// 					remote:{
// 			               type:"POST",
// 			               url:"${ctx}/Company/parentVerify.htm",             //servlet
// 			               data:{
// 			            	 id:function(){return $("#comId").val();},
// 			                 parentId:function(){return $("#comParentId").val();}
// 			               } 
// 			        } 
			            
				},
				comRgnCode:{
					maxlength : 6
				},
				comBctCode:{
					maxlength : 11
				},
				comStrCode:{
					maxlength : 10
				},
				comEmail:{
					maxlength : 60
				},
				descp:{
					maxlength : 300
				},
				comSort:{
					maxlength : 10
				}
			},messages: {
				comParentId:{remote:'<img width="16" height="16" src="${ctx}/theme/images/validator/check_n.gif">上级企业不能在此企业的子企业中!'}
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
		app.controller('addCompanyCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
			initPageData($stateParams.cmId);
			$scope.backCompany = function(){
				$state.go('app.companyDepartmentInfo');
			  }
		}]);
	});
	
	
	function saveForm(){
		$("#editForm").trigger("submit");
	}
	
	//初始化页面数据
	function initPageData(comId){
		$(".formData").val("");
		if(comId != "" && comId != null){
			 $("#comId").val(comId);
			 $.ajax({
				type:"post",
				url:"${ctx}/Company/selectById.htm",
				data:{"comId":comId},
				success:function(msg){
					$("#comCode").val(msg.comCode);
					$("#comName").val(msg.comName);
					$("#comShortName").val(msg.comShortName);
					$("#comAddr").val(msg.comAddr);
					$("#comZip").val(msg.comZip);
					$("#comFax").val(msg.comFax);
					$("#comCorp").val(msg.comCorp);
					$("#comCont").val(msg.comCont);
					$("#comTel").val(msg.comTel);
					$("#comMobile").val(msg.comMobile);
					$("#comCretBy").val(msg.comCretBy);
					$("#comCretDate").val(msg.comCretDate);
					$("#comParentId").val(msg.comParentId);
					$("#comRgnCode").val(msg.comRgnCode);
					$("#comBctCode").val(msg.comBctCode);
					$("#comEmail").val(msg.comEmail);
					$("#comSort").val(msg.comSort);
					$("#comStatus").val(msg.comStatus);
					$("#regMoney").val(msg.regMoney);
					$("#descp").val(msg.descp);
					$("#provinceid").val(msg.provinceid);
					$("#cityid").val(msg.cityid);
					$("#countyid").val(msg.countyid);
					$("#begindate").val(msg.begindate);
					$("#enddate").val(msg.enddate);
					 getCompanyType(msg.comBctCode);
					
// 					getCom(msg.comId,msg.comParentId);
// 					getRegion('1',null,'provinceid',msg.provinceid);
// 					getRegion('2',msg.provinceid,'cityid',msg.cityid);
// 					getRegion('3',msg.cityid,'countyid',msg.countyid);
				}
			});
			 getSelected(comId);
		}else{
// 			getCom();
// 			getRegion('1',null,'provinceid',null);
			getSelected(null);
			getCompanyType(null);
		}		
	}

	function getSelected(comId){
		app.controller('RegionCtrl', ['$http', '$scope', function($http, $scope){
// 		地址省市县start	===============================================================
			 $scope.provinced = {};
			 $scope.province = null;
		     $scope.cityd = {};
			 $scope.city = null; 
			 $scope.countyd = {};
			 $scope.county = null; 
			 
			 $scope.provinceChange= function () {
	    		 var a = angular.copy($scope.provinced.selected.id); 
	    		 $("#provinceid").val(a);
	    		 $scope.countyd.selected= { regionName: null,id:  null};
	    		 $scope.cityd.selected= { regionName: null,id:  null};
		         $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":2,"parentId":a}})
		         .success(function (resultcity) {
		        	 $scope.city = resultcity;
		        	 for(var i=0,len=$scope.city.length;i<len;i++){
		 					if($scope.city[i].id==  $("#cityid").val()){
		 						$scope.cityd.selected= { regionName: $scope.city[i].regionName,id:  $("#cityid").val()};
		 					}
		 				}
		        	 
		        	 if($("#countyid").val() != null && $("#countyid").val() != "" ){
			    		 //$scope.cityChange();
			    	 }
		         }); 
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
			    	 
			    	 if($("#cityid").val() != null && $("#cityid").val() != "" ){
			    		 //$scope.provinceChange();
			    	 }
				}); 
// 	地址省市县 end ================================================
	
// 所属企业 start=================================================	
			$scope.companyd = {};
		   	$scope.company = null;
			$http({method:"POST",url:"${ctx}/Company/selectAll.htm",params:{"comId":comId}})
			.success(function (result) {
		    	 $scope.company = result;
		    	 for(var i=0,len=$scope.company.length;i<len;i++){
					if($scope.company[i].comId==  $("#comParentId").val()){
						$scope.companyd.selected= { comName: $scope.company[i].comName,comId:  $("#comParentId").val()};
					}
				}
		    	 $scope.companyChange= function () {
			         $("#comParentId").val(angular.copy($scope.companyd.selected.comId));
				} 
			}); 
// 所属企业end=======================================================
		}]);
	}
	
	function getCom(comId,comParentId){
		$("#comParentId").empty();
		$.ajax({
			type:"post",
			data:{"comId":comId},
			url:"${ctx}/Company/selectAll.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#comParentId").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					for(var i=0,len=msg.length;i<len;i++){
						var op="<option value='"+msg[i].comId+"'";
						if(comParentId!=null&&msg[i].comId==comParentId){
							op+=" selected='selected' ";
						}
						op+=">"+msg[i].comName+"</option>";
						$("#comParentId").append(op);
					}
				}
			}
		});
	}

	function getCompanyType(dictId){
		$("#comBctCode").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/Company/getCompanyType.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#comBctCode").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					for(var i=0,len=msg.length;i<len;i++){
						var op='<option value="'+msg[i].id+'"';
						if(dictId!=null&&msg[i].id==dictId){
							op+=' selected="selected" ';
						}
						op+='>'+msg[i].dictName+'</option>';
						$("#comBctCode").append(op);
					}
				}
			}
		});
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
</script>
<div ng-controller="addCompanyCtrl">
<div ng-controller="RegionCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">企业信息管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
		<!-- form 开始 -->
		<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Company/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="comId" value="{{$stateParams.cmId}}" id="comId" class="formData"/>
            <div class="form-group">
              <label class="col-lg-2 control-label">企业名称</label>
              <div class="col-lg-8">
                <input type="text" id="comName" name="comName" maxlength="30" class="form-control formData">
              </div>
             </div>
            <div class="form-group">
               <label class="col-lg-2 control-label">简称</label>
              <div class="col-lg-3">
                <input type="text" id="comShortName" name="comShortName" maxlength="20" class="form-control formData">
              </div>
                <label class="col-lg-2 control-label"> 企业类型</label>
              <div class="col-lg-3">
             	 <select id="comBctCode" name="comBctCode" class="form-control formData">
             	</select>
              </div>  
<!--                <label class="col-lg-2 control-label">企业代码</label> -->
<!--               <div class="col-lg-3"> -->
<!--                 <input type="text" id="comCode" name="comCode" maxlength="8"  class="form-control formData"> -->
<!--               </div> -->
            </div>
            <div class="form-group">
              <%--<label class="col-lg-2 control-label">上级企业</label>
              <div class="col-lg-3">
<!--               <select id="comParentId" name="comParentId" class="form-control formData"> -->
<!--             		</select> -->
					<ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
		            <ui-select-choices  repeat="item in company | filter: $select.search">
		              <div ng-bind-html="item.comName | highlight: $select.search"></div>
		            </ui-select-choices>
			          </ui-select>
					<input type="hidden" id="comParentId" name="comParentId" class="form-control formData" />
					</div>--%>
            
	        </div>     
            <div class="form-group">
            	<label class="col-lg-2 control-label">企业法人</label>
               <div class="col-lg-3">
                <input type="text" id="comCorp" name="comCorp" maxlength="20" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">注册资金</label>
              <div class="col-lg-2">
                <input type="text" id="regMoney" name="regMoney" maxlength="10" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
              </div>
              <label class="col-lg-1 control-label">万元</label>
             </div>  
            <div class="form-group">
              <label class="col-lg-2 control-label" >传真</label>
              <div class="col-lg-3">
                <input type="text" id="comFax" name="comFax" maxlength="18" placeholder="区号-电话-分机" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">联系电话</label>
              <div class="col-lg-3">
                <input type="text" id="comTel" name="comTel"  maxlength="18" placeholder="区号-电话-分机   或  手机号" class="form-control formData">
              </div>
            </div>     
            <div class="form-group">
             <label class="col-lg-2 control-label">联系人</label>
              <div class="col-lg-3">
                <input type="text" id="comCont" name="comCont" maxlength="20" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">邮编</label>
              <div class="col-lg-3">
                <input type="text" id="comZip" name="comZip" maxlength="6" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
              </div>
            </div>
            <div class="form-group">
              <label class="col-lg-2 control-label">地址</label>
                <div class="col-lg-2">
<!--                 <select id="province" class="form-control formData" onchange="getRegion('2',this.value,'city');"> -->
<!-- 				</select> -->
		            <ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in province | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
		          	<input type="hidden" name ="provinceid" id="provinceid"  class="form-control formData"/>
              </div>
              <div class="col-lg-2">
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
              <div class="col-lg-2">
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
              <div class="col-lg-8">
                <input type="text" id="comAddr" name="comAddr" maxlength="50" class="form-control formData">
             </div>
            </div>
            <div class="form-group">
              <label class="col-lg-2 control-label">其他介绍</label>
              <div class="col-lg-8">
                <textarea rows="3" id="descp" name="descp" maxlength="300" class="form-control formData"></textarea>
              </div>
             </div> 
<!--             <div class="form-group"> -->
<!-- 	             <label class="col-lg-1 control-label">手机</label> -->
<!-- 	              <div class="col-lg-2"> -->
<!-- 	                <input type="text" id="comMobile" name="comMobile" class="form-control formData"> -->
<!-- 	              </div> -->
	            
<!-- 	              <label class="col-lg-1 control-label">区划代码</label> -->
<!-- 	              <div class="col-lg-2"> -->
<!-- 	                <input type="text" id="comRgnCode" name="comRgnCode" class="form-control formData"> -->
<!-- 	              </div> -->
<!--              </div> -->
             
<!--              <div class="form-group"> -->
             	
<!-- 	              <label class="col-lg-1 control-label">行业类别</label> -->
<!-- 	              <div class="col-lg-2"> -->
<!-- 	                <input type="text" id="comStrCode" name="comStrCode" class="form-control formData"> -->
<!-- 	              </div> -->
<!-- 	              <label class="col-lg-1 control-label">邮箱</label> -->
<!-- 	              <div class="col-lg-2"> -->
<!-- 	                <input type="text" id="comEmail" name="comEmail" class="form-control formData"> -->
<!-- 	              </div> -->
<!--              </div> -->
             
<!--                <div class="form-group"> -->
<!--             	  <label class="col-lg-1 control-label"> 排序</label> -->
<!--               <div class="col-lg-2"> -->
<!--                 <input type="text" id="comSort" name="comSort" class="form-control formData"> -->
<!--               </div> -->
<!--               <label class="col-lg-1 control-label">状态</label> -->
<!--               <div class="col-lg-2"> -->
<!--                 <input type="text" id="comStatus" name="comStatus" class="form-control formData"> -->
<!--               </div> -->
<!--              </div> -->
             
             <div class="form-group">
	            <div class="col-lg-offset-2 col-lg-4">   
	                <button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="backCompany();"><strong>取消</strong></button>
	                 <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
	   			 </div>
   			 </div>
          </form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
 </div>
