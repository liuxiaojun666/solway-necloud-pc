app.directive('onFinishRenderFilters', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
            if (scope.$last === true) {
                $timeout(function() {
                    scope.$emit('ngRepeatFinished');
                });
            }
        }
    };
});

//编辑开关
svgEditOnOff = function(legendICO){
	$(legendICO).find('i:eq(0)').hide();
	$(legendICO).find('i:eq(1)').show();
	$(".draggable").unbind("click");
	$(".draggable").draggable('enable');
}

//图例状态过滤开关
selectDevStatusLegend_All = function(legendICO){
	if($(legendICO).find('i:eq(0)').is(":visible")==true){
		$(legendICO).find('i:eq(0)').hide();
		$(legendICO).find('i:eq(1)').show();
		$(legendICO).parent().prev().children().find('i:eq(0)').hide();
		$(legendICO).parent().prev().children().find('i:eq(1)').show();
		//设置设备
		$(".draggable").filter(".necloud_huiliuxiang,.necloud_nibianqi,.necloud_xiangbian,.necloud_nibianqi_huiliuxiang").show()
	}else{
		$(legendICO).find('i:eq(0)').show();
		$(legendICO).find('i:eq(1)').hide();
		$(legendICO).parent().prev().children().find('i:eq(0)').show();
		$(legendICO).parent().prev().children().find('i:eq(1)').hide();
		//设置设备
		$(".draggable").filter(".necloud_huiliuxiang,.necloud_nibianqi,.necloud_xiangbian,.necloud_nibianqi_huiliuxiang").hide()
	}
}
selectDevStatusLegend = function(legendICO,status){
	if($(legendICO).find('i:eq(0)').is(":visible")==true){
		$(legendICO).find('i:eq(0)').hide();
		$(legendICO).find('i:eq(1)').show();
		if($(legendICO).siblings().find('i:eq(0)').is(":visible")==true){
			$(legendICO).parent().next().children().find('i:eq(0)').show();
			$(legendICO).parent().next().children().find('i:eq(1)').hide();
		}else{
			$(legendICO).parent().next().children().find('i:eq(0)').hide();
			$(legendICO).parent().next().children().find('i:eq(1)').show();
		}
		//设置设备
		$("g[name*="+status+"]").parents('div.draggable').show();
	}else{
		$(legendICO).find('i:eq(0)').show();
		$(legendICO).find('i:eq(1)').hide();
		$(legendICO).parent().next().children().find('i:eq(0)').show();
		$(legendICO).parent().next().children().find('i:eq(1)').hide();
		//设置设备
		$("g[name*="+status+"]").parents('div.draggable').hide();
		
		if(status != 'shadow'){
			if($("#legendICO5").find('i:eq(1)').is(":visible")){
				$("g[name*='shadow']").parents('div.draggable').show();
			}
		}else{
			if($("#legendICO1").find('i:eq(1)').is(":visible")){
				$("g[name*='normal']").parents('div.draggable').show();
			}
			if($("#legendICO2").find('i:eq(1)').is(":visible")){
				$("g[name*='error']").parents('div.draggable').show();
			}
			if($("#legendICO3").find('i:eq(1)').is(":visible")){
				$("g[name*='alert']").parents('div.draggable').show();
			}
			if($("#legendICO4").find('i:eq(1)').is(":visible")){
				$("g[name*='break']").parents('div.draggable').show();
			}
		}
	}

	//设置设备
}

selectDevStatusLegendForTask = function(){
	
	if($("#legendICO0").find('i:eq(0)').is(":visible")){
		if($("#legendICO1").find('i:eq(1)').is(":visible")){
			$("g[name*='normal']").parents('div.draggable').show();
		}else{
			$("g[name*='normal']").parents('div.draggable').hide();
		}
		if($("#legendICO2").find('i:eq(1)').is(":visible")){
			$("g[name*='error']").parents('div.draggable').show();
		}else{
			$("g[name*='error']").parents('div.draggable').hide();
		}
		if($("#legendICO3").find('i:eq(1)').is(":visible")){
			$("g[name*='alert']").parents('div.draggable').show();
		}else{
			$("g[name*='alert']").parents('div.draggable').hide();
		}
		if($("#legendICO4").find('i:eq(1)').is(":visible")){
			$("g[name*='break']").parents('div.draggable').show();
		}else{
			$("g[name*='break']").parents('div.draggable').hide();
		}
		if($("#legendICO5").find('i:eq(1)').is(":visible")){
			$("g[name*='shadow']").parents('div.draggable').show();
		}
	}
	
}

