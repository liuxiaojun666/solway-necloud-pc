<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 去处理 -->
<style>
.noteDetails02 span {
	color: #666;
}
</style>
<div class="modal fade noteModal" id="noteDetails02" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row">
			<div class="modal-content ">
				<!--  <h4 class="modal-title" id="myModalLabel">
	             	消息详情
	            </h4>
       		  </div>
	         <div class="modal-body" >
	         		<div class="col-sm-4 wrapper-xs">业务类型：<span id="busiType00"></span></div>
	               <div class="col-sm-4 wrapper-xs">发送人：<span id="sendUserName00"></span></div>
	              <div class="col-sm-4 wrapper-xs">接受人：<span id="recUserName00"></span></div>
	               <div class="col-sm-4 wrapper-xs">创建时间：<span id="creTime00"></span></div>
	              <div class="col-sm-4 wrapper-xs">阅读状态：<span id="readStatus00"></span></div>
	              <div class="col-sm-4 wrapper-xs">阅读时间：<span id="readTime00"></span></div>
	              <div class="col-sm-4 wrapper-xs">通知方式：<span id="sendMethod00"></span></div>
	              <div class="col-sm-4 wrapper-xs">通知时间：<span id="sendTime00"></span></div>
	              <div class="col-sm-4 wrapper-xs">通知状态：<span id="sendStatus00"></span></div>
	              <div class="col-sm-12 wrapper-xs">消息正文：<span id="content00"></span></div>
	         </div>  -->
				<div class="modal-header">
					<button type="button" class="close"onclick="closeModal02()">&times;</button>
					<h4 class="modal-title">事件处理详情</h4>
				</div>
				<div
					class="modal-body col-sm-12 no-padder black-1 noteDetails02 m-t-md m-b-md">
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-4 ">
							处理人：<span id="processUser02"></span>
						</div>
						<div class="col-sm-3  ">
							处理方式：<span id="processMethod02"></span>
						</div>
						<div class="col-sm-5 ">
							处理时间：<span id="processTime02"></span>
						</div>
					</div>
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-12 ">
							不处理原因：<span id="notProceReason02"></span>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<div class="form-group">
						<div class="col-sm-12 text-center">
							<button type="button" class="taskBtn btn w-xs" onclick="closeModal02()">关闭</button>
						</div>
					</div>
				</div>
			</div>
	</div>
	<script>
	function closeModal02(){
		$('#noteDetails02').modal('hide')
	}
	
	</script>