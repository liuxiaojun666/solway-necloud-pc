<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/dataAnalysisPage/analyData.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/dataAnalysisPage/headerChangeDate.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
	<!-- 综合评估 -->
	<div ng-controller="overviewHeaderCtrl" class="clearfix">
		<!-- 时间切换 -->
		<div class="pull-left no-padder" ng-hide="hideDate">
			<!-- 显示月  -->
			<a class="no-padder">
				<i class="fa fa-angle-left map-jt " id="leftJt" style="color: #fff !important" class="m-r-xs" ng-click="dateLeft()"></i>
				<span class="input-append date form_datetime" id="changeTimeIdTimer-month" data-link-field="date-month">
					<input type="hidden" id="date-month" value="" />
					<span id="showDate-month" class="showdate m-l m-r  font-h2" ng-bind="mapTimeDay | date:'yyyy-MM'"></span>
				</span>
				<i id="rightJt" class="fa fa-angle-right map-jt" ng-class="{'effiJt':dailyJt}" style="color: #fff !important" class="m-r-xs" ng-click="dateRight()"></i>
			</a>
		</div>
	</div>
<script>
app.controller('overviewHeaderCtrl',function($scope, $http, $state, $stateParams) {

	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.today = rightDay;

	$scope.$on("fillItem",function(e,value){
		var value = value[0];
		if(value != null){//编辑
			$scope.mapTimeDay = new Date(value.busiDate);
		}else{
			//新增
			$scope.mapTimeDay = rightDay;
		}
        $scope.judgeJt();
		emitData();
	});

	//切换时间后,传数据给父级
	function emitData(){
		$scope.$emit("emitChangeDateToMonth", $scope.mapTimeDay);
	}

	$scope.judgeJt = function(){
		$scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM")) == (new Date($scope.today).Format("yyyy-MM"));
	}
	
	$("#changeTimeIdTimer-month").datetimepicker({
		language : 'zh-CN',
		startView: 3, 
		minView: 3, 
		format: 'yyyy-mm',
		autoclose : true,
		todayBtn : true,
		endDate : $scope.today,
		initialDate : $scope.mapTimeDay,
		pickerPosition : "bottom-left"
	});
	
	//点击左箭头
	$scope.dateLeft = function() {
		//只要点击左箭头，则右箭头则可以点击
		$scope.dailyJt = false;
		$scope.mapTimeDay.setMonth($scope.mapTimeDay.getMonth()-1);
		$("#date-month").val($scope.mapTimeDay.Format("yyyy-MM"));

		//将日期广播出去
		emitData();
		
	};
	//点击右箭头
	$scope.dateRight = function() {
		if($scope.dailyJt){
			return false;
		}
		$scope.mapTimeDay.setMonth($scope.mapTimeDay.getMonth()+1);
		$("#date-month").val($scope.mapTimeDay.Format("yyyy-MM"));

		$scope.judgeJt();
		//将日期广播出去
		emitData();
	};
	
	//选择完日期，关闭时触发（月）
	$("#changeTimeIdTimer-month").on('hide',function(ev) {
		var stringTime = $("#date-month").val();
		if(stringTime){
			var timestamp = Date.parse(getDateForStringDate(stringTime));
			$scope.mapTimeDay = new Date(timestamp);
			$("#showDate-month").text(new Date(timestamp).Format("yyyy-MM"));
		}
		$scope.mapTimeDay = new Date(timestamp);
		$scope.judgeJt();
		emitData();
	});

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
