<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
			rules : {
				teamStr:{ 
					required : true
				},
				startDate:{ 
					required : true
				},
				endDate:{ 
					required : true
				}
			},
			
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						$(".formData").val(""); 
						refreshList();
						promptObj('success','',"添加成功");
					},
					error : function(json) {
						promptObj('error','',"添加失败");
					}
				};
				$('#editForm').ajaxSubmit(options);
			} 
		});
	});
	
	function saveForm(){
		$("#editForm").trigger("submit"); 
	}
	
	//刷新列表
	function refreshList(){
		var appElement = document.querySelector('[ng-controller=manualSchedulingCtrl]');
		var $scope = angular.element(appElement).scope();
		$scope.schedulingList();	
	}
 
	app.controller('manualSchedulingCtrl', function($scope, $http,$state) {
		//后台查询班组信息
		$scope.opteam = {};
		
		$http({method:"POST",url:"${ctx}/opTeam/opTeamList.htm",params:{}})
		.success(function (result) {
	    	 $scope.opteamArr = result.data;
		}); 
		
		$scope.schedulingList = function(){
			$http({method:"POST",url:"${ctx}/scheduling/schedulingList.htm",params:{}})
			.success(function (result) {
		    	 $scope.schedulingData = result.data;
			}); 
		}
		
		$scope.schedulingList();
		
		$scope.gotoScheduling = function(){
			$state.go("app.scheduling");
		}
		
	});
	
</script>
<div ng-controller="manualSchedulingCtrl">
	<div class="wrapper-md bg-light b-b">
		<h1 class="m-n font-thin h3">人工排班</h1>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
		<!-- form 开始 -->
		<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/scheduling/manualUpdate.htm" method="post" id="editForm" name="editForm">
			<input type="hidden" name="id" value="" id="id" class="formData"/>
			
			<div class="form-group">
			
				<label class="col-lg-1 control-label">选择班组</label>
				<div class="col-lg-2">
		          <ui-select id="teamStr" name="teamStr" ng-model="opteamArr.selected" theme="bootstrap">
		            <ui-select-match placeholder="选择班组">{{$select.selected.teamName}}</ui-select-match>
		            <ui-select-choices repeat="item in opteamArr | filter: $select.search">
		              <div ng-bind-html="item.teamName | highlight: $select.search"></div>
		            </ui-select-choices>
		          </ui-select>
		          <input type="hidden" name="opTeamId" value="{{opteamArr.selected.teamId}}" class="form-control formData">
				</div>
				
				<label class="col-lg-1 control-label">起始日期</label>
				<div class="col-lg-2">
					<input  type="date" id="startdate" name="startdate" class="form-control formData" >
				</div>
				<label class="col-lg-1 control-label">结束日期</label>
				<div class="col-lg-2">
					<input type="date" id="enddate" name="enddate" class="form-control formData">
				</div>
				
	            <div class="col-lg-1">   
	                <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs  btn-info"><strong>添加</strong></button>
	   			 </div>
	            <div class="col-lg-1" >   
	                <button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="gotoScheduling();" ><strong>关闭</strong></button>
	   			</div>
			</div>
          </form>
		<!-- form 结束 -->
		<div class="col-sm-12 panel padder-l-sm no-padder" >
			<div class="panel-heading"></div>
			<table id="operator_table" class="table table-striped b-t b-light" style="align:'right'">
				<thead>
					<tr>
						<th>班组名称</th>
						<th>起始日期</th>
						<th>结束日期</th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="vo in schedulingData ">
						<td ng-bind="vo.teamName"></td>
						<td ng-bind="vo.startdate"></td>
						<td ng-bind="vo.enddate"></td>
					</tr>
				</tbody>
			</table>
		</div>
     </div>
     </div>
   </div>
 </div>
