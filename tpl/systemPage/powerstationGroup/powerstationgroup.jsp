<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.tree_info table tr th,.tree_info table tr td {text-align: center;}
	.list-group-item.active {background-color: #06bebe !important;}
	.app-content > .app-content-full {bottom: 0;}
	.inverterTablediv .simThead th,
	#roleTablePop td {width: 33.33%;}
	.tree_manage .remove {position: absolute;right: 5px;top: 0;}
	.tree_manage .remove:before {content:"删除";}
</style>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>
<div ng-controller="groupCtrl" class="hbox hbox-auto-xs bg-light">
	<div class="app-content-full" style="top:0px;bottom: 0px">
		<div class="hbox hbox-auto-xs hbox-auto-sm" >
			<div class="col tree_wrap">
				<div class="vbox">
					<div class="font-h3 menu_text text-center pr">
						电站分组
						<a class="btn btn-xs pa inherited" id="addgroupBtn" style="right: 5px;bottom: 5px;">添加分组</a>
					</div>
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
												<button type="button" id="addpowerstationBtn" class="btn btn-info btn-sm ml15">添加电站</button>
												<div class="pull-right mr15">
													<%@ include file="/common/pager.jsp"%>
												</div>
											</div>
											<table class="table text-center table-striped b-t b-light">
												<thead>
													<tr>
														<th>电站名称</th>
														<th>装机容量</th>
														<th>地址</th>
														<th>操作</th>
													</tr>
												</thead>
												<tbody id="roleTable">
													<tr ng-repeat="vo in data">
														<td class="table-roleCode" ng-bind="vo.name"></td>
														<td class="table-roleName" ng-bind="vo.build"></td>
														<td class="table-remark" ng-bind="vo.address"></td>
														<td>
															<a class="text-danger ml5 role_del" href="javascript:;" ng-click="deleteRow({{vo.id}});">删除</a>
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
<!-- 添加电站start -->
<div ng-controller="addpowerstationCtrl" class="modal fade" id="addps">
    <div class="modal-dialog">
        <div class="modal-content wrapper-lg">
			<form class="form-horizontal" id="addRoleForm" name="addRoleForm">
				<input type="hidden" name="roleId" />
				<div class="inverterTablediv simThead_fault pr">
					<table class="table text-center table-striped b-t b-light">
						<input id="clickon" type="hidden" ng-click="clic()">
						<thead>
							<tr>
								<th>
									<label class="i-checks m-b-none">
										<input type="checkbox" id="all" onclick="changeAll(this.checked,'ids');" /><i></i>
									</label>
								</th>
								<th>电站名称</th>
								<th>装机容量</th>
								<th>地址</th>
							</tr>
						</thead>
						<tbody id="roleTablePop">
							<tr ng-repeat="vo in powerData">
								<td>
								<label class="i-checks m-b-none">
								<input type="checkbox" name="ids" id="ids" value="{{vo.id}}-{{vo.entrustId}}" />
								<i></i></label>
								</td>
								<td class="table-roleCode" ng-bind="vo.name"></td>
								<td class="table-roleName" ng-bind="vo.build"></td>
								<td class="table-remark" ng-bind="vo.address"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="text-center mt20">
					<button type="button" class="btn btn-info" data-loading-text="保存中..."onclick="savadata('');">保存</button>
					<button type="button" class="btn ml15" data-dismiss="modal" name="resetAddRole" id="resetAddRole">取消</button>
				</div>
			</form>
        </div>
    </div>
</div>
<!-- 添加电站end -->
<!-- 添加分组start -->
<div class="modal fade" id="addgr">
    <div class="modal-dialog">
        <div class="modal-content wrapper-lg">
			<form class="form-horizontal" id="addRoleForm" name="addRoleForm">
				<div class="form-group">
					<label class="col-sm-2 control-label">分组名称</label>
					<div class="col-sm-4">
						<input type="text" name="groupname" id="groupname" class="form-control valid-roleCode valid-required"  placeholder="请输入分组名称">
						<div class="valid-error" style="left: 25px;top: 100%;margin-top: 2px;"></div>
					</div>
				</div>
				<div class="text-center mt20">
					<button type="button" class="btn btn-info" data-loading-text="保存中..."onclick="savagroupdata('');">保存</button>
					<button type="button" class="btn ml15" data-dismiss="modal" name="groupAdd" id="groupAdd">取消</button>
				</div>
			</form>
        </div>
    </div>
</div>
<!-- 添加分组end -->
<div data-ng-include="'${ctx}/tpl/systemPage/companyDepartment/rootPop.jsp'"></div>

<script>
	$('.simThead_fault').scroll(function(event) {
		$('.simThead_fault .simThead').css('top', $(this).scrollTop());
	});

	var depid = null;
	app.controller('groupCtrl', function($scope, $http, $state) {
		initTableConfig($scope);
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			};
			$http({
				method : "POST",
				url : "${ctx}/AuthPowerStationGroup/AuthPowerStationGroupList.htm",
				params : {
					pageIndex : page - 1,
					pageSize : $scope.pageSizeSelect,
					groupid: depid
				}

			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
	});
	app.controller('addpowerstationCtrl', function($scope, $http, $state) {
		$scope.clic = function(){
			$http({
				method : "POST",
				url : "${ctx}/AuthPowerStationGroup/powerstationList.htm"
			}).success(function(result) {
				$scope.powerData = result;
			});
		};

	});

	var zTreeObj, newCount = 1, CountId = 0;
	var setting = {
			view: {
				selectedMulti: false
			},
			edit: {
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

	function initgroup(){
		$.ajax({
			url: '${ctx}/AuthPowerStationGroup/initgroupData.htm'
		})
		.done(function(res) {
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
		})
		.fail(function() {
			console.log("初始化数据失败error");
		});
	}
	//初始化电站分组
	$.ajax({
		url: '${ctx}/AuthPowerStationGroup/initgroupData.htm'
	})
	.done(function(res) {
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
	//添加电站弹出
	$('#addpowerstationBtn').click(function() {
		$('#addps').modal();
		$('#clickon').trigger('click');
	});
	//添加分组弹出
	$('#addgroupBtn').click(function() {
		$('#addgr').modal();
	});
	//添加电站保存
	function savadata() {
		var conti = checkSelectMsg("ids", "请至少选择一条记录!");
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/AuthPowerStationGroup/savedata.htm?"
						+ $("input[name=ids]:checked").serialize()+"&groupid="+depid,
				success : function(json) {
					promptObj('success', '', json.message);
					$('.curSelectedNode').trigger('click');
					$('#resetAddRole').trigger('click');
				},
				error : function(json) {
					promptObj('error', '',"操作失败");
					$('.curSelectedNode').trigger('click');
					$('#resetAddRole').trigger('click');
				}
			};
			$.ajax(options);
		}
	}
	//添加分组保存
	function savagroupdata() {
		var groupname=$("#groupname").val();
		if(groupname.trim("")==""){
			alert("请输入名称")
			return ;
		}
		var optionss = {
			type : "post",
			dataType : "json",
			url : "${ctx}/AuthPowerStationGroup/savegroupdata.htm?groupname="+groupname,
			success : function(json) {
				promptObj('success', '', json.message);
				$('#groupAdd').trigger('click');
				initgroup();
			},
			error : function(json) {
				promptObj('error', '',"操作失败");
				$('#groupAdd').trigger('click');
				initgroup();
			}
		};
		$.ajax(optionss);
	}
	//删除电站
	function deleteRow(id) {
		if (confirm("确定要删除这个电站吗？")) {
			singledel(id);
		}
	}
	function singledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx }/AuthPowerStationGroup/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '', json.message);
				$('.curSelectedNode').trigger('click');
			},
			error : function() {
				promptObj('error', '',"删除失败");
				$('.curSelectedNode').trigger('click');
			}
		});
	}
	

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
		if(!confirm("确定删除此分组吗？")) return false;
		$.ajax({
			type : "post",
			url : "${ctx }/AuthPowerStationGroup/deletegroup.htm",
			data : {
				"id" : treeNode.id
			},
			dataType : "json",
			success : function(json) {
				promptObj('success', '', json.message);
				initgroup();
			},
			error : function() {
				promptObj('error', '',"删除失败");
				initgroup();
			}
		});
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
