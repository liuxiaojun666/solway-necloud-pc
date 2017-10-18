<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 记录维修情况 -->
<style>
a.deal-suggest-con{display:block;padding: 5px;margin-bottom: 5px;}
a.deal-suggest-con.active{color:white;background:#06bebd;}
.level-content >li{display:block; margin-bottom: 5px;line-height: 25px;}
.item label{margin:0;width:100%;background: rgb(245,245,245);padding: 5px;}
.item label.active{background: rgb(27,197,196);
.level-title label.active{background: rgb(27,197,196);}
</style>
<script type="text/javascript">
	function cllarverifyhandle02(){
		var handle2_finishdate=$("#handle2_finishdate").val();
		var handle2_content=$("#handle2_content").val();
		
		if(handle2_finishdate){
		   $("#handle2_finishdateverify").html("");
		   $('#handle2_finishdate').removeClass('error');
		}
		
		if(handle2_content){
		   $("#handle2_contentverify").html("");
		   $('#handle2_content').removeClass('error');
		}
	}
	
	function clearHandle02Info(){
	   $("#handle2_finishdateverify").html("");	
	   $("#handle2_contentverify").html("");
	   
	   $('#handle2_finishdate').removeClass('error');
	   $('#handle2_content').removeClass('error');
	   
	   $("#handle2_contentverify").val(null);
	   $("#picture0").val(null);
	   $("#picture1").val(null);
	   $("#picture2").val(null);
	   $("#billImg0").attr("src","theme/images/uploadImg.png");
	   $("#billImg1").attr("src","theme/images/uploadImg.png");
	   $("#billImg2").attr("src","theme/images/uploadImg.png");
	   $("#picture0").attr("disabled",false);
	   $("#picture1").attr("disabled",false);
	   $("#picture2").attr("disabled",false);
	   
	   $("#handle2_finishdate").val(endDate(new Date()));
	}
	function endDate(date){
		var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
		return endTime;
	}
	</script>
<div class="modal fade noteModal "id="handle2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row">
		<div class="modal-content ">
			 <div class="modal-header">
	            <button type="button" class="close" 
	               data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <h4 class="modal-title font-h3" id="myModalLabel">
	               <span ng-bind="faultList[0].content|limitTo : 42"></span>
				   <span ng-if="faultList[0].content.length >42">...</span>
				   <span class="m-l-sm">
				   	 <span ng-if="faultList[0].handstatus=='00'" class="handle1">
						待确认
					</span>
					<span ng-if="faultList[0].handstatus=='01'" class="handle1">
						待受理
					</span>
					<span ng-if="faultList[0].handstatus=='02'" class="handle2">
						待处理
					</span>
					<span ng-if="faultList[0].handstatus=='03'" class="handle3">
						已关闭
					</span>
					<span ng-if="faultList[0].handstatus=='04'" class="handle3">
						被确认
					</span>
				   </span>
	            </h4>
       		  </div>
			<div class="modal-body wrapper-lg" >
				 <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Optask/finishTask.htm" method="post" id="editForms" name="editForms" enctype="multipart/form-data">
					<div class="form-group">
						<label class="col-sm-3 control-label pull-left">实际处理时间<i class="fa fa-asterisk text-required"/></label>
						<div class="col-sm-5">
							<input type="text" class="form-control formData" id="handle2_finishdate"  readonly="true">
							<div id="handle2_finishdateverify"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-3 control-label pull-left">处理情况<i class="fa fa-asterisk text-required"/></label>
						<div class="col-sm-8">
							<textarea rows="4" cols="20"  maxlength="200" id="handle2_content"
								name="taskcontent" class="form-control formData" onMouseOut="cllarverifyhandle02()"></textarea>
							<div id="handle2_contentverify"/>
						</div>
					</div>
					<div class="form-group" ng-show="suggestsList.length>0">
						<label class="col-sm-3 control-label pull-left">处理建议<i class="fa fa-asterisk text-required"/></label>
						<div class="col-sm-9">
							<ul class="level-content" style="-webkit-padding-start: 0;">
								<li ng-repeat="i in suggestsList" class="item">
									<label id="item{{i.id}}"  name="{{i.id}}" class="suggestItem common-item" ng-click="selectAll({{i.id}})">{{i.content}}</label>
						        </li>
						        <li class="item">
						        	<label name="other" id="other" class="suggestItem other-item" ng-click="selectAll('other')">其它</label>
						        </li>
							</ul>
							<div id="handle2_severify" style="display:none;color: red;">必选项</div>
						</div>
					</div>
					<div class="form-group">
							<label class="col-sm-3 control-label pull-left">验收人</label>
							<div class="col-sm-4 select">
				            <ui-select ng-model="managerd02.selected" theme="bootstrap" ng-change="managerChange02()">
					            <ui-select-match placeholder="请输入关键字..." ng-model="managerd02.selected.realName" >{{$select.selected.realName}}</ui-select-match>
					            <ui-select-choices  repeat="item in manager02 | filter: $select.search">
					              <div ng-bind-html="item.realName | highlight: $select.search"></div>
					            </ui-select-choices>
				         	 </ui-select>
				         	 <input type="hidden" onMouseOut="cllarverifyhandle02()" id="inspectedMan" name="inspectedMan" class="form-control formData"/>
							<div  id="inspectedmanverify" class="control-label m-t-sm black-1 no-padder"></div>
							</div>
					</div>
					
					<div class="form-group">
			                <label  class="col-sm-3 control-label">现场图片</label>
			                <div class="col-sm-7 imgfile-sm" style="width:360px">
			                	<div class="fileimgsize-sm">
				          			<img id="billImg0" class="fileImg0 fileimgsize-sm" name = "billImg0" src="theme/images/uploadImg.png">
				          			<input type="file" name="picture0" id ="picture0" class="file form-control formData" 
				          			onchange="getImg(this,'fileImg0')"/>
			          			</div>
			          			<div class="fileimgsize-sm">
				          			<img id="billImg1" class="fileImg1 fileimgsize-sm" name = "billImg1" src="theme/images/uploadImg.png">
				          			<input type="file"  name="picture1" id ="picture1" class="file form-control formData" onchange="getImg(this,'fileImg1')"/>
			          			</div>
			          			<div class="fileimgsize-sm">
				          			<img id="billImg2" class="fileImg2 fileimgsize-sm"  name = "billImg2" src="theme/images/uploadImg.png">
				          			<input type="file"  name="picture2" id ="picture2" class="file form-control formData" onchange="getImg(this,'fileImg2')"/>
			          			</div>
			               		<input type="hidden" name="oldFile0" id ="oldFile0"  />
			               		<input type="hidden" name="oldFile1" id ="oldFile1"  />
			               		<input type="hidden" name="oldFile2" id ="oldFile2"  />
						 	</div>
						 	<div class="col-sm-3 col-sm-offset-3 m-t-sm" >*最多上传三张照片</div>
		             	</div>
		             	
	             	
					<!-- 隐藏域参数 --Start-->
		             <input type="hidden" name="id" id="id" class="clearData">
		             <input type="hidden"  name="topmessageId" id="topmessageId" class="clearData">
		             <input type="hidden"  name="finishdate" id="finishdate" class="clearData">
		             <input type="hidden"  name="taskstatus" id="taskstatus" class="clearData">
		             <input type="hidden"  name="finishedstatus" id="finishedstatus" class="clearData">
		             <input type="hidden"  name="finishcontent" id="finishcontent" class="clearData">
		             <input type="hidden"  name="eventid" id="eventid" class="clearData">
		             <input type="hidden" name="adviceIds" id="adviceIds" class="clearData"><!-- 处理列表已选中项id数组 -->
		            <!-- 隐藏域参数 --end-->
		             <input type="hidden" id="handle2_topmessageId" value="">
		             <input type="hidden" id="handle2_id" value="">
		             <input type="hidden" id="handle2_taskstatus" value="">
					<div class="form-group" style="margin-top:30px">
						<div class="col-sm-offset-2 col-sm-9 text-center" >
							<button type="button" ng-click="handle2_save('1')" 
								class="btn m-b-xs w-xs taskBtn">
								<strong>完成了</strong>
							</button>
							<button type="button" ng-click="handle2_save('0')" 
								class="btn m-b-xs w-xs  btn-default" style="margin-left:5px">
								<strong>未完成</strong>
							</button>
							<button type="button" data-dismiss="modal" aria-hidden="true"
								class="btn m-b-xs w-xs btn-default" style="margin-left:5px">
								取消
							</button>
						</div>
					</div>
				</form>
         			 </div>
				</div>
		</div>
	</div>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script type="text/javascript">

	$("#editForms").validate( {
		rules : {
		},submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(msg) {
					if(msg.result){
						promptObj('success','',msg.infoMsg);
					}else{
						promptObj('error','',msg.infoMsg);
					}
					$('#handle2').modal('hide');
					//刷新列表
// 					$scope.showNoteList(noteActiveId);
					showNoteList(noteActiveId);
				},error : function(json) {
						promptObj('error','',"保存失败,请稍后重试!");
				}
			};
			$('#editForms').ajaxSubmit(options);
		}
	});



//上传图片
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
  	    $("#handle2_picture" + index).css("display","none");
       $("#handle2_picture"+(index+1)).css("display","block");
     }
}

 //任务状态选择时，自动填写当前时间
 function getCurrentDate(value){
	 $("#taskId").val(value);
 }
</script>
