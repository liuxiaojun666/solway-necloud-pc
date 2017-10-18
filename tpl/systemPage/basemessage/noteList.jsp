<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- navbar header -->
<!-- 我接受的 --><!-- ng-class="{'noteListActive':{{$index}}=='0'}"  -->
<div id="recMess">
	<div class="col-xs-12 bg-white wrapper b-b a-cur-poi" 
		ng-repeat="note in basemessage"id="note{{note.mid}}"ng-click="showNoteList({{note.mid}},{{note.busitype}})">
		
		<div class="col-xs-4 no-padder black-0 m-b-xs">
			<span class="font-h4 " ng-show="note.musid_real!=null">
				<img  src="${ctx}/theme/images/icon/people.png" class="icon-size m-t-n-xs m-r-xs">
			</span>
			<span class="font-h4 "ng-show="note.musid_real==null">
				<img ng-show="note.recoveryTime!=null" src="${ctx}/theme/images/icon/gear.png" class="icon-size m-t-n-xs m-r-xs">
				<img ng-show="note.recoveryTime==null" src="${ctx}/theme/images/icon/gear-red.png" class="icon-size m-t-n-xs m-r-xs">
			</span>
			<span class="" ng-bind="note.musname"></span>
		</div>
		<div class="col-xs-8 no-padder" >
			<span class="pull-right opa-8 text-1-3x">
				<span class="m-r-xs" ng-bind="note.ct|dateFilter"></span>
				<span id="mhs{{note.mid}}">
				<small ng-if="note.mhs=='00'" class="handle1">
					待确认
				</small>
				<small ng-if="note.mhs=='01'" class="handle1">
					待受理
				</small>
				<small ng-if="note.mhs=='02'" class="handle2">
					待处理
				</small>
				<small ng-if="note.mhs=='03'" class="handle3">
					已关闭
				</small>
				<small ng-if="note.mhs=='04'" class="handle3">
					被确认
				</small>
				<small ng-if="note.mhs=='05'" class="handle2">
					验收中
				</small>
				</span>
            </span>
		</div>
		<div class="col-xs-10 no-padder font-h5 black-1 m-b-xs">
			<span data-ng-bind-html="note.mc|limitTo : 42"></span>
			<span ng-if="note.mc.length >42">...</span>
		</div>
		<div class="col-xs-2 no-padder"  ng-if="note.unread_num>0" id="unread_num{{note.mid}}">
			<span class="badge badge-sm  bg-danger pull-right" ng-bind="note.unread_num">-</span>
		</div>
		<div class="col-xs-12 no-padder">
			<small ng-bind="note.lusname"></small>
			<small ng-if="note.lusname!=null" class="m-r-xs">:</small>
			<small data-ng-bind-html="note.lc|limitTo : 42"></small>
			<small ng-if="note.lc.length >42">...</small>
		</div>
	</div>
</div>
 <!-- ng-class="{'noteListActive':{{$index}}=='0'}"  -->
<!-- 我发送的的 -->
<div id="sendMess">
	<div class="col-xs-12 bg-white wrapper b-b a-cur-poi "
		ng-repeat="note in baseSendmessage"id="{{note.mid}}"ng-click="showNoteList({{note.mid}},{{note.busitype}})" repeat-done="noteActived({{note.busitype}})">
		<div class="col-xs-4 no-padder black-0 m-b-xs">
			<span class="font-h4 " ng-show="note.musid_real!=null">
				<img src="${ctx}/theme/images/icon/people.png" class="icon-size m-t-n-xs m-r-xs">
			</span>
			<span class="font-h4 "ng-show="note.musid_real==null">
				<img ng-show="note.recoveryTime!=null" src="${ctx}/theme/images/icon/gear.png" class="icon-size m-t-n-xs m-r-xs">
				<img ng-show="note.recoveryTime==null" src="${ctx}/theme/images/icon/gear-red.png" class="icon-size m-t-n-xs m-r-xs">
			</span>
			<span class=""ng-bind="note.musname"></span>
		</div>
		<div class="col-xs-8 no-padder">
			<span class="pull-right opa-8 text-1-3x">
				<span class="m-r-xs" ng-bind="note.ct| date:'yyyy-MM-dd HH:mm:ss'"></span>
				<small ng-if="note.mhs=='00'" class="handle1">
					待确认
				</small>
				<small ng-if="note.mhs=='01'" class="handle1">
					待受理
				</small>
				<small ng-if="note.mhs=='02'" class="handle2">
					待维修
				</small>
				<small ng-if="note.mhs=='03'" class="handle3">
					已关闭
				</small>
				<small ng-if="note.mhs=='04'" class="handle3">
					被确认
				</small>
             </span>
		</div>
		<div class="col-xs-10 no-padder font-h5 black-1 m-b-xs">
			<span data-ng-bind-html="note.mc|limitTo : 42"></span>
			<span ng-if="note.mc.length >42">...</span>
		</div>
		<div class="col-xs-2 no-padder"  ng-if="note.unread_num>0">
			<span  class="badge badge-sm  bg-danger pull-right" ng-bind="note.unread_num">-</span>
		</div>
		<div class="col-xs-12 no-padder">
			<small ng-bind="note.lc"></small>
			<small ng-if="note.lc!=null" class="m-r-xs">:</small>
			<small data-ng-bind-html="note.lc"></small>
		</div>
	</div>
	</div>
</div>
