<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<link rel="stylesheet" href="./theme/css/tpl/confirm.css">
<div class="confirm-con" ng-controller="confirmCtrl">
	<p class="alertContent">{{content}}</p>
	<div class="col-xs-12 clearfix" ng-show="type=='double'">
		<div class="col-xs-6"><a class="cancel" id="cancel">取消</a></div>
		<div class="col-xs-6"><a class="delete" id="confirm">确定</a></div>
	</div>
	<div class="col-xs-12 clearfix" ng-show="type=='single'">
		<div class="col-xs-12"><a class="delete" id="tip">确定</a></div>
	</div>
</div>

<script type="text/javascript">
	var confirmH = 100;
	var confirmW = 250;
	var confirmContainerH = $(".confirm-con").parent().parent().height();
	var confirmContainerW = $(".confirm-con").parent().parent().width();
	$(".confirm-con").css({"top":(confirmContainerH-confirmH)/2,"left":(confirmContainerW-confirmW)/2});
	$("#cancel").click(function(){
		$(".confirm-con").hide();
	});
	$("#tip").click(function(){
		$(".confirm-con").hide();
	});
	app.controller('confirmCtrl', function($scope) {
		$scope.$on('childConfirm', function(event,data,type,content) {
			$scope.childConfirm = data;
			$scope.type = type;
			$scope.content = content;
        });
		$("#confirm").click(function(){
			 $scope.$emit('confirmEvent',$scope.childConfirm);
			 $(".confirm-con").hide();
		});
	});
</script>

