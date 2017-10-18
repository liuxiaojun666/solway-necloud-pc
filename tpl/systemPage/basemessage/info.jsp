<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">      
//初始化页面数据
function initPageData(id){
	if(id != "" && id != null){
		$.ajax({
			type:"post",
			url:"${ctx}/BaseMessage/selectAndreadById.htm",
			data:{"id":id},
			success:function(msg){
				$("#content").html(msg.content);
				$('#searchMain').trigger("click");
			}
		});
	}
}
</script>
<div class="modal fade" id="basemessageInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog row">
<div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
<div class="col-sm-12">
	<span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">消息内容</span>
	
	<div id="content" class="m-t-md m-l-md"/>
	
</div>
</div>
</div>
</div>
</div>
</div>