<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">    
	function cllarverifyhandleCT(){
		var pstationid=$("#pstationidCT").val();
		var respman=$("#respmanCT").val();
		var expectedtime=$("#expectedtimeCT").val();
		var taskcontent=$("#taskcontentCT").val();
		
		if(pstationid){
		   $("#pstationidverifyCT").html("");	
		}
		
		if(respman){
		   $("#respmanverifyCT").html("");	
		}
		
		if(expectedtime){
		   $("#expectedverifyCT").html("");
		}
		
		if(taskcontent){
		   $("#taskcontentverifyCT").html("");
		}
	}
	
	function clearHandleCTInfo(){
	   $("#pstationidverifyCT").html("");	
	   $("#respmanverifyCT").html("");	
	   $("#expectedverifyCT").html("");
	   $("#taskcontentverifyCT").html("");
	   
	   $("#pstationidCT").val(null);
	   $("#respmanCT").val(null);
	   $("#expectedtimeCT").val(null);
	   $("#taskcontentCT").val(null);
	   
	   $("#expectedtimeCT").datetimepicker({
			language: 'zh-CN',
	    	format: "yyyy-mm-dd hh:00",
	    	minView : 1,
	    	autoclose: true,
	    	todayBtn: true,
	    	pickerPosition: "bottom-left"
		});
		
		$("#expectedtimeCT").datetimepicker('setStartDate',new Date().Format("yyyy-MM-dd hh:mm"));
	}
</script>
<div  class="modal fade noteModal "id="createTask" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	<div class="modal-dialog row">
		<div class="modal-content ">
	     	<div class="modal-header">
	     		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	     		<h4 class="modal-title font-h3" id="myModalLabel">
	       			<span >手工派工任务</span>
	     		</h4>
			</div>
	     	<div class="modal-body ">
				<form class="bs-example form-horizontal" >
		          	<div class="form-group">
		              	<label class="col-sm-2 control-label">电站名称</label>
		              	<div class="col-sm-9">
			              	<ui-select ng-model="stationdCT.selected" theme="bootstrap" ng-change="textChangeCT()">
				             	<ui-select-match placeholder="请输入关键字..." ng-model="stationdCT.selected.stationname" >{{$select.selected.stationname}}</ui-select-match>
				            	<ui-select-choices  repeat="item in stationCT | filter: $select.search">
				              		<div ng-bind-html="item.stationname | highlight: $select.search"></div>
				            	</ui-select-choices>
				          	</ui-select>
				          	<input type="hidden" id="pstationidCT" name="pstationidCT" onMouseOut="cllarverifyhandle01()" class="form-control formData">
			              	<input type="hidden" id="pstationnameCT" name="pstationnameCT" class="form-control formData">
			              	<div  id="pstationidverifyCT" class="control-label m-t-sm black-1 no-padder"></div>
		              	</div>
		            </div>
		             <div class="form-group">
		              <label class="col-sm-2 control-label">受理人</label>
		              <div class="col-sm-5">
			           	<ui-select ng-model="managerdCT.selected" theme="bootstrap" ng-change="managerChangeCT()">
			            <ui-select-match placeholder="请输入关键字..." ng-model="managerdCT.selected.realName" >{{$select.selected.realName}}</ui-select-match>
			            <ui-select-choices  repeat="item in managerCT | filter: $select.search">
			              <div ng-bind-html="item.realName | highlight: $select.search"></div>
			            </ui-select-choices>
			         	 </ui-select>
		 				<input type="hidden" id="respmanCT" name="respmanCT" onMouseOut="cllarverifyhandle01()" class="form-control formData">
		              <div  id="respmanverifyCT" class="control-label m-t-sm black-1 no-padder"></div>
		              </div>
		             </div>
		             <div class="form-group">
		              <label class="col-sm-2 control-label">期望完成时间</label>
		              <div class="col-sm-5">
		 					<input type="text" id="expectedtimeCT" name="expectedtimeCT" class="form-control formData" onchange="cllarverifyhandleCT()">
		 				<div  id="expectedverifyCT" class="control-label m-t-sm black-1 no-padder"></div>
		              </div>
		            </div>
		              <div class="form-group">
		              <label class="col-sm-2 control-label">任务内容</label>
		              <div style="margin-left: 100px" class="col-sm-8">
		              <textarea rows="8" cols="20" id="taskcontentCT" maxlength="200" name="taskcontentCT" class="form-control formData" onMouseOut="cllarverifyhandleCT()"></textarea>
		              <div  id="taskcontentverifyCT" class="control-label m-t-sm black-1 no-padder"></div>
		              </div>
		              </div>
		             <div class="form-group">
	            	 <div class="col-sm-12 text-center" >
	            		<button type="button" ng-click="saveTaskForm()"  id="btnCT"
							class="btn m-b-xs w-xs taskBtn" data-loading-text="保存中..." autocomplete="off">
							<strong>保 存</strong>
						</button>
						<button type="button" data-dismiss="modal" aria-hidden="true"
							class="btn m-b-xs w-xs btn-default" style="margin-left:5px">
							取 消
						</button>
	   			 	</div>
				</div>
	   			 </form>
			</div>
		</div>
	</div>
</div>
