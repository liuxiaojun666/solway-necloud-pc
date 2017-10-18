<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>流程展现</title>
	<link rel="stylesheet" href="${ctx}/vendor/workflow/css/snaker.css" type="text/css" media="all" />
	<link rel="stylesheet" href="${ctx}/vendor/workflow/css/snaker_custom.css" type="text/css" media="all" />
	<script src="${ctx}/vendor/workflow/raphael-min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/jquery-ui-1.8.4.custom/js/jquery.min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/jquery-ui-1.8.4.custom/js/jquery-ui.min.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/snaker/snaker.designer.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/snaker/snaker.model.js" type="text/javascript"></script>
	<script src="${ctx}/vendor/workflow/snaker/snaker.editors.js" type="text/javascript"></script>
</head>
<body>

<script type="text/javascript">
	/*
    function addTaskActor(taskName) {
        var url = '${ctx}/snaker/task/actor/add?orderId=${orderId}&taskName=' + taskName;
        var returnValue = window.showModalDialog(url,window,'dialogWidth:1000px;dialogHeight:600px');
        if(returnValue) {
            $('#currentActorDIV').append(',' + returnValue);
        }
    }
	*/
	function display(process, state) {
		/** view*/
		$('#snakerflow').snakerflow($.extend(true,{
			basePath : "${ctx}/vendor/workflow/snaker/",
            ctxPath : "${ctx}",
            orderId : "${param.orderId}",
			restore : eval("(" + process + ")"),
			editable : false
			},eval("(" + state + ")")
		));
	}
</script>
<div class="wrapper-md">
	<div class="panel panel-default">
			<div id="snakerflow" style="border: 1px solid #d2dde2; margin-top:10px; margin-left:10px; margin-bottom:10px; width:98%;">
			</div>
	</div>
</div>
		<script type="text/javascript">
		$.ajax({
				type:'GET',
				url:"${ctx}/snaker/process/json.htm",
				data:"processId=${param.processId}&orderId=${param.orderId}",
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