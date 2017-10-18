<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 去处理 -->
<style>
.noteDetails00 span {
	color: #666;
}
</style>
<script type="text/javascript">
$("#picture0").css("display","block");
function  getImg(obj,fileImgClass){
	  var fileImg = $("."+ fileImgClass);
     var explorer = navigator.userAgent;
     var imgSrc = $(obj)[0].value;
     if (explorer.indexOf('MSIE') >= 0) {
         if (!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/.test(imgSrc)) {
             imgSrc = "";
             fileImg.attr("src","/img/default.png");
             return false;
         }else{
             fileImg.attr("src",imgSrc);
         }
     }else{
         if (!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/.test(imgSrc)) {
             imgSrc = "";
             fileImg.attr("src","/img/default.png");
             return false;
         }else{
             var file = $(obj)[0].files[0];
             var url = URL.createObjectURL(file);
             fileImg.attr("src",url);
         }
     }
     var index=$(".imgfile .file").index($(obj));//获得当前元素的下标
     var imgs=$(".imgfile").children().size();
     if(index<imgs){
  	    var indexS=index+1;
       if(indexS==imgs){
      	 $(".imgfile").css("display","none");
       }
  	    $("#picture" + index).css("display","none");
       $("#picture"+(index+1)).css("display","block");
     }
}

</script>
<div class="modal fade noteModal" id="noteDetails01" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
					<button type="button" class="close" onclick="closeModal01()">&times;</button>
					<h4 class="modal-title">任务详情</h4>
				</div>
				<div
					class="modal-body col-sm-12 no-padder black-1 noteDetails00 m-t-md m-b-md">
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-4 ">
							电站名称：<span id="stationnameStr"></span>
						</div>
						<div class="col-sm-4  ">
							指派人：<span id="distmanStr"></span>
						</div>
						<div class="col-sm-4 ">
							受理人：<span id="respmanStr"></span>
						</div>
					</div>
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-4 ">
							任务指派时间：<span id="distdateStr"></span>
						</div>
						<div class="col-sm-4 ">
							期待完成时间：<span id="expectedtimeStr"></span>
						</div>
						<div class="col-sm-4 ">
						再次提醒时间 ：
							<span id="remindtimeStr"></span>
						</div>
					</div>
					<div class="col-sm-12 m-b">
							任务描述：<span id="taskcontentStr"></span>
					</div>
					<div class="col-sm-12 no-padder m-b">
						<div class="col-sm-4 ">
						任务状态：
							<span id="taskstatusStr"></span>
						</div>
						<div class="col-sm-4 ">
						完成状态：
							<span id="finishedstatusStr"></span>
						</div>
						<div class="col-sm-4 ">
						实际处理时间：
							<span id="finishdateStr"></span>
						</div>
					</div>
						
					<div class="col-sm-12 m-b">
							处理情况：<span id="finishcontentStr"></span>
					</div>
					<div class="col-sm-12 m-b clearfix">
							<div class="pull-left" style="width:5em;">处理建议：</div>
							<div class="col-sm-9 no-padder" id="suggestionList"></div>
					</div>
				<div class="form-group">
                <div class="col-lg-7 imgfile" style="width:510px">
                	<div class="fileimgsize" id="imgdiv1">
	          			<img id="billImg5" class="fileImg5 fileimgsize" name = "billImg5" src="theme/images/uploadImg.png">
          			</div>
          			<div class="fileimgsize" id="imgdiv2">
	          			<img id="billImg6" class="fileImg6 fileimgsize" name = "billImg6" src="theme/images/uploadImg.png">
          			</div>
          			<div class="fileimgsize" id="imgdiv3">
	          			<img id="billImg7" class="fileImg7 fileimgsize"  name = "billImg7" src="theme/images/uploadImg.png">
          			</div>
			 	</div>
             </div>
             
             <div class="form-group" ng-show="isInspected == true">
						<label class="col-sm-2 control-label pull-left">验收意见</label>
						<div class="col-sm-10">
							<textarea rows="4" cols="20"  maxlength="200" id="inspected_content"
								name="inspected_content" class="form-control formData"></textarea>
						</div>
					</div>
					
				</div>
				<div class="modal-footer">
					<div class="form-group">
						<div class="col-sm-12 text-center">
							<button type="button" ng-show="isInspected == true" class="taskBtn btn w-xs" ng-click="handleInspectedData(1)">通过</button>
							<button type="button" ng-show="isInspected == true" class="taskBtn btn w-xs" ng-click="handleInspectedData(3)">不通过</button>
							<button type="button" class="taskBtn btn w-xs" onclick="closeModal01()">关闭</button>
						</div>
					</div>
				</div>
			</div>
	</div>
	</div>
		<script>
	function closeModal01(){
		$('#noteDetails01').modal('hide')
	}
	
	</script>
