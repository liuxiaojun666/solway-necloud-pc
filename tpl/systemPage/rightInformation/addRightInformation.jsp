<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
    <script type="text/javascript">      
	$(function() {
		$("#editForms").validate( {
			rules : {
				rightCode:{
					required : true
				},
				rightName:{
					required : true
				},
				sequence:{
					required : true,
					digits : true
				},
				companyid:{
					//required : true
				}
			},
            errorPlacement: errorPlacement,
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success', '',json.message);
						hideModal("rightInformationModal");
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"操作失败，请稍后重试");
					}
				};
				$('#editForms').ajaxSubmit(options);
			}
		});
	});
	function saveForm(){
		//alert($("#companyid").val());
		$("#editForms").trigger("submit");
		
	}
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		$("#childRight").html("");
// 		getCompany();
// 		geParentRight("");
		if(id != "" && id != null){
			 geParentRight(id);
			 $("#rightId").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Right/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#rightCode").val(msg.rightCode);
					$("#rightName").val(msg.rightName);
					$("#companyid").val(msg.companyid);
					$("#parentRightId").val(msg.parentRightId);
					$("#remark").val(msg.remark);
					$("#uisref").val(msg.uisref);
					$("#uiurl").val(msg.uiurl);
					$("#sequence").val(msg.sequence);
					$("#stylename").val(msg.stylename);
					$("#isbottom").val(msg.isbottom);
                    initIscomManage(msg.iscomManage);
                    initIssystemManage(msg.issystemManage);
                    initIsValid(msg.isValid);
					var childRight = $("#childRight").html();
					var rightChilds = msg.rightChilds;
					for(var i = 0;i<rightChilds.length;i++){
					childRight = childRight+"<label class=\"col-lg-2 control-label\">权限编码</label>"
			        +"<div class=\"col-lg-4\">"
			        +"<input type=\"text\" id=\"childRightCode\" name=\"childRightCode\" class=\"form-control formData\" value=\""+rightChilds[i].rightCode+"\">"
			        +"</div>"
			        +"<label class=\"col-lg-2 control-label\">权限名称</label>"
			        +"<div class=\"col-lg-4\">"
			        +"<input type=\"text\" id=\"childRightName\" name=\"childRightName\" class=\"form-control formData\" value=\""+rightChilds[i].rightName+"\">"
			        +"</div>";
					}
			        $("#childRight").html(childRight);
					
				}
			});
			 getSelected(id);
		}else{
			getSelected(null);
		}	
	}
	
	
	var getSelected, initIscomManage, initIssystemManage, initIsValid;
	app.controller('addRightCtrl', ['$http',  '$scope',  function($http,$scope){
		getSelected = $scope.getA = function(id){
			$scope.companyd = {};
	    	$scope.company = null;
			$http({method:"POST",url:"${ctx}/Company/selectAll.htm",params:{}})
			.success(function (result) {
		    	 $scope.company = result;
		    	 for(var i=0,len=$scope.company.length;i<len;i++){
	 					if($scope.company[i].comId==  $("#companyid").val()){
	 						$scope.companyd.selected= { comName: $scope.company[i].comName,comId:  $("#companyid").val()};
	 					}
	 				}
		    	 $scope.companyChange= function () {
			         $("#companyid").val(angular.copy($scope.companyd.selected.comId));
				} 
			}); 
// 	组织机构end===============================================================
			$scope.parentRightd = {};
	    	$scope.parentRight = null;
			$http({method:"POST",url:"${ctx}/Right/selectAll.htm",params:{"rightId":id}})
			.success(function (result) {
		    	 $scope.parentRight = result;
		    	 for(var i=0,len=$scope.parentRight.length;i<len;i++){
	 					if($scope.parentRight[i].rightId==  $("#parentRightId").val()){
	 						$scope.parentRightd.selected= { rightName: $scope.parentRight[i].rightName,rightId:  $("#parentRightId").val()};
	 					}
	 				}
		    	 $scope.parentRightChange= function () {
			         $("#parentRightId").val(angular.copy($scope.parentRightd.selected.rightId));
				} 
			}); 
		};

        $scope.iscomManageArr = ["否", "是"];
		$scope.iscomManage = [{"id": 0, "name": "否"}, {"id": 1, "name": "是"}];
        $scope.iscomManaged = {};
        $scope.iscomManageChange = function () {
            $("#iscomManage").val(angular.copy($scope.iscomManaged.selected.id));
        };
        initIscomManage = $scope.initIscomManage = function (iscomManage) {
            if (iscomManage == null){
                $scope.iscomManaged.selected = {"id": null, "name": "青选择..."};
            }else {
                $scope.iscomManaged.selected = {"id": iscomManage, "name": $scope.iscomManageArr[iscomManage]};
                $scope.iscomManageChange();
                $scope.$applyAsync();
            }
        };
        $scope.issystemManage = [{"id": 0, "name": "否"}, {"id": 1, "name": "是"}];
        $scope.issystemManaged = {};
        $scope.issystemManageChange = function () {
            $("#issystemManage").val(angular.copy($scope.issystemManaged.selected.id));
        };
        initIssystemManage = $scope.initIssystemManage = function (issystemManage) {
            if (issystemManage == null){
                $scope.issystemManaged.selected = {"id": null, "name": "青选择..."};
            }else {
                $scope.issystemManaged.selected = {"id": issystemManage, "name": $scope.iscomManageArr[issystemManage]};
                $scope.issystemManageChange();
                $scope.$applyAsync();
            }
        };
        $scope.isValidArr = ["正常", "暂停使用"];
        $scope.isValid = [{"id": 0, "name": "正常"}, {"id": 1, "name": "暂停使用"}];
        $scope.isValidd = {};
        $scope.isValidChange = function () {
            $("#isValid").val(angular.copy($scope.isValidd.selected.id));
        };
        initIsValid = $scope.initIsValid = function (isValid) {
            if (isValid == null){
                $scope.isValidd.selected = {"id": null, "name": "青选择..."};
            }else {
                $scope.isValidd.selected = {"id": isValid, "name": $scope.isValidArr[isValid]};
                $scope.isValidChange();
                $scope.$applyAsync();
            }
        };
	}]);
	
	
	function getCompany(companyId){
		$("#companyid").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/Company/selectAll.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#companyid").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].comId+"'";
 					if(companyId!=null&&msg[i].comId==companyId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].comName+"</option>";
					$("#companyid").append(op);
				}
			}
		});
	}
	function geParentRight(id,rightId){
		$("#parentRightId").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/Right/selectAll.htm",
			data:{"rightId":id},
			dataType : "json",
			async: false,
			success:function(msg){
				$("#parentRightId").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].rightId+"'";
 					if(rightId!=null&&msg[i].rightId==rightId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].rightName+"</option>";
					$("#parentRightId").append(op);
				}
			}
		});
	}
	
	
	function addChildRight(){
		//alert($("#childRight").html());
		var childRight = $("#childRight").html();
		childRight = childRight+"<label class=\"col-lg-2 control-label\">权限编码</label>"
        +"<div class=\"col-lg-4\">"
        +"<input type=\"text\" id=\"childRightCode\" name=\"childRightCode\" class=\"form-control formData\">"
        +"</div>"
        +"<label class=\"col-lg-2 control-label\">权限名称</label>"
        +"<div class=\"col-lg-4\">"
        +"<input type=\"text\" id=\"childRightName\" name=\"childRightName\" class=\"form-control formData\">"
        +"</div>";
        $("#childRight").html(childRight)
	}
