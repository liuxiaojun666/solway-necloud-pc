<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">

<!-- navbar 
<div data-ng-include=" 'tpl/blocks/header.jsp' "
	class="app-header navbar"></div>-->
<!-- / navbar -->
<div class="hbox hbox-auto-xs hbox-auto-sm"
	ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;"
	ng-controller="dailyCtrl">
	<!-- main header -->
	<div class="bg-light lter b-b col-sm-12" id="head-title"
		style="padding: 15px 0px">
		<div class="col-sm-6 col-xs-12 no-padder">
			<span class="href-blur col-sm-12 no-padder text-muted ">
				<ul class="col-sm-12 m-n nav navbar-nav">
					<li class="m-l-md m-t-xs">
						<span class="font-h5 black-1  text-black m-t-xs" ng-click="goBack();">
							<i class="fa  fa-chevron-left m-r-xs a-cui-poi"></i>返回
						</span>
					</li>
					<li class="dropdown" dropdown>
						<a href class="dropdown-toggle clear no-padder font-h3 blue-1  text-black  m-l m-r"
									style="margin-top: 3px" dropdown-toggle>
							<i class="fa fa-calendar m-r-xs"></i>切换
							<span ng-bind="changeTime"></span>
							<b class="caret"></b>
						</a>
						<ul class="dropdown-menu animated fadeInRight">
							<li><a ng-click="changeDate('2')">切换月</a></li>
						</ul>
					<li><a class="no-padder">
							<i class="fa fa-angle-left map-jt " id="leftJt"
								style="color: #fff !important" class="m-r-xs" ng-click="dateLeft()"></i>
							<span class="input-append date form_datetime" id="changeTimeIdTimer"data-link-field="dtp_input2">
								<input type="hidden" value="" readonly>
								<span id="changeTimeId1" class="m-l m-r  font-h2" ng-bind="mapTimeDay| date:'yyyy-MM-dd'"></span>
							</span>
							<input type="hidden" id="dtp_input2" value="" />
							<i id="rightJt" class="fa fa-angle-right map-jt" ng-class="{'effiJt':dailyJt}"
								style="color: #fff !important" class="m-r-xs"ng-click="dateRight()"></i>
						</a>
					</li>
				</ul>
			</span>
		</div>
		<div class="col-sm-6 text-right">
			<!-- <span class="font-h3 blue-1 text-black "><img style="width:20px;height:20px;margin-right:5px;" src="${ctx}/theme/images/icon/upLoad.png">导出数据 PDF</span> -->
		</div>
	</div>
	<!-- / main header -->
	<div class="col-sm-12 daily" style="padding: 20px 20px 20px 25px;">
		<!-- 第一排开始 -->
		<div class="row row-xs m-b-md">
			<div class="col-sm-8 divshadow">
				<div ng-include="'${ctx}/tpl/reportPage/daily/target.jsp'"></div>
			</div>
			<div class="col-sm-4 divshadow">
				<div ng-include="'${ctx}/tpl/reportPage/daily/assess.jsp'"></div>
			</div>
		</div>
		<!-- 第一排结束 -->

		<!-- 第二排开始 -->
		<div class="row row-xs m-b-md">
			<div ng-include="'${ctx}/tpl/reportPage/daily/falutData.jsp'"></div>
		</div>
		<!-- 第二排结束 -->

		<!-- 第三排开始 -->
		<div class="row row-xs m-b-md">
			<div ng-include="'${ctx}/tpl/reportPage/daily/powerBight.jsp'"></div>
		</div>
		<!-- 第三排结束 -->

		<!-- 第四排开始 -->
		<div class="row row-xs m-b-md">
			<div ng-include="'${ctx}/tpl/reportPage/daily/inverterTable.jsp'"></div>
		</div>
		<!-- 第四排结束 -->

		<!-- 第五排开始 -->
		<div class="row row-xs m-b-md">
			<div ng-include="'${ctx}/tpl/reportPage/daily/faultTable.jsp'"></div>
		</div>
		<!-- 第五排结束 -->
	</div>
</div>

