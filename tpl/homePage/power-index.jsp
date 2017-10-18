<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.waterPlaceholder::before {right: 200px;}
</style>
<div ng-controller="homeCtrl">
	<!-- navbar -->
	<div data-ng-include=" 'tpl/blocks/header.jsp' " class="app-header navbar box-shadow">
	</div>
	<!-- / navbar -->
	<div ng-controller="powerhomeCtrl" class="container no-padder">
		<!-- 普通模式 -->
		<%--<div class="text-center clearfix">
			<h2>普通模式</h2>
			<div>
				<a class="i_switchMap default-blue" ng-click="toMonitoringMap()">切换成地图模式</a>
			</div>
			<div class="col-xs-6 col-xs-offset-3 search_form">
				<form action="">
					<input class="form-control search placeholder_center" type="search" placeholder="搜索">
				</form>
			</div>
		</div>--%>
		<!-- 普通模式- END -->
		<div style="text-align:right;padding-bottom:5px;margin-top: 10px;">
			<a class="i_switchMap default-blue" ng-click="toMonitoringMap()">切换成地图模式</a>
		</div>
		<!-- 数据统计块 -->
		<div class="row text-center stat_block no-margin" style="width: 1170px;">
			<!-- 功率与发电量 -->
			<div class="col-xs-6 no-padder">
				<div class="col-xs-6 no-padder data-bg-red bg_height" ng-click="showRealPower('1')">
					<div class="circleProgress_box">
						<div class="circleProgress_wrap" style="">
							<div class="wrapper wrapper_ly right">
								<div class="circleProgress rightcircle"></div>
							</div>
							<div class="wrapper wrapper_ly left">
								<div class="circleProgress leftcircle"></div>
							</div>
						</div>
						<div class="circleProgress_data">
							<div>实时功率</div>
							<span ng-bind="powerStation.realTimePower[0]|dataNullFilter" class="h2"></span>{{realTimePower.realPower[1]}}
							<div class="divider"></div>
							<div>总装机</div>
							<span ng-bind="powerStation.installedCapacity[0]|dataNullFilter" class="h3">634</span>{{powerStation.installedCapacity[1]}}
						</div>
					</div>
					<!-- <div class="text_r_percent">
						<span ng-bind="powerStation.realInst|dataNullFilter" ></span>%
					</div> -->
				</div>
				<div class="col-xs-6 no-padder block_kwh ">
					<div class="data-bg-green" ng-click="showRealPower('2')">
						<p>日发电量</p>
						<span ng-bind="powerStation.dayGeneratingPower[0]|dataNullFilter" class="h3"></span>{{powerStation.dayGeneratingPower[1]}}
					</div>
					<div class="month_bg" ng-click="showRealPower('3')">
						<p>月累计发电量</p>
						<span ng-bind="powerStation.monthGeneratingPower[0]|dataNullFilter" class="h3"></span>{{powerStation.monthGeneratingPower[1]}}
						<div class="text_r_percent">
							<span ng-bind="powerStation.monthRate|dataNullFilter" ></span>%
						</div>
					</div>
					<div class="year_bg" ng-click="showRealPower('4')">
						<p>年累计发电量</p>
						<span ng-bind="powerStation.yearGeneratingPower[0]|dataNullFilter" class="h3"></span>{{powerStation.yearGeneratingPower[1]}}
						<div class="text_r_percent">
							<span ng-bind="powerStation.yearRate|dataNullFilter" ></span>%
						</div>
					</div>
					<div class="total_bg" ng-click="showRealPower('5')">
						<p>累计发电量</p>
						<span ng-bind="powerStation.accumulateGeneratingPower[0]|dataNullFilter" class="h3"></span>{{powerStation.accumulateGeneratingPower[1]}}
					</div>
				</div>
			</div>
			<!-- 功率与发电量 END-->
			<!-- 故障与统计分析 -->
			<div class="col-xs-6 no-padder">
				<div class="failure_wrap pull-left">
					<div class="failures_bg failure_up bg_hei">
						<span class="h1" ng-bind="faultAlarms.total|dataNullFilter"></span>
						<span class="h4">故障台数</span>
					</div>
					<div class="failure_down">
						<div class="fault_bg">
							<span class="h2" ng-bind="faultAlarms.fault|dataNullFilter"></span>
							<p>故障</p>
						</div>
						<div class="alarm_bg">
							<span class="h2" ng-bind="faultAlarms.warn|dataNullFilter"></span>
							<p>报警</p>
						</div>
						<div class="break_bg">
							<span class="h2" ng-bind="faultAlarms.interrupt|dataNullFilter"></span>
							<p>中断</p>
						</div>
					</div>
				</div>
				<div class="block_right pull-left">
					<!-- <a class="stat_bg db inherited" ui-sref="app.statistics.staDay({roleId: HeaderRoleId})">
						<span class="h4">统计分析</span>
					</a> -->
					<a class="stat_bg db inherited" >
						<span class="h4">统计分析</span>
					</a>
					<a class="block_knows db inherited mt10" href="javascript:;" ng-click="toBaseMessage()">
						<i class="i_msg_center mr40" style="vertical-align: middle;"></i>
						<span class="h4 pr" style="display: inline-block;">
							消息中心<span style="margin-left: -2px;top: -8px;" class="badge bg-danger msg_center_num"></span>
						</span>
					</a>
					<!-- <div class="block_right_d">
						<a class="knows_bg inherited">
							<i class="i_knows"></i>
							<p>知识库</p>
						</a>
						<div ng-click="toBaseMessage()" class="default-blue-bg cp">
							<i class="i_msg_center">
								<span class="badge bg-danger msg_center_num">2</span>
							</i>
							<p>消息中心</p>
						</div>
					</div> -->
				</div>
			</div>
			<!-- 故障与统计分析 END -->
		</div>
		<!-- 数据统计块 END -->
		<!-- 电站列表 -->
		<div class="power_tab no-padder text-sm">
			<div class="pos-rlt powerList">
				<span class="text-base">电站列表</span>
				<ul class="power_tab_nav list-inline">
					<li ng-click="switchTab(tabnav)" ng-repeat="tabnav in tabNav" ng-class="{'active':tabnav==tabNav[0]}">{{tabnav}}</li>
				</ul>
				<ul class="tab_pager list-inline">
					<li ng-click="prevPage()" class="prev pager_arror"><a href=""></a></li>
					<li class="pager_go no-padder"><span ng-show="goPageInputFlag" ng-click="goPageInput()"><span>{{curPage}}</span>/{{pageNums}}</span><input ng-show="!goPageInputFlag" class="inputNum text-center" type="text"></li>
					<li ng-click="nextPage()" class="next pager_arror"><a href=""></a></li>
				</ul>
			</div>
			<ul class="list-unstyled power_tab_con" d="alert('b')">
				<li ng-repeat="tabList in powerStationList" ng-class="{'tab_fault': tabList.status==1, 'tab_alarm': tabList.status==2, 'tab_break': tabList.status==3}">
					<div class="name">
						<i class="circle data-bg-green"></i><span ng-bind="tabList.name"></span>
					</div>
					<span class="powerList_weather">
						<i class="ico-family ico-sun sun_color" ng-show="tabList.weather=='晴'"></i>
						<i class="ico-family ico-yin yin_color" ng-show="tabList.weather=='阴'"></i>
						<i class="ico-family ico-rain rain_color" ng-show="tabList.weather=='雨'"></i>
						<i class="ico-family ico-snow snow_color" ng-show="tabList.weather=='雪'"></i>
						<i class="ico-family ico-smog smog_color" ng-show="tabList.weather=='霾'"></i>
						<i class="ico-family ico-weatherelse weatherelse_color" ng-show="tabList.weather=='其它'"></i>
					</span>
					<ul class="list-unstyled text-right">
						<li class="nowrap m-t-xs">
							<span class="pull-left black-4">实时功率</span>
							<span class="font-h4">{{tabList.power[0]}}{{tabList.power[1]}}</span>
							<!-- <span class="font-h4">{{tabList.realInst[0]}}{{tabList.realInst[1]}}&nbsp;</span> -->
						</li>
						<li class="nowrap m-t-xs">
							<span class="pull-left black-4">日发电量</span>
							<span class="font-h4">{{tabList.dw[0]}}{{tabList.dw[1]}}&nbsp;</span>
						</li>
					</ul>
					<ul class="row no-padder list-unstyled hoverLayer">
						<li ng-repeat="vl in tabList.viewList" class="col-sm-6 m-t-xs">
							<a ng-class="{'i_mon': vl.viewCodeAndRW.substring(0,2)=='00','i_pro': vl.viewCodeAndRW.substring(0,2)=='01',
						'i_alaly': vl.viewCodeAndRW.substring(0,2)=='02','i_bill': vl.viewCodeAndRW.substring(0,2)=='03',}"
							   ng-click="skipView(vl.viewCodeAndRW.substring(0,2),tabList.id)">{{vl.viewName}}</a>
						</li>
					</ul>
				</li>
				<!-- <li class="add_list">
					<div class="text-center">
						<p>接入新电站</p>
					</div>
				</li> -->
			</ul>
			<div ng-include="'${ctx}/tpl/homePage/modal/powerModal.jsp'"></div>
		</div>
		<!-- 电站列表 END -->
	</div>
