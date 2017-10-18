//表单控件要添加验证的类
jQuery.validator.addClassRules('valid-required', {
	required: true
});
jQuery.validator.addClassRules('valid-email', {
	email: true
});
jQuery.validator.addClassRules('valid-tel', {
	mobile: true
});
//最小6位密码
jQuery.validator.addClassRules('valid-minlengthPass', {
	required: true,
	minlength: 6
});
//6位数字验证码
jQuery.validator.addClassRules('valid-fourcode', {
	required: true,
	fourcode: true
});
//6位数字验证码
jQuery.validator.addClassRules('valid-sixcode', {
	required: true,
	sixcode: true
});
//企业名称长度
jQuery.validator.addClassRules('valid-companyLength', {
	companyName: true
});

//1-11位数字字母(部门角色编码)
jQuery.validator.addClassRules('valid-roleCode', {
	abcNum: true
});

//表单验证
jQuery.validator.formValid = function(validForm) {
	var validator = $(validForm).validate({
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
	return validator;
}
