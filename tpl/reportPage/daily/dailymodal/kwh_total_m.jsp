<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#powerEfficForDaily{
overflow-y: auto; overflow-x: hidden}
</style>
<div  class="modal" id="kwhMTotalModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-lg" >
		<div class="modal-content col-sm-12 no-padder n-b-r" style="margin-top:150px;">
			<a class="icon-close modelCloseBtn time black-1" data-dismiss="modal"></a>
			<!-- <a class="dailymodelCloseBtn" data-dismiss="modal">
				<img src="theme/images/close.png"/>	
			</a> -->
			<div class="modal-body " style="min-height: 380px;" id = "powerEfficForDaily">
				<div ng-include="'${ctx}/tpl/reportPage/monthly/powerEffic.jsp'"></div>
			</div>
		</div>
	</div>
</div>
