<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.tree_info .table td {border-color: #ddd;}
	.table tbody tr td {height: 100px;padding-left: 100px;}
	.table tbody input.form-control {width: 60%;display: inline-block;margin-left: 8px;color: #999;cursor: text;}
	.table tbody input.inputShow {background-color: inherit;border-color: transparent;}
	.app-content > .app-content-full {bottom: 0;}
	#manageDepartmentForm .btn.disabled {background-color: #ccc;border-color: #ccc;}
</style>
<link rel="stylesheet" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>

<div ng-controller="manageDepartmentCtrl" id="manageDepartment" class="hbox hbox-auto-xs bg-light">
	<div class="app-content-full" style="top:0px;bottom: 0px">
		<div class="hbox hbox-auto-xs hbox-auto-sm">
			<div class="col tree_wrap">
				<div class="vbox">
					<div id="departmentTreeMask" class="pa none" style="top: 0;bottom: 0;left: 0;right: 0;z-index: 2;"></div>
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
										<div class="col-sm-12 panel no-padder">
<form id="manageDepartmentForm" action="">
	<div class="row wrapper">
		<a id="editTree" href="javascript:;" data-loading-text="保存中..." class="btn btn-sm btn-info ml15">编辑</a>
		<a id="saveTree" href="javascript:;" class="btn btn-sm btn-info ml10 none">保存</a>
		<a id="removeTree" href="javascript:;" class="btn btn-sm btn-info ml10">删除</a>
		<a id="cancelTree" href="javascript:;" class="btn btn-sm btn-info ml10 none">取消</a>
		<a id="addChild" href="javascript:;" class="btn btn-sm btn-info ml10">添加下级部门</a>
		<a id="addParent" href="javascript:;" class="btn btn-sm btn-info ml10">添加同级部门</a>
	</div>
	<div>
		<table class="table">
			<tbody>
				<tr>
					<td>部门编码<input id="departmentCompanyId" class="form-control inputShow valid-roleCode" disabled></input></td>
					<td>部门简称<input id="departmentName" class="form-control inputShow" disabled></input></td>
				</tr>
				<!-- <tr>
					<td>上级部门<input id="departmentParentName" class="form-control inputShow" disabled readonly></input></td>
					<td>部门负责人<input id="departmentParentLinkMan" class="form-control inputShow" disabled readonly></input></td>
				</tr>
				<tr>
					<td><span class="ls4_3">联系人</span><input id="departmentLinkMan" class="form-control inputShow" disabled></input></td>
					<td>
						<div class="pr">
							联系电话
							<input id="departmentLinkPhone" name="departmentLinkPhone" class="form-control inputShow valid-tel" disabled></input>
							<span class="valid-error" style="white-space: nowrap;left: 74px;top: 100%;margin-top: 2px;"></span>
						</div>
					</td>
				</tr>-->
				<tr>
					<td>部门全称<input id="departmentFullName" class="form-control inputShow" disabled></input></td>
					<td>
						<div class="pr">
							<span class="ls4_2">排序</span>
							<input id="departmentSequence" name="departmentSequence" class="form-control inputShow" onkeyup="this.value=this.value.replace(/[^0-9]/g,'')" onafterpaste="this.value=this.value.replace(/[^0-9]/g,'')" disabled></input>
							<span class="valid-error" style="white-space: nowrap;left: 74px;top: 100%;margin-top: 2px;" ></span>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<script>
	app.controller('manageDepartmentCtrl', function($scope, $http, $state) {

	});


	var validatorManageDepartmentForm = $('#manageDepartmentForm').validate({
		messages: {
			'departmentLinkPhone': {
				mobile: '手机号码不合法'
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
	$('#departmentLinkPhone').blur(function() {
		validatorManageDepartmentForm.element($(this));
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
	//初始化
	$.ajax({
		url: '${ctx}/authDepartment/initDepartmentData.htm',
		type: "post"
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

	// $.post('${ctx}/shareClassifyTree/initData.htm', {}, function (data, status) {
	// 	initTree(data);
	// });

	$("#addParent").bind("click", {isParent:true}, addTree);
	$("#addChild").bind("click", {isParent:false}, addTree);
	$("#removeTree").bind("click", removeTree);
	$("#editTree").bind("click", editTree);
	$('#departmentTree').on('click', '.button', function(event) {
		$(this).parent('a').trigger('dblclick');
	});

	//添加
	var parentid;
	function addTree(e) {
		var isParent = e.data.isParent,
		nodes = zTreeObj.getSelectedNodes(),//当前选中部门
		treeNode = nodes[0];
		if(treeNode){//当前选中部门
			if (isParent) {//增加同级：
				var treeParentNode = nodes[0].getParentNode();//父部门
				if (treeParentNode) {//非根同级
					var newName = "新部门"+(newCount++);
					var newTreeNode = zTreeObj.addNodes(treeParentNode, {id:(CountId++), pId:treeParentNode.id, isParent:isParent, name: newName} );

					$.ajax({//获取父部门信息
						url: '${ctx}/authDepartment/editDepartment.htm',
						data: {id: treeParentNode.id},
					})
					.done(function(res) {
						if (res.key==1) {
							$('#departmentParentName').val(res.data.name);//上级部门
							$('#departmentParentLinkMan').val(res.data.linkman);//部门负责人
						}
					});
					parentid = treeParentNode.id;

				} else {//根同级
					var newName = "新部门"+(newCount++);
					var newTreeNode = zTreeObj.addNodes(null, {id:(CountId++), pId:0, isParent:isParent, name: newName} );
					parentid = null;
				};
				$('.curSelectedNode').find('.button.ico_close').removeClass('ico_close').addClass('ico_docu');
			} else {//增加下级
				var newName = "新部门"+(newCount++);
				var newTreeNode = zTreeObj.addNodes(treeNode, {id:(CountId++), pId:treeNode.id, isParent:isParent, name: newName} );
				parentid = treeNode.id;
				$.ajax({//获取父部门信息
					url: '${ctx}/authDepartment/editDepartment.htm',
					data: {id: treeNode.id},
				})
				.done(function(res) {
					if (res.key==1) {
						$('#departmentParentName').val(res.data.name);//上级部门
						$('#departmentParentLinkMan').val(res.data.linkman);//部门负责人
					}
				});
			};
			if (newTreeNode) {
				zTreeObj.selectNode(newTreeNode[0]);
				$('#saveTree').show();
				$('#editTree').hide();
				$('#removeTree').hide();
				$('#cancelTree').show();
				$('.inputShow').removeClass('inputShow').removeAttr('disabled');
				$('.table input').val('');
				$('#departmentName').val(newName);
				$('#addChild').addClass('disabled');
				$('#addParent').addClass('disabled');
				$('#departmentTreeMask').show();
				$('.curSelectedNode').find('.button.ico_close').removeClass('ico_close').addClass('ico_docu');
				$('#saveTree').unbind('click');
				$('#saveTree').click(function() {
					var newNodeObj = {
						"id": null,
						"departcode": $('#departmentCompanyId').val(),
						"name": $('#departmentName').val(),
						"parentid": parentid,
						"linkman": $('#departmentLinkMan').val(),
						"linkphone": $('#departmentLinkPhone').val(),
						"fullName": $('#departmentFullName').val(),
						"sequence": $('#departmentSequence').val()
					};
					var newNodeStr = JSON.stringify(newNodeObj);
					$.ajax({
						url: '${ctx}/authDepartment/updateDepartment.htm',
						type: "post",
						data: {data: newNodeStr},
					})
					.done(function(res) {
						var addId = res.id;
						if (res.key==2) {
							$('.form-control').addClass('inputShow').attr('disabled','disabled');
							$('#editTree').show();
							$('#saveTree').hide();
							$('#removeTree').show();
							$('#cancelTree').hide();
							$('#addChild').removeClass('disabled');
							$('#addParent').removeClass('disabled');
							$('#departmentTreeMask').hide();

							$.ajax({
								url: '${ctx}/authDepartment/initDepartmentData.htm',
								type: "post"
							})
							.done(function(res) {
								if (res.key==1) {
									var zNodes = setOpenTree(res.data, addId)
									$.fn.zTree.init($("#departmentTree"), setting, zNodes);
									zTreeObj = $.fn.zTree.getZTreeObj("departmentTree")
									var addNode = zTreeObj.getNodeByParam("id",addId);
									zTreeObj.selectNode(addNode, true, true);
									//$('#'+addNode.tId+'_a').trigger('click');
								}
							})
							.fail(function() {
								console.log("初始化数据失败error");
							});

						};
					})
					.fail(function() {
						console.log("error");
					});
				});
				$('#cancelTree').unbind('click');
				$('#cancelTree').click(function() {
					$('#saveTree').hide();
					$('#editTree').show();
					$('#removeTree').show();
					$('#cancelTree').hide();
					$('#addChild').removeClass('disabled');
					$('#addParent').removeClass('disabled');
					$('#departmentTreeMask').hide();
					$('.table .form-control').addClass('inputShow').attr('disabled','disabled');
					zTreeObj.removeNode(newTreeNode[0]);
				});
			} else {
				alert("叶子部门被锁定，无法增加子部门");
			};
		} else {//没有选中部门
			if ($(this).attr('id')=='addParent') {
				if ($("#departmentTree").text()=="") {
					var newName = "新部门"+(newCount++);
					var newTreeNode = zTreeObj.addNodes(null, {id:(CountId++), pId:0, isParent:isParent, name: newName} );
					parentid = null;
					if (newTreeNode) {
						zTreeObj.selectNode(newTreeNode[0]);
						$('#saveTree').show();
						$('#editTree').hide();
						$('#removeTree').hide();
						$('#cancelTree').show();
						$('.inputShow').removeClass('inputShow').removeAttr('disabled');
						$('.table input').val('');
						$('#departmentName').val(newName);
						$('#addChild').addClass('disabled');
						$('#addParent').addClass('disabled');
						$('#departmentTreeMask').show();
						$('#saveTree').click(function() {
							var newNodeObj = {
								"id": null,
								"companyid": $('#departmentCompanyId').val(),
								"name": $('#departmentName').val(),
								"parentid": parentid,
								"linkman": $('#departmentLinkMan').val(),
								"linkphone": $('#departmentLinkPhone').val(),
								"fullName": $('#departmentFullName').val(),
								"sequence": $('#departmentSequence').val()
							};
							var newNodeStr = JSON.stringify(newNodeObj);
							$.ajax({
								url: '${ctx}/authDepartment/updateDepartment.htm',
								type: "post",
								data: {data: newNodeStr},
							})
							.done(function(res) {
								var addId = res.id;
								if (res.key==2) {
									$('.form-control').addClass('inputShow').attr('disabled','disabled');
									$('#editTree').show();
									$('#saveTree').hide();
									$('#addChild').removeClass('disabled');
									$('#addParent').removeClass('disabled');
									$('#departmentTreeMask').hide();

									$.ajax({
										url: '${ctx}/authDepartment/initDepartmentData.htm',
										type: "post"
									})
									.done(function(res) {
										if (res.key==1) {
											var zNodes = setOpenTree(res.data, addId)
											$.fn.zTree.init($("#departmentTree"), setting, zNodes);
											zTreeObj = $.fn.zTree.getZTreeObj("departmentTree")
											var addNode = zTreeObj.getNodeByParam("id",addId);
											zTreeObj.selectNode(addNode, true, true);
											//$('#'+addNode.tId+'_a').trigger('click');
										}
									})
									.fail(function() {
										console.log("初始化数据失败error");
									});
								};
							})
							.fail(function() {
								console.log("error");
							});
						});
					} else {
						alert("叶子部门被锁定，无法增加子部门");
					};
				} else {
					alert("请选择一个部门");
				}
			} else {
				alert("请选择一个部门");
			}
		};
	};
	$('#departmentTreeMask').click(function(event) {
		alert("请先保存要添加的部门！");
	});
	//删除部门信息
	function removeTree(e) {
		var nodes = zTreeObj.getSelectedNodes(),
		treeNode = nodes[0];
		//alert(treeNode.id)
		if (nodes.length == 0) {
			alert("请先选择一个部门");
			return;
		}
		if(!confirm("确定删除此部门吗？")) return false;
		$.ajax({
			url: '${ctx}/authDepartment/deleteDepartmentData.htm',
			type: 'post',
			data: {id: treeNode.id},
		})
		.done(function(res) {
			//alert(res.key)
			if(res.key == 3){
				alert("请先删除下级部门，再删除此部门");
				return;
			}else if (res.key==2) {
				console.log('删除成功');
				zTreeObj.removeNode(treeNode);
				$('#editTree').show();
				$('#saveTree').hide();
				$('#addChild').removeClass('disabled');
				$('#addParent').removeClass('disabled');
				$('#departmentTreeMask').hide();
				$('.table .form-control').addClass('inputShow').attr('disabled','disabled');
			} else if (res.key==1) {
				alert("删除失败");
				console.log('删除失败');
			}
		})
		.fail(function() {
			console.log("删除部门信息error");
		});
	};
	//编辑
	function editTree() {
		$this = $(this);
		var zTreeObj = $.fn.zTree.getZTreeObj("departmentTree"),
		nodes = zTreeObj.getSelectedNodes(),
		treeNode = nodes[0];
		if (nodes.length == 0) {
			alert("请先选择一个部门");
			return;
		};
		if ($this.text()=='编辑') {
			var treeParentNode = nodes[0].getParentNode();//父部门
			parentid = treeParentNode?treeParentNode.id:null;
			$this.text('保存');
			$('#addChild').addClass('disabled');
			$('#addParent').addClass('disabled');
			$('#removeTree').addClass('disabled');
			$('.inputShow').removeClass('inputShow').removeAttr('disabled');
			$('.table .form-control').each(function(index, el) {
				if($(this).val()=='-'){
					$(this).val('');
				};
			});
		} else {
			if (validatorManageDepartmentForm.form()) {
				$this.button('loading');
				var newNodeObj = {
					"id": treeNode.id,
					"departcode": $('#departmentCompanyId').val(),
					"name": $('#departmentName').val(),
					"parentid": parentid,
					"linkman": $('#departmentLinkMan').val(),
					"linkphone": $('#departmentLinkPhone').val(),
					"fullName": $('#departmentFullName').val(),
					"sequence": $('#departmentSequence').val()
				};
				var newNodeStr = JSON.stringify(newNodeObj);
				$.ajax({
					url: '${ctx}/authDepartment/updateDepartment.htm',
					type: "post",
					data: {data: newNodeStr},
				})
				.done(function(res) {
					console.log('保存部门:'+res.key)
					$this.button('reset');
					if (res.key==4) {
						$this.text('编辑');
						$('#addChild').removeClass('disabled');
						$('#addParent').removeClass('disabled');
						$('.table .form-control').addClass('inputShow').attr('disabled','disabled');
						//zTreeObj.editName(treeNode);
						//zTreeObj.cancelEditName($('#departmentName').val());
						$('.curSelectedNode').trigger('click');
					}
				})
				.fail(function() {
					console.log("error");
					$this.button('reset');
				});
			};//表单校验成功后
		};
	};

	function setOpenTree(arr, pId){
	    for(var i=0,ii=arr.length;i<ii;i++){
	        var _obj = arr[i];
	        if(_obj.id && _obj.id == pId){
	            _obj.open = true;
	            if(_obj.pId)
	                arr = setOpenTree(arr, _obj.pId);
	            return arr;
	        }
	    }
	    return arr;
	}

	//更新部门信息  编辑、添加时调用
	function updateDepartment(data) {
		$.ajax({
			url: '${ctx}/authDepartment/updateDepartment.htm',
			data: {data: data},
		})
		.done(function(res) {
			console.log("success");
		})
		.fail(function() {
			console.log("error");
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
		if(!confirm("确定删除此部门吗？")) return false;
		if(treeNode.children && treeNode.children.length > 0){
			alert("此部门存在下级分类，不能删除");
			return false;
		}

		$.post("${ctx}/shareClassifyTree/selectShareRepos.htm",{
			'id' : treeNode.id
		},
		function(result, status){
			if(result.key != 0){
				if(result.count && result.count > 0){
					if(!confirm("删除此分类后，此分类相关的文章将被归为未分类，确定删除此部门吗？"))
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
	}

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

	function onClick(event, treeId, treeNode, clickFlag){
		//console.log(treeNode.id+ ", " +treeNode.tId + ", " + treeNode.name);
		if (treeNode.id == 0) {
			$('#editTree').addClass('disabled');
			$('#removeTree').addClass('disabled');
			$('.form-control').addClass('inputShow').attr('disabled','disabled');
			$('#editTree').show().text("编辑");
			$('#saveTree').hide();
			$('#addChild').removeClass('disabled');
			$('#addParent').addClass('disabled');
			
			$('#departmentCompanyId').val("-");
			$('#departmentName').val("-");
			$('#departmentFullName').val("-");
			$('#departmentSequence').val("-");
			
		} else {
			
			var ntext = $('#editTree').text();
			if(ntext == '编辑'){
				$('#addParent').removeClass('disabled');
				$('#removeTree').removeClass('disabled');
			}
			$('#editTree').removeClass('disabled');
			
			$('#saveTree').removeClass('disabled');
			$('#cancelTree').removeClass('disabled');
		}
		$.ajax({
			url: '${ctx}/authDepartment/editDepartment.htm',
			data: {id: treeNode.id},
		})
		.done(function(res) {
			if (res.key==1) {
				var showMsg = res.data;
				if (showMsg.parentid) {
					$.ajax({
						url: '${ctx}/authDepartment/editDepartment.htm',
						data: {id: showMsg.parentid},
					})
					.done(function(res) {
						showMsg.parentname = res.data.name;
						showMsg.parentlinkman = res.data.linkman;
						if ($("#editTree").text()=="编辑") {
							objAtrNullToShow(showMsg);
						}
						setShowMsg(showMsg);
					});
				} else {
					showMsg.parentname = null;
					showMsg.parentlinkman = null;
					if ($("#editTree").text()=="编辑") {
						objAtrNullToShow(showMsg);
					}
					setShowMsg(showMsg);
				};
			};
		})
		.fail(function() {
			console.log("error");
		});
	};

	function setShowMsg(msg) {
		$('#departmentCompanyId').val(msg.departcode);
		$('#departmentName').val(msg.name);
		$('#departmentParentName').val(msg.parentname);
		$('#departmentParentLinkMan').val(msg.parentlinkman);
		$('#departmentLinkMan').val(msg.linkman);
		$('#departmentLinkPhone').val(msg.linkphone);
		$('#departmentFullName').val(msg.fullName);
		$('#departmentSequence').val(msg.sequence);
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
