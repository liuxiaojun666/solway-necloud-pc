<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 去处理 -->
<style>
.noteDetails02 span {
	color: #666;
}
#messageDetailmodal{
overflow-y: auto; overflow-x: hidden}
</style>
<div class="modal fade noteModal bs-example-modal-lg" id="messageDetail" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-lg">
			<div class="modal-content" style="background-color: #f7f7f7;">
				<div class="modal-header" style="border-bottom: 1px solid #ddd">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title">
			  				<span ng-bind="usedTilte"></span>
			  				<span class="m-r-xs m-l-sm data-red" ng-bind="usedDate"></span>
			  				<span class="m-l-sm handle1 handle1-bg  wrapper" ng-if="faultList[0].handstatus=='00'">待确认</span>
				        	<span class="m-l-sm handle1 handle1-bg wrapper" ng-if="faultList[0].handstatus=='01'">待受理</span>
				        	<span class="m-l-sm handle2 handle2-bg wrapper" ng-if="faultList[0].handstatus=='02'">待处理</span>
				        	<span class="m-l-sm handle3 handle3-bg wrapper" ng-if="faultList[0].handstatus=='03'">已关闭</span>
				        	<span class="m-l-sm handle3 handle3-bg wrapper" ng-if="faultList[0].handstatus=='04'">被处理</span>
				</h4>
				</div>
				<div class="col lter" id="messageDetailmodal" >
					<div ng-include="'${ctx}/tpl/systemPage/basemessage/taskList.jsp'">
				</div>
				
			</div>
			
	</div>
