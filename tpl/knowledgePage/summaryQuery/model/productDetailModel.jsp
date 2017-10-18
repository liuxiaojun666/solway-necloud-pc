<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  ng-controller="productDetailModelCtrl" class="product-detail">
	<h3 class="title" ng-bind="item.title"></h3>
	<p class="text-center light-black" style="margin-bottom: 35px;"><img src="theme/images/knowledgeBase/eye.png" style="margin-right:10px;"><span class="font14" style="margin-right:20px;">浏览次数</span><span class="font16" ng-bind="item.views"></span></p>
	<div class="clearfix  pro-introduce">	
		<p class="col-sm-2 no-padder"><label class="light-black">发布人</label><span class="dark-black" ng-bind="item.userName"></span></p>
		<p class="col-sm-4 no-padder"><label class="light-black">发布单位</label><span class="dark-black" ng-bind="item.releaseunitName"></span></p>
		<p class="col-sm-4 no-padder"><label class="light-black">产品名称</label><span class="dark-black" ng-bind="item.productName"></span></p>
		<p class="col-sm-2 no-padder"><label class="light-black" style="width:3em;">状态</label><span class="dark-black" ng-if="item.status == '01'">发布</span><span class="dark-black" ng-if="item.status == '00'">草稿</span><span class="dark-black" ng-if="item.status == '02'">作废</span></p>
	</div>
	<div class="clearfix  pro-introduce">
		<p class="col-sm-2 no-padder"><label class="light-black">发布范围</label><span class="dark-black" ng-if="item.releaseScope == '01'">公司内</span><span class="dark-black" ng-if="item.releaseScope == '00'"></span></p>
		<p class="col-sm-4 no-padder"><label class="light-black">发布时间</label><span class="dark-black" ng-bind="item.releasetime"></span></p>
		<p class="col-sm-5 no-padder"><label class="light-black">厂商名称</label><span class="dark-black" ng-bind="item.manuFName"></span></p>
	</div>
	<div class="clearfix  pro-introduce">	
		<p class="col-sm-12 no-padder clearfix"><label class="light-black col-sm-2 no-padder">简介</label>
		<span class="col-sm-10 no-padder dark-black" style="line-height:2em;" ng-bind="item.introduce"></span></p>
	</div>
	<div class="clearfix  pro-introduce">	
		<p class="col-sm-12 no-padder">
			<label class="light-black">关键词</label>
			<span class="margin-right15 dark-black" ng-repeat="m in item.keywords.split(',')">{{m}}</span>
		</p>
	</div>
	<h5 class="font12 light-black">正文</h5>
	<div class="main-words" ng-bind-html="item.content"></div>

	<div class="attachment" ng-repeat="attachment in item.attachment">
		<a href="javascript:;" class="download" attachmentId="" ng-click="download({{attachment.id}})">
			<img src="theme/images/knowledgeBase/attachment-icon.png" style="vertical-align: text-top;">
			<label>附件{{$index+1}}</label>{{attachment.fileName}}
		</a>
	</div>
</div>
<script>
app.controller('productDetailModelCtrl',function($scope, $http, $state, $stateParams) {
	//参数类型的接收
	$scope.$on('detail',function(event,data){

		$http({
			method : "POST",
			url : "${ctx}/shareRepository/getOne.htm",
			params : {
				'id' : data.id,
				'queryType' : 'proInfo'
			}
		}).success(function(result) {
			if (result.code == 0) {
				$scope.item = result.data;
				$http({
					method : "POST",
					url : "${ctx}/shareRepository/addViewsCount.htm",
					params : {
						'id' : data.id,
						'queryType' : 'proInfo'
					}
				}).success(function(result) {
					if (result.code == 0) {
						$scope.item = result.data;
					}
				});
			}
		});
	});

	$scope.download = function(id){
		window.open("${ctx}/shareRepository/downloadAttachment.htm?id="+id);
	}
});
</script>
