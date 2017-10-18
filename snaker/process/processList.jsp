<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<title>流程定义</title>
		<%@ include file="/common/meta.jsp"%>
		<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
		<script src="${ctx}/vendor/workflow/jquery-1.8.3.min.js" type="text/javascript"></script>
		<script src="${ctx}/vendor/workflow/table.js" type="text/javascript"></script>
	</head>

	<body>
		<div class="row">
			<div class="col-lg-12">
				<div class="page-header">
					<h1>流程定义</h1>
				</div>
				<form id="mainForm" action="${ctx}/snaker/process/list.htm" method="get">
					<div class="row">
						<div class="col-lg-6">
							<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}"/>
							<span>流程名称：</span>
							<input type="text" class="input_240" name="displayName" value="${param['displayName']}"/>
							<input type='submit' class='btn' value='查询'/>
						</div>
						<div class="col-lg-6">
							<a class="btn btn-primary" href="${ctx}/snaker/process/designer.htm">设计</a>
							<%--<a class="btn btn-primary" href="${ctx}/snaker/process/deploy.htm">部署</a>--%>
							<%--<a class="btn btn-primary" href="${ctx}/snaker/process/init.htm">初始化</a>--%>
						</div>
					</div>
				</form>
				<table class="table table-bordered">
					<tr>
						<th>名称</th>
						<th width="120">ID</th>
						<th>流程显示名称</th>
						<th>状态</th>
						<th>版本号</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${page.result}" var="process">
						<tr>
							<td>
								${process.name}&nbsp;
							</td>
							<td>
								${process.id}&nbsp;
							</td>
							<td>
								${process.displayName}&nbsp;
							</td>
							<td>
								${process.state == 1 ? '启用' : '禁用'}&nbsp;
							</td>
							<td>
								${process.version}&nbsp;
							</td>
							<td>
								<a href="${ctx}/index.jsp#app/flowAccess?processId=${process.id }&processName=${process.name }" class="btnStart" title="启动流程">启动流程2</a>
								<a href="${ctx}/snaker/process/edit/${process.id }.htm" class="btnEdit" title="编辑">编辑</a>
								<a href="${ctx}/snaker/process/designer.htm?processId=${process.id }" class="btnDesigner" title="设计">设计</a>
								<%--<a href="${ctx}/snaker/process/delete/${process.id }.htm" class="btnDel" title="删除" onclick="return confirmDel();">删除</a>--%>
							</td>
						</tr>
					</c:forEach>
				</table>
				<qbi:page curPage="${page.pageNo}" totalPages="${page.totalPages }" totalRecords="${page.totalCount }"/>
			</div>
		</div>
	</body>
</html>
