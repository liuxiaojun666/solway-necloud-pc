<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<center>
	<ul class="list-inline">
		<li><img src="${ctx}/theme/images/speedSettled/circle1.png"/></li>
		<li>填写电站信息</li>
		<li class="hr-top"></li>
		<li><img src="${ctx}/theme/images/speedSettled/circle2-b.png"/></li>
		<li>填写厂区信息</li>
		<li class="hr-top"></li>
		<li><img src="${ctx}/theme/images/speedSettled/circle3-b.png"/></li>
		<li>填写设备信息</li>
	</ul>
</center>
<div>
<div class="col-sm-12" style="padding-bottom: 20px" ng-controller="speedSettled-threeCtrl">
	<!-- tab 切换开始 -->
	  <ul class="nav nav-tabs nav-border" ng-init="standingBook.activeTab=1">
	    <li ng-class="{active: standingBook.activeTab == 1}">
	    	<a href="javascript:;" ng-click="standingBook.activeTab = 1">箱变台账</a>
	    </li>
	    <li ng-class="{active: standingBook.activeTab == 2}">
	    	<a href="javascript:;" ng-click="standingBook.activeTab = 2">汇流箱台账</a>
	    </li>
	    <li ng-class="{active: standingBook.activeTab == 3}">
	    	<a href="javascript:;" ng-click="standingBook.activeTab = 3">逆变器台账</a>
	    </li>
	    <li ng-class="{active: standingBook.activeTab == 4}">
	    	<a href="javascript:;" ng-click="standingBook.activeTab = 4">其它台账</a>
	    </li>
	  </ul>
	  <div class="tab-content tab-bordered">
	    <div class="tab-panel" ng-show="standingBook.activeTab == 1">
	    <div>
			<!-- --------------------------------------------------------------------------------------------------- -->
			<div data-ng-include="'${ctx}/tpl/ledgerPage/boxChange/boxChangeList.jsp'"></div>
			<!-- --------------------------------------------------------------------------------------------------- -->
	    </div>
	    </div>
	    <div class="tab-panel" ng-show="standingBook.activeTab == 2">
		<div>
			<!-- --------------------------------------------------------------------------------------------------- -->
			<div data-ng-include="'${ctx}/tpl/ledgerPage/junctionBox/junctionBoxList.jsp'"></div>
			<!-- --------------------------------------------------------------------------------------------------- -->
	    </div>
	    </div>
	    <div class="tab-panel" ng-show="standingBook.activeTab == 3">
		<div>
			<!-- --------------------------------------------------------------------------------------------------- -->
			<div data-ng-include="'${ctx}/tpl/ledgerPage/inverter/inverterList.jsp'"></div>
			<!-- --------------------------------------------------------------------------------------------------- -->
	    </div>
	    </div>
	    <div class="tab-panel" ng-show="standingBook.activeTab == 4">
		<div>
			<!-- --------------------------------------------------------------------------------------------------- -->
			<div data-ng-include="'${ctx}/tpl/ledgerPage/otherDevice/otherDeviceList.jsp'"></div>
			<!-- --------------------------------------------------------------------------------------------------- -->
	    </div>
	    </div>
	  </div>
	<!-- tab 切换结束 -->
</div>
<nav class="navbar navbar-default navbar-footer-solway bg-white b-t" role="navigation" >
 	<div class="navbar-header  navbar-header-black ng-scope ">
       <a href="#/" class="navbar-brand font-h2">&nbsp;</a>
     </div>
     <center class="m-t-md">
     	<button class="btn  btn-prev m-r-sm" onclick="window.location.href='#/app/speedSettled/speedSettled-two'">
			<i class="fa fa-chevron-left green m-r-xs"></i> 上一步
		</button>
     	<button class="btn btn-next " ng-click="finish()">
			完 成  <i class="fa fa-chevron-right m-l-xs"></i>
		</button>
		<a class="m-l-md" onclick="window.location.href='${ctx}/index.jsp'" style="color:#999">
			暂不填写，<span class="href-blur">跳过 <i class="fa fa-angle-right"></i></span>
		</a>
	</center>
</nav>
<script type="text/javascript">
app.controller('speedSettled-threeCtrl', ['$http', '$rootScope', '$scope', 'toaster', function($http, $rootScope, $scope, toaster) {
	
	$scope.finish = function() {
		if($rootScope.last_unfinish_bpowerstation_id!="" && 
				$rootScope.last_unfinish_bpowerstation_id!=null){
			$scope.finish_SpeedSettled($rootScope.last_unfinish_bpowerstation_id);
		}else if($('#last_unfinish_bpowerstation_id').val()!="-1" && 
				$('#last_unfinish_bpowerstation_id').val()!="" && 
				$('#last_unfinish_bpowerstation_id').val()!=null){
			$scope.finish_SpeedSettled($('#last_unfinish_bpowerstation_id').val());
		}else{
			toaster.pop('warning','无待完成电站','请返回流程起始创建新电站');
			return;
		}
	}
	
	
	$scope.finish_SpeedSettled = function(last_unfinish_bpowerstation_id) {
		//修改数据库电站流程状态为已完成
		$.ajax({
			type : "post",
			url : "${ctx}/SpeedSettled/speedSettled-three.htm",
			data : {
				"id" : last_unfinish_bpowerstation_id
			},
			dataType : "json",
			success : function(result) {
				if(result){
					$scope.cleanSession_LastUnfinishBpowerstationId();
					toaster.pop('success','已完成电站','');
				}
			},
			error : function() {
				toaster.pop('erroe','完成电站失败','请联系管理员 [speedSettled-threeCtrl]');
			}
		});
	}
	
	
	$scope.cleanSession_LastUnfinishBpowerstationId = function() {
		//清空页面及Session中未完成状态
		$.ajax({
			type : "post",
			url : "${ctx}/SpeedSettled/speedSettled-one.htm",
			data : {
				"id" : null
			},
			dataType : "json",
			success : function(result) {
				if(result){
					$('#last_unfinish_bpowerstation_id').val("-1"); 
					window.location.href='#/app/speedSettled/speedSettled-final';
				}
			},
			error : function() {
				toaster.pop('erroe','清空状态失败','请联系管理员 [speedSettled-threeCtrl]');
			}
		});
	}
}]);
</script>
