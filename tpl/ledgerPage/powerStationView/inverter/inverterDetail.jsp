<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/checkSelected.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/device-standingbook.css"/>
<link rel="stylesheet" href="theme/css/grid.css" type="text/css" />
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript">

$(function() {
	switchInfo();
	$("#moreInfo").hide();
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
});


$("#inverter_result_table").css("height", $(window).height() - 430);
$("#inverter_result_table").css("width", $("#deviceDatas").width);

var code;
var buildnum=0;
var acp;
var inverterTimer;
var inverterTimer2;
var inverterTimerDCU;
var inverterTimerDCC;
var inverterTimerDCP;
var inverterTimerACU;
var inverterTimerACC;
var inverterTimerACP;
app.controller('inverterMonitorCtrl', function($scope, $http, $state, $stateParams) {

	//设备信息	
	$scope.onSelectPage = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/InverterStanding/inverterCount.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"param" : $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
// 			alert(JSON.stringify(result));
			$scope.pstationid=result.inverter.pstationid
			$scope.boxchangeid=result.inverter.boxchangeid;
			$scope.inverterName=result.inverter.name;
			$scope.boxname=result.inverter.boxname;
			$scope.address=result.inverter.address;
			$scope.inverterroom=result.inverter.inverterroom;
			$scope.invertergid=result.inverter.invertergid;
			$scope.manufid=result.inverter.manufname;
			$scope.productid=result.inverter.productname;
			$scope.mainparameter=result.inverter.mainparameter;
			$scope.repaircard=result.inverter.repaircard;
			buildnum=$scope.buildcapacity=result.inverter.realcapacity==null?0: result.inverter.realcapacity
			//$scope.buildcapacity=buildnum.toFixed(1)+"kW";
			$scope.faultalarmTitle="("+result.faultalarm+")";
			$scope.repairtTitle="("+result.repairt+")";
			$scope.experimentTile="("+result.experiment+")";
			$scope.replacedTitle="("+result.replaced+")";
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求逆变器信息数据超时!');
// 			}else{
// 				promptObj('error','','请求逆变器信息数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	$scope.onSelectPage(1);	
	
	//历史信息
	app.controller('inverpageHistory', function($scope, $http, $state,$stateParams) {
		$scope.inverterGridOptions = {
				data : 'deviceData',
				enablePinning : true,
				enableCellSelection : true,
				columnDefs : [
						 
						{
							field : 'dtime',
							displayName : '时间',
							width : 120,
							pinned : true,
							cellClass : 'text-center',
							cellTemplate :'<span ng-if="row.getProperty(\'dtime\')!=null"><span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'dtime\')*1000|date:\'yyyy-MM-dd HH:mm:ss\'"></span></span> '
						},{
							field : 'dcu',
							displayName : 'DC电压(V)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'dcc',
							displayName : 'DC电流(A)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'dcp',
							displayName : 'DC功率(kW)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'acu',
							displayName : 'AC电压(V)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'acc',
							displayName : 'AC电流(A)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'acp',
							displayName : 'AC功率(kW)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 't',
							displayName : '温度(℃)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'ef',
							displayName : '效率(%)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right',
							cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'ef\')*100|number:2"></span> '
						}, {
							field : 'f',
							displayName : '频率(Hz)',
							width : 80,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'pf',
							displayName : '功率因数',
							width : 90,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'dw',
							displayName : '日发电量(kWh)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						}, {
							field : 'tw',
							displayName : '总发电量(kWh)',
							width : 120,
							cellFilter : 'number:2',
							cellClass : 'text-right'
						} ]
			};
	
	var flag=0;	
	initTableConfig($scope);
	$scope.onSelectPage  = function(page) {
			if(flag==0){
				$('#begindate').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				}).on('changeDate', function(ev){
					$("#enddate").val($('#begindate').val());
				    $('#enddate').datetimepicker('setStartDate', $('#begindate').val()).datetimepicker('update').datetimepicker('show');
				});	
				$('#enddate').datetimepicker({
					format: "yyyy-mm-dd hh:ii",
					language: 'zh-CN',
					todayHighlight:true,
					todayBtn:true,
				   	autoclose: true,
				   	endDate:new Date()
				});
				function startDate(date){
					var newdate=new Date(date-24*60*60*1000);
					var startTime= new Date(newdate).Format("yyyy-MM-dd hh:mm");
					return startTime;
				}
				function endDate(date){
					var endTime= new Date(date).Format("yyyy-MM-dd hh:mm");
					return endTime;
				}
				$("#begindate").val(startDate(new Date()));
				$("#enddate").val(endDate(new Date()));
				$scope.begindate = $("#begindate").val();
				$scope.enddate = $("#enddate").val();
				flag++;
			}
		CommonPerson.Base.LoadingPic.PartShow('loadingDiv');//加载状态
		$("#inverter_result_table").hide();
		if (page == 0) {
			page = 1;
			$scope.currentPage=1;
		}
		$http({
			method : "POST",
			//url : "${ctx}/HistoryData/getHsData.htm",
			url : "${ctx}/HistoryData/getNewHistoryData.htm",
			params : {
				'pageIndex' : page,
				'pageSize' : $scope.pageSizeSelect,
				'devicetype':2,
				'begindate':$scope.begindate,
				'enddate':$scope.enddate,
				'stationid':$scope.stationid,
				"serialnumber" : $scope.serialnumber,
				"id" : $stateParams.InId
			}
// 			,timeout: 5000
		}).success(function(result) {
			getPaginationDatas($scope,result[0]);
			partHide('loadingDiv');
			$("#inverter_result_table").show();
//				breakdown(result.data);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求逆变器历史数据超时!');
// 			}else{
// 				promptObj('error','','请求逆变器历史数据出错!');
// 			}
		});
		};
	});
	function initPaginationDatas($scope){
		$scope.deviceData = null;
		$scope.currentPage = 0;
		$scope.numPages = 1;
		$scope.pageSize = 1800000;
		$scope.pages = [];
		$scope.showStart = null;
		$scope.showEnd = null;
		$scope.totalPage = 0;
		$scope.pageSizeSelect=1800000;
		$scope.startTimeInMillis=null;
		$scope.endTimeInMillis=null;
	}
	function getPaginationDatas($scope,result){
		$scope.deviceData = result.data;
		$scope.numPages = result.totalPage;
		$scope.showStart = result.showStart;
		$scope.showEnd = result.showEnd;
		$scope.total = result.total;
		$scope.totalPage=result.totalPage;
		$scope.startTimeInMillis=result.startTimeInMillis;
		$scope.endTimeInMillis=result.endTimeInMillis;
		if($scope.totalPage==0){
			$scope.currentPage=0;
		}else{
			$scope.currentPage=result.pageIndex;		
		}
	}
	
	//故障信息
	app.controller('faultAlarm', function($scope, $http, $state,$stateParams) {
	$scope.onSelectPage  = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/FaultAlarm/faultAlarmList.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"deviceId" : $stateParams.InId,
				deviceType :2
			},
			timeout: 5000
		}).success(function(result) {
			getTableData($scope,result);
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求逆变器故障信息数据超时!');
// 			}else{
// 				promptObj('error','','请求逆变器故障信息数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	});
	
	
	//检修维护
	app.controller('repairt', function($scope, $http, $state,$stateParams) {
	$scope.onSelectPage  = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/Repair/repairtList.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"param" : $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
			$scope.maintenance=result.data
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求逆变器检修维护数据超时!');
// 			}else{
// 				promptObj('error','','请求逆变器检修维护数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	});
	
	
	//技术监督
	app.controller('experiment', function($scope, $http, $state,$stateParams) {
	$scope.onSelectPage  = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/Experiment/experimentList.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"param" : $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
			$scope.supervise=result.data
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求逆变器技术监督数据超时!');
// 			}else{
// 				promptObj('error','','请求逆变器技术监督数据出错!');
// 			}
		});
		};
		initTableConfig($scope);
	});
	
	
	//技术改造
	app.controller('replaced', function($scope, $http, $state,$stateParams) {
	$scope.onSelectPage  = function(page) {
		if (page == 0) {
			page = 1;
		}
		$http({
			method : "POST",
			url : "${ctx}/Replaced/replacedList.htm",
			params : {
				'pageIndex': page - 1,
				'pageSize' : $scope.pageSizeSelect,
				"param" : $stateParams.InId,
				serialnumber:$scope.serialnumber,
				pstationid : $stateParams.pstationid
// 				"id": $stateParams.InId,
// 				"deviceid": $stateParams.InId,
			},
			timeout: 5000
		}).success(function(result) {
			$scope.reform=result.data
		}).error(function(response) {
// 			if(response==null){
// 				promptObj('error','','请求逆变器技术改造数据超时!');
// 			}else{
// 				promptObj('error','','请求逆变器技术改造数据出错!');
// 			}
		});
	};
	initTableConfig($scope);
	});
	
	$scope.toBoxChange = function(id,serialnumber,pstationid) {
		$state.go("app.BoxChangeDetail", {
			InId : id
// 			serialnumber : serialnumber,
// 			pstationid : pstationid
		});
	}
	
	$scope.serialnumber = $stateParams.serialnumber;
	$scope.pstationid = $stateParams.pstationid;
	getHours($scope, $stateParams,$http);
	getRtData($scope, $stateParams,$http,0);
	inverterTimer=setInterval(function(){
		getRtData($scope, $stateParams,$http,1);
	}, 5000);
	inverterTimer2=setInterval(function(){
		getHours($scope, $stateParams,$http);
	}, 60000);
	$scope.$on('$stateChangeStart', function(event){
		clearInterval(inverterTimer);
		clearInterval(inverterTimer2);
		clearInterval(inverterTimerDCU);
		clearInterval(inverterTimerDCC);
		clearInterval(inverterTimerDCP);
		clearInterval(inverterTimerACU);
		clearInterval(inverterTimerACC);
		clearInterval(inverterTimerACP);
	});
});
//实时数据
function getRtData($scope, $stateParams,$http,flag){

	$http.get("${ctx}/DeviceStation/getSingleRealDataBInverter.htm", {
		params : {
			id : $stateParams.InId,
			serialnumber:$scope.serialnumber,
			pstationid : $scope.pstationid
		},
		timeout: 5000
	}).success(function(response) {
		if(response.respStatus==1){
			$scope.serialnumber = response.data.did;
			$scope.pstationid =response.data.sid;
			$scope.dw=response.data.dw;
			$scope.tw=response.data.tw;
			$scope.dwUnit=response.dwUnit;
			$scope.twUnit=response.twUnit;
			$scope.millisecond=response.data.utime*1000;//实时时间
			$scope.inverterMonitorData = response.data;
			acp=$scope.inverterMonitorData.acp;
			numToFixed();
			if(flag==0){
				getDCU($scope.inverterMonitorData.dcu,$scope);
				getDCC($scope.inverterMonitorData.dcc,$scope);
				getDCP($scope.inverterMonitorData.dcp,$scope);
				getACU($scope.inverterMonitorData.acu,$scope);
				getACC($scope.inverterMonitorData.acc,$scope);
				getACP($scope.inverterMonitorData.acp,$scope);
			}
		}
	}).error(function(response) {
// 		if(response==null){
// 			promptObj('error','','请求逆变器实时数据超时!');
// 		}else{
// 			promptObj('error','','请求逆变器实时数据出错!');
// 		}
	});
}
//小时数数据
function getHours($scope, $stateParams,$http){
	$http.get("${ctx}/InverterStanding/getInverterHours.htm", {
		params : {
			id : $stateParams.InId
		},
		timeout: 5000
	}).success(function(result) {
		$scope.installDate=result.begindate;	
		$scope.runhour=result.runhour+"h";
		$scope.totalHour=result.totalHour+"h";
		$scope.workHour=result.workHour+"h";
		$scope.faultHour=result.faultHour+"h";
	}).error(function(response) {
		
	});
}
function getDCU(dcu,$scope){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interverdcu'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
		    tooltip : {
		        formatter: "{a}  : {c}V"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'电压',
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            max:parseInt(dcu*1.2/10)*10+10,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dcu, name: '电压(V)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	inverterTimerDCU=setInterval(function(){
		if($scope.inverterMonitorData==null||$scope.inverterMonitorData.dcu!=null){
			option.series[0].data[0].value=$scope.inverterMonitorData.dcu.toFixed(1);
			option.series[0].max=parseInt(dcu*1.2/10)*10+10;
			myChart.setOption(option,true);
		}
	},5000);
});
}


