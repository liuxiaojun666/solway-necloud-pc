<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
#paginationForKnowledgePage.pagination > li > a {
   height:26px;width:26px;line-height:26px;text-align:center;background-color: rgb(183,183,183);color: #fff;border-radius:0px; margin-right: 17px;font-size:18px;padding:0;
}
#paginationForKnowledgePage.pagination > li > a.current  {
    padding: 0;
    background-color:rgb(28,176,154);
    color: #fff;
    border-radius: 0px;
    border:0px;
}
#paginationForKnowledgePage.pagination > li {
    display: inline-block;
}
#paginationForKnowledgePage.pagination > li:first-child > a {
    border-top-left-radius: 0px;
    border-bottom-left-radius: 0px;
}
#paginationForKnowledgePage.pagination > li:last-child > a {
    border-top-right-radius: 0px;
    border-bottom-right-radius: 0px;
}
</style>

	<div class="pull-right"  style="text-align: right;margin: 8px 0 0;" ng-controller="knowledgePaggerCtr">
		<ul class="pagination no-padder m-n" id="paginationForKnowledgePage"
			num-pages="tasks.pageCount" current-page="tasks.currentPage"
			on-select-page="selectPage(page)" style="background-color: transparent!important;">
			<li ng-class="{disabled: noPrevious()}">
				<a ng-click="selectPrevious()"><i class="fa fa-angle-left"></i></a>
			</li>
			<li id="pageNumShow">
			</li>
			<li ng-class="{disabled: noNext()}">
				<a ng-click="selectNext()" style="margin-left:5px;"><i class="fa fa-angle-right"></i></a>
			</li>
		</ul>
	</div>
<script type="text/javascript">
app.controller('knowledgePaggerCtr', function($scope, $http, $state) {
	var obj = $("#pageNumShow");
	$scope.$on("pages",function(){
		showPages();
	});
	function showPages(){
		obj.empty();
		if($scope.currentPage != 1 && $scope.currentPage >= 4 && $scope.totalPage != 4){
			obj.append('<a href="javascript:;" class="tcdNumber">'+1+'</a>');
		}
		if($scope.currentPage-2 > 2 && $scope.currentPage <= $scope.totalPage && $scope.totalPage > 5){
			obj.append('<a>...</a>');
		}
		var start = $scope.currentPage -2,end = $scope.currentPage+2;
		if((start > 1 && $scope.currentPage < 4)||$scope.currentPage == 1){
			end++;
		}
		if($scope.currentPage > $scope.currentPage-4 && $scope.currentPage >= $scope.totalPage){
			start--;
		}
		for (;start <= end; start++) {
			if(start <= $scope.totalPage && start >= 1){
				if(start != $scope.currentPage){
					obj.append('<a  class="tcdNumber">'+ start +'</a>');
				}else{
					obj.append('<a class="current">'+ start +'</a>');
				}
			}
		}
		
		if(($scope.currentPage + 2 < $scope.totalPage - 1) && ($scope.currentPage >= 1 && $scope.totalPage > 5)){
			obj.append('<a>...</a>');
		}
		if($scope.currentPage != $scope.totalPage && $scope.currentPage < $scope.totalPage -2  && $scope.totalPage != 4){
			obj.append('<a href="javascript:;" class="tcdNumber">'+$scope.totalPage+'</a>');
		}
		$(".tcdNumber").click(function(){
			var currentNum = $(this).text();
			$scope.selectPage(currentNum);
		});
	}
	
	showPages();
	
});
	
</script>