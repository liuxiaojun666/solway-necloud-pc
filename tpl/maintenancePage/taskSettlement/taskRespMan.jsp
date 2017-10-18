<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
    <script type="text/javascript">      
	$(function() {
		$('#finishdate').datetimepicker({
			format: "yyyy-mm-dd hh:ii",
			minView: 0,language: 'zh-CN',
		   	autoclose: true
		});
		$("#editForms").validate( {
			rules : {
				pstationid:{
					required : true,
				},
				respman:{
					required : true,
				},
				expectedtime:{
					required : true
				},
				status:{
					required : true
				},
				taskstatus:{
					required : true
				},
				finishdate:{
					datefinish : true
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if(json.message=="repeat"){
							promptObj('error','',"任务已为完成状态,忽略此操作!!!");	
						}else{
							promptObj('success','',json.message);
						}
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
							promptObj('error','',"保存失败,请稍后重试!");
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForms').ajaxSubmit(options);
			}
		});
	});
	function saveForm(){
		if($("#picture2").val()==""){
			$("#picture2").attr("disabled","disabled");
		}
		if($("#picture1").val()==""){
			$("#picture1").attr("disabled","disabled");
		}
		if($("#picture0").val()==""){
			$("#picture0").attr("disabled","disabled");
		}
		$("#editForms").trigger("submit");
	}
	
	//点击完成，必须选择完成时间
	jQuery.validator.addMethod("datefinish", function(value, element) {
		var	task= $("#taskId").val();
		if(task==03){
			return value!="" && value!=null;	
		}else{
			return true;
		}
	 },"请选择完成时间!!!");
	
	//初始化页面数据 
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Optask/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#taskno").val(msg.taskno);
					$("#respman").val(msg.respman);
					$("#pstationid").val(msg.pstationid); 
					$("#pstationname").val(msg.pstationname);
					$("#distManName").val(msg.distManName);
					$("#distman").val(msg.distman);
					$("#taskcontent").html(msg.taskcontent);
					$("#taskconid").val(msg.taskcontent);
// 					$("#faultid").val(msg.faultid);
					$("#eventid").val(msg.eventid);
					$("#eventprocessid").val(msg.eventprocessid);
					$(".hideDiv").hide();
					if(msg.eventid){
						$(".hideDiv").show();
						 $.ajax({
								type:"post",
								url:"${ctx}/DeviceLog/selectDeviceById.htm",
								data:{"id":msg.eventid},
								success:function(msg){
									$("#sstarttime").val(new Date(msg.sStartTime).Format("yyyy-MM-dd hh:mm:ss"));
									$("#sendtime").val(new Date(msg.sEndTime).Format("yyyy-MM-dd hh:mm:ss")); 
									$("#devicename").val(msg.devicename);
									$("#eventdesc").html(msg.eventDesc);  
									$("#faultlevelstr").val(msg.faultlevelStr); 
									$("#faultclassStr").val(msg.faultclassStr);
									$("#eventCode").val(msg.eventCode);
							}
						})
					}
					if(msg.refimage1){
						$("#oldFile0").val(msg.refimage1);
						$("#billImg0").attr("src","${imgPath}/document/faultHand/"+msg.refimage1);
					}
					if(msg.refimage2){
						$("#oldFile1").val(msg.refimage2);
						$("#billImg1").attr("src","${imgPath}/document/faultHand/"+msg.refimage2);
					}
					if(msg.refimage3){
						$("#oldFile2").val(msg.refimage3);
						$("#billImg2").attr("src","${imgPath}/document/faultHand/"+msg.refimag3);
					}
// 					if(msg.sceneimg != null && msg.sceneimg !=""){
// 						var array = msg.sceneimg.split(",");
// 						for (var i=0;i<array.length;i++){
// 							$("#oldFile"+i).val(array[i]);
// 							$("#billImg"+i).attr("src","${ctx}/document/faultHand/"+array[i]);
// 						}
// 					}
					if(msg.expectedtime){
					$("#expectedtime").val( new Date(msg.expectedtime).Format("yyyy-MM-dd hh:mm:ss"));
					}
					if(msg.distdate){
					$("#distdate").val(new Date(msg.distdate).Format("yyyy-MM-dd hh:mm:ss"));
					}
					if(msg.respdate){
					$("#respdate").val(new Date(msg.respdate).Format("yyyy-MM-dd hh:mm:ss"));
					}else{
					$("#respdate").val(new Date().Format("yyyy-MM-dd hh:mm:ss"));	
					}
					if(msg.finishdate){
					$("#finishdate").val(new Date(msg.finishdate).Format("yyyy-MM-dd hh:mm:ss"));
					}
					$("#finishcontent").val(msg.finishcontent);
					var status=msg.taskstatus;
					//radio 选中处理
					if (status) {
						var ridaolen = document.editForms.taskstatus.length;
						for (var i = 0; i < ridaolen; i++) {
							if (status == document.editForms.taskstatus[i].value) {
								document.editForms.taskstatus[i].checked = true;
								 $("#taskId").val(status);
							}
						}
					}
				}
			});
		}	
	}
	
	app.controller('TaskRespManCtrl', ['$http','$scope','$stateParams','$state', function($http, $scope,$stateParams,$state){
		initPageData($stateParams.InId);
		$scope.backInverter = function() {
			if($stateParams.backUrl==0){
				$state.go('app.taskSettlement');
			}else if($stateParams.backUrl==3){
				$state.go('app.faultalarm',{tabId	:$stateParams.tabId});
			}else if($stateParams.backUrl==4){
				$state.go('app.devicerunLog');
			}else if($stateParams.backUrl==5){
				$state.go('app.basemessage',{recuserId	:$stateParams.recuserId});
			}else{
				$state.go('app.myTaskList');
			}
		}
	}]);
	
