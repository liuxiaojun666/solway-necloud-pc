<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
	function goPage(pageIndex) {
		$("#searchBtn").trigger("click");
	}
	
	function selectUpdate(opreate,ids) {
		if(null==ids||""==ids){
			promptObj('error', '', '请至少选择一条用户');
			goPage(0);
		}
		
		//批量删除
		if (opreate == 0) {
			if (confirm("确定要删除这些用户吗?")) {
				var options = {
					type : "post",
					dataType : "json",
					url : "${ctx}/AdminUser/deleteBatch.htm?"
							+ ids,
					success : function(json) {
						promptObj('success', '', json.message);
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"删除失败");
					}
				};
				$.ajax(options);
			}
		}

		//批量锁定 批量注销 [&Un]
		if (opreate == 1 || opreate == 2 || opreate == 3 || opreate == 4) {
				var asktext;
				switch(opreate){
					case 1:
						asktext = "确定要锁定这些用户吗?"
						break;
					case 2:
						asktext = "确定要解锁这些用户吗?"
						break;
					case 3:
						asktext = "确定要注销这些用户吗?"
						break;
					case 4:
						asktext = "确定要激活这些用户吗?"
						break;
					default:
						asktext = "确定要执行这些用户吗?"
				}
		if (confirm(asktext)) {
			if (ids.split('&').length==1||confirm(asktext)) {
				var options = {
					type : "post",
					dataType : "json",
					url : "${ctx}/AdminUser/updateStateBatch.htm?"+
							"opreate="+opreate+"&"
							+ ids,
					success : function(json) {
						promptObj('success', '', json.message);
						goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"执行失败");
					}
				};
				$.ajax(options);
			}
		}
		}

	}
	function deleteBatch() {
		var conti = checkSelectMsg("ids", "请至少选择一条用户!");
		if (conti) {
			conti = confirm("确定要删除这些用户吗?");
		}
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/AdminUser/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
					promptObj('success', '', json.message);
					goPage(0);
				},
				error : function(json) {
					promptObj('error', '',"删除失败");
				}
			};
			$.ajax(options);
		}
	}

	function deleteRow(id) {
		if (confirm("确定要删除这条数据吗？")) {
			singledel(id);
		}
	}
	function singledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/AdminUser/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '', json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}

	app.controller('userInformationCtrl', function($scope, $http, $state) {
		getStation("");
		$scope.createManufacturer = function(id, name) {
			$state.go("app.addUserInformation", {
				manId : id
			});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.editData = function(id, modalId) {
			editData(id, modalId);
		}
		$scope.editAuthority =  function(id, modalId) {
			//editData(id, modalId);
			initAuthorityPageData(id);
			showModal(modalId);
		}
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if (!page) {
				page = 1;
				$scope.currentPage = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/AdminUser/userInformationList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					userType : $scope.userTypeS,
					userName : $scope.userNameS,
					pstationid : $scope.pstationidS,
					keyWords : $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope, result);
			});
		};
		//get first page
		$scope.onSelectPage(1);
	});

	function getStation(parentId, stationcode) {
		/* $("#pstationidS").empty();
		$.ajax({
			type : "post",
			url : "${ctx}/PowerStation/selectByParentId.htm",
			data : {
				"parentId" : parentId
			},
			dataType : "json",
			async : false,
			success : function(msg) {
				$("#pstationidS").append("<option value=''>请选择</option>");
				for (var i = 0, len = msg.length; i < len; i++) {
					var op = "<option value='" + msg[i].id + "'";
					if (stationcode != null && msg[i].id == stationcode) {
						op += " selected='selected' ";
					}
					op += ">" + msg[i].stationname + "</option>";
					$("#pstationidS").append(op);
				}
			}
		}); */
	}
</script>
<style type="text/css">
.table .t_center{text-align:center;}
.table .t_right{text-align:right;}
.table .t_left{text-align:left;}
</style>
<!-- 弹出层界面 -->
<div id="userInformationEdit"
	data-ng-include="'${ctx}/tpl/systemPage/userInformation/addUserInformation.jsp'"></div>
<div id="UserInformationAuthority"
	data-ng-include="'${ctx}/tpl/systemPage/userInformation/userInformationAuthority.jsp'"></div>	
	
