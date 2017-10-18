//颜色常量
BREAK = "#999", ALERT = "#f90", ERROR = "#db412f", NORMAL = "#3fad22", SELECT = "#15575f";

//重绘故障设备
refreshDraggSVGDevCore = function(data,allDevStatus) {
	
	$("g[type='windTurbine']").each(function(){
		var deviceId= $(this).attr("deviceId");
		
		var newStatus = data[deviceId][0];
		if(allDevStatus.get(deviceId) != newStatus){
			$(this).find("g").removeClass("class");
			if(newStatus == 0){
				$(this).find("path").attr("fill", NORMAL);
				$(this).find("g").attr("class", "svgRotate0-360");
			}else if(newStatus == 1){
				$(this).find("path").attr("fill", ERROR);
			}else if(newStatus == 2){
				$(this).find("path").attr("fill", ALERT);
			}else if(newStatus == 3){
				$(this).find("path").attr("fill", BREAK);
			}else if(newStatus == 4){
				$(this).find("path").attr("fill", BREAK);
			}else if(newStatus == 5){
				$(this).find("path").attr("fill", NORMAL);
			}
		}
		
		
		
	});
	
}