//定义加载样式
var loadDiv = "<div class='loader'>" +
	"<div class='loader-inner ball-beat'>" +
	"<div></div><div></div> <div></div>" +
	"</div>" +
	"</div>";
$.showLoading = function(obj) {
	$(obj).html(loadDiv);
};

$.hideLoading = function(obj) {
	$(obj).html("");
};

require.config({
	paths : {
		echarts : 'vendor/echarts'
	}
});
app.controller('staAllCtrl', function($scope, $http, $state, $rootScope, toaster, $stateParams) {
	//当前角色
	$scope.currentRole = $stateParams.roleId;
	//获得电站列表的id
	$scope.getPowerStationIds=function(){
		//请求当前权限下的电站列表
		$.ajax({
			type: "post",
			url: ctx + "/UserAuthHandle/changeRoleForMobile.htm",
			async: false,
			timeout: 5000,
			data: {
				"roleId": $scope.currentRole
			},
			success: function(result) {
				console.log(result);
				//循环遍历 获取电站列表的id
				var powerStationIds=[];//放电站列表ID
				if(result.stlist){
					for(var i=0;i<result.stlist.length;i++){
						if(result.stlist[i].level=='0'){//获得第一层级的列表
							var stlistIds=result.stlist[i].stids.split(",")
							for(var j=0;j<stlistIds.length;j++){
								powerStationIds.push(stlistIds[j])
							}
						}
					}
				}
				$scope.rootStationId = powerStationIds;
			}
		});
	};
	$scope.getPowerStationIds();
	//监听刷新事件
	$state.go("app.statistics.staDay", {});
	
	/*//离开界面清空
	$scope.$on('$stateChangeStart', function(event) {
		$('.modal-backdrop').css("display","none");
		clearInterval(mapTimer1);
		clearInterval(timeTicket);
	})*/
	
	$("#ssjk").addClass("active");
	//公用模态框
	$rootScope.statDataPage = "";
	$rootScope.statDataPage2 = "";
	$scope.changeTimeId = 1;

	//关闭模态框
	$scope.closeStatModal = function() {
		$("#statModal").animate({
			left: window.screen.width + 'px'
		}, 300, function() {
			$rootScope.statDataPage = "";
			$('#statModal').modal("hide");
		});
	};
	//打开模态框
	$scope.openStatModal = function() {
		$('#statModal').modal({backdrop: 'static', keyboard: false});
		$("#statModal").animate({
				left: '0px'
			}, 300, function() {
		});
	};
	//打开模态框2
	$scope.openStatModal2 = function() {
		$('#statModal2').modal({backdrop: 'static', keyboard: false});
		$("#statModal2").animate({
				left: '0px'
			}, 300, function() {
		});
	};
	//关闭模态框
	$scope.closeStatModal2 = function() {
		$("#statModal2").animate({
			left: window.screen.width + 'px'
		}, 300, function() {
			$rootScope.statDataPage2 = "";
			$('#statModal2').modal("hide");
		});
	};
		//当前日
	$scope.mapTimeDay = new Date().getTime(); //用来计算时间
	$scope.mapTimeDayFlag = new Date().getTime(); //当天时间，用来判断是否可以点击
	$scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.mapTimeDayFlag).Format("yyyy-MM-dd")); //标记下一天是否可以点击

	//当前月
	$scope.mapCurrTimeMonth = new Date().getMonth() + 1;
	$scope.mapTimeMonthFlag = new Date().getMonth() + 1;

	//当前年
	$scope.mapTimeYear = new Date().getFullYear();
	$scope.mapTimeYearFlag = new Date().getFullYear();

	//初始化的月份
	$scope.mapTimeMonth = new Date().getFullYear() + '/' + $scope.mapCurrTimeMonth;
	//初始化年
	$scope.mapTimeMonthY = new Date().getFullYear();

	//时间改变，需要把改变后的时间广播出去
	$scope.broadcastData = function(data, brodFlag) {
		$scope.dailyRefresh = true;
		$scope.mapTimeDayRefresh = data;
		$scope.$broadcast(brodFlag, [$scope.dailyRefresh, $scope.mapTimeDayRefresh]);
	};

	//切换日月年标签
	$scope.changeDate = function(changeDateFlag) {
		$scope.changeTimeId = changeDateFlag;
		
		$("#ssjk").addClass("active");
		if (changeDateFlag == "1") { //日
			$scope.changeTime = "日";
			$(".map-jt").removeClass("hidden");
			$("#changeTimeId1").removeClass("hidden");
			$("#changeTimeId1").siblings().addClass("hidden");
			$scope.dailyJt = (($scope.mapTimeDay) == ($scope.mapTimeDayFlag)) //标记下一天是否可以点击	
			$scope.broadcastData(new Date($scope.mapTimeDay).Format("yyyy-MM-dd"), "statDayBro")
		} else if (changeDateFlag == "2") { //月
			$("#ssjk").addClass("active")
			$(".map-jt").removeClass("hidden");
			$scope.dailyJt = $scope.mapCurrTimeMonth == $scope.mapTimeMonthFlag
			$scope.changeTime = "月";
			$("#changeTimeId2").removeClass("hidden");
			$("#changeTimeId2").siblings().addClass("hidden");
			$scope.broadcastData(new Date($scope.mapTimeMonth).Format("yyyy-MM-dd"), "statMonthBro")
		} else if (changeDateFlag == "3") { //年
			$("#ssjk").addClass("active")
			$(".map-jt").removeClass("hidden");
			$scope.dailyJt = $scope.mapTimeYear == $scope.mapTimeYearFlag
			$scope.changeTime = "年";
			$("#changeTimeId3").removeClass("hidden");
			$("#changeTimeId3").siblings().addClass("hidden");
			$scope.broadcastData($scope.mapTimeYear, "statYearBro")
		} else {
			$("#ssjk").addClass("active")
			$(".map-jt").addClass("hidden");
			$("#changeTimeId4").removeClass("hidden");
			$("#changeTimeId4").siblings().addClass("hidden");

		}
	};