</script>
<div ng-controller="addRightCtrl"  class="modal fade" id="rightInformationModal" tabindex="-1" right="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">权限信息管理</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Right/updateData.htm" method="post" id="editForms" name="editForms">
          <input type="hidden" name="rightId" value="" id="rightId" class="formData"/>
          <input type="hidden" name="isbottom" value="0" id="isbottom"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">权限编码</label>
              <div class="col-lg-4">
              <input type="text" id="rightCode" maxlength="20" name="rightCode" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">权限名称</label>
              <div class="col-lg-4">
               <input type="text" id="rightName"  maxlength="20" name="rightName" class="form-control formData">
              </div>
            </div>
            <div class="form-group">
            <label class="col-lg-2 control-label">所属机构</label>
              <div class="col-lg-4">
 				 <input type="hidden" id="companyid" name="companyid" class="form-control formData">
	          	 <ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
	             <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
	             <ui-select-choices  repeat="item in company | filter: $select.search">
	              <div ng-bind-html="item.comName | highlight: $select.search"></div>
	             </ui-select-choices>
		         </ui-select>
              </div>
              <label class="col-lg-2 control-label">父权限</label>
              <div class="col-lg-4">
 				<input type="hidden" id="parentRightId" name="parentRightId" class="form-control formData">
	          	<ui-select ng-model="parentRightd.selected" theme="bootstrap" ng-change="parentRightChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="parentRightd.selected.rightName" >{{$select.selected.rightName}}</ui-select-match>
	            <ui-select-choices  repeat="item in parentRight | filter: $select.search">
	            <div ng-bind-html="item.rightName | highlight: $select.search"></div>
	            </ui-select-choices>
		         </ui-select>
              </div>
            </div>
            <div class="form-group">
            <label class="col-lg-2 control-label">路径</label>
              <div class="col-lg-4">
 					 <input type="text" id="uisref" maxlength="50" name="uisref" class="form-control formData">
              </div>
               <label class="col-lg-2 control-label">访问路径</label>
              <div class="col-lg-4">
 					 <input type="text" id="uiurl" maxlength="50" name="uiurl" class="form-control formData">
              </div>
            </div>
            <div class="form-group">
               <label class="col-lg-2 control-label">类名称</label>
              <div class="col-lg-4">
 					 <input type="text" id="stylename" maxlength="100" name="stylename" class="form-control formData">
              </div>
            <label class="col-lg-2 control-label">排序</label>
              <div class="col-lg-4">
 					 <input type="text" id="sequence" maxlength="20"  name="sequence" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
                  <label class="col-lg-2 control-label">公司管理</label>
                  <div class="col-lg-4">
                      <ui-select ng-model="iscomManaged.selected" theme="bootstrap" ng-change="iscomManageChange()">
                          <ui-select-match placeholder="请输入..." ng-model="iscomManage.selected.name" >{{$select.selected.name}}</ui-select-match>
                          <ui-select-choices  repeat="item in iscomManage | filter: $select.search">
                              <div ng-bind-html="item.name | highlight: $select.search"></div>
                          </ui-select-choices>
                      </ui-select>
                      <input type="hidden" id="iscomManage" name="iscomManage" />
                  </div>
                  <label class="col-lg-2 control-label">系统管理</label>
                  <div class="col-lg-4">
                      <ui-select ng-model="issystemManaged.selected" theme="bootstrap" ng-change="issystemManageChange()">
                          <ui-select-match placeholder="请输入..." ng-model="issystemManaged.selected.name" >{{$select.selected.name}}</ui-select-match>
                          <ui-select-choices  repeat="item in issystemManage | filter: $select.search">
                              <div ng-bind-html="item.name | highlight: $select.search"></div>
                          </ui-select-choices>
                      </ui-select>
                      <input type="hidden" id="issystemManage" name="issystemManage" />
                  </div>
              </div>
              <div class="form-group">
                  <label class="col-lg-2 control-label">权限有效性</label>
                  <div class="col-lg-4">
                      <ui-select ng-model="isValidd.selected" theme="bootstrap" ng-change="isValidChange()">
                          <ui-select-match placeholder="请输入..." ng-model="isValid.selected.name" >{{$select.selected.name}}</ui-select-match>
                          <ui-select-choices  repeat="item in isValid | filter: $select.search">
                              <div ng-bind-html="item.name | highlight: $select.search"></div>
                          </ui-select-choices>
                      </ui-select>
                      <input type="hidden" id="isValid" name="isValid" />
                  </div>
              </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">备注</label>
                 <div class="col-lg-4">
                 <textarea rows="4" cols="55" maxlength="500" id="remark" name="remark"></textarea>
              </div>
            </div>
            <div class="form-group" id="childRight" >
            </div>
             <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">   
                <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                 <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info" style="margin-left: 10px"><strong>保 存</strong></button>
                 <button type="button" onclick="addChildRight();" id="addRight" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>添加子权限</strong></button>
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
