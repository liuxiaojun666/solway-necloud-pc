<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>流程定义</title>
	<%@ include file="/common/meta.jsp"%>
	<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/vendor/workflow/css/snaker.css" type="text/css" media="all" />
	<link rel="stylesheet" href="${ctx}/vendor/workflow/wbox/wbox/wbox.css" type="text/css" media="all" />
	<script src="${ctx}/vendor/workflow/jquery-ui-1.8.4.custom/js/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/wbox/wbox.js" type="text/javascript"></script>
	<style type="text/css">
		.table > tbody > tr > td {
			text-align: left;
		}
	</style>
</head>

<body>
	<div class="row">
		<div class="col-lg-12">
			<div class="page-header">
				<h1>流程定义</h1>
			</div>
			<form id="inputForm" action="${ctx }/snaker/process/deploy.htm" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${process.id }">
				<table class="table table-bordered">
					<tr>
						<td>
							<span>流程名称：</span>
						</td>
						<td colspan="3">
							&nbsp;${process.name }
						</td>
					</tr>
					<tr>
						<td>
							<span>显示名称：</span>
						</td>
						<td colspan="3">
							&nbsp;${process.displayName }
						</td>
					</tr>
					<tr>
						<td>
							<span>状态：</span>
						</td>
						<td colspan="3">
							&nbsp;${process.state == 1 ? '启用' : '禁用' }
						</td>
					</tr>
					<tr>
						<td>
							<span>上传流程定义文件：</span>
						</td>
						<td colspan="3">
							<input type="file" class="input_file" id="snakerFile" name="snakerFile"/>
						</td>
					</tr>
					<tr>
						<td>
							<span>流程定义：</span>
						</td>
						<td colspan="3">
							${content }
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<input type="submit" class="btn" name="submit" value="提交">
							&nbsp;&nbsp;
							<input type="button" class="btn" name="reback" value="返回" onclick="history.back()">
						</td>
					</tr>
				</table>

			</form>
		</div>
	</div>
</body>
</html>