function getDCC(dcc,$scope){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interverdcc'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
		    tooltip : {
		        formatter: "{a}  : {c}A"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'电流',
		            max:parseInt(dcc*1.2/10)*10+10,
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dcc, name: '电流(A)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	inverterTimerDCC=setInterval(function(){
		if($scope.inverterMonitorData==null||$scope.inverterMonitorData.dcc!=null){
			option.series[0].data[0].value=$scope.inverterMonitorData.dcc.toFixed(2);
			option.series[0].max=parseInt(dcc*1.2/10)*10+10;
			myChart.setOption(option,true);
		}
	},5000);
});
}

function getDCP(dcp,$scope){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interverdcp'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
		    tooltip : {
		        formatter: "{a}  : {c}kW"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'功率',
		            max:parseInt(buildnum*1.2/10)*10+10,
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: dcp, name: '功率(kW)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	inverterTimerDCP=setInterval(function(){
		if($scope.inverterMonitorData==null||$scope.inverterMonitorData.dcp!=null){
			option.series[0].data[0].value=$scope.inverterMonitorData.dcp.toFixed(1);
			//option.series[0].max=parseInt(buildnum*1.2/10)*10+10;
			myChart.setOption(option,true);
		}
	},5000);
});
}



function getACU(acu,$scope){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interveracu'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
		    tooltip : {
		        formatter: "{a}  : {c}V"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'电压',
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            max:parseInt(acu*1.2/10)*10+10,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: acu, name: '电压(V)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	inverterTimerACU=setInterval(function(){
		if($scope.inverterMonitorData==null||$scope.inverterMonitorData.acu!=null){
			option.series[0].data[0].value=$scope.inverterMonitorData.acu.toFixed(1);
			option.series[0].max=parseInt(acu*1.2/10)*10+10;
			myChart.setOption(option,true);
		}
	},5000);
});
}


