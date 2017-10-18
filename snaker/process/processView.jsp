<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>流程状态</title>
	<%@ include file="/common/meta.jsp"%>

	<link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="${ctx}/vendor/workflow/css/snaker.css" type="text/css" media="all" />
	<link rel="stylesheet" href="${ctx}/vendor/workflow/css/snaker_custom.css" type="text/css" media="all" />
	<script src="${ctx}/vendor/workflow/raphael-min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/jquery-ui-1.8.4.custom/js/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/jquery-ui-1.8.4.custom/js/jquery-ui.min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/snaker/snaker.designer.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/snaker/snaker.model.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/snaker/snaker.editors.js" type="text/javascript"></script>

<script type="text/javascript">
    function addTaskActor(taskName) {
        var url = '${ctx}/snaker/task/actor/add.htm?orderId=${order.id}&taskName=' + taskName;
        var returnValue = window.showModalDialog(url,window,'dialogWidth:1000px;dialogHeight:600px');
        if(returnValue) {
            $('#currentActorDIV').append(',' + returnValue);
        }
    }
	function display(process, state) {
		/** view*/
		$('#snakerflow').snakerflow($.extend(true,{
			basePath : "${ctx}/styles/js/snaker/",
            ctxPath : "${ctx}",
            orderId : "${order.id}",
			restore : eval("(" + process + ")"),
			editable : false
			},eval("(" + state + ")")
		));
	}
</script>
</head>
<body>
<div class="row">
	<div class="col-lg-12">
		<div class="page-header">
			<h1>流程状态</h1>
		</div>
		<blockquote>
			<p>流程名称：${order.processName }</p>
			<p>流程编号：${order.orderNo }</p>
			<p>流程创建时间：${order.createTime }</p>
			<p>流程状态：${order.orderState == 0 ? '结束':'处理中' }</p>
		</blockquote>
		<table class="table table-bordered">
			<tr>
				<td>任务名称</td>
				<td>任务创建时间</td>
				<td>任务完成时间</td>
				<td>任务处理人</td>
			</tr>
			<c:forEach items="${tasks}" var="item">
				<tr>
					<td class="td_list_2">${item.displayName}&nbsp;</td>
					<td class="td_list_2">${item.createTime}&nbsp;</td>
					<td class="td_list_2">${item.finishTime}&nbsp;</td>
					<td class="td_list_2">${item.operator }&nbsp;</td>
				</tr>
			</c:forEach>
			<%--
			<tr>
				<td colspan="4">
					<input type='button' class='btn' value='返回' onclick="history.back()"/>
				</td>
			</tr>
			--%>
		</table>
		<div class="wrapper-md">
			<div class="panel panel-default">
				<div id="snakerflow" style="border: 1px solid #d2dde2; margin-top:10px; margin-left:10px; width:98%;">
				</div>
			</div>
		</div>
	</div>
</div>
		<script type="text/javascript">
		$.ajax({
				type:'GET',
				url:"${ctx}/snaker/process/json.htm",
				data:"processId=${processId}&orderId=${order.id}",
				async: false,
				globle:false,
				error: function(){
					alert('数据处理错误！');
					return false;
				},
				success: function(data){
					display(data.process, data.state);
				}
			});
		</script>
	</body>
</html>
