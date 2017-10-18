app.directive('paging', function() {
		return {
			restrict : 'E',
			//scope: {
			//    numPages: '=',
			//    currentPage: '=',
			//    onSelectPage: '&'
			//},
			template : '',
			replace : true,
			link : function(scope, element, attrs) {
				scope.$watch('numPages', function(value) {
					scope.pages = [];
					for (var i = 1; i <= value; i++) {
						scope.pages.push(i);
					}
					if (scope.currentPage > value) {
						scope.selectPage(value);
					}
				});
				scope.isActive = function(page) {
					return scope.currentPage === page;
				};
				scope.selectPage = function(page) {
					if (!scope.isActive(page)) {
						scope.currentPage = page;
						scope.onSelectPage(page);
					}
				};
				scope.selectPrevious = function() {
					if (!scope.noPrevious()) {
						scope.selectPage(scope.currentPage - 1);
					}
				};
				scope.selectNext = function() {
					if (!scope.noNext()) {
						scope.selectPage(scope.currentPage + 1);
					}
				};
				scope.noPrevious = function() {
					return scope.currentPage <= 1;
				};
				scope.noNext = function() {
					return scope.currentPage == scope.numPages;
				};
				scope.goPage = function () {
					if (scope.goPageNum != scope.currentPage && scope.goPageNum != '' &&scope.goPageNum <= scope.numPages) {
						scope.selectPage(scope.goPageNum);
					}
				}

			}
		};
	});
function initTableConfig($scope){
	$scope.data = null;
	$scope.currentPage = 1;
	$scope.numPages = 1;
	$scope.pageSize = 10;
	$scope.pages = [];
	$scope.showStart = null;
	$scope.showEnd = null;
	$scope.totalPage = null;
	$scope.pageSizeSelect=10;
}
function getTableData($scope,result){
	$scope.data = result.data;
	$scope.numPages = result.totalPage;
	$scope.showStart = result.showStart;
	$scope.showEnd = result.showEnd;
	$scope.total = result.total;
	$scope.totalPage=result.totalPage;
	if($scope.totalPage==0){
		$scope.currentPage=0;
	}else{
		$scope.currentPage=result.pageIndex+1;
	}
}
