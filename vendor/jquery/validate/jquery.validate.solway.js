// 手机号码验证
jQuery.validator.addMethod("mobile", function(value, element) {
	var length = value.length;
	return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
 }, "请检查您的手机号码");

//电话号码验证
jQuery.validator.addMethod("phone", function(value, element) {
	var ph = /(^[0-9]{3,4}\-[0-9]{7,8}$)|(^[0-9]{7,8}$)|(^\([0-9]{3,4}\)[0-9]{7,8}$)|(^[0-9]{3,4}\-[0-9]{7,8}\-[0-9]{1,4}$)|(^0{0,1}13[0-9]{9}$)|(^0{0,1}15[0-9]{9}$)|(^0{0,1}18[0-9]{9}$)/;
	return this.optional(element) || (ph.test(value));
}, "请检查您的电话号码");

//传真号码验证
jQuery.validator.addMethod("fax", function(value, element) {
	var ph =  /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
	return this.optional(element) || (ph.test(value));
}, "请检查您的传真号码");

//邮政编码验证
jQuery.validator.addMethod("zipcode", function(value, element) {
	var tel = /^[1-9]{1}[0-9]{5}$/;
	return this.optional(element) || (tel.test(value));
}, "请检查您的邮政编码");

//4位数字 随机验证码
jQuery.validator.addMethod("fourcode", function(value, element) {
	var tel = /^\d{4}$/;
	return this.optional(element) || (tel.test(value));
}, "请检查您的随机验证码");

//6位数字 手机验证码
jQuery.validator.addMethod("sixcode", function(value, element) {
	var tel = /^\d{6}$/;
	return this.optional(element) || (tel.test(value));
}, "请检查您的验证码");

//最长不得超过50个汉字，或100个字节(数字，字母和下划线)正则表达式
jQuery.validator.addMethod("companyName", function(value, element) {
	var tel = /^[\u4e00-\u9fa5_a-zA-Z0-9_]{1,100}$/;
	return this.optional(element) || (tel.test(value));
}, "您输入的企业名称太长");

//1-11数字、字母
jQuery.validator.addMethod("abcNum", function(value, element) {
	var pattern = /^[A-Za-z0-9]{1,11}$/;
	return this.optional(element) || (pattern.test(value));
}, "请输入1-11个字符");


//身份证
jQuery.validator.addMethod("idcard",function(value,element){
	if ( this.optional(element) )
		return "dependency-mismatch";
	if(value.length != 15 && value.length != 18) return false;//"身份证号共有 15 码或18位";
	var Ai=value.length==18?value.substring(0,17):value.slice(0,6)+"19"+value.slice(6,16);
	if (!/^\d+$/.test(Ai))  return false;//"身份证除最后一位外，必须为数字！";
	var yyyy=Ai.slice(6,10) ,  mm=Ai.slice(10,12)-1  ,  dd=Ai.slice(12,14);
	var d=new Date(yyyy,mm,dd) ,  now=new Date();
	var year=d.getFullYear() ,  mon=d.getMonth() , day=d.getDate();
	if (year!=yyyy || mon!=mm || day!=dd || d>now || year<1940) return false;//"身份证输入错误！";
	return true;
},"请检查您的身份证号码");

//身份证
jQuery.validator.addMethod("idCode",function(value,element){
	if ( this.optional(element) ){
		return "dependency-mismatch";
	}
	var exp = /(^[1-9]{1}[0-9]{14}$)|(^[1-9]{1}[0-9]{17}$)|(^[1-9]{1}[0-9]{16}X$)/;
	var reg = value.match(exp);
	if(reg==null){
		return false;
	}
	var inYear = (value.length==18)?value.substring(6,10):"19"+value.substring(6,8); 
	var inMonth = (value.length==18)?value.substring(10,12)-1:value.substring(8,10)-1; 
	var inDay = (value.length==18)?value.substring(12,14):value.substring(10,12); 
	var d = new Date(inYear,inMonth,inDay);
	var now = new Date();
	var year = d.getFullYear();
	var month = d.getMonth();
	var day = d.getDate();
	if (inYear!=year || inMonth!=month || inDay!=day || d>now || year<1800) return false;
	return true;
},"请检查您的身份证号码");

//驾驶证号
jQuery.validator.addMethod("driverId",function(value,element){
	var exp = /(^[1-9]{1}[0-9]{11,14}$)/;
	return this.optional(element) || (exp.test(value));
},"请检查您的驾驶证号");

//IP验证
jQuery.validator.addMethod("ip", function(value, element) {
	var tel =/^((2[0-4]\d|25[0-5]|[01]?\d\d?)\.){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)$/;
	return this.optional(element) || (tel.test(value));
}, "请检查IP地址");

//域名验证
jQuery.validator.addMethod("domain", function(value, element) {
	var tel =/^(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/;
	return this.optional(element) || (tel.test(value));
}, "请检查服务器地址");

//小数位数
jQuery.validator.addMethod("decimal", function(value, element) {
	var decimal = /^-?\d+(\.\d{1,1})?$/;
	return this.optional(element) || (decimal.test(value));
},"值为数值型,小数位数不能超过一位!");

//小数位数
jQuery.validator.addMethod("decimal2", function(value, element) {
	var decimal = /^-?\d+(\.\d{1,2})?$/;
	return this.optional(element) || (decimal.test(value));
},"值为数值型,小数位数不能超过二位!");