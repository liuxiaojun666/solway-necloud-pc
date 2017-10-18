
    <link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<!-- list -->
<script type="text/javascript">
	
	getMenuTreeNav();
	function getMenuTreeNav() {
		$.ajax({
					type : "post",
					url : "/NECloud/UserAuthHandle/getRightListForPCBySessionNew.htm",
					dataType : "json",
					async : false,
					success : function(res) {
						console.log(res);
						if(!res || !res.result || !res.rightlist) return;
						var msg = res.rightlist;
						$('#li').html("");
						var t = $('#li').html();
						var index = 0;
						for (var i = 0; i < msg.length; i++) {
							if (msg[i].uisref == null || msg[i].uisref == "") {
								if (i != 0) {
									t += '<li class="line dk"></li>';
								}
								t = t + '<li class="'+msg[i].stylename+'"><span class="nav-title">'
										+ msg[i].rightName + '</span></li>';
							} else {
								if(index==0){
									t = t+'<li ui-sref-active="active">';
								}else{
									t = t+ '<li style="margin-top:2px" ui-sref-active="active">';
								}
										
								t=t+ '<a ui-sref="'+msg[i].uisref+'">'
										+ '<i class="'+msg[i].stylename+'"></i>'
										+ '<span >'
										+ msg[i].rightName
										+ '</span>'
										+ '</a>'
										+ '<ul class="nav nav-sub no-hover dk" style="width:150px;margin-left:-30px;margin-top:2px;">'
										+ '<li class="nav-sub-header"> <a ui-sref="'+msg[i].uisref+'">'
										+ '<span>' + msg[i].rightName
										+ '</span></a></li></ul>' + '</li>';
								index++;
							}
						}
						t += '<li class="line dk hidden-folded"></li>';
						$('#li').html(t);
						//动态添加汇流箱，逆变器
						$('.icon_huiliuxiang').html("&#xe607")
						$('.icon_nibianqi').html("&#xe606")
						$('.icon_xiangbian').html("&#xe602")
					}
				});
	}
	$('#li').on('click', '.active', function(event) {
		$(this).addClass('active1').siblings().removeClass('active1');
	});
