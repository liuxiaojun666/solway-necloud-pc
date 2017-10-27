<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.tree_info table tr th,.tree_info table tr td {text-align: center;}
	.table .dropdown-toggle {border: none;box-shadow: none;}
	.app-content > .app-content-full {bottom: 0;}
</style>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/tmpl/jquery.tmpl.min.js"></script>
<div ng-controller="managePersonCtrl"  class="hbox hbox-auto-xs bg-light">
	<div class="app-content-full" style="top:0px;bottom: 0px">
		<div class="hbox hbox-auto-xs hbox-auto-sm">
			<div class="col tree_wrap">
				<div class="vbox">
					<div class="font-h3 menu_text text-center">部门结构树</div>
					<div class="row-row">
						<div class="cell">
							<div class="cell-inner">
								<ul class="tree_manage" id="departmentTree">

								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col lter tree_info">
				<div class="vbox">
					<div class="row-row">
						<div class="cell">
							<div class="cell-inner">
								<div class="wrapper-md">
									<div class="panel panel-default">
										<paging class="col-sm-12 panel no-padder">
											<div class="row wrapper">
												<button type="button" id="invitePersonBtn" class="btn btn-sm btn-info ml15">邀请人员</button>
												<div class="pull-right mr15">
													<%@ include file="/common/pager.jsp"%>
												</div>
											</div>
											<table class="table text-center table-striped b-t b-light">
												<thead>
													<tr>
														<th>姓名</th>
														<th>账号</th>
														<!-- <th>联系电话</th> -->
														<th>邀请时间</th>
														<th>邀请状态</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody id="personTable">
													<tr ng-repeat="vo in data">
														<td ng-bind="vo.realname"></td>
														<td ng-bind="vo.userName"></td> 
														<!-- <td ng-bind="vo.phone"></td>-->
														<td ng-bind="vo.invitetime"></td>
														<td ng-bind="vo.invitestatus"></td>
														<td width="15%" style="text-align: left !important;">
															<a ng-show="currentUserId != vo.userid" class="text-danger ml5 person_del" href="javascript:;" data-id="{{vo.id}}">删除</a>
															<!-- <a ng-show="{{vo.istautsNum=='01'}}" class="text-success ml5 modifyAuthBtn" data-realname="{{vo.realname}}"
															data-username="{{vo.phone}}" data-id="{{vo.id}}" href="javascript:;">修改</a> -->
															<a ng-show="vo.istautsNum=='01'" class="text-success ml5 rootAuthBtn" data-realname="{{vo.realname}}"
															data-username="{{vo.phone}}" data-id="{{vo.id}}" href="javascript:;">授权</a>
															<a class="text-success ml5 recallAuthBtn" ng-show="vo.istautsNum=='00' && 0 == 1" data-id="{{vo.id}}">撤回</a>
														</td>
													</tr>
												</tbody>
											</table>
										</paging>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input id="selectPageClick" type="hidden" ng-click="onSelectPage(1)">
</div>
<!-- 邀请人员弹出 -->
<div data-ng-include="'${ctx}/tpl/systemPage/companyDepartment/invitePersonPop.jsp'"></div>
<!-- 邀请人员弹出 END -->
<!-- 授权人员弹出 -->
<div data-ng-include="'${ctx}/tpl/systemPage/companyDepartment/rootPersonPop.jsp'"></div>
<!-- 授权人员弹出 END -->

