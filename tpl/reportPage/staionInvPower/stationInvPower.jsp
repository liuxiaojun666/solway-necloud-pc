<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/echarts/echarts-all.js" type="text/javascript"></script>
	<div class="hbox hbox-auto-xs hbox-auto-sm"
		ng-init="app.settings.asideFolded = false; app.settings.asideDock = false;"
			ng-controller="stationInvPowerCtrl">
		<!-- main header -->
		<div ng-include="'${ctx}/tpl/reportPage/staionInvPower/stationInvPowerTitle.jsp'"></div>
		<!-- / main header -->
		<div class="col-sm-12 daily" style="padding: 20px 20px 20px 25px;">
		<!-- 第一排开始 -->
			<div class="row row-xs">
				<div ng-include="'${ctx}/tpl/reportPage/staionInvPower/stationInvData.jsp'"></div>
			</div>
			<!-- 第一排结束 -->
			<!-- 发电量分析开始 -->
			<div class="row row-xs m-b-md">
				<div ng-include="'${ctx}/tpl/reportPage/staionInvPower/inverterV.jsp'"></div>
			</div>
			<!-- 发电量分析结束 -->

			<!-- 第四排开始 -->
			<div class="row row-xs m-b-md">
				<div ng-include="'${ctx}/tpl/reportPage/staionInvPower/inverterTable.jsp'"></div>
			</div>
			<!-- 第四排结束 -->
		</div>
	</div>
	<script>
		app.controller('stationInvPowerCtrl',function($scope, $http, $state, $stateParams) {
			$scope.stid=1;
			//根据日月年，切换日期
			$scope.changeTime="月";
			$scope.mapTimeDay=new Date().getTime();
			$scope.mapTimeYear=new Date().getFullYear();
			$scope.mapTimeMonth1=new Date().getMonth()+1
			
			$scope.mapTimeMonth=new Date().getFullYear()+' -'+$scope.mapTimeMonth1;
			$scope.mapTimeMonthY=new Date().getFullYear();

			$scope.changeTimeId=2;
			
			$scope.changeDate=function(changeDateFlag){
				$scope.changeTimeId=changeDateFlag
				if(changeDateFlag=="1"){//日
					$state.go("app.daily");
				}else if(changeDateFlag=="2"){//月
					$scope.changeTime="月";
					$("#changeTimeId2").removeClass("hidden");
					$("#changeTimeId2").siblings().addClass("hidden");
				}
			}
			$scope.dateLeft=function(){
				if($scope.changeTimeId=="1"){//日
					$scope.mapTimeDay=$scope.mapTimeDay-1000*60*60*24;
				}else if($scope.changeTimeId=="2"){//月
					console.log($scope.mapTimeMonth1-1)
					if($scope.mapTimeMonth1-1<=0){
						$scope.mapTimeMonth1=$scope.mapTimeMonth1+11
						$scope.mapTimeMonthY=$scope.mapTimeMonthY-1
					}else{
						$scope.mapTimeMonth1=$scope.mapTimeMonth1-1;
					}
					$scope.mapTimeMonth=$scope.mapTimeMonthY+' -'+$scope.mapTimeMonth1;
				}
			}
			$scope.dateRight=function(){
				if($scope.changeTimeId=="1"){//日
	 				$scope.mapTimeDay=$scope.mapTimeDay+1000*60*60*24;
				}else if($scope.changeTimeId=="2"){//月
					if($scope.mapTimeMonth1+1>12){
						$scope.mapTimeMonth1=($scope.mapTimeMonth1+1)%12;
						$scope.mapTimeMonthY=$scope.mapTimeMonthY+1
					}else{
						$scope.mapTimeMonth1=$scope.mapTimeMonth1+1;
					}
					$scope.mapTimeMonth=$scope.mapTimeMonthY+' -'+$scope.mapTimeMonth1;
				}
			}
		});
		 
	</script>
