<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript">
$(function() {
	getFaultNohandReason();
});
app.controller('faultHandCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
	showGoBackFlag();
	getFault($stateParams.faultId,$scope);
	$scope.viewHistoryData = function(){
		var deviceType = $("#deviceType").val();
		var deviceId = $("#deviceId").val();
		var pstationid = $("#pstationid").val();
	//  1:汇流箱    2:逆变器：3:箱变  4:电能表  5:气象仪
    	if(deviceType==1){
    		$state.go("app.junctionBoxMonitor", {
				InId : deviceId,
				pstationid : pstationid
			});
    	}else if(deviceType==2){
    		$state.go("app.inverterDetail", {
				InId : deviceId,
				pstationid : pstationid
			});
    	}else if(deviceType==3){
    		$state.go("app.BoxChangeDetail", {
    			InId : deviceId,
				pstationid : pstationid
			});
    	}else if(deviceType==5){
    		$state.go("app.otherDeviceDetail", {
    			InId : deviceId,
				pstationid : pstationid
			});
    	}
	}
	$scope.$on('$stateChangeStart', function(event){
		hideGoBackFlag();
	});
	//检修任务单
	$http({method:"POST",url:"${ctx}/Optask/selectByFaultAlarmId.htm",
		params:{faultId:$stateParams.faultId}})
    .success(function (result) {
    	 $scope.taskList = result;
    	 $("#expectedtime").datetimepicker({
    			language: 'zh-CN',
    	    	format: "yyyy-mm-dd hh:ii",
    	    	autoclose: true,
    	    	todayBtn: true,
    	    	pickerPosition: "bottom-left"
    		});
	}).error(function (result) {
	 $("#expectedtime").datetimepicker({
			language: 'zh-CN',
	    	format: "yyyy-mm-dd hh:ii",
	    	autoclose: true,
	    	todayBtn: true,
	    	pickerPosition: "bottom-left"
		});
	});
	$scope.backFaultList = function(){
		if($stateParams.backUrl==4){
			$state.go('app.devicerunLog');
		}else if($stateParams.backUrl==5){
			$state.go('app.basemessage',{recuserId	:$stateParams.recuserId});
		}else{
			$state.go('app.faultalarm',{tabId	:$stateParams.tabId});			
		}
	}
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
	    		 $("#respmanverify").html("");	
		         $("#respman").val(angular.copy($scope.managerd.selected.userId));
			} 
		});
	}
	//$scope.getUserList();
}]);

//提交验证
function saveTaskForm(){
	var respman=$("#respman").val();
	var expectedtime=$("#expectedtime").val();
	var taskcontent=$("#taskcontent").val();
	if(respman && expectedtime && taskcontent){
		addTask();
	}else{
		if(!respman){
		$("#respmanverify").html("<font color='#FF0000'>处理人不可为空</font>");
	}
		
	if(!expectedtime){
		$("#expectedverify").html("<font color='#FF0000'>时间不可为空</font>"); 
		}
	
	if(!taskcontent){
		$("#taskcontentverify").html("<font color='#FF0000'>内容不可为空</font>"); 
		}
	}
	//$("#addTaskForm").trigger("submit");
}