function getACC(acc,$scope){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interveracc'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
		    tooltip : {
		        formatter: "{a}  : {c}A"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'电流',
		            max:parseInt(acc*1.2/10)*10+10,
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: acc, name: '电流(A)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	inverterTimerACC=setInterval(function(){
		if($scope.inverterMonitorData==null||$scope.inverterMonitorData.acc!=null){
			option.series[0].data[0].value=$scope.inverterMonitorData.acc.toFixed(2);
			option.series[0].max=parseInt(acc*1.2/10)*10+10;
			myChart.setOption(option,true);
		}
	},5000);
});
}

function getACP(acp,$scope){
	require([ 'echarts', 'echarts/chart/gauge' ], function(ec) {
		
	var myChart = ec.init(document.getElementById('interveracp'));
	
  	 window.addEventListener("resize", function() {
		//myChart.resize();
	});
	var option = {
		    tooltip : {
		        formatter: "{a}  : {c}kW"
		    },
		    toolbox: {
		        show : false,
		        feature : {
		            mark : {show: true},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    series : [
		        {
		            name:'功率',
		            max:parseInt(buildnum*1.2/10)*10+10,
		            type:'gauge',
		            startAngle:180,
		            endAngle:0,
		            splitNumber: 10,       // 分割段数，默认为5
		            axisLine: {            // 坐标轴线
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: [[0.2, '#228b22'],[0.8, '#48b'],[1, '#ff4500']], 
		                    width: 8
		                }
		            },
		            axisTick: {            // 坐标轴小标记
		                splitNumber: 10,   // 每份split细分多少段
		                length :12,        // 属性length控制线长
		                lineStyle: {       // 属性lineStyle控制线条样式
		                    color: 'auto'
		                }
		            },
		            axisLabel: {           // 坐标轴文本标签，详见axis.axisLabel
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto'
		                }
		            },
		            splitLine: {           // 分隔线
		                show: true,        // 默认显示，属性show控制显示与否
		                length :20,         // 属性length控制线长
		                lineStyle: {       // 属性lineStyle（详见lineStyle）控制线条样式
		                    color: 'auto'
		                }
		            },
		            pointer : {
		                width : 5
		            },
		            title : {
		                show : true,
		                offsetCenter: [0, '-40%'],       // x, y，单位px
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    fontWeight: 'bolder'
		                }
		            },
		            detail : {
		                formatter:'{value}',
		                textStyle: {       // 其余属性默认使用全局文本样式，详见TEXTSTYLE
		                    color: 'auto',
		                    fontWeight: 'bolder'
		                },
		    height: -30
		            },
		            data:[{value: acp, name: '功率(kW)'}]
		        }
		    ]
		};
	myChart.setOption(option);
	inverterTimerACP=setInterval(function(){
		if($scope.inverterMonitorData==null||$scope.inverterMonitorData.acp!=null){
			option.series[0].data[0].value=$scope.inverterMonitorData.acp.toFixed(1);
			//option.series[0].max=parseInt(acp*1.2/10)*10+10;
			myChart.setOption(option,true);
		}
	},5000);
});
}


