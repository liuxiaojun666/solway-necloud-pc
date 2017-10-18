<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<div class="bg-light lter b-b col-sm-12" id="head-title" style="padding:15px 0px" ng-controller="meterHeaderCtrl">
	<div class="">
		<div class="col-sm-12 col-xs-12 no-padder">
			<span class="href-blur col-sm-12 no-padder text-muted ">
				<ul class="col-sm-12 nav navbar-nav  m-l-md">
					<li ng-show="posJcvFlag" ng-class="{'hidden':!dailyJt}" class="m-t-xs" >
						<span ng-if="statDayData.comm == 1 || statDayData.status == -99" class="state-img" >
							<i class="stopped" title="通讯中断"></i>
						</span>
						<span ng-if="statDayData.comm == 2" class="state-img" >
							<i class="status-stopped" title="通讯初始化"></i>
						</span>
						<span ng-if="statDayData.comm != 1 && statDayData.comm != 2 && statDayData.status == 1" class="state-img" >
							<i class="status-trouble" title="故障"></i>
						</span>
						<span ng-if="statDayData.comm != 1 && statDayData.comm != 2 && statDayData.status == 2" class="state-img" >
							<i class="status-alarm" title="报警"></i>
						</span>
						<span ng-if="statDayData.comm != 1 && statDayData.comm != 2 && statDayData.status != 1 && statDayData.status != 2 && statDayData.status != -99" class="state-img" >
							<i class="status-normal" title="正常运行"></i>
						</span>&nbsp;
					</li>
					<li>
						<span class="font-h2 blue-1 text-black"  ng-bind="currentDataName | companyInfoFilter:parentName" ></span>
						<span ng-click="changeStation()">[切换]</span>
					</li>
					<li class="m-t-xs m-l-xs" dropdown="" id="changeStationSP" style="display: none;">
						<span class="no-padder dropdown-toggle" dropdown-toggle=""
							aria-haspopup="true" aria-expanded="false">
							<span ng-bind="stationScopeStr"></span>
							<span class="blue-1 caret"></span>
						</span>
						<div class="dropdown-menu animated fadeInUp" style="margin-left: -1px">
							<div class="panel bg-white">
								<div class="list-group">
									<a class="media list-group-item" ng-repeat="vo in stationList"
										ng-click="changeStation({{vo.id}});">{{ vo.stationname}}
									</a>
								</div>
							</div>
						</div>
					</li>
					<li class="m-t-xs m-l-md" ng-show="posJcvFlag">
						<div data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/positioning.jsp'"></div>
						<span data-toggle="modal" data-target="#positioningModal" class="href-blur" ng-click="showPosition();">
								<i class="icon-pointer m-r-xs "></i>定位
						</span>
					</li>
					<li class="m-t-xs m-l-md" ng-show="posJcvFlag">
						<span ng-controller="CarouselDemoCtrl">
								<a class="href-blur" ng-click="showPicture(powerStationId);">
								<img class="m-r-xs m-t-n-xs" src="${ctx}/theme/images/solway/icon/icon-earth.png">实景图 </a>
								<div id="pictureDiv" data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/realistic.jsp'"></div>
					     </span>
					</li>
				</ul>
			</span>
				<span class="href-blur col-sm-12 no-padder text-muted ">
				<ul class="col-sm-12 m-n nav navbar-nav" style="height: 20px;">

					<li class="m-t-xs m-l-md  black-1 font-h5" ng-class="{'hidden':!dailyJt}" ng-show="posJcvFlag">
						最后更新于 <span ng-bind="statDayData.utime | date:'yyyy-MM-dd HH:mm:ss' |dataNullFilter"></span>
					</li>
				</ul>
			</span>
		</div>
		<div class="col-sm-6 text-right hidden-xs pull-right"
			style="margin-top: -45px;">
			<div class="inline m-r-md  text-center">
				<span class="m-b-xs m-n black-1 h3"
					ng-bind="statDayData.powerStationNum|dataNullFilter"></span>
				<div>
					<span class="text-base black-3">工厂数量</span>
				</div>
			</div>
			<div class="inline m-r-md  text-center">
				<span class="m-b-xs m-n black-1 h3"
					ng-bind="statDayData.installedCapacity[0]|dataNullFilter"></span>
					<span class="text-base black-1" ng-bind="statDayData.installedCapacity[1]|dataNullFilter"></span>
				<div>
					<span class="text-base black-3">变压器总容量</span>
				</div>
			</div>
			<div class="inline m-r-md  text-center">
				<span class="m-b-xs m-n black-1 h3" ng-bind="statDayData.accumulateGeneratingPower[0]|dataNullFilter"></span>
				<span class="text-base black-1" ng-bind="statDayData.accumulateGeneratingPower[1]|dataNullFilter"></span>
				<div>
					<span class="text-base black-3">累计用电量</span>
				</div>
			</div>
			<div data-ng-include="'${ctx}/tpl/rtMonitorPage/deviceLayout/weather.jsp'"></div>
			</div>
		</div>