//重绘故障设备
reFlashDraggSVGDevCore = function(data,quickSelect) {

	cleanNecloud_dev(quickSelect);
	var b_alertNum = 0, b_errorNum = 0, b_breakNum = 0, b_normalNum = 0,
			i_alertNum = 0, i_errorNum = 0, i_breakNum = 0, i_normalNum = 0,
			j_alertNum = 0, j_errorNum = 0, j_breakNum = 0, j_normalNum = 0;
	
	//箱变
	var r_blist = data.boxChangeRtDataBatchList;
	if(r_blist != null){
		for(var n = 0; n < r_blist.length; n++){
			//绘制SVG样式
			setNecloud_xiangbian(r_blist[n].serialnumber,r_blist[n].comm_status);
			//统计数量
			if("alert" == r_blist[n].comm_status){++b_alertNum;}
			else if("error" == r_blist[n].comm_status){++b_errorNum;}
			else if("break" == r_blist[n].comm_status){++b_breakNum;}
			else if("normal" == r_blist[n].comm_status){++b_normalNum;}
			else {++b_normalNum;}
			//中文提示
			$("div .necloud_xiangbian[name="+r_blist[n].serialnumber+"] p[name=status]").html(r_blist[n].statusDesc);
		}
	}
	//逆变器
	var r_ilist = data.inverterRtDataBatchList;
	if(r_ilist != null){
		for(var n = 0; n < r_ilist.length; n++){
			//绘制SVG样式
			setNecloud_nibianqi(r_ilist[n].serialnumber,r_ilist[n].comm_status);
			//绘制SVG样式
			setNecloud_nibianqi_huiliuxiang(r_ilist[n].serialnumber,r_ilist[n].comm_status,r_ilist[n].shadowFlags,r_ilist[n].statuFlags,quickSelect);
			//统计数量
			if("alert" == r_ilist[n].comm_status){++i_alertNum;}
			else if("error" == r_ilist[n].comm_status){++i_errorNum;}
			else if("break" == r_ilist[n].comm_status){++i_breakNum;}
			else if("normal" == r_ilist[n].comm_status){++i_normalNum;}
			else {++i_normalNum;}
			//中文提示
			$("div .necloud_nibianqi[name="+r_ilist[n].serialnumber+"] p[name=status]").html(r_ilist[n].statusDesc);
		}
	}
	//汇流箱
	var r_jlist = data.junctionBoxRtDataBatchList;
	if(r_jlist != null){
		for(var n = 0; n < r_jlist.length; n++){
			//绘制SVG样式
			setNecloud_huiliuxiang(r_jlist[n].serialnumber,r_jlist[n].comm_status,r_jlist[n].shadowFlags,r_jlist[n].statuFlags,quickSelect);
			//统计数量
			if("alert" == r_jlist[n].comm_status){++j_alertNum;}
			else if("error" == r_jlist[n].comm_status){++j_errorNum;}
			else if("break" == r_jlist[n].comm_status){++j_breakNum;}
			else if("normal" == r_jlist[n].comm_status){++j_normalNum;}
			else {++j_normalNum;}
			//中文提示
			$("div .necloud_huiliuxiang[name="+r_jlist[n].serialnumber+"] p[name=status]").html(r_jlist[n].statusDesc);
		}
	}

	if(!quickSelect){
		$("input[name=boxChangeRtDataBatchListNum_all]").val(b_normalNum+b_alertNum+b_errorNum+b_breakNum);
		$("input[name=inverterRtDataBatchListNum_all]").val(i_normalNum+i_alertNum+i_errorNum+i_breakNum);
		$("input[name=junctionBoxRtDataBatchListNum_all]").val(j_normalNum+j_alertNum+j_errorNum+j_breakNum);
	}else{
		b_normalNum = $("input[name=boxChangeRtDataBatchListNum_all]").val() - b_alertNum - b_errorNum - b_breakNum;
		i_normalNum = $("input[name=inverterRtDataBatchListNum_all]").val() - i_alertNum - i_errorNum - i_breakNum;
		j_normalNum = $("input[name=junctionBoxRtDataBatchListNum_all]").val() - j_alertNum - j_errorNum - j_breakNum;
	}

	//填写统计数量
	$("div[name=boxChangeRtDataBatchListNum] p span[name=alert]").html(b_alertNum);
	$("div[name=boxChangeRtDataBatchListNum] p span[name=error]").html(b_errorNum);
	$("div[name=boxChangeRtDataBatchListNum] p span[name=break]").html(b_breakNum);
	$("div[name=boxChangeRtDataBatchListNum] p span[name=normal]").html(b_normalNum);
	
	$("div[name=inverterRtDataBatchListNum] p span[name=alert]").html(i_alertNum);
	$("div[name=inverterRtDataBatchListNum] p span[name=error]").html(i_errorNum);
	$("div[name=inverterRtDataBatchListNum] p span[name=break]").html(i_breakNum);
	$("div[name=inverterRtDataBatchListNum] p span[name=normal]").html(i_normalNum);
	
	$("div[name=junctionBoxRtDataBatchListNum] p span[name=alert]").html(j_alertNum);
	$("div[name=junctionBoxRtDataBatchListNum] p span[name=error]").html(j_errorNum);
	$("div[name=junctionBoxRtDataBatchListNum] p span[name=break]").html(j_breakNum);
	$("div[name=junctionBoxRtDataBatchListNum] p span[name=normal]").html(j_normalNum);

	$("i[name=zuchuanLoading]").hide();
}

