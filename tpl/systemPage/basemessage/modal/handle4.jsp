<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 记录维修情况 -->
<style>
a.deal-suggest-con{display:block;padding: 5px;margin-bottom: 5px;}
a.deal-suggest-con.active{color:white;background:#06bebd;}
.level-content >li{display:block; margin-bottom: 5px;line-height: 25px;}
.item label{margin:0;width:100%;background: rgb(245,245,245);padding: 5px;}
.item label.active{background: rgb(27,197,196);
.level-title label.active{background: rgb(27,197,196);}
</style>
<div class="modal fade noteModal "id="handle4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row">
		<div class="modal-content ">
			<div class="modal-body wrapper-lg" >
				 <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Optask/selectInspectedMan.htm" method="post" id="editForms4" name="editForms" enctype="multipart/form-data">
					<div class="form-group">
							<label class="col-sm-3 control-label pull-left"></label>
							<label class="col-sm-2 control-label pull-left">验收人</label>
							<div class="col-sm-4 select">
				            <ui-select ng-model="managerd04.selected" theme="bootstrap" ng-change="managerChange04()">
					            <ui-select-match placeholder="请输入关键字..." ng-model="managerd04.selected.realName" >{{$select.selected.realName}}</ui-select-match>
					            <ui-select-choices  repeat="item in manager04 | filter: $select.search">
					              <div ng-bind-html="item.realName | highlight: $select.search"></div>
					            </ui-select-choices>
				         	 </ui-select>
				         	 <input type="hidden" onMouseOut="cllarverifyhandle04()" id="inspectedMan4" name="inspectedMan" class="form-control formData"/>
							<div id="handle4_severify" style="display:none;color: red;">请选择人员</div>
							</div>
							<label class="col-sm-3 control-label pull-left"></label>
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group">
					</div>
					<div class="form-group" style="margin-top:30px">
						<div class="col-sm-offset-2 col-sm-9 text-center" >
							<button type="button" ng-click="handleInspected_select()" 
								class="btn m-b-xs w-xs taskBtn">
								<strong>确定</strong>
							</button>
							<button type="button" data-dismiss="modal" aria-hidden="true"
								class="btn m-b-xs w-xs btn-default" style="margin-left:5px">
								取消
							</button>
						</div>
					</div>
				</form>
         			 </div>
				</div>
		</div>
	</div>
<script type="text/javascript">

	$("#editForms4").validate( {
		rules : {
		},submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(msg) {
					if(msg.result){
						promptObj('success','',msg.infoMsg);
					}else{
						promptObj('error','',msg.infoMsg);
					}
					$('#handle4').modal('hide');
					//刷新列表
// 					$scope.showNoteList(noteActiveId);
					showNoteList(noteActiveId);
				},error : function(json) {
						promptObj('error','',"保存失败,请稍后重试!");
				}
			};
			$('#editForms4').ajaxSubmit(options);
		}
	});
</script>