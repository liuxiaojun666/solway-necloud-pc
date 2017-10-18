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
</style>
<div  ng-controller="dtOperationTicketfillCtrl" class="background-white page-con">
	<div class="fill-requirement">
		<p class="clearfix"><a class="pull-right require-btn  m-r-8" id="require-btn" ng-click="showFillRequirement()">填写要求</a></p>
		<div id="requirement-con">
			<h4 class="text-center">填写要求</h4>
			<p>一、操作票登记由操作人按操作票的生成顺序填写。</p>
			<p>二、填写时使用钢笔或碳素笔，字迹清晰工整、内容填写完整。</p>
			<p>三、严格执行操作票制度，每项工作必须有标准的操作票。</p>
			<p>四、工作终结，操作票交回，确认无误，在执行情况栏中盖已执行章，操作票作废盖作废章。</p>
			<p>五、封面使用日期应填写此记录本开始使用日期。</p>
			<p>六、登记本保存期限为一年（备查）,每月由安全员对其检查并签字。</p>
		</div>
	</div>
	<div class="form-data-con">
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">操作票票号</label>
					<div class="flex"><input type="text" name="ticketNum" class="small-input"  ng-model="formData.ticketNo"></div>
				</div>
			</div>
		</div>
		<div class="form-input-con h-box font14">
			<label class="label-name">操作任务</label>
			<div class="flex" id="workTaskList"></div>
		</div>
		<div class="clearfix" style="margin-bottom: 20px;"><a class="pull-right" ng-click="addWorkTaskInput()"><span class="add-input-icon">+</span><span class="add-input-tip">添加</span></a></div>
		<div class="clearfix ">
			<div class="clearfix ">
				<div class="width2-1 pull-left">
					<div class="form-input-con h-box font14">
						<label class="label-name">操作人</label>
						<div class="flex"><input type="text" name="workPermit" class="small-input" ng-model="formData.operationUser"></div>
					</div>
				</div>
				<div class="width2-1 pull-left ">
					<div class="form-input-con h-box font14">
						<label class="label-name"></label>
						<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">监护人</label>
							<input type="text" name="inchargePerson" class="small-input" ng-model="formData.guardianUser"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">操作开始时间</label>
					<div class="flex">
						<span class="input-append date form_datetime date-time-con" id="changeTimeId-operStartTime" data-link-field="operStartTime">
							<input type="hidden"  id="operStartTime"/>
							<span id="showOperStartTime" class="showdate m-l m-r  font-h2" ng-bind="formData.startTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;">
						<label class="label-name" style="right: 78%;position:absolute;text-align: left;">操作结束时间</label>
						<span class="input-append date form_datetime date-time-con" id="changeTimeId-operEndTime" data-link-field="operEndTime">
							<input type="hidden"  id="operEndTime"/>
							<span id="showOperEndTime" class="showdate m-l m-r  font-h2" ng-bind="formData.endTime | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix ">
			<div class="width2-1 pull-left">
				<div class="form-input-con h-box font14">
					<label class="label-name">值班负责人</label>
					<div class="flex"><input type="text" name="workPermit1" class="small-input" ng-model="formData.chiefUser"></div>
				</div>
			</div>
			<div class="width2-1 pull-left ">
				<div class="form-input-con h-box font14">
					<label class="label-name"></label>
					<div class="flex text-right" style="position:relative;"><label class="label-name" style="right: 78%;position:absolute;text-align: left;">执行情况</label>
					<input type="text" name="inchargePerson1" class="small-input" ng-model="formData.remark"></div>
				</div>
			</div>
		</div>
		<div class="clearfix" style="margin-bottom: 15px;"><a  class="pull-right cancel-add-workticket" ng-click="cancel()">取消</a><a class="pull-right save-add-workticket" ng-click="saveAddWorkticket()" style="margin-right:12px;">保存</a></div>
	</div>
</div>
<script>
app.controller('dtOperationTicketfillCtrl',function($scope, $http, $state, $stateParams) {

	var rightDay2 = new Date();
	rightDay2.setDate(rightDay2.getDate() - 1);
	$scope.today = rightDay2;
	//$scope.startTime = rightDay2;
	//$scope.endTime = rightDay2;

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
			$("#operStartTime").val("");
			$("#operEndTime").val("");
		}
	});
	
	//编辑时查询记录数据
	$scope.initPageData = function(id){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdOperateTicket/selectById.htm",
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

			$("#operStartTime").val(new Date($scope.formData.startTime).Format("yyyy-MM-dd hh:mm:ss"));
			$("#operEndTime").val(new Date($scope.formData.endTime).Format("yyyy-MM-dd hh:mm:ss")); 
		 })
	}
	
	//查询工作票类型
	$scope.getWorkTicketTypeList = function(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpdOperateTicket/selectByTicketTypes.htm",
		 }).success(function(result) {
			 $scope.ticketType = result.data[0].dictValue;
		 })
	}
	
	//保存
	$scope.saveAddWorkticket = function(){
		var contentArr = [];
		var $contentInput = $("#workTaskList").find("input");
		for(var i = 0;i< $contentInput.length;i++){
			contentArr.push($contentInput[i].value);
		}
		var content = contentArr.join(",");//工作任务

		var startTime = $("#operStartTime").val();
		var endTime = $("#operEndTime").val();
		
		$http({
	 		method : "POST",
	 		url : "${ctx}/rpdOperateTicket/update.htm",
	 		params : {
	 			id:$scope.currentId,
	 			ticketNo : $scope.formData.ticketNo,
	 			ticketType:$scope.ticketType,
	 			content:content,
	 			operationUser:$scope.formData.operationUser,
	 			guardianUser:$scope.formData.guardianUser,
	 			startTime:startTime,
	 			endTime:endTime,
	 			chiefUser:$scope.formData.chiefUser,
	 			remark:$scope.formData.remark
	 			
			}
		 }).success(function(result) {
				if(result.code == 0){
					promptObj('success', '', "保存成功");
					emit("listOrFill");
				}else if(result.code == 1){
					promptObj('error', '',"保存失败");
				}
			 
		 })
	}

	$("#changeTimeId-operStartTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate :  $scope.today,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeId-operStartTime").on('hide',function(ev) {
		var stringTime = $("#operStartTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showOperStartTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});

	$("#changeTimeId-operEndTime").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm-dd hh:mm:ss",
		//minView : 2,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.today,
		pickerPosition : "bottom-left"
	});
	$("#changeTimeId-operEndTime").on('hide',function(ev) {
		var stringTime = $("#operEndTime").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$("#showOperEndTime").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
		}
	});

				
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
