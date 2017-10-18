<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.tree_manage .remove{margin-left: 2px;}
	.tree_manage .remove::before {content:"删除";}
	.tree_manage .add {margin-left: 5px;}
	.tree_manage .add::before {content:"增加";}
	.tree_manage .edit {margin-left: 2px;}
	.tree_manage .edit::before {content:"编辑";}
</style>
	<div ng-controller="ShareTreeCtrl" class="col tree_wrap">
		<div class="vbox">
			<div id="departmentTreeMask" style="margin-top: 50px;">
				<div class="font-h3 menu_text text-center">
					知识库分类
					<a class="btn btn-xs pa inherited" ng-click="addRootNode();" id="addgroupBtn" style="right: 5px;top: 78px;">添加分类</a>
				</div>
			</div>
			<%--<div class="row" style="margin-top:3px;">--%>
				<%--<div class="col-sm-5"></div>--%>
				<%--<div class="col-sm-7">--%>
					<%--<button class="btn btn-sm btn-default " ng-click="addRootNode();">添加一级分类</button>--%>
				<%--</div>--%>
			<%--</div>--%>
			<div class="row-row">
				<div class="cell">
					<div class="cell-inner" style="overflow: scroll">
						<ul class="tree_manage" id="classifyTree" style="width: auto">

						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
<link rel="stylesheet" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>
<script type="text/javascript">
var zTreeObj, newCount = 0;
$(function(){
	// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	var setting = {
			check: {
				enable: true,
				chkStyle: "radio",
				radioType: "all"
			},
			view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false
			},
			edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn,
				removeTitle: "",
				renameTitle: ""
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
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

	// zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
	$.post('${ctx}/shareClassifyTree/initData.htm', {}, function (data, status) {
		initTree(data);
	});

	$('#classifyTree').on('click', '.button', function(event) {
		$(this).parent('a').trigger('dblclick');
	});

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
		setTreeChecked(setting, treeNode.id);
		$("#watchType").val(treeNode.id);
		$("#watchType").trigger("click");
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
			+ "' onfocus='this.blur();'></span>";
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
});

app.controller('ShareTreeCtrl',['$http','$scope','$stateParams','$state',
	function($http, $scope, $stateParams, $state) {

	$scope.addRootNode = function(){
		var treeNode = zTreeObj.addNodes(null, {id:++newCount, flag:"0", isParent: true, name:"一级分类"}, true);
		zTreeObj.editName(treeNode[0]);
	};
}]);

function setOpenTreeById(arr, id){
	for(var i=0,ii=arr.length;i<ii;i++){
		var _obj = arr[i];
		delete _obj.parent;
		if(_obj.id == id){
			_obj.parent = 1;
		}
	}
	return arr;
}

function setTreeChecked(setting, id){
	var nodes = zTreeObj.getNodes();
	zTreeObj = $.fn.zTree.init($("#classifyTree"), setting, setCheckedFlag(setNoCheckedFlag(nodes), id));
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

function getTreeData(arr){
    var treeData = [];
    for(var i=0,ii=arr.length;i<ii;i++) {
        var _obj = arr[i];
        treeData.push({
            "id": _obj.id,
            "pId": _obj.pId,
            "name": _obj.name
        });
        if (_obj.children && _obj.children.length > 0) {
            treeData.push(getTreeData(_obj.children));
        }
    }
    return treeData;
}

function getTreeLastId(arr){
    var lastId = 0;
    for(var i=0,ii=arr.length;i<ii;i++) {
        var _obj = arr[i];
        if(_obj.id > lastId)
            lastId = _obj.id;
        if (_obj.children && _obj.children.length > 0) {
            lastId = getTreeLastId(_obj.children);
        }
    }
    return lastId;
}

function setParentData(arr){
    for(var i=0,ii=arr.length;i<ii;i++) {
        var _obj = arr[i];
        if(!_obj.pId){
            _obj.isParent = true;
        }
        if (_obj.children && _obj.children.length > 0) {
            setParentData(_obj.children);
        }
    }
    return arr;
}

function setSelectedOpenTree(arr){
    for(var i=0,ii=arr.length;i<ii;i++){
        var _obj = arr[i];
        if(_obj.parent && _obj.parent==1){
        	_obj.checked = true;
            return setOpenTree(arr, _obj.pId);
        }
    }
    return arr;
}

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
</script>
