<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
    <script type="text/javascript">
	$(function() {
		$('#startdate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		   	autoclose: true
		});
		$('#enddate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		    autoclose: true
		});
		$('#settledate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		    autoclose: true
		});
		$("#editForm").validate( {
			rules : {
				settlepowerv:{ 
					number: true,
					maxlength : 20
				},
				settlemoney:{ 
					number: true,
					maxlength : 20
				},
				settleman:{ 
					maxlength : 20
				},
				descp:{ 
					maxlength : 300
				},
				pstationid :{
					required : true
				},
				startdate :{
					required : true
				},
				enddate :{
					required : true
				},
				settledate :{
					required : true
				},
				settlepowerv :{
					required : true
				},
				settleman :{
					required : true
				},
				settlemoney :{
					required : true
				}
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
		app.controller('IncomeSettlementAddCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
			initPageData($stateParams.InId);  
			$scope.backIncomeSettlement = function(){
				$state.go('app.incomeSettlement');
			  }
		}]);
	});
	function saveForm(){
		 if($("#billFile").val()==""){
				$("#billFile").attr("disabled","disabled");
			}
		 var beginDate=$("#startdate").val();
		 var endDate=$("#enddate").val();
			if(beginDate && endDate){
				if(getDateToMs(beginDate)>getDateToMs(endDate)){
					alert("周期结束时间不小于周期开始时间");
							return false;
					}else{
						$("#editForm").trigger("submit"); 
					}
				}else{
				$("#editForm").trigger("submit"); 
			} 
		}
	
	function getDateToMs(date){
		Todate = date.replace(new RegExp("-","gm"),"/");
		var TimeMs=new Date(Todate).getTime();
		return TimeMs;
	}
	
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/IncomeSettlement/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#pstationid").val(msg.pstationid);
					$("#pstationname").val(msg.pstationname);
					if(msg.startdate != null && msg.startdate != ""  ){
						 var date = new Date(msg.startdate);						
						 var   year=date.getFullYear();     
			             var   month=date.getMonth()+1;     
			             var   date=date.getDate();     
			             startdateStr=   year+"-"+month+"-"+date;     
						$("#startdate").val(startdateStr);
					}
					
					if(msg.enddate != null && msg.enddate != ""  ){
						 var date = new Date(msg.enddate);						
						 var   year=date.getFullYear();     
			             var   month=date.getMonth()+1;     
			             var   date=date.getDate();     
			             enddateStr=   year+"-"+month+"-"+date;     
						$("#enddate").val(enddateStr);
					}
					
					if(msg.settledate != null && msg.settledate != ""  ){
						 var date = new Date(msg.settledate);						
						 var   year=date.getFullYear();     
			             var   month=date.getMonth()+1;     
			             var   date=date.getDate();     
			             settledateStr=   year+"-"+month+"-"+date;     
						$("#settledate").val(settledateStr);
					}
					
					$("#settlepowerv").val(msg.settlepowerv);
					$("#settlemoney").val(msg.settlemoney);
					$("#settleman").val(msg.settleman);
					$("#oldFile").val(msg.sourcebill);
					$("#descp").val(msg.descp);
					if(msg.sourcebill != null && msg.sourcebill !=""){
						$("#billImg").attr("src","${imgPath}/document/incomSourceBill/"+msg.sourcebill);
					}
				}
			});
		}		
		getSelected(null);
	}
	
	function getSelected(id){
		app.controller('PPStationCtrl', ['$http', '$scope', function($http, $scope){
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
							$scope.textChange();
						}
					}
		    	 } else if(result.length==1){
		    		 $scope.stationd.selected= { stationname: $scope.station[0].stationname,id:  $scope.station[0].id};
		    		 $scope.textChange();
		    	 } */
			}); 
	    	$scope.textChange= function () {
		         $("#pstationid").val(angular.copy($scope.stationd.selected.id));
		         $("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
		         $scope.getUserList($scope.stationd.selected.id);
			} 
			 //所属电站--------------------------end------------------------------------
		
		//结算人======================================================
			$scope.managerd = {};
	    	$scope.manager = null;
	    	$scope.getUserList = function(sid){
	    		$http({method:"POST",url:"${ctx}/AdminUser/selectAll.htm",params:{sid:sid}})
				.success(function (result) {
			    	 $scope.manager = result;
			    	 for(var i=0,len=$scope.manager.length;i<len;i++){
		 					if($scope.manager[i].userId==  $("#settleman").val()){
		 						$scope.managerd.selected= { realName: $scope.manager[i].realName,userId:  $("#settleman").val()};
		 					}
		 				}
			    	 $scope.managerChange= function () {
				         $("#settleman").val(angular.copy($scope.managerd.selected.userId));
					} 
				});
	    	}
	    	$scope.getUserList();
		}]);
	}
</script>
<div ng-controller="IncomeSettlementAddCtrl">
<div ng-controller="PPStationCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 m-n font-thin h3">电费结算管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			
		<div class="row wrapper">
		<!-- form 开始 -->
		<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/IncomeSettlement/update.htm" method="post" id="editForm" name="editForm" enctype="multipart/form-data">
          <input type="hidden" name="id" value="{{$stateParams.InId}}" id="id" class="formData"/>
             <div class="form-group">
              <label class="col-lg-2 control-label">电站名称</label>
              <div class="col-lg-4">
              	<input type="text" class="form-control formData" disabled ng-model="stationd.selected.stationname" />
	           	<!-- <ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
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
             <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>周期开始时间</label>
              <div  class="col-lg-2">
              <input    type="text" id ="startdate" name ="startdate"   class="form-control formData"/>
              </div>
              <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>周期结束时间</label>
               <div  class="col-lg-2">
             	 <input    type="text" id ="enddate" name ="enddate"   class="form-control formData"/>
              </div>
              <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>结算时间</label>
               <div  class="col-lg-2">
             	 <input    type="text" id ="settledate"  name ="settledate"  class="form-control formData"/>
              </div>
            </div>
            <div class="form-group">
             <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>结算电量 (kW)</label>
              <div  class="col-lg-2">
              <input    type="text" id ="settlepowerv" name ="settlepowerv" maxlength="20"  class="form-control formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"/>
              </div>
              <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>结算金额 (元)</label>
               <div  class="col-lg-2">
             	 <input    type="text" id ="settlemoney" name ="settlemoney" maxlength="20"  class="form-control formData" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"/>
              </div>
              <label class="col-lg-2 control-label">结算人</label>
               <div  class="col-lg-2">
              	<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	              <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
	         	  <input  type="hidden" id ="settleman" name ="settleman"   class="form-control formData"/>
              </div>
            </div>
             <div class="form-group">
             	<label class="col-lg-2 control-label">原始单据</label>
               <div  class="col-lg-2">
               <input type="hidden" id="oldFile" name="oldFile" />
             	<input type="file" id ="billFile" name ="billFile"   class="form-control formData"/>
				</div>
				<div class="col-lg-4">
				<img id="billImg" width="30%" height="30%" name = "billImg">
			  </div>
              </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">其它说明</label>
                <div class="col-lg-8">
                  <textarea id="descp" name="descp" maxlength="300"class="form-control formData"></textarea>
             	</div>
             </div>
	          
             <div class="form-group m-t-lg">
            <div class="col-lg-12 text-center">   
            <button type="button" onclick="saveForm();" id="saveButton" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
                <button id="cancelBtn" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" ng-click="backIncomeSettlement();"><strong>取消</strong></button>
                 
   			 </div>
   			 </div>
          </form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
 </div>
