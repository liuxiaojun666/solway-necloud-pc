<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.table .dropdown-toggle {border: none;box-shadow: none;}
	.table .table-error {margin-left: 0px;left:0;top: 100%;margin-top: 2px;}
</style>

<!-- modal -->
<div class="modal fade" id="invitePersonPop">
	<div class="modal-dialog" style="width: 900px;">
		<div class="modal-content wrapper-lg">
			<form id="updateAuthForm" action="">
				<table class="table table-bordered text-center">
					<thead>
						<tr>
							<th class="text-center">姓名</th>
							<th class="text-center">手机号(账号)</th>
							<th class="text-center">权限</th>
							<th class="text-center">发送状态</th>
							<th class="text-center">操作</th>
						</tr>
					</thead>
					<tbody id="invitePersonTable">
					</tbody>
				</table>
				<div class="text-center">
					<button id="add_row" class="btn btn-info pull-left" type="button" style="margin-top: -10px;">增加</button>
					<input type="hidden" id="invitePersonTotaldata" name="invitePersonTotaldata">
					<button id="PpdateAuthComUserRelBtn" data-loading-text="正在发送..." class="btn btn-info" type="button">发送邀请</button>
					<button data-dismiss="modal" class="btn ml10" type="button">取消</button>
				</div>
			</form>
			<table class="none">
				<tbody>
					<tr id="invitePersonRow">
						<td width="15%">
							<div class="pr">
								<input type="text" class="invite_name form-control valid-required" name="inviteName">
								<span class="valid-error table-error" ></span>
							</div>
						</td>
						<td width="20%">
							<div class="pr">
								<input type="text" class="invite_mobile invite_tel form-control valid-required" name="mobile">
								<span class="valid-error table-error" ></span>
							</div>
						</td>
						<td width="45%" style="padding: 5px 0;">
							<div class="col-sm-4 dropdown">
								<span class="">
									<button type="button" class="btn btn-default dropdown-toggle toggle-one" data-toggle="dropdown">
										<span class="toggle-cur">选择角色</span>
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu animated fadeInRight dropdown-menu-right dropdown-one">
									</ul>
								</span>
							</div>
							<div class="dropdown col-sm-8">
								<span class="col-sm-6">
									<button type="button" class="btn btn-default dropdown-toggle toggle-multi" data-toggle="dropdown">
										<span class="toggle-cur">选择电站组</span>
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu dropdown-menu-right dropdown-multi multi-group animated fadeInRight">
									</ul>
								</span>
								<span class="col-sm-6">
									<button type="button" class="btn btn-default dropdown-toggle toggle-multi" data-toggle="dropdown">
										<span class="toggle-cur">选择电站</span>
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu dropdown-menu-right dropdown-multi multi-one animated fadeInRight">
									</ul>
								</span>
							</div>
						</td>
						<td class="text-center" width="12%">
							<a href="javascript:;">待发送</a>
						</td>
						<td class="text-center del_row" width="13%"><a href="javascript:;">删除</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- modal End -->

<script>
	$('#invitePersonTable').on('click', '.toggle-one', function(event) {
		var $toggleCur =  $(this).children('.toggle-cur');
		var	$ul = $(this).next('.dropdown-one');
		$('#invitePersonTable .dropdown-menu').not($ul).hide();
		$ul.toggle();
		$ul.children('li').one('click', function(event) {
			$toggleCur.text($(this).text());
			$(this).addClass('active').siblings().removeClass('active');
			$ul.show().hide();
		});
	});
	$('#invitePersonTable').on('click', '.toggle-multi', function(event) {
		var $toggleCur =  $(this).children('.toggle-cur');
		var	$ul = $(this).next('.dropdown-multi');
		var flag = $ul.hasClass("multi-one");
		$('#invitePersonTable .dropdown-menu').not($ul).hide();
		$ul.toggle();
		$ul.children('li').off('click');
		$ul.children('li').one('click', function(event) {
			console.log($(this).hasClass('active'))
			$(this).toggleClass('active');
			$toggleCur.text('已选'+$ul.find('.active').length+'个'+(flag?"电站":"电站组"));
			$ul.show().hide();
		});
	});

	var invitePersonRowCount = 0;
	$('#add_row').click(function() {
		invitePersonRowCount++;
		$('#invitePersonRow').find('.invite_name').attr('name', 'invite_name'+invitePersonRowCount);
		$('#invitePersonRow').find('.invite_mobile').attr('name', 'invite_mobile'+invitePersonRowCount);
		$('#invitePersonTable').append($('#invitePersonRow').clone().removeAttr('id'));
	});

	jQuery.extend(jQuery.validator.messages, {
		//required:'必填项',
		//mobile: '手机号码不合法',
	});
	var validatorUpdateAuthForm = $('#updateAuthForm').validate({
		messages: {
			/** 'mobile': {
				mobile: "手机号码不合法"
			}*/
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

	$('#invitePersonTable').on('click', '.del_row', function(event) {
		$(this).parents('tr').remove();
	});

	//邀请人员
	$('#PpdateAuthComUserRelBtn').click(function(event) {
		var $btn = $(this);
		if (validatorUpdateAuthForm.form()) {
			$btn.button('loading');
			var formParam = [];
			var isValid = true;
			$("#invitePersonTable").find("tr").each(function(){
				var stations = [], groups = [];
				$(this).find('.multi-one .active').each(function(index, el) {
					var obj = {
						pstationId: $(this).attr('data-id'),
						flag: $(this).attr('data-flag')
					};
					stations.push(obj);
				});
				$(this).find('.multi-group .active').each(function(index, el) {
					var obj = {
						groupId: $(this).attr('data-id')
					};
					groups.push(obj);
				});
				if(stations.length ==0 && groups.length ==0){
					isValid = false;
				}
				var roleid = $(this).find('.dropdown-one .active').attr('data-roleId');
				if(!roleid){
					isValid = false;
				}
				var trRow = {
					deptid: $('#invitePersonTable').attr('data-deptid'),
					realname: $(this).find('.invite_name').val(),
					phone: $(this).find('.invite_tel').val(),
					roleid: roleid,
					aursrs: stations,
					authUserRoleGroupStationRels: groups
				};
				formParam.push(trRow);
			});
			
			if(!isValid){
				alert('请选择角色或者电站');
				$btn.button('reset');
				return;
			}
			$("#invitePersonTotaldata").val(JSON.stringify(formParam));

			$.ajax({
				url: '${ctx}/authComUserRel/updateAuthComUserRel.htm',
				type: 'POST',
				data: {
					data: $("#invitePersonTotaldata").val()
				}
			})
			.done(function(res) {//0 网络错误
				console.log(res.key)
				if (res.key==1){
					console.log('新增失败');
					promptObj('error', '', '新增失败');
				} else if(res.key==2){
					console.log('新增成功');
					promptObj('success', '', '新增成功');
					$('#invitePersonPop').modal('hide');
					$('.curSelectedNode').trigger('click');
				} else if(res.key==3){
					console.log('已经被邀请');
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
</script>
