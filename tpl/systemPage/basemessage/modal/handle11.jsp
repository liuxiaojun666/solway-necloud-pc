<!-- 撤回 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade noteModal bs-example-modal-sm"id="handle11" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-sm" style="width: 350px">
		<div class="modal-content ">
			 <div class="modal-header">
	            <button type="button" class="close" 
	               data-dismiss="modal" aria-hidden="true">
	                  &times;
	            </button>
	            <h4 class="modal-title font-h3 " id="myModalLabel">
	            	提示
	            </h4>
       		  </div>

		<div class="col-sm-12 no-padder m-t m-b" id="OtherReason">
			<h4 class=" font-h3 col-sm-12" id="myModalLabel">
	            	将撤回此任务，确认撤回吗？
	        </h4>
			<div class="col-sm-12">
				<i class="fa fa-asterisk text-required"/>
				<textarea id="handle11_reason"  placeholder="请输入撤回原因" rows="2" cols="10"  maxlength="200" name="taskcontent" class="form-control formData"></textarea>
				<div id="handle11_reasonverify"/>
			</div>
		</div>
		<input type="hidden" id="handle11_id" value="">
		<input type="hidden" id="handle11_topmessageId" value="">
	            
		<div class="modal-footer text-center">
	            <button type="button" ng-click="handle11_do()" class=" btn m-r-sm redBtn">
	               撤 回
	            </button>
	             <button type="button" class="btn btn-default m-l-sm" data-dismiss="modal" style="margin-left:5px">取 消
	            </button>
	         </div>
		</div>
	</div>
</div>