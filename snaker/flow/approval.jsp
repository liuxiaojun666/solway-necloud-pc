<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/vendor/snaker/dialog.js" type="text/javascript"></script>
<div ng-controller="approvalController">

	<form id="inputForm" action="${ctx }/snaker/flow/doApproval.htm" method="post" target="mainFrame">
		<input type="hidden" name="processId" value="${processId }" />
		<input type="hidden" name="orderId" value="${orderId }" />
		<input type="hidden" name="taskId" value="${taskId }" />
		<input type="hidden" name="taskName" value="${taskName }" />
		<table class="table_all" align="center" border="0" cellpadding="0" cellspacing="0" style="margin-top: 0px">
			<tr>
				<td class="td_table_1">
					<span>审批结果：</span>
				</td>
				<td class="td_table_2">
					<input type="radio" name="state" value="0" checked="checked"/>同意
					<input type="radio" name="state" value="1"/>不同意
				</td>
			</tr>
			<tr>
				<td class="td_table_1">
					<span>审批意见：</span>
				</td>
				<td class="td_table_2" colspan="3">
					<textarea class="input_textarea_320" id="description" name="description"></textarea>
				</td>
			</tr>
		</table>
		<table align="center" border="0" cellpadding="0"
			   cellspacing="0">
			<tr align="left">
				<td colspan="1">
					<button class="btn btn-primary" ng-click="Sub">提交</button>
					&nbsp;&nbsp;
					<button class="btn"onclick="history.back()">返回</button>
				</td>
			</tr>
		</table>
	</form>

</div>
<script>
	app.controller('approvalController', function($scope, $http, $state) {
		$scope.$on('commonParams',function(event,data) {
			console.log('值过来吧', data);
		});
	});
</script>