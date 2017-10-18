<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.modal-open {
    overflow-y: auto;
}
.reportWeekBox{
	width: 100%;
	height: 100%;
	overflow: hidden;
}
.reportHeader{
	width: 100%;
	height: 50px;
	border-bottom: 1px solid #ccc;
	padding: 10px 15px 0;
}
.reportHeader div{
	float: left;
}
.reportNav{
	background-color: #111c22;
	color: white;
	width: 90px;
	height: 2em;
	line-height: 2em;
	margin-right: 1px;
	text-align: center;
	cursor: pointer;
}
.reportHeader .navActive{
	background-color:#1cb09a; 
}
.reportMain{
	padding: 0 30px 50px;
}
.reportMain h3{
	color:#1cb09a;
}
.reportMain{
	text-align: center;
}
.oddStyle{
	background-color: white;
}
.evenStyle{
	background-color: #e6f9f9; 
}
.currentWeekNum{
	width:160px;
	height: 30px;
	border-radius: 2px;
	border: 1px solid #bbb;
	margin-left: 40px;
	margin-right: 20px;
	position: relative;
}
.changeWeekNumBox{
	width:100px;
	height: 100px;
	overflow: hidden;
	position: absolute;
	left: 29px;
	top : 26px;
	z-index: 99;
	border-radius: 2px;
	border: 1px solid #bbb;
	padding: 3px;
	background-color: rgba(0,0,0,.8);
	color:white!important;
}
.changeWeekNumBox div{
	width: 50%;
	height: 100px;
	overflow:auto;
	box-sizing: border-box;
	text-align: center;	
}
.changeWeekNumBox p:hover{
	background-color: #1cb09a;
}
.changeWeekNumBox .yearsBox{
	border-right: 1px solid black;
}
.yearsBox::-webkit-scrollbar{/*隐藏滚轮*/
	display: none;
}
.weeksBox::-webkit-scrollbar{/*隐藏滚轮*/
	display: none;
}
.yearsBox,.weeksBox{
	-ms-overflow-style:none;	
}
.weekNumInfo{
	height: 100%;
	position: absolute;
	left: 28px;
	right: 28px;
	top: 0;
}
.weekNumInfo span{
	height: 28px;
	line-height: 28px;
	font-size: 14px;
}
.weekNumInfo span:first-of-type{
	float: left;
	margin-left: 5px;
}
.weekNumInfo span:last-of-type{
	margin-right: 5px;
	float: right;
}
.currentWeekNum .preWeek,.nextWeek{
	padding: 0px;text-align:center;width:25px;height:28px;line-height:25px;font-size: 30px;
    background: #123043;color: rgba(28, 43, 54,.9)!important;border-radius: 2px;cursor: pointer;color: #fff;
	width:27Px;
	height:28Px;
}
.preWeek{
	position: absolute;
	left: 0;
	top: 0;
}
.nextWeek{
	position: absolute;
	right: 0;
	top: 0;
}
.effiJt{
    background: rgba(18, 48, 67,.5)!important;
}
.showWeekBox{
	height:30px;
	line-height: 28px;
	border-radius: 3px;
	border: 1px solid #bbb;
}
.weekStart,.weekEnd{
	padding: 0 6px;
	font-size: 16px;
	float: left;
}

