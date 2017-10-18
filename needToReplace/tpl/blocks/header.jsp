<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%> -->
<style>
	.toggletick .ico-active-right {color: #22c1aa;visibility: hidden;}
	.toggletick.active .ico-active-right {visibility: visible;}
	.headerName{position: fixed;background:white;font-size: 20px;letter-spacing: 3px;line-height: 50px;width: 100%;text-align: center;}
	@media (min-width: 768px){
		.app-aside-folded .navbar-collapse,.app-aside-folded .app-footer {
		    margin-left: 200px;
		}
		.app-aside-folded .navbar-header {
		    min-width:200px;
		}
	}
</style>
<!-- -->
<toaster-container toaster-options="{'position-class': 'toast-top-right', 'close-button':true}"></toaster-container>
<!-- 修改登录用户 信息 -->
<div data-ng-include="'/NECloud/tpl/blocks/updateUserInformation.jsp'"></div>
<!-- 修改登录用户 密码 -->
<div data-ng-include="'/NECloud/tpl/blocks/loginUserChangePassword.jsp'"></div>
<div ng-controller="HeaderCtrl">
	<!-- navbar header -->
	<div class="headerName"><span  ng-bind="headCenterTitle"></span></div>
	<div class="navbar-header bg-white">
		<!-- <button class="pull-right visible-xs dk" ui-toggle-class="show" data-target=".navbar-collapse">
			<i class="glyphicon glyphicon-cog"></i>
		</button>
		<button class="pull-right visible-xs" ui-toggle-class="off-screen" data-target=".app-aside" ui-scroll="app">
			<i class="glyphicon glyphicon-align-justify"></i>
		</button> -->
		<!-- brand -->
		<!-- <a href="#/" class="navbar-brand text-lt">
			 <span style="margin-left: 17px;"><img src="theme/images/solway/top_logo1.png" alt="." style="width: 25px;margin-left: 3px;"></span>
			<span class="hidden-folded" >
			 <img src="theme/images/solway/top_logo2.png" alt="." style="width: 45%;margin-left: 0px;">
			</span>
		</a> -->
		<!--  <a ng-click="goHome(isRootRoleType)" class="navbar-brand font-h2">-->
		 <!--  <i class="fa fa-btc"></i>
			<img src="theme/images/logo.png" alt="." class="hide"> -->
			<!-- <span class="pr" style="width: 25px;height:25px;top: -1px;display: inline-block;overflow: hidden;vertical-align: middle;">
				<img ng-src="${imgPath}/{{currCompanyLogo | companyInfoFilter:'${currCompanyLogo}'}}" alt="" style="width: 25px;height: 25px;position:absolute;top:0;left: 0;">
			</span><span class="hidden-folded m-l-xs opa-7" ng-bind="currCompanyName | companyInfoFilter:'${currCompanyName}'"></span>
		</a>-->
		
		<!-- <img ng-src="${imgPath}/{{currCompanyLogo | companyInfoFilter:'${currCompanyLogo}'}}" alt="" style="height: 50px;position:absolute;top:0;left: 0;"> -->
		<!-- <img ng-src="theme/images/datang/monitoringMap/datang-logo.png" alt="" style="height: 50px;position:absolute;top:0;left: 0;">-->
		
		<!-- / brand -->
	</div>
	<!-- / navbar header -->

	<!-- navbar collapse -->
	<div class="collapse pos-rlt navbar-collapse {{app.settings.navbarCollapseColor}}" ng-class="{'box-shadow': !ishome}" style="position:relative;background:rgba(255,255,255,0);">
		<!-- buttons -->
		<div class="nav navbar-nav hidden-xs m-r-md" ng-class="{'none': ishome}">
			<!-- <a href class="btn no-shadow navbar-btn" ng-click="app.settings.asideFolded = !app.settings.asideFolded">
				<i class="fa {{app.settings.asideFolded ? 'fa-indent' : 'fa-dedent'}} fa-fw"></i>
			</a>
			<a class="btn no-shadow navbar-btn" onclick="window.history.go(-1)" id="go-back-flag">
				<i class="fa fa-angle-left"></i> <span class="">返回</span>
			</a> -->
			<!-- <a href class="btn no-shadow navbar-btn" ng-click="app.settings.asideFolded = !app.settings.asideFolded" onclick="getTableWidth()">
				<i class="fa fa-dedent fa-fw"></i>
			</a> -->
			<a ng-click="goHome(isRootRoleType)" class="btn no-shadow navbar-btn text-sm" style=" margin-left: 55px;" ng-hide="roleType==3||roleType==99">
				<i class="icon-holder ico-family ico-home" style="margin-top: -4px;margin-left: 35px;"></i>&nbsp;&nbsp;首页
			</a>
			<!-- <a href class="btn no-shadow navbar-btn" onclick="window.history.go(-1)">
				<i class="fa  fa-chevron-left"></i>
			</a>
			<a href class="btn no-shadow navbar-btn" >
				<i class="fa   fa-chevron-right" onclick="window.history.go(+1)"></i>
			</a>
			<a href class="btn no-shadow navbar-btn" onclick="history.go(-0)">
				<%-- <img class="" src="${ctx}/theme/images/solway/icon/tab-refresh.png" onclick="history.go(-0)"> --%>
				<i class="fa fa-refresh"></i>
			</a> -->
			<!-- <a class="btn no-shadow navbar-btn" onclick="window.history.go(-1)" id="go-back-flag">
				<i class="fa fa-angle-left"></i> <span class="">返回</span>
			</a> -->
		</div>
		<!-- / buttons -->

		<!-- search form -->
		<!-- <form class="navbar-form navbar-form-sm navbar-left shift" ui-shift="prependTo" target=".navbar-collapse" role="search" ng-controller="TypeaheadDemoCtrl">
			<div class="form-group">
				<div class="input-group">
					<input type="text" ng-model="selected" typeahead="state for state in states | filter:$viewValue | limitTo:8" class="form-control input-sm bg-light no-border rounded padder" placeholder="搜索电站...">
					<span class="input-group-btn">
						<button type="submit" class="btn btn-sm bg-light rounded"><i class="fa fa-search"></i></button>
					</span>
				</div>
			</div>
		</form> -->
		<!-- / search form -->

		<!-- nabar right -->
		<!-- <%-- <div class="headerName">{{currCompanyName | companyInfoFilter:'${currCompanyName}'}}集中监控系统</div> --%> -->
		<ul class="nav navbar-nav navbar-right">
			<!-- <li class="hidden-xs"> -->
			<!-- <a ng-click="gotoSpeedSettled()"><i class="fa fa-plus m-r-xs font-h4"></i>接入电站</a> -->
			<!--           </li> -->
			<li class="hidden-xs">
				<a ui-fullscreen></a>
			</li>
			<li class="hidden-xs">
				 <a ng-click="lockMe();" title="锁屏"> <i class="icon-lock-open"></i></a>
			</li>
			<li class="dropdown" dropdown>
				<a ng-click="toBaseMessage()" href="javascript:;" class="dropdown-toggle" dropdown-toggle ng-hide="roleType==99" title="消息中心">
					<i class="icon-bell fa-fw"></i>
					<span class="visible-xs-inline">Notifications</span>
					<span class="badge badge-sm up bg-danger pull-right-xs" id="noticeCount1"></span>
				</a>
				<!-- dropdown -->
				<!--  <div class="dropdown-menu w-xl animated fadeInUp"> -->
					<!--  <div class="panel bg-white"> -->
					<!--  <div class="panel-heading b-light bg-light"> -->
						<!-- <strong>您有<span id="noticeCount2">0</span>条通知</strong> -->
					<!-- </div> -->
					<!-- <div class="list-group" id="noticeDiv"> -->
					<!-- </div> -->
					<!-- </div> -->
				<!-- </div> -->
				<!-- / dropdown -->
			</li>
			<li class="dropdown" dropdown>
				<a href class="dropdown-toggle clear" dropdown-toggle>
					<i class="icon-user"></i>
					<span class="hidden-sm hidden-md" ng-bind="realName"></span>
					<!-- <span data-currentRole="currentRoleID" ng-bind="currentRoleName"></span> -->
					<b class="caret"></b>
				</a>
				<!-- dropdown -->
				<ul class="dropdown-menu animated fadeInRight w">
					<li class="toggletick" ng-repeat="role in rolelist" ng-class="{'active': currentRoleID==role.roleId}">
						<a ng-click="changeRole(role.roleId, null, null, viewListCur.viewCodeAndRW)" roleId="role.roleId">
							<i class="ico-family ico-active-right"></i>
							{{role.roleDisplayName}}
						</a>
					</li>
					<li class="divider"></li>
					<li>
						<a data-toggle="modal" data-target="#powerStationManageModal"><i class="ico-family ico-null">&#xe604;</i>电站组管理</a>
					</li>
					<li>
						<a ng-click="editUserData()"><i class="ico-family ico-null">&#xe604;</i>个人信息</a>
					</li>
						 <li>
						<a ng-click="changePassword()"><i class="ico-family ico-null">&#xe604;</i>修改密码</a>
					</li>
					<li class="divider"></li>
					<li>
						<a  onclick="logOut();"><i class="ico-family ico-null">&#xe604;</i>退出系统</a>
					</li>
				</ul>
				<!-- / dropdown -->
			</li>
			<!--  <li class="hidden-xs"> -->
				<!--  <a href=""><i class=" icon-question"></i> 帮助</a> -->
			<!-- </li> -->
		</ul>
		<!-- / navbar right -->

	</div>
	<div data-ng-include="'/tpl/blocks/powerStationManage.jsp'"></div>
	<!-- / navbar collapse -->
	<style ng-if="(roleType!=3 && roleType!=99 && isPowerStationView)">
		.app-aside {
			display: none;
		}
		.app-content {
			margin-left: 0;
		}
	</style>
</div>

<script type="text/javascript">
	app.controller('HeaderCtrl', function($scope, $rootScope, $http, $state, $stateParams, $location) {
		$scope.isRootRoleType = "1";
		//$scope.isPowerStationView = (location.href.indexOf('powerStationView')!=-1);//台账页面
		$scope.ishome = ( location.href.indexOf('power-index')!=-1 );//首页
		
		//获取角色
		$http({
			method : "POST",
			url : "/NECloud/UserAuthHandle/getRoleListForPC.htm"
		}).success(function(res) {
			$scope.rolelist = res.rolelist;	//用户列表
			$scope.currentRoleID = res.currentRole;//当前用户的ID‘
			$scope.roleType = res.roleType;//当前角色类型
			var currentRoleNum = getArrAtrNum($scope.rolelist, 'roleId', $scope.currentRoleID);
			$scope.currentRoleName = $scope.rolelist[currentRoleNum].roleDisplayName;//当前角色名
			if (res.roleType ==3 || res.roleType==99) {//集团管理员,系统管理员
				$scope.isRootRoleType = '0';
			}
		});

		$scope.goHome = function (type) {
			if(type == "1"){
				//window.location.href="${ctx}/index.jsp";
				//获取角色
				$state.go($rootScope.mainPageUrl);
				/** $http({
					method : "POST",
					url : "${ctx}/UserAuthHandle/getRightListForPCNew.htm"
				}).success(function(result) {
					if(result.result){
						if(result.mainPageType == 1){
							$state.go("power-index-meter");
						}else{
							$state.go("power-index");
						}
					}
				});*/
			}
		}
		
		

		//切换角色,默认跳到各角色的首页
		$scope.changeRole = function (Id) {
			$http({
				method : "POST",
				url : "/NECloud/UserAuthHandle/changeRoleNew.htm",
				params: {
					roleId: Id	//用户要切换的ID
				}
			}).success(function(response) {
				$scope.roleType = response.roleType;
				//角色
				$scope.currentRoleID = Id;//当前角色Id
				var currentRoleNum = getArrAtrNum($scope.rolelist, 'roleId', $scope.currentRoleID);
				$scope.currentRoleName = $scope.rolelist[currentRoleNum].roleDisplayName;//当前角色名

				var res = {};
				res.currCompanyName = response.comName;
				res.currCompanyLogo = response.comLogo;
				$scope.$emit("chCompanyInfo", res);
				
				if (response.roleType ==3 || response.roleType==99) {//集团管理员,系统管理员
					var uisref = getArrRealVal(response.rightlist, 'uisref');//获取第一个uisref不为空的值
					/**$scope.isRootRoleType = '0';
					$state.go(uisref, {
						RoleId: $scope.currentRoleID
					},{reload: true});*/
					window.location.href="/index.html";
				} else {//非集团系统角色
					window.location.href="/index.html";
				};
			});
		};

		$scope.loginName = null;
		$scope.realName = null;
		$scope.userId=null;
		//锁屏
		$scope.lockMe = function() {
			$.ajax({
					type:"post",
					url:"/NECloud/Login/logout.htm",
					data:{},
					success:function(msg){
						//clearInterval(loginTimer);
							$state.go("lockme", {
								loginName : $scope.loginName,
								realName : $scope.realName
							});
					}
				});
		}
		$http({
			method : "POST",
			url : "/NECloud/Login/getLoginUser.htm",
			params : {
			}
		}).success(function(result) {
			$scope.loginName = result.userName;
			$scope.userId = result.userId;
			if(result.realName){
				$scope.realName = result.realName;
			}else{
				$scope.realName = result.userName;
			}
		});
		/*$scope.toBaseMessage = function() {
			$state.go("app.basemessage", {
				recuserId : $scope.userId
				//,
				//sendstatus : '1'
			});
		}*/
		$scope.toBaseMessage = function() {
			$state.go("app.note", {
				recuserId : $scope.userId
			},{reload: true});
		}
		$scope.editUserData=function(){
			//console.log($scope.userId)
			initPageDataUserMod($scope.userId);
			$('#userInformationUpdateModel').modal('show');
			//editData($scope.userId,'userInformationUpdateModel');
		}
		$scope.changePassword=function(){
			//console.log($scope.userId)
			$('#userPasswordChangeModel').modal('show');
		}
		$scope.gotoSpeedSettled=function(){
				$http({
				method : "POST",
				url : "/NECloud/SpeedSettled/speedSettled-session.htm"
			}).success(function(result) {
				$rootScope.last_unfinish_bpowerstation_id = result;
				window.location.href="#/app/speedSettled/speedSettled-one";
			});
		}

		 });
		/*var loginTimer;
		 $(function(){
		getLoginStatus();
		loginTimer = setInterval(getLoginStatus,10000);
			getFaultAlarmForRemind();
			setInterval(getFaultAlarmForRemind,5000);
		 }); */
		 getNoticeCount1();
		 setInterval(getNoticeCount1,5000)
		 function getNoticeCount1(){
			$.ajax({
				type : "POST",
					url : "/NECloud/BaseMessage/getNoReadBaseMessageCount.htm",
					data : {
						'searchKey':'',
						isRorS:true
					},
					success:function(result) {
						if(result > 0) {
							$("#noticeCount1").html(result);
						}else{
							$("#noticeCount1").html("");
						}
					}
				});
		 }
		 //退出登录
		 function logOut(){
			$.ajax({
				type:"post",
				url:"/Login/logout.htm",
				timeout : 5000,
				data:{},
				beforeSend: function () {
					setTimeout(function() {
						window.location.href="/login.html"
					}, 0)
				},
				success:function(msg){
					window.location.href="/login.html";
				},
				error:function(msg){
					window.location.href="/login.html";
				}
			});
		 }
		 //查询需要提醒的报警信息
		 function getFaultAlarmForRemind(){
			//$("#noticeDiv").empty();
			//$("#noticeCount1").html("");
			$.ajax({
				type:"post",
				url:"/NECloud/Login/getMessage.htm",
				data:{},
				success:function(msg){
					if((msg+"").indexOf('<title>')>=0){
						return false;
					}
					if(msg>0){
						$("#noticeCount1").html(msg);
					}else{
						$("#noticeCount1").html("");
					}
					$("#noticeCount2").html(msg.length);
				//var content='';
				//for(var i=0;i<msg.length;i++){
					//content+='<a href class="media list-group-item"><span class="media-body block m-b-none">';
					//content+=msg[i].content;
					//content+='</span></a>';
				//}
				//$("#noticeDiv").html(content);
				}
			});
		 }
		 function getLoginStatus(){
			 $.ajax({
				type:"post",
				url:"/NECloud/Login/getLoginStatus.htm",
				data:{},
				success:function(msg){
					if(msg!=1){
						window.location.href="/NECloud/login.jsp";
						return false;
					}
				}
			});
	};
</script>
<script>
	//根据数组中每项的每个属性的值查找在数组中的排序，找不到返回-1
	function getArrAtrNum(arr, atr, value) {//getArrAtrNum([{id:1},{id:2}], "id", 3)
		for (var i = 0; i < arr.length; i++) {
			if (arr[i][atr] == value) {
				return i;
			}
		}
		return -1;
	};
	function getArrAtrNum2(arr, atr, value) {
		for (var i = 0; i < arr.length; i++) {
			if (arr[i][atr].substr(0,2) == value) {
				return i;
			}
		}
		return -1;
	};
	function getArrRealVal(arr, atr){//获取数组arr中第一个atr属性不为空的值
		for (var i = 0; i < arr.length; i++) {
			if (arr[i][atr]) {
				return arr[i][atr];
			}
		}
	};
</script>