<!-- 已选择角色、电站模板 -->
<script id="invitePersonTmpl" type="text/x-jquery-tmpl">
	<tr>
		<td width="40%" style="padding: 5px 0;">
			<div class="col-sm-4">
				<span class="dropdown">
					<button type="button" class="btn btn-default dropdown-toggle toggle-one" data-toggle="dropdown">
						{{each(i,role) dataRole}}
							{{if role.checked==1}}
								<span class="toggle-cur">{{= role.roleName}}</span>
								<span class="caret"></span>
							{{/if}}
						{{/each}}
					</button>
					<ul class="dropdown-menu animated fadeInRight dropdown-menu-left dropdown-one">
						{{each(i,role) dataRole}}
							<li data-roleId="{{= role.roleId}}" {{if role.checked==1}}class="active"{{/if}}>
								<a href="javascript:;">{{= role.roleName}}</a>
							</li>
						{{/each}}
					</ul>
				</span>
			</div>
			<div class="col-sm-8">
				<span class="dropdown col-sm-6">
					<button type="button" class="btn btn-default dropdown-toggle toggle-multi" data-toggle="dropdown">
						<span class="toggle-cur">已选{{= groupLen}}个电站组</span>
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu animated fadeInRight dropdown-menu-left multi-group dropdown-multi">
						{{each(i, group) dataGroup}}
							<li data-id="{{= group.id}}" {{if group.checked==1}}class="active"{{/if}}">
								<a href="javascript:;">{{= group.groupName}}</a>
							</li>
						{{/each}}
					</ul>
				</span>
				<span class="dropdown col-sm-6">
					<button type="button" class="btn btn-default dropdown-toggle toggle-multi" data-toggle="dropdown">
						<span class="toggle-cur">已选{{= stationLen}}个电站</span>
						<span class="caret"></span>
					</button>
					<ul class="dropdown-menu animated fadeInRight dropdown-menu-left multi-one dropdown-multi">
						{{each(i, station) dataStation}}
							<li data-id="{{= station.id}}" {{if station.checked==1}}class="active"{{/if}} data-flag="{{= station.flag}}">
								<a href="javascript:;">{{= station.stationName}}</a>
							</li>
						{{/each}}
					</ul>
				</span>
			</div>
		</td>
		<td class="text-center" width="15%">
			<a href="javascript:;">待发送</a>
		</td>
		<td class="text-center del_row" width="10%"><a href="javascript:;">删除</a></td>
	</tr>
</script>

<!-- 角色列表模板 -->
<script id="roleListTmpl" type="text/x-jquery-tmpl">
	{{each(i, d) data}}
		<li data-roleId="{{= d.roleId}}"><a href="javascript:;">{{= d.roleName}}</a></li>
	{{/each}}
</script>

<!-- 电站列表模板 -->
<script id="stationListTmpl" type="text/x-jquery-tmpl">
	{{each(i, d) stations}}
		<li data-id="{{= d.id}}" data-flag="{{= d.flag}}"><a href="javascript:;">{{= d.stationName}}</a></li>
	{{/each}}
</script>

<!-- 电站组列表模板 -->
<script id="stationGroupListTmpl" type="text/x-jquery-tmpl">
	{{each(i, d) groupStations}}
		<li data-id="{{= d.id}}"><a href="javascript:;">{{= d.groupname}}</a></li>
	{{/each}}
</script>

