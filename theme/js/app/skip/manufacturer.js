app.controller('ManufacturerCtrl', ['$scope', '$http', function($scope, $http) {
  $scope.createManufacturer = function(){
	  alert("----");
//	  $http({method : 'GET',params : { id:123}, data:{name:'john',age:27}, url : "/product"})
//	  .success(function(response, status, headers, config){
//		  alert("success");
//	  //do anything what you want;
//	  })
//	  .error(function(response, status, headers, config){
//	  //do  anything what you want;
//		  alert("error");
//	  });
	  $http.get('/product').
	  success(function(data, status, headers, config) {
	    // this callback will be called asynchronously
	    // when the response is available
	  }).
	  error(function(data, status, headers, config) {
		  alert("error2");
	    // called asynchronously if an error occurs
	    // or server returns response with an error status.
	  });

  }
}]);