/*
	$('#changeTimeId1').datePicker({
		beginyear: 2000, //日期--年--份开始
        endyear: 2016, //日期--年--份结束
	    theme: 'date',
	    beginday:12,
	    callBack: function() {
	    	var chooseDate=new Date($('#changeTimeId1').val()).Format("yyyy/MM/dd")
	    	$('#changeTimeId1').html(chooseDate)
	    	$scope.mapTimeDay=chooseDate
	    	$scope.changeDate(1);
	    }
	});*/

	//监听刷新事件
	$scope.$on('loadData', function(event, data) {
		$scope.changeDate($scope.changeTimeId)
	});

	//向左面切换
	$scope.dateLeft = function() {
		if ($('.fa-angle-left').hasClass('effiJt')) {
			return;
		};
			$("#statcontent").animate({
				left: '500px',
				opacity: '0.1'
			}, 300, function() {
				$("#statcontent").css("left", "-300px");
				$("#statcontent").animate({
					left: '0px',
					opacity: '1'
				}, 300, function() {
					if ($scope.changeTimeId == "1") { //日
						$scope.mapTimeDay = $scope.mapTimeDay - 1000 * 60 * 60 * 24;
						$scope.dailyJt = (($scope.mapTimeDay) == ($scope.mapTimeDayFlag)) //标记下一天是否可以点击	
						$scope.broadcastData(new Date($scope.mapTimeDay).Format("yyyy/MM/dd"), "statDayBro")
					} else if ($scope.changeTimeId == "2") { //月
						if ($scope.mapCurrTimeMonth - 1 <= 0) {
							$scope.mapCurrTimeMonth = $scope.mapCurrTimeMonth + 11
							$scope.mapTimeMonthY = $scope.mapTimeMonthY - 1
						} else {
							$scope.mapCurrTimeMonth = $scope.mapCurrTimeMonth - 1;
						}
						$scope.mapTimeMonth = $scope.mapTimeMonthY + '/' + $scope.mapCurrTimeMonth;
						$scope.dailyJt = $scope.mapCurrTimeMonth == $scope.mapTimeMonthFlag //标记下一天是否可以点击	
						$scope.broadcastData(new Date($scope.mapTimeMonth).Format("yyyy/MM"), "statMonthBro")
					} else if ($scope.changeTimeId == "3") { //年
						$scope.mapTimeYear = $scope.mapTimeYear - 1;
						$scope.dailyJt = $scope.mapTimeYear == $scope.mapTimeYearFlag
						$scope.broadcastData($scope.mapTimeYear, "statYearBro")
					}
				});
			});
	};
		//向右面切换
	$scope.dateRight = function() {
		if ($('.fa-angle-right').hasClass('effiJt')) {
			return;
		};
			$("#statcontent").animate({
				left: '-300px',
				opacity: '0.1'
			}, 300, function() {
				$("#statcontent").css("left", "300px");
				$("#statcontent").animate({
					left: '0px',
					opacity: '1'
				}, 300, function() {
					if ($scope.changeTimeId == "1") { //日
						if ((new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.mapTimeDayFlag).Format("yyyy-MM-dd"))) {
							return false;
						}
						$scope.mapTimeDay = $scope.mapTimeDay + 1000 * 60 * 60 * 24;
						$scope.dailyJt = (new Date($scope.mapTimeDay).Format("yyyy-MM-dd")) == (new Date($scope.mapTimeDayFlag).Format("yyyy-MM-dd")) //标记下一天是否可以点击	
							//广播
						$scope.broadcastData(new Date($scope.mapTimeDay).Format("yyyy/MM/dd"), "statDayBro")
					} else if ($scope.changeTimeId == "2") { //月
						if ($scope.mapCurrTimeMonth == $scope.mapTimeMonthFlag) {
							return false;
						}
						if ($scope.mapCurrTimeMonth + 1 > 12) {
							$scope.mapCurrTimeMonth = ($scope.mapCurrTimeMonth + 1) % 12;
							$scope.mapTimeMonthY = $scope.mapTimeMonthY + 1
						} else {
							$scope.mapCurrTimeMonth = $scope.mapCurrTimeMonth + 1;
						}
						$scope.mapTimeMonth = $scope.mapTimeMonthY + '/' + $scope.mapCurrTimeMonth;
						$scope.dailyJt = $scope.mapCurrTimeMonth == $scope.mapTimeMonthFlag
						$scope.broadcastData(new Date($scope.mapTimeMonth).Format("yyyy/MM"), "statMonthBro")
					} else if ($scope.changeTimeId == "3") { //年
						if ($scope.dailyJt = $scope.mapTimeYear == $scope.mapTimeYearFlag) {
							return false
						}
						$scope.mapTimeYear = $scope.mapTimeYear + 1;
						$scope.dailyJt = $scope.mapTimeYear == $scope.mapTimeYearFlag
						$scope.broadcastData($scope.mapTimeYear, "statYearBro")

					}
				});
			});
	};
		//检查当前时间是不是今天
	$scope.checkDateForToday = function(checkDate, checkMonth) {

		var isDay = new Date().getDate()
		var isMonth = new Date().getMonth() + 1 //当前月份比较
			//如果当前月份比传过来的月份小
		if (isMonth <= checkMonth) {
			return ""
		} else {
			return isDay >= checkDate ? checkDate : "";
		}

	};

	//获取当前时间前两天和后两天的日
	var oneDay = 1000 * 60 * 60 * 24
	$scope.getDayData = function(todayTimeDay) {
		if (todayTimeDay) {
			$scope.todayTimeDay = parseInt(todayTimeDay)
		} else {
			$scope.todayTimeDay = $scope.mapTimeDay
		}
		$scope.analTodayData = [{
				"titleData": $scope.checkDateForToday(new Date($scope.mapTimeDay - 2 * oneDay).getDate(), new Date($scope.mapTimeDay - 2 * oneDay).getMonth()),
				"realData": $scope.mapTimeDay - 2 * oneDay
			},

			{
				"titleData": $scope.checkDateForToday(new Date($scope.mapTimeDay - oneDay).getDate(), new Date($scope.mapTimeDay - 1 * oneDay).getMonth()),
				"realData": $scope.mapTimeDay - oneDay
			},

			{
				"titleData": $scope.checkDateForToday(new Date($scope.mapTimeDay).getDate(), new Date($scope.mapTimeDay * oneDay).getMonth()),
				"realData": $scope.mapTimeDay
			},

			{
				"titleData": $scope.checkDateForToday(new Date($scope.mapTimeDay + oneDay).getDate(), new Date($scope.mapTimeDay + 1 * oneDay).getMonth()),
				"realData": $scope.mapTimeDay + oneDay
			},

			{
				"titleData": $scope.checkDateForToday(new Date($scope.mapTimeDay + 2 * oneDay).getDate(), new Date($scope.mapTimeDay + 2 * oneDay).getMonth()),
				"realData": $scope.mapTimeDay + 2 * oneDay
			}
		];
		return $scope.analTodayData
	};

	//获取当前月以及当前月前后 两个月的时间
	//切换月的格式
	$scope.changeDataFormat = function(mapTimeMonth) {
		var isMonth = new Date().getMonth() + 1;

		if (mapTimeMonth <= 0) {
			mapTimeMonth = mapTimeMonth + 12;
			$scope.mapTimeMonthY = $scope.mapTimeMonthY - 1;
			$scope.mapCurrTimeMonthData = 12;

			mapTimeMonth = ((isMonth >= (mapTimeMonth + 12)) ? mapTimeMonth : "");

		} else if (mapTimeMonth > 12) {
			mapTimeMonth = mapTimeMonth - 12;
			mapTimeMonth = ((isMonth >= (mapTimeMonth - 12)) ? mapTimeMonth : "");
		}
		$scope.mapCurrTimeMonthData = mapTimeMonth;

		mapTimeMonth = ((isMonth >= (mapTimeMonth)) ? mapTimeMonth : "");
			//判断当前月份后面是否有月份
			//return isMonth>=mapTimeMonth?mapTimeMonth:"";
		return mapTimeMonth
	};
	$scope.changeYearFormat = function(yearTime, mapTimeMonth) {

			if (mapTimeMonth <= 0) {
				mapTimeMonth = mapTimeMonth + 12
				yearTime = new Date().getYear() - 1
				$scope.mapCurrTimeMonthData = 12
			} else if (mapTimeMonth > 12) {
				mapTimeMonth = mapTimeMonth - 12;
			} else {
				mapTimeMonth = mapTimeMonth;
			}
			console.log(mapTimeMonth)
			$scope.mapCurrTimeMonthData = mapTimeMonth;
			return yearTime + "/" + mapTimeMonth;
		}
		//当前月份的格式
	$scope.getMonData = function(analMonthData) {
		var nowMonth = new Date(analMonthData).getMonth() + 1;
		var nowYear = new Date(analMonthData).getFullYear()
		$scope.analMonData = [{
			"titleData": $scope.changeDataFormat(nowMonth - 2),
			"realData": $scope.changeYearFormat(nowYear, nowMonth - 2)
		}, {
			"titleData": $scope.changeDataFormat(nowMonth - 1),
			"realData": $scope.changeYearFormat(nowYear, nowMonth - 1)
		}, {
			"titleData": $scope.changeDataFormat(nowMonth),
			"realData": $scope.changeYearFormat(nowYear, nowMonth)
		}, {
			"titleData": $scope.changeDataFormat(nowMonth + 1),
			"realData": $scope.changeYearFormat(nowYear, nowMonth + 1)
		}, {
			"titleData": $scope.changeDataFormat(nowMonth + 2),
			"realData": $scope.changeYearFormat(nowYear, nowMonth + 2)
		}];
		console.log($scope.mapTimeDay)
		return $scope.analMonData
	};

	//检查当前时间是不是今天
	$scope.checkDateForYear = function(checkDate) {
		var isYear = new Date().getFullYear()
		return isYear >= checkDate ? checkDate : "";
	};

	//获取年的数据
	$scope.getYearData = function(yearData) {
		console.log("打印出的年" + yearData)
			//var yearData=new Date(yearDatas).getFullYear()
		$scope.analYearData = [{
			"titleData": $scope.checkDateForYear(yearData - 2),
			"realData": yearData - 2
		}, {
			"titleData": $scope.checkDateForYear(yearData - 1),
			"realData": yearData - 1
		}, {
			"titleData": $scope.checkDateForYear(yearData),
			"realData": yearData
		}, {
			"titleData": $scope.checkDateForYear(yearData + 1),
			"realData": yearData + 1
		}, {
			"titleData": $scope.checkDateForYear(yearData + 2),
			"realData": yearData + 2
		}];
		return $scope.analYearData;
	};

	$scope.showSyScore = function(currentPsId){
		$scope.$broadcast("dateChangeCtrl", currentPsId);
		$("#syScore").modal();
	};

	//手势操作
	//mui.init({
	//	gestureConfig: {
	//		tap: true, //默认为true
	//		doubletap: true, //默认为false
	//		longtap: true, //默认为false
	//		swipe: true, //默认为true
	//		drag: true, //默认为true
	//		hold: false, //默认为false，不监听
	//		release: false //默认为false，不监听
	//	}
	//});
	//绑定弹出框向右滑动，执行关闭
	document.getElementById("statModal").addEventListener("swiperight", function(event) {
		//console.log("deltaX = " + event.detail.deltaX);
		//console.log("event = " + event.detail.center.x +"-" +event.detail.center.y);
		if (event.detail.deltaX > 80)
			$scope.closeStatModal();
	});

	$scope.isStatContentDrag = false;
	//statcontent开始拖动
	document.getElementById("statcontent").addEventListener("dragstart", function(event) {
		var minHeight = window.screen.height / 3;
		var maxHeight = minHeight * 2;

		if ($scope.changeTimeId != "4" && event.detail.center.y > minHeight && event.detail.center.y < maxHeight) {
			$("#statcontent").css("position", "relative");
			$scope.isStatContentDrag = true;
		}
	});
	//statcontent拖动中
	document.getElementById("statcontent").addEventListener("drag", function(event) {
		if ($scope.isStatContentDrag) {
			$("#statcontent").css("left", event.detail.deltaX + "px");
		}
	});
	//绑定弹出框向左滑动，执行切换为下一周期
	document.getElementById("statcontent").addEventListener("dragend", function(event) {
		if (!$scope.isStatContentDrag) {
			return;
		}
		var deltaX = event.detail.deltaX;
		if ($scope.changeTimeId != "4" && deltaX > 80) {
			$scope.dateLeft();
		} else if (!$scope.dailyJt && deltaX < -80) {
			$scope.dateRight();
		} else {
			$("#statcontent").animate({
				left: '0px',
				opacity: '1'
			}, 300);
		}
		$scope.isStatContentDrag = false;
	});
	
	$scope.isStatModalDrag = false;
	//statModal开始拖动
	document.getElementById("statModal").addEventListener("dragstart", function(event) {
		$("#statModal").css("position", "fixed");
		$scope.isStatModalDrag = true;
	});
	//statModal拖动中
	document.getElementById("statModal").addEventListener("drag", function(event) {
//		var deltaX = event.detail.deltaX;
//		var deltaY = event.detail.deltaY;
//		
//		var angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI;
//		var dirc = 0; //1：向上，2：向下，3：向左，4：向右,0：未滑动
//		if (angle >= -45 && angle < 45) {
//      		dirc = 4;
//  		} else if (angle >= 45 && angle < 135) {
//      		dirc = 1;
//  		} else if (angle >= -135 && angle < -45) {
//      		dirc = 2;
//  		}
//  		else if ((angle >= 135 && angle <= 180) || (angle >= -180 && angle < -135)) {
//     		dirc = 3;
//  		}
//		if ($scope.isStatModalDrag && dirc == 4 ) {
//			$("#statModal").css("left", event.detail.deltaX + "px");
//			$("#statModal").css("top", "0px");
//		}
	});
	//statModal拖动结束
	document.getElementById("statModal").addEventListener("dragend", function(event) {
		if (!$scope.isStatModalDrag) {
			reutrn;
		}
		var deltaX = event.detail.deltaX;
		var deltaY = event.detail.deltaY;
		
		if(deltaY > 30 || deltaY < -30){
			return;
		}
		
		var angle = Math.atan2(deltaY, deltaX) * 180 / Math.PI;
		var dirc = 0; //1：向上，2：向下，3：向左，4：向右,0：未滑动
		if (angle >= -45 && angle < 45) {
        		dirc = 4;
    		} else if (angle >= 45 && angle < 135) {
        		dirc = 1;
    		} else if (angle >= -135 && angle < -45) {
        		dirc = 2;
    		}
    		else if ((angle >= 135 && angle <= 180) || (angle >= -180 && angle < -135)) {
       		dirc = 3;
    		}
    		
		if (deltaX > 80 && dirc == 4) {
			$scope.closeStatModal();
		} else {
			$("#statModal").animate({
				left: '0px',
				opacity: '1'
			}, 300);
		}
		$scope.isStatModalDrag = false;
	});
});
app.controller('staAllRankCtrl',function($scope, $http, $state,$rootScope) {
	$("#conternt").css("height",$(window).height()-100)
	$scope.getYearRank=function(){
		console.log($scope.mapTimeMonth)
		$http({
			method : "POST",
			url : ctx+"MobileRtmDeviceMonitor/getStationRank.htm",
			params : {
				//'dateString':$scope.mapTimeMonth,
				'dateType':"A",
				'powerStationId':$scope.rootStationId
			}
		}).success(function (msg) {
			$scope.prRank=msg.prRank.sort(function(obj1, obj2){
				return obj1.order - obj2.order;
			});
			$scope.prRank = $scope.prRank.slice(0, 3);
			$scope.prRankReverse = msg.prRank.sort(function(obj1, obj2){
				return obj2.order - obj1.order;
			});
			$scope.prRankReverse = $scope.prRankReverse.slice(0, 3);
			console.log("prRank:"+JSON.stringify($scope.prRank));
			console.log("prRankReverse:"+JSON.stringify($scope.prRankReverse));
		}).error(function(msg){
		});
	}
	$scope.getYearRank();
});


