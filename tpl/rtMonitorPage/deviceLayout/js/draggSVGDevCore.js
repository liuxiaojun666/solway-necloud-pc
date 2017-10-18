//定义初始化方法
initDraggSVGDevCore = function() {
	//鼠标滑过 CSS
	$(".draggable").hover(
	  function () {
		  $(this).parents(".dragggroup").find('svg [name=select]').show();
		  $(this).find('svg [name=select]').show();
	  },
	  function () {
		  $(this).parents(".dragggroup").find('svg [name=select]').hide();
		  $(this).find('svg [name=select]').hide();
	  }
	);

	//初始化拖拽
	$(".draggable").draggable({
		containment: "#containment-wrapper",
		scroll: false,
		cursor: "move",
//		grid: [ 80, 80],
		snap: true
	});
	//确定拖拽中心
	$(".necloud_xiangbian").draggable({
		cursorAt: {top: 21,left: 36}
	});
	$(".necloud_huiliuxiang").draggable({
		cursorAt: {top: 21,left: 29}
	});
	$(".necloud_nibianqi").draggable({
		cursorAt: {top: 26,left: 16}
	});
	$(".necloud_nibianqi_huiliuxiang").draggable({
		cursorAt: {top: 21,left: 36}
	});

	d3.xml("tpl/rtMonitorPage/deviceLayout/css/svg_template/XB.svg", "image/svg+xml", //加载文件
		function(xml) {
		if($(".necloud_xiangbian").children('svg').length==0){
			$(".necloud_xiangbian").append(xml.documentElement); //添加DOM节点
		}
	});

	d3.xml("tpl/rtMonitorPage/deviceLayout/css/svg_template/HLX.svg", "image/svg+xml", //加载文件
		function(xml) {
		if($(".necloud_huiliuxiang").children('svg').length==0){
			$(".necloud_huiliuxiang").append(xml.documentElement); //添加DOM节点
		}
	});

	d3.xml("tpl/rtMonitorPage/deviceLayout/css/svg_template/NBQ.svg", "image/svg+xml", //加载文件
		function(xml) {
		if($(".necloud_nibianqi").children('svg').length==0){
			$(".necloud_nibianqi").append(xml.documentElement); //添加DOM节点
		}
	});

	d3.xml("tpl/rtMonitorPage/deviceLayout/css/svg_template/NBQHLX.svg", "image/svg+xml", //加载文件
		function(xml) {
			if($(".necloud_nibianqi_huiliuxiang").children('svg').length==0){
				$(".necloud_nibianqi_huiliuxiang").append(xml.documentElement); //添加DOM节点
			}
		});





	$(".draggable").draggable('disable');
}


$(document).ready(function () {
	//颜色常量
	BREAK = "#999", ALERT = "#f90", ERROR = "#db412f", NORMAL = "#3fad22", SELECT = "#15575f";
	initDraggSVGDevCore();
});
function switchColor (state){
	switch (state) {
	  case "break":
		COLOR = BREAK
		break;
	  case "alert":
	    COLOR = ALERT
	    break;
	  case "error":
	    COLOR = ERROR
	    break;
	  case "normal":
	    COLOR = NORMAL
	    break;
	  default:
	    COLOR = NORMAL
	}
	return COLOR;
}

//设置箱变
setNecloud_xiangbian = function(name, state) {

	COLOR = switchColor(state);
	g = $(".necloud_xiangbian[name=" + name + "] g")
			.attr("name",state);

	$(g).find("rect")
	  .attr("stroke", COLOR)
	  .attr("fill", COLOR);
	$(g).find("ellipse")
	  .attr("stroke", COLOR);

}

//设置逆变器
setNecloud_nibianqi = function(name, state) {

	COLOR = switchColor(state);
	g = $(".necloud_nibianqi[name=" + name + "] g")
			.attr("name",state);

	$(g).find("rect")
	  .attr("stroke", COLOR)
	  .attr("fill", COLOR);
	$(g).find("line")
	  .attr("stroke", COLOR);
	$(g).find("path")
	  .attr("stroke", COLOR);

}