//表单有值时，清除验证提示信息
function cllarverify(){
	var respman=$("#respman").val();
	var expectedtime=$("#expectedtime").val();
	var taskcontent=$("#taskcontent").val();
	
	if(respman){
	$("#respmanverify").html("");	
	}
	
	if(expectedtime){
	$("#expectedverify").html("");
	}
	
	if(taskcontent){
	$("#taskcontentverify").html("")	
	}
}
//处理故障
function addTask(){
	$.ajax({
		type:"post",
		url:"${ctx}/FaultHand/faultHand.htm",
		data:{
			"eventid":$("#faultId").val(),
			"respman":$("#respman").val(),
			"expectedtime":$("#expectedtime").val(),
			"remindtime":$("#remindTime").val(),
			"taskcontent":$("#taskcontent").val()},
		success:function(msg){
			if(msg.id==-1){
				promptObj('error','',msg.message);
			}else{
				promptObj('success','',msg.message);
				$("#backFaultListBtn").trigger("click");
			}
		},error : function(json) {
// 			alert("保存失败,请稍后重试!");
			promptObj('error','',"保存失败,请稍后重试!");
		}
	});
}
function saveNoHandForm(){
	//$("#addTaskForm").trigger("submit");
	addNoHandReason();
}
//不处理
function addNoHandReason(){
	//alert($("#noHandReasonId").val());
	$.ajax({
		type:"post",
		url:"${ctx}/FaultHand/noHand.htm",
		data:{
			"handclosereasonId":$("#noHandReasonId").val(),
			"deviceLogId":$("#faultId").val(),
			"reasonType":$("#reasonType").val(),
			"handclosereason":$("#handclosereason").val()},
		success:function(msg){
			if(msg.id==-1){
				promptObj('error','',msg.message);
			}else{
				promptObj('success','',msg.message);
//	 			alert(msg.message);
				$("#backFaultListBtn").trigger("click");
			}
		},error : function(json) {
			//alert("保存失败,请稍后重试!");
			promptObj('error','',"保存失败,请稍后重试!");
		}
	});
}
//查询故障
function getFault(id,$scope){
	//alert(id);
	$("#faultId").val(id);
	$.ajax({
		type:"post",
		url:"${ctx}/FaultHand/getFaultAlarmById.htm",
		data:{"id":id},
		success:function(msg){
			$scope.fault = msg;
			$scope.getUserList($scope.fault.pstationid);
			$("#stationDiv").text(msg.pstationname);
			var showName = '';
			if(msg.devicetypeStr){
				showName = msg.devicetypeStr;
			}
			if(msg.devicename){
				showName+=msg.devicename;
				$("#viewHistoryDataDiv").show();
			}else{
				showName+=msg.pstationname;
				$("#viewHistoryDataDiv").hide();
			}
			$("#deviceNameSp").text(showName);
			if(msg.faultlevelStr){
				$("#faultLevelSp").text(msg.faultlevelStr);
			}else if(msg.eventType==-9){
				$("#faultLevelSp").text("通讯中断");
			}
			$("#faultStatusSp").text(msg.sysstatusStr);
			$("#faultHourSp").text(msg.faultHour+"个小时");
			
			$("#repairTabTitle").text("检修任务单("+msg.handstatusStr+")");

			$("#faultLevelTd").text((msg.faultlevelStr==null||msg.faultlevelStr=="") ?"-":msg.faultlevelStr);
			$("#devicenameTd").text((msg.devicename==null||msg.devicename=="") ?"-":msg.devicename);
			$("#faultcodeTd").text((msg.eventCode==null||msg.eventCode=="") ?"-":msg.eventCode);
			$("#faultclassTd").text((msg.faultclassStr==null||msg.faultclassStr=="") ?"-":msg.faultclassStr);
			$("#faultdescTd").text((msg.eventDesc==null||msg.eventDesc=="") ?"-":msg.eventDesc);
			
			$("#deviceId").val(msg.deviceId);
			$("#deviceType").val(msg.deviceType);
			$("#pstationid").val(msg.pstationid);
			//msg.handStatus = '04';
			if("00"==msg.handStatus||"01"==msg.handStatus){//待确认-待派工
				$("#faultHandTab").show();
				$("#taskHandTab").hide();
				$("#taskListTab").hide();
				$("#faultHandDiv").show();
				$("#faultHandDiv2").hide();
				//angular.element("#taskHandTabTitle").trigger("click");
			} else if("02"==msg.handStatus||"03"==msg.handStatus){//待处理
				$("#faultHandTab").hide();
				$("#taskHandTab").hide();
				$("#taskListTab").show();
				angular.element("#taskListTabTitle").trigger("click");
			} else if("04"==msg.handStatus){//处理完成
				$("#faultHandTab").hide();
				$("#taskHandTab").hide();
				$("#taskListTab").show();
				angular.element("#taskListTabTitle").trigger("click");
			} else if("05"==msg.handStatus){//不处理
				$("#faultHandTab").hide();
				$("#tabDiv").hide();
				$("#taskHandTab").hide();
				$("#taskListTab").hide();
				$("#faultHandDiv").hide();
				$("#faultHandDiv2").show();
				$("#handclosereasonShow").text(msg.faultHand.handclosereason==null?"":msg.faultHand.handclosereason);
				$("#confirmdateShow").text(msg.faultHand.confirmdateStr);
				$("#confirmmanNameShow").text(msg.faultHand.confirmmanName);
			}
		}
	});
}
function viewHsData(devCode){
	showModal("deviceHsdataModal");
	goPage(0);
}
function showModal(modalId){
	$('#'+modalId).modal('show');
}
function hideModal(modalId){
	$('#'+modalId).modal('hide');
}
function choseReason(reasonId){
	$("#writeOtherReason").removeClass("writeOtherReason");
	$("#"+reasonId).parent().siblings().children().removeClass('writeOtherReason');
	$("#"+reasonId).addClass("writeOtherReason");
	if($("#noHandReasonId").val()==reasonId){
		$("#noHandReasonId").val(null);
		$("#reasonType").val("");
	}else{
		$("#noHandReasonId").val(reasonId);
		$("#reasonType").val("0");
		$("#otherReasonDiv").hide();
	}
}
function writeOtherReason(){
	$("#writeOtherReason").addClass("writeOtherReason");
	$("#noHandReasonUl").children().children().removeClass('writeOtherReason');
	$("#otherReasonDiv").show();
	$("#reasonType").val("1");
}
function choseRemindHour(hour,obj){
	$(obj).parent().siblings().removeClass('timeActive');
	$(obj).parent().addClass('timeActive');
	if($("#remindTime").val()==hour){
		$("#remindTime").val(null);
	} else {
		$("#remindTime").val(hour);
	}
}
function getFaultNohandReason(){
	$("#noHandReasonUl").empty();
	$.ajax({
		type:"post",
		url:"${ctx}/FaultHand/getFaultNohandReason.htm",
		//data:{"treeLevel":level,"parentId":parentId},
		dataType : "json",
		async: false,
		success:function(msg){
			for(var i=0;i<msg.length;i++){
				$("#noHandReasonUl").append('<li><a onclick="choseReason('+msg[i].id+')"; id="'+msg[i].id+'"class="b-a">'+msg[i].dictName+'</a></li>');
			}
		}
	});
}
</script>
	<div class="hbox hbox-auto-xs hbox-auto-sm ng-scope" ng-init=" app.settings.asideFolded = false; app.settings.asideDock = false;"
		  ng-controller="faultHandCtrl">
