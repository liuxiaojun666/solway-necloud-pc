
app.controller('datangMonitoringCtrl', function($scope, $rootScope, $http, $state, $stateParams, $document,$timeout) {
	
	//打开本页面的日期，进入下一天时自动刷新页面
	$scope.comeDate = new Date();
	$scope.getCurrentDataName('00',1);
	
	var rightDay = new Date();
	//只能取到前一天
	rightDay.setDate(rightDay.getDate());
	$scope.today = rightDay;
	
	if ($stateParams.analData) {//首页带进来的参数
		$scope.mapTimeDay = new Date(parseInt($stateParams.analData)).getTime();

		$scope.mapTimeDayRefresh = new Date(parseInt($stateParams.analData)).Format("yyyy-MM-dd")
	} else {
		$scope.mapTimeDay = $scope.today;
		$scope.mapTimeDayRefresh = $scope.today.Format("yyyy-MM-dd")
	}

	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		$scope.refreshViewDataForHead();
	});

	$scope.$on("emitChangeDate",function(e,data){
		//$scope.$broadcast('broadChangeDate',data);
	});
	$scope.getCurrentInfo = function() {
		$http({
				method : "POST",
				url : "./UserAuthHandle/getCurrentInfo.htm"
			}).success(function(msg) {
				$scope.userId = msg.currentRole;
				if(msg.currentSTNum > 1){
					$rootScope.posJcvFlag = false;
				}
			})
		};
	$scope.getCurrentInfo();
	
	//双击按钮事件
	 $scope.dblclick = function (pstationid,deviceid,deviceSerialNnumber,deviceType,hasJB) {
		 
		var res = {};
		res.deviceSerialNnumber = deviceSerialNnumber;
		res.deviceId = deviceid;
		res.pstationid = pstationid;
		res.deviceTypeNow = deviceType;
		$scope.deviceTypeNow = deviceType;
		
		$scope.inverterType = hasJB;
		console.log(deviceType +"===deviceType");
		if(deviceType == '3'){
			$('#taskList_historyData3').modal({backdrop: 'static', keyboard: false});
			//$scope.$emit("showDeviceDetail3", res);
			$scope.$broadcast("showDeviceDetail3broad", res);
		}else if(deviceType == '2'){
			$('#taskList_historyData2').modal({backdrop: 'static', keyboard: false});
			$scope.$broadcast("showDeviceDetail2broad", res);
			//$scope.$emit("showDeviceDetail2", res);
		}else if(deviceType == '1'){
			$('#taskList_historyData1').modal({backdrop: 'static', keyboard: false});
			$scope.$broadcast("showDeviceDetail1broad", res);
			//$scope.$emit("showDeviceDetail1", res);
		}
		
		//$scope.showHistoryData_byRTMDeviceLogId(pstationid,deviceid,deviceSerialNnumber,deviceType);
    }
	
	//获取箱变详情数据
	function getBoxChangeDetail(){
		$scope.junctionBoxList = [{'state':0,
									  'inverterList':[
									         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
									         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
									         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]}
									  ]},
		                          {'state':1,
		                        	  'inverterList':[
		                        	         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
     								         {'state':1,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':1},{'state':0},{'state':1},{'state':0},{'state':1},{'state':0},{'state':1},{'state':0},{'state':1},{'state':0},{'state':0}]},
     								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
     								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]}
     								  ]},
		                          {'state':0,
		                        	  'inverterList':[
		 		                        	         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
		      								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
		      								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
		      								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]}
		      								  ]},
		                          {'state':0,
		                        	  'inverterList':[
		 		                        	         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
		      								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
		      								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]},
		      								         {'state':0,'zuchuanList':[{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0},{'state':0}]}
		      								  ]},
		      					];
	}
	//显示箱变详情
	$scope.showBoxChangeDetail = function(){
		$scope.boxChangeDetail = true;
		$scope.getBoxChangeDetail();
	}
	
	//返回箱变列表
	$scope.showBoxChangeList = function(){
		$scope.boxChangeDetail = false;
	}
	
	//点击四个框显示详情
	$scope.showPowerIndexData = "";
	$scope.showRealPower = function(flag){
		if(flag == 1){
			$('#powerIndexModal').modal();
			$scope.showPowerIndexData='tpl/datang/rtMonitorPage/modal/showWeatherPowerModal.jsp';
		}else if(flag == 2){
			$('#powerIndexModal').modal();
			$scope.showPowerIndexData="tpl/datang/rtMonitorPage/modal/app_bInverterData.jsp";
			//$scope.showPowerIndexData='tpl/datang/rtMonitorPage/modal/staTodayPower.jsp';
		}else if(flag == 3){
			$('#powerIndexModal').modal();
			$scope.showPowerIndexData='tpl/datang/rtMonitorPage/modal/staMonModal.jsp';
		}else if(flag == 4){
			$('#powerIndexModal').modal();
			$scope.showPowerIndexData='tpl/datang/rtMonitorPage/modal/staYearModal.jsp';
		}
		//$('#powerIndexModal').on('shown.bs.modal', function (e) {});
	};
	
	//关闭弹出层
	$scope.hiddenModal=function(){
		$('#powerIndexModal').modal("hide");
		$scope.showPowerIndexData="";
	};
	
	
	$scope.singleClick = function () {
	    if ($scope.clicked) {
	        $scope.cancelClick = true;
	        return;
	    }

	    $scope.clicked = true;

	    $timeout(function () {
	        if ($scope.cancelClick) {
	            $scope.cancelClick = false;
	            $scope.clicked = false;
	            return;
	        }

	        $scope.dblclick(1,1,2001,'3');
	        $scope.cancelClick = false;
	        $scope.clicked = false;
	    }, 500);
	};
	
	$scope.doubleClick = function (eqid) {
		console.log(eqid +"===eqid")
		$scope.bcId = eqid;
		nbqList = null;
		hlxName = null;
	    $timeout(function () {

	    	$scope.showBoxChangeDetail();

	    });
	};
	$scope.goFaultAlarm = function () {

		$state.go("app.faultalarm");
	};
	
	var bcList;
	$scope.getBoxChangeList = function() {
		$http({
			method : "POST",
			url : "./RtmDeviceLayout/getAllBoxChangeData.htm",
			params : {
				ids : bcList
			} 
		}).success(function(msg) {
			bcList = msg.ids;
			$scope.boxChangeList = msg.bcList;
			console.log(msg.bcList)
			//模拟数据
			$scope.boxChangeList = [{'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001},
			                        {'name':'1箱变','invFaultCount':0,'invRunCount':8,'acpCount':12,'status':1,'comm':0,'did':2001}]
		})
	};
	
	//获取逆变器数据
	var nbqList;
	var hlxName;
	$scope.getBoxChangeDetail = function() {
		$http({
			method : "POST",
			url : "./RtmDeviceLayout/getAllInvByBCData.htm",
			params : {
				ids : nbqList,
				hlxName : hlxName,
				bcid : $scope.bcId
			} 
		}).success(function(msg) {
			console.log(msg);
			nbqList = msg.ids;
			hlxName = msg.hlxName;
			$scope.junctionBoxList = msg.junctionBoxList;
		})
	};
	
	timer = setInterval(function() {
		if($scope.boxChangeDetail == false){
			console.log("list----------")
			$scope.getBoxChangeList();
		}
	}, 5000);
	
	timer2 = setInterval(function() {
		if($scope.boxChangeDetail == true){
			console.log("detail----------")
			$scope.getBoxChangeDetail();
		}
	}, 5000);
	
	$scope.$on('$stateChangeStart', function(event) {
		clearInterval(timer);
		clearInterval(timer2);
	});
	
	function init(){
		$scope.boxChangeDetail = false;
		$scope.getBoxChangeList();
		//getBoxChangeDetail();//测试
	}
	init();
})