<script>
	function getDateForStringDate(strDate){
		//切割年月日与时分秒称为数组
		var s = strDate.split(" ");
		var s1 = s[0].split("-");
		var s2 = s[1].split(":");
		if(s2.length==2){
			s2.push("00");
		}
		return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
	}
	app.controller('dailyCtrl',
		function($scope, $http, $state, $stateParams) {
			$scope.stid = $stateParams.stid;
			//根据日月年，切换日期
			$scope.changeTime = "日";
			var rightDay = new Date();
			//只能取到前一天
			rightDay.setDate(rightDay.getDate() - 1);
			$scope.today = rightDay;

			//点击选择时间
			$("#changeTimeIdTimer").datetimepicker({
				language : 'zh-CN',
				format : "yyyy-mm-dd",
				minView : 2,
				autoclose : true,
				todayBtn : true,
				endDate : $scope.today,
				pickerPosition : "bottom-left"
			});
			$("#changeTimeIdTimer").on('show',function(ev){
				$(".map-jt").addClass("effiJt")
			})
			$("#changeTimeIdTimer").on('hide',
				function(ev) {
					// 获取某个时间格式的时间戳
					var stringTime = $("#dtp_input2").val();

					if(stringTime){
						var timestamp2 = Date.parse(getDateForStringDate(stringTime));
						$scope.mapTimeDay = timestamp2
						$("#changeTimeId1").text(new Date(timestamp2).Format("yyyy-MM-dd"))
						$scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.today).Format("yyyy-MM-dd"))
					}

					//判断箭头
					$("#leftJt").removeClass("effiJt")
					if ($scope.dailyJt) {
						$("#rightJt").addClass("effiJt")
					} else {
						$("#rightJt").removeClass("effiJt")
					}

					//切换时间后，重新加载整个界面的数据
					$scope.dailyRefresh = true;
					$scope.mapTimeDayRefresh = new Date($scope.mapTimeDay).Format("yyyy-MM-dd")
					$scope.$broadcast('dailyRefresh', [$scope.dailyRefresh,$scope.mapTimeDayRefresh ]);
				});

			//	}
			//$scope.changeTimeType()
			if ($stateParams.analData) {//首页带进来的参数
				$scope.mapTimeDay = new Date(parseInt($stateParams.analData)).getTime();

				$scope.mapTimeDayRefresh = new Date(parseInt($stateParams.analData)).Format("yyyy-MM-dd")
			} else {
				$scope.mapTimeDay = $scope.today;
				$scope.mapTimeDayRefresh = $scope.today
						.Format("yyyy-MM-dd")
			}

			$scope.changeTimeId = 1;

			$scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.today).Format("yyyy-MM-dd"))
			$scope.changeDate = function(changeDateFlag) {
				$scope.changeTimeId = changeDateFlag

				if (changeDateFlag == "1") {//日
					$scope.changeTime = "日";
					$("#changeTimeId1").removeClass("hidden");
					$("#changeTimeId1").siblings().addClass("hidden");
				} else if (changeDateFlag == "2") {//月
					$state.go("app.monthly", {
						stid: $scope.stid
					});
				}
			}
			$scope.dateLeft = function() {
				if ($scope.changeTimeId == "1") {//日
					$scope.mapTimeDay = $scope.mapTimeDay - 1000
							* 60 * 60 * 24;
				}
				$scope.dailyJt = (new Date($scope.mapTimeDay)
						.Format("yyyy-MM-dd")) == (new Date(
						$scope.today).Format("yyyy-MM-dd"))

				//将日期广播出去
				$scope.dailyRefresh = true;
				$scope.mapTimeDayRefresh = new Date($scope.mapTimeDay).Format("yyyy-MM-dd")
				$scope.$broadcast('dailyRefresh', [$scope.dailyRefresh,$scope.mapTimeDayRefresh ]);
			}
			$scope.dateRight = function() {
				if (new Date($scope.mapTimeDay)
						.Format("yyyy-MM-dd") == new Date(
						$scope.today).Format("yyyy-MM-dd")) {
					return false
				}
				if ($scope.changeTimeId == "1") {//日
					$scope.mapTimeDay = $scope.mapTimeDay + 1000
							* 60 * 60 * 24;
				}
				$scope.dailyJt = (new Date($scope.mapTimeDay)
						.Format("yyyy-MM-dd")) == (new Date(
						$scope.today).Format("yyyy-MM-dd"))

				//将日期广播出去
				$scope.dailyRefresh = true;
				$scope.mapTimeDayRefresh = new Date(
						$scope.mapTimeDay).Format("yyyy-MM-dd")
				$scope.$broadcast('dailyRefresh', [
						$scope.dailyRefresh,
						$scope.mapTimeDayRefresh ]);
			}
			$scope.goBack = function() {
				$state.go("analyzeHome", {
					stid: $scope.stid
				});
			}
					});
	function FormatDate(strTime) {
		var date = new Date(strTime);
		return date.getFullYear() + "年" + (date.getMonth() + 1) + "月"
				+ date.getDate() + "日";
	}
	Date.prototype.Format = function(fmt) { //author: meizz
		var o = {
			"M+" : this.getMonth() + 1, //月份
			"d+" : this.getDate(), //日
			"h+" : this.getHours(), //小时
			"m+" : this.getMinutes(), //分
			"s+" : this.getSeconds(), //秒
			"q+" : Math.floor((this.getMonth() + 3) / 3), //季度
			"S" : this.getMilliseconds()
		//毫秒
		};
		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}
</script>
