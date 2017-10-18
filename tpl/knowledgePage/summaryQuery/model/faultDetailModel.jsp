<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  ng-controller="faultDetailModelCtrl" class="fault-detail clearfix">
	<h3 class="title">故障码</h3>
	<table class="table table-bordered">
		<tr>
			<td class="col-lg-2">厂家名称</td>
			<td class="col-lg-4">{{detail.field2}}</td>
			<td class="col-lg-2">产品型号</td>
			<td class="col-lg-4">{{detail.field3}}</td>
		</tr>
		<tr>
			<td class="col-lg-2">协议名称</td>
			<td class="col-lg-10" colspan="4">{{detail.field4}}</td>
		</tr>
		<tr>
			<td class="col-lg-2" ng-if="item.faultCode != null && item.faultCode != ''">故障代码</td>
			<td class="col-lg-4" ng-if="item.faultCode != null && item.faultCode != ''">{{item.faultCode}}</td>
			<td class="col-lg-2" ng-if="item.faultCodeIndex != null && item.faultCodeIndex != ''">故障索引</td>
			<td class="col-lg-4" ng-if="item.faultCodeIndex != null && item.faultCodeIndex != ''">{{item.faultCodeIndex}}</td>
			<td class="col-lg-2">故障分类</td>
			<td class="col-lg-4">{{item.faultTypeName}}</td>
		</tr>
		<tr>
			<td class="col-lg-2">故障中文描述</td>
			<td class="col-lg-4">{{item.faultDescCH}}</td>
			<td class="col-lg-2">故障英文描述</td>
			<td class="col-lg-4">{{item.faultDescEN}}</td>
		</tr>
		<tr>
			<td class="col-lg-2">故障原因及处理流程</td>
			<td class="col-lg-10" colspan="4" ng-bind-html="item.faultHandle | replaceBrFilter"></td>
		</tr>
		<tr>
			<td class="col-lg-2">处理建议</td>
			<td class="col-lg-10" colspan="4"><p ng-repeat="item in realAdvices" ng-bind="item.content"></p></td>
		</tr>
		<tr>
			<td class="col-lg-2">备注</td>
			<td class="col-lg-10" colspan="4">{{item.descp}}</td>
		</tr>
		<tr>
			<td class="col-lg-2">附件</td>
			<td class="col-lg-10" colspan="4">

				<a ng-if="item.file1 != '' && item.file1 != null" class="text-info" title="{{item.fileName1}}" ng-click="downloadFaultFile({{item.id }}, '1')">
					<i class="fa fa-paperclip"></i> 附件1
				</a>
				<span ng-if="!(item.file1 != '' && item.file1 != null)" class="text-muted">
					<i class="fa fa-paperclip"></i> 附件1
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a ng-if="item.file2 != '' && item.file2 != null" class="text-info" title="{{item.fileName2}}" ng-click="downloadFaultFile({{item.id }}, '2')">
					<i class="fa fa-paperclip"></i> 附件2
				</a>
				<span ng-if="!(item.file2 != '' && item.file2 != null)" class="text-muted">
					<i class="fa fa-paperclip"></i> 附件2
				</span>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<a ng-if="item.file3 != '' && item.file3 != null"class="text-info" title="{{item.fileName3}}" ng-click="downloadFaultFile({{item.id }}, '3')">
					<i class="fa fa-paperclip"></i> 附件3
				</a>
				<span ng-if="!(item.file3 != '' && item.file3 != null)"class="text-muted">
					<i class="fa fa-paperclip"></i> 附件3
				</span>
			</td>
		</tr>
	</table>
</div>
<script>
app.controller('faultDetailModelCtrl',function($scope, $http, $state, $stateParams) {
	
	//参数类型的接收
	$scope.$on('detail',function(event,data){
		$scope.detail = data;
		$http({
			method : "POST",
			url : "${ctx}/shareRepository/getOne.htm",
			params : {
				'id' : data.id,
				'queryType' : 'faultGuidance'
			}
		}).success(function(result) {
			if (result.code == 0) {
				$scope.item = result.data;
				$http({
					method : "POST",
					url : "${ctx}/shareRepository/addViewsCount.htm",
					params : {
						'id' : data.id,
						'queryType' : 'faultGuidance'
					}
				}).success(function(result) {
					if (result.code == 0) {
						$scope.item = result.data;
					}
				});
			}
		});
	});
	//下载故障码附件
	$scope.downloadFaultFile = function(id, index){
		window.open("${ctx}/PFaultCodeReal/downloadAttachment.htm?id=" + id + "&index=" + index);
	}

});
</script>