</div>
<script src="${ctx}/theme/js/nowTime.js" type="text/javascript"></script>
<script>
var disTimer;
var syncTimer;
var map;
var lot;
var lat;
app.controller('meterHeaderCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.showPosition = function(){
		// 百度地图API功能
		if(!map){
			map = new BMap.Map("allmap");
			map.enableScrollWheelZoom();   //启用滚轮放大缩小
			map.enableContinuousZoom();    //启用地图惯性拖拽
			//map.addEventListener("click",function(e){
			//	alert(e.point.lng + "," + e.point.lat);
			//});
		}
		if(lot != $scope.stationData.longitude && lat != $scope.stationData.latitude){
			map.clearOverlays();
			lot = $scope.stationData.longitude;
			lat = $scope.stationData.latitude;
			//中心点定位不准，可能样式冲突，人工校正
			var point = new BMap.Point(parseFloat($scope.stationData.longitude) - 0.03083, parseFloat($scope.stationData.latitude) + 0.01553);
			map.centerAndZoom(point, 15);
			var point2 = new BMap.Point($scope.stationData.longitude, $scope.stationData.latitude);
			var marker = new BMap.Marker(point2); // 创建标注
			map.addOverlay(marker); // 将标注添加到地图中
			marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
		}
		
		
		
	};
	//设备布局图
	$scope.showDeviceLayout = function(id,name) {
		$state.go("deviceLayout", {
		//$state.go("app.deviceLayOut", {
			stationId : id,
			stationName : name
		});
	};
	//设备监控
	$scope.showDeviceRtData = function(id,name) {
		$state.go("app.deviceStation", {
			stationId : id,
			stationName : name
		});
	};

	$scope.$on('$stateChangeStart', function(event){
		//clearInterval(disTimer);
	});

	//进入电站监控
	$scope.showStationMonitor1 = function(id) {
		$state.go("app.dashboard-v1", {
			stationId : id
		});
	};

	$scope.changeStation = function(){
		$('#switchPowerModal').modal();
//		$('#switchPowerModal').show();
		$('#switchPowerModal').removeClass("fade");
	};

	if($scope.getStationList){
		$scope.getStationList();
	}
});
app.controller('CarouselDemoCtrl',['$scope','$http',function($scope, $http, $state) {
					$scope.myInterval = 3000;
					$scope.slides = [];
					$scope.addSlide = function(imgSrc) {
						$scope.slides
								.push({
									image : '${imgPath}/document/powerStationPicture/'
											+ imgSrc
								});
					};
					$scope.closeModel = function(imgSrc) {
						$('#photosModal').modal('hide');
					};

					//点击按钮，显示弹出框
					$scope.showPicture = function(id) {
						$scope.slides.length = 0;
						$http.get("${ctx}/PowerStation/selectByIdForMonitor.htm",
										{
											params : {
												id : id
											}
										})
								.success(
										function(
												response) {
											if (response.scenepictures) {
												$scope.picList = response.scenepictures
														.split(",");
												for (var i = 0; i < $scope.picList.length; i++) {
													$scope.addSlide($scope.picList[i]);
												}
											}
											//window.location.href="${ctx}/tpl/rtMonitorPage/monitor/realistic.jsp";
											$('#photosModal').modal('show');
										})
								.error(
										function(response) {
										});
					};
				} ]);
</script>