</style>
	<div class="reportWeekBox" ng-controller="reportWeekCtrl">

		<div class="reportHeader clearfix">
			<div class="reportNav" id="toFirstNav" ng-class="{'navActive' : activeTab == 'productWeekData'}" ng-click="changeState('app.DTReportWeekSum.productWeekData')">生产周数据</div>
			<div class="reportNav" ng-class="{'navActive' : activeTab == 'weekWorkPlan'}" ng-click="changeState('app.DTReportWeekSum.weekWorkPlan')">周工作计划</div>
			<div class="reportNav" ng-class="{'navActive' : activeTab == 'defectManage'}" ng-click="changeState('app.DTReportWeekSum.defectManage')">缺陷管理</div>
			<div class="reportNav" ng-class="{'navActive' : activeTab == 'workOrder'}" ng-click="changeState('app.DTReportWeekSum.workOrder')">工作票</div>
			<div class="reportNav" ng-class="{'navActive' : activeTab == 'operationOrder'}" ng-click="changeState('app.DTReportWeekSum.operationOrder')">操作票</div>	

			<div class="currentWeekNum" ng-init="weekFlag = false" >
				<div class="preWeek fa fa-angle-left map-jt" style="color: #fff !important" ng-click="preData()"></div>
				<div class="weekNumInfo" ng-click="weekFlag = !weekFlag" ><span ng-bind="nowTimeYear+'年'"></span><span ng-bind="'第'+currentWeek +'周'"></span></div>
				<div class="nextWeek fa fa-angle-right map-jt" style="color: #fff !important" ng-click="nextData()" ng-class="{'effiJt':currentWeek == weekTotal}"></div>

				<div class="changeWeekNumBox" ng-show="weekFlag" >
					<div class="yearsBox" >
						<p class="years" ng-repeat="yearNum in yearsArr" ng-bind="yearNum" ng-click="changeYearFn()" ></p>
						<div style="width: 100%;height: 10px;"></div>
					</div>
					<div class="weeksBox" ng-click="weekFlag = !weekFlag" >
						<p class="weeks" ng-repeat="n in weeksArr" ng-bind="n" ng-click="changeWeekFn();" ></p>
						<div style="width: 100%;height: 10px;"></div>
					</div>
				</div>
			</div>
			<div class="showWeekBox">
				<span ng-bind="startDate|date:'yyyy-MM-dd'|dataNullFilter" scroll="no"></span>
				至
				<span ng-bind="endDate|date:'yyyy-MM-dd'|dataNullFilter"></span>
			</div>
		</div>
		<div class="reportMain" ui-view ></div>
	</div>
<script>	
	app.controller('reportWeekCtrl',function($scope, $http, $state, $stateParams){
		
		//切换子页面
		$scope.changeState = function(state){
			$state.go(state);
			//broadcastDateTime();
			
		}
		// 显示不同导航的数据
		$scope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams) {  
  			$scope.activeTab = $state.current.url.substr(1);
       	});
		if($state.current.url == '/DTReportWeekSum'){
			$state.go('app.DTReportWeekSum.productWeekData');
			$scope.activeTab = 'productWeekData';
		};
		// 请求来的所有周数据	
		
				
		$scope.startYear = 2017; //数据的起始年份
		$scope.startWeek = 1; //数据的起始周数
		$scope.weekTotal; //此数据来源：请求总周数

		$scope.preData = function(){//前一周数据
			if($scope.currentWeek > $scope.startWeek){
				$scope.currentWeek--;
				broadcastDateTime();
				getDateFromWeek()
			}
		};
		$scope.nextData = function(){//后一周数据
			if($scope.currentWeek < $scope.weekTotal){
				$scope.currentWeek++;
				broadcastDateTime();
				getDateFromWeek()
			}
		};
		
		//更改显示周
		$scope.changeWeekFn = function(){
			$scope.currentWeek = this.n;
			broadcastDateTime();
			getDateFromWeek()
		};
		$scope.changeYearFn = function(){
			$scope.nowTimeYear = this.yearNum;
		};

		$http({
	 		method : "POST",
	 		url : "${ctx}/rpws/getYearList.htm",
		}).success(function(res) {
			 var years = res.data;
		     $scope.yearsArr = years;
			 if(years){
				 $scope.nowTimeYear = years[0];
				 $http({
				 		method : "POST",
				 		url : "${ctx}/rpws/getWeekByYearList.htm",
				 		params: {
				 			year:$scope.nowTimeYear
				 		}
					 }).success(function(res) {
						 $scope.weeksArr= res.data;
						 if($scope.weeksArr){
							 $scope.currentWeek = $scope.weeksArr[0];
							$scope.weekTotal = $scope.weeksArr[0];
							 broadcastDateTime();
							 getDateFromWeek();
						 }
					 }) 
			 }
			 
		 })
		 
		function getDateFromWeek(){
			$http({
				method : "GET",
				url : "${ctx}/report/getCurrWeekDay.htm",
				params : {
					year : $scope.nowTimeYear,
					week:$scope.currentWeek
				}
			}).success(function(result) {
				if(result.code == 0){
					$scope.startDate = result.data.startDate;
					$scope.endDate = result.data.endDate;
				}
			});
		}
		 function broadcastDateTime(){
			$scope.$broadcast("yearWeek",{"year":$scope.nowTimeYear,"week":$scope.currentWeek});
		}

	});
	//防止内部滚轮滚到底后触发浏览器滚轮下滑
	$('.changeWeekNumBox').hover(
		function(){
		    $(window).on("scroll",function() {
		    	$(window).scrollTop(0);
		    })
		},
		function(){
		    $(window).off("scroll");
	});
</script>


