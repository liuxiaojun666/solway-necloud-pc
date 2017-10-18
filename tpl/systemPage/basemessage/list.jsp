<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
app.controller('basemessageListCtrl', function ($scope,$http,$state,$stateParams) {
	$scope.voSelect = -99;
	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}
		//处理voSelect下拉菜单
		if($scope.voSelect==2){
			$scope.readstatus = null;
			$scope.handstatus = 0;
		}else if($scope.voSelect==1){
			$scope.readstatus = 1;
			$scope.handstatus = null;
		}else if($scope.voSelect==0){
			$scope.readstatus = 0;
			$scope.handstatus = null;
		} else {
			$scope.readstatus = null;
			$scope.handstatus = null;
		}
		
		$http({
			method : "POST",
			url : "${ctx}/BaseMessage/list.htm",
			params : {
				'pageIndex'	:page - 1,
				'pageSize'	:$scope.pageSizeSelect,
				
				readstatus:$scope.readstatus,
				handstatus: $scope.handstatus,
				
				content_like:$scope.contentLike,
				
				recuserid	:$stateParams.recuserId,
				sendstatus	:$stateParams.sendstatus
			}
		}).success(function(result) {
			getTableData($scope,result);
		});
	};
	$scope.onSelectPage(1);
	$scope.recuserId = $stateParams.recuserId;
	//点击Enter键查询
	document.onkeydown = function(e) {
	var e = window.event?window.event:e; 
		if(e.keyCode == 13){
			$scope.onSelectPage(1);
		}
	}
	
	$scope.go_taskRespMan = function(id,busino) {
		$.ajax({
			type:"post",
			url:"${ctx}/BaseMessage/selectAndreadById.htm",
			data:{"id":id},
			success:function(msg){
			}
		});
		$state.go("app.taskRespMan", {
			InId : busino,
			recuserId:$stateParams.recuserId,
			backUrl :5
		});
	}
	$scope.go_faultAlarmHand = function(id,busino) {
		$.ajax({
			type:"post",
			url:"${ctx}/BaseMessage/selectAndreadById.htm",
			data:{"id":id},
			success:function(msg){
				
			}
		});
		$state.go("app.faultAlarmHand", {
			faultId : busino,
			recuserId:$stateParams.recuserId,
			backUrl :5
		});
	}
	$scope.to_taskRespMan = function(id,busino) {
		$state.go("app.viewTask", {
			InId : busino,
			recuserId:$stateParams.recuserId,
			backUrl :5
		});
	}

});
angular.module('app', ['ngSanitize']);
app.filter('ellipsis', function ($sce) {	
    return function (text, length) {
        if (text.length > length) {
			return $sce.trustAsHtml(text.substr(0, length) + "...");
        }
        return $sce.trustAsHtml(text);
    }
});
</script>
<!-- 弹出层界面 -->     
<div data-ng-include="'${ctx}/tpl/systemPage/basemessage/info.jsp'"></div>
	
