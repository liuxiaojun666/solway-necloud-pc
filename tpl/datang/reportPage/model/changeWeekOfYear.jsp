<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
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
	border-right: 1px solid black;float:left;
}
.yearsBox::-webkit-scrollbar{ /*隐藏滚轮*/
	display: none;
}
.weeksBox::-webkit-scrollbar{ /*隐藏滚轮*/
	display: none;
}
.yearsBox,.weeksBox{
	-ms-overflow-style:none;	float:left;
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
	<!-- 综合评估 -->
	<div ng-controller="changeWeekOfYearCtrl" class="clearfix">
		<div class="currentWeekNum" ng-init="weekFlag = false" >
			<!--<div class="preWeek fa fa-angle-left map-jt" style="color: #fff !important" ng-click="preData()"></div> -->
			<div class="weekNumInfo" ng-click="weekFlag = !weekFlag" ><span ng-bind="nowTimeYear+'年'"></span><span ng-bind="'第'+ currentWeek +'周'"></span></div>
			<!--<div class="nextWeek fa fa-angle-right map-jt" style="color: #fff !important" ng-click="nextData()" ng-class="{'effiJt':currentWeek == weekTotal}"></div>-->

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
		<!-- <div class="showWeekBox">
			<span ng-bind="productData[0].startDate|date:'yyyy-MM-dd'|dataNullFilter" scroll="no"></span>
			至
			<span ng-bind="productData[0].endDate|date:'yyyy-MM-dd'|dataNullFilter"></span>
		</div> -->
	</div>
<script>
app.controller('changeWeekOfYearCtrl',function($scope, $http, $state, $stateParams) {
	$scope.startWeek = 1; //数据的起始周数
	$scope.currentMaxWeek;//当前最大周

	$scope.$on("fillItem",function(e,value){
		$scope.yearsArr = [];
		$scope.weeksArr = [];
		var value = value[0];
		if(value != null){
			//编辑
			$scope.nowTimeYear = value.yearDate;
			$scope.currentWeek = value.weekNum;
			$scope.initYearWeek("edit");
		}else{
			//新增
			$scope.initYearWeek("insert");
		}
	});

	$scope.initYearWeek = function(type){
		$http({
			method : "GET",
			url : "${ctx}/report/getWeekOfYears.htm"
		}).success(function(result) {

			if(result.code != 0){
				return false;
			}
			$scope.weekOfYearsData = result.data;
			//年列表
			for(var i = $scope.weekOfYearsData.length-1 ; i>=0; i--){
				$scope.yearsArr.push($scope.weekOfYearsData[i].year);
			}
			//默认显示首年的week列表
			$scope.weeksArr = $scope.getWeeksArr(result.data[0].week);
			if(type == "edit"){
				for(var i = 0;i< $scope.weekOfYearsData.length;i++){
					if($scope.weekOfYearsData[i].year == $scope.nowTimeYear){
						$scope.currentMaxWeek = $scope.weekOfYearsData[i].week;
						break;
					}
				}
			}else if(type == "insert"){
				$scope.nowTimeYear = result.data[ result.data.length-1].year;
				$scope.currentWeek = result.data[ result.data.length-1].week;
				$scope.currentMaxWeek = $scope.currentWeek;
			}
			emitDate();
		});
	}

	$scope.preData = function(){//前一周数据
		if($scope.currentWeek > $scope.startWeek){
			$scope.currentWeek--;
		}
	};
	$scope.nextData = function(){//后一周数据
	console.log($scope.currentMaxWeek);
		if($scope.currentWeek < $scope.currentMaxWeek){
			$scope.currentWeek++;
		}
	};

	//可选的周(所有周数)
	$scope.getWeeksArr = function(maxWeek){
		var weeksArr = [];
		for(var j = $scope.startWeek ; j <= maxWeek ; j++){
			weeksArr.push(j);
		};
		return weeksArr.reverse();
	}

	//更改显示周
	$scope.changeWeekFn = function(){
		$scope.currentWeek = this.n;
		emitDate();
	};
	$scope.changeYearFn = function(){
		$scope.nowTimeYear = this.yearNum;
		var week;
		for(var i = 0;i< $scope.weekOfYearsData.length;i++){
			if($scope.weekOfYearsData[i].year == $scope.nowTimeYear){
				week = $scope.weekOfYearsData[i].week;
				break;
			}
		}
		$scope.currentWeek = week;
		$scope.currentMaxWeek = week;
		$scope.weeksArr = $scope.getWeeksArr(week);
	};

	function emitDate(){
		var date = {"year":$scope.nowTimeYear,"week":$scope.currentWeek};
		$scope.$emit("changeWeek",date);
	}
});

</script>
