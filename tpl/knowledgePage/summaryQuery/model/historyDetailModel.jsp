<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  ng-controller="historyDetailModelCtrl" class="history-detail">
	<%--<h3 class="title">{{detail.field1|dataNullFilter}}</h3>--%>

	<div class="clearfix  pro-introduce">
		<p class="col-sm-5 no-padder"><label class="light-black">厂家名称</label><span class="dark-black">{{detail.field2|dataNullFilter}}</span></p>
		<p class="col-sm-5 no-padder"><label class="light-black">产品型号</label><span class="dark-black">{{detail.field3|dataNullFilter}}</span></p>
		<p class="col-sm-2 no-padder"><label class="light-black">维修时间</label><span class="dark-black">{{item.updateTime|dataNullFilter}}</span></p>
	</div>
	<!--<div class="clearfix  pro-introduce">	
		 <p class="col-sm-2 no-padder"><label class="light-black">发布人</label><span class="dark-black">{{item.respManName}}</span></p>
		<p class="col-sm-4 no-padder"><label class="light-black">发布单位</label><span class="dark-black">{{item.companyName}}</span></p> 
		<p class="col-sm-4 no-padder"><label class="light-black">维修时间</label><span class="dark-black">{{item.updateTime|dataNullFilter}}</span></p>
	</div>-->
	<h5 class="font12 light-black">维修内容</h5>
	<div class="main-words">{{item.finishContent}}</div>
</div>
<script>
app.controller('historyDetailModelCtrl',function($scope, $http, $state, $stateParams) {	
	//参数类型的接收
	$scope.$on('detail',function(event,data){
		$scope.detail = data;
		$http({
			method : "POST",
			url : "${ctx}/shareRepository/getOne.htm",
			params : {
				'id' : data.id,
				'queryType' : 'historyRepair'
			}
		}).success(function(result) {
			if (result.code == 0) {
				$scope.item = result.data;
				console.info($scope.item);
				$http({
					method : "POST",
					url : "${ctx}/shareRepository/addViewsCount.htm",
					params : {
						'id' : data.id,
						'queryType' : 'historyRepair'
					}
				}).success(function(result) {
					if (result.code == 0) {
						$scope.item = result.data;
					}
				});
			}
		});
	});
});
</script>
