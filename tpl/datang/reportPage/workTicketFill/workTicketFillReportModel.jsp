<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
.page-con{padding:20px 45px 10px;}
#requirement-con{display:none;margin-bottom:50px;}
#requirement-con p{font-size:12px;line-height: 2.2em;}
#requirement-con h4{font-size:16px;color:#1cb09a;margin-bottom: 30px;}
.require-btn{width: 88px;height:30px;line-height:30px;text-align:center;background:#1cb09a;color:white;font-size:12px;}
.require-btn-active{color:#1cb09a;border:1px solid #1cb09a;background:white;}
.form-input-con{margin-bottom:10px;}
.form-input-con .label-name{display:block;width:90px;height: 35px;line-height: 35px;}
.form-input-con input{height:35px;line-height:35px;}
.form-input-con input.small-input{width:76%;}
.form-input-con input.big-input{width:100%;    margin-bottom: 8px;}
.form-data-con .add-input-icon{width:26px;height:26px;text-align:center;color:white;font-size:29px;border-radius:50%;background:#1cb09a;display: inline-block;line-height: 26px;margin-right: 10px;}
.form-data-con .add-input-tip{    color: #1cb09a;line-height: 26px;height: 26px;display: inline-block;vertical-align: super;}
.width2-1{width:50%;}
.save-add-workticket{color:white;width:90px;height:45px;line-height:45px;text-align:center;background:#1cb09a;font-size:16px;}
.cancel-add-workticket{width:90px;height:45px;line-height:45px;text-align:center;background:white;border:1px solid #1cb09a;color:#1cb09a;font-size:16px;}
.date-time-con{
    border: 1px solid rgb(177,177,177);
    height: 35px;
    display: inline-block;
    line-height: 32px;
    width: 76%;text-align: left;}
.form-input-con select.small-select {
    width: 76%;
    height: 35px;
}
.fill-requirement{margin-bottom:15px;}
</style>
<div  ng-controller="dtfillReportPageCtrl" class="background-white page-con">
	<div class="fill-requirement">
		<p class="clearfix"><a class="pull-right require-btn  m-r-8" id="require-btn" ng-click="showFillRequirement()">填写要求</a></p>
		<div id="requirement-con">
			<h4 class="text-center">填写要求</h4>
			<p>一、工作票登记由工作许可人按工作票的生成顺序填写。</p>
			<p>二、填写时使用钢笔或碳素笔，字迹清晰工整、内容填写完整。</p>
			<p>三、严格执行工作票制度，每项工作必须有标准的工作票。</p>
			<p>四、工作票号登记时可以缩写，如北架风电场058D11308001可以写成001，下个月登记时，另起一页。</p>
			<p>五、工作终结，工作票交回，检查安全措施恢复，在备注栏中盖已执行章，工作票作废盖作废章。</p>
			<p>六、封面使用日期应填写此记录本开始使用日期。</p>
			<p>七、登记本vvv两个班组共同使用，保存期限为一年（备查）,每月由风场安全员对其检查并签字。</p>
		</div>
	</div>
	<div class="form-data-con">
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">票号</label>
					<div class="flex"><input type="text" name="ticketNum"  class="small-input" ng-model="formData.ticketNo"></div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;">
						<label class="label-name" style="right: 78%;position:absolute;text-align: left;">工作票类型</label>
					    <select  class="small-select" ng-model="formData.ticketType"  ng-options="o.dictValue as o.dictName for o in workTicketTypeList"></select>
					</div>
				</div>
			</div>
		</div>
		<div class="form-input-con h-box font14">
			<label class="label-name">工作任务</label>
			<div class="flex" id="workTaskList"></div>
		</div>
		<div class="clearfix" style="margin-bottom: 20px;"><a class="pull-right" ng-click="addWorkTaskInput()"><span class="add-input-icon">+</span><span class="add-input-tip">添加</span></a></div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">投票时间</label>
					<div class="flex">
						<span class="input-append date form_datetime date-time-con" id="changeTimeIdTimer-voteTime" data-link-field="voteTime">
							<input type="hidden"  id="voteTime"/>
							<span id="showVoteTime" class="showdate m-l m-r  font-h2" ng-bind="formData.acceptTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;">
						<label class="label-name" style="right: 78%;position:absolute;text-align: left;">许可时间</label>
						<span class="input-append date form_datetime date-time-con" id="changeTimeIdTimer-permitTime" data-link-field="permitTime">
							<input type="hidden"  id="permitTime"/>
							<span id="showPermitTime" class="showdate m-l m-r  font-h2" ng-bind="formData.allowTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">工作许可人</label>
					<div class="flex"><input type="text" name="workPermit" class="small-input" ng-model="formData.allowUser1"></div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">工作负责人</label><input type="text" name="inchargePerson" ng-model="formData.chargeUser1" class="small-input"></div>
				</div>
			</div>
		</div>
		<div class="clearfix">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">延期时间</label>
					<div class="flex">
						<span class="input-append date form_datetime date-time-con" id="changeTimeIdTimer-delayTime" data-link-field="delayTime">
							<input type="hidden"  id="delayTime"/>
							<span id="showDelayTime" class="showdate m-l m-r  font-h2" ng-bind="formData.delayTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">结束时间</label>
						<span class="input-append date form_datetime date-time-con" id="changeTimeIdTimer-endTime" data-link-field="endTime">
							<input type="hidden"  id="endTime"/>
							<span id="showEndTime" class="showdate m-l m-r  font-h2" ng-bind="formData.endTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">工作许可人</label>
					<div class="flex"><input type="text" name="workPermit1" class="small-input" ng-model="formData.allowUser2"></div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">工作负责人</label><input type="text" name="inchargePerson1" ng-model="formData.chargeUser2" class="small-input"></div>
				</div>
			</div>
		</div>
		<div class="form-input-con h-box font14" style="margin: 30px 0 20px;">
			<label class="label-name">备注</label>
			<div class="flex" >
				<textarea  name="workTask" style="width: 100%;height: 90px;" ng-model="formData.remark" ></textarea>
			</div>
		</div>
		<div class="clearfix" style="margin-bottom: 15px;"><a ng-click="cancel()" class="pull-right cancel-add-workticket">取消</a><a class="pull-right save-add-workticket" ng-click="saveAddWorkticket()" style="margin-right:12px;">保存</a></div>
	</div>
</div>
<script>
app.controller('dtfillReportPageCtrl',function($scope, $http, $state, $stateParams) {

	var rightDay2 = new Date();
	rightDay2.setDate(rightDay2.getDate() - 1);
	$scope.today = rightDay2;


	$scope.$on('fillItem', function(event,item) {
		$("#workTaskList").empty();
		$scope.getWorkTicketTypeList();
		var item = item[0];
		if(item != null){
			$scope.currentId = item.id;
			$scope.initPageData(item.id);
		}else{
			$scope.currentId = "";
			$scope.formData = {};
			$scope.voteTime = rightDay2;
			$scope.permitTime = rightDay2;
			$scope.delayTime = rightDay2;
			$scope.endTime = rightDay2;
		}
	});
	
	//查询单条记录数据
	$scope.initPageData = function(id){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdWorkTicket/selectById.htm",
	 		params : {
				id : id
			}
		 }).success(function(result) {
			 
			 $scope.formData = result.data;
			 
			 var content = ($scope.formData.content).split(",");
			 for(var i = 0;i<content.length;i++){
				 var tpl = '<input type="text" name="ticketNum" value="'+content[i]+'" class="big-input">';
				 if(content[i] != "" && content[i] != null && content[i] != undefined){
					 $("#workTaskList").append(tpl);
				 }
			 }

			$("#voteTime").val(new Date($scope.formData.acceptTime).Format("yyyy-MM-dd hh:mm:ss"));
			$("#permitTime").val(new Date($scope.formData.allowTime).Format("yyyy-MM-dd hh:mm:ss"));
			$("#delayTime").val(new Date($scope.formData.delayTime).Format("yyyy-MM-dd hh:mm:ss"));
			$("#endTime").val(new Date($scope.formData.endTime).Format("yyyy-MM-dd hh:mm:ss")); 
		 })
	}
	
	//显示隐藏填写要求
	$scope.showFillRequirement = function(){
		$("#requirement-con").toggle();
		$("#require-btn").toggleClass("require-btn-active")
	}
	
	//添加工作任务
	$scope.addWorkTaskInput = function(){
		var html = '<input type="text" name="ticketNum" class="big-input">';
		$("#workTaskList").append(html);
	}
	
	$scope.closeAddWorkticket = function(){
		if($scope.opTaskIdForWT){
	 		$('#handleWorkTicketId').modal('hide');
	 	}
	}
	
	//保存
	$scope.saveAddWorkticket = function(){
		var contentArr = [];
		var $contentInput = $("#workTaskList").find("input");
		for(var i = 0;i< $contentInput.length;i++){
			contentArr.push($contentInput[i].value);
		}
		var content = contentArr.join(",");//工作任务
		
		var voteTime = $("#voteTime").val();//四个时间
		var allowTime = $("#permitTime").val();
		var delayTime = $("#delayTime").val();
		var endTime = $("#endTime").val();
		
		$http({
	 		method : "POST",
	 		url : "${ctx}/rpdWorkTicket/update.htm",
	 		params : {
	 			id:$scope.currentId,
	 			ticketNo : $scope.formData.ticketNo,
	 			ticketType:$scope.formData.ticketType,
	 			content:content,
	 			acceptTime:voteTime,
	 			allowTime:allowTime,
	 			allowUser1:$scope.formData.allowUser1,
	 			chargeUser1:$scope.formData.chargeUser1,
	 			delayTime:delayTime,
	 			endTime:endTime,
	 			allowUser2:$scope.formData.allowUser2,
	 			chargeUser2:$scope.formData.chargeUser2,
	 			remark:$scope.formData.remark,
	 			stationId:$scope.pstationIdForWT,
	 			opTaskId:$scope.opTaskIdForWT
	 			
			}
		 }).success(function(result) {
				if(result.code == 0){
					promptObj('success', '', "保存成功");
					emit("listOrFill");
				}else if(result.code == 1){
					promptObj('error', '',"保存失败");
				}
			 	if($scope.opTaskIdForWT){
			 		$('#handleWorkTicketId').modal('hide');
			 	}
		 })
	}

	//查询工作票类型
	$scope.getWorkTicketTypeList = function(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdWorkTicket/selectByTicketTypes.htm",
		 }).success(function(result) {
			 $scope.workTicketTypeList = result.data;
		 })
	}

	$("#changeTimeIdTimer-voteTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.voteTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeIdTimer-voteTime").on('hide',function(ev) {
		var stringTime = $("#voteTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showVoteTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});
			
	$("#changeTimeIdTimer-permitTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.permitTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeIdTimer-permitTime").on('hide',function(ev) {
		var stringTime = $("#permitTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showPermitTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});
			
	$("#changeTimeIdTimer-delayTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.delayTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeIdTimer-delayTime").on('hide',function(ev) {
		var stringTime = $("#delayTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showDelayTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});
	
	$("#changeTimeIdTimer-endTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.endTime,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeIdTimer-endTime").on('hide',function(ev) {
		var stringTime = $("#endTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showEndTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});

	function emit(value){
		$scope.$emit("childPage",value);
	};

	//取消
	$scope.cancel = function(){
		emit("");
	}
});
function getDateForStringDate(strDate){
	//切割年月日与时分秒称为数组
	var s = strDate.split(" ");
	var s1 = s[0].split("-");
	var s2 = s[1].split(":");
	if(s2.length==2){
		s2.push("00");
	}
	return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
}
</script>
