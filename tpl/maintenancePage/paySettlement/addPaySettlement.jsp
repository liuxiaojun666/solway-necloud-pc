<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<style>
	.menu_right .dropdown-menu {right: 0;left: auto;}
</style>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
    <script type="text/javascript">
	$(function() {
		$('#paydate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		   	autoclose: true
		});
		$("#editForm").validate( {
			rules : {
				paymoney:{
					number: true,
					maxlength : 20
				},
				payno:{
					maxlength : 50
				},
				paycontent :{
					maxlength : 50
				},
				pstationid :{
					required : true
				},
				payno:{
					required : true
				},
				paycontent :{
					required : true
				},
				payman:{
					required : true
				},
				paymoney :{
					required : true
				},
				paydate :{
					required : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						hideModal("paySettlementModal");
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
		 if($("#billFile").val()==""){
				$("#billFile").attr("disabled","disabled");
			}
		$("#editForm").trigger("submit");
	}
	//初始化页面数据
	function initPageData(id){
		$(".formData").not(':disabled').val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/PaySettlement/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#pstationid").val(msg.pstationid);
					$("#pstationname").val(msg.pstationname);
					$("#payno").val(msg.payno);
					$("#paycontent").val(msg.paycontent);
					$("#paymoney").val(msg.paymoney);
					$("#payman").val(msg.payman);
					$("#oldFile").val(msg.sourcebill);
					if(msg.sourcebill != null && msg.sourcebill !=""){
						$("#billImg").attr("src","${imgPath}/document/paySourceBill/"+msg.sourcebill);
					}
					if(msg.paydate != null && msg.paydate != ""  ){
						 var date = new Date(msg.paydate);
						 var year = date.getFullYear();
			             var month = date.getMonth()+1;
			             var date = date.getDate();
			             paydateStr = year+"-"+month+"-"+date;
						$("#paydate").val(paydateStr);
					}
				}
			});
		}
		getSelected(null);
	}

	var getSelected;
	app.controller('PPStationCtrl', ['$http', '$scope', function($http, $scope){
		 getSelected = $scope.getA = function(id){
			 //所属电站--------------------------start------------------------------------
			 $scope.stationd = {};
			 $scope.station = null;
		     $scope.factd = {};
			 $scope.fact = null;

			$http({method:"POST",url:"${ctx}/PowerStation/selectByParentId.htm",params:{}})
			.success(function (result) {
				 $scope.station = result;
		    	 $scope.stationd.selected= { stationname: result[0].stationname,id:  result[0].id};
	    		 $scope.textChange();
		    	 /* if($("#pstationid").val() != null && $("#pstationid").val() != "" ){
			    	 for(var i=0,len=$scope.station.length;i<len;i++){
						if($scope.station[i].id==  $("#pstationid").val()){
							$scope.stationd.selected= { stationname: $scope.station[i].stationname,id:  $("#pstationid").val()};
							$("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
							$scope.getUserList($scope.stationd.selected.id);
						}
					}
		    	 } else if(result.length==1){
		    		 $scope.stationd.selected= { stationname: $scope.station[0].stationname,id:  $scope.station[0].id};
		    		 $("#pstationid").val(angular.copy($scope.stationd.selected.id));
		    		 $("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
		    		 $scope.getUserList($scope.stationd.selected.id);
		    	 } */
			});
			$scope.textChange= function () {
		         $("#pstationid").val(angular.copy($scope.stationd.selected.id));
		         $("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
		         $scope.getUserList($scope.stationd.selected.id);
			}
			 //所属电站--------------------------end------------------------------------
			//支出人==================================================================
			$scope.managerd = {};
	    	$scope.manager = null;
	    	$scope.getUserList = function(sid){
	    		$http({method:"POST",url:"${ctx}/AdminUser/selectAll.htm",params:{sid:sid}})
				.success(function (result) {
			    	 $scope.manager = result;
			    	 for(var i=0,len=$scope.manager.length;i<len;i++){
		 					if($scope.manager[i].userId==  $("#payman").val()){
		 						$scope.managerd.selected= { realName: $scope.manager[i].realName,userId:  $("#payman").val()};
		 					}
		 				}
			    	 $scope.managerChange= function () {
				         $("#payman").val(angular.copy($scope.managerd.selected.userId));
					}
				});
	    	}
	    	$scope.getUserList();
		}
	}]);
</script>
<div ng-controller="PPStationCtrl" class="modal fade" id="paySettlementModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">运维支出管理</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PaySettlement/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">电站名称</label>
              <div class="col-lg-10">
                <input type="text" class="form-control formData" disabled ng-model="stationd.selected.stationname">
	           <!--<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname" >{{$select.selected.stationname}}</ui-select-match>
	            <ui-select-choices  repeat="item in station | filter: $select.search">
	              <div ng-bind-html="item.stationname | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select> -->
	         	 <input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
	         	 <input type="hidden" id="pstationname" name="pstationname" class="form-control formData">
              </div>

            </div>
              <div class="form-group">
              <label class="col-lg-3 control-label"><i class="fa fa-asterisk text-required"/>支出单号</label>
              <div class="col-lg-3">
                <input type="text" id="payno" maxlength="50" name="payno" class="form-control formData">
              </div>
              <label class="col-lg-3 control-label"><i class="fa fa-asterisk text-required"/>支出项目</label>
              <div class="col-lg-3">
 		<input type="text" id="paycontent" maxlength="50" name="paycontent" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
              <label class="col-lg-3 control-label"><i class="fa fa-asterisk text-required"/>支出金额（元）</label>
              <div class="col-lg-3">
                <input type="text" id="paymoney" maxlength="20" name="paymoney" class="form-control formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
              </div>
              <label class="col-lg-3 control-label">支出人</label>
              <div class="col-lg-3 menu_right">
                <ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	             <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
	         	   <input type="hidden" id="payman" name="payman" class="form-control formData" >
              </div>
             </div>
            <div class="form-group">
              <label class="col-lg-3 control-label"><i class="fa fa-asterisk text-required"/>支出时间</label>
              <div class="col-lg-3">
                <input type="text" id="paydate" name="paydate" class="form-control formData">
              </div>
            </div>
               <div class="form-group">
             	<label class="col-lg-2 control-label">原始单据</label>
               <div  class="col-lg-4">
               <input type="hidden" id="oldFile" name="oldFile" />
             	<input type="file" id ="billFile" name ="billFile"   class="form-control formData"/>
				</div>
				<div class="col-lg-4">
				<img id="billImg" width="30%" height="30%" name = "billImg">
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
