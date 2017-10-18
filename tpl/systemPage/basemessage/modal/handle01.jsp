<!-- 指派给他人 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<script type="text/javascript">
	app.controller('handle01Ctrl', function ($scope, $http,$state,$stateParams) {
		//getUserList(1);
	});
	function cllarverifyhandle01(){
		var respman=$("#respman").val();
		var expectedtime=$("#expectedtime").val();
		var taskcontent=$("#taskcontent").val();
		
		if(respman){
		   $("#respmanverify").html("");
		   $('#respman').removeClass('error');
		}
		
		if(expectedtime){
		   $("#expectedverify").html("");
		   $('#expectedtime').removeClass('error');
		}
		
		if(taskcontent){
		   $("#taskcontentverify").html("");
		   $('#taskcontent').removeClass('error');
		}
	}
	
	function clearHandle01Info(){
	   $("#respmanverify").html("");	
	   $("#expectedverify").html("");
	   $("#taskcontentverify").html("");
	   
	   $('#respman').removeClass('error');
	   $('#expectedtime').removeClass('error');
	   $('#taskcontent').removeClass('error');
	   
	   $("#respman").val(null);
	   $("#expectedtime").val(null);
	   $("#taskcontent").val(null);
	   choseRemindHour01(0,"#remindTimeCheck01");
	   
	   $("#expectedtime").datetimepicker({
			language: 'zh-CN',
	    	format: "yyyy-mm-dd hh:00",
	    	minView : 1,
	    	autoclose: true,
	    	todayBtn: true,
	    	pickerPosition: "bottom-left"
		});
	    $("#expectedtime").datetimepicker('setStartDate',new Date().Format("yyyy-MM-dd hh:mm"));
	}
	
	function choseRemindHour01(hour,obj){
		$(obj).parent().siblings().removeClass('timeActive');
		$(obj).parent().addClass('timeActive');
		$("#remindTime01").val(hour);
	}
	
	</script>

<div class="modal fade noteModal "id="handle01" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" ng-controller="handle01Ctrl">
	<div class="modal-dialog row">
		<div class="modal-content ">
			 <div class="modal-header">
	            <button type="button" class="close" 
	               data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <h4 class="modal-title font-h3" id="myModalLabel">
	               <span ng-bind="faultList[0].content|limitTo : 42"></span>
				   <span ng-if="faultList[0].content.length >42">...</span>
				   <span class="m-l-sm">
				   	 <span ng-if="faultList[0].handstatus=='00'" class="handle1">
						待确认
					</span>
					<span ng-if="faultList[0].handstatus=='01'" class="handle1">
						待受理
					</span>
					<span ng-if="faultList[0].handstatus=='02'" class="handle2">
						待处理
					</span>
					<span ng-if="faultList[0].handstatus=='03'" class="handle3">
						已关闭
					</span>
					<span ng-if="faultList[0].handstatus=='04'" class="handle3">
						被确认
					</span>
				   </span>
	            </h4>
       		  </div>
			<div class="modal-body ">
							<form class="bs-example form-horizontal" >
								<div class="form-group" id="respmanDiv">
									<label class="col-sm-3 control-label pull-left">受理人</label>
									<div class="col-sm-4 select">
						            <ui-select ng-model="managerd01.selected" theme="bootstrap" ng-change="managerChange01()">
							            <ui-select-match placeholder="请输入关键字..." ng-model="managerd01.selected.realName" >{{$select.selected.realName}}</ui-select-match>
							            <ui-select-choices  repeat="item in manager01 | filter: $select.search">
							              <div ng-bind-html="item.realName | highlight: $select.search"></div>
							            </ui-select-choices>
						         	 </ui-select>
						         	 <input type="hidden" onMouseOut="cllarverifyhandle01()" id="respman" name="respman" class="form-control formData"/>
									<div  id="respmanverify" class="control-label m-t-sm black-1 no-padder"></div>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label pull-left">期望完成时间<i class="fa fa-asterisk text-required"/></label>
									<div class="col-sm-4">
										<input type="text" id="expectedtime" name="expectedtime"
											class="form-control formData" onchange="cllarverifyhandle01()" required>
									<div id="expectedverify"/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label pull-left">故障再次提醒</label>
									<div class="col-sm-9">
											<ul class="nav nav-pills">
												<li class="timeActive"><a onclick="choseRemindHour01(0,this);" class="b-a" id="remindTimeCheck01">不提醒</a></li>
												<li><a onclick="choseRemindHour01(1,this);" class="b-a">一小时后</a></li>
												<li><a onclick="choseRemindHour01(3,this);" class="b-a">三小时后</a></li>
												<li><a onclick="choseRemindHour01(6,this);" class="b-a">六小时后</a></li>
												<li><a onclick="choseRemindHour01(9,this);" class="b-a">九小时后</a></li>
											</ul>
									</div>
									<input type="hidden" id="remindTime01" name="remindTime01" value="0"/>
								</div>
								<div class="form-group">
									<label class="col-sm-3 control-label pull-left">任务描述<i class="fa fa-asterisk text-required"/></label>
									<div class="col-sm-9">
										<textarea rows="8" cols="20" id="taskcontent" maxlength="200"
											name="taskcontent" class="form-control formData" onMouseOut="cllarverifyhandle01()"></textarea>
									<div id="taskcontentverify"/>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12 text-center" >
										<button type="button" ng-click="saveHandle01Form()" 
											class="btn m-b-xs w-xs taskBtn" id="btnH01" data-loading-text="保存中..." autocomplete="off">
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