<div ng-controller="basemessageListCtrl">
	<div class="wrapper-md bg-light b-b">
	<span class="font-h3 blue-1 m-n text-black">消息中心
	</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-2 m-b-xs w-sm p-r-sm">    
			
					<select class="input-sm form-control w-sm inline v-middle" ng-model="voSelect" ng-change="onSelectPage(1);">
						<option value="-99">全部</option>
						<option value="0">未读</option>
						<option value="1">已读</option>
						<option value="2">未处理</option>
					</select>
				</div>
				<div class="col-sm-3 m-b-xs w-sm p-r-sm m-l-xs">    
					<input type="text" ng-model="contentLike" id="contentLike" class="input-sm form-control" placeholder="消息内容">
				</div>
				<div class="col-sm-2 m-b-xs w-sm p-r-sm">
					<span class="input-group-btn">
					    <button id="searchMain" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
					</span>
				</div>
				<div class="col-sm-4 pull-right"><%@ include file="/common/pager.jsp"%></div>
			</div>
						
						
		
			<table id="result_table" class="table table-striped b-t b-light">
				<thead>
					<tr>
						<%--<th style="width: 20px;">
							<label class="i-checks m-b-none">
								<input type="checkbox" id="all"
						onclick="changeAll(this.checked,'ids');" /><i></i>
						</label>
						</th>--%>
						<th style="width: 80px;">操作</th>
						<th colspan="2">消息内容</th>
						<th style="width: 100px;">发送用户</th>
						<th style="width: 100px;" ng-if="recuserId==null">接收用户</th>
						<%--<th>接收手机号</th>--%>
						<th style="width: 100px;">创建时间</th>
						<%--<th>业务类型</th>--%>
						<%--<th>业务单号</th>--%>
						<%--<th>发送方式</th>--%>
						<%--<th>发送时间</th>--%>
						<%--<th>草稿&正式</th>--%>
						<th style="width: 100px;" ng-if="recuserId==null">发送状态</th>
					</tr>
				</thead>
				<tbody>
				<tr ng-repeat="vo in data ">
					<%--<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="ids" value="{{vo.id}}" />
					<i></i></label>
					</td>--%>
					<td ng-if="vo.handstatus=='1'">
						<a class="text-info" ng-if="vo.busitype=='00'"><i class="icon-note" ng-click="go_faultAlarmHand({{vo.id}},{{vo.busino}});" style="cursor:pointer"></i></a>
						<a class="text-info" ng-if="vo.busitype=='01'"><i class="icon-note" ng-click="to_taskRespMan({{vo.id}},{{vo.busino}});" style="cursor:pointer"></i></a>
					</td>
					<td ng-if="vo.handstatus!='1'">
						<a class="text-info" ng-if="vo.busitype=='00'"><i class="icon-note" ng-click="go_faultAlarmHand({{vo.id}},{{vo.busino}});" style="cursor:pointer"></i></a>
						<a class="text-info" ng-if="vo.busitype=='01'"><i class="icon-note" ng-click="go_taskRespMan({{vo.id}},{{vo.busino}});" style="cursor:pointer"></i></a>
					</td>
					
					<td style="width: 5px;" ng-if="vo.readstatus=='0'"><i class="fa fa-circle data-red"></i></td>
					<td style="width: 5px;" ng-if="vo.readstatus=='1'"></td>
					
					<td ng-if="recuserId==null" data-ng-bind-html="vo.content|ellipsis:45" ng-click="editData({{vo.id}},'basemessageInfo');" style="cursor:pointer"></td>
					<td ng-if="recuserId!=null" data-ng-bind-html="vo.content|ellipsis:60" ng-click="editData({{vo.id}},'basemessageInfo');" style="cursor:pointer"></td>
					
					<td ng-if="vo.senduserid==null" >系统</td>
					<td ng-if="vo.senduserid!=null" ng-bind="vo.sendusername"></td>
					
					<td ng-if="recuserId==null" ng-bind="vo.recusername"></td>
					<%--<td ng-bind="vo.recphone"></td>--%>
					<td ng-bind="vo.cretime | date:'yyyy-MM-dd HH:mm:ss'"></td>
					<%--<td ng-bind="vo.busitype"></td>--%>
					<%--<td ng-bind="vo.busino"></td>--%>
			
					<%--<td ng-if="vo.sendmethod=='1'">短信</td>
					<td ng-if="vo.sendmethod=='2'">APP消息</td>
					<td ng-if="vo.sendmethod=='3'">邮件</td>--%>
					
					<%--<td ng-bind="vo.sendtime | date:'yyyy-MM-dd HH:mm:ss'"></td>--%>
					
					<td ng-if="recuserId==null && vo.sendstatus=='0'">未发送</td>
					<td ng-if="recuserId==null && vo.sendstatus=='1'">发送成功</td>
					<td ng-if="recuserId==null && vo.sendstatus=='2'">发送失败</td>
					
					<%--<td ng-if="vo.usestatus=='0'">草稿</td>
					<td ng-if="vo.usestatus=='1'">正式</td>--%>
					
				</tr>
				</tbody>
			</table>
		</paging>
		</div>
	</div>
</div>

