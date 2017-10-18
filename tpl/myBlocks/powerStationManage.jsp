<!-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%> -->
<link rel="stylesheet" href="./theme/css/powerStationManage/addGroup.css">
<div ng-controller="powerStationManageCtrl" class="modal fade" id="powerStationManageModal">
	<div id="model-container">
		<div class="modal-container" style="height:275px;width:768px;">
			<div class="modal-content" style="background-color: rgba(42, 58, 71, .9);font-size: 14px;">
				<a class="icon-close modelCloseBtn time black-1" data-dismiss="modal" style="color:black;"></a>
			</div>
			<!-- 暂无分组 -->
			<div class="sign" id="addGroup-con">
				<div class="circle">
					<img  src="./theme/images/power-index/non-group.png" style="margin: 28px 0 15px;"> 
					<p>暂无分组</p>
				</div>
				<a class="add-btn" ng-click="addGroup()">添加分组</a>
			</div>
			<!-- 有分组，显示分组列表 -->
			<div class="sign" id="group-list">
				<div class="header-con">
	                <div class="name">电站组</div>
	            </div>
	            <div class="clearfix nav-con">
	            	<div class="pull-left check-box"><input type="checkbox" ng-model="groupSelectAll"><span>全选</span></div>
	            	<div class="pull-left"><a class="delete-all" ng-click="deleteGroups()">删除</a></div>
	            	<div class="pull-left"><span class="add-group" ng-click="addGroup()"><img src="./theme/images/power-index/add-group.png"></span><span>添加组</span></div>
	            </div>
	            <ul class="group-list">
	            	<li class="clearfix" ng-repeat="item in groupList">
                        <div class="pull-left" style="width:3%;"><input type="checkbox" ng-checked="groupSelectAll" name="groupCheckList" value={{item.id}}></div>
                        <div class="pull-right clearfix" style="width:97%;" ng-click="showStationList(item.id,item.groupName)">
                            <div class="pull-left"><span class="station-name">{{item.groupName}}</span></div>
                            <div class="pull-right" ><span class="station-num">{{item.powerStation.length}}</span><span>＞</span></div>
                        </div>
	            	</li>
	            </ul>
			</div>
			<!-- 创建分组  -->
			<div class="sign" id="add-group">
				<h4>创建分组</h4>
				<div class="input-con h-box"><label>分组名称：</label><input  placeholder="请输入新建组名称，最多6个字" ng-model="addGroupName" class="flex"></div>
				<div class="button-con clearfix"><a ng-click="save()" class="save pull-left">保存</a><a ng-click="cancel()" class="cancel pull-right">取消</a></div>
			</div>
			<!-- 某个分组下的电站列表 -->
			<div class="sign"  id="station-list">
				<div class="header-con">
	                <div class="go-back" ng-click="showGroupList()"><span>＜</span></div>
	                <div class="name">{{groupName}}</div>
	            </div>
                <div class="clearfix nav-con">
                    <div class="pull-left check-box"><input type="checkbox" ng-model="stationSelectAll"><span>全选</span></div>
                    <div class="pull-left"><a class="delete-all" ng-click="deleteStations()">删除</a></div>
                    <div class="pull-left"><span class="add-group" ng-click="addStation()"><img src="./theme/images/power-index/add-group.png"></span><span>添加电站</span></div>
                </div>
                <ul class="station-list">
                    <li class="clearfix" ng-repeat="item in stations">
                        <div class="pull-left"><input type="checkbox" ng-checked="stationSelectAll" name="stationCheckList" value={{item.powerstationid}}><span class="station-name">{{item.stationName}}</span></div>
                    </li>
                </ul>
			</div>
			<!-- 添加电站 -->
			<div class="sign"  id="add-station">
				<div class="header-con">
	                <div class="go-back" ng-click="showStationList()"><span>＜</span></div>
	                <div class="name">{{groupName}}-添加电站</div>
	            </div>
	            <div class="clearfix nav-con" ng-hide="addStations.length=='0'">
	            	<div class="pull-left check-box"><input type="checkbox" ng-model="addStationSelectAll"><span>全选</span></div>
	            	<div class="pull-right"><a class="saveStationBtn" ng-click="saveStations()">添加</a></div>
	            </div>
                <div ng-show="addStations.length=='0'" style="width: 180px;margin: 10px auto;">
                    <div class="circle">
						<img  src="./theme/images/power-index/non-group.png" style="margin: 28px 0 15px;"> 
						<p>暂无电站</p>
					</div>
                </div>
	            <ul class="station-list">
	            	<li class="clearfix" ng-repeat="item in addStations">
	            		<div class="pull-left"><input type="checkbox" ng-checked="addStationSelectAll" value={{item.id}} name="checkboxList"><span class="station-name">{{item.stationName}}</span></div>
	            	</li>
	            </ul>
			</div>
			<div ng-include="'/tpl/blocks/confirm.jsp'"></div>
		</div>
	</div>
