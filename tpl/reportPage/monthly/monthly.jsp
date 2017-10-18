<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
	.scrollDivTop{
		margin-top: -70px!important;
  		border-top: 70px solid transparent!important;
	}
</style>
  <!-- navbar 
  <div data-ng-include=" 'tpl/blocks/header.jsp' " class="app-header navbar"> </div>-->
  <!-- / navbar -->
	<div class="hbox hbox-auto-xs hbox-auto-sm"
		ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;"
			ng-controller="monthlyCtrl">
		<!-- main header -->
			<div class="bg-light lter b-b col-sm-12" id="head-title"style="padding: 15px 0px">
				<div class="col-sm-6 col-xs-12 no-padder">
					<span class="href-blur col-sm-12 no-padder text-muted ">
						<ul class="col-sm-12 m-n nav navbar-nav">
							<li class="m-l-md m-t-xs"><span class="font-h5 black-1 text-black m-t-xs" ng-click="goBack();">
								<i class="fa  fa-chevron-left m-r-xs a-cui-poi"></i>返回</span>
							</li>
							<li class="dropdown" dropdown>
								<a href class="dropdown-toggle clear no-padder font-h3 blue-1  text-black  m-l m-r" style="margin-top:3px"
									dropdown-toggle>
									<i class="fa fa-calendar m-r-xs"></i>切换 <span ng-bind="changeTime"></span>
									<b class="caret"></b>
								</a>
								<ul class="dropdown-menu animated fadeInRight">
			<!-- 						<li><a ng-click="changeDate('2')">切换月</a></li>
			 -->						<li><a ng-click="changeDate('1')">切换日</a></li>
								</ul>
							<li>
								<a class="no-padder">
									<i class="fa fa-angle-left map-jt " id="leftJt" style="color:#fff!important"class="m-r-xs"ng-click="dateLeft()"></i>
									<span class="input-append date form_datetime" id="changeTimeMonthTimer"data-link-field="month_input">
										<input type="hidden" value="" readonly>
										<span id="changeTimeId2" class="m-l m-r  font-h2"ng-bind="mapTimeMonth"></span>
									</span>
									<input type="hidden" id="month_input" value="" />
									<i id="rightJt" class="fa fa-angle-right map-jt"
									 ng-class="{'effiJt':monthlyJt}"
									style="color:#fff!important" class="m-r-xs" ng-click="dateRight()"></i>
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
					<div ng-include="'${ctx}/tpl/reportPage/monthly/target.jsp'"></div>
				</div>
				<div class="col-sm-4 divshadow">
					<div ng-include="'${ctx}/tpl/reportPage/monthly/assess.jsp'"></div>
				</div>
			</div>
			<!-- 第一排结束 -->
			<!-- 第二排开始 -->
			<div class="row row-xs m-b-md">
				<div ng-include="'${ctx}/tpl/reportPage/monthly/falutData.jsp'"></div>
			</div>
			<!-- 第二排结束 -->
			<!-- 发电量分析开始 -->
			<div class="row row-xs m-b-md scrollDivTop" id="scroll1" >
				<div ng-include="'${ctx}/tpl/reportPage/monthly/powerEffic.jsp'"></div>
			</div>
			<!-- 发电量分析结束 -->
			<!-- 第三排开始 -->
			<div class="row row-xs m-b-md scrollDivTop" id="scroll3">
				<div ng-include="'${ctx}/tpl/reportPage/monthly/powerBight.jsp'"></div>
			</div>
			<!-- 第三排结束 -->

			<!-- 第四排开始 -->
			<div class="row row-xs m-b-md scrollDivTop"  id="scroll2">
				<div ng-include="'${ctx}/tpl/reportPage/monthly/inverterTable.jsp'"></div>
			</div>
			<!-- 第四排结束 -->

			<!-- 第五排开始 -->
			<div class="row row-xs m-b-md scrollDivTop" id="scroll4">
				<div ng-include="'${ctx}/tpl/reportPage/monthly/opTable.jsp'"></div>
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
		app.controller('monthlyCtrl',function($scope, $http, $state, $stateParams,$location,$anchorScroll) {
			$scope.stid=$stateParams.stid;
			//根据日月年，切换日期
			
			$scope.showScroller=function(){
				if($stateParams.flag==1){
					$location.hash("scroll1");
			        $anchorScroll();
				}else if($stateParams.flag==2){
					$location.hash("scroll2");
			        $anchorScroll();
				}else if($stateParams.flag==3){
					$location.hash("scroll3");
			        $anchorScroll();
				}else if($stateParams.flag==4){
					$location.hash("scroll4");
			        $anchorScroll();
				}
			}
			$scope.showScroller()
			$scope.changeTime="月";
			$scope.mapTimeMonth_1=new Date().getMonth()+1//用来比较的月份
			//切换时间选择
			//点击选择时间
			$("#changeTimeMonthTimer").datetimepicker({
				language : 'zh-CN',
				format : "yyyy-mm",
				startView: 'year',
				minView : 'year',
				autoclose : true,
				todayBtn : true,
				endDate : new Date(),
				pickerPosition : "bottom-left"
			});

		 	$("#changeTimeMonthTimer").on('hide',
				function(ev) {
					// 获取某个时间格式的时间戳
					var stringTime = $("#month_input").val();
					var timestamp2 = Date.parse(getDateForStringDate(stringTime));

				//	$scope.mapTimeDay = timestamp2
					//$scope.monthlyJt=($scope.mapTimeMonth1)==($scope.mapTimeMonth_1)
					$scope.monthlyJt=(getDateForStringDate(stringTime).getMonth()+1)==($scope.mapTimeMonth_1);
					$("#changeTimeId2").text(new Date(timestamp2).Format("yyyy-MM"))
					$scope.mapTimeMonth1 = new Date(timestamp2).getMonth()+1;
					$scope.mapTimeMonthY = new Date(timestamp2).getFullYear();

					//判断箭头
					$("#leftJt").removeClass("effiJt")
					if ($scope.monthlyJt) {
						$("#rightJt").removeClass("effiJt")
					} else {
						$("#rightJt").addClass("effiJt")
					}

					//切换时间后，重新加载整个界面的数据
					$scope.monthlyRefresh=true;
					$scope.mapTimeMonth = new Date(timestamp2).Format("yyyy-MM")
					$scope.$broadcast('monthlyRefresh',[$scope.monthlyRefresh,$scope.mapTimeMonth]);
				});

			//如果首页传日期过来
			if($stateParams.analData){
				$scope.mapTimeMonth1=parseInt($stateParams.analMon)
				$scope.mapTimeMonthY=parseInt($stateParams.analData)
			}else{
				$scope.mapTimeMonth1=new Date().getMonth()+1
				$scope.mapTimeMonthY=new Date().getFullYear();
			}

			//修改月份和年份
			if($scope.mapTimeMonth1 < 10){
				$scope.mapTimeMonth=$scope.mapTimeMonthY+'-0'+$scope.mapTimeMonth1;
			}else{
				$scope.mapTimeMonth=$scope.mapTimeMonthY+'-'+$scope.mapTimeMonth1;
			}


			$scope.changeTimeId=2;

			//用来判断向右的按钮的样式
			$scope.monthlyJt=($scope.mapTimeMonth1)==($scope.mapTimeMonth_1)

			//跳转到日历
			$scope.changeDate=function(changeDateFlag){
				$scope.changeTimeId=changeDateFlag
				if(changeDateFlag=="1"){//日
					$state.go("app.daily", {
						stid: $scope.stid
					});
				}
			}

			//向左切换时间，默认加1
			$scope.dateLeft=function(){
				console.log($scope.mapTimeMonth1)
				 if($scope.changeTimeId=="2"){//月
					if($scope.mapTimeMonth1-1<=0){
						$scope.mapTimeMonth1=$scope.mapTimeMonth1+11
						$scope.mapTimeMonthY=$scope.mapTimeMonthY-1
					}else{
						$scope.mapTimeMonth1=$scope.mapTimeMonth1-1;
					}
					if($scope.mapTimeMonth1 < 10){
						$scope.mapTimeMonth=$scope.mapTimeMonthY+'-0'+$scope.mapTimeMonth1;
					}else{
						$scope.mapTimeMonth=$scope.mapTimeMonthY+'-'+$scope.mapTimeMonth1;
					}
				}
				if($scope.mapTimeMonthY==new Date().getFullYear()){
					$scope.monthlyJt = ($scope.mapTimeMonth1)==($scope.mapTimeMonth_1) //标记下一天是否可以点击
				}else{
					$scope.monthlyJt=false;
				}
				//$scope.monthlyJt=($scope.mapTimeMonth1)==($scope.mapTimeMonth_1);

				//将日期广播出去，用来更新界面其他数据
				$scope.monthlyRefresh=true;
				$scope.$broadcast('monthlyRefresh',[$scope.monthlyRefresh,$scope.mapTimeMonth]);
			}

			//向右切换时间，默认减一
			$scope.dateRight=function(){
				if($scope.mapTimeMonth1==$scope.mapTimeMonth_1 && $scope.mapTimeMonthY==new Date().getFullYear()){
					return false
				}
				if($scope.changeTimeId=="2"){//月

					if($scope.mapTimeMonth1+1>12){
						$scope.mapTimeMonth1=($scope.mapTimeMonth1+1)%12;
						$scope.mapTimeMonthY=$scope.mapTimeMonthY+1
					}else{
						$scope.mapTimeMonth1=$scope.mapTimeMonth1+1;
					}
					if($scope.mapTimeMonth1 < 10){
						$scope.mapTimeMonth=$scope.mapTimeMonthY+'-0'+$scope.mapTimeMonth1;
					}else{
						$scope.mapTimeMonth=$scope.mapTimeMonthY+'-'+$scope.mapTimeMonth1;
					}
				}
				if($scope.mapTimeMonthY==new Date().getFullYear()){
					$scope.monthlyJt = ($scope.mapTimeMonth1)==($scope.mapTimeMonth_1) //标记下一天是否可以点击
				}else{
					$scope.monthlyJt=false;
				}
				//$scope.monthlyJt=($scope.mapTimeMonth1)==($scope.mapTimeMonth_1);

				//将日期广播出去，用来更新界面其他数据
				$scope.monthlyRefresh=true;
				$scope.$broadcast('monthlyRefresh',[$scope.monthlyRefresh,$scope.mapTimeMonth]);
			}
			$scope.goBack=function(){
				$state.go("analyzeHome", {
					stid: $scope.stid
				});
			}
		});
	</script>