</div>

<div class="waterPlaceholder"></div>
<script>
	function canvasCircleProgress (per) {
		var curDeg = 3.6*parseFloat(per);
		// console.log(curDeg);
		if (curDeg > 180) {
			$('.rightcircle').css({
				'-webkit-transform': 'rotate(45deg)',
				'-moz-transform': 'rotate(45deg)',
				'transform': 'rotate(45deg)'
			});
			$('.leftcircle').css({
				'-webkit-transform': 'rotate('+(curDeg+45)+'deg)',
				'-moz-transform': 'rotate('+(curDeg+45)+'deg)',
				'transform': 'rotate('+(curDeg+45)+'deg)'
			});
		} else {
			$('.rightcircle').css({
				'-webkit-transform': 'rotate('+(curDeg-135)+'deg)',
				'-moz-transform': 'rotate('+(curDeg-135)+'deg)',
				'transform': 'rotate('+(curDeg-135)+'deg)'
			});
			$('.leftcircle').css({
				'-webkit-transform': 'rotate(225deg)',
				'-moz-transform': 'rotate(225deg)',
				'transform': 'rotate(225deg)'
			});
		}
	};

	getNoticeCount1();
	timer1 = setInterval(getNoticeCount1,5000)
	function getNoticeCount1(){
		$.ajax({
			type : "POST",
			url : "${ctx}/BaseMessage/getNoReadBaseMessageCount.htm",
			data : {
				'searchKey':'',
				isRorS:true
			},
			success:function(result) {
				if(result > 0) {
					$(".msg_center_num").html(result);
				}else{
					$(".msg_center_num").html("");
				}
			}
		});
	};
	function objAtrNullToShow(obj) {
		for (atr in obj) {
			if (!obj[atr] && obj[atr]!==0 ) {
				obj[atr] = "-";
			};
		};
	};

