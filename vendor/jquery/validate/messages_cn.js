/*
 * Translated default messages for the jQuery validation plugin.
 * Language: CN
 * Author: Fayland Lam <fayland at gmail dot com>
 */
//baseUrl,如果应用的部署没有contextPath，将此处的baseUrl改成/
var pathName = window.location.pathname;
var baseUrl = pathName.substr(0,pathName.substr(1).indexOf("/")+1);
jQuery.extend(jQuery.validator.messages, {
	
//	required: "&nbsp;<img src='"+baseUrl+"/images/validator/check_n.gif' width=16 height=16>&nbsp;必填项",

//TODO:迁移校验框架后放开
//		required: "必填项",
//		remote: "值重复",
//		email: "请检查电子邮件",
//		url: "请检查网址",
//		date: "请检查日期",
//		dateISO: "请检查日期 (ISO).",
//		number: "请检查数字",
//		digits: "只能输入整数",
//		creditcard: "请检查的信用卡号",
//		equalTo: "请再次输入相同的值",
//		accept: "请输入拥有合法后缀名的字符串",
//		zipcode:"请检查邮政编码",
//		mobile:"请检查手机号码",
//		phone:"请检查电话号码",

	required:'必填项',
	email:'请检查电子邮件',
	url:'请检查网址',
	date:'请检查日期',
	dateISO:'请检查日期 (ISO)',
	number:'请检查数字',
	digits:'只能输入整数',
	creditcard:'请检查的信用卡号',
	equalTo:'请再次输入相同的值',
	accept:'请输入拥有合法后缀名的字符串',
	zipcode:'请检查邮政编码',
	mobile:'请检查手机号码',
	phone:'请检查电话号码',

	maxlength: jQuery.validator.format("最多 {0}个字符"),
	minlength: jQuery.validator.format("最少 {0} 个字符"),
	rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
	range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
	min: jQuery.validator.format("请输入一个最小为 {0} 的值")

});
function errorPlacement(error, element) {
    element.wrap('<div style="display:inline-block;width:100%;position:relative;"/>').parent().append('<span style="position:absolute;bottom:-16px;left:5px;font-size:12px;color:red;"/>').find('span').append(error)
}