<button id="backFaultListBtn" type="button" style="display: none;" ng-click="backFaultList();"><strong>取消</strong></button>
		      <input type="hidden" id="faultId" name="faultId"/>
    <input type="hidden" id="remindTime" name="remindTime" value="0"/>
    <input type="hidden" id="noHandReasonId" name="noHandReasonId"/>
    <input type="hidden" id="reasonType" name="reasonType" value="1"/>
    <input type="hidden" id="deviceId" name="deviceId"/>
    <input type="hidden" id="deviceType" name="deviceType"/>
    <input type="hidden" id="pstationid" name="pstationid"/>
  <!-- 导航开始 -->
			<div class="bg-light lter b-b wrapper">
				<div class="row">
					<div class="col-sm-6 col-xs-12 font-bold">
						<span class="font-h1 blue-1 m-n text-black" id="stationDiv"></span>
						<div class="m-t-xs text-base">
							<span class="black-1"  id="deviceNameSp"></span>
							<span class="black-1">发生</span>
							<span style="color: #cc2822"  id="faultLevelSp"></span>
							<span class="m-l-xs black-2">故障状态
								<span class="black-1" id="faultStatusSp"></span>
							</span> 
							<span class="m-l-xs black-2">故障已存在 
								<span class="black-1"  id="faultHourSp"></span>
							</span>
						</div>
					</div>
				</div>
			</div>
			<!-- 导航结束 -->
			<!-- 故障信息 开始-->
				<div class="ng-scope wrapper-md ">
	<div class="panel " style="margin-bottom: 0px;">