cleanNecloud_dev2 = function(quickSelect){
	
	var COLOR = NORMAL
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

	//$(".necloud_nibianqi,.necloud_xiangbian,.necloud_huiliuxiang").attr("lang","");
	
	$(".necloud_huiliuxiang g rect[name=shadow]").hide();
}
var v2 = 0;
reFlashDraggSVGDevCore2 = function(result,flag ,oldMapMap){
	//console.info('-----------' + new Date());
	var oldMap = oldMapMap.get("status");
	if(!oldMap){
		oldMap = new MapDef();
	}
	var oldMapsh = oldMapMap.get("shade");
	if(!oldMapsh){
		oldMapsh = new MapDef();
	}
	var map = new MapDef();
	var mapst = new MapDef();
	var mapsh = new MapDef();
	var mapsd = new MapDef();
	//cleanNecloud_dev2(flag);
	/**var b_alertNum = 0, b_errorNum = 0, b_breakNum = 0, b_normalNum = 0,
	i_alertNum = 0, i_errorNum = 0, i_breakNum = 0, i_normalNum = 0,
	j_alertNum = 0, j_errorNum = 0, j_breakNum = 0, j_normalNum = 0;*/
	var arr1 = [];
	var arr2 = [];
	var arr2i = [];
	var arr3 = [];
	var arr4 = [];
	var arr5 = [];
	var arr8 = [];
	var allBreakFlag;
	var nAllBreakFlag;
	if(result.junctionBoxRtDataBatchList){
		arr1 = result.junctionBoxRtDataBatchList.serialnumber;
		arr2i = result.junctionBoxRtDataBatchList.comm_status;
		arr3 = result.junctionBoxRtDataBatchList.statusDesc;
		arr4 = result.junctionBoxRtDataBatchList.statuFlags;
		arr5 = result.junctionBoxRtDataBatchList.shadowFlags;
		arr8 = result.junctionBoxRtDataBatchList.s1s2;
		for(var i =0;i<result.junctionBoxRtDataBatchList.comm_status.length;i++){
			map.put(arr1[i],arr8[i]);
			mapst.put(arr1[i],arr4[i]);
			mapsh.put(arr1[i],arr5[i]);
			mapsd.put(arr1[i],arr3[i]);
			//arr2[i] = getColor(result.junctionBoxRtDataBatchList.comm_status[i]);
		}
		allBreakFlag = result.junctionBoxRtDataBatchList.allBreakFlag;
	}
	
	if(!flag){
		var arr6 = [];
		var arr7 = [];
		if(result.junctionBoxRtDataBatchList){
			arr6 = result.junctionBoxRtDataBatchList.statuFlagsY;
			arr7 = result.junctionBoxRtDataBatchList.serialnumberY;
		}
		$("g").attr("name" , "normal");
		$(".necloud_huiliuxiang g rect[name=zuchuan]").each(function(){
			var _id = $(this).parent().parent().parent().attr("name");
			var index = $.inArray(_id, arr7);
			if(index >= 0){
				var index2 = parseInt($(this).attr("z")) - 1;
				if($.inArray(index2, arr6[index]) >= 0){
					$(this).hide();
				}
			}
	    });


		var arr8 = [];
		var arr9 = [];
		if(result.inverterRtDataBatchList){
			arr8 = result.inverterRtDataBatchList.statuFlagsY;
			arr9 = result.inverterRtDataBatchList.serialnumberY;
		}
		$('.necloud_nibianqi_huiliuxiang').each(function(i, iv){
			var _name = $(this).attr("name");
			var index = $.inArray(_name, arr9)
			if (index >= 0) {
				//console.info(index + '___' + _name);
				$(this).find('g[type=hlx] rect[name=zuchuan]').each(function(j, jv){
					if ($.inArray(j, arr8[index]) >= 0) {
						//console.info(index + '___' + _name + '___' + j);
						$(this).hide();
					}
				})
			}
		});
		//$("input[name=junctionBoxRtDataBatchListNum_all]").val(arr1.length);
	}
	if(allBreakFlag == 1){
		//for(var l=0;l<sel.length;l++){
		$("rect[z=0]").attr("stroke", BREAK).attr("fill", BREAK);
		//$("p[name=statush]").html("通讯中断");
		//j_breakNum = $("input[name=junctionBoxRtDataBatchListNum_all]").val();
	}else{
		/**for(var k=0;k<breakSN.length;k++){
			var sel = $("#"+ breakSN[k] + " rect[z=0]");
			sel.attr("stroke", BREAK).attr("fill", BREAK);
			$("#"+ breakSN[k] + " p[name=statush]").html("通讯中断");
		}
		j_breakNum = breakSN.length;*/
	}
	
	$(".necloud_huiliuxiang").each(function(){
		var sn = $(this).attr("id");
		var newv = map.get(sn);
		if(newv){
			var oldv = oldMap.get(sn);
			if(newv != oldv){
				var s1s2listn = (newv+"").split("_");
				var s1s2listo = (oldv+"").split("_");
				var flagsh = s1s2listn[0];
				if(s1s2listn[0] != s1s2listo[0] && allBreakFlag != 1){
					$("#"+ sn + " rect[z=0]").attr("stroke", getColor(s1s2listn[0])).attr("fill", getColor(s1s2listn[0]));
					//$("#"+ sn + " p[name=statush]").html(mapsd.get(sn));
				}
				//$("#" + sn + " g rect[name=zuchuan]").attr("stroke", NORMAL).attr("fill", NORMAL);
				var num = 0;
				var isshadenew = false;
				var oldshs = oldMapsh.get(sn);
				var shs = mapsh.get(sn);
				var sts = mapst.get(sn);
				$("#" + sn + " g rect").each(function(){
					if(num >= 2){
						var vnum = num % 2;
						if(vnum == 1){
							var v = Math.floor(num / 2 - 1);
							
							var hidd = false;
							//var hidod = $(this).css("display");
							var hido = false;
							if(oldshs && oldshs[v] == 1){
								hido = true ;
							}
							if(shs[v] == 1){
								isshadenew = true;
								hidd = true ;
							}
							if(hidd != hido){
								if(hidd){
									$(this).show();
								}else{
									$(this).hide();
								}
							}
						}else{
							//var v = $(this).attr("z") - 1;
							var v = num / 2 - 1;
							var stszz ;
							if(sts[v] == 1){
								stszz = ERROR;
							}else if(sts[v] == 2) {
								stszz = ALERT;
							}else{
								stszz = NORMAL
							}
							var oldsts = $(this).attr("stroke");
							//oldsts = NORMAL;
							if(stszz != oldsts){
								$(this).attr("stroke", stszz).attr("fill", stszz);
							}
						}
					}
					num++;
					
			    }); 
				//重新绘制汇流箱的状态信息
				if(isshadenew){
					$("#"+ sn + " g").attr("name",flagsh+",shadow");
				}else{
					$("#"+ sn + " g").attr("name",flagsh);
				}
			}
		}else{
			var oldv = oldMap.get(sn);
			if(oldv){
				$("#"+ sn + " rect[z=0]").attr("stroke", NORMAL).attr("fill", NORMAL);
				$("#"+ sn + " g rect[name!=shadow]")
				.attr("stroke", NORMAL)
				.attr("fill", NORMAL);
				//$(".necloud_nibianqi,.necloud_xiangbian,.necloud_huiliuxiang").attr("lang","");
				$("#"+ sn + " g rect[name=shadow]").hide();
				$("#"+ sn + " g").attr("name","normal");
			}
		}
		//var index = $.inArray($(this).attr("id"), arr3);
		//console.log(index);
	});
	var xnmap = new MapDef();
	var mapsd = new MapDef();
	var mapst = new MapDef();
	var mapsh = new MapDef();
	var narr1 = [];
	var narr2 = [];
	var narr2i = [];
	var narr3 = [];
	var narr4 = [];
	var narr5 = [];
	var narr8 = [];
	if(result.inverterRtDataBatchList){
		narr1 = result.inverterRtDataBatchList.serialnumber;
		narr2i = result.inverterRtDataBatchList.comm_status;
		narr3 = result.inverterRtDataBatchList.statusDesc;


		narr4 = result.inverterRtDataBatchList.statuFlags;
		narr5 = result.inverterRtDataBatchList.shadowFlags;
		narr8 = result.inverterRtDataBatchList.s1s2;
		for(var i =0;i<result.inverterRtDataBatchList.comm_status.length;i++){
			map.put(narr1[i],narr2i[i]);
			xnmap.put(narr1[i],narr8[i]);//小逆变器（含组串）
			mapst.put(narr1[i],narr4[i]);
			mapsh.put(narr1[i],narr5[i]);
			mapsd.put(narr1[i],narr3[i]);
			//arr2[i] = getColor(result.junctionBoxRtDataBatchList.comm_status[i]);
		}

		nAllBreakFlag = result.inverterRtDataBatchList.allBreakFlag;
	}
	if(nAllBreakFlag == 1){
		$(".necloud_nibianqi_huiliuxiang g[type='nbq'] rect").attr("stroke", BREAK).attr("fill", BREAK);
		$(".necloud_nibianqi_huiliuxiang g[type='nbq'] path").attr("stroke", BREAK);
		$(".necloud_nibianqi_huiliuxiang g[type='nbq'] line").attr("stroke", BREAK);
	}

	//for(var i =0;i<narr1.length;i++){
		//map.put(narr1[i],narr2i[i]);
		//mapsd.put(narr1[i],narr3[i]);
	//}

	$(".necloud_nibianqi").each(function(){
		/**if("alert" == narr2i[k]){++i_alertNum;}
		else if("error" == narr2i[k]){++i_errorNum;}
		else if("break" == narr2i[k]){++i_breakNum;}*/
		var sn = $(this).attr("id");
		var newv = map.get(sn);
		
		var oldsts = $("#"+ sn + " g rect").attr("stroke");
		var newsts = getColor(newv);
		if(newsts != oldsts){
			$("#"+ sn + " g rect").attr("stroke", newsts);
			$("#"+ sn + " g line").attr("stroke", newsts);
			$("#"+ sn + " g path").attr("stroke", newsts);
			$("#"+ sn + " p[name=status]").html(mapsd.get(sn));
			$("#"+ sn + " g").attr("name",newv);
		}
	});

	//console.info('-------necloud_nibianqi_huiliuxiang');
	$(".necloud_nibianqi_huiliuxiang").each(function(){
		var sn = $(this).attr("id");
		var newv = xnmap.get(sn);
		if(newv){
			/*
			 */
			var oldv = oldMap.get(sn);
			//console.info(newv, oldv)
			if(newv != oldv){
				var s1s2listn = (newv+"").split("_");
				var s1s2listo = (oldv+"").split("_");
				var flagsh = s1s2listn[0];
				if(s1s2listn[0] != s1s2listo[0] && nAllBreakFlag != 1){
					$("#"+ sn + " g[type='nbq'] rect").attr("stroke", getColor(s1s2listn[0])).attr("fill", getColor(s1s2listn[0]));
					$("#"+ sn + " g[type='nbq'] path").attr("stroke", getColor(s1s2listn[0]));
					$("#"+ sn + " g[type='nbq'] line").attr("stroke", getColor(s1s2listn[0]));

					$("#"+ sn + " g[type='nbq'] ").attr("name",newv);
				}
				var isshadenew = false;
				var oldshs = oldMapsh.get(sn);
				var shs = mapsh.get(sn);
				var sts = mapst.get(sn);
				$("#" + sn + " g[type='hlx'] rect").each(function(i){
					var vnum = i % 2;
					if(vnum == 1){
						var v = Math.floor(i / 2);

						var hidd = false;
						var hido = false;
						if(oldshs && oldshs[v] == 1){
							hido = true ;
						}
						if(shs[v] == 1){
							isshadenew = true;
							hidd = true ;
						}
						if(hidd != hido){
							if(hidd){
								$(this).show();
							}else{
								$(this).hide();
							}
						}
					}else{
						var v = i / 2;

						var stszz ;
						if(sts[v] == 1){
							stszz = ERROR;
						}else if(sts[v] == 2) {
							stszz = ALERT;
						}else{
							stszz = NORMAL
						}
						var oldsts = $(this).attr("stroke");
						if(stszz != oldsts){
							$(this).attr("stroke", stszz).attr("fill", stszz);
						}
					}
				});
				//重新绘制汇流箱的状态信息
				if(isshadenew){
					$("#"+ sn + " g").attr("name",flagsh+",shadow");
				}else{
					$("#"+ sn + " g").attr("name",flagsh);
				}
			}
		}else{
			var oldv = oldMap.get(sn);
			if(oldv){

				$("#"+ sn + " g[type='nbq'] rect").attr("stroke", NORMAL).attr("fill", NORMAL);
				$("#"+ sn + " g[type='nbq'] path").attr("stroke", NORMAL);
				$("#"+ sn + " g[type='nbq'] line").attr("stroke", NORMAL);
				$("#"+ sn + " g[type='nbq'] ").attr("name", "normal");

				$("#"+ sn + " g[type='hlx'] ").attr("name", "normal");

				$("#"+ sn + " g[type='hlx'] rect[name='zuchuan']").attr("stroke", NORMAL).attr("fill", NORMAL);

			}
		}


	});

	reStr += ";";
	/**if(!flag){
		$("input[name=inverterRtDataBatchListNum_all]").val(narr1.length);
	}
	i_normalNum = $("input[name=inverterRtDataBatchListNum_all]").val() - i_alertNum - i_errorNum - i_breakNum;*/
	var mapsd = new MapDef();
	var xarr1 = [];
	var xarr2 = [];
	var xarr2i = [];
	var xarr3 = [];
	if(result.boxChangeRtDataBatchList){
		xarr1 = result.boxChangeRtDataBatchList.serialnumber;
		xarr2i = result.boxChangeRtDataBatchList.comm_status;
		xarr3 = result.boxChangeRtDataBatchList.statusDesc;
	}
	for(var i =0;i<xarr2i.length;i++){
		map.put(xarr1[i],xarr2i[i]);
		mapsd.put(xarr1[i],xarr3[i]);
		//xarr2[i] = getColor(xarr2i[i]);
	}
	
	$(".necloud_xiangbian").each(function(){
		var sn = $(this).attr("id");
		/**if("alert" == xarr2i[k]){++b_alertNum;}
		else if("error" == xarr2i[k]){++b_errorNum;}
		else if("break" == xarr2i[k]){++b_breakNum;}*/
		var newv = map.get(sn);
		
		var oldsts = $("#"+ sn + " g rect").attr("stroke");
		var newsts = getColor(newv);
		if(newsts != oldsts){
			$("#"+ sn + " g rect").attr("stroke", newsts).attr("fill", newsts);
			$("#"+ sn + " g ellipse").attr("stroke", newsts);
			$("#"+ sn + " p[name=status]").html(mapsd.get(sn));
			$("#"+ sn + " g").attr("name",newv);
		}
		
		//$("#"+ xarr1[k] + " g").attr("name",xarr2i[k]);
	});

	
	var reStr = "";
	v2 += 1;
	var remap = new MapDef(); 
	remap.put("status",map);
	remap.put("shade",mapsh);
	return remap;
}

getColor = function(state){
	var COLOR;
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
	  default:
	    COLOR = NORMAL
	}
	
	return COLOR;
}