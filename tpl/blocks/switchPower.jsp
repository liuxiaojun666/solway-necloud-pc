<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.search {width: 50%;min-width: 600px;margin-top: 20px;margin-bottom: 20px;display: inline-block;z-index: 3;position: relative;}
	.search .form-control {border-color: rgb(6 , 190, 189);background-color: #1c2b36;border-radius: 17px;color: #fff;padding-right: 40px;padding-left: 20px;border-width: 2px;}
	.search .search_btn {background-color: transparent;border: none;position: absolute;right: 5px;top: 0;line-height: 32px;color: #fff;font-size: 20px;}
	.search .form-control::-moz-placeholder {color: #f6f6f6;opacity: 1;}
	.search .form-control::-webkit-input-placeholder {color: #f6f6f6;}
	.search .form-control:-ms-input-placeholder {color: #f6f6f6;}
	.tabNav > li {border-bottom: 2px solid transparent;cursor: pointer;}
	.tabNav > .active {border-color: rgb(6 , 190, 189);color: rgb(6 , 190, 189);}
	.activeItem{color: rgb(6 , 190, 189);}
	.tabNav  {margin-bottom: 0;}
	.tabNavSTClass  {color: white; font-size: 17px;margin-right: 10px;}
	.switch_bar {border-bottom: 1px solid rgb(28, 175, 154);}
	.arrowbtn {display: inline-block;width: 16px;background-color: rgb(6 , 190, 189);text-align: center;line-height: 16px;color: rgba(42, 58, 71, .8);vertical-align: middle;font-weight: bold;font-style: normal;cursor: pointer;}
	.arrowbtn.disabled {background-color: #999;cursor: default;}
	.tabCon {padding: 30px 65px;}
	.allBtn1 {background-color: #36444e;border: none;margin-bottom: 20px;line-height: 30px;padding: 0 10px;}
	.tabCon dt {background-color: #36444e;font-weight: normal;line-height: 30px;}
	.tabCon dd {line-height: 40px;}
	.tabCon dd > .circle {display: inline-block; margin-right: 3px;background-color: #3fad22;}
	.tabCon dd.normalsp > .circle {background-color: #3fad22;color: #3fad22;}
	.tabCon dd.fault > .circle {background-color: #db412f;color: #db412f;}
	.tabCon dd.alarm > .circle {background-color: #f90;color: #f90;}
	.tabCon dd.break > .circle {background-color: #999;color: #999;}
	.dl-inline > dt, .dl-inline > dd {display: inline;color: #999;font-weight: normal;}
	.dl-inline > dd {padding: 0 5px;}
	.dl-inline > dd + dd {border-left: 1px solid #999;}
	.tabCon .level-1 {padding-left: 5px;}
	.tabCon .level0 {padding-left: 5px;}
	.tabCon .level1 {padding-left: 20px;}
	.tabCon .level2 {padding-left: 30px;}
	.tabCon .level3 {padding-left: 40px;}
	.tabCon .disabled {color: #ccc;cursor: not-allowed;}
	.ellipse{    white-space: nowrap;text-overflow: ellipsis;-o-text-overflow: ellipsis;overflow: hidden;}
</style>
<div ng-controller="switchPowerCtrl" class="modal fade" id="switchPowerModal">
	<div class="modal-dialog" style="width: 50%;min-width: 670px;">
		<div class="modal-content" style="background-color: rgba(42, 58, 71, .9);font-size: 14px;">
			<a class="icon-close modelCloseBtn time black-1" data-dismiss="modal" style="color: rgb(6 , 190, 189);"></a>
			<div class="modal-body">
				<div class="text-center">
					<!-- <div class="search">
						<form action="">
							<input type="text" class="form-control" placeholder="请输入电站名称">
							<button class="search_btn" type="submit"><i class="ico-family ico-search"></i></button>
						</form>
						<dl class="dl-inline mt5">
							<dt>最近访问：</dt>
							<dd>演示电站1</dd>
							<dd>演示电站2</dd>
						</dl>
					</div> -->
					<div class="text-center">
						<span class="tabNavSTClass" ng-repeat="stClass in stationClasses" >
							<span ng-bind="stClass.name" id="stClass{{stClass.id}}"  class="cp tabNavSTClass2"  ng-class="{'activeItem':(stClass.id == currentSTClass)}" ng-click="changeSTClass(stClass.id)"></span>
						</span>
					</div>
				</div> 
				
				<div style="color: #fff;">
					<div class="switch_bar">
						<span class="h4 mr20">选择分类</span>
						<ul class="list-inline inline tabNav">
							<li class="active" id="stType0">按部门</li>
							<li id="stType1">自定义</li>
						</ul>
						<!-- <div class="pageWrap pull-right">
							<i id="prev" class="arrowbtn disabled mr10">&lt;</i>
							<span id="curPage">1</span>/<span id="pageNums">2</span>
							<i id="next" class="arrowbtn ml10">&gt;</i>
						</div> -->
					</div>
					<div class="tabCon">
						<div class="row">
							<!-- <button class="allBtn disabled"  ng-click="toMonitoring()">全部</button> -->
						</div>
						<dl class="row" ng-repeat="station in stationGroup" style="margin-bottom: 2px;">
							<dt class="col-sm-12 level{{station.level}}">
								<span class="cp" ng-bind="station.name" ng-class="{'disabled': !station.isDisplay,'activeItem':(tabIndex == 'tabIndex0' && station.id == currentSTID && station.stFlag == (currentType + 1) && isCurrentSTClass)}" ng-click="switchStation($event, station.id, station.stFlag, station.name, station.isGroup)"></span>
							</dt>
							<dd class="col-sm-3 level{{station.level + 1}} ellipse" ng-repeat="stationList in station.children" >
								<span ng-class="{'disabled': !stationList.isDisplay,'activeItem':(tabIndex == 'tabIndex0' && stationList.id == currentSTID && stationList.stFlag == (currentType + 1) && isCurrentSTClass)}" ng-bind="stationList.name" class="cp" ng-click="switchStation($event, stationList.id, stationList.stFlag,stationList.name, stationList.isGroup)"></span>
							</dd>
						</dl>
					</div>
					<div class="tabCon none">
						<div class="row">
							<!-- <button class="allBtn" ng-click="toMonitoring()">全部</button> -->
						</div>
						<dl class="row" ng-repeat="station in stationGroupDefined" style="margin-bottom: 2px;">
							<dt class="col-sm-12 level{{station.level}}">
								<span class="cp" ng-bind="station.name" ng-class="{'disabled': !station.isDisplay,'activeItem':(tabIndex == 'tabIndex1' && station.id == currentSTID && station.stFlag == (currentType + 1) && isCurrentSTClass)}" ng-click="switchStation($event, station.id, station.stFlag, station.name, station.isGroup)"></span>
								<!-- <ul class="list-inline pull-right no-margin">
									<li>
										<span class="c9 mr5">实时功率</span>
										<span ng-bind="station.power"></span>&nbsp;
										<span ng-bind=""></span>
									</li>
									<li class="ml10">
										<span class="c9 mr5">日发电量</span>
										<span ng-bind="station.kWh"></span>
									</li>
								</ul> -->
							</dt>
							<dd class="col-sm-3 normalsp level{{station.level + 1}} ellipse" ng-repeat="stationList in station.children" ng-class="{'fault': stationList.status==1, 'alarm': stationList.status==2, 'break': stationList.status==3}">
								<!-- <i class="circle data-bg-green"></i> -->
								<span ng-class="{'disabled': !stationList.isDisplay,'activeItem':(tabIndex == 'tabIndex1' && stationList.id == currentSTID && stationList.stFlag == (currentType + 1) && isCurrentSTClass)}" ng-bind="stationList.name" class="cp" ng-click="switchStation($event, stationList.id, stationList.stFlag, stationList.name, stationList.isGroup)"></span>
							</dd>
						</dl>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	var currentSTClassVar;
	$('.tabNav li').click(function() {
		$(this).addClass('active').siblings().removeClass('active');
		$('.tabCon').eq($(this).index()).show().siblings('.tabCon').hide();
	});
	app.controller('switchPowerCtrl', function($scope, $rootScope, $http, $state, $stateParams, $location) {
		
		$scope.isCurrentSTClass = true;
		$scope.getSTClass = function () {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getSTClassLIst.htm",
			}).success(function(res) {
				$scope.stationClasses = res.data;
				if(!$rootScope.currentSTClass && $scope.stationClasses.length > 0){
					$rootScope.currentSTClass = $scope.stationClasses[0].id;
					currentSTClassVar = $rootScope.currentSTClass;
				}
			});
		}
		
		$scope.getCurrentInfo = function () {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfoNew.htm",
			}).success(function(res) {
				$rootScope.currentSTClass = res.currentSTClass;
				currentSTClassVar = $rootScope.currentSTClass;
				$rootScope.currentSTID = res.currentSTID;
				$rootScope.currentType = res.currentType;
				if(res.stType != null){
					$rootScope.tabIndex = "tabIndex" + res.stType;
					$("#stType" + res.stType).addClass('active').siblings().removeClass('active');
					$('.tabCon').eq($("#stType" + res.stType).index()).show().siblings('.tabCon').hide();
					
				}
				$scope.getSTClass();
				
			});
		}
		
		//获取当前所处的电站
		$scope.getCurrentInfo();
		
		$scope.changeSTClass = function (stClass) {
			if(stClass == $rootScope.currentSTClass){
				$scope.isCurrentSTClass = true;
				if($rootScope.tabIndex){
					var lastChar = $rootScope.tabIndex.substr(-1);
					$("#stType" + lastChar).addClass('active').siblings().removeClass('active');
					$('.tabCon').eq($("#stType" + lastChar).index()).show().siblings('.tabCon').hide();
				}else{
					$('.tabNav li').eq(0).addClass('active').siblings().removeClass('active');
					$('.tabCon').eq(0).show().siblings('.tabCon').hide();
				}
			}else{
				$scope.isCurrentSTClass = false;
				$('.tabNav li').eq(0).addClass('active').siblings().removeClass('active');
				$('.tabCon').eq(0).show().siblings('.tabCon').hide();
			}
			currentSTClassVar = stClass;
			$('.tabNavSTClass2').removeClass('activeItem');
			$('#stClass' + stClass).addClass('activeItem');
			$scope.getAllSTList(stClass);
			
		}
		
		$scope.switchStation = function ($event, powerStationId , stFlag , dataName, isGroup) {
			//alert(powerStationId+"="+stFlag +"=" + dataName)
			if ($($event.target).hasClass('disabled')) {
				return;
			}
			//当再次选择已选择的电站时，直接返回
			if($($event.target).hasClass('activeItem')){
				return;
			}
			
			//每次新增一种电站类型需要在此补充
			//if(currentSTClassVar !='01' && currentSTClassVar !='02') return;
			$("#switchPowerModal").modal('hide');
			if(isGroup == null){
				isGroup = '0';
			}
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeDataType.htm",
				params: {
					id: powerStationId,
					dataType: stFlag - 1,
					isGroup : isGroup,
					stClass : currentSTClassVar
				}
			}).success(function(res) {
				
				if(res.result){
					if(res.isChangeSTClass == 'yes'){
							//当从首页或者消息中心跳到监控视图等页面时
							if(res.isNullSTClass == 'yes'){
								/**if(currentSTClassVar == '01'){
									$state.go('app.dashboard-v1');
								}else if(currentSTClassVar == '02'){
									$state.go('app.wpMonitoring');
								}else if(currentSTClassVar == '03'){
									$state.go('app.meterMonitoring');
								}*/
								$state.go($rootScope.firstMenuUrl[currentSTClassVar]["uisref"]);
							}else{
								//当在不同电站类型间跳转时
								/**if(currentSTClassVar == '01'){
									window.location.href="${ctx}/index.jsp#/app/monitoring";
								}else if(currentSTClassVar == '02'){
									window.location.href="${ctx}/index.jsp#/app/wpMonitoring";
								}else if(currentSTClassVar == '03'){
									window.location.href="${ctx}/index.jsp#/app/meterMonitoring";
								}*/
								window.location.href="${ctx}/index.jsp#/app"+$rootScope.firstMenuUrl[currentSTClassVar]["uiurl"];
								location.reload();
							}
							
						
					}else{
						//此处告诉session
						var msg = {};
						msg.dataId = powerStationId;
						msg.dataName = dataName;
						msg.stFlag = stFlag;
						$rootScope.currentSTClass = currentSTClassVar;
						$rootScope.currentSTID = powerStationId;
						$rootScope.currentType = stFlag - 1;
						$rootScope.tabIndex = "tabIndex" + isGroup;
						if (res.currentSTNum > 1){
							$rootScope.posJcvFlag = false;
						} else {
							$rootScope.posJcvFlag = true;
						}
						$scope.$emit("emitSwitchStation", msg);
					}
				}
				
				
			});
		};
		$('#switchPowerModal').on('shown.bs.modal', function (e) {
			$scope.isCurrentSTClass = true;
			$scope.getAllSTList();
			$scope.getCurrentInfo();
		});
		
		//$('#switchPowerModal').on('shown.bs.modal', function (e) {
		$scope.getAllSTList = function (stClass) {
			$http({
				method: 'POST',
				url: "${ctx}/UserAuthHandle/getAllSTListBySession.htm",
				params: {
					isGroup: $rootScope.isGroup,
					currentView: $rootScope.currentView,
					stClass : stClass
				}
			}).success(function (res) {
				var stationGroup = res.comList;
				var stationGroupDefined = res.groupList;
				$scope.stationGroup = [];
				$scope.stationGroupDefined = [];

				if(stationGroup){
					for (var i = 0; i < stationGroup.length; i++) {
						if (stationGroup[i].parentId === null) {
							stationGroup[i].children = [];
							$scope.stationGroup.push(stationGroup[i])
						}
					}
					
					for (var i = 0; i < stationGroup.length; i++) {
						if (stationGroup[i].parentId !== null) {
							for (var j = 0; j < $scope.stationGroup.length; j++) {
								if ($scope.stationGroup[j].id == stationGroup[i].parentId) {
									$scope.stationGroup[j].children.push(stationGroup[i]);
								}
							}
						}
					}
				}
				
				if(stationGroupDefined){
					for (var i = 0; i < stationGroupDefined.length; i++) {
						if (stationGroupDefined[i].parentId === null) {
							stationGroupDefined[i].children = [];
							$scope.stationGroupDefined.push(stationGroupDefined[i])
						}
					}
					for (var i = 0; i < stationGroupDefined.length; i++) {
						if (stationGroupDefined[i].parentId !== null) {
							for (var j = 0; j < $scope.stationGroupDefined.length; j++) {
								if ($scope.stationGroupDefined[j].id == stationGroupDefined[i].parentId) {
									$scope.stationGroupDefined[j].children.push(stationGroupDefined[i]);
								}
							}
						}
					}
				}
				
				if($rootScope.tabIndex != undefined){
					var lastChar = $rootScope.tabIndex.substr(-1);
					$("#stType" + lastChar).addClass('active').siblings().removeClass('active');
					$('.tabCon').eq($("#stType" + lastChar).index()).show().siblings('.tabCon').hide();
				}				
			});
		};
		
		//$scope.getAllSTList(null);

		$scope.toMonitoring = function () {
			//$state.go('app.dashboard-v1');
			$state.go($rootScope.firstMenuUrl["01"]["uisref"]);
		}

	});
</script>