<!-- 	<div class="row m-l-xs"> -->
<!-- 	<h4 class="m-b">故障信息</h4> -->
<!-- 	</div> -->
		<div class="row m-l-sm">
		<div class="col-sm-12 ">
               <div class="col-sm-3 wrapper-xs">故障级别：<span id="faultLevelTd"></span></div>
               <div class="col-sm-3 wrapper-xs">故障设备：<span id="devicenameTd"></span></div>
              <div class="col-sm-3 wrapper-xs">故障类型：<span id="faultclassTd"></span></div>
              <div class="col-sm-5 wrapper-xs">故障码：<span id="faultcodeTd"></span></div>
              <div class="col-sm-10 wrapper-xs">故障描述：<span id="faultdescTd"></span></div>
              <div id="viewHistoryDataDiv" class="col-sm-10 wrapper-xs"><a class="href-blur font-h4 col-sm-12 no-padder" ng-click="viewHistoryData();">查看设备实时状态</a></div>
          </div>
		</div>
		</div></div>
		<div class="ng-scope wrapper-md " style="padding-top: 0px;">
	<div id="faultHandDiv2" style="display: none;" class="panel panel-default wrapper-md ">
		<div class="row m-l-sm">
          <div class="col-sm-12 no-padder">
          	  <div class="col-sm-12 black-1 font-h1 wrapper-xs">故障已关闭</div>
          	  <div class="col-sm-1 wrapper-xs text-right">关闭人：</div>
          	  <div class="col-sm-1 wrapper-xs"><span id="confirmmanNameShow">11</span></div>
              <div class="col-sm-1 wrapper-xs text-right">关闭时间：</div>
              <div class="col-sm-9 wrapper-xs"><span id="confirmdateShow">11</span></div>
              <div class="col-sm-1 wrapper-xs text-right">不处理原因：</div>
              <div class="col-sm-11 wrapper-xs"><span id="handclosereasonShow">11</span></div>
		</div> 
	</div>
	</div>	
			<!-- 故障信息 结束-->
		<div id="tabDiv" class="m-t-sm">
			<tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
			<!-- 故障处理-派工开始 --> 
			<tab id="faultHandTab"> 
				<tab-heading>
				 	<span id="faultHandTabTitle" class="wrapper-sm white-1 a-cur-poi "> 故障确认 </span>
				 </tab-heading>
				 <div class="col-sm-6 text-center m-t"></div>
				 <div id="faultHandDiv" class="b-l col-sm-12 dealTabs">
						
							<tabset class="col-sm-12 nav-tabs-alt"> <!-- 立即处理开始 -->
							<tab> <tab-heading> <a
								class="wrapper-sm a-cur-poi"> 立即处理 </a> </tab-heading>
								<hr class="col-sm-5 no-padder m-b-sm" style="width:270px">
							<div class="col-sm-12 wrapper-md panel ">
								<p class="font-h3 black-2">故障指派</p>
								<form
									class="col-sm-12 no-padder bs-example form-horizontal ng-pristine ng-valid">
									<div class="black-2">
										<div class="form-group m-t">
											<label class="col-sm-2 black-1 m-t-sm control-label no-padder">故障处理人</label>
											<div class="col-sm-3 select">
												<input type="hidden" onMouseOut="cllarverify()" id="respman" name="respman" class="form-control formData"/>
	           	<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	              <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
											</div>
	         	 <div  id="respmanverify" class="col-sm-1 control-label m-t-sm black-1 no-padder"></div>
										</div>
										<div class="form-group m-t">
											<label class="col-sm-2 control-label m-t-sm black-1 no-padder">期望完成时间</label>
											<div class="col-sm-3">
   					 							<input class="form-control" onchange="cllarverify()" style="border: 1px solid #cfdadd;" id="expectedtime" name="expectedtime" type="text" value=""  >
											<div id="expectedverify"/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label m-t-sm black-1 no-padder">故障再提醒</label>
											<div class="col-sm-10">
													<ul class="nav nav-pills">
														<li class="timeActive"><a onclick="choseRemindHour(0,this);" class="b-a">不提醒</a></li>
														<li><a onclick="choseRemindHour(1,this);" class="b-a">一小时后</a></li>
														<li><a onclick="choseRemindHour(3,this);" class="b-a">三小时后</a></li>
														<li><a onclick="choseRemindHour(6,this);" class="b-a">六小时后</a></li>
														<li><a onclick="choseRemindHour(9,this);" class="b-a">九小时后</a></li>
													</ul>
