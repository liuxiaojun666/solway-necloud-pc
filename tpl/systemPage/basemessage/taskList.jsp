<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="hbox hbox-auto-xs hbox-auto-sm" ng-init="app.settings.asideFolded = false;  app.settings.asideDock = false;" >
	<div class="col-sm-12 col-3" id="taskList" style="padding-bottom:30px;padding-top:25px">
		<div id="noMessFlag" class="text-center" style="margin-top: 20%;" ng-show="isSkip!='0'">
			<img src="./theme/images/noMessage.png"></img>
		</div>
	<div class="col-sm-12" ng-repeat="note in faultList">
		<div class="col-sm-12 text-center padder-v " ng-show="note.parentid!=null && note.parentid!=faultList[0].id && $index==1">
			<small class="text-muted inline m-b-sm m-l-sm m-r-sm font-h6">
			以下为 <span ng-bind="note.sendusername" style="color: #000000"/> 处理进展 [当前状态:
				<small ng-if="note.through_handstatus=='00'" class="handle1">待确认</small>
				<small ng-if="note.through_handstatus=='01'" class="handle1">待受理</small>
				<small ng-if="note.through_handstatus=='02'" class="handle2">待处理</small>
				<small ng-if="note.through_handstatus=='03'" class="handle3">已关闭</small>
			]
			</small>
			<abbr class="col-sm-12" style="border-bottom-color:#98a6ad; border-bottom-style:dashed;" title="华丽的分割线"/>
		</div>
		<div class="col-sm-8" repeat-done="taskHeight()" ng-class="{'ownDiv':note.senduserid ==${sessionScope.USER.userId},
															'taskListDiv':note.senduserid !=${sessionScope.USER.userId},
															'readDiv':note.readstatus=='0'&&note.recuserid ==${sessionScope.USER.userId}}" 
													ng-click="showNoteContent({{note.id}})">
		
			<div class="col-sm-12 padder-v padder-no">
				<div class="col-sm-12 no-padder">
					<div class="col-sm-6 no-padder font-h3 black-0">
						<span ng-show="note.senduserid!=null">
							<img ng-show="note.senduserid ==${sessionScope.USER.userId}" src="${ctx}/theme/images/icon/people_whiter.png" class=" m-r-xs">
							<img ng-show="note.senduserid !=${sessionScope.USER.userId}" src="${ctx}/theme/images/icon/people.png" class=" icon-size m-t-n-xs m-r-xs">
						</span>
						<span ng-show="note.senduserid==null">
							<img src="${ctx}/theme/images/icon/gear.png" class="icon-size m-t-n-xs m-r-xs">
						</span>
						<span ng-bind="note.sendusername"></span>
					</div>
					<div class="col-sm-6 no-padder">
						<p class="pull-right" ng-show="note.recusername!=null" class="font-h4 black-2">接收人：<span ng-bind="note.recusername"></span></p>
						<span class="m-r-xs pull-right" ng-bind="note.cretime|date:'yyyy-MM-dd HH:mm'"></span>
					</div>
				</div>
				<div class="col-sm-12 no-padder">
					<div class="black-2 col-sm-12 no-padder font-h4 m-t-xs">
						<span data-ng-bind-html="note.content"></span>
						<!-- <span ng-if="note.content.length >100">...</span> -->
					</div>
					<div class="col-sm-12 no-padder text-1-5x m-t-xs">
						<img class="col-sm-3 padder-xs zoomImg" ng-src="{{note.img1}}" ng-show="note.img1 != null"  ng-click="zoomPic('note.img1')"/>
						<img class="col-sm-3 padder-xs zoomImg" ng-src="{{note.img1}}" ng-show="note.img1 != null"  ng-click="zoomPic('note.img1')"/>
						<img class="col-sm-3 padder-xs zoomImg" ng-src="{{note.img1}}" ng-show="note.img1 != null"  ng-click="zoomPic('note.img1')"/>
					</div>
				</div>
				</div>
				<div class="col-sm-12 taskDetails">
					
					
					<small  ng-click="noteDetails({{note.id}},{{note.busitype}},{{note.busino}})"  ng-if="note.busitype=='00' || note.busitype=='01' || note.busitype=='02'" class="a-cur-poi default-blue pull-right">查看详情 ></small>
					<span ng-if="!((note.taskStatus=='01'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index==0)
								|| (note.taskStatus=='01'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index>0))" >
			              	<small  ng-click=""  ng-if="sysMessageManageValue == 1 && note.busitype=='01'" class="a-cur-poi default-blue pull-right">工作票 >&nbsp;&nbsp;&nbsp;</small>
							<small  ng-click=""  ng-if="sysMessageManageValue == 1 && note.busitype=='01'" class="a-cur-poi default-blue pull-right">缺陷记录 >&nbsp;&nbsp;&nbsp;</small>
				    </span>
					<div ng-show="faultList[0].through_handstatus!='04' && isSkip!='0'">
					<!-- 事件通知 -->
					<div class="col-sm-4 no-padder pull-right m-r" ng-if="note.busitype=='00'">
						 <div class="dropdown navbar-right m-n" id="dropdown1" dropdown >
				            <a ng-if="note.handstatus=='00' && $index==faultList.length-1" class="dropdown-toggle pull-right btn btn-sm taskBtn m-t-n-xs clear" dropdown-toggle="" aria-haspopup="true" aria-expanded="true">
				             确认
	           				 </a>
				            <!-- dropdown -->
				            <ul class="dropdown-menu animated fadeInRight w" style="min-width: inherit;">
				              <li>
				                <a ng-click="handle01({{note.busino}})">
			           			  派给他人处理
	          					 </a>
				              </li>
				               <li>
				               	 <a ng-click="handle02({{note.busino}})">
			           			 	派给自己处理
	          				  	 </a>
				              </li>
				              <li class="divider"></li>
				              <li>
				                <a ng-click="handle03()">
			           			  不处理
	          				 	</a>
				              </li>
				            </ul>
				          </div>
					</div>
					<!-- 事件类型为派工 -->
					<div class="col-sm-8 no-padder pull-right m-r" ng-if="note.busitype=='01'">
				         <span ng-if="note.taskStatus=='00'&& note.recuserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index>0" >
				              	<a ng-click="handle111(note.busino,note.parentid)" class="pull-right btn btn-sm taskBtn m-t-n-xs " >受理</a>
				              	<a ng-click="handle112(note.busino,note.parentid)" class="pull-right btn btn-sm btn-default m-r-xs m-t-n-xs" >拒绝</a>
				         </span>
						 <a ng-click="handle11(note.busino,note.parentid)" class="pull-right btn btn-sm taskBtn m-t-n-xs" 
							ng-if="note.taskStatus=='00' && note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index>0" >
							  撤回
						</a> 
						<span ng-if="note.taskStatus=='01'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index>0" >
			              	<a ng-click="handle2(note.busino,note.parentid)" class="pull-right btn btn-sm taskBtn m-r-xs m-t-n-xs">记录处理情况</a>
			              	<a ng-if="sysMessageManageValue == 1" ng-click="handleDefectManagement(note.busino,note.parentid)" class="pull-right btn btn-sm taskBtn m-r-xs m-t-n-xs" >缺陷记录</a>
			              	<a ng-if="sysMessageManageValue == 1" ng-click="handleWorkTicket(note.busino)" class="pull-right btn btn-sm taskBtn m-r-xs m-t-n-xs " >工作票填写</a>
				         </span>
						<a ng-click="handleInspected(note.busino,note.parentid)" class="pull-right btn btn-sm taskBtn m-t-n-xs" 
							ng-if="note.taskStatus=='02' && note.finishedStatus == '2' && note.recuserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index>0" >
							验收
						</a>
						<a ng-click="handleInspected_selectopen(note.busino,note.parentid)" class="pull-right btn btn-sm taskBtn m-t-n-xs" 
							ng-if="note.taskStatus=='02' && note.finishedStatus == '2' && note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index>0" >
							更改验收人
						</a>
						<!-- 手动派工 -->
						<span ng-if="note.taskStatus=='00'&& note.recuserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index==0" >
				              	<a ng-click="handle111(note.busino,note.id)" class="pull-right btn btn-sm taskBtn m-t-n-xs " >受理</a>
				              	<a ng-click="handle112(note.busino,note.id)" class="pull-right btn btn-sm btn-default m-r-xs m-t-n-xs" >拒绝</a>
				         </span>
						 <a ng-click="handle11(note.busino,note.id)" class="pull-right btn btn-sm taskBtn m-t-n-xs" 
							ng-if="note.taskStatus=='00'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index==0" >
							  撤回
						</a> 
						<span ng-if="note.taskStatus=='01'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1 && $index==0" >
			              	<a ng-click="handle2(note.busino,note.id)" class="pull-right btn btn-sm taskBtn m-t-n-xs" >记录处理情况</a>
			              	<a ng-if="sysMessageManageValue == 1" ng-click="" class="pull-right btn btn-sm taskBtn m-r-xs m-t-n-xs" >缺陷记录</a>
			              	<a ng-if="sysMessageManageValue == 1" ng-click="" class="pull-right btn btn-sm taskBtn m-r-xs m-t-n-xs " >工作票填写</a>
				         </span>
				<!-- 	</div>
					<div class="col-sm-4 no-padder pull-right m-r" ng-if="note.busitype=='01'"> -->
						 <div class="dropdown  navbar-right m-n" id="dropdowns2" dropdown >
				            <a 
				            ng-if="(faultList[0].handstatus=='00' && $index==faultList.length-1 && note.senduserid == ${sessionScope.USER.userId} && note.taskStatus=='04') || (faultList[0].handstatus=='00' && $index==faultList.length-1 && note.recuserid == ${sessionScope.USER.userId} && note.taskStatus!='04')" class="dropdown-toggle pull-right btn btn-sm taskBtn m-t-n-xs clear" dropdown-toggle="" aria-haspopup="true" aria-expanded="true">
				            再次确认
	           				 </a>
				            <!-- dropdown -->
				            <ul class="dropdown-menu animated fadeInRight w" style="min-width: inherit;">
				              <li>
				                <a ng-click="handle01(faultList[0].busino)">
			           			  派给他人处理
	          					 </a>
				              </li>
				               <li>
				               	 <a ng-click="handle02(faultList[0].busino)">
			           			 	派给自己处理
	          				  	 </a>
				              </li>
				              <li class="divider"></li>
				              <li>
				                <a ng-click="handle03()">
			           			  不处理
	          				 	</a>
				              </li>
				            </ul>
				          </div>
					</div>
					<!-- 企业邀请 -->
					<div class="col-sm-4 no-padder pull-right m-r" ng-if="note.busitype=='03'">
				         <span ng-if="note.handstatus=='00'&& note.recuserid == ${sessionScope.USER.userId} && $index==faultList.length-1" >
				              	<a ng-click="companyInviteHandle(note.busino,note.id,1)" class="pull-right btn btn-sm taskBtn m-t-n-xs " >接受邀请</a>
				              	<a ng-click="companyInviteHandle(note.busino,note.id,0)" class="pull-right btn btn-sm btn-default m-r-xs m-t-n-xs" >拒绝邀请</a>
				         </span>
				         <!-- <a ng-click="companyInviteHandle(note.busino,note.parentid,2)" class="pull-right btn btn-sm taskBtn m-t-n-xs" 
							ng-if="note.handstatus=='00'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1" >
							  撤回邀请
						 </a> -->
				     </div>
				     <!-- 业主邀请 -->
					<div class="col-sm-4 no-padder pull-right m-r" ng-if="note.busitype=='04'">
				         <span ng-if="note.handstatus=='00'&& note.recuserid == ${sessionScope.USER.userId} && $index==faultList.length-1" >
				              	<a ng-click="ownerInviteHandle(note.busino,note.id,0)" class="pull-right btn btn-sm taskBtn m-t-n-xs " >接收邀请</a>
				              	<a ng-click="ownerInviteHandle(note.busino,note.id,1)" class="pull-right btn btn-sm btn-default m-r-xs m-t-n-xs" >拒绝邀请</a>
				         </span>
				         <!-- <a ng-click="ownerInviteHandle(note.busino,note.parentid,2)" class="pull-right btn btn-sm taskBtn m-t-n-xs" 
							ng-if="note.handstatus=='00'&& note.senduserid == ${sessionScope.USER.userId} && $index==faultList.length-1" >
							  撤回邀请
						 </a> -->
				     </div>
				</div>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>
