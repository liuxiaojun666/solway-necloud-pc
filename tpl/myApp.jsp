  <!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%> -->
  <div ng-controller="commonCtrl">
  <!-- -->
  <toaster-container toaster-options="{'position-class': 'toast-top-right', 'close-button':true}"></toaster-container>
  <!-- navbar -->
  <div data-ng-include=" 'tpl/blocks/header.jsp' " class="app-header navbar">
  </div>
  <!-- / navbar -->

  <!-- menu -->
  <div data-ng-include=" 'tpl/blocks/aside.jsp' " class="app-aside hidden-xs {{app.settings.asideColor}}">
  </div>
  <!-- / menu -->

  <!-- content -->
  <div class="app-content">
	<!-- 修改登录用户 信息 -->
	<!-- <%--<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>--%> -->
	<!-- 修改登录用户 密码 -->
	<!-- <%--<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>--%> -->

    <div ui-butterbar></div>
    <a href class="off-screen-toggle hide" ui-toggle-class="off-screen" data-target=".app-aside" ></a>
    <div class="app-content-body fade-in-up ng-scope " ui-view></div>
  </div>
  <script>
  	
  
  </script>
  <!-- /content -->
<button type="button" style="display: none;" id="errorFlag" ng-click="getPrompt('error','','保存失败,请稍后重试!')">click</button>
  <!-- aside right -->
  <div class="app-aside-right pos-fix no-padder w-md w-auto-xs bg-white b-l animated fadeInRight hide">
    <div class="vbox">
      <div class="wrapper b-b b-t b-light m-b">
        <a href class="pull-right text-muted text-md" ui-toggle-class="show" target=".app-aside-right"><i class="icon-close"></i></a>
        Chat
      </div>
      <div class="row-row">
        <div class="cell">
          <div class="cell-inner padder">
            <!-- chat list -->
            <div class="m-b">
             <!--  <a href class="pull-left thumb-xs avatar"><img src="img/a2.jpg" alt="..."></a> -->
              <div class="clear">
                <div class="pos-rlt wrapper-sm b b-light r m-l-sm">
                  <span class="arrow left pull-up"></span>
                  <p class="m-b-none">Hi John, What's up...</p>
                </div>
                <small class="text-muted m-l-sm"><i class="fa fa-ok text-success"></i> 2 minutes ago</small>
              </div>
            </div>
            <div class="m-b">
             <!--  <a href class="pull-right thumb-xs avatar"><img src="img/a3.jpg" class="img-circle" alt="..."></a> -->
              <div class="clear">
                <div class="pos-rlt wrapper-sm bg-light r m-r-sm">
                  <span class="arrow right pull-up arrow-light"></span>
                  <p class="m-b-none">Lorem ipsum dolor :)</p>
                </div>
                <small class="text-muted">1 minutes ago</small>
              </div>
            </div>
            <div class="m-b">
              <!-- <a href class="pull-left thumb-xs avatar"><img src="img/a2.jpg" alt="..."></a> -->
              <div class="clear">
                <div class="pos-rlt wrapper-sm b b-light r m-l-sm">
                  <span class="arrow left pull-up"></span>
                  <p class="m-b-none">Great!</p>
                </div>
                <small class="text-muted m-l-sm"><i class="fa fa-ok text-success"></i>Just Now</small>
              </div>
            </div>
            <!-- / chat list -->
          </div>
        </div>
      </div>
      <div class="wrapper m-t b-t b-light">
        <form class="m-b-none">
          <div class="input-group">
            <input type="text" class="form-control" placeholder="Say something">
            <span class="input-group-btn">
              <button class="btn btn-default" type="button">SEND</button>
            </span>
          </div>
        </form>
      </div>
    </div>
  </div>
  <!-- / aside right -->
</div>
  <!-- footer -->
<!--   <div class="app-footer wrapper b-t bg-light">
    <span class="pull-right">{{app.version}} <a href ui-scroll="app" class="m-l-sm text-muted"><i class="fa fa-long-arrow-up"></i></a></span>
    &copy; 2015 Solway.
  </div> -->
  <!-- / footer -->
<!--  -->
<!--   <div data-ng-include=" 'tpl/blocks/settings.html' " class="settings panel panel-default">
  </div> -->
  <script>
// success   info    wait   warning   error
var promptObj;
app.controller('commonCtrl', ['$scope','$rootScope', 'toaster','$http', function($scope,$rootScope, toaster,$http) {
	promptObj=$scope.getPrompt = function(type,title,message){
        toaster.pop(type,title,message);
    };
    //添加
    $scope.addData = function (modalId){
    	initPageData();
    	$('#'+modalId).modal('show');
    };
    //修改
    $scope.editData = function (id,modalId){
    	initPageData(id);
    	$('#'+modalId).modal('show');
    };
    //单条删除
    $scope.deleteOneData = function(dataId,durl) {
    	if (confirm("确定要删除这条数据吗？")) {
    		$http({
				method : "POST",
				url : durl,
				params : {"id" : dataId}
			}).success(function(result) {
				toaster.pop('success', '', result.message);
				goPage(1);
			}).error(function(){
			});
		}
	};
	//批量删除
    $scope.deleteBatchData=function(url){
    	var conti = checkSelectMsg("ids", "请至少选择一条记录!");
		if (conti&&confirm("确定要删除这些记录吗?")) {
			$http({
				method : "POST",
				url : url
			}).success(function(result) {
				toaster.pop('success', '', result.message);
				goPage(1);
			}).error(function(){
				$scope.getPrompt('error', '', '删除失败!');
			});
		}
    };
    
    $scope.getCurrentDataName = function (currentView,isGroup,callback) {
    	$rootScope.currentView = currentView;
      $rootScope.isGroup = isGroup;
   		$http({
   			method:"POST",
   			url:"/NECloud/UserAuthHandle/getCurrentInfoNew.htm",
   			params : {currentView : currentView,isGroup : isGroup}
       	}).success(function (result) {
       		if(result.currentDataName){
       			$rootScope.currentDataName = result.currentDataName;
       		}else{
       			$rootScope.currentDataName = "-请选择-";
       		}
          result.currentSTID && callback && callback(result)
		});
    }
    $scope.getCurrentDataNameAsyncFalse = function (currentView,isGroup) {
    	$rootScope.currentView = currentView;
    	$rootScope.isGroup = isGroup;
    	$.ajax({
    		type : "post",	
    		url:"/NECloud/UserAuthHandle/getCurrentInfoNew.htm",
    		data:{currentView : currentView,isGroup : isGroup},
    		async : false,
    		success : function(result) {
    			if(result.currentDataName){
           			$rootScope.currentDataName = result.currentDataName;
           		}else{
           			$rootScope.currentDataName = "-请选择-";
           		}
    		},
    		error : function(json) {
    		}
    	});
	}

    $scope.$on("getNavCompany", function (event, msg) {
      $scope.$broadcast("getNavCompanyFromApp", msg);
    });
    
}]);
</script>