<!-- 												<select id="remindTime" name="remindTime"> -->
<!--       												<option value="">请选择</option> -->
<!--       												<option value="1">一小时后</option> -->
<!--       												<option value="3">三小时后</option> -->
<!--       												<option value="6">六小时后</option> -->
<!--       												<option value="9">九小时后</option> -->
<!--       											</select> -->
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label m-t-sm  black-1 no-padder">任务内容</label>
											<div class="col-sm-8">
												<textarea id="taskcontent" onMouseOut="cllarverify()" name="taskcontent" maxlength="200" class="form-control formData" rows="5"></textarea>
											<div id="taskcontentverify"/>
											</div>
										</div>
									</div>
									<!-- <div class="col-sm-5">
										<div class="form-group">
											<label class="col-sm-3 control-label black-1">任务内容</label>
											<div class="col-sm-9">
												<textarea id="taskcontent" name="taskcontent" maxlength="200" class="form-control formData" rows="5"></textarea>
											</div>
										</div>
									</div> -->
									<div class="col-sm-12 no-padder m-l-xs">
										<button onclick="saveTaskForm();" class="col-sm-offset-2 m-t-lg btn submit-btnt ">提交</button>
									</div>
								</form>
							</div>
							</tab> <!-- 立即处理结束 --> <!-- 不处理开始 --> <tab> <tab-heading>
							<span class="wrapper-sm  a-cur-poi ">不处理</span> </tab-heading>
							<hr class="col-sm-5 no-padder m-b-sm ng-scope" style="width:270px">
							<div class="wrapper-md panel padder col-sm-12 ">
								<div class="m-b-lg text-md col-sm-12 no-padder">
									<p class="black-3 font-h3 col-sm-12 no-padder">不处理故障原因</p>
									<div class="col-sm-12 padder">
										<ul class="nav nav-pills nav-choose" id="noHandReasonUl">
