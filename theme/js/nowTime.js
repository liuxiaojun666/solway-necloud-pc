//修改显示时间
	function changeCurrentTime(url,showDomId) {
		var options = {
			dataType : "json",
			url : url+"/PowerStationMonitor/getCurrentTime.htm?i=" + Math.random(),
			success : function(json) {
				disCurrentTime(json.millisecond,showDomId);
			},
			error : function(json) {
			}
		};
		$.ajax(options);
	}
	var tempNum = 0;
	function disCurrentTime(text,showDomId) {
		now.setTime(text);
		if (tempNum == 0) {
			plusOneSec(showDomId);
			disTimer = setInterval(function(){plusOneSec(showDomId);}, 1000);
			tempNum++;
		}
	}
	var now = new Date();
	var weekArray = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
	function plusOneSec(showDomId) {//自动增加一秒   
		now.setSeconds(now.getSeconds() + 1);
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var day = now.getDate();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();
		var weeks = now.getDay();

		if (hours < 10) {
			hours = "0" + hours;
		}
		if (minutes < 10) {
			minutes = "0" + minutes;
		}
		if (seconds < 10) {
			seconds = "0" + seconds;
		}
		var dateValue = year + "年" + month + "月" + day + "日 ";
		var timeValue = hours + ":" + minutes + ":" + seconds;
		var weekValue = weekArray[weeks];
		$("#"+showDomId).html(dateValue +timeValue+ weekValue);
	}