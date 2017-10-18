<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/dataAnalysisPage/analyData.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/dataAnalysisPage/headerChangeDate.css" />
<style>
.map-jt {
    padding: 0px;text-align:center;width:25px;height:28px;line-height:25px;font-size: 30px;
    background: #123043;color: rgba(28, 43, 54,.9)!important;border-radius: 2px;cursor: pointer;color: #fff;
}
.effiJt {
    background: rgba(18, 48, 67,.5)!important;
}
.time-color{color:#123043;}
</style>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
	<!-- 综合评估 -->
	<div ng-controller="overviewHeaderCtrl" class="clearfix">
		<!-- 时间切换 -->
		<div class="pull-left no-padder">
			<!-- 显示日  -->
			<a class="no-padder" ng-show="dataType == 'month'">
				<i class="fa fa-angle-left map-jt " id="leftJt" style="color: #fff !important" class="m-r-xs" ng-click="dateLeft()"></i>

				<span class="input-append date form_datetime" id="changeTimeIdTimer-day" data-link-field="date-day">
					<input type="hidden" id="date-day" value="" />
					<span id="showDate-day" class="showdate m-l m-r font14 time-color" style="vertical-align: super;" ng-bind="mapTimeDay | date:'yyyy-MM'"></span>
				</span>

				<i id="rightJt" class="fa fa-angle-right map-jt" ng-class="{'effiJt':dailyJt}" style="color: #fff !important" class="m-r-xs" ng-click="dateRight()"></i>
			</a>
		</div>
	</div>
<script>
app.controller('overviewHeaderCtrl',function($scope, $http, $state, $stateParams) {
	$scope.judgeJt = function(){
		if ($scope.dataType == "day") {//日
			$scope.dailyJt = new Date($scope.mapTimeDay).Format("yyyy-MM-dd") == (new Date($scope.today).Format("yyyy-MM-dd"));
		}else if ($scope.dataType == "month") {//月
			$scope.dailyJt = new Date($scope.mapTimeDay).Format("yyyy-MM") == (new Date($scope.today).Format("yyyy-MM"));
		}else if ($scope.dataType == "year") {//年
			$scope.dailyJt = new Date($scope.mapTimeDay).Format("yyyy") == (new Date($scope.today).Format("yyyy"));
		}
	}
	
	//只能取到前一天
	var rightDay = new Date();
	rightDay.setMonth(rightDay.getMonth() - 1);
	$scope.today = rightDay;

	//父组件手动init
	// $scope.$on('chageDateInit',function (e, obj) {
	// 	$scope.dataType = obj.dataType || 'day',
	// 	$scope.mapTimeDay = obj.defaultTime || new Date
	// 	$scope.dailyJt = obj.endDate.Format("yyyy-MM") == $scope.mapTimeDay.Format("yyyy-MM")
	// 	$("#date-day").val($scope.mapTimeDay.Format("yyyy-MM"))
	// 	console.log(obj)
	// })

	init();//初始化页面
	function init(){
		$scope.dataType = "month";//默认显示月的数据
	}
	
	if ($stateParams.analData) {//首页带进来的参数
		$scope.mapTimeDay = new Date(parseInt($stateParams.analData)).getTime();
	} else {
		var rightDay2 = new Date();
		rightDay2.setMonth(rightDay2.getMonth() - 1);
		$scope.mapTimeDay = rightDay2;
		if($scope.dataType == "month"){
			$scope.mapTimeDay.setDate(1);
		}else if($scope.dataType == "year"){
			$scope.mapTimeDay.setDate(1);
			$scope.mapTimeDay.setMonth(1);
		}
	}
	//判断右箭头是否需要显示
	$scope.judgeJt();
	
	//点击选择时间
	$("#changeTimeIdTimer-day").datetimepicker({
		language : 'zh-CN',
		format : "yyyy-mm",
		minView : 3,
		startView: 3,
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.mapTimeDay,
		pickerPosition : "bottom-left"
	});
	
	//向左切换时间，默认加1
	$scope.mapTimeMonth1=new Date().getMonth()+1;
	$scope.mapTimeMonthY=new Date().getFullYear();
	
	$scope.nowTimeYear=new Date().getFullYear();
	
	//点击左箭头
	$scope.dateLeft = function() {
		//只要点击左箭头，则右箭头则可以点击
		$scope.dailyJt = false;
		if ($scope.dataType == "month") {//日
			$scope.mapTimeDay.setMonth($scope.mapTimeDay.getMonth()-1);
			$("#date-day").val($scope.mapTimeDay.Format("yyyy-MM"));
		}

		//将日期广播出去
		emitData();
		
	};
	//点击右箭头
	$scope.dateRight = function() {
		if ($scope.dataType == "month") {//日
			if($scope.dailyJt){
				return false;
			}
			$scope.mapTimeDay.setMonth($scope.mapTimeDay.getMonth()+1);
			$("#date-day").val($scope.mapTimeDay.Format("yyyy-MM"));
			$scope.judgeJt();
		}

		//将日期广播出去
		emitData();
	};
	
	//选择完日期，关闭时触发（日）
	$("#changeTimeIdTimer-day").on('hide',function(ev) {
		var stringTime = $("#date-day").val();//2016-08-31 14:12:57
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
			$scope.mapTimeDay = new Date(timestamp);
			$("#showDate-day").text(new Date(timestamp).Format("yyyy-MM"));
			$scope.judgeJt();
		}
	
		emitData();
		$scope.$apply()
	});
	
	//切换时间后,传数据给父级
	function emitData(){
		var msg = {};
		msg.dataType = $scope.dataType;
		msg.dtime = $scope.mapTimeDay;
		$scope.$emit("emitChangeDate", msg);
	}
});
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
</script>
