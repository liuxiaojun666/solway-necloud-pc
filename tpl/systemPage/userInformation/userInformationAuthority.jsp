<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
    <script type="text/javascript">      
	
	//初始化页面数据
	function initAdminUser(id,array){
		 $.ajax({
			type: "post",
			url: "${ctx}/AdminUser/queryAuthWaitStation.htm",
			data: {"userId":id},
			success:function(result){
				if(result.key == 0){
					if(result.data == null) return;
					//初始化清空select值
					document.getElementById("select1").options.length = 0;
					var data = result.data;
					for(var i= 0, ii=data.length; i<ii; i++){
						var uid =data[i].id;
						if(array.indexOf(uid)==-1){
							$("#select1").append("<option value="+uid+">"+data[i].stationName+"</option>");
						}
					}
				}
			}
		});
	}
	
	//初始化数据
	var user_id;
	var arr;
	function initAuthorityPageData(id){
		user_id=id;
		initRole();
		$.ajax({
			type:"post",
			url:"${ctx}/AdminUser/queryAuthStation.htm",
			data:{"userId":user_id},
			success:function(result){
				console.log(result)
				if (result.key == 0){
					//初始化清空select值
					document.getElementById("select2").options.length = 0;
					//遍历数据,并把数据存入集合
					var data = result.data;
					if (data != null && data.length > 0){
						arr = new Array();
						for(var i= 0,ii=data.length; i<ii;i++){
							arr[i] = data[i].id;
							$("#select2").append("<option value="+data[i].id+">"+data[i].stationName+"</option>");
						}
					}
					var array=getselect();
					initAdminUser(id, array);
				}else {
					alert("数据初始化失败");
				}
			},
			error : function(result) {
				promptObj('success', "数据初始化错误");
			}
		});
	}
	
	//获取下拉框选中值
	function getselect(){
		var obj = document.getElementById("select2");
		var array=new Array();
		for(var i=0;i<obj.options.length;i++){
			array[i]=obj.options[i].value
		}
		return array;
	}
	
	//保存数据
	function saveSelected(){
		var roleId = $("#roleId").val();
		if (roleId == null || roleId == ''){
			alert("请选择角色");
			return;
		}
		var pStationid=getselect();
		if (pStationid == null || pStationid.length == 0){
			alert("请选择授权电站");
			return;
		}
		$.ajax({
			type:"post",
			url:"${ctx}/AdminUser/saveStationidid.htm",
			dataType : "json",
			async: false,
			data: {
				'pstationid': pStationid.join(","),
				'userId':user_id,
				'roleId': roleId
			},
			success:function(result){
				if (result.key == 0){
					promptObj('success','',result.msg);
					hideModal('usereditAuthority');
					return;
				}
				promptObj('error','',result.msg);
				hideModal('usereditAuthority');
			},
			error : function(result) {
				promptObj('success',"保存失败");
				hideModal('usereditAuthority');
			}
		})
	}
	
	//保存数据
	function deleteSelected(){
		$.ajax({
			type:"post",
			url:"${ctx}/AdminUser/deleteStationidid.htm",
			dataType : "json",
			async: false,
			data: {
				'userId':user_id,
			},
			success:function(result){
				if (result.key == 0){
					promptObj('success','',result.msg);
					hideModal('usereditAuthority');
					return;
				}
				promptObj('error','',result.msg);
				hideModal('usereditAuthority');
			},
			error : function(result) {
				promptObj('success',"保存失败");
				hideModal('usereditAuthority');
			}
		})
	}
	
	$(function(){	
		//移到右边
		$('#add').click(function(){
			//先判断是否有选中
			if(!$("#select1 option").is(":selected")){			
				alert("请选择需要移动的选项")
			}
			//获取选中的选项，删除并追加给对方
			else{
				$('#select1 option:selected').appendTo('#select2');
			}	
		});
		
		//移到左边
		$('#remove').click(function(){
			//先判断是否有选中
			if(!$("#select2 option").is(":selected")){			
				alert("请选择需要移动的选项")
			}
			else{
				$('#select2 option:selected').appendTo('#select1');
			}
		});
		
		//全部移到右边
		$('#add_all').click(function(){
			//获取全部的选项,删除并追加给对方
			$('#select1 option').appendTo('#select2');
		});
		
		//全部移到左边
		$('#remove_all').click(function(){
			$('#select2 option').appendTo('#select1');
		});
		
		//双击选项
		$('#select1').dblclick(function(){ //绑定双击事件
			//获取全部的选项,删除并追加给对方
			$("option:selected",this).appendTo('#select2'); //追加给对方
		});
		
		//双击选项
		$('#select2').dblclick(function(){
			$("option:selected",this).appendTo('#select1');
		});
		
	});