//设置逆变器-汇流箱
setNecloud_nibianqi_huiliuxiang = function(name, state, shadowFlags, statuFlags, quickSelect) {
	console.info(shadowFlags);
	console.info(statuFlags);
	console.info(quickSelect);

	COLOR = switchColor(state);
	g1 = $(".necloud_nibianqi_huiliuxiang[name=" + name + "] g[type='nbq']")
		.attr("name",state);

	$(g1).find("rect")
		.attr("stroke", COLOR)
		.attr("fill", COLOR);
	$(g1).find("line")
		.attr("stroke", COLOR);
	$(g1).find("path")
		.attr("stroke", COLOR);

	g2 = $(".necloud_nibianqi_huiliuxiang[name=" + name + "] g[type='hlx']")
		.attr("name",state);
	zuchuan = $(g2).find("rect[name=zuchuan]");
	//组串状态位,0组串无效，1电流偏小(故障)，2电流偏大(告警)，3组串正常
	for(var n = 0; n < statuFlags.length; n++){
		if(1 == statuFlags[n]){
			$(zuchuan[n])
				.attr("stroke", ERROR)
				.attr("fill", ERROR).show();
		}
		if(2 == statuFlags[n]){
			$(zuchuan[n])
				.attr("stroke", ALERT)
				.attr("fill", ALERT).show();
		}
		if(!quickSelect){
			if(3 == statuFlags[n]){
				$(zuchuan[n])
					.attr("stroke", NORMAL)
					.attr("fill", NORMAL).show();
			}
		}
	}

	//组串遮挡标志位,0无遮挡，1有遮挡
	for(var n = 0; n < shadowFlags.length; n++){
		if(1 == shadowFlags[n]){
			$($(g2).find("rect[name=shadow]")[n+1]).show();
			$(".necloud_nibianqi_huiliuxiang[name=" + name + "] g[type='hlx']").attr("name",state+",shadow")
		}
	}

}

//设置汇流箱
setNecloud_huiliuxiang = function(name, state, shadowFlags, statuFlags, quickSelect) {

	COLOR = switchColor(state);
	g = $(".necloud_huiliuxiang[name=" + name + "] g")
			.attr("name",state);

	$($(g).find("rect[name!=shadow]")[0])
		.attr("stroke", COLOR)
		.attr("fill", COLOR).show();

	if(COLOR==BREAK){
		$(g).find("rect[name=shadow]").hide();
	}

	zuchuan = $(g).find("rect[name=zuchuan]");
	//组串状态位,0组串无效，1电流偏小(故障)，2电流偏大(告警)，3组串正常
	for(var n = 0; n < statuFlags.length; n++){
		if(1 == statuFlags[n]){
			$(zuchuan[n])
			.attr("stroke", ERROR)
			.attr("fill", ERROR).show();
		}
		if(2 == statuFlags[n]){
			$(zuchuan[n])
			.attr("stroke", ALERT)
			.attr("fill", ALERT).show();
		}
		if(!quickSelect){
			if(3 == statuFlags[n]){
				$(zuchuan[n])
				.attr("stroke", NORMAL)
				.attr("fill", NORMAL).show();
			}
		}
	}

	//组串遮挡标志位,0无遮挡，1有遮挡
	for(var n = 0; n < shadowFlags.length; n++){
		if(1 == shadowFlags[n]){
			$($(g).find("rect[name=shadow]")[n+1]).show();
			$(".necloud_huiliuxiang[name=" + name + "] g").attr("name",state+",shadow")
		}
	}

}

//清空显示
cleanNecloud_dev = function(quickSelect){

	COLOR = NORMAL

	//B
	$(".necloud_xiangbian g rect")
	.attr("stroke", COLOR)
	.attr("fill", COLOR);
	$(".necloud_xiangbian g ellipse")
	.attr("stroke", COLOR);
	//I
	$(".necloud_nibianqi g rect")
	.attr("stroke", COLOR)
	.attr("fill", COLOR);
	$(".necloud_nibianqi g line")
	.attr("stroke", COLOR);
	$(".necloud_nibianqi g path")
	.attr("stroke", COLOR);
	//J
	$(".necloud_huiliuxiang g rect[name!=shadow]")
	.attr("stroke", COLOR)
	.attr("fill", COLOR);
	if(!quickSelect){
		$(".necloud_huiliuxiang g rect[name=shadow],[name=zuchuan]").hide();
	}else{
		$(".necloud_huiliuxiang g rect[name=shadow]").hide();
	}

	$(".necloud_nibianqi,.necloud_xiangbian,.necloud_huiliuxiang").attr("lang","");

}

