'use strict';


angular.module('app', [
    'ngAnimate',
//    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngTouch',
    'ngStorage',
    'ui.router',
    'ui.bootstrap',
    'ui.load',
    'ui.jq',
    'ui.validate',
    'oc.lazyLoad',
    'pascalprecht.translate'
]).directive('loadDone', function($timeout) {//界面加载后执行的方法
    return {
        link: function(scope, element, attrs) {
            	$timeout(function() {
            		scope.$eval(attrs.loadDone)    // 执行绑定的表达式
            	});
        }
    }
}).directive('repeatDone', function($timeout) {
    return {
        link: function(scope, element, attrs) {
            if (scope.$last) {                   // 这个判断意味着最后一个 OK
            	$timeout(function() {
            		scope.$eval(attrs.repeatDone)    // 执行绑定的表达式
            	});
            }
        }
    }
}).directive('onFinishRender', function ($timeout) {
	return {
		restrict: 'A',
		link: function(scope, element, attr) {
			if (scope.$last === true) {
				$timeout(function() {
					scope.$emit('onFinishRender');
				});
			}
		}
	};
}).filter("companyInfoFilter", function(){
	return function (input, def){
		if(input == undefined){
			return def;
		}
		return input;
	}
}).filter("replaceBrFilter", function(){ //将返回的文本换行转换成标签br
	return function (value){
		var newValue = "";
		if(value != undefined && value != null && value != ""){
			newValue = value.replace(/\n/g, '<br />');
		}
		return newValue;
	}
}).filter("dataNullFilter",function(){//判断为空
    return function(data){
    	var dataIsNull="-";
    	if(data !== null && data !== undefined && data !== ''){
    		dataIsNull=data
    	}
		return dataIsNull;
    }
}).filter("dataNull0Filter",function(){//判断为空则显示为0
    return function(data){
    	var dataIsNull="0";
    	if(data !== null && data !== undefined && data !== ''){
    		dataIsNull=data
    	}
		return dataIsNull;
    }
}).filter("incomeFilter",function(){//计算收入
    return function(data){
    	var dataIsNull="0元";
    	if(data !== null && data !== undefined && data !== ''){
    		if((data[1]+"").indexOf('万') >= 0){
    			return (data[0] * 1.2).toFixed(0) + "万元";
    		}else{
    			return (data[0] * 1.2).toFixed(0) + "元";
    		}
    	}
		return dataIsNull;
    }
}).filter("dateFilter",function(){//时间过滤器
    return function(data){
    	var countDate;
		var date2= (new Date).getTime();  //开始时间
		var date1=data;    //结束时间
		var date3=date2-date1  //时间差的毫秒数

		//计算出相差天数
		var days=Math.floor(date3/(24*3600*1000))

		//计算出小时数
		var leave1=date3%(24*3600*1000)

		//计算天数后剩余的毫秒数
		var hours=Math.floor(leave1/(3600*1000))

		//计算相差分钟数
		var leave2=leave1%(3600*1000)

		//计算小时数后剩余的毫秒数
		var minutes=Math.floor(leave2/(60*1000))

		//计算相差秒数
		var leave3=leave2%(60*1000)

		//计算分钟数后剩余的毫秒数
		var seconds=Math.round(leave3/1000);

		if(date3<=60*1000){
			countDate="刚刚";
		}else if(days>=1){
			countDate=FormatDate(date1)
			//countDate=days+"天 "+hours+"小时 "+minutes+"分钟前"
		}else {
			if(hours>0&&hours<=24){
				countDate=hours+"小时 "+minutes+"分钟前"
			}else{
				if(minutes>=1&&minutes<=60){
					countDate=minutes+"分钟前";
				}
			}
		}
		return countDate;
    }
}).filter("sDecimalFilter", function(){
	return function (decimal, num){
		if(decimal===undefined || decimal==="" || decimal ===null && decimal ==="-"){
			return "-";
		}
		decimal = (decimal + "").split(".");
		if (!decimal[1]){
			return decimal[0] + "." + getNumZero(num);
		}

		var len = decimal[1].length;
		if (len <= num){
			return decimal[0] + "." + decimal[1] + getNumZero(num - len);
		}
		return decimal[0] + "." + decimal[1].substr(0, num);
	};

	function getNumZero(num){
		var zero = "";
		for (var i=0;i<num;i++){
			zero += "0";
		}
		return zero;
	}
}).filter("dateFormat", function () {
	return function (date, fmt) {
		var d = new Date(date);
		var o = {
			"M+" : d.getMonth() + 1, //月份
			"d+" : d.getDate(), //日
			"h+" : d.getHours(), //小时
			"m+" : d.getMinutes(), //分
			"s+" : d.getSeconds(), //秒
			"q+" : Math.floor((d.getMonth() + 3) / 3), //季度
			"S" : d.getMilliseconds()
		};

		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (d.getFullYear() + "")
				.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
					: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	};
}).factory('paramsData', function () {
	var params = {};
	return {
		get: function (key, flag) {
			var v = params[key];
			if (typeof (flag) == 'boolean') {
				if (flag) {
					this.remove(key);
				}
			} else {
				this.remove(key);
			}
			return v;
		},
		put: function (key, object) {
			params[key] = object;
		},
		remove: function (key) {
			delete params[key];
		}
	};
});