var initRole;
app.controller("usereditAuthCtrl", function($scope, $http){
	$scope.roled = {};
	$scope.roles = null;
	$("#roleId").val(null);
	$scope.roled.selected = {roleName: null, roleId: null};
	initRole = $scope.initRole = function(){
		$http({
			method : "POST",
			url : "${ctx}/AdminUser/queryAuthRole.htm",
			params : {
				'userId': user_id
			}
		}).success(function(result) {
			console.log(result)
			if (result.key == 0){
				$scope.roles = result.data;
				if ($scope.roles != null && $scope.roles.length > 0){
					for (var i in $scope.roles){
						if ($scope.roles[i].flag == 1){
							$scope.roled.selected = {roleName: $scope.roles[i].roleName, roleId: $scope.roles[i].roleId};
							$("#roleId").val(angular.copy($scope.roled.selected.roleId));
							break;
						}
					}
				}
			}
		});
	};

	$scope.roleChange = function(){
		$("#roleId").val(angular.copy($scope.roled.selected.roleId));
	};
});
</script>
<div  class="modal fade" id="usereditAuthority" ng-controller="usereditAuthCtrl" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
	<div id="row">
		<div class="form-group  col-sm-12">
			<label class="col-lg-2 control-label" style="padding-top: 10px;">角色</label>
			<div class="col-lg-5">
				<ui-select ng-model="roled.selected" theme="bootstrap" ng-change="roleChange()">
					<ui-select-match placeholder="请输入关键字..." ng-model="roled.selected.roleName">
						{{$select.selected.roleName}}
					</ui-select-match>
					<ui-select-choices repeat="item in roles | filter: $select.search">
						<div ng-bind-html="item.roleName | highlight: $select.search"></div>
					</ui-select-choices>
				</ui-select>
			</div >
			<input type="hidden" id="roleId" />
		</div>
	</div>
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">电站管理权限设置</span>
      <div class="panel-body">
		  <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/AdminUser/updateData.htm" method="post" id="editForm2" name="editForm2">
			<!--开始-->
			<div class="selectbox col-sm-12" >
				<div class="select-bar col-sm-4">
					<div >电站待授权</div>
					<select multiple="multiple" id="select1" style="height: 200px; width:130px "></select>
				</div>

				<div class="btn-bar col-sm-2" style="margin: 30px;">
					<p><span id="add"><input type="button" class="btn" style="width:40px;" value=">" title="移动选择项到右侧"/></span></p>
					<p><span id="add_all"><input type="button" class="btn" style="width:40px;" value=">>" title="全部移到右侧"/></span></p>
					<p><span id="remove"><input type="button" class="btn" style="width:40px;" value="<" title="移动选择项到左侧"/></span></p>
					<p><span id="remove_all"><input type="button" class="btn" style="width:40px;" value="<<" title="全部移到左侧"/></span></p>
				</div>
				<div class="select-bar col-sm-4">
					<div >电站已授权</div>
					<select multiple="multiple" id="select2" style="height: 200px; width:130px "></select>
				</div>
			</div>
			<!--结束-->
			<div class="form-group" >
				<div class="col-lg-offset-2 col-lg-10" style="margin-top:25px">
					<button type="button"  id="cancelBtn" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
					<button type="button" onclick="saveSelected();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
					<button type="button"  onclick="deleteSelected();" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"><strong>删除</strong></button>
				</div>
			</div>
          </form>
        </div>
    </div>
  </div>
</div>
</div>
</div>
</div>
