<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.modal-open {
    overflow-y: auto;
}
.report{
	background-color: #f6f8f8;
}
.reportDay-nav{
	padding: 15px;
	border-bottom: 1px solid #dfe6ea;
}
.reportDay-nav ul{
	margin: 0;
}
.reportDay-nav ul li{
	width: 100px;
	background-color: #1d2b36;
	border-right: 1px solid transparent;
}
.reportDay-nav ul li.active{
	background-color: #1cb09a;
}
.reportDay-nav ul li a{
	display: block;
	width: 100%;
	line-height: 2em;
	height: 2em;
	color: #fff;
	text-align: center;
}
</style>

<div class="report" ng-controller="reportDayCtrl">
	<div class="reportDay-nav" style="position: relative;">
		<ul class="list-inline">
			<li ng-class="{'active': activeTab == 'powerStation' }"><a href="#/app/DTReportDaySum/powerStation">各电站日数据</a></li>
			<li ng-class="{'active': activeTab == 'productData' }"><a href="#app/DTReportDaySum/productData">生产数据</a></li>
			<li ng-class="{'active': activeTab == 'defectManage' }"><a href="#app/DTReportDaySum/defectManage">缺陷管理</a></li>
			<li ng-class="{'active': activeTab == 'workBriefing' }"><a href="#app/DTReportDaySum/workBriefing">工作简报</a></li>
			<li ng-class="{'active': activeTab == 'workTicket' }"><a href="#app/DTReportDaySum/workTicket">工作票</a></li>
			<li ng-class="{'active': activeTab == 'operationTicket' }"><a href="#app/DTReportDaySum/operationTicket">操作票</a></li>
		</ul>
		</div>
		<div  style="position: absolute;left: 865px;top: 64px;"><div class="clearfix" ng-include="'${ctx}/tpl/datang/rtMonitorPage/model/changeDate.jsp'"></div>
			
	</div>
	<div ui-view=""></div>
</div>
<script>
	app.controller('reportDayCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
		if($state.current.url == '/DTReportDaySum'){
			$state.go('app.DTReportDaySum.powerStation')
			$scope.activeTab = 'powerStation'
		}

		$scope.$on("emitChangeDate",function(e,data){
			$scope.commonData = data
			$scope.$broadcast('broadChangeDate',data)
		});
		
		$scope.$on("getDate",function(e){
			$scope.$broadcast('broadChangeDate', $scope.commonData)
		});

		//获取昨天的日期
		var getPreDate = function () {
			var rightDay = new Date();
			rightDay.setDate(rightDay.getDate() - 1)
			return rightDay
		}


		$scope.$watch('$viewContentLoading',function(event){   
		    $scope.activeTab = $state.current.url.substr(1)
		});  
		
		 $rootScope.$on('$stateChangeSuccess',  
          	function(event, toState, toParams, fromState, fromParams) { 
              	$scope.activeTab = toState.url.substr(1)//tab切换样式

 				$scope.$broadcast('broadChangeDate',$scope.commonData);
             
              // $scope.$broadcast('chageDateInit',{dataType: 'day', defaultTime: getPreDate(), endDate: getPreDate()});//手动初始化日历
         })  



	})
</script>