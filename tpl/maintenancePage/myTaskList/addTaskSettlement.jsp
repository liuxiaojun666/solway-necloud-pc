<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">      
	$(function() {
		$('#expectedtime').datetimepicker({
			format: "yyyy-mm-dd hh:ii",
			minView: 0,language: 'zh-CN',
			startDate:new Date(),
		   	autoclose: true
		});
		$("#editForm").validate( {
			rules : {
				pstationid:{
					required : true,
				},
				respman:{
					required : true,
				},
				expectedtime:{
					required : true
				},
				taskcontent:{
					required : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						hideModal("taskSettlementModal");
						goPage(0);
					},
					error : function(json) {
						promptObj('error','',"保存失败,请稍后重试!");
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
		getSelected(null);
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Optask/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#taskno").val(msg.taskno);
					$("#eventid").val(msg.eventid);
					$("#eventprocessid").val(msg.eventprocessid);
					$("#pstationid").val(msg.pstationid);
					$("#respman").val(msg.respman);
					$("#expectedtime").val(msg.expectedtime);
					$("#taskcontent").val(msg.taskcontent);
					$("#pstationname").val(msg.pstationname);
					if(msg.expectedtime != null && msg.expectedtime != ""  ){
						 var 	date = new Date(msg.expectedtime);						
						 var   year=date.getFullYear();     
			             var   month=date.getMonth()+1;     
			             var   day=date.getDate();
			             var   hour=date.getHours();
			             var   minute=date.getMinutes(); 
			             paydateStr=   year+"-"+month+"-"+day+" "+hour+":"+minute;
						$("#expectedtime").val(paydateStr);
					}
				}
			});
		}	
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
		    	 if($("#pstationid").val() != null && $("#pstationid").val() != "" ){
			    	 for(var i=0,len=$scope.station.length;i<len;i++){
						if($scope.station[i].id==  $("#pstationid").val()){
							$scope.stationd.selected= { stationname: $scope.station[i].stationname,id:  $("#pstationid").val()};
						}
					}
		    	 } else if(result.length==1){
		    		 $scope.stationd.selected= { stationname: $scope.station[0].stationname,id:  $scope.station[0].id};
		    		 $("#pstationid").val($scope.station[0].id);
		    	 }
		    	 $scope.textChange= function () {
			         $("#pstationid").val(angular.copy($scope.stationd.selected.id));
			         $("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
			         $scope.getUserList($scope.stationd.selected.id);
				} 
			}); 
			 //所属电站--------------------------end------------------------------------
			 //受理人==================start==========================================
			$scope.managerd = {};
	    	$scope.manager = null;
	    	$scope.getUserList = function(sid){
				$http({method:"POST",url:"${ctx}/AdminUser/selectAll.htm",params:{sid:sid}})
				.success(function (result) {
			    	 $scope.manager = result;
			    	 for(var i=0,len=$scope.manager.length;i<len;i++){
		 					if($scope.manager[i].userId==  $("#respman").val()){
		 						$scope.managerd.selected= { realName: $scope.manager[i].realName,userId:  $("#managerid").val()};
		 					}
		 				}
			    	 $scope.managerChange= function () {
				         $("#respman").val(angular.copy($scope.managerd.selected.userId));
					} 
				});
	    	}
	    	$scope.getUserList();
			//受理人=========================end=========================
		 }
	}]);
</script>
<div  ng-controller="PPStationCtrl" class="modal fade" id="taskSettlementModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div  class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">派工任务管理</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Optask/updateData.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <input type="hidden" name="taskno" id="taskno" class="formData"/>
          <input type="hidden" name="eventid" id="eventid" class="formData"/>
          <input type="hidden" name="eventprocessid" value="" id="eventprocessid" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">电站名称</label>
              <div class="col-lg-10">
              <ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname" >{{$select.selected.stationname}}</ui-select-match>
	            <ui-select-choices  repeat="item in station | filter: $select.search">
	              <div ng-bind-html="item.stationname | highlight: $select.search"></div>
	            </ui-select-choices>
	          </ui-select>
	          <input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
              <input type="hidden" id="pstationname" name="pstationname" class="form-control formData">
              </div>
             </div>
            <div class="form-group">   
              <label class="col-lg-2 control-label">受理人</label>
              <div class="col-lg-4">
	           	<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	              <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
 				<input type="hidden" id="respman" name="respman" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">期望时间</label>
              <div class="col-lg-4">
 					<input type="text" id="expectedtime" name="expectedtime" class="form-control formData">
              </div>
            </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">任务内容</label>
              <div style="margin-left: 100px">
              <textarea rows="8" cols="20" id="taskcontent" name="taskcontent" class="form-control formData"></textarea>
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
