<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<div ng-controller="baseRegionUploadCtrl" class="modal fade" id="baseRegionUpload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <div class="modal-dialog ">
      <div class="modal-content ">
		<div class="modal-body">
	<div class="">
		<span class="font-h3 blue-1 m-n ">导入行政区划信息</span>  
	</div>
	<div class="wrapper-md ng-scope">
	<div class="panel panel-default">
		<div style="padding: 45px;">
           <form  class="m-t-lg form-horizontal ng-pristine ng-valid" action="${ctx}/BaseInfo/uploadBaseRegionExcel.htm" method="post" id="uploadForm" name="uploadForm">
                <div class="m-t-md" style="padding: 30px;">
                <input type="file" name="fileExcel" class="col-lg-6">
                <input type="hidden" name="pstationid" id="filepstationid">
                </div>
            </form> 
            <div class="form-group m-t-lg">
	            <div class="col-lg-12 text-center">  
	            	<button type="button" onclick="saveUploadForm();" id="saveBoxButton" class="  btn m-b-xs w-xs   btn-info"><strong>上传</strong></button> 
	                <button id="closebut" type="button" data-dismiss="modal" class="m-l-sm  btn m-b-xs w-xs btn-default"><strong>取消</strong></button>
	   			 </div>
   			</div>
     </div>
     </div>
   </div>
 </div>
</div>
</div>
</div>
<script type="text/javascript">
$(function() {
	$("#uploadForm").validate({
		rules : {
			code : {
				number : true,
				required : true,
				maxlength : 50
			},
			cycle : {
				digits : true
			},
		},
		submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(json) {
					if (json.type == "error"){
						promptObj(json.type, '',json.message);
						$("#closebut").trigger("click");
					}else{
						//hideModal("boxChangeModal");
						alert(json.message);
						promptObj(json.type, '',json.message);
						$("#closebut").trigger("click");
					}
				},
				error : function(json) {
					//hideModal("boxChangeModal");
					promptObj("error", '',"操作失败,请稍后重试");
				}
			};
			$('#uploadForm').ajaxSubmit(options);
		}
	});

});
$("#filepstationid").val($("#stationid").val());
function saveUploadForm() {
	$("#filepstationid").val($("#stationid").val());
	$("#uploadForm").trigger("submit");
}
app.controller('baseRegionUploadCtrl',
		['$http','toaster', '$location', '$rootScope', '$scope', '$state', '$stateParams',
		 function($http,toaster, $location, $rootScope, $scope, $state, $stateParams){
			
		}]);

</script>