Date.prototype.Format = Date.prototype.format = function(fmt) { //author: meizz
	var o = {
		"M+": this.getMonth() + 1, //月份
		"d+": this.getDate(), //日
		"h+": this.getHours(), //小时
		"m+": this.getMinutes(), //分
		"s+": this.getSeconds(), //秒
		"q+": Math.floor((this.getMonth() + 3) / 3), //季度
		"S": this.getMilliseconds() //毫秒
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
		if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
};
function countTime(opt) {
    var now = new Date().getTime();
    var defaultOpt = {
        st: now, //开始时间,时间戳
        et: now, //结束时间,时间戳
        sdom: null,
        mdom: null,
        hdom: null,
        ddom: null,
        Mdom: null,
        ydom: null
    };
    this.opt = $.extend({}, defaultOpt, opt);
    this.h = 0;
    this.m = 0;
    this.s = 0;
    this.d = 0;
    this.M = 0;
    this.y = 0;
    this.init = function() {
        if (now >= this.st) {
            this.interCount();
        } else {
            this.interCount();
        }
    };
    this.interCount = function() {
        var _this = this;
        var bTime = _this.bTime();
        if (bTime > 0) {
            _this.interSwitch = setInterval(function() {
                bTime--;
                if (bTime < 0) {
                    clearInterval(_this.interSwitch);
                } else {
                    _this.renderTime(bTime);
                }
            }, 1000);
        } else {

        }
    };
    this.bTime = function() { //距离的时间(单位s)
        return Math.round(this.opt.et / 1000 - now / 1000);
    };
    this.renderTime = function(t) {
        this.s = t % 60;
        this.m = Math.floor(t / 60) % 60;
        this.h = (Math.floor(t / 3600) % 60) % 24;
        this.d = Math.floor(t / 86400) % 30;
        this.M = Math.floor(t / 2592000) % 12;
        this.y = Math.floor(t / 31104000);
        this.opt.ydom.innerHTML = this.y < 10 ? "0" + this.y : this.y;
        this.opt.Mdom.innerHTML = this.M < 10 ? "0" + this.M : this.M;
        this.opt.ddom.innerHTML = this.d < 10 ? "0" + this.d : this.d;
        this.opt.hdom.innerHTML = this.h < 10 ? "0" + this.h : this.h;
        this.opt.mdom.innerHTML = this.m < 10 ? "0" + this.m : this.m;
        this.opt.sdom.innerHTML = this.s < 10 ? "0" + this.s : this.s;

    }

};
var two = new countTime({
    et: new Date('2015-4-7').getTime(),
    ydom: document.getElementById('y'),
    Mdom: document.getElementById('M'),
    ddom: document.getElementById('d'),
    hdom: document.getElementById('h')/* ,
    mdom: document.getElementById('m'),
    sdom: document.getElementById('s') */
});
two.init();