</script>
<script>
	//接收header角色ID
	app.controller("homeCtrl",function ($scope) {
		$scope.$on("CtrlHeaderChange", function (event, msg) {
			console.log("homeCtrl", msg);
			console.log("homeCtrl1", msg[1]);
			$scope.$broadcast("CtrlHeaderChangeFromApp", msg);
		});
	})
</script>
<script>
	app.controller('powerhomeCtrl', function($scope, $http, $state, $stateParams, $rootScope) {
		//打开实时监控(弹出不同的内页)
		$scope.showRealPower=function(flag){
			/*
			 if(flag==1){ //实时监控曲线
			 $scope.showPowerIndexData="${ctx}/tpl/homePage/modal/staDayPower.jsp"
			 }else if(flag==2){	//日发电量
			 $scope.showPowerIndexData="${ctx}/tpl/homePage/modal/staTodayPower.jsp"
			 }else if(flag==3){//月发电量
			 $scope.showPowerIndexData="${ctx}/tpl/homePage/modal/staMonModal.jsp"
			 }else if(flag==4){//年发电量
			 $scope.showPowerIndexData="${ctx}/tpl/homePage/modal/staYearModal.jsp"
			 }else if(flag==5){//累计发电量
			 $scope.showPowerIndexData="${ctx}/tpl/homePage/modal/staAllModal.jsp"
			 }
			 $('#powerIndexModal').modal({backdrop: 'static', keyboard: false});
			 */
		};
		//离开当前界面
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval(timer1);
			clearInterval(timer2);
		})
		//关闭弹出层
		$scope.hiddenModal=function(){
			$('#powerIndexModal').modal("hide");
			$scope.showPowerIndexData="";
		};
		$scope.$on("CtrlHeaderChangeFromApp",function (event, roleId) {
			console.log("powerhomeCtrl", roleId[0]);
			$scope.HeaderRoleId = roleId[0];
			$scope.getPowerStationInfo();
			$scope.getFaultAlarms();
			$scope.getPowerStationList();
		});
		($scope.getPowerStationInfo = function () {
			$http.get('${ctx}/MobileRtmDeviceMonitor/getRunTimeMonitor.htm',{
				timeout: 5000,
				params: {
					'dateString':new Date().Format("yyyy-MM-dd"),
					roleId: $scope.HeaderRoleId
				}
			}).success(function(response) {
				console.log("q3")
				$scope.powerStation = response;
				canvasCircleProgress($scope.powerStation.realInst);
			}).error(function(response) {
				$scope.powerStation = {
					realTimePower: '-',//实时功0率
					installedCapacity: '-',//总装机容量
					outputPowerRatio: '-',//出力比
					dayGeneratingPower: '-',//日发电量
					monthGeneratingPower: '-',//月发电量
					monthRate: '-',//月达成率
					yearGeneratingPower: '-',//年发电量
					yearRate: '-',//年达成率
					accumulateGeneratingPower: '-'//累及发电量
				};
			});
		})();
		setInterval(function() {
			$scope.$apply($scope.getPowerStationInfo);
		}, 5000);

		//故障
		($scope.getFaultAlarms = function () {
			$http.get('${ctx}/homePage/faultAlarms.htm',{
				timeout: 5000,
				params: {
					roleId: $scope.HeaderRoleId
				}
			}).success(function(response) {
				$scope.faultAlarms = response.data;
				$scope.faultAlarms.total = parseInt($scope.faultAlarms.fault)+parseInt($scope.faultAlarms.warn)+parseInt($scope.faultAlarms.interrupt);
				if (!$scope.faultAlarms.total && $scope.faultAlarms.total!=0) {
					$scope.faultAlarms.total = "-";
				};
			}).error(function(response) {
				$scope.faultAlarms = {
					fault: '-',
					warn: '-',
					interrupt: '-',
					total: '-'
				}
			});
		})();
		setInterval(function() {
			$scope.$apply($scope.getFaultAlarms);
		}, 5000);

		//电站列表
		$scope.tabNav = ['全部', '故障', '报警', '中断'];
		/*$scopeList = [
		 {
		 powerName: '演示电站',
		 powerStatus: 0,//状态
		 weather: 'sun',//天气
		 realPower: 3217,//实时功率
		 realInst: '34%',//百分比
		 dailyGener: 234//日发电量
		 }
		 ];*/
		$scope.curPage = 1;//默认第一页
		$scope.curType = 0;//默认显示全部
		$scope.getPowerStationList = function () {
			$http.get('${ctx}/homePage/powerStationListNew.htm', {
				params: {
					roleId: $scope.HeaderRoleId,
				}
			}).success(function(response) {
				//遍历电站ID 的集合
				if(response.data){
					var stationIdList=[]
					for(var i=0;i<response.data.length;i++){
						stationIdList.push(response.data[i].id)
					}
					$scope.stationListId=stationIdList
				}
				$scope.powerStationList2 = response.devList;
				$scope.changeList();
			}).error(function(response) {
			});
		};
		var weaList=[];
		$scope.changeList = function () {
			//先复制，防止中间数据出现变化
			var cp = $scope.curPage;
			var ct = $scope.curType;
			var pn = $scope.pageNums;
			var psl = $scope.powerStationList2;

			var begin=(cp-1)*10;
			var list1 = new Array();
			var j =0;
			var pagesum=0;

			for(var i=0;i<psl.length;i++){
				if(ct == 0){
					pagesum=pagesum+1;
					if(i>=begin&&j<10){
						list1[j++]=psl[i];
					}
				}else if(ct == 1){
					if(psl[i].powerStatus==1){
						pagesum=pagesum+1;
						if(pagesum>begin&&j<10){
							list1[j++]=psl[i];
						}
					}
				}else if(ct == 2){
					if(psl[i].powerStatus==2){
						pagesum=pagesum+1;
						if(pagesum>begin&&j<10){
							list1[j++]=psl[i];
						}
					}
				}else if(ct == 3){
					if(psl[i].powerStatus==3){
						pagesum=pagesum+1;
						if(pagesum>begin&&j<10){
							list1[j++]=psl[i];
						}
					}
				}
			}
			//当不是全部显示时需要判断页面总数是否发生变化
			if(ct != 0){
				var newPn = Math.ceil(pagesum/10);
				//当当前页大于总页面时,当前页显示最后一页
				if(cp>newPn){
					$scope.curPage = newPn;
					$scope.pageNums = newPn;
					$scope.changeList();
				}else{
					//页码和类型发生变化时不更改信息
					if(ct==$scope.curType && cp==$scope.curPage){
						$scope.powerStationList=list1;
						$scope.pageNums = Math.ceil(pagesum/10);//总页数
					}
				}
			}else{
				//页码和类型发生变化时不更改信息
				if(ct==$scope.curType && cp==$scope.curPage){
					$scope.powerStationList=list1;
					$scope.pageNums = Math.ceil((pagesum)/10);//总页数
				}
			}

		}
		timer2 = setInterval(function () {
			$scope.getPowerStationList();
			//$scope.$apply($scope.getPowerStationList);
			//setTimeout(function () {
			// $scope.showlist = $('.power_tab_con > li');
			// $scope.divPage($scope.showlist, $scope.curPage);
			//$scope.$apply($scope.initDivPage);
			//$scope.$apply($scope.switchTab($('.power_tab_nav .active').text()));
			//}, 50);
		}, 5000);

		$scope.initDivPage = function() {
			$scope.showlist = $('.power_tab_con > li');
			$scope.divPage($scope.showlist, $scope.curPage);
		}
		// $scope.initDivPage();
		//setTimeout(function () {
		//$scope.$apply($scope.initDivPage);
		//}, 100);

		$scope.switchTab = function(tabnav) {
			$scope.curType = $scope.tabNav.indexOf(tabnav);
			$scope.curPage = 1;
			$(".power_tab_nav li").eq($scope.curType).addClass('active').siblings().removeClass("active");
			$scope.changeList();
		};
		$scope.divPage = function ($showList, showNum) {
			var showNums = $showList.length;//列表数量
			var pageNums = Math.ceil(showNums/10);//总页数
			$showList.each(function(index, el) {
				if (((showNum-1)*10 < index+1) && (index+1 <= showNum*10 )) {
					$(this).show();
				} else {
					$(this).hide();
				}
			});
			return pageNums;
		};

		$scope.prevPage = function () {
			if ($scope.curPage > 1 ) {
				$scope.curPage = $scope.curPage - 1;
				$scope.changeList();
			}
		};
		$scope.nextPage = function () {
			if ($scope.curPage < $scope.pageNums) {
				$scope.curPage = $scope.curPage + 1;
				$scope.changeList();
				//$scope.divPage($scope.showlist, $scope.curPage);
			}
		};
		//跳转pager
		$scope.goPageInputFlag = true;
		$scope.goPageInput = function () {
			$scope.goPageInputFlag = false;
			$('.inputNum').focus();
			$('.inputNum').blur(function(event) {
				$scope.goPageInputFlag = true;
				var getInputNum = parseInt($('.inputNum').val());
				if ( getInputNum!=='' && getInputNum<=$scope.pageNums && getInputNum>=1 && getInputNum!==$scope.curPage ) {
					$scope.curPage = getInputNum;
					$scope.divPage($scope.showlist, $scope.curPage);
				}
			});
		};
		$scope.toBaseMessage = function() {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
				params: {
					roleId: $scope.currentRoleID
				}
			}).success(function(response) {
				$state.go("apps.note", {
					recuserId : $scope.HeaderRoleId
				});
			});
		};
		$scope.statsticAnalysis = function(){
			$state.go("app.statistics.staDay", {
				roleId: $scope.HeaderRoleId
			});
		};
		//跳转视图
		$scope.skipView = function(view,id) {
			if(view == '00'){
				$scope.toMonitoring(id);
			}else if(view == '01'){
				$scope.toProduce(id);
			}else if(view == '02'){
				$scope.toAnalyzeHome(id);
			}else if(view == '03'){
				$scope.toPowerStationView(id);
			}
		}
		//go监控
		$scope.toMonitoring = function(id) {
			console.log("监控传入的电站id：" +id);
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
				params: {
					roleId: $scope.HeaderRoleId,
					stId: id,
					view: '00'
				}
			}).success(function(res) {
				$state.go("app.dashboard-v1", {
					// rootRoleId: $scope.HeaderRoleId,
					// rootStId: id,
					//rootViewType: '00',
					stationId: id
				});
				$rootScope.viewType="00";
				$rootScope.stId=id;
				$rootScope.roleId=$scope.HeaderRoleId;

			});

			// session.setAttrbute('roleId',"00");
		};
		//go台账
		$scope.toPowerStationView = function(id) {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
				params: {
					roleId: $scope.HeaderRoleId,
					stId: id,
					view: '03'
				}
			}).success(function(res) {
				if(res.rightlist && res.rightlist.length > 0){
					$state.go(res.rightlist[1].uisref, {
						inId: id
					});
				}else{
					alert("无子权限!");
				}

			});

		};
		//go分析
		$scope.toAnalyzeHome = function(id) {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
				params: {
					roleId: $scope.HeaderRoleId,
					stId: id,
					view: '02'
				}
			}).success(function(res) {
				$state.go("analyzeHome", {
					// rootRoleId: $scope.HeaderRoleId,
					// rootStId: id,
					//rootViewType: '02',
					stid: id
				});
			});

		};
		//go生产toProduce
		$scope.toProduce = function(id) {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/changeSessionRoleOrSTOrViewForPC.htm",
				params: {
					roleId: $scope.HeaderRoleId,
					stId: id,
					view: '01'
				}
			}).success(function(res) {
				if(res.rightlist && res.rightlist.length > 0){
					$state.go(res.rightlist[1].uisref, {
						stId: id
					});
					$rootScope.viewType="01";
					$rootScope.stId=id;
					$rootScope.roleId=$scope.HeaderRoleId;
				}else{
					alert("无子权限!");
				}

			});

		};
		//go地图模式
		$scope.toMonitoringMap = function() {
			$state.go("dashboard-v2", {
				roleId: $scope.HeaderRoleId,
			});
		}
	});

	var timer1, timer2;
	Date.prototype.Format = function(fmt) { //author: meizz
		var o = {
			"M+": this.getMonth() + 1, //月份
			"d+": this.getDate(), //日
			"h+": this.getHours(), //小时
			"m+": this.getMinutes(), //分
			"s+": this.getSeconds(), //秒
			"q+": Math.floor((this.getMonth() + 3) / 3), //季度
			"S": this.getMilliseconds() //毫秒
		};
		if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		for (var k in o)
			if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}
</script>