function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
}
/*
 *高级查询条件展开
 */
function showSearch(){
	var state=$(".hideSearchDiv").css('display');
	if(state=="none"){
		$(".hideSearchDiv").slideDown("slow");
		$(".searchTitle").html("<button class='btn btn-sm  btn-default'> 收起</button>");
	}else{
		$(".hideSearchDiv").slideUp("slow");
		$(".searchTitle").html("<button class='btn btn-sm  btn-default'>更多查询</button>");
	}
}
function deleteDiv(obj){
	$(obj).parents(".panel-default").css("display","none");
}
function changeCheck(obj,className){
	$(obj).siblings().children().removeClass(className);
	$(obj).children().addClass(className);
}
//隐藏显示返回上一级
function showGoBackFlag(){
	$("#go-back-flag").css("display","inline-block")
}
function hideGoBackFlag(){
	$("#go-back-flag").css("display","none")
}

function changeCheck(obj,className){
	$(obj).siblings().children().removeClass(className);
	$(obj).children().addClass(className);
}
function arrFromNullToEmpty(arr) {
	for (var i = 0; i < arr.length; i++) {
		if (arr[i] === null) {
			arr[i] = '';
		}
	}
}
//增加map
function MapDef(){
	//初始化map_，给map_对象增加方法，使map_像个Map
    var map_=new Object();
    //属性加个特殊字符，以区别方法名，统一加下划线_
    map_.put=function(key,value){    map_[key]=value;}
    map_.get=function(key){    return map_[key];}
    map_.remove=function(key){    delete map_[key];}
    map_.keyset=function(){
        var ret="";
        for(var p in map_){
            if(typeof p =='string' && p.substring(p.length-1)=="_"){
                ret+=",";
                ret+=p;
            }
        }
        if(ret==""){
            return ret.split(","); //empty array
        }else{
            return ret.substring(1).split(",");
        }
    }
    return map_;
}

Date.prototype.Format = function(fmt) { //author: meizz
	var o = {
		"M+" : this.getMonth() + 1, //月份
		"d+" : this.getDate(), //日
		"h+" : this.getHours(), //小时
		"m+" : this.getMinutes(), //分
		"s+" : this.getSeconds(), //秒
		"q+" : Math.floor((this.getMonth() + 3) / 3), //季度
		"S" : this.getMilliseconds()
		//毫秒
	};
	if (/(y+)/.test(fmt))
		fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
			.substr(4 - RegExp.$1.length));
	for ( var k in o)
		if (new RegExp("(" + k + ")").test(fmt))
			fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
				: (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}