function dateFormat(date){
    var time = new Date(date).Format("yyyy-MM-dd HH:mm:ss"); 
    return time;
}
			
		
		var tab=0;
		function switchInfo(){
			if(tab==0){
				tab=1;
				$("#moreInfo").show();
			}else{
				tab=0;
				$("#moreInfo").hide();
			}
		}
		function numToFixed(){
			if(buildnum!=0 && acp !=0){
				var number=(acp/buildnum)*100;
				var value=number.toFixed(1)+"%";
				$("#used").html(value);	
			}else{
				$("#used").html("0%");
			}
		}
</script>

<div ng-controller="inverterMonitorCtrl" >
		<div  class="bg-light lter b-b padder-v padding-b-10 height_70">
		 
		  <div class="whf_left">
		 	 <span class="font-h3 blue-1 m-n text-black wrapper" ng-bind="inverterName"></span>
		  </div>
		  
		 <div class="wh_left">
			 <img alt="" src="${ctx}/theme/images/inverterMonitor/dayPower.png" style="margin-top: -9px">
		 </div>

		 <div class="wh_float" style="margin-top: -12px">
		 	<div>
		   		<font class="f_color" >日发电量</font>
		   		<br>
		    	<font ng-bind="dw" class="f_color_1"></font>
		    	<font ng-bind="dwUnit"class="f_color_2"></font>
		 	</div>
		 </div>
		  
		 <div class="f_color_3">
		   <img alt="" src="${ctx}/theme/images/inverterMonitor/sumPower.png" style="margin-top: -9px">
		 </div>
		  
		 <div class="f_color_4" style="margin-top: -12px">
		   <div>
		       <font class="f_color">总发电量</font>
		       <br>
		       <font ng-bind="tw" class="f_color_1"></font>
		       <font ng-bind="twUnit" class="f_color_2"></font>
		   </div>
		 </div>
	</div>
	     <div class="hb_parame b-b wrapper">
	    	 <div class="col-sm-12">
		 		<span class="m-r-xs">所属箱变</span>
		 		<span id="boxchangeid" class="m-r-md font_weight a-cur-poi href-blur" ng-bind="boxname" ng-click="toBoxChange(boxchangeid);"></span>
 				<span class="m-r-xs" >位置</span>
 				<span id="address" class="m-r-md font_weight" ng-bind="address"></span>
 				<span class="m-r-xs">逆变器室</span>
 				<span id="inverterroom" class="m-r-md font_weight" ng-bind="inverterroom"></span>
 				<span class="m-r-xs">逆变器组</span>
 				<span id="invertergid" class="m-r-md font_weight" ng-bind="invertergid"></span>
 				<span class="m-r-xs">设备厂商</span>
 				<span id="manufid" class="m-r-md font_weight" ng-bind="manufid"></span>
 				<span class="m-r-xs">产品型号</span>
 				<span id="productid" class="m-r-md font_weight" ng-bind="productid"></span>
 				<a><span  class="m-r-xs col-sm-28 pull-right" onclick="switchInfo()">查看更多信息</span></a>
		 	</div>
	     </div>
	     <div class="hb_info wrapper" id="moreInfo">
	     <span class="pull-left">主要参数:</span>
	     <span class="pull-left" ng-bind="mainparameter"></span>
	     <br>
	     <br>
	     <span class="pull-left">检修工艺卡:</span>
	     <span class="pull-left" ng-bind="repaircard"></span>
	     </div>
		 <div class="hb_info wrapper">
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder text-center">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Tools.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>安装时间</p>
		 			<div id="installDate" ng-bind="installDate"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Speedometer.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>已运行时间</p>
		 			<div id="runhour" ng-bind="runhour"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Clock.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>累计工作时间</p>
		 			<div id="totalHour" ng-bind="totalHour"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Timer.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>正常工作时间</p>
		 			<div id="workHour" ng-bind="workHour"></div>
		 		</div>
		 	</div>
		 	<div style="width:20%" class="col-sm-12 no-padder">
		 		<div class="col-sm-4 no-padder v-middle">
		 			<img alt="" src="${ctx}/theme/images/solway/icon/Hourglass.png" class="m-t-xs">
		 		</div>
		 		<div class="col-sm-8">
		 			<p>故障时间</p>
		 			<div id="faultHour" ng-bind="faultHour"></div>
		 		</div>
		 	</div>
		 </div>
		 
	<div class="wrapper-sm  no-border-xs">
	  <tabset class="nav-tabs-alt nav-tabs-power2" justified="true">
				<!-- 故障发生开始 --> 
			<tab> 
				<tab-heading> 
				<span class="wrapper-sm white-1 a-cur-poi" id="deviceInfo" ng-click="onSelectPage(1)">设备信息</span>
					 </tab-heading>
					 <div class="col-sm-6 text-center m-t">
					 </div>
				<div class="col-sm-12 wrapper-md b-a panel border-none">
				   <div class="w_a_line_h">
				   <font class="font-h3 black-2 line_height_25">当前状态</font>&nbsp;&nbsp;&nbsp;
				   <img alt="" src="${ctx}/theme/images/inverterMonitor/run.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1 line_height_25" ng-bind="inverterMonitorData.s1"></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h3 black-2 line_height_25" >设备容量</font>&nbsp;&nbsp;&nbsp;
				   <img alt="" src="${ctx}/theme/images/inverterMonitor/capacity.png" style="transform: scale(0.8);">
				   <font class="font-h3 black-1 line_height_25"><span ng-bind="buildcapacity|number:1"></span>kW</font>&nbsp;&nbsp;&nbsp;
				   <font class="font-h4 black-1 line_height_25" >出力</font>
				   <font class="font-h4 c_line_height" id="used">0%</font>&nbsp;&nbsp;
			    	<span class="pull-right">
			          	   <font class="font-h3 black-2" style="line-height: 25px"></font>&nbsp;&nbsp;&nbsp;
				           <font class="font-h3 black-1" style="line-height: 25px"><span  ng-bind="millisecond | date:'yyyy-MM-dd HH:mm:ss'"></span></font>&nbsp;&nbsp;&nbsp;
		          	</span>
				   </div>
				   
				   <div class="width_h">
				   <div id="interverdcu" class="height_w_f"></div>
				   <div id="interverdcc" class="height_w_f"></div>
				   <div id="interverdcp" class="height_w_f"></div>
				   <div class="float_w_m">
				   <font class="font-h2 color_line_h" >DC</font>&nbsp;&nbsp;
				   <hr class="height_b_t" />
				   <font class="font-h2 color_line_h" >AC</font>&nbsp;&nbsp;
				   </div>
				   
				   <div id="interveracu" class="height_w_f_m"></div>
				   <div id="interveracc" class="height_w_f_m"></div>
				   <div id="interveracp" class="height_w_f_m"></div>
				   <div class="width_m_h_f_t">
				   <font class="font-h2 black-2" >温度</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.t|number:1"></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >无功功率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.acq|number:1"> </font><font class="font-h2 black-1">kVar</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >效率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.ef|number:2"></font><font class="font-h2 black-1">%</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >频率</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.f|number:2"></font><font class="font-h2 black-1">Hz</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				   <font class="font-h2 black-2" >功率因数</font>&nbsp;&nbsp;
				   <font class="font-h2 black-1" ng-bind="inverterMonitorData.pf|number:2"></font>&nbsp;&nbsp;
				   </div>
				   </div>

				</div>
				</tab> <!-- 故障发生结束 -->
				
				
					<tab  ng-controller="inverpageHistory"> 
						<tab-heading class="wrapper-sm white-1">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">历史信息</span>
							<span class="white-1 a-cur-poi" id="pageHistory"></span> 
						</tab-heading>
					<paging class="col-sm-12 panel no-padder m-b-none">
				<div class="col-sm-12 text-center m-t m-b no-padder">
			<div class="col-sm-9">
			<div class="input-group " style="width: 350px;">
			<input type="text" id="begindate" name="begindate" ng-model="begindate" class="form-control">
         	<span class="input-group-addon">至</span>
         	<input type="text" id="enddate" name="enddate"  ng-model="enddate" class="form-control">
      		 <span class="input-group-btn padder-l-sm ">
         	<button class=" btn btn-sm btn-info" ng-click="onSelectPage(1)" type="button">查询</button>
         	</span>
      		</div>
		    </div>
					     </div>