</div>
<toaster-container toaster-options="{'position-class': 'toast-top-right', 'close-button':true}"></toaster-container>
<script type="text/javascript">

	app.controller('powerStationManageCtrl', function($scope, $rootScope, $http, $state, $stateParams, $location,toaster) {
		
		var hasGroup = 0;//有无分组，0无，1有
        var fromWhere = 0;//添加分组页面，点击取消时判断返回的页面是无分组页面，还是列表页面；0返回无分组
        var groupId = null;//当前groupId的值
        $scope.groupName = null;//当前groupName的值
        
        $scope.$on('confirmEvent', function(event,data) {
			if(data == "deleteGroup"){
				delGroups();
			}
        	if(data == "deleteStation"){
        		delStations();
        	}
        });
        
        //删除分组接口
        function delGroups(){
        	var checkValues = [];
            var $checkList = $("input[name = 'groupCheckList']");
            for(var i in $checkList){
                if($checkList[i].checked == true){
                    checkValues.push($checkList.eq(i).val());
                }
            }
        	$http({
                method : "POST",
                url : "/NECloud/userGroup/deleteGroup.htm",
                params : {
                    id:checkValues
                }
            })
            .success(function (msg) {
                if(msg.key=="0"){
                	toaster.pop("error", '', '网络错误');
                }else if(msg.key=="1"){
                	toaster.pop("error", '', '没有当前角色');
                }
                else if(msg.key=="2"){
                	toaster.pop("error", '', '此分组不能为空');
                }
                else if(msg.key=="3"){
                	toaster.pop("error", '', '删除失败');
                }
                else if(msg.key=="4"){
                	toaster.pop("success", '', '删除成功,重新登录后生效！');
                    $scope.showGroupList();
                }
            }).error(function(msg){

            });
        }
        //删除电站接口
        function delStations(){
        	var checkValues = [];
            var $checkList = $("input[name = 'stationCheckList']");
            for(var i in $checkList){
                if($checkList[i].checked == true){
                    checkValues.push($checkList.eq(i).val());
                }
            }
        	$http({
                method : "POST",
                url : "/NECloud/userGroup/deleteGroupRel.htm",
                params : {
                    groupId:groupId,
                    pStatIds:checkValues
                }
            })
            .success(function (msg) {
                if(msg.key=="0"){
                	toaster.pop("error", '', '网络错误');
                }else if(msg.key=="1"){
                	toaster.pop("error", '', '不存在该组');
                }else if(msg.key=="2"){
                	toaster.pop("error", '', '删除失败');
                }else if(msg.key=="3"){
                	toaster.pop("success", '', '删除成功,重新登录后生效！');
                    $scope.showStationList();
                }
            }).error(function(msg){

            });
        }
		function init(){
			//获取分组列表的数据
			$http({
				method : "POST",
				url : "/NECloud/userGroup/listGroup.htm"})
				.success(function (msg) {
					if(msg.data && msg.data.length>0){
						hasGroup = 1;
                        fromWhere = 1;
						$scope.groupList=msg.data;
					}else{
						hasGroup = 0;
                        fromWhere = 0;
					}
                    if(hasGroup){
                        $scope.showGroupList();
                    }else{
						$scope.showNonGroup();
    				}
				}).error(function(msg){
					
				});

		}

        //显示暂无分组页面
        $scope.showNonGroup = function(){
        	$(".sign").hide();
			$("#addGroup-con").show();
        }
        //获取分组列表的数据
        $scope.getGroups = function(){
            $http({
                method : "POST",
                url : "/NECloud/userGroup/listGroup.htm"})
            .success(function (msg) {
                if(msg.data && msg.data.length>0){
                    hasGroup = 1;
                    fromWhere = 1;
                    $scope.groupList=msg.data;
                }else{
                    hasGroup = 0;
                    fromWhere = 0;
                }
            }).error(function(msg){

            });
        }
        //获取电站列表数据
        $scope.stationList = function(){
            $http({
                method : "POST",
                url : "/NECloud/userGroup/listPStations.htm",
                params : {
                    groupId:groupId
                }
            })
            .success(function (msg) {
                $scope.stations=msg.data;
            }).error(function(msg){
            });
        };

        //获取可添加的电站列表数据
        $scope.getStations = function(){
        	$http({
        		method : "POST",
        		url : "/NECloud/userGroup/unGroupBPS.htm"
       		}).success(function (msg) {
       			$scope.addStations=msg.data;
       		}).error(function(msg){
       		});
        }

		//显示分组列表
		$scope.showGroupList = function(){
			$(".sign").hide();
			$("#group-list").show();
            $scope.getGroups();
		}
		//显示添加组
		$scope.addGroup = function(){
			$(".sign").hide();
			$("#add-group").show();
		} 
		//显示电站列表
		$scope.showStationList = function(id,name){
			$(".sign").hide();
			$("#station-list").show();
            if(id){
                groupId = id;$scope.groupName=name;
            }else{
                groupId = groupId;
            }
            $scope.stationList();//获取电站列表接口
		}
		//显示添加电站
		$scope.addStation = function(){
			$(".sign").hide();
			$("#add-station").show();
			$scope.getStations();//获取可添加的电站
		}
        //添加电站
        $scope.saveStations = function(){
            var checkValues = [];
            var $checkList = $("input[name = 'checkboxList']");
            for(var i in $checkList){
                if($checkList[i].checked == true){
                    checkValues.push($checkList.eq(i).val());
                }
            }
            if(checkValues.length<=0){
            	$(".confirm-con").show();
                $scope.$broadcast('childConfirm', '','single','请先选择');
                return;
            }
            $http({
                method : "POST",
                url : "/NECloud/userGroup/updateGroupRel.htm",
                params : {
                    groupId:groupId,
                    pStatIds:checkValues
                }
            })
            .success(function (msg) {
                if(msg.key=="0"){
                	toaster.pop("error", '', '网络错误');
                }else if(msg.key=="1"){
                	toaster.pop("error", '', '不存在该组');
                }else if(msg.key=="2"){
                	toaster.pop("error", '', '用户当前无电站权限');
                }else if(msg.key=="3"){
                	toaster.pop("error", '', '新增失败');
                }else if(msg.key=="4"){
                	toaster.pop("success", '', '添加成功,重新登录后生效！');
                    $scope.showStationList();
                }
            }).error(function(msg){

            });
        }
        //批量删除分组
        $scope.deleteGroups = function(){
            var checkValues = [];
            var $checkList = $("input[name = 'groupCheckList']");
            for(var i in $checkList){
                if($checkList[i].checked == true){
                    checkValues.push($checkList.eq(i).val());
                }
            }
            if(checkValues.length<=0){
            	$(".confirm-con").show();
                $scope.$broadcast('childConfirm', 'deleteGroup','single','请先选择');
                return;
            }
            //弹出框
            $(".confirm-con").show();
            $scope.$broadcast('childConfirm', 'deleteGroup','double','确认删除所选组？');
        }
        
        //批量删除电站
        $scope.deleteStations = function(){
            var checkValues = [];
            var $checkList = $("input[name = 'stationCheckList']");
            for(var i in $checkList){
                if($checkList[i].checked == true){
                    checkValues.push($checkList.eq(i).val());
                }
            }
            if(checkValues.length<=0){
            	$(".confirm-con").show();
                $scope.$broadcast('childConfirm', 'deleteStation','single','请先选择');
                return;
            }
          	//弹出框
            $(".confirm-con").show();
            $scope.$broadcast('childConfirm', 'deleteStation','double','确认删除所选电站？');
        }
        //确定按钮，添加分组接口
        $scope.save = function(){
        	var validValue = $scope.addGroupName;
        	if(validValue == "" || validValue == null || validValue == undefined){
        		toaster.pop("新建组名称不能为空");return;
        	}
        	$.post("/NECloud/userGroup/updateGroup.htm", {
    			groupName:$scope.addGroupName
    		},function(msg){
    			if(msg.key=="4" || msg.key=="6"){
    				toaster.pop("success", '', '操作成功,重新登录后生效！');
                    fromWhere = 1;
                    $scope.showGroupList();
    			}else{
    				toaster.pop("error", '',msg.msg);
    			}
    		});
        }
        //取消按钮，显示列表或者无分组标识
        $scope.cancel = function(){
            if(fromWhere == 1){
                $scope.showGroupList();
            }else{
                $(".sign").hide();
                $("#addGroup-con").show();
            }
        }

		window.addEventListener("resize", function() {
			responseHeight();
		});
		function responseHeight(){
            $("#model-container").css("top", ($(window).height() -275)/2);
		}
		//初始化页面
		init();
		responseHeight(); 
	});
</script>
