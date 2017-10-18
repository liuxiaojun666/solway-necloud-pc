<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<p name="loading" style="margin-top: 100px;" class="text-center"><i class="fa fa-spinner fa-spin fa-2x"/></p>
<p name="nodevicedata" style="margin-top: 100px; display : none" class="text-center">无设备数据</p>
<!-- 设备布局 S -->
<div id="containment-wrapper">

	<div class="dragggroup col-sm-4" ng-repeat="vo in boxChanges" on-finish-render-filters style="padding: 0px;">
		<div class="draggable " ng-class="{'necloud_xiangbian':vo.id > 0}"  name="{{vo.serialnumber}}" id="{{vo.serialnumber}}" ng-dblclick="dblclick(vo.pstationid,vo.id,vo.serialnumber,'3')">
			<!-- <p name="status"/> --><p style="color: #333;position: absolute;margin-top: 12px;margin-left: 80px;white-space: nowrap;" ng-bind="vo.name" /></div>
		<div ng-repeat="inv in vo.inverter">
			<div class="draggable " ng-class="{'necloud_nibianqi':inv.id >0 && inv.hasJB != '1', 'necloud_nibianqi_huiliuxiang':inv.id >0 && inv.hasJB == '1'}"  name="{{inv.serialnumber}}" id="{{inv.serialnumber}}" ng-dblclick="dblclick(inv.pstationid,inv.id,inv.serialnumber,'2',inv.hasJB)" >
				<!-- <p name="status"/> --><p  ng-bind="inv.name" /></div>
			<div ng-repeat="jun in inv.junctionBox"  class="inline" >
				<div ng-click="showDevInfoData(1,jun.serialnumber)" class="draggable "  ng-class="{'necloud_huiliuxiang':jun.id  > 0}"  name="{{jun.serialnumber}}" id="{{jun.serialnumber}}" ng-dblclick="dblclick(jun.pstationid,jun.id,jun.serialnumber,'1')">
					<span class="text-center"><p ng-bind="jun.name" /><p name="statush"/></span></div>
			</div>
		</div>
	</div>

</div>