<script>
	var depid = null;
	app.controller('managePersonCtrl', function($scope, $http, $state) {
		
		$scope.getCurrentInfo = function() {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm"
			}).success(function(msg) {
				console.log(msg.currentUserId)
				$scope.currentUserId = msg.currentUserId;
			})
		};
		$scope.getCurrentInfo();
		$scope.angulartest = 'adf';
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if (!page) {
				page = 1;
				$scope.currentPage = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/authComUserRel/listInfo.htm",
				params : {
					pageIndex : page - 1,
					pageSize : $scope.pageSizeSelect,
					depid: depid
				}
			}).success(function(result) {
				getTableData($scope, result);
			});
		};
		$scope.onSelectPage(1);
	});

	//邀请人员弹出
	$('#invitePersonBtn').click(function(event) {
		var nodes = zTreeObj.getSelectedNodes(),
		treeNode = nodes[0];
		var $addTr;
		if (nodes.length == 0) {
			alert("请先选择一个节点");
			return;
		}
		$('#invitePersonPop').modal();
		$('#invitePersonTable').empty();
		$.ajax({
			url: '${ctx}/authComUserRel/deptListRole.htm',
			type: 'POST',
			data: {
				depId: 0 //treeNode.id
			}
		})
		.done(function(res) {//0 网络错误
			if (res.key==1) {
				$('#invitePersonRow .dropdown-one').empty();
				$("#roleListTmpl").tmpl(res).appendTo($("#invitePersonRow .dropdown-one"));

				$.ajax({
					url: '${ctx}/authComUserRel/pStidsList.htm'
				})
				.done(function(res) {//0 网络错误
					if (res.key==1) {
						$('#invitePersonRow .dropdown-multi').empty();
						$("#stationListTmpl").tmpl(res.data).appendTo($("#invitePersonRow .multi-one"));
						$("#stationGroupListTmpl").tmpl(res.data).appendTo($("#invitePersonRow .multi-group"));
						$('#invitePersonTable').attr('data-deptid',treeNode.id).append($('#invitePersonRow').clone().removeAttr('id'))
					}
				})
				.fail(function() {
					console.log("error");
				});
			}
		})
		.fail(function() {
			console.log("error");
		});
	});

	//修改邀请人员弹出
	$('#personTable').on('click', '.rootAuthBtn', function(event) {
		var nodes = zTreeObj.getSelectedNodes(),
		treeNode = nodes[0];
		//$('#rootPersonTable tr:gt(0)').remove();
		$('#rootPersonPop').modal();
		$('#rootPersonPop').attr('data-id', $(this).attr('data-id'));
		$.ajax({
			url: '${ctx}/authComUserRel/editAuthComUserRel.htm',
			data: {id: $(this).attr('data-id')}
		})
		.done(function(res) {
			if (res.data == null) return;
			if(res.data){
				$('#curPerson_name').text(res.data.realname);
				$('#curPerson_user').text(res.data.phone);
			}else {
				$('#curPerson_name').text('');
				$('#curPerson_user').text('');
			}

			$("#rootPersonTable").empty();

			if (!res.data.aursrRoles || res.data.aursrRoles.length == 0){
				//$("#rootadd_row").click();
				return;
			}

			var data;
			for(var i= 0,ii=res.data.aursrRoles.length;i<ii;i++){
				data = {};
				data.dataRole = res.data.aursrRoles[i].roleIdList;
				data.dataStation = res.data.aursrRoles[i].aursrs;
				data.dataGroup = res.data.aursrRoles[i].authUserRoleGroupStationRels;
				data.stationLen = 0;
				if(data.dataStation != null){
					for(var j=0, jj=data.dataStation.length;j<jj;j++){
						if(data.dataStation[j].checked == 1){
							data.stationLen += 1;
						}
					}
				}

				data.groupLen = 0;
				if(data.dataGroup != null){
					for (var j= 0,jj=data.dataGroup.length;j<jj;j++){
						if(data.dataGroup[j].checked == 1){
							data.groupLen += 1;
						}
					}
				}

				$("#invitePersonTmpl").tmpl(data).appendTo($("#rootPersonTable"));
			}
		})
		.fail(function() {
			console.log("error");
		});


		$.ajax({
			url: '${ctx}/authComUserRel/deptListRole.htm',
			type: 'POST',
			data: {
				depId: 0 //treeNode.id
			}
		})
		.done(function(res) {//0 网络错误
			if (res.key==1) {
				$('#rootPersonRow .dropdown-one').empty();
				$("#roleListTmpl").tmpl(res).appendTo($("#rootPersonRow .dropdown-one"));
				$.ajax({
					url: '${ctx}/authComUserRel/pStidsList.htm'
				})
				.done(function(res) {//0 网络错误
					if (res.key==1) {
						$('#rootPersonRow .dropdown-multi').empty();
						$("#stationListTmpl").tmpl(res.data).appendTo($("#rootPersonRow .multi-one"));
						$("#stationGroupListTmpl").tmpl(res.data).appendTo($("#rootPersonRow .multi-group"));
					}
				})
				.fail(function() {
					console.log("error");
				});
			}
		})
		.fail(function() {
			console.log("error");
		});
	});

	//删除人员
	$('#personTable').on('click', '.person_del' , function() {
		var $this = $(this);
		$.ajax({
			url: '${ctx}/authComUserRel/deleteAuthComUserRel.htm',
			type: 'POST',
			data: {
				id: $(this).attr('data-id')
			},
		})
		.done(function(res) {//0 网络错误
			console.log(res.key)
			if (res.key==1){
				console.log('删除失败');
				promptObj('error', '', '删除失败');
			} else if(res.key==2){
				console.log('删除成功');
				promptObj('success', '', '删除成功');
				$this.parent().parent().remove();
			}
		})
		.fail(function() {
			console.log("error");
		});
	});

	//撤回人员
	$('#personTable').on('click', '.recallAuthBtn' , function() {
		var $this = $(this);
		$.ajax({
			url: '${ctx}/authComUserRel/recallAuthComUserRel.htm',
			type: 'POST',
			data: {
				id: $(this).attr('data-id')
			},
		})
		.done(function(res) {//0 网络错误，1 撤回失败, 2 撤回成功
			console.log(res.key)
			if (res.key==1){
				console.log('撤回失败');
				promptObj('error', '', '撤回失败');
			} else if(res.key==2){
				console.log('撤回成功');
				promptObj('success', '', '撤回成功');
				$('.curSelectedNode').trigger('click');
			};
		})
		.fail(function() {
			console.log("error");
		});
	});

	var zTreeObj, newCount = 1, CountId = 0;
	var setting = {
			view: {
				//addHoverDom: addHoverDom,
				//removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
			edit: {
				//drop: {
					//isCopy: false,
					//isMove: false
				//},
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeDrag: zTreeBeforeDrag,
				beforeDrop: zTreeBeforeDrop,
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove,
				onRename: onRename,
				onNodeCreated: onNodeCreated,
				onCheck: onCheck,
				onClick: onClick
			}
	};
	//初始化部门树
	$.ajax({
		url: '${ctx}/authDepartment/initDepartmentData.htm'
	})
	.done(function(res) {
		if (res.key==1) {
			var zNodes = res.data;
			$.fn.zTree.init($("#departmentTree"), setting, zNodes);
			zTreeObj = $.fn.zTree.getZTreeObj("departmentTree")
			$('#departmentTree li:first > a').trigger('click');
			$('#departmentTree li:first > a').trigger('dblclick');
			for (var i = 0; i < zNodes.length; i++) {
				if (CountId < zNodes[i].id){
					CountId = zNodes[i].id;
				}
			};
		}
	})
	.fail(function() {
		console.log("初始化数据失败error");
	});

	$('#departmentTree').on('click', '.button', function(event) {
		$(this).parent('a').trigger('dblclick');
	});

	function onClick(event, treeId, treeNode, clickFlag){
		//console.log(treeNode.id+ ", " +treeNode.tId + ", " + treeNode.name);
		depid = treeNode.id;
		$('#selectPageClick').trigger('click');
		// $.ajax({
		// 	url: '${ctx}/authComUserRel/listInfo.htm',
		// 	data: {depid: treeNode.id},
		// })
		// .done(function(res) {
		// 	var showList = res.data;
		// 	for (var i = 0; i < showList.length; i++) {
		// 		$('#roleTable').append($tr);
		// 	};
		// })
		// .fail(function() {
		// 	console.log("error");
		// });
	};


	function zTreeBeforeDrag(treeId, treeNodes) {
		return false;
	};
	function zTreeBeforeDrop(treeId, treeNodes) {
		return false;
	};

	function beforeEditName(treeId, treeNode) {
		return true;
	}

	function beforeRemove(treeId, treeNode) {
		if(!confirm("确定删除此节点吗？")) return false;
		if(treeNode.children && treeNode.children.length > 0){
			alert("此节点存在下级分类，不能删除");
			return false;
		}

		$.post("${ctx}/shareClassifyTree/selectShareRepos.htm",{
			'id' : treeNode.id
		},
		function(result, status){
			if(result.key != 0){
				if(result.count && result.count > 0){
					if(!confirm("删除此分类后，此分类相关的文章将被归为未分类，确定删除此节点吗？"))
						return false;
					deleteNode(treeNode);
				}
				deleteNode(treeNode);
				return;
			}
			promptObj('error', '',"删除失败");
			zTreeObj.refresh();
		});
		return false;
	};

	function beforeRename(treeId, treeNode, newName, isCancel) {
		return true;
	}
	function onRemove(e, treeId, treeNode, isCancel){
		return true;
	}
	function onRename(e, treeId, node, isCancel) {
		if(node && node.flag=="0"){
			saveSingleData(node);
			return true;
		}
		renameNodeName(node);
		return true;
	}
	function onNodeCreated(e, treeId, node){
		return true;
	}
	function showRemoveBtn(treeId, treeNode) {
		return true;
	}
	function showRenameBtn(treeId, treeNode) {
		return true;
	}

	function onCheck(event, treeId, treeNode){
		$("#watchType").val(treeNode.id);
		$("#watchType").trigger("click");
	}

	function deleteNode(node){
		$.post("${ctx}/shareClassifyTree/deleteNode.htm",{
			'id' : node.id
		},
		function(result, status){
			if(result.key != '0'){
				zTreeObj.removeNode(node);
				initTree(result.treeData);
				promptObj('success', "","删除成功");
				return;
			}
			zTreeObj.refresh();
			promptObj('error', "","删除失败");
		});
	}

	function renameNodeName(node){
		var info = {};
		info.id = node.id;
		info.pId = node.pId;
		info.name = node.name;
		$.post("${ctx}/shareClassifyTree/renameNodeName.htm",{
			'node' : JSON.stringify(info)
		},
		function(result, status){
			if(result.key != 0){
				initTree(result.treeData);
				promptObj('success', "","保存成功");
				return;
			}
			promptObj('error', '',"保存失败");
			zTreeObj.refresh();
		});
	}

	function saveSingleData(node){
		var info = {};
		info.id = node.id;
		info.pId = node.pId;
		info.name = node.name;
		$.post("${ctx}/shareClassifyTree/saveSingleData.htm",{
			'node' : JSON.stringify(info)
		},
		function(result, status){
			if(result.key != 0){
				initTree(result.treeData);
				promptObj('success', "","保存成功");
				return;
			}
			promptObj('error', '',"保存失败");
			zTreeObj.refresh();
		});
	}

	function initTree(data){
		data = setParentData(data);
		var id = $("#watchType").val();
		if(id){
			data = setCheckedFlag(setNoCheckedFlag(data), id);
			data = setOpenTreeById(data, id);
		}
		zTreeObj = $.fn.zTree.init($("#classifyTree"), setting, setSelectedOpenTree(data));
		newCount = getTreeLastId(data);
	}

	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='addnode' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			var zTree = $.fn.zTree.getZTreeObj("classifyTree");
			var newNode = zTree.addNodes(treeNode, {id:++newCount, flag:"0", pId:treeNode.id, name:"新分类"}, false);
			zTree.editName(newNode[0]);
			return false;
		});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};

	function setNoCheckedFlag(arr){
		(function setFlag(arr){
			for(var i=0,ii=arr.length;i<ii;i++){
				var _obj = arr[i];
				_obj.checked = false;
				if(_obj.children){
					setFlag(_obj.children);
				}
			}
		})(arr);
		return arr;
	}

	function setCheckedFlag(arr, id){
		(function setFlag(arr, id){
			for(var i=0,ii=arr.length;i<ii;i++){
				var _obj = arr[i];
				if(_obj.id == id){
					_obj.checked = true;
					_obj.parent = 1;
				}else{
					if(_obj.children){
						setFlag(_obj.children, id);
					}
				}
			}
		})(arr, id);
		return arr;
	}

	function objAtrNullToShow(obj) {
		for (atr in obj) {
			if (!obj[atr] && obj[atr]!==0 ) {
				obj[atr] = "-";
			};
		};
	};

</script>