<div ng-controller="userInformationCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">用户信息 </span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-4 m-b-xs p-r-sm" style="width: 100px;">
					<button class="btn btn-sm btn-info m-r-xs"
						onclick="addData('userInformationModal');">新增</button>
					<!-- <select class="input-sm form-control w-sm inline v-middle"
						id="opreate">
						<option value="0">批量删除</option>
						<%-- <option value="1">批量锁定</option> --%>
						<%-- <option value="2">批量解锁</option> --%>
						<option value="3">批量注销</option>
						<%-- <option value="4">批量激活</option> --%>
					</select> 
					<button class="btn btn-sm btn-default" onclick="selectUpdate($('#opreate').val(),$('input[name=ids]:checked').serialize());">执行</button>-->
				</div>
				<div class="col-sm-3 no-padder">
					<div class="col-sm-9 no-padder ">
						<div class="input-group p-r-sm">
							<input type="text" ng-model="keyWords" id="keyWords"
								class="input-sm form-control" placeholder="关键字"> <span
								class="input-group-btn">
								<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);"
									type="button">查询</button>
							</span>
						</div>
					</div>
					<a class="col-sm-3 text-info no-padder cwsearch"
						onclick="showSearch()"> <span class="searchTitle "><button
								class="btn btn-sm  btn-default">更多查询</button></span></a>
				</div>
				<div class="col-sm-5 pull-right">
					<%@ include file="/common/pager.jsp"%></div>
			</div>
			<div class="row hideSearchDiv wrapper">
				<div class="col-sm-2">
					<div class="input-group">
						<span class="input-group-btn">
							<button class="btn btn-sm btn-default" type="button">账号</button>
						</span> <input type="text" class="input-sm form-control" id="userNameS"
							name="userNameS" ng-model="userNameS">
					</div>
				</div>
				<div class="col-sm-1">
					<button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
				</div>
			</div>


			<div>
				<paging class="col-sm-12 panel no-padder">
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th style="width: 20px;"><label class="i-checks m-b-none">
									<input type="checkbox" id="all"
									onclick="changeAll(this.checked,'ids');" /><i></i>
							</label></th>
							<th class="t_center">账号</th>
							<th class="t_center">真实姓名</th>
							<th class="t_center">所属公司</th>
							<th class="t_center">上次登录时间</th>
							<th class="t_center">邀请状态</th>
							<th class="t_center">状态</th>
							<th class="t_center">操作</th>

						</tr>
					</thead>
					<tbody>

						<tr ng-repeat="vo in data ">
							<td><label class="i-checks m-b-none"> <input
									type="checkbox" name="ids" id="ids" value="{{vo.userId }}" />
									<i></i>
							</label></td>
							<td class="t_left" ng-if="vo.userId!='1'" ng-bind="vo.userName"></td>
							<td class="t_center" ng-if="vo.userId=='1'"></td>
							<td class="t_left" ng-bind="vo.realName"></td>
							<td class="t_center" ng-bind="vo.companyName"></td>
							<td class="t_center" ng-bind="vo.lastLoginTime"></td>
							<td class="t_center" ng-bind="vo.invitestatus"></td>
							<td class="t_center" ng-bind="vo.useStatus">-</td>
							<td class="t_center">
								<!-- <a class="text-info"><i class="icon-note"
									ng-click="editData({{ vo.userId }},'userInformationModal');"></i></a> 
								<a class="text-info"><i class="icon-trash"
									ng-click="deleteRow({{vo.userId}});"></i></a>-->
								<a class="text-info"><i class="icon-user-following"
									ng-click="editAuthority({{vo.userId}},'usereditAuthority');"></i></a>
								<a class="text-info" ng-if="vo.isLocked=='1' && vo.userId!=${sessionScope.USER.userId}"  
									onclick="selectUpdate(2,'ids='+$(this).parent().siblings().find('input[name=ids]').val());">
									<i class="icon-lock" style="color: #f27136"></i></a>
								<a class="text-info m-r-xs" ng-if="vo.isLocked=='0'&& vo.userId !=${sessionScope.USER.userId}" 
									onclick="selectUpdate(1,'ids='+$(this).parent().siblings().find('input[name=ids]').val());">
									<i class="icon-lock-open"/></a>
							</td>
						</tr>
					</tbody>
				</table>
				</paging>
			</div>
			</paging>
		</div>
	</div>
</div>
