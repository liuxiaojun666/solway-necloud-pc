<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.girdWidth{
	width: 850px!important;
}
.ngGrid{
    width: 850px;
    color:#333!important;
}
/* .ngRow.even {
    background-color: transparent!important;
     color: #333!important;
	}
	.ngRow.odd {
    background-color: rgba(6, 190, 189,.1)!important;
    color: #333!important;
	} */
#junctionBox1{
width:260px!important;
}
#junctionBox2{
width:260px!important;
}
#junctionBox3{
width:260px!important;
}
#interveracu{
width:260px!important;
}
#interveracc{
width:260px!important;
}
#interveracp{
width:260px!important;
}
#interverdcu{
width:260px!important;
}
#interverdcc{
width:260px!important;
}
#interverdcp{
width:260px!important;
}
</style>
<div  class="modal fade noteModal" id="taskList_historyData" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog row modal-lg">
<div class="modal-content col-sm-12 no-padder">
	<!-- <div class="modal-header">
		<h4 class="modal-title font-h3" id="myModalLabel">
			<span>查看设备运行数据</span>
		</h4>
	</div> -->
	<a class="icon-close modelCloseBtn" data-dismiss="modal" ng-click="closeHistoryData_byRTMDeviceLogId(showHistoryData_byRTMDeviceLogId.msg)" style="color:rgba(0, 0, 0,.7);z-index:1"></a>
<!-- 	<button type="button" class="close" data-dismiss="modal" 
	aria-hidden="true" ng-click="closeHistoryData_byRTMDeviceLogId(showHistoryData_byRTMDeviceLogId.msg)">
		
	</button> -->
	<div class="modal-body "  id="text" style="overflow-y: auto; overflow-x: hidden;">
		<!-- 查看设备运行数据 -->
		<div id="taskList_historyData" ng-include="showHistoryData_byRTMDeviceLogId_incloud" load-done="showHistoryData_byRTMDeviceLogId_ready(showHistoryData_byRTMDeviceLogId.msg)"/>
	</div>
</div>
</div>
</div>
