<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 运维信息 班组、运维人员管理 -->
<script type="text/javascript">

	var opTeamId = "";
	
	//进行控制
	app.controller('MaintenanceCtr', function($scope, $http, $state) {
		
		$scope.operatorIds = "";

		$scope.editData = function(id, modalId) {
			editData(id, modalId);
		}
		initTableConfig($scope);

		//加载班组信息 参数判断是否为初始加载
		$scope.loadTeamInfo = function(isIinit) {
			$http({
				method : "POST",
				url : "${ctx}/opTeam/opTeamList.htm"
			}).success(function(result) {
				var teamData = result.data;
				var teamCount = teamData.length;
				if (result.status && teamCount>0) {
					if(isIinit)
						opTeamId = teamData[0].teamId;
					else
						opTeamId = teamData[teamCount-1].teamId;
					
					$("#opTeamId").val(opTeamId);
					$scope.loadOperatorInfo(opTeamId);
					getTableData($scope, result);
				} else {
					promptObj('error', '',"查询失败");
				}
			});
		};

		//加载运维人员详细信息
		$scope.loadOperatorInfo = function(id,event) {
			//显示选中行
			if(event)
				$scope.showLineFlag(event);
			
			teamId = id;
			$("#opTeamId").val(opTeamId);
			
			$http({
				method : "POST",
				url : "${ctx}/opOperator/opOperatorByTeamId.htm",
				params : {
					'teamId' : id
				}
			}).success(function(result) {
				$scope.operatorData = result.data;
			});
			
		};
		
		$scope.showLineFlag = function(event) {
			var currTd = $(event.target);
			var tdValue =  currTd.html()
			var tds = $("#result_table td");
			for(var i=0;i<tds.length;i++){
				var tempTdValue = tds[i].innerHTML;
				if(tempTdValue == tdValue){
					if(tempTdValue.indexOf("▶") == -1)
						currTd.html("▶" + tdValue);
				}else{
					if(tempTdValue.indexOf("▶") != -1)
						tds[i].innerHTML = (tempTdValue.substring(1,tempTdValue.length));
				}
					
			 }
		}
		
		$scope.loadTeamInfo(true);
	});
</script>
<!-- 弹出层界面 -->
<div data-ng-include="'${ctx}/tpl/maintenancePage/maintenanceInfo/addTeam.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/maintenancePage/maintenanceInfo/addOperator.jsp'"></div>

<div ng-controller="MaintenanceCtr">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h1 blue-1 m-n text-black">运维信息管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="col-sm-3 panel padder-l-sm no-padder"  style="text-align:center;">
				<div class="panel-heading">班組信息</div>
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th>
								组数：<span class="font-h4 black-1"  ng-bind="data.length">0</span>&nbsp;&nbsp;&nbsp;
								 成员数：<span class="font-h4 black-1"  ng-bind="operatorData.length">0</span>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in data ">
							<td ng-click="loadOperatorInfo(vo.teamId,$event)">{{vo.teamName}}</td>
						</tr>
					</tbody>
				</table>
				<button type="button" class="btn btn-default" onclick="addData('opTeamModal');">+添加班组</button>
			</div>
			<div class="col-sm-9 panel" style="padding:0px 0px 0px 10px;">
				<div class="panel-heading">运维人员信息</div>
				<table id="operator_table" class="table table-striped b-t b-light" style="align:'right'">
					<thead>
						<tr>
							<th>人员姓名</th>
							<th>联系电话</th>
							<th>入职时间</th>
							<th>专业特长</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="vo in operatorData ">
							<td>{{vo.realName}} <span  ng-show="vo.isteamleader==1">&nbsp;&nbsp;&nbsp;<img src="${ctx}/theme/images/icon-teamleader.png"></img>[组长]</span></td>
							<td ng-bind="vo.tel"></td>
							<td ng-bind="vo.entrytime"></td>
							<td ng-bind="vo.skills"></td>
						</tr>
					</tbody>
				</table>
				<button type="button" class="btn btn-primary pull-right"  onclick="addData('opOperatorModal');">+ 添加成员</button>
			</div>
		</div>
	</div>
</div>
