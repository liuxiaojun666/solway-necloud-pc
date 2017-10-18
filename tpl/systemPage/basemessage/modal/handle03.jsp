<!-- 不处理 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">

function cllarverifyhandle03(){
	var taskcontent=$("#taskcontent03").val();
	if(taskcontent){
	   $("#taskcontentverify03").html("");
	}
}

function clearHandle03Info(){
	 $("#taskcontentverify03").html("");
	 $("#taskcontent03").val(null);
	 //$("#OtherReasonhandle03").addClass("hidden")
}
</script>
<div class="modal fade noteModal "id="handle03" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
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
			<div class="modal-body wrapper-lg" style="height: 373px">
				<div class="row">
					<div class="col-sm-12">
						<div class="panel-body">
							<form class="bs-example form-horizontal" id="handle03EditForms" name="handle03EditForms">
								<div class="form-group" >
										<label class="col-sm-3  pull-left">不处理原因</label>
										<div class="col-sm-9" id="noHandReasonUl">
										</div>
								</div>
								<div class="form-group " style="height: 200px;">
									<div class="col-sm-12 no-padder" >
										<label class="col-sm-3 control-label pull-left">不处理原因</label>
										<div class="col-sm-8">
											<textarea  rows="8" cols="20" id="taskcontent03" maxlength="200"
												name="taskcontent03" disabled="true"  class="form-control formData" onMouseOut="cllarverifyhandle03()"></textarea>
										<div  id="taskcontentverify03" class="control-label m-t-sm black-1 no-padder"></div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-12 text-center" >
										<button type="button" ng-click="saveHandle03Form()" 
											class="btn m-b-xs w-xs taskBtn">
											<strong>保 存</strong>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
//判断其他原因
function checkRadio(obj) {
	if ($(obj).is(':checked')) {
		if ($(obj).val() == "0") {
			$("#taskcontent03").attr("disabled",false)
		} else {
			$("#taskcontent03").attr("disabled",true)
		}
	}
}
</script>