<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade noteModal" id="liveVideoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-lg" style="width:672px">
		<div class="modal-content col-sm-12 no-padder">
			<a class="icon-close modelCloseBtn" data-dismiss="modal" style="color:rgba(0, 0, 0,.7);z-index:1"></a>
			<div class="modal-body" id="text" style="overflow-y: auto; overflow-x: hidden;">
				<div id="liveVideoDivPage" ng-include="'${ctx}/tpl/rtMonitorPage/video/videoLive.jsp'">
				</div>
			</div>
		</div>
	</div>
</div>

