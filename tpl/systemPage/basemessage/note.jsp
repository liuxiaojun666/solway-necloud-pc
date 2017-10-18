<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
 <style>
 	.form-control::-moz-placeholder {
  color: #999;
  opacity: 1;
  text-align: center;
}
.form-control:-ms-input-placeholder {
  color:  #999;
  text-align: center;
}
.form-control::-webkit-input-placeholder {
  color:  #999;
  text-align: center;
}
.app-content-body {
	left: 0;
}
.handle-suggest{display: inline-block;position: absolute;top: 0px;margin-left: 30px;}
.handle-suggest>a{width: 130px;border: 1px solid rgb(244,189,110);display: inline-block;text-align: center;line-height:52px;height:52px;font-size: 18px;color: #00bebd;}
.knowledge-btn{display: inline-block;width: 50px;color: white;text-align:center;font-size: 16px;}
 </style>
 <div class="hbox hbox-auto-xs bg-light " ng-init="
  app.settings.asideFixed = true;
  app.settings.asideDock = false;
  app.settings.container = false;
  app.hideAside = false;
  app.hideFooter = true;">
<div class="app-content-full" ng-controller="taskListCtrl" style="bottom: 0px">

	<div class="hbox hbox-auto-xs hbox-auto-sm">
 		<div class="col"  style="overflow: hidden;width: 290px;">
			<div class="vbox">
				<div class="wrapper text-center default-blue-bg">
    				<span class="a-cur-poi  white-1 font-h3" ng-click="createTask()">
    					<img src="${ctx}/theme/images/icon/edit.png" class="icon-size m-t-n-xs m-r-md">发布任务
    				</span>
				</div>
				<ul class="nav nav-tabs text-center  bg-white nav-tabs-writer hidden">
					<li ng-click="changeSend('0')"  class="col-sm-6 no-padder">
						<a >
							<span class="col-sm-12 no-padder b-r active" id="span0">我收的</span>
						</a>
					</li>
					<li ng-click="changeSend('1')" class="col-sm-6 no-padder">
						<a >
							<span class="col-sm-12 no-padder" id="span1">我发的</span>
						</a>
					</li>
				</ul>
				<form class="col-sm-12 m-t-sm">
		          <div class="form-group m-b-sm">
		            <div class="input-group">
		              <input id="noteSearch" type="text" class="form-control input-sm bg-light no-border rounded padder" placeholder="搜索">
		              <span class="input-group-btn">
		                <button ng-click="search()" type="submit" class="btn btn-sm bg-light rounded"><i class="fa fa-search"></i></button>
		              </span>
		            </div>
		          </div>
		        </form>
		        <ul class="nav nav-tabs text-center nav-tabs-border bg-white">
					<li ng-click="changeHandle('0')"  class="col-sm-4 no-padder active" id="read0">
						<a >全部消息</a></li>
					<li  ng-click="changeHandle('1')" class="col-sm-4 no-padder" id="read1">
						<a>未阅读
							<span ng-if="noReadMessage>0" class="data-red">(<span  ng-bind="noReadMessage"></span>)</span>
						</a>
					</li>
					<li ng-click="changeHandle('2')" class="col-sm-4 no-padder" id="read2">
						<a >未关闭
							<span ng-if="noHandleMessageCount>0" class="data-red">(<span ng-bind="noHandleMessageCount"></span>)</span>
						</a>
					</li>
				</ul>


				<div class="row-row">
					<paging class=" col-sm-12 no-padder " style="width:290px;height:100%">
					<div class="cell scrollable bg-white" id="contain">
						<div class="cell-inner "style="padding-top: 0px">
							<div ng-include="'${ctx}/tpl/systemPage/basemessage/noteList.jsp'"></div>
						</div>
						<span id="noData" class="text-center m-t data-red hidden col-sm-12">暂无数据!</span>
					</div>
				</div>
					<div class="note_task_pager">
						<%@ include file="/common/pagerForMessage.jsp"%>
					</div>
					</paging>
			</div>
		</div>
	  	<div class="col lter">
		  	<div class="vbox">
		  		<div ng-show="faultList.length!='0'" class="wrapper taskTitle" style="padding-right:0px;">
		  			<span class="handle-suggest" ng-hide="ifShowKnowledge || faultList[0].busitype !='00'">
		  				<img src="${ctx}/theme/images/icon/bear.png"><a ng-bind="dealOrFold" ng-click="showDealOrFold(faultList[0].busino)"></a>
		  			</span>
		  			<span class="font-h3 pull-right black-1">
		  				<span ng-bind="usedTilte"></span>
		  				<span class="m-r-xs m-l-sm data-red" ng-bind="usedDate"></span>
		  				<span class="m-l-sm a-cur-poi default-blue wrapper"  ng-show="faultList[0].busitype=='00'" ng-click="showKnowledgeOrBack()" style="background-color: rgb(107,211,226);margin-left:10px;">
		  					<a class="knowledge-btn" ng-bind="knowledgeOrBack"></a>
		  				</span>
		  				<span class="m-l-sm a-cur-poi default-blue handle3-bg wrapper"
		  					ng-if="faultList[0].busitype=='00' && (faultList[0].deviceType=='1' || faultList[0].deviceType=='2' || faultList[0].deviceType=='3' )"
		  					ng-click="showHistoryData_byRTMDeviceLogId(faultList[0].busino)">
		  					查看设备运行数据
		  				</span>
		  				<span class="m-l-sm handle1 handle1-bg  wrapper" ng-if="faultList[0].handstatus=='00'">待确认</span>
				        	<span class="m-l-sm handle1 handle1-bg wrapper" ng-if="faultList[0].handstatus=='01'">待受理</span>
				        	<span class="m-l-sm handle2 handle2-bg wrapper" ng-if="faultList[0].handstatus=='02'">待处理</span>
				        	<span class="m-l-sm handle3 handle3-bg wrapper" ng-if="faultList[0].handstatus=='03'">已关闭</span>
				        	<span class="m-l-sm handle3 handle3-bg wrapper" ng-if="faultList[0].handstatus=='04'">被确认</span>
				        	<span class="m-l-sm handle2 handle2-bg wrapper" ng-if="faultList[0].handstatus=='05'">验收中</span>
		  			</span>
			        <div class="font-h4 black-1 hidden">
			        	<span ng-bind="faultList[0].content|limitTo : 50"></span>
						<span ng-if="faultList[0].content.length >50">...</span>
			        </div>
				</div>
				<div ng-if="ifShowHandleSuggest" style="padding:13px 13px 0;">
					<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handleSuggestModel.jsp'"></div>
				</div>
				<div class="row-row" ng-if="ifShowKnowledge">
					<div class="cell">
						<div class="cell-inner">
							<div ng-include="'${ctx}/tpl/knowledgePage/summaryQuery/knowledgeBaseQuery.jsp'"></div>
						</div>
					</div>
				</div>
				<div class="row-row" ng-show="!ifShowKnowledge">
					<div class="cell">
						<div class="cell-inner">
							<div ng-include="'${ctx}/tpl/systemPage/basemessage/taskList.jsp'"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
  </div>
  <!-- 去处理 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handle01.jsp'"></div><!-- 派给他人去处理 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handle03.jsp'"></div><!-- 派给自己处理 -->
<!--拒绝 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handle112.jsp'"></div>
<!-- 撤回 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handle11.jsp'"></div>
<!-- 记录维修情况 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handle2.jsp'"></div>
<!-- 重新指定验收人 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handle4.jsp'"></div>
<!-- 查看详情 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails.jsp'"></div>
<!-- 查看事件日志详情 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails00.jsp'"></div>
<!-- 查看任务详情 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails01.jsp'"></div>
<!-- 查看事件处理详情 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/notedetails02.jsp'"></div>
<!-- 发布任务 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/createtask.jsp'"></div>
<!-- 缺陷记录 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handleFaultRecord.jsp'"></div>
<!-- 工作票 -->
<div ng-include="'${ctx}/tpl/systemPage/basemessage/modal/handleWorkTicket.jsp'"></div>
<!-- 查看设备运行数据 -->
<div ng-include="showModelDiv1" ></div>
<div ng-include="showModelDiv2" ></div>
<div ng-include="showModelDiv3" ></div>
</div>
</div>
<script type="text/javascript">
var showNoteList;
var noteActiveId;   //默认左边被选中的id
var noReadRefreshTime;

app.controller('taskListCtrl', function($scope, $http,$stateParams,$state,toaster,$location,$anchorScroll, paramsData) {
	
	$scope.hideKnowledgeHeader = true;//隐藏知识库的header
	//处理建议或者收起
	$scope.dealOrFold = "处理建议";
	$scope.showDealOrFold = function(v){
		$scope.ifShowKnowledge = false;
		if($scope.dealOrFold == "处理建议"){
			$scope.ifShowHandleSuggest = true;
			$scope.dealOrFold = "收起";
			paramsData.put('busino', v);//传参
		}else{
			$scope.ifShowHandleSuggest = false;
			$scope.dealOrFold = "处理建议";
		}
	}
	//显示知识库或者返回
	$scope.knowledgeOrBack = "知识库";
	$scope.showKnowledgeOrBack = function(){
		$scope.ifShowHandleSuggest = false;
		$scope.dealOrFold = "处理建议";
		if($scope.knowledgeOrBack == "知识库"){
			$scope.ifShowKnowledge = true;
			$scope.knowledgeOrBack = "返回";
		}else{
			$scope.ifShowKnowledge = false;
			$scope.knowledgeOrBack = "知识库";
		}
		$("#noMessFlag").addClass("hidden");
	}
	
	//切换是否显示知识库
	$scope.ifShowKnowledge = false;//默认不显示
	
	$scope.basemessage=[];
	$scope.faultList=[]
	$scope.sendState=0;//发送状态    1 我发的  0 我收的
	$scope.handleState=0;//发送状态 0 全部   1 未读  2 未处理

	//上一页
	var readOrsend=true;//标记未读和未处理的数量，当true 的时候是我收到的，当false 的时候是我发送的

	//更改接受状态
	$scope.changeSend=function(sendState){
		$scope.sendState=sendState;
		$("#span"+sendState).addClass("active");
		$("#span"+sendState).parent().parent().siblings().children().children().removeClass("active");
		$scope.onSelectPage();
	}

	//更改处理状态
	$scope.changeHandle=function(handleState){
		
		$scope.initKnowledgeDefault();
		$scope.handleState=handleState;
		$("#read"+handleState).addClass("active");
		$("#read"+handleState).siblings().removeClass("active");
		$scope.getNoDoBaseMessageCount();
		$scope.onSelectPage();
		$scope.faultList=[];
		$("#noMessFlag").removeClass("hidden")
	}
	//查询消息详情
	$scope.onSelectPage=function(page){
		$scope.ifShowKnowledge = false;
		$scope.ifShowHandleSuggest = false;
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}
		CommonPerson.Base.LoadingPic.PartShow('contain');
		$("#noData").addClass("hidden")
			readOrsend=true;
			$("#sendMess").addClass("hidden")
			$("#recMess").removeClass("hidden")
			$http({
				method : "POST",
				url : "${ctx}/BaseMessage/getBaseMessageList.htm",
				params : {
					'pageIndex'	:page - 1,
					'pageSize'	:$scope.pageSizeSelect,
					'searchKey':$("#noteSearch").val(),
					'listTab':$scope.handleState,
				}
			}).success(function(result) {
				partHide('contain')
				getTableData($scope,result);

				$scope.getNoReadBaseMessageCount();//统计未读的数量
				
				$scope.basemessage=result.data;
				if($scope.recTotalPage>1){
					$("#notePaging").removeClass("hidden")
				}
				if($scope.basemessage==""){
					$scope.faultList=[];
					$("#noData").removeClass("hidden")
					$("#noMessFlag").addClass("hidden")
				}
			});
	}
	
	//获取消息中心是否填写工作票信息
	$scope.getSysMessageManageValue=function(page){
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getSysMessageManageValue.htm",
		}).success(function(result) {
			$scope.sysMessageManageValue = result;
		});
			
	}
	$scope.getSysMessageManageValue();
	
	//点击搜索
	$scope.search=function(){
		$("#noMessFlag").addClass("hidden")
		$scope.faultList=[]
		$scope.getNoDoBaseMessageCount();

		$scope.onSelectPage(1);

	}
	
	//定时刷新未读数量
	noReadRefreshTime = setInterval(function() {
		$scope.getNoReadBaseMessageCount();
	}, 5000);
	
	//离开当前界面
	$scope.$on('$stateChangeStart', function(event) {
		clearInterval(noReadRefreshTime);
	});
	
	//右面列表加载后计算高度
	$scope.taskHeight=function(){
		if(document.body.scrollHeight-$("#taskList").height()<140){
			var weeks=$("#taskList").find(".dropdown")
			for(var i=0;i<weeks.length;i++){
				$(weeks[i]).addClass("dropup")
			}
		}else{
			var weeks=$("#taskList").find(".dropdown")
			for(var i=0;i<weeks.length;i++){
				$(weeks[i]).removeClass("dropup")
			}
		}
	}

	initTableConfig($scope);

	//获得未读数量
	$scope.getNoReadBaseMessageCount=function(){
		$http({
				method : "POST",
				url : "${ctx}/BaseMessage/getNoReadBaseMessageCount.htm",
				params : {
					'searchKey':$("#noteSearch").val(),
					isRorS:readOrsend
				}
			}).success(function(result) {
				$scope.noReadMessage=result
		});
	}
	//查看未处理数量
	$scope.getNoDoBaseMessageCount=function(){
		$http({
				method : "POST",
				url : "${ctx}/BaseMessage/getNoEndBaseMessageCount.htm",
				params : {
					'searchKey':$("#noteSearch").val(),
					isRorS:readOrsend
				}
			}).success(function(result) {
				$scope.noHandleMessageCount=result
			});
	}

	//初始化装载数据（根据不同的状态）
	$scope.onSelectPage(1);

	//获得未读数量
	$scope.getNoDoBaseMessageCount();

	//获得右面整个流程列表
	$scope.showFaultList=function(id,busitype){
		$http({
			method : "POST",
			url : "${ctx}/BaseMessage/getTopBaseMessageDetail.htm",
			params : {
				'pageIndex'	:0,//pageFaultIndex+1,
				'pageSize'	:10,
				'parentid':id,
				'busitype':busitype
			}
		}).success(function(result) {
			$scope.getNoDoBaseMessageCount()
			var readids="";
			$scope.faultList=result.data;
			//判断状态来获得时间
			if($scope.faultList[0].handstatus=='03'){
				$scope.usedTilte="共耗时"
				$scope.usedDate=countTime($scope.faultList[0].cretime,$scope.faultList[result.data.length-1].cretime);
			}else{
				$scope.usedTilte="已耗时"
				$scope.usedDate=countTime($scope.faultList[0].cretime,(new Date).getTime());
			}
			//隐藏未读数量
	    	var msh;
	    	if($scope.faultList[0].handstatus=='04'){
	    		msh="<small class='handle3'>被确认</small>"
	    	}else if($scope.faultList[0].handstatus=='03'){
	    		msh="<small class='handle3'>已关闭</small>"
	    	}else if($scope.faultList[0].handstatus=='00'){
	    		msh="<small class='handle1'>待确认</small>"
	    	}else if($scope.faultList[0].handstatus=='01'){
	    		msh="<small class='handle1'>待受理</small>"
	    	}else if($scope.faultList[0].handstatus=='02'){
	    		msh="<small class='handle2'>待处理</small>"
	    	}else if($scope.faultList[0].handstatus=='05'){
	    		msh="<small class='handle2'>验收中</small>"
	    	}
	    	$("#unread_num"+id).addClass("hidden");
			$("#mhs"+id).html(msh);

 			//改变消息列表中所有状态为已读
			for(var i=0;i<result.data.length;i++){
				if(result.data[i].readstatus=="0"&&result.data[i].recuserid == "${sessionScope.USER.userId}"){
					readids=readids+result.data[i].id+",";
				}
				//将所有的未读状态转化为已读状态
			}
			$http({
				method : "POST",
				url : "${ctx}/BaseMessage/readBaseMessages.htm",
				params : {
					'ids':readids
				}
			}).success(function(result) {
				//改成定时刷新
				//$scope.getNoReadBaseMessageCount();
			});
		});
	}


	//根据左面的列表切换右面的数据
	showNoteList=$scope.showNoteList=function(id,busitype){

		$scope.initKnowledgeDefault();
		$scope.showFaultList(id,busitype)
		noteActiveId=id;
		$("#note"+id).addClass("noteListActive");
		$("#noMessFlag").addClass("hidden");
		$("#note"+id).siblings().removeClass("noteListActive");

	}
	
	//知识库恢复成默认状态
	$scope.initKnowledgeDefault=function(){
		$scope.ifShowKnowledge = false;
		$scope.knowledgeOrBack = "知识库";
		$scope.ifShowHandleSuggest = false;
		$scope.dealOrFold = "处理建议";
	}

 	//左边加载后显示派单列表
	$scope.noteActived=function(busitype){
		if($scope.sendState=="1"){//我发送的
			noteActiveId=$scope.baseSendmessage[0].mid
			$scope.showFaultList($scope.baseSendmessage[0].mid,busitype)
			$("#note"+$scope.baseSendmessage[0].mid).addClass('noteListActive')
		}else{
			noteActiveId=$scope.basemessage[0].mid
			$scope.showFaultList($scope.basemessage[0].mid,busitype)
			$("#note"+$scope.basemessage[0].mid).addClass('noteListActive')
		}
	}

	//查看详情
	$scope.noteDetails=function(messageId,busitype,busino){
		$scope.isInspected = false;
		if(busitype=='00'){
			$scope.getEventDetailById(busino);
			//$scope.getMessageDetailById(messageId);
			$('#noteDetails00').modal({backdrop: 'static', keyboard: false});
		}else if(busitype=='01'){
			$scope.getTaskDetailById(busino);
			//$scope.getMessageDetailById(messageId);
			$('#noteDetails01').modal({backdrop: 'static', keyboard: false});
		}else if(busitype=='02'){
			$scope.getEventHandleDetailById(busino);
			//$scope.getMessageDetailById(messageId);
			$('#noteDetails02').modal({backdrop: 'static', keyboard: false});
		}
	}
	
	//验收弹出
	$scope.handleInspected=function(busino,topmessageid){
		$('#inspected_content').val('');
		$scope.getTaskDetailById(busino);
		$scope.isInspected = true;
		$scope.inspectedbusino = busino;
		$scope.inspectedtopmessageid = topmessageid;
		//$scope.getMessageDetailById(messageId);
		$('#noteDetails01').modal({backdrop: 'static', keyboard: false});
	}
	
	//验收
	$scope.handleInspectedData=function(type){
		
		var eventid=$scope.faultList[0].busino;
		if($scope.faultList[0].busitype=='01'){
			eventid=null;
		}
		
		$http({
			method : "POST",
			url : "${ctx}/Optask/inspectedHandle.htm",
			params : {
				'id':$scope.inspectedbusino,
				'topmessageId':$scope.inspectedtopmessageid,
				'finishedstatus':type,
				'inspectedContent':$('#inspected_content').val(),
				'eventid':eventid
			}
		}).success(function(msg) {
			if(msg.result){
				promptObj('success','',msg.infoMsg);
			}else{
				promptObj('error','',msg.infoMsg);
			}
			//刷新列表
			$scope.showNoteList(noteActiveId);
			$('#noteDetails01').modal('hide');
		});
	}
	
	//重新选择验收人弹出
	$scope.handleInspected_selectopen=function(id,topmessageId){
		$("#handle4_severify").hide();
		$("#inspectedMan4").val(null);
		$scope.inspectedbusino_select = id;
		$scope.inspectedtopmessageid_select = topmessageId;
		$scope.getUserList04(id);
		$('#handle4').modal({backdrop: 'static', keyboard: false});
	}
	
	//重新选择验收人
	$scope.handleInspected_select=function(id,topmessageId){
		if(!$("#inspectedMan4").val()){
			$("#handle4_severify").show();
			return;
		}else{
			$("#handle4_severify").hide();
		}
		$http({
			method : "POST",
			url : "${ctx}/Optask/updateInspectedMan.htm",
			params : {
				'id':$scope.inspectedbusino_select,
				'topmessageId':$scope.inspectedtopmessageid_select,
				'inspectedMan':$("#inspectedMan4").val()
			}
		}).success(function(msg) {
			if(msg.result){
				promptObj('success','',msg.infoMsg);
			}else{
				promptObj('error','',msg.infoMsg);
			}
			//刷新列表
			$scope.showNoteList(noteActiveId);
			$('#handle4').modal('hide');
		});
	}

	/*查看设备运行数据*/ //单击按钮事件 准备"待加载链接地址"
	$scope.showHistoryData_byRTMDeviceLogId=function(id){
		$http({
			method : "POST",
			url : "${ctx}/DeviceLog/selectDeviceById.htm",
			params : {
				'id':id
			}
		}).success(function(msg) {

	 	//msg.deviceType = "2"
	 		/*	msg.deviceSerialNnumber = "2001"
		msg.pstationid = "1"
		msg.id = "1" */
		//根据设备类型设置准备加载页面连接
			
			var res = {};
			res.deviceSerialNnumber = msg.deviceSerialNnumber;
			res.deviceId = msg.deviceId;
			res.pstationid = msg.pstationid;
			res.deviceTypeNow = msg.deviceType;
			$scope.deviceTypeNow = msg.deviceType;
			$scope.inverterType = msg.hasJB;
			if(msg.deviceType == '3'){
				$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});
				//$scope.$emit("showDeviceDetail3", res);
				$scope.$broadcast("showDeviceDetail3broad", res);
			}else if(msg.deviceType == '2'){
				$('#taskList_historyData2').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail2broad", res);
				//$scope.$emit("showDeviceDetail2", res);
			}else if(msg.deviceType == '1'){
				$('#taskList_historyData1').modal({backdrop: 'static', keyboard: false});
				$scope.$broadcast("showDeviceDetail1broad", res);
				//$scope.$emit("showDeviceDetail1", res);
			}
		});
	}
	/*查看设备运行数据*/ //"待加载链接地址" 加载完毕
	$scope.showHistoryData_byRTMDeviceLogId_ready=function(msg){
		var screenHeight=document.body.clientHeight;
	//	$('#taskList_historyData .modal-body ').css("height",screenHeight-100)
		$scope.$broadcast('deviceStation_parameter',$scope.showHistoryData_byRTMDeviceLogId.msg ,2);
		$('#taskList_historyData').modal({backdrop: 'static', keyboard: false});
	}
	/*查看设备运行数据*/ //单击按钮事件 关闭 "待加载链接地址"弹出页面
	$scope.closeHistoryData_byRTMDeviceLogId=function(msg){
		switch(msg.deviceType) {
			case "1":
				clearInterval(junction);
				clearInterval(junction2);
				clearInterval(junctionV);
				clearInterval(junctionA);
				clearInterval(junctionP);
				$scope.showHistoryData_byRTMDeviceLogId_incloud= "";
			    $scope.serialnumber = "";
				$scope.pstationid = "";
				$scope.InId = "";

				$stateParams.InId = "";
				$stateParams.pstationid = "";
				$stateParams.dstarttime = "";
				$scope.showHistoryData_byRTMDeviceLogId_incloud= "";
				break;
			case "2":
				//inverterDetail
				clearInterval(inverterTimer);
				clearInterval(inverterTimer2);
				clearInterval(inverterTimerDCU);
				clearInterval(inverterTimerDCC);
				clearInterval(inverterTimerDCP);
				clearInterval(inverterTimerACU);
				clearInterval(inverterTimerACC);
				clearInterval(inverterTimerACP);
			    $scope.serialnumber = "";
				$scope.pstationid = "";
				$scope.InId = "";

				$stateParams.InId = "";
				$stateParams.pstationid = "";
				$stateParams.dstarttime = "";
				$scope.showHistoryData_byRTMDeviceLogId_incloud= "";
				break;
			case "3":
				//boxChangeDetail
				clearInterval(junction);
				clearInterval(junction2);
				$scope.serialnumber = "";
				$scope.pstationid = "";
				$scope.InId = "";

				$stateParams.InId = "";
				$stateParams.pstationid = "";
				$stateParams.dstarttime = "";
				$scope.showHistoryData_byRTMDeviceLogId_incloud= "";
				break;
			default:
				$scope.showHistoryData_byRTMDeviceLogId_incloud="";
				break;
		}
	}

	//手工创建任务单
	$scope.createTask=function(id){
		clearHandleCTInfo();
		$scope.getStationsAndUserList();
		$('#createTask').modal({backdrop: 'static', keyboard: false});
	}


	//不同的按钮出现的点击事件
	//去处理

	//派给他人处理
	$scope.handle01=function(busiNo){
		$('#respmanDiv').show();
		clearHandle01Info();
		$scope.getUserList(busiNo);
		$('#handle01').modal({backdrop: 'static', keyboard: false});
	}
	//派给自己处理
	$scope.handle02=function(busiNo){
		clearHandle01Info();
		$scope.managerd01 = {};
		$scope.manager01 = null;
		$('#respman').val(-1);
		$('#respmanDiv').hide();
		//$scope.getPstationId(busiNo);
		$('#handle01').modal({backdrop: 'static', keyboard: false});
	}
	//不处理
	$scope.handle03=function(){
		clearHandle03Info();
		getFaultNohandReason();
		$('#handle03').modal({backdrop: 'static', keyboard: false});

	}


	/*
	* C4 接口
	*/
	//受理
	$scope.handle111=function(id,topmessageId){
		//alert("我是受理")
		$http({
			method : "POST",
			url : "${ctx}/Optask/acceptTask.htm",
			params : {
				'id':id,
				'topmessageId':topmessageId
			}
		}).success(function(msg) {
			if(msg.result){
				promptObj('success','',msg.infoMsg);
			}else{
				promptObj('error','',msg.infoMsg);
			}
			//刷新列表
			$scope.showNoteList(noteActiveId);
		});
	}

	//拒绝
	$scope.handle112=function(id,topmessageId){
		$('#handle112_reason').val("");
		$('#handle112_id').val(id);
		$('#handle112_topmessageId').val(topmessageId);
		$('#handle112').modal({backdrop: 'static', keyboard: false});
	}
	$scope.handle112_save=function(){
		var reason = $('#handle112_reason').val();
		if(!reason){
			$("#handle112_reasonverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			$('#handle112_reason').addClass('error');
			return false;
		}
		$("#handle112_reasonverify").html("");
		$('#handle112_reason').removeClass('error');
		$http({
			method : "POST",
			url : "${ctx}/Optask/rejectTask.htm",
			params : {
				'id':$('#handle112_id').val(),
				'topmessageId':$('#handle112_topmessageId').val(),
				'reason':$('#handle112_reason').val()
			}
		}).success(function(msg) {
			if(msg.result){
				promptObj('success','',msg.infoMsg);
			}else{
				promptObj('error','',msg.infoMsg);
			}
			$('#handle112').modal('hide');
			//刷新列表
			$scope.showNoteList(noteActiveId);
		});
	}

	//处理建议列表数据
	//测试
	 /* $scope.suggestsList = [{"id":1,"content":"测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述测试一段话述"},
	                       {"id":2,"content":"测试一段话述测试一段话述话述测试一段话述测试一段话述测试一段话述测试一段话述"},
	                       {"id":3,"content":"测试一段话述测试一段话述段话述测试一段话述测试一段话述"}]  */
	$scope.getSuggestionListData = function(){
		$http({
			method : "GET",
			url : "${ctx}/pFaultcodeRealAdvice/deviceSuggests.htm",
			params : {
				'busino':$scope.faultList[0].busino,
			}
		}).success(function(msg) {
			if(msg.code == 0){
				$scope.suggestsList = msg.data;
			}
		});
	} 
	
	$scope.selectAll= function(id){
		$scope.totalSelectedIds = [];
		if(id == 'other'){
			var otherAct = $("#other").hasClass("active");
			if(otherAct){
				$("#other").removeClass("active");
				$scope.totalSelectedIds = undefined;
			}else{
				$("#other").addClass("active");
				$scope.totalSelectedIds = ["other"];
			}
			$(".common-item").removeClass("active");
			
		}else{
			var isact = $("#item" + id).hasClass("active");
			if(isact){
				$("#item" + id).removeClass("active");
			}else{
				$("#item" + id).addClass("active");
			} 
			$(".other-item").removeClass("active");
			$(".suggestItem").each(function(){
				if($(this).hasClass("active")) {
					$scope.totalSelectedIds.push($(this).attr('name'));
				}
			});
			if($scope.totalSelectedIds.length <= 0){
				$scope.totalSelectedIds = undefined;
			}
		}
		
	}
	//记录维修情况
	$scope.handle2=function(id,topmessageId){
		$('#handle2_content').val("");
		$('#handle2_finishdate').val("");
		$('#handle2_topmessageId').val(topmessageId)
		$('#handle2_id').val(id)
		$("#inspectedMan").val(null);
		$scope.getUserList02(id);
		clearHandle02Info();
		$('#handle2').modal({backdrop: 'static', keyboard: false});
		$scope.getSuggestionListData();
	}
	
	
	//hand02处理
	$scope.getUserList02=function(taskid){
		$scope.managerd02 = {};
		$scope.manager02 = null;
		$http({method:"POST",url:"${ctx}/Optask/selectById.htm",params:{id:taskid}})
		.success(function (result) {
			$http({method:"POST",url:"${ctx}/AdminUser/selectAllNoSelf.htm",params:{sid:result.pstationid}})
			.success(function (result) {
		    	 $scope.manager02 = result;
				if($scope.manager02.length>0){
					$scope.manager02.unshift({realName :"-请选择人员-",userId : null});
			    	 for(var i=0,len=$scope.manager02.length;i<len;i++){
						 if($scope.manager02[i].userId==  $("#inspectedman").val()){
							$scope.managerd02.selected= { realName: $scope.manager02[i].realName,userId:$scope.manager02[i].userId};
						 }
					 }
			    	 $scope.managerChange02= function () {
			    		 $("#inspectedmanverify").html("");
				         $("#inspectedMan").val(angular.copy($scope.managerd02.selected.userId));
				         console.log($("#inspectedMan").val()+"====");
					}
				}
				
			});
		});
	}
	
	//hand04处理
	$scope.getUserList04=function(taskid){
		$scope.managerd04 = {};
		$scope.manager04 = null;
		$http({method:"POST",url:"${ctx}/Optask/selectById.htm",params:{id:taskid}})
		.success(function (result) {
			$http({method:"POST",url:"${ctx}/AdminUser/selectAllNoSelf.htm",params:{sid:result.pstationid}})
			.success(function (result) {
		    	 $scope.manager04 = result;
				if($scope.manager04.length>0){
			    	 for(var i=0,len=$scope.manager04.length;i<len;i++){
						 if($scope.manager04[i].userId==  $("#inspectedman").val()){
							$scope.managerd04.selected= { realName: $scope.manager04[i].realName,userId:$scope.manager04[i].userId};
						 }
					 }
			    	 $scope.managerChange04= function () {
			    		 $("#inspectedman4verify").html("");
				         $("#inspectedMan4").val(angular.copy($scope.managerd04.selected.userId));
					}
				}
				
			});
		});
	}

	//任务详情方法
	$scope.handle2_save=function(finishedStatus){
		$(".clearData").val();
		var finishdate = $('#handle2_finishdate').val();
		if(!finishdate){
			$("#handle2_finishdateverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			$('#handle2_finishdate').addClass('error');
			return false;
		}
		$("#handle2_finishdateverify").html("");
		$('#handle2_finishdate').removeClass('error');
		var content = $('#handle2_content').val();
		if(!content){
			$("#handle2_contentverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			$('#handle2_content').addClass('error');
			return false;
		}
		$("#handle2_contentverify").html("");
		$('#handle2_content').removeClass('error');

		$("#id").val($('#handle2_id').val());
		$("#topmessageId").val($('#handle2_topmessageId').val());
		$("#finishdate").val($('#handle2_finishdate').val());
		$("#taskstatus").val('02');
		$("#finishdate").val($('#handle2_finishdate').val());
		$("#finishedstatus").val(finishedStatus);
		$("#finishcontent").val($('#handle2_content').val());
		
		//如果没选择或者选择其它，该字段传空；其余传id数组
		if($scope.suggestsList.length <= 0){
			$("#adviceIds").val("");
		}else{
			if($scope.totalSelectedIds == undefined){
				$("#handle2_severify").show();
				return false;
			}else if($scope.totalSelectedIds && $scope.totalSelectedIds.length > 0){
				$("#handle2_severify").hide();
				if($.inArray("other", $scope.totalSelectedIds) != -1){
					$("#adviceIds").val("");
				}else{
					$("#adviceIds").val($scope.totalSelectedIds);
				}
			}
		}
		
		var eventid=$scope.faultList[0].busino;
		if($scope.faultList[0].busitype=='01'){
			eventid=null;
		}
		$("#eventid").val(eventid);


		if($("#picture2").val()==""){
			$("#picture2").attr("disabled","disabled");
		}
		if($("#picture1").val()==""){
			$("#picture1").attr("disabled","disabled");
		}
		if($("#picture0").val()==""){
			$("#picture0").attr("disabled","disabled");
		}
		$("#editForms").trigger("submit");
	}


	//撤回
	$scope.handle11=function(id,topmessageId){
		$('#handle11_reason').val("");
		$('#handle11_id').val(id);
		$('#handle11_topmessageId').val(topmessageId);
		$('#handle11').modal({backdrop: 'static', keyboard: false});
	}
	$scope.handle11_do=function(){
		var reason = $('#handle11_reason').val();
		if(!reason){
			$("#handle11_reasonverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			$('#handle11_reason').addClass('error')
			return false;
		}
		$("#handle11_reasonverify").html("");
		$('#handle11_reason').removeClass('error')
		$http({
			method : "POST",
			url : "${ctx}/Optask/recallTask.htm",
			params : {
				'id':$('#handle11_id').val(),
				'topmessageId':$('#handle11_topmessageId').val(),
				'reason':$('#handle11_reason').val()
			}
		}).success(function(msg) {
			if(msg.result){
				promptObj('success','',msg.infoMsg);
			}else{
				promptObj('error','',msg.infoMsg);
			}
			$('#handle11').modal('hide');
			//刷新列表
			$scope.showNoteList(noteActiveId)
		});
	}

	//保存任务单
	$scope.saveTaskForm=function(){
		var respman=$("#respmanCT").val();
		var expectedtime=$("#expectedtimeCT").val();
		var taskcontent=$("#taskcontentCT").val();
		var pstationid=$("#pstationidCT").val();
		if(pstationid && respman && expectedtime && taskcontent){
			var $btn = $('#btnCT').button('loading');
			//保存任务单
			$http({
				method : "POST",
				url : "${ctx}/Optask/assignTaskManual.htm",
				params : {
					'respman':$("#respmanCT").val(),
					'pstationid':$("#pstationidCT").val(),
					'expectedtime':$("#expectedtimeCT").val(),
					'taskcontent':$("#taskcontentCT").val(),
				}
			}).success(function(msg) {
				if(msg.result){
					promptObj('success','',msg.infoMsg);
				}else{
					promptObj('error','',msg.infoMsg);
				}
				$('#createTask').modal('hide');
				//刷新列表
				$scope.onSelectPage();
				$scope.faultList=[];
			//	$scope.showFaultList($scope.baseSendmessage[0].mid)
				$btn.button('reset');
			});
		}else{
			if(!pstationid){
				$("#pstationidverifyCT").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			}else{
				$("#pstationidverifyCT").html("");
			}

			if(!respman){
				$("#respmanverifyCT").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			}else{
				$("#respmanverifyCT").html("");
			}

			if(!expectedtime){
				$("#expectedverifyCT").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			}else{
				$("#expectedverifyCT").html("");
			}

			if(!taskcontent){
				$("#taskcontentverifyCT").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
			}else{
				$("#taskcontentverifyCT").html("");
			}
		}
	}

	//指派他人处理
	$scope.saveHandle01Form=function(){

		var respman=$("#respman").val();
		var expectedtime=$("#expectedtime").val();
		var taskcontent=$("#taskcontent").val();
		if(respman && expectedtime && taskcontent){
			var $btn = $('#btnH01').button('loading');
			//保存任务单
			$http({
				method : "POST",
				url : "${ctx}/EventHandle/eventHandle.htm",
				params : {
					'respman':$("#respman").val(),
					'pstationid':$scope.pstationId,
					'topmessageId':$scope.faultList[0].id,
					'expectedtime':$("#expectedtime").val(),
					"remindtime":$("#remindTime01").val(),
					'taskcontent':$("#taskcontent").val(),
					'eventid':$scope.faultList[0].busino,
				}
			}).success(function(msg) {
				if(msg.result){
					promptObj('success','',msg.infoMsg);
				}else{
					promptObj('error','',msg.infoMsg);
				}
				//刷新列表
				$scope.showNoteList(noteActiveId);
				$btn.button('reset');
			});
			$('#handle01').modal('hide');
		}else{

			if(!respman){
				$("#respmanverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
				$('#respman').addClass('error');
			}else{
				$("#respmanverify").html("");
				$('#respman').removeClass('error');
			}

			if(!expectedtime){
				$("#expectedverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
				$('#expectedtime').addClass('error');
			}else{
				$("#expectedverify").html("");
				$('#expectedtime').removeClass('error');
			}

			if(!taskcontent){
				$("#taskcontentverify").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
				$('#taskcontent').addClass('error');
			}else{
				$("#taskcontentverify").html("");
				$('#taskcontent').removeClass('error');
			}
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
					if(i == 0){
						$("#noHandReasonUl").append('<div class="col-xs-4 no-padder "> <label class="i-checks m-b-none"> <input type="radio" name="reasonIds" value=" '+msg[i].id+' " checked onclick="checkRadio(this)" /> <i></i> </label> <span>'+msg[i].dictName+'</span> </div>');
					}else{
						$("#noHandReasonUl").append('<div class="col-xs-4 no-padder "> <label class="i-checks m-b-none"> <input type="radio" name="reasonIds" value=" '+msg[i].id+' " onclick="checkRadio(this)" /> <i></i> </label> <span>'+msg[i].dictName+'</span> </div>');
					}
				}
				$("#noHandReasonUl").append('<div class="col-xs-4 no-padder "> <label class="i-checks m-b-none"> <input type="radio" name="reasonIds" value="0" onclick="checkRadio(this)" /> <i></i> </label> <span>其它原因</span> </div>');
			}
		});
	}
	//不处理
	$scope.saveHandle03Form=function(){
		//保存不处理原因
		//radio 选中处理
		var status=0;
		var ridaolen = document.handle03EditForms.reasonIds.length;
		for (var i = 0; i < ridaolen; i++) {
			if (document.handle03EditForms.reasonIds[i].checked) {
				status = document.handle03EditForms.reasonIds[i].value;
				break;
			}
		}
		var taskcontent = $("#taskcontent03").val();
		if(status == 0 &&  !taskcontent){
			$("#taskcontentverify03").html("<div class='popover fade bottom in' role='tooltip' style='display: block;margin: 40px 10px;'><div style='padding: 2px 7px;font-size: 12px;'>必填项</div></div>");
		}else{
			//保存任务单
			$http({
				method : "POST",
				url : "${ctx}/EventHandle/eventNoHandle.htm",
				params : {
					'notprocereason':status,
					'otherreason':taskcontent,
					'topmessageId':$scope.faultList[0].id,
					'eventid':$scope.faultList[0].busino,
				}
			}).success(function(msg) {
				if(msg.result){
					promptObj('success','',msg.infoMsg);
				}else{
					promptObj('error','',msg.infoMsg);
				}
				//刷新列表
				$scope.showNoteList(noteActiveId)
			});

			$('#handle03').modal('hide')
		}
	//	alert("不处理");

	}



	//填写完成情况
	$scope.saveHandle2Form=function(){
		//保存不处理原因


		//刷新列表
		$scope.showNoteList(noteActiveId);
		$('#handle2').modal('hide')
	}
	//点击撤回
	$scope.doHandle11=function(){
		//撤回执行的代码
	}
	//拒绝
	$scope.saveHandle112Form=function(){
		$('#handle112').modal('hide')
	}
	//hand01处理
	//根据事件日志id得到用户
	$scope.pstationId = 0;
	$scope.getUserList=function(eventid){
		$scope.managerd01 = {};
		$scope.manager01 = null;
		$http({method:"POST",url:"${ctx}/DeviceLog/selectDeviceById.htm",params:{id:eventid}})
		.success(function (result) {
			$scope.pstationId = result.pstationid;
			$http({method:"POST",url:"${ctx}/AdminUser/selectAllNoSelf.htm",params:{sid:result.pstationid}})
			.success(function (result) {
		    	 $scope.manager01 = result;
		    	 for(var i=0,len=$scope.manager01.length;i<len;i++){
					 if($scope.manager01[i].userId==  $("#respman").val()){
						$scope.managerd01.selected= { realName: $scope.manager01[i].realName,userId:$scope.manager01[i].userId};
					 }
				 }
		    	 $scope.managerChange01= function () {
		    		 $("#respmanverify").html("");
			         $("#respman").val(angular.copy($scope.managerd01.selected.userId));
				}
			});
		});
	}


	$scope.getStationsAndUserList=function(){
		$scope.stationdCT = {};
		$scope.stationCT = null;
		$http({method:"POST",url:"${ctx}/UserAuthHandle/getAllSTListForPCBySession.htm",params:{}})
		.success(function (result) {
	    	 $scope.stationCT = result;
	    	 if($("#pstationidCT").val() != null && $("#pstationidCT").val() != "" ){
		    	 for(var i=0,len=$scope.stationCT.length;i<len;i++){
					if($scope.stationCT[i].id==  $("#pstationidCT").val()){
						$scope.stationdCT.selected= { stationname: $scope.stationCT[i].stationname,id:  $("#pstationidCT").val()};
					}
				}
	    	 } else if(result.length==1){
	    		 $scope.stationdCT.selected= { stationname: $scope.stationCT[0].stationname,id:  $scope.stationCT[0].id};
	    		 $("#pstationidCT").val($scope.stationCT[0].id);
	    		 $scope.getUserListCT($scope.stationCT[0].id);
	    	 }
	    	 $scope.textChangeCT= function () {
		         $("#pstationidCT").val(angular.copy($scope.stationdCT.selected.id));
		         //$("#pstationnameCT").val(angular.copy($scope.stationdCT.selected.stationname));
		         $scope.getUserListCT($scope.stationdCT.selected.id);
			}
		});
	}

	$scope.getUserListCT = function(sid){
		$scope.managerdCT = {};
		$scope.managerCT = null;
		$http({method:"POST",url:"${ctx}/AdminUser/selectAllUserBySTID.htm",params:{sid:sid}})
		.success(function (result) {
	    	 $scope.managerCT = result;
	    	 for(var i=0,len=$scope.managerCT.length;i<len;i++){
 					if($scope.managerCT[i].userId==  $("#respmanCT").val()){
 						$scope.managerdCT.selected= { realName: $scope.managerCT[i].realName,userId:  $("#manageridCT").val()};
 					}
 				}
	    	 $scope.managerChangeCT= function () {
		         $("#respmanCT").val(angular.copy($scope.managerdCT.selected.userId));
			}
		});
	}

	$scope.getPstationId=function(eventid){
		$http({method:"POST",url:"${ctx}/DeviceLog/selectDeviceById.htm",params:{id:eventid}})
		.success(function (result) {
			$scope.pstationId = result.pstationid;
		});
	}

	$scope.getEventDetailById=function(eventid){
		$http({method:"POST",url:"${ctx}/FaultHand/getFaultAlarmById.htm",params:{id:eventid}})
		.success(function (msg) {
			$("#stationDiv00").text(msg.pstationname);
			$("#deviceTypeSp00").text((msg.devicetypeStr==null||msg.devicetypeStr=="") ?"-":msg.devicetypeStr);
			$("#deviceNameSp00").text((msg.devicename==null||msg.devicename=="") ?"-":msg.devicename);
			if(msg.faultlevelStr){
				$("#faultLevelSp00").text(msg.faultlevelStr);
			}else if(msg.eventType==-9){
				$("#faultLevelSp00").text("通讯中断");
			}
			$("#faultStatusSp00").text(msg.sysstatusStr);
			$("#sStartTime00").text(msg.sysrptdateStr);
			$("#dStartTime00").text(msg.dStartTimeStr);
			$("#dEndTime00").text(msg.dEndTimeStr);
			$("#faultLevelTd00").text((msg.faultlevelStr==null||msg.faultlevelStr=="") ?"-":msg.faultlevelStr);
			$("#devicenameTd00").text((msg.devicename==null||msg.devicename=="") ?"-":msg.devicename);
			$("#faultcodeTd00").text((msg.eventCode==null||msg.eventCode=="") ?"-":msg.eventCode);
			$("#faultclassTd00").text((msg.faultclassStr==null||msg.faultclassStr=="") ?"-":msg.faultclassStr);
			$("#faultdescTd00").text((msg.eventDesc==null||msg.eventDesc=="") ?"-":msg.eventDesc);
			if(msg.matinAdvices){
				var $advice = $("#matinAdvices .advice");
				var $adviceClone;
				for(var i= 1,ii=msg.matinAdvices.length;i<ii;i++){
					$adviceClone = $advice.clone(true);
					$adviceClone.find(".faultCode").text(msg.matinAdvices[i].faultCode);
					$adviceClone.find(".content").html(msg.matinAdvices[i].content);
					$adviceClone.appendTo($("#matinAdvices"));
				}
				$advice.find(".faultCode").text(msg.matinAdvices[0].faultCode);
				$advice.find(".content").html(msg.matinAdvices[0].content);
			}
			//msg.handStatus = '04';
		});
	}

	$scope.getTaskDetailById=function(taskid){
		$http({method:"POST",url:"${ctx}/Optask/selectById.htm",params:{id:taskid}})
		.success(function (msg) {
			if(msg.pstationname){
				$("#stationnameStr").text(msg.pstationname);
			}else{
				$("#stationnameStr").text("");
			}
			if(msg.distManName){
				$("#distmanStr").text(msg.distManName);
			}else{
				$("#distmanStr").text("");
			}
			if(msg.respManName){
				$("#respmanStr").text(msg.respManName);
			}else{
				$("#respmanStr").text("");
			}
			if(msg.distdate){
				$("#distdateStr").text(dateFormat(new Date(msg.distdate)));
			}else{
				$("#distdateStr").text("");
			}
			if(msg.expectedtime){
				$("#expectedtimeStr").text(dateFormat(new Date(msg.expectedtime)));
			}else{
				$("#expectedtimeStr").text("");
			}
			if(msg.remindtimeStr){
				$("#remindtimeStr").text(msg.remindtimeStr);
			}else{
				$("#remindtimeStr").text("");
			}
			if(msg.taskcontent){
				$("#taskcontentStr").text(msg.taskcontent);
			}else{
				$("#taskcontentStr").text("");
			}
			if(msg.taskstatusStr){
				$("#taskstatusStr").text(msg.taskstatusStr);
			}else{
				$("#taskstatusStr").text("");
			}
			if(msg.finishcontent){
				$("#finishcontentStr").text(msg.finishcontent);
			}else{
				$("#finishcontentStr").text("");
			}
			$("#suggestionList").empty();
			if(msg.suggests && msg.suggests.length>0){
				var html = "";
				for(var i = 0 ,length = msg.suggests.length ; i<length; i++){
					html += '<p>'+msg.suggests[i].content+'</p>';
				}
				$("#suggestionList").append(html);
			}
			if(msg.finishdate){
				$("#finishdateStr").text(dateFormat(new Date(msg.finishdate)));
			}else{
				$("#finishdateStr").text("-");
			}
			if(msg.finishedstatus){
				$("#finishedstatusStr").text(msg.finishedstatus);
			}else{
				$("#finishedstatusStr").text("-");
			}
			if(msg.refimage1){
				$("#imgdiv1").show();
				$("#billImg5").attr("src","${imgPath}/document/faultHand/"+msg.refimage1);
			}else{
				$("#billImg5").attr("src","theme/images/uploadImg.png");
				$("#imgdiv1").hide();
			}
			if(msg.refimage2){
				$("#imgdiv2").show();
				$("#billImg6").attr("src","${imgPath}/document/faultHand/"+msg.refimage2);
			}else{
				$("#billImg6").attr("src","theme/images/uploadImg.png");
				$("#imgdiv2").hide();
			}
			if(msg.refimage3){
				$("#imgdiv3").show();
				$("#billImg7").attr("src","${imgPath}/document/faultHand/"+msg.refimage3);
			}else{
				$("#billImg7").attr("src","theme/images/uploadImg.png");
				$("#imgdiv3").hide();
			}
		});
	}

	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd hh:mm");
		return time;
	}

	$scope.getEventHandleDetailById=function(ehid){
		$http({method:"POST",url:"${ctx}/EventHandle/getEventHandleDetailById.htm",params:{id:ehid}})
		.success(function (msg) {
			$("#processUser02").text(msg.real_name);
			$("#processMethod02").text(msg.processmethodStr);
			$("#processTime02").text(msg.processtimeStr);
			$("#notProceReason02").text(msg.notprocereason_desc);

		});
	}

	$scope.getMessageDetailById=function(messageId){
		$http({method:"POST",url:"${ctx}/BaseMessage/getBaseMessageDetailById.htm",params:{id:messageId}})
		.success(function (msg) {
			$("#busiType00").text(msg.buistypeStr);
			$("#creTime00").text((msg.cretimeStr==null||msg.cretimeStr=="") ?"-":msg.cretimeStr);
			$("#sendUserName00").text((msg.sendusername==null||msg.sendusername=="") ?"-":msg.sendusername);
			$("#recUserName00").text((msg.recusername==null||msg.recusername=="") ?"-":msg.recusername);
			$("#sendTime00").text((msg.sendtimeStr==null||msg.sendtimeStr=="") ?"-":msg.sendtimeStr);
			$("#readTime00").text((msg.readtimeStr==null||msg.readtimeStr=="") ?"-":msg.readtimeStr);
			$("#readStatus00").text((msg.readstatusStr==null||msg.readstatusStr=="") ?"-":msg.readstatusStr);
			$("#sendMethod00").text((msg.sendmethodStr==null||msg.sendmethodStr=="") ?"-":msg.sendmethodStr);
			$("#sendStatus00").text((msg.sendstatusStr==null||msg.sendstatusStr=="") ?"-":msg.sendstatusStr);
			$("#content00").text((msg.content==null||msg.content=="") ?"-":msg.content);

		});
	}

	$scope.stationChange= function () {
        $("#companyid").val(angular.copy($scope.companyd.selected.comId));
        $scope.getStation();
	}

	//企业邀请处理
	$scope.companyInviteHandle=function(id,topmessageId,type){
		$http({
			method : "POST",
			url : "${ctx}/authComUserRel/handleCompanyInvite.htm",
			params : {
				'inviteId':id,
				'topMesId':topmessageId,
				'isAccept':type
			}
		}).success(function(msg) {
			if(msg.result){
				promptObj('success','',msg.infoMsg);
			}else{
				promptObj('error','',msg.infoMsg);
			}
			//刷新列表
			$scope.showNoteList(noteActiveId);
		});
	};

	//业主邀请处理
	$scope.ownerInviteHandle=function(id,topmessageId,type){
		$http({
			method : "POST",
			url : "${ctx}/OpOwnerInvite/dealOpOwnerInvite.htm",
			params : {
				'id': id,
				'type': type,
				'topmessageId': topmessageId
			}
		}).success(function(msg) {
			if(msg.key==0){
				promptObj('success','',msg.msg);
			}else{
				promptObj('error','',msg.msg);
			}
			//刷新列表
			$scope.showNoteList(noteActiveId);
		});
	}
	
	//工作票
	$scope.handleWorkTicket=function(id,type){
		$scope.opTaskIdForWT = id;
		$scope.pstationIdForWT = null;
		$http({
			method : "POST",
			url : "${ctx}/Optask/selectById.htm",
			params : {
				'id': id,
			}
		}).success(function(msg) {
			if(type == 1){
				//查看详情时
				
			}else{
				//填报时
				if(msg){
					$scope.pstationIdForWT = msg.pstationid;
					if(msg.id){
						$scope.$broadcast("fillItem",{id:msg.workTicketId});
					}else{
						$scope.$broadcast("fillItem",null);
					}
					$('#handleWorkTicketId').modal({backdrop: 'static', keyboard: false});
				}
			}
			
			
		});
	}
	
	//缺陷管理
	$scope.handleDefectManagement=function(id,topMessageId,type){
		$scope.opTaskIdForFault = null;
		$scope.pstationIdForFault = null;
		$http({
			method : "POST",
			url : "${ctx}/Optask/selectById.htm",
			params : {
				'id': id,
			}
		}).success(function(msg) {
			if(msg){
				$scope.pstationIdForFault = msg.pstationid;
				//缺陷记录已有时，为更新
				if(msg.faultRecordId){
					if(type == 1){
						//查看详情
						
					}else{
						//填报
						$scope.$broadcast("fillItem",{id:msg.workTicketId});
					}
					
				}else{
					//没有缺陷记录时，查询其他任务是否已关联
					$http({
						method : "POST",
						url : "${ctx}/Optask/selectFaultRecordIdByTopMessageId.htm",
						params : {
							'topmessageId': topMessageId,
						}
					}).success(function(result) {
						if(type == 1){
							//查看详情
							if(result){
								
							}else{
								
							}
						}else{
							//其他任务有缺陷记录时，更新,没有时，为新插入，任务插入时需要关联上缺陷id
							if(result){
								$scope.$broadcast("fillItem",{id:result});
							}else{
								$scope.opTaskIdForFault = id;
								$scope.$broadcast("fillItem",null);
							}
						}
						
					});
				}
				$('#handleDefectManagementId').modal({backdrop: 'static', keyboard: false});
			}
			
			
		});
	}
	
	$scope.showModelDiv1="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData1.jsp";
	$scope.showModelDiv2="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData2.jsp";
	$scope.showModelDiv3="${ctx}/tpl/systemPage/basemessage/modal/taskList_historyData3.jsp";

});

function countTime(time1,time2){
	var countDate;
	var date1=time1;  //开始时间
	var date2=time2;    //结束时间
	var date3=date2-date1  //时间差的毫秒数
	//计算出相差天数
	var days=Math.floor(date3/(24*3600*1000))

	//计算出小时数
	var leave1=date3%(24*3600*1000)    //计算天数后剩余的毫秒数
	var hours=Math.floor(leave1/(3600*1000))
	//计算相差分钟数
	var leave2=leave1%(3600*1000)        //计算小时数后剩余的毫秒数
	var minutes=Math.floor(leave2/(60*1000))

	//计算相差秒数
	var leave3=leave2%(60*1000)      //计算分钟数后剩余的毫秒数
	var seconds=Math.round(leave3/1000);

	if(date3<=0){
		countDate="0 分钟 0 秒";
	}else{
		if(days=="0"){
			if(hours=="0"){
				countDate=minutes+" 分钟"+seconds+" 秒"
			}else{
				countDate=hours+"小时 "+minutes+" 分钟"+seconds+" 秒"
			}
		}else{
			countDate=days+"天 "+hours+"小时 "+minutes+" 分钟"+seconds+" 秒"
		}
	}

	return countDate;
}
</script>