<div class="row">
	<div class="col-sm-12 pull-right">
		<!-- 分页 -->
		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
	</div>
</div>
					 		<div class="col-sm-12 no-padder " id="deviceDatas">
					 		<div class="col-sm-12 no-padder" id="loadingDiv"></div>
							<div class="col-sm-12 no-padder" ng-grid="inverterGridOptions" id="inverter_result_table" ></div>
						</div>
						</paging>
					</tab>
				
				
					<tab  ng-controller="faultAlarm"> 
					<tab-heading class="wrapper-sm">
						<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">故障信息</span>
						<span class="white-1 a-cur-poi" id="faultalarmTitle" ng-bind="faultalarmTitle"></span> 
					</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					 	<paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="breakdown" class="table table-striped b-t b-light bg-table">
					 		<thead>
							 	<tr>
									 <th width="15%" class="text-left">发生时间</th>
									 <th width="15%" class="text-left">结束时间</th>
					                 <th class="text-left">故障级别</th>
					                 <th class="text-left">故障描述</th>
					                 <th class="text-left">结果</th>
					                 <th>人工处理状态</th>
					            </tr>
			                 </thead>
						 <tbody>
			      				<tr ng-repeat="vo in data">
					      			<td ng-bind="vo.sStartTime|date:'yyyy-MM-dd HH:mm'"></td>
									<td ng-bind="vo.sEndTime|date:'yyyy-MM-dd HH:mm'"></td>
					      			<td class="blue-3 text-left" ng-bind="vo.faultlevelStr"></td>
					      			<td class="blue-3 text-left" ng-bind="vo.eventDesc"></td>
					      			<td class="blue-3 text-left" ><span  ng-if="vo.sEndTime==null">报告</span><span  ng-if="vo.sEndTime!=null">关闭</span></td>
					      			<td ng-bind="vo.handstatusStr "></td>
			      				</tr>
	      				</tbody>
					 	
					 	</table>
						 </paging>
					</tab>
					
					<tab ng-controller="repairt"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">检修维护</span>
							<span class="white-1 a-cur-poi" id="repairtTitle" ng-bind="repairtTitle" ></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
						<paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="maintenance" class="table table-striped b-t b-light bg-table">
					 		   	
						<thead>
						    <tr>
							    <th width="15%">维护时间</th>
				                <th width="15%">维护人</th>
				                <th>维护内容</th>
				                <th width="15%">结果</th>
				            </tr>
				       </thead>
				                	
				     	<tbody>
					   		<tr ng-repeat="vo in maintenance">
					   			<td class="blue-3" ng-bind="vo.repairdate | date:'yyyy-MM-dd HH:mm:ss'"></td>
					   			<td class="blue-3" ng-bind="vo.operator"></td>
					   			<td class="blue-3" ng-bind="vo.repaircontent"></td>
					   			<td class="blue-3" ng-bind="vo.repairresult"></td>
				   			</tr>
		   				</tbody>      
			
					 	</table>
						 </paging>
					</tab>
					
					<tab ng-controller="experiment"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">技术监督</span>
							<span class="white-1 a-cur-poi" id="experimentTile" ng-bind="experimentTile"></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					  <paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="supervise" class="table table-striped b-t b-light bg-table">
					
					<thead>
				    	<tr>
					   		<th width="15%">监督时间</th>
		                	<th width="15%">监督人</th>
		                	<th>监督内容</th>
	               		</tr>
	               </thead>	
	        		
	        	  <tbody>
		   				<tr ng-repeat="vo in supervise">
				   			<td class="blue-3" ng-bind="vo.experidate | date:'yyyy-MM-dd HH:mm:ss'"></td>
				   			<td class="blue-3" ng-bind="vo.operator"></td>
				   			<td class="blue-3" ng-bind="vo.expericontent"></td>
		   				</tr>
		  		</tbody>
					 </table>
					</paging>
					</tab>
					
					<tab ng-controller="replaced"> 
						<tab-heading class="wrapper-sm">
							<span class="white-1 a-cur-poi" ng-click="onSelectPage(1)">技术改造</span>
							<span class="white-1 a-cur-poi" id="replacedTitle" ng-bind="replacedTitle" ></span> 
						</tab-heading>
					<div class="col-sm-6 text-center m-t"></div>
					 <paging class="col-sm-12 wrapper-md b-a panel border-none" style="overflow-x:auto;">
					 		<div class="col-sm-5 pull-right"><%@ include file="/common/pager.jsp"%></div>
					 	<table id="reform" class="table table-striped b-t b-light bg-table">
				<thead>
				    <tr>
				    	<th width="15%">维护时间</th>
	                	<th width="15%">实施人</th>
	                	<th>改造内容</th>
	               </tr>
	            </thead>	
	            <tbody>
		   			<tr ng-repeat="vo in reform">
		   				<td class="blue-3" ng-bind="vo.replaceddate"></td>
		   				<td class="blue-3" ng-bind="vo.operator"></td>
		   				<td class="blue-3" ng-bind="vo.replacedcontent"></td>
		   			</tr>
		   		</tbody>
					</table>
					</paging>
					</tab>
					</tabset>
		</div>

</div>
