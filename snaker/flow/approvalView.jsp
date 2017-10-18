<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div ng-controller="approvalController">
	<c:forEach items="${approvals}" var="item">
		<table class="table table-bordered">
			<tr>
				<td>审批人：</td>
				<td>${item.operator }</td>
				<td>审批时间：</td>
				<td>${item.operateTime }</td>
			</tr>
			<tr>
				<td>审批结果：</td>
				<td colspan="3">${item.state == '0' ? '同意' : '不同意' }</td>
			</tr>
			<tr>
				<td>审批意见：</td>
				<td colspan="3">${item.description }</td>
			</tr>
		</table>
	</c:forEach>
</div>
