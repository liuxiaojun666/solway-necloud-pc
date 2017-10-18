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
			<li ng-class="{'active': activeTab == 'productData' }"><a href="#app/DTReportMonthSum/productData">生产月数据</a></li>
			<li ng-class="{'active': activeTab == 'workSummary' }"><a href="#app/DTReportMonthSum/workSummary">月工作总结</a></li>
			<li ng-class="{'active': activeTab == 'defectManage' }"><a href="#app/DTReportMonthSum/defectManage">缺陷管理</a></li>
			<li ng-class="{'active': activeTab == 'workTicket' }"><a href="#app/DTReportMonthSum/workTicket">工作票</a></li>
			<li ng-class="{'active': activeTab == 'operationTicket' }"><a href="#app/DTReportMonthSum/operationTicket">操作票</a></li>
			<li ng-class="{'active': activeTab == 'twoVoteAnalysis' }"><a href="#app/DTReportMonthSum/twoVoteAnalysis">两票分析</a></li>
		</ul>
		</div>
		<div  style="position: absolute;left: 865px;top: 64px;"><div class="clearfix" ng-include="'${ctx}/tpl/datang/rtMonitorPage/model/changeMonth.jsp'"></div>
			
	</div>
	<div ui-view=""></div>
</div>
<script>
	app.controller('reportDayCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){
		if($state.current.url == '/DTReportMonthSum'){
			$state.go('app.DTReportMonthSum.productData')
			$scope.activeTab = 'productData'
		}

		$scope.$on("emitChangeDate",function(e,data){
			$scope.commonData = data
			$scope.$broadcast('broadChangeDate',data);
		});
		
		$scope.$on("getDate",function(e){
			$scope.$broadcast('broadChangeDate', $scope.commonData)
		});

		//获取昨天的日期
		var getPreDate = function () {
			var rightDay = new Date();
			rightDay.setDate(rightDay.getDate() - 1);
			return rightDay
		}


		$scope.$watch('$viewContentLoading',function(event){   
		    $scope.activeTab = $state.current.url.substr(1)
		});  
		
		 $rootScope.$on('$stateChangeSuccess',  
          	function(event, toState, toParams, fromState, fromParams) { 
              $scope.activeTab = toState.url.substr(1)//tab切换样式
              // $scope.$broadcast('chageDateInit',{dataType: 'month', defaultTime: getPreDate(), endDate: getPreDate()});//手动初始化日历
         })  
	})
</script>