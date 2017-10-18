<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div class="wrapper-md" ng-if="items">
	<div class="panel panel-default" ng-repeat="item in items">

		<table class="table table-border">
			<tr>
				<td>审批人：</td>
				<td>{{item.operator }}</td>
				<td>审批时间：</td>
				<td>{{item.operateTime }}</td>
			</tr>
			<tr>
				<td>审批结果：</td>
				<td><span ng-if="item.state == 0">通过</span><span ng-if="item.state == -1">不通过</span></td>
				<td>审批意见：</td>
				<td>{{item.description }}</td>
			</tr>
		</table>

	</div>
</div>