<!-- 											<li><a onclick="choseReason(0);" class="b-a">选择原因1</a></li> -->
<!-- 											<li><a onclick="choseReason(1);" class="b-a">选择原因2</a></li> -->
<!-- 											<li><a onclick="choseReason(2);" class="b-a">选择原因3</a></li> -->
<!-- 											<li><a onclick="choseReason(3);" class="b-a">选择原因4</a></li> -->
<!-- 											<li><a onclick="choseReason(4);" class="b-a">选择原因5</a></li> -->
<!-- 											<li><a onclick="choseReason(5);" class="b-a">选择原因6</a></li> -->
										</ul>
									</div>
									<div class="col-sm-12 padder">
										<ul class="nav nav-pills nav-choose">
											<li><a id="writeOtherReason" class="writeOtherReason" onclick="writeOtherReason();" class="b-a">其他原因</a></li>
										</ul>
									</div>
									<div id="otherReasonDiv" class="col-sm-8 padder">
										<textarea rows="5" id="handclosereason" name="handclosereason" maxlength="50" class="form-control formData" placeholder="其他原因"></textarea>
									</div>
									<div class="col-sm-12 padder">
										<button onclick="saveNoHandForm();" class="m-t-lg btn submit-btnt ">提交</button>
									</div>
								</div>
							</div>
							</tab> <!-- 不处理结束 --> </tabset>
						</div>
			</tab>
			<!-- 故障处理-派工结束 --> 
			<!-- 故障处理-处理任务开始 -->
			<tab id="taskHandTab"> 
				<tab-heading>
				 	<span id="taskHandTabTitle" class="wrapper-sm white-1 a-cur-poi "> 故障处理 </span>
				 </tab-heading>
				 <div class="col-sm-6 text-center m-t"></div> 
			</tab>
			<!-- 故障处理-处理任务结束 --> 
			<!-- 故障处理-处理任务开始 -->
			<tab id="taskListTab"> 
				<tab-heading>
				 	<span id="taskListTabTitle" class="wrapper-sm white-1 a-cur-poi ">检修任务单</span>
				 </tab-heading>
				 <div class="col-sm-6 text-center m-t"></div> 
				 <div class="wrapper-md col-sm-12 no-padder">
					<div class="m-b-sm text-md col-sm-12 no-padder">
						<div class="col-sm-12 wrapper-md b-a  m-b panel border-black"  ng-repeat="vo in taskList ">
							<div class="col-sm-12 no-padder">
								<div class=" col-sm-4 font-h3 black-1 b-r">
									<p class="font-h1 font-bold m-b">任务单号：{{vo.taskno}}</p>
									<h4>派发信息</h4>
									<div class="col-sm-12 m-b">
										<div class="col-sm-12 no-padder">
										<p class="col-sm-5 no-padder font-h3 black-2">故障确认人</p>
										<p class="col-sm-7 no-padder">{{vo.confirmManName}}</p>
										</div>
										<div class="col-sm-12 no-padder">
										<p class="col-sm-5 no-padder font-h3 black-2">派单时间</p>
										<p class="col-sm-7 no-padder">{{vo.distdate | date:'yyyy-MM-dd HH:mm'}}</p>
										</div>
										<div class="col-sm-12 no-padder">
										<p class="col-sm-5 no-padder font-h3 black-2">期望完成时间</p>
										<p class="col-sm-7 no-padder">{{vo.expectedtime | date:'yyyy-MM-dd HH:mm'}}</p>
										</div>
										<div class="col-sm-12 no-padder">
										<p class="col-sm-5 no-padder font-h3 black-2">故障受理人</p>
										<p class="col-sm-7 no-padder">{{vo.respManName}}</p>
										</div>
									</div>
									<h4>受理情况</h4>
									<div class="col-sm-12 ">
										<p class="col-sm-4 no-padder font-h3 black-2">受理状态</p>
										<p class="col-sm-8">{{vo.distStatusStr}}</p>
									</div>
									<div class="col-sm-12 ">
										<p class="col-sm-4 no-padder font-h3 black-2">受理时间</p>
										<p class="col-sm-8">{{vo.respdate | date:'yyyy-MM-dd HH:mm'}}</p>
									</div>
									<div class="col-sm-12 ">
										<p class="col-sm-4 no-padder font-h3 black-2">完成时间</p>
										<p class="col-sm-8">{{vo.finishdate | date:'yyyy-MM-dd HH:mm'}}</p>
									</div>
								</div>
								<div class="col-sm-8 font-h3 black-2">
									<div class="col-sm-12">
										<div class="col-sm-12 no-padder">
										<p class="col-sm-3 font-h2 black-1">完成情况说明</p>
										<p class="col-sm-9">{{vo.finishcontent}}</p>
										</div>
										<div class="col-sm-12 no-padder">
										<p class="col-sm-3 font-h2 black-1 m-b m-t">现场图片</p>
										<div class="col-sm-9 no-padder m-b m-t">
											<div class="col-sm-4" ng-if="vo.refimage1!=null">
												<img  src="${imgPath}/document/faultHand/{{vo.refimage1}} ">
											</div>
											<div class="col-sm-4" ng-if="vo.refimage2!=null">
												<img  src="${imgPath}/document/faultHand/{{vo.refimage2}} ">
											</div>
											<div class="col-sm-4" ng-if="vo.refimage3!=null">
												<img  src="${imgPath}/document/faultHand/{{vo.refimage3}} ">
											</div>
										</div>
										</div>
										<p class="col-sm-3 font-h2 black-1">故障排除情况</p>
										<p class="col-sm-9 warning">{{vo.taskstatusStr}}</p>
									</div>
								</div>
							</div>
						</div>
						
					</div>
				</div>
			</tab>
			<!-- 故障处理-处理任务结束 --> 
			</tabset>
		</div>	
		</div>
	</div>	