</script>
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
 
 //任务状态选择时，自动填写当前时间
 function getCurrentDate(value){
	 $("#taskId").val(value);
	if(value==03){
	 $("#finishdate").val(new Date().Format("yyyy-MM-dd hh:mm:ss"));	 
	 }else{
	 $("#finishdate").val("");	 
	 }
 }
</script>
<div  ng-controller="TaskRespManCtrl">
<div class="wrapper-md bg-light b-b">
		<span class="font-h4 blue-1 m-n text-black">派工任务受理</span>
	</div>
	
<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Optask/updateData.htm" method="post" id="editForms" name="editForms" enctype="multipart/form-data">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
<!--           <input type="hidden" name="faultid" value="" id="faultid" class="formData"/> -->
          <input type="hidden" name="eventid" value="" id="eventid" class="formData"/>
          <input type="hidden" name="eventprocessid" value="" id="eventprocessid" class="formData"/>
          <input type="hidden" name="distman" value="" id="distman" class="formData"/>
          <input type="hidden" name="respman" id="respman" class="formData"/>
          <input type="hidden" name="pstationid" id="pstationid" class="formData"/>  
          <input type="hidden" name="taskStatus" id="taskId" class="formData"/> 
<!--设备运行日志 Start -->
    		<div class="form-group hideDiv">   
              <label class="col-lg-2 control-label">开始时间</label>
              <div class="col-lg-3">
 					<input type="text" id="sstarttime" readonly="readonly"  class="form-control formData">
              </div>
               <label class="col-lg-2 control-label">结束时间</label>
              <div class="col-lg-3">
 					<input type="text" id="sendtime" readonly="readonly"  class="form-control formData">
              </div>
            </div>
            
            <div class="form-group hideDiv">   
              <label class="col-lg-2 control-label">故障分类</label>
              <div class="col-lg-3">
 					<input type="text" id="faultclassStr" readonly="readonly"  class="form-control formData">
              </div>
               <label class="col-lg-2 control-label">故障级别</label>
              <div class="col-lg-3">
 					<input type="text" id="faultlevelstr" readonly="readonly"  class="form-control formData">
              </div>
            </div>
            
              <div class="form-group hideDiv">   
              <label class="col-lg-2 control-label">设备名称</label>
              <div class="col-lg-3">
 					<input type="text" id="devicename" readonly="readonly" name="devicename" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
              </div>
               <label class="col-lg-2 control-label">故障编码</label>
              <div class="col-lg-3">
 					<input type="text" id="eventCode" readonly="readonly"  class="form-control formData">
              </div>
            </div>
            
             <div class="form-group hideDiv">
              <label class="col-lg-2 control-label">故障内容</label>
              	<div  class="col-lg-8" id="eventdesc"  style="height: 100px;">
                </div>
              </div>
 <!--设备运行日志 end -->    
        
            <div class="form-group">   
              <label class="col-lg-2 control-label">任务单号</label>
              <div class="col-lg-3">
 					<input type="text" id="taskno" readonly="readonly" name="taskno" class="form-control formData">
 					<textarea style="display:none" id="taskconid" name="taskcontent"></textarea>
              </div>
               <label class="col-lg-2 control-label">电站名称</label>
              <div class="col-lg-3">
 					<input type="text" id="pstationname" readonly="readonly" name="pstationname" class="form-control formData">
              </div>
            </div>
             <div class="form-group">   
              <label class="col-lg-2 control-label">派工时间</label>
              <div class="col-lg-3">
 					<input type="text" id="distdate" readonly="readonly" name="distdate" class="form-control formData">
              </div>
               <label class="col-lg-2 control-label">期望完成时间</label>
              <div class="col-lg-3">
 					<input type="text" id="expectedtime" readonly="readonly" name="expectedtime" class="form-control formData">
              </div>
            </div>
               <div class="form-group">
              <label class="col-lg-2 control-label">任务内容</label>
              	<div  class="col-lg-8" id="taskcontent"  style="height: 100px;">
                </div>
              </div>
             <div class="form-group">   
              <label class="col-lg-2 control-label">受理时间</label>
              <div class="col-lg-3">
 					<input type="text" id="respdate"  name="respdate" readonly="readonly" class="form-control formData">
              </div>
               <label class="col-lg-2 control-label">完成时间</label>
              <div class="col-lg-3">
 					<input type="text" id="finishdate"  name="finishdate" class="form-control formData">
              </div>
            </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">任务状态</label>
				<div id="taskstatus" class="col-lg-10">
					 <label class="checkbox-inline i-checks"> <input
							type="radio" class="form-control " value="02" 
							name="taskstatus"  onclick="getCurrentDate(this.value)"> <i></i> 处理中
						</label><label class="checkbox-inline i-checks"> <input
							type="radio" class="form-control " value="03" 
							name="taskstatus"  onclick="getCurrentDate(this.value)"> <i></i> 完成
						</label>
				</div>
              </div>
            
             <div class="form-group">
                <label  class="col-lg-2 control-label">现场图片</label>
                <div class="col-lg-7 imgfile" style="width:510px">
                	<div class="fileimgsize">
	          			<img id="billImg0" class="fileImg0 fileimgsize" name = "billImg0" src="theme/images/uploadImg.png">
	          			<input type="file" name="picture0" id ="picture0" class="file form-control formData" 
	          			onchange="getImg(this,'fileImg0')"/>
          			</div>
          			<div class="fileimgsize">
	          			<img id="billImg1" class="fileImg1 fileimgsize" name = "billImg1" src="theme/images/uploadImg.png">
	          			<input type="file"  name="picture1" id ="picture1" class="file form-control formData" onchange="getImg(this,'fileImg1')"/>
          			</div>
          			<div class="fileimgsize">
	          			<img id="billImg2" class="fileImg2 fileimgsize"  name = "billImg2" src="theme/images/uploadImg.png">
	          			<input type="file"  name="picture2" id ="picture2" class="file form-control formData" onchange="getImg(this,'fileImg2')"/>
          			</div>
               		<input type="hidden" name="oldFile0" id ="oldFile0"  />
               		<input type="hidden" name="oldFile1" id ="oldFile1"  />
               		<input type="hidden" name="oldFile2" id ="oldFile2"  />
			 	</div>
			 	<div class="col-lg-2 no-padder" style="line-height:95px;">*最多上传三张照片</div>
             </div>
             
             
              <div class="form-group">
              <label class="col-lg-2 control-label">情况说明</label>
              	<div  class="col-lg-8">
               		 <textarea rows="4" maxlength="50" name ="finishcontent" id ="finishcontent" class="form-control formData"></textarea>
                </div>
              </div>
              
             <div class="form-group">
            <div class="col-lg-12 text-center ">   
                 <button type="button" onclick="saveForm();" id="saveButton" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
                <button id="cancelBtn" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" ng-click="backInverter();"><strong>取消</strong></button>
   			 </div>
   			 </div>
          </form>
        </div>
    </div>
  </div>
  </div>
