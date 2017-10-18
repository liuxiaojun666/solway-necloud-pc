<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.app-content > .app-content-full {bottom: 0;}
</style>
<div ng-controller="KnowledgeCtr" class="hbox hbox-auto-xs bg-light">
	<div class="app-content-full" style="top:0px;bottom: 0px">
		<div class="hbox hbox-auto-xs hbox-auto-sm">
			<!-- <%@ include file="shareTree/shareTree.jsp"%> -->
			<div class="col lter tree_info">
				<div class="vbox">
					<div class="row-row">
						<div class="cell">
							<div class="cell-inner">
								<div class="wrapper-md">
									<%@ include file="shareRepository/shareRepositoryList.jsp"%>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<input type="hidden" id="watchType" ng-click="onSelectPage(1)" />
		</div>
	</div>
</div>

<script type="text/javascript">
app.controller('KnowledgeCtr', function($scope, $http, $state) {
	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		if (page == 0) {
			page = 1;
		}
		
		$.post("${ctx}/shareRepository/list.htm", {
			'pageIndex' : page - 1,
			'pageSize' : $scope.pageSizeSelect,
			'keywords' : $("#keyWords").val(),
			'id': $("#bccode").val(),
			'title': $("#bcname").val(),
			'type': $("#watchType").val()
		}, function(result, status){
			getTableData($scope,result);
			$scope.$applyAsync();
		});
	};
	$scope.onSelectPage(1);
});
</script>
