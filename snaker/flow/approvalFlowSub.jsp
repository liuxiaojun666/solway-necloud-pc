<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${ctx}/vendor/workflow/snaker/dialog.js" type="text/javascript"></script>

<div class="wrapper-md">
	<div class="panel panel-default">

		<form id="dataForm" action="${ctx }/snaker/flow/doApproval.htm" method="post">
			<input type="hidden" name="processId" value="{{commonData.processId }}" />
			<input type="hidden" name="orderId" value="{{commonData.orderId }}" />
			<input type="hidden" name="taskId" value="{{commonData.taskId }}" />
			<input type="hidden" name="taskName" value="{{commonData.taskName }}" />
			<input type="hidden" name="taskKey" value="{{commonData.taskKey }}" />
			<table class="table table-bordered">
				<tr>
					<td>
						<span>审批结果：</span>
					</td>
					<td>
						<input type="radio" name="state" value="0" checked="checked"/>通过
						<input type="radio" name="state" value="-1"/>不通过
					</td>
				</tr>
				<tr>
					<td>
						<span>审批意见：</span>
					</td>
					<td>
						<textarea id="description" name="description"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<a id="formSub" class="btn btn-primary">提交</a>
						&nbsp;&nbsp;
						<a id="goBack" class="btn" ng-click="goBack();">返回</a>
					</td>
				</tr>
			</table>
		</form>

	</div>
</div>

<script>

	$(function(){
		$('#formSub').click(function(){
			var options = {
				dataType : "json",
				success : function(json) {
					if (json.code == "0") {
						promptObj('success','',"审核完成");
						$("#goBack").trigger("click");
					} else {
						promptObj('error', '',"审核操作失败");
					}
				},
				error : function(json) {
					$("#errorFlag").trigger('click');
				}
			};
			$('#dataForm').ajaxSubmit(options);
		})
	});
</script>