</script>
<!-- <span class="icon_huiliuxiang">123</span> -->
<ul id="li" class="nav" style="padding: 0px 10px;">
</ul>
 <!-- --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%> -->
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<link rel="stylesheet" href="./theme/css/tpl/nav.css">
<!-- list -->
<script type="text/javascript">
var hre = window.location.href + "?";
var nowid;
getMenuTreeNav();
function getMenuTreeNav() {
	$.ajax({
		type : "post",
		url : "/NECloud/UserAuthHandle/getRightListForPCBySessionNew.htm",
		dataType : "json",
		async : false,
		success : function(res) {
			//console.log(res);
			if(!res || !res.result || !res.rightlist) return;
			var msg = res.rightlist;
			var newArr = [];
			for (var i = 0; i < msg.length; i++) {
				if(msg[i].parentRightId == null){
					msg[i].childItems = [];
					newArr.push(msg[i]);
				}
			}
			
			for(var i = 0;i<newArr.length;i++){
				if(newArr[i].rightId != null){
					for(var j = 0;j<msg.length;j++){
						if(msg[j].parentRightId == newArr[i].rightId){
							newArr[i].childItems.push(msg[j]);
						}
					}
				}
			}
			$('#accordion').html("");
			var tpl = $('#accordion').html();
			tpl += '<a href class="btn no-shadow navbar-btn" style="width:100%;padding:0;padding-right: 16px" ng-click="app.settings.asideFolded = !app.settings.asideFolded">'+
				'<img src="theme/images/datang/common/menu-open-icon.png">'+
				'</a>';
			for(var i = 0;i<newArr.length;i++){
				
				if((newArr[i].childItems).length<=0){
					tpl += '<li class="nav-li">'+
								'<div class="panel-heading" >'+
									'<h4 class="panel-title">'+
										'<a class="nav-title">'+
											(newArr[i].rightName)+
										'</a>'+
									'</h4>'+
								'</div>'+
							'</li>';
				}else{
					tpl += '<li class="nav-li" id ="fs'+newArr[i].rightId+'">'+
								'<div class="panel-heading" ng-mouseover="headerIndex='+i+'" ng-mouseleave="headerIndex = null">'+
									'<h4 class="panel-title">'+
										'<a data-toggle="collapse" data-parent="#accordion"  data-target="#firstmenu'+newArr[i].rightId+'"  class="nav-title">'+
											'<span ng-show="!app.settings.asideFolded">'+newArr[i].rightName+'</span>'+
											'<span ng-show="app.settings.asideFolded">'+newArr[i].rightNameSimple+'</span>'+
											'<span class="arrow-right arrow-mark"></span>'+
											'<span ng-show="headerIndex == '+i+' && app.settings.asideFolded" class="hover-tip">'+newArr[i].rightName+
												'<span class="diy-triangle"></span>'+
											'</span>'+
										'</a>'+
									'</h4>'+
								'</div>'+
								'<div id="firstmenu'+newArr[i].rightId+'" class="mark panel-collapse collapse">';
									for(var j = 0;j<newArr[i].childItems.length;j++){
										if(newArr[i].childItems[j].uiurl){
											if(hre.indexOf(newArr[i].childItems[j].uiurl +"?") > 0){
												nowid = newArr[i].rightId;
											}
										}
										if(newArr[i].childItems[j].stylename){
											tpl += '<a class="panel-body child-item" ng-mouseover="childIndex = '+j+'" ng-mouseleave="childIndex = null" ui-sref="'+newArr[i].childItems[j].uisref+'"  ui-sref-active="active"  onclick="setStyle('+newArr[i].rightId+')">'+
											'<i class="'+newArr[i].childItems[j].stylename+'"></i>'+
											'<span ng-show="!app.settings.asideFolded">'+newArr[i].childItems[j].rightName+'</span>'+
											'<span ng-show="childIndex == '+j+' && app.settings.asideFolded" class="hover-tip-child">'+newArr[i].childItems[j].rightName+
												'<span class="diy-triangle-child"></span>'+
											'</span>'+
											'</a>';
										}else{
											tpl += '<a class="panel-body child-item" ng-mouseover="childIndex = '+j+'" ng-mouseleave="childIndex = null">'+
											'<span ng-show="!app.settings.asideFolded">'+newArr[i].childItems[j].rightName+'</span>'+
											'<span ng-show="app.settings.asideFolded">'+newArr[i].childItems[j].rightNameSimple+'</span>'+
											'<span ng-show="childIndex == '+j+' && app.settings.asideFolded" class="hover-tip-child">'+newArr[i].childItems[j].rightName+
												'<span class="diy-triangle-child"></span>'+
											'</span>'+
											'</a>';
										}
									}
					tpl += 	'</div>'+
							'</li>';			
									
				}
				
			}
			$('#accordion').html(tpl);
			
			var $liArr = $(".nav-li");
			
			$("#accordion").on("click","li", function(e) {
				$(this).siblings().children(".mark").addClass("collapse").removeClass("in");
				for(var i = 0;i<$liArr.length;i++){
					var ins =false;
					if($(this).attr("id")==$liArr.eq(i).attr("id")){
						ins = !$liArr.eq(i).children(".mark").hasClass("in");
					}
					
					var $liArr2 = $liArr.eq(i).children(".mark").children(".panel-body");
					var xz = false;
					for(var j = 0;j<$liArr2.length;j++){
						if($liArr2.eq(j).hasClass("active")){
							xz = true;
							break;
						}
					}
					if(ins && xz){
						$liArr.eq(i).find(".arrow-mark").removeClass("arrow-down active-right arrow-right").addClass("active-down");
					}else if(!ins && xz){
						$liArr.eq(i).find(".arrow-mark").removeClass("arrow-down arrow-right active-down").addClass("active-right");
					}else if(ins && !xz){
						$liArr.eq(i).find(".arrow-mark").removeClass("arrow-right active-right active-down").addClass("arrow-down");
					}else{
						$liArr.eq(i).find(".arrow-mark").removeClass("arrow-down active-right active-down").addClass("arrow-right");
					}
					
				}
				
				/**$(this).siblings().find(".arrow-mark").removeClass("arrow-down").addClass("arrow-right");
				for(var i = 0;i<$liArr.length;i++){
					if($liArr.eq(i).children(".mark").attr("id") == "firstmenu"+nowid){
						$liArr.eq(i).find(".arrow-mark").removeClass("active-down").addClass("active-right");
					}
				}
				if($(this).children(".mark").hasClass("in")){//当为展开时
					if($(this).children(".mark").attr("id") == "firstmenu"+nowid){
						$(this).find(".arrow-mark").removeClass("active-down").addClass("active-right");
					}else{
						$(this).find(".arrow-mark").removeClass("arrow-down").addClass("arrow-right");
					}
					
				}else{//当为折合时
					if($(this).children(".mark").attr("id") == "firstmenu"+nowid){
						$(this).find(".arrow-mark").removeClass("active-right").addClass("active-down");
					}else{
						$(this).find(".arrow-mark").removeClass("arrow-right").addClass("arrow-down");
					}
				}*/
			 });
			$("#accordion").on("click",".panel-body", function(e) {
				e.stopPropagation();
				e.preventDefault();
			});
			
			//动态添加汇流箱，逆变器
			$('.icon_huiliuxiang').html("&#xe607")
			$('.icon_nibianqi').html("&#xe606")
			$('.icon_xiangbian').html("&#xe602")
			$("#firstmenu" + nowid).removeClass('collapse').addClass("in");
			
			$(".arrow-mark").removeClass("arrow-down active-right active-down");
			$("#firstmenu" + nowid).parent().find(".arrow-mark").addClass("active-down");
		}
		
		
	});
}

function setStyle(id){
	var $liArr = $(".nav-li");
	for(var i = 0;i<$liArr.length;i++){
		var ins = $liArr.eq(i).children(".mark").hasClass("in");
		var xz = false;
		
		if(('fs' + id) == $liArr.eq(i).attr("id")){
			xz = true;
		}
		if(ins && xz){
			$liArr.eq(i).find(".arrow-mark").removeClass("arrow-down active-right arrow-right").addClass("active-down");
		}else if(!ins && xz){
			$liArr.eq(i).find(".arrow-mark").removeClass("arrow-down arrow-right active-down").addClass("active-right");
		}else if(ins && !xz){
			$liArr.eq(i).find(".arrow-mark").removeClass("arrow-right active-right active-down").addClass("arrow-down");
		}else{
			$liArr.eq(i).find(".arrow-mark").removeClass("arrow-down active-right active-down").addClass("arrow-right");
		}
		
	}
}
$(function(){
	//动态设置tip距页面顶端的距离
	
	$(".child-item").mouseover(function(){
		var top = $(this).offset().top;
		$(this).children(".hover-tip-child").css("top",top);
	});
	
	$(".panel-heading").mouseover(function(){
		var top = $(this).offset().top;
		$(this).find(".hover-tip").css("top",top);
	});
})
</script>
<ul  class="nav panel-group" id="accordion">
	<!-- <a href class="btn no-shadow navbar-btn" ng-click="app.settings.asideFolded = !app.settings.asideFolded" onclick="getTableWidth()">
		<i class="fa fa-dedent fa-fw"></i>
	</a> -->
</ul>


 