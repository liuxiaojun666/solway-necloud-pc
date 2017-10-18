<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%> -->
<div class="modal-over bg-black" ng-controller="LockMeCtrl">
  <div class="modal-center animated fadeInUp text-center" style="width:200px;margin:-100px 0 0 -100px;">
    <div class="thumb-lg">
<!--       <img src="img/a0.jpg" class="img-circle"> -->
    </div>
    <p class="h4 m-t m-b" ng-bind="realName"></p>
    <div class="input-group">
      <input type="password" ng-model="password" class="form-control text-sm btn-rounded no-border" placeholder="输入密码继续操作">
      <span class="input-group-btn">
        <a id="unLockBtn" class="btn btn-success btn-rounded no-border" ng-click="unLock();"><i class="fa fa-arrow-right"></i></a>
      </span>
    </div>
    <div class="input-group">
      <p ng-bind="errorMessage" style="font-size: 14px;font-family: '黑体';color:red;text-align: center;margin-bottom: -10px;"></p>
    </div>
  </div>
</div>
<script type="text/javascript">
app.controller('LockMeCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams',
		                                       function($http, $location, $rootScope, $scope, $state, $stateParams){
	$scope.loginName = $stateParams.loginName;
	$scope.realName = $stateParams.realName;
	$scope.password = null;
	$scope.errorMessage = null;
	$scope.unLock = function(){
		if($scope.password==null||$scope.password==""){
			return false;
		}
		$http({
       		method : "POST",
       		url : "/NECloud/Login/doLogin.htm",
       		params : {
       			userName:$scope.loginName,
       			password:$scope.password
       		}
       	}).success(function(result) {
       		//用户名和密码匹配,登陆成功
       		if(result.status==1){
       			window.location.href="/index.html";
       		} else {
       			$scope.errorMessage = "密码错误！";
       		}
       	});
	}
}]);
//点击  Enter  键  登陆
document.onkeydown = function(e)
{
   var e = window.event   ?   window.event   :   e; 
   if(e.keyCode == 13){
	   $("#unLockBtn").trigger("click");
	}
}	 
</script>
