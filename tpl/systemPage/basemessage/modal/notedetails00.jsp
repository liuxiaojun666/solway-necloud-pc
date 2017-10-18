<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 去处理 -->
<style>
.noteDetails00 span {
	color: #666;
}
</style>
<div class="modal fade noteModal" id="noteDetails00" tabindex="-1"
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
					<button type="button" class="close" onclick="closeModal00()">&times;</button>
					<h4 class="modal-title">事件详情</h4>
				</div>
				<div
					class="modal-body col-sm-12 no-padder black-1 noteDetails00 m-t-md m-b-md">
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-4 ">
							电站名称：<span id="stationDiv00"></span>
						</div>
						<div class="col-sm-4  ">
							设备类型：<span id="deviceTypeSp00"></span>
						</div>
						<div class="col-sm-4 ">
							设备名称：<span id="deviceNameSp00"></span>
						</div>
					</div>
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-4 ">
							故障状态：<span id="faultStatusSp00"></span>
						</div>
						<div class="col-sm-4 ">
							故障码：<span id="faultcodeTd00"></span>
						</div>
						<div class="col-sm-4 ">
							故障级别：<span id="faultLevelTd00"></span>
						</div>
					</div>
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-6 ">
							开始时间：<span id="dStartTime00"></span>
						</div>
						<div class="col-sm-6 ">
							结束时间：<span id="dEndTime00"></span>
						</div>
					</div>
					<div class="col-sm-12 m-b">
							报告时间：<span id="sStartTime00"></span>
					</div>
					<div class="col-sm-12 m-b">
						故障类型：<span id="faultclassTd00"></span>
					</div>
					<div class="col-sm-12 m-b">
						故障描述：<span id="faultdescTd00"></span>
					</div>
					<!-- <div class="col-sm-12 m-b">
						维修建议：
						<div id="matinAdvices">
							<div class="advice">
								<span class="col-sm-1"></span>
								<div class="col-sm-10">
									<span class="faultCode"></span>
									<p class="content"></p>
								</div>
							</div>
						</div>
					</div> -->
				</div>
				<div class="modal-footer">
					<div class="form-group">
						<div class="col-sm-12 text-center">
							<button type="button" class="taskBtn btn w-xs" onclick="closeModal00()">关闭</button>
						</div>
					</div>
				</div>
			</div>
	</div>
			<script>
	function closeModal00(){
		$('#noteDetails00').modal('hide')
	}
	
	</script>