<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.table .dropdown-toggle {border: none;box-shadow: none;}
	.table .table-error {margin-left: 0px;left:0;top: 100%;margin-top: 2px;}
</style>

<!-- modal -->
<div class="modal fade" id="rootPersonPop" ng-controller="rootPersonCtrl">
	<div class="modal-dialog" style="width: 750px;">
		<div class="modal-content wrapper-lg">
		<div class="text-md">
			姓名:<span id="curPerson_name" class="mr10"></span>
			账号:<span id="curPerson_user" class=""></span>
		</div>
		<form id="RootupdateAuthForm" action="">
			<table class="table table-bordered text-center">
				<thead>
					<tr>
						<th class="text-center">权限</th>
						<th class="text-center">发送状态</th>
						<th class="text-center">操作</th>
					</tr>
				</thead>
				<tbody id="rootPersonTable">
				</tbody>
			</table>
			<div class="text-center">
				<button id="rootadd_row" class="btn btn-info pull-left" type="button" style="margin-top: -10px;">增加</button>
				<input type="hidden" id="modifyPersonTotaldata" name="modifyPersonTotaldata">
				<button id="rootPpdateAuthComUserRelBtn" data-loading-text="正在发送..." class="btn btn-info" type="button">保存</button>
				<button data-dismiss="modal" class="btn ml10" type="button">取消</button>
			</div>
		</form>
		<table class="none">
			<tbody>
				<tr id="rootPersonRow">
					<td width="40%" style="padding: 5px 0;">
						<div class="col-sm-4">
							<span class="dropdown">
								<button type="button" class="btn btn-default dropdown-toggle toggle-one" data-toggle="dropdown">
									<span class="toggle-cur">选择角色</span>
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu animated fadeInRight dropdown-menu-left dropdown-one">
								</ul>
							</span>
						</div>
						<div class="col-sm-8">
							<span class="dropdown col-sm-6">
								<button type="button" class="btn btn-default dropdown-toggle toggle-multi" data-toggle="dropdown">
									<span class="toggle-cur">选择电站组</span>
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu animated fadeInRight dropdown-menu-left multi-group dropdown-multi">
								</ul>
							</span>
							<span class="dropdown col-sm-6">
								<button type="button" class="btn btn-default dropdown-toggle toggle-multi" data-toggle="dropdown">
									<span class="toggle-cur">选择电站</span>
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu animated fadeInRight dropdown-menu-left multi-one dropdown-multi">
								</ul>
							</span>
						</div>
					</td>
					<td class="text-center" width="15%">
						<a href="javascript:;">待发送</a>
					</td>
					<td class="text-center del_row" width="10%"><a href="javascript:;">删除</a></td>
				</tr>
			</tbody>
		</table>
		</div>
	</div>
</div>
<!-- modal End -->

<script>
	$('#rootPersonTable').on('click', '.toggle-one', function(event) {
		var $toggleCur =  $(this).children('.toggle-cur');
		var	$ul = $(this).next('.dropdown-one');
		$('#rootPersonTable .dropdown-menu').not($ul).hide();
		$ul.toggle();
		$ul.children('li').click(function() {
			$toggleCur.text($(this).text());
			$(this).addClass('active').siblings().removeClass('active');
			$ul.show().hide();
		});
	});
	$('#rootPersonTable').on('click', '.toggle-multi', function(event) {
		var $toggleCur =  $(this).children('.toggle-cur');
		var	$ul = $(this).next('.dropdown-multi');
		$('#rootPersonTable .dropdown-menu').not($ul).hide();
		$ul.toggle();
		$ul.children('li').off('click');
		$ul.children('li').one('click', function(event) {
			console.log($(this).hasClass('active'))
			$(this).toggleClass('active');
			$toggleCur.text('已选'+$ul.find('.active').length+'个电站');
			$ul.show().hide();
		});
	});

	var rootPersonRowCount = 0;
	$('#rootadd_row').click(function() {
		rootPersonRowCount++;
		$('#rootPersonRow').find('.invite_name').attr('name', 'invite_name'+rootPersonRowCount);
		$('#rootPersonRow').find('.invite_mobile').attr('name', 'invite_mobile'+rootPersonRowCount);
		$('#rootPersonTable').append($('#rootPersonRow').clone().removeAttr('id'))
	});

	jQuery.extend(jQuery.validator.messages, {
		//required:'必填项',
		mobile: '手机号码不合法',
	});
	var validatorRootUpdateAuthForm = $('#RootupdateAuthForm').validate({
		messages: {
			'mobile': {
				mobile: "手机号码不合法"
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

	$('#rootPersonTable').on('click', '.del_row', function(event) {
		$(this).parents('tr').remove();
	});

	//邀请人员
	$('#rootPpdateAuthComUserRelBtn').click(function(event) {
		var $btn = $(this);
		if (validatorRootUpdateAuthForm.form()) {
			$btn.button('loading');
			var formParam = [];
			var aursrRoles = [];
			var isValid = true;
			$("#rootPersonTable").find("tr").each(function(){
				var objRow = {};
				objRow.roleid = $(this).find('.dropdown-one .active').attr('data-roleId');
				if(!objRow.roleid){
					isValid = false;
				}
				objRow.aursrs = [];
				$(this).find('.multi-one .active').each(function(index, el) {
					var obj = {
						pstationId: $(this).attr('data-id'),
						flag: $(this).attr('data-flag')
					};
					objRow.aursrs.push(obj);
				});
				
				objRow.authUserRoleGroupStationRels = [];
				$(this).find('.multi-group .active').each(function(index, el) {
					var obj = {
						groupId: $(this).attr('data-id')
					};
					objRow.authUserRoleGroupStationRels.push(obj);
				});
				if(objRow.aursrs.length ==0 && objRow.authUserRoleGroupStationRels.length ==0){
					isValid = false;
				}
				aursrRoles.push(objRow);
			});
			
			if(!isValid){
				alert('请选择角色或者电站');
				$btn.button('reset');
				return;
			}
			var trRow = {
				deptid: $('#rootPersonTable').attr('data-deptid'),
				realname: $('#curPerson_name').text(),
				phone: $('#curPerson_user').text(),
				id: $('#rootPersonPop').attr('data-id'),
				aursrRoles: aursrRoles
			};
			formParam.push(trRow);
			$("#modifyPersonTotaldata").val(JSON.stringify(trRow));

			$.ajax({
				url: '${ctx}/authComUserRel/modifyAuthComUserRel.htm',
				type: 'POST',
				data: {
					data: $("#modifyPersonTotaldata").val()
				}
			})
			.done(function(res) {//0 网络错误
				if (res.key==1){
					promptObj('error', '', '保存失败');
				} else if(res.key==2){
					promptObj('success', '', '保存成功');
					$('#rootPersonPop').modal('hide');
					$('.curSelectedNode').trigger('click');
				} else if(res.key==3){
					var phones = [];
					for(var i in res.data){
						phones.push(res.data[i].phone);
					}
					alert(phones.join(",")+"用户已被邀请，请去除后再添加");
					//promptObj('success', '', '已经被邀请');
				}
				$btn.button('reset');
			})
			.fail(function() {
				console.log("error");
				$btn.button('reset');
			});
		};
	});
	app.controller("rootPersonCtrl", function ($scope) {

	});
</script>
