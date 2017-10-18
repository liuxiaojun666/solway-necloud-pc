<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css"/>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.all.min.js"></script>
    <script type="text/javascript">      
	$(function() {
		$("#editForm2").validate( {
			rules : {
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						hideModal("addRightModal");
						//goPage(0);
					},
					error : function(json) {
						promptObj('error', '',"操作失败");
					}
				};
				$('#editForm2').ajaxSubmit(options);
			}
		});
	});
	function saveForm2(){
		var zTree = $.fn.zTree.getZTreeObj('tree');
		var checkNodes = zTree.getNodesByFilter(function(node) {
			var status = node.getCheckStatus();
			//if (node.level == 0) return false;
			if (status.checked === true || status.half === true) return true;
			else return false;
		}, false, null);
		if ($(checkNodes).length == 0) {
			alert("请至少选中一个权限");
			return false;
		}
		for (var n in checkNodes) {
			var checkId = checkNodes[n].id;
			if(checkId!=null&&checkId!=undefined){
				$('<input type="hidden" name="resourceIds" />').val(checkId).insertAfter('#roleId2');				
			}
		}
		$("#editForm2").trigger("submit");
	}
	//初始化页面数据
	function initPageData2(id){
		$(".formData").val("");
		$("[name='resourceIds']").remove();
		if(id != "" && id != null){
			 $("#roleId2").val(id);
			 getRightTree(id);
		}
	}
	function getRightTree(roleId){
		$.ajax({
			type:"post",
			url:"${ctx}/Role/getRightTree.htm",
			data:{"roleId":roleId},
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
<style type="text/css">
#rightPanelDiv{
/* 	float:left; */
	background-color: #e4eaec;
}
.level0 li{
	float:left;
	width: 150px;
}
</style>
<div class="modal fade" id="addRightModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <h3 class="m-t-none m-b font-thin" id="myModalLabel">添加权限</h3>
      <div id="rightPanelDiv" class="panel-body" >
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Role/addRight.htm" method="post" id="editForm2" name="editForm2">
          <input type="hidden" id="roleId2" name="roleId" value="" class="formData"/>
  <div class="col dk b-r ">
		<div class="form-body">
			<ul id="tree" class="ztree" style="width: 300px"></ul>
		</div>
</div>
            <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">   
                <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                 <button type="button" onclick="saveForm2();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
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
