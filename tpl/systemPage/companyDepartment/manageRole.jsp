<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.tree_info table tr th,.tree_info table tr td {text-align: center;}
	.list-group-item.active {background-color: #06bebe !important;}
	.app-content > .app-content-full {bottom: 0;}
	.line{height: auto}
</style>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>
<div ng-controller="manageRoleCtrl" class="hbox hbox-auto-xs bg-light">
	<div class="app-content-full" style="top:0px;bottom: 0px">
		<div class="hbox hbox-auto-xs hbox-auto-sm" >
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
			<div class="col lter tree_info" >
				<div class="vbox">
					<div class="row-row">
						<div class="cell">
							<div class="cell-inner">
								<div class="wrapper-md">
									<div class="panel panel-default">
										<paging class="col-sm-12 panel no-padder">
											<div class="row wrapper">
												<button type="button" id="addRoleBtn" class="btn btn-info btn-sm ml15">添加角色</button>
												<div class="pull-right mr15">
													<%@ include file="/common/pager.jsp"%>
												</div>
											</div>
											<table class="table text-center table-striped b-t b-light">
												<thead>
													<tr>
														<th>角色编码</th>
														<th>角色名称</th>
														<th>角色描述</th>
														<th>角色操作</th>
													</tr>
												</thead>
												<tbody id="roleTable">
													<tr ng-repeat="vo in data">
														<td class="table-roleCode" ng-bind="vo.roleCode"></td>
														<td class="table-roleName" ng-bind="vo.roleName"></td>
														<td class="table-remark" ng-bind="vo.remark"></td>
														<td>
															<a class="text-info role_modify" href="javascript:;" data-roleCode="{{vo.roleCode}}" data-roleName="{{vo.roleName}}" data-remark="{{vo.remark}}" data-roleId="{{vo.roleId}}">修改</a>
															<a class="text-danger ml5 role_del" href="javascript:;" data-roleId="{{vo.roleId}}">删除</a>
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
<div ng-controller="addRoleCtrl" class="modal fade" id="addRolePop">
    <div class="modal-dialog">
        <div class="modal-content wrapper-lg">
			<form class="form-horizontal" id="addRoleForm" name="addRoleForm">
				<input type="hidden" name="roleId" />
				<div class="form-group">
					<label class="col-sm-2 control-label">角色编码</label>
					<div class="col-sm-4">
						<input type="text" name="roleCode" id="roleCode" class="form-control valid-roleCode valid-required"  placeholder="请输入角色编码">
						<div class="valid-error" style="left: 25px;top: 100%;margin-top: 2px;"></div>
					</div>
					<label class="col-sm-2 control-label">角色名称</label>
					<div class="col-sm-4">
						<input type="text" name="roleName" id="roleName" class="form-control valid-required" placeholder="请输入角色名称">
						<span class="valid-error" style="left: 25px;top: 100%;margin-top: 2px;"></span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">所属部门</label>
					<div class="col-sm-4">
						<input type="text" name="roleDepartment" id="roleDepartment" class="form-control" readonly>
					</div>
					<label class="col-sm-2 control-label" ng-show="viewCodeData[0].name == '电能站'">角色类型</label>
					<div class="col-sm-4" ng-show="viewCodeData[0].name == '电能站'">
						<input name="roleElec" value="00" type="radio">用电企业
						<input name="roleElec" value="01" type="radio">售电公司
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">角色描述</label>
					<div class="col-sm-10">
						<textarea style="width: 100%;resize: vertical;" name="roleDescribe" id="roleDescribe" class="form-control"></textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">功能权限</label>
					<div class="col-sm-10">
						<div data-ng-include="'${ctx}/tpl/systemPage/companyDepartment/manageRoleAddRight.jsp'"></div>
					</div>
				</div>
				<div class="form-group" ng-repeat="viewCoded in viewCodeData">
					<label class="col-sm-2 control-label">{{viewCoded.name}}</label>
					<div class="col-sm-10">
						<ul class="list-unstyled">
							<li ng-repeat="viewCode in viewCoded.data">
								<span>{{viewCode.rightName}}</span>
								<input name="{{'writeFlag'+viewCode.rightId}}" value="0" type="radio">只读
								<input name="{{'writeFlag'+viewCode.rightId}}" value="1" type="radio">读写
							</li>
						</ul>
					</div>
				</div>
				<div class="text-center mt20">
					<button type="button" class="btn btn-info" data-loading-text="保存中..." autocomplete="off" name="submitAddRole" id="submitAddRole">保存</button>
					<button type="button" class="btn ml15" data-dismiss="modal" name="resetAddRole" id="resetAddRole">取消</button>
				</div>
			</form>
        </div>
    </div>
</div>
<div data-ng-include="'${ctx}/tpl/systemPage/companyDepartment/rootPop.jsp'"></div>

<script>
	var depid = null;
	app.controller('manageRoleCtrl', function($scope, $http, $state) {
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			};
			$http({
				method : "POST",
				url : "${ctx}/Role/roleInformationList.htm",
				params : {
					pageIndex : page - 1,
					pageSize : $scope.pageSizeSelect,
					depid: depid,
					roleType: '02'
				}

			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
	});
	app.controller('addRoleCtrl', function($scope, $http, $state) {
		$http.get('${ctx}/Role/getViewCode.htm',{
		}).success(function(res) {
			console.log(res)
			$scope.viewCodeData = res.data;
		}).error(function(res) {
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
		depid = treeNode.id;
		$('#selectPageClick').trigger('click');
	};

	var validatorRoleForm = $('#addRoleForm').validate({
		messages: {
			'roleName': {
			}
		},
		//错误提示位置
		errorPlacement: function (error, ele) {
			if (ele.siblings('.valid-error').length>0) {
	    		var $validError = ele.siblings('.valid-error');
			} else {
				var $validError = ele.parent().siblings('.valid-error');
			}
			$validError.html(error);
		},
		submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(json) {
					//promptObj('success','',json.message);
					hideModal("userInformationModal");
					goPage(0);
				},
				error : function(json) {
					promptObj('error', '',"保存失败");
				}
			};
			$(form).ajaxSubmit(options);
		}
	});
	//添加角色弹出
	$('#addRoleBtn').click(function() {
		$('#addRolePop').modal();
		getRightTree();
		$('#roleCode').removeAttr('readonly');
		var nodes = zTreeObj.getSelectedNodes();
		$('#addRoleForm').get(0).reset();
		$('#roleDepartment').val(nodes[0].name).attr('data-departmentId', nodes[0].id);
	});
	//修改角色
	var curRoleId;
	$('#roleTable').on('click', '.role_modify', function(event) {
		$("input[type='radio']").prop("checked", false);;
		curRoleId = $(this).attr('data-roleId');
		$.post("${ctx}/Role/selectById.htm",{
			roleId:curRoleId
		}).success(function(msg){
			console.log(msg)
			console.log(11111)
			if(msg.key == "1"){
				$('#addRolePop').modal();
				var data = msg.data;
				$("input[name='roleId']").val(data.roleId);
				$('#roleDepartment').val(data.depName).attr('data-departmentId', depid);
				$('#roleCode').val(data.roleCode);
				$('#roleName').val(data.roleName);
				$('#roleDescribe').val(data.remark);
				$("input[name='roleElec'][value='"+data.roleElec+"']").prop("checked",true); 
				for(var i= 0,ii=data.authRoleRights.length;i<ii;i++){
					$("input[name='writeFlag"+data.authRoleRights[i].rightId+"'][value='"+
							data.authRoleRights[i].writeflag+"']").prop("checked", true);;
				}
			}
		});
		getRightTree(curRoleId);
	});
	//保存角色
	$('#submitAddRole').click(function(event) {
		var $btn = $(this);
		var authRoleRight = saveForm2();
		if(authRoleRight == undefined) return false;
		if(authRoleRight.length == 0){
			alert("请至少选中一个权限");
			return false;
		}
		if (validatorRoleForm.form()) {
			$btn.button('loading');
			var oData = {
				roleId: $("input[name='roleId']").val(),
				roleCode: $('#roleCode').val(),//角色编码
				roleName: $('#roleName').val(),//角色名称
				//conpanyid: $('#roleDepartment').val(),//所属部门
				depid: $('#roleDepartment').attr('data-departmentid'),//部门id
				remark: $('#roleDescribe').val(),//角色描述
				roleType: '02', //角色类型
				authRoleRights: authRoleRight,
				roleElec : $("input[name='roleElec']:checked").val()//售电角色用
			};
			if ($('#roleCode').attr('readonly')) {
				oData.roleId = curRoleId;
			};
			$.ajax({
				url: '${ctx}/Role/updateRole.htm',
				type: 'POST',
				data: {data: JSON.stringify(oData)}
			})
			.done(function(res) {
				if (res.key == 1) {
					console.log('部门不存在');
					promptObj('error','','部门不存在');
				} else if(res.key == 2) {
					console.log('新增失败');
					promptObj('error','','新增失败');
				} else if(res.key == 3) {
					console.log('新增成功');
					promptObj('success','','新增成功');
					$('#addRolePop').modal('hide');
					$('.curSelectedNode').trigger('click');
				} else if (res.key == 4) {
					promptObj('error','','修改失败');
				} else if (res.key == 5) {
					console.log('修改成功');
					promptObj('success','','修改成功');
					$('#addRolePop').modal('hide');
					$('#roleCode').removeAttr('readonly');
					$('.curSelectedNode').trigger('click');
				}
				$btn.button('reset');
			})
			.fail(function() {
				console.log("error");
				$btn.button('reset');
			});
		};
	});
	//删除角色
	$('#roleTable').on('click', '.role_del' , function() {
		var $this = $(this);
		$.ajax({
			url: '${ctx}/Role/delete.htm',
			type: 'POST',
			data: {
				roleId: $(this).attr('data-roleId')
			},
		})
		.done(function(res) {//0 网络错误
			console.log("success");
			if (res.key==1) {
				console.log('有下级部门');
				promptObj('error', '', '有下级部门');
			} else if (res.key==2){
				console.log('删除失败');
				promptObj('error', '', '删除失败');
			} else if(res.key==3){
				console.log('删除成功');
				promptObj('success', '', '删除成功');
				$this.parent().parent().remove();
			}
		})
		.fail(function() {
			console.log("error");
		});
	});

	//授权
	$('.rootRoleBtn').click(function(event) {
		$('#rootPop').modal();
	});


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
