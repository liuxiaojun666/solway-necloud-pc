<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css"/>
<style type="text/css">
	#rightPanelDiv {
		max-height: 200px;
		overflow-y: auto;
	}
	#rightPanelDiv {
		/*float:left;*/
		background-color: #e4eaec;
	}
	#tree .level0 li{
		float:left;
		width: 150px;
	}
</style>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">
	function saveForm2(){
		var zTree = $.fn.zTree.getZTreeObj('tree');
		var checkNodes = zTree.getNodesByFilter(function(node) {
			var status = node.getCheckStatus();
			//if (node.level == 0) return false;
			if (status.checked === true || status.half === true) return true;
			else return false;
		}, false, null);
		var authRoleRights = [];
		var input, inputed;
		for (var n in checkNodes) {
			var authRoleRight = {};
			var checkId = checkNodes[n].id;
			if(checkId!=null&&checkId!=undefined){
				input = $("input[name='writeFlag"+checkId+"']");
				if(input.length > 0){
					inputed = $("input[name='writeFlag"+checkId+"']:checked");
					if(inputed.length == 0){
						alert("请选择"+input.eq(0).parent().find("span").text()+"的只读或读写权限");
						return;
					}
					authRoleRight.writeflag = inputed.val();
				}
				authRoleRight.rightId = checkId;
				authRoleRights.push(authRoleRight);
			}
		}
		return authRoleRights;
	};
	//初始化页面数据
	// function initPageData2(id){
	// 	$(".formData").val("");
	// 	$("[name='resourceIds']").remove();
	// 	if(id != "" && id != null){
	// 		 $("#roleId2").val(id);
	// 		 getRightTree(id);
	// 	}
	// }
	function getRightTree(roleId){
		$.ajax({
			type:"post",
			url:"${ctx}/Role/getRightTree.htm",
			data: {
				roleId: roleId||null
			},
			success:function(msg){
				var settings = {
					check: {
						enable: true
					}
				};
				$.fn.zTree.init($('#tree'), settings, msg);
			}
		});
	}
</script>
<div id="addRightModal" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true">
	<div id="rightPanelDiv" class="panel-body" >
		<input type="hidden" id="roleId2" name="roleId" value="" class="formData"/>
		<div class="col dk b-r ">
			<div class="form-body">
				<ul id="tree" class="ztree"></ul>
			</div>
		</div>
	</div>
</div>
