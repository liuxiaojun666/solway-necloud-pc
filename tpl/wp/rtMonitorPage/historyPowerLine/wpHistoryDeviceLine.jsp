<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/array.extend.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<style>
	.panel_top {line-height: 34px;padding-left: 0;padding-right: 0;}
	.panel_top em,.modal-header em {font-style: normal;color: #000;margin-left: 5px;}
	.modal-header em {font-size: 16px;}
	.panel_top + .btn {margin-left: 20px;}
	.modal-header {background-color: #f5f5f5;}
</style>
<script type="text/javascript">
	function responseHeight(){
		$("#ssglqx").css("height", $(window).height() - 310);
	}
	window.addEventListener("resize", function() {
		responseHeight();
	});
	responseHeight();
	//日期控件
	$('#begindate').datetimepicker({
		format: "yyyy-mm-dd",
		language: 'zh-CN',
		minView: 2,
		todayHighlight:true,
		todayBtn:true,
		autoclose: true,
		endDate:new Date(new Date()-24*60*60*1000)
	}).on('changeDate', function(ev){
		if(Date.parse(ev.date)>Date.parse($("#enddate").val())){
			$("#enddate").val(ev.date.Format("yyyy-MM-dd"));
		}
		$('#enddate').datetimepicker('setStartDate', ev.date).datetimepicker('update').datetimepicker('show');
	});
	//日期控件
	$('#enddate').datetimepicker({
		format: "yyyy-mm-dd",
		language: 'zh-CN',
		minView: 2,
		todayHighlight:true,
		todayBtn:true,
		autoclose: true,
		endDate:new Date(new Date()-24*60*60*1000)
	});
	
	$("#begindate").val((new Date(new Date-24*60*60*1000)).Format("yyyy-MM-dd"));
	$("#enddate").val((new Date(new Date-24*60*60*1000)).Format("yyyy-MM-dd"));
	String.prototype.endWith=function(str){
		if(str==null||str==""||this.length==0||str.length>this.length)
		  return false;
		if(this.substring(this.length-str.length)==str)
		  return true;
		else
		  return false;
		return true;
	}
	var flag = 0;
	var deviceIdArray = new Array();
	var stationIdArray = new Array();
	app.controller('WpHistoryPowerLineCtrl', function($scope, $http, $document, toaster) {
		$scope.getCurrentDataName('00',0);
		$scope.$on('broadcastSwitchStation', function(event, data) {
			$scope.currentDataName = data.dataName;
//			$scope.selectPowerStation();
			$('#ssglqx').html("");
			$('#selectDevIds').html("");
			$scope.selectedDevice = [];
			
		});
        $scope.isChecked = false;//默认显示逆变器
		$document.on('screenfull.raw.fullscreenchange', function () {
			  if(responseHeight){responseHeight();};
		});
		$scope.$on('refreshViewDataForHead', function(event, data) {
//			$scope.selectPowerStation();
		});

		$scope.windTurbineList = null;
		$scope.getWindTurbineList = function () {
			$scope.windTurbineList = null;
			$http({
				method : "POST",
				url : "${ctx}/WpWindTurbine/queryBWindTurbineByPsId.htm",
				params : {}
			})
			.success(function(result) {
				if (result.key == 0){
					$scope.windTurbineList = result.data;
					for(var i=0;i<$scope.windTurbineList.length;i++){
						for(var j=0;j<deviceIdArray.length;j++){
							if(deviceIdArray[j]==$scope.windTurbineList[i].serialnumber){
								$scope.windTurbineList[i].invChk = true;
							}
						}
					}
				}
			});
		};
		$scope.getWindTurbineList();

		$scope.selectedDevice = [];
		$scope.selectWindTurbine = function(chk,deviceId,deviceName){
			if(stationIdArray.length + deviceIdArray.length>=5 && chk){
				toaster.pop('error','','风电机组最多只能查看5条功率趋势图!');
				event.preventDefault();
				return false;
			}
			var index = deviceIdArray.indexOf(deviceId);
			if(chk && index<0){
				deviceIdArray.push(deviceId);
				$scope.selectedDevice.push({id:deviceId, name:deviceName});
				for(var i=0;i<$scope.windTurbineList.length;i++){
					if(deviceId==$scope.windTurbineList[i].serialnumber){
						$scope.windTurbineList[i].invChk=true;
					}
				}
			} else if((!chk)&&index>=0){
				deviceIdArray.remove(index);
				$scope.selectedDevice.remove(index);
				for(var i=0;i<$scope.windTurbineList.length;i++){
					if(deviceId==$scope.windTurbineList[i].serialnumber){
						$scope.windTurbineList[i].invChk=false;
					}
				}
			}
		};

		$scope.getWpHistoryPowerLineData = function() {
			if(!$("#begindate").val()){
				toaster.pop('error','','请选择时间!');
				return false;
			}
			if(!$("#enddate").val()){
				toaster.pop('error','','请选择结束时间!');
				return false;
			}
			var bdate = $("#begindate").val().split('-');
			var begindate = new Date(bdate[0], bdate[1], bdate[2]);
			var edate = $("#enddate").val().split('-');
			var enddate = new Date(edate[0], edate[1], edate[2]);
			if(enddate<begindate){
				toaster.pop('error','','结束时间必须不能小于开始时间!');
				return false;
			}

			var nowToday = new Date().Format("yyyy-MM-dd");
			if (Date.parse($("#enddate").val()) >= Date.parse(nowToday)) {
				toaster.pop('error','','结束时间不能超过今天!');
				return false;
			}
			if(enddate.diff(begindate)>7){
				toaster.pop('error','','查询时间不能超过7天!');
				return false;
			}
			if((stationIdArray==null||stationIdArray.length==0)&&(deviceIdArray==null||deviceIdArray.length==0)){
				toaster.pop('error','','请选择至少一台设备!');
				return false;
			}
			if(stationIdArray.length+deviceIdArray.length>5){
				toaster.pop('error','','最多只能查看5台设备!');
				return false;
			}
			$("#ssglqx").hide();
			$(".panel.hidden").removeClass('hidden');
			CommonPerson.Base.LoadingPic.PartShow('loadingDiv');//加载状态
			$http({
				method : "POST",
				url : "${ctx}/WpHistoryPowerLine/getWpHistoryDevicesLineData.htm",
				params : {
					'deviceIds':deviceIdArray,
					'begindate': $("#begindate").val(),
					'enddate': $("#enddate").val()
				}
			}).success(function(result) {
				var data = result.data;
				partHide('loadingDiv');
				$("#ssglqx").show();
				var echarts_legend = [];
				for (var i = 0; i < data.echarts_powers.length; i++) {
					echarts_legend.push(data.echarts_powers[i].deviceName);
				}
				echarts_legend.push('风速');
				if($scope.isChecked){
					getNewData(data.echarts_xaxisTime, echarts_legend, data.echarts_powers, data.echarts_windSpeed, $http, $scope);
				}else{
					if(!data.echarts_xaxisTime){
						data.echarts_xaxisTime = [];
					}
					if(!data.echarts_powers){
						data.echarts_powers = [];
					}
					if(!data.echarts_windSpeed){
						data.echarts_windSpeed = [];
					}
					getPowerV(data.echarts_xaxisTime, echarts_legend, data.echarts_powers, data.echarts_windSpeed, $http, $scope);
				}
			}).error(function(response){
				partHide('loadingDiv');
			});
		};

		<!--点击归一化 -->
		$scope.showScale = function(){
			$scope.isChecked ? $scope.isChecked = false : $scope.isChecked = true;
			$scope.getWpHistoryPowerLineData();
		};
	});

	$('#modal-device').one('shown.bs.modal', function (e) {//显示
		$('.checkedDeviceList').hide();
	});
	$('#modal-device').one('hide.bs.modal', function (e) {//隐藏
		$('.checkedDeviceList').show();
	});
	$('.undoChecked').click(function() {
		$('.checkedDeviceList .data-red').trigger('click')
	});

	function getPowerV(echarts_xaxisTime, echarts_legend, echarts_powers, echarts_windSpeed, $http, $scope) {

		var myChart = echarts.init(document.getElementById('ssglqx'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			title : {
				text : '功率趋势图',
				x: 20,
				textStyle : {
					fontSize : 14,
					color : "#666",
					fontFamily : '微软雅黑',
					fontWeight : 'normal'
				}
			},
			color: ["#D8412F","#5B459D","#1CAF9A", "#428BCA","#97C34B"],
			tooltip : {
				trigger: 'axis',
				axisPointer:{
					type: 'line',
					lineStyle: {
						color: '#CCC',
						width: 1,
						type: 'dotted'
					}
				},
				/**formatter: function(params, ticket, callback) {
					var res = params[0].name;
					var power ="功率"
					for (var i = 0, l = params.length; i < l; i++) {
						if (params[i].value != "" && !isNaN(params[i].value)) {
							console.log((parseFloat((params[i]).value)).toFixed(1))
							console.log((parseFloat((params[i]).value)).toFixed(1))
							if (i==(l-1)) {
								res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1)+' &nbsp;W/㎡<hr style="padding: 0;height: 1px;margin: 4px 0;color: #333;">';
							} else {
								power += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1)+"kW";
							}
						} else if (params[i].value == "") {
							if (i==(l-1)) {
								res += '<br/>' + params[i].seriesName + ' : N/A<hr style="padding: 0;height: 1px;margin: 4px 0;color: #333;">';
							} else {
								power += '<br/>' + params[i].seriesName + ': N/A';
							}
						}
					}
					return res+power;
				}*/
				//formatter: "{b} : {c}kW"
			},
			dataZoom:{
				show: true
			},
			legend : {
				x : 'right',
				orient : 'horizontal',
				data : echarts_legend
			},
			calculable : true,
			grid : {
				borderWidth : '0px',
				x : '60',
				x2 : '60',
				y : "70",
				y2 : "70"
			},
			xAxis : [ {
				axisTick : {
					show : false
				},
				axisLabel : {
					// interval:59,
					/*interval:function(index,data){
					 if((data+"").endWith("00")){
					 return true;
					 }
					 return false;
					 },*/
					textStyle : {
						color : '#bbb',
						fontSize : 12
					},
					formatter: function(params,ticket,callback) {
						if(params && params.length > 11){
							params = params.substr(-11);
						}
						return params;
					}
				},
				type : 'category',
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				splitLine : {
					show : false
				},
				boundaryGap : false,
				data : echarts_xaxisTime
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : "kW",
				nameTextStyle: {
					color: "#000",
					fontSize: 14
				},
				font : {
					color : '#bbb'
				},
				splitLine: {
					show: true,
					lineStyle: {
						type: 'dotted'
					}
				},
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				type : 'value'
			}, {
				name : "m/s",
				nameTextStyle: {
					color: "#000",
					fontSize: 14
				},
				font : {
					color : '#bbb'
				},
				axisLine : {
					lineStyle : {
						color : '#bbb',
						width : 1
					}
				},
				splitLine : {
					show : false
				},
				type : 'value',
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					},
					formatter : function(v) {
						return v;
					}
				}
			} ],
			series : []
		};
		option.color[echarts_legend.length-1] = "#FFC700";
		if(echarts_powers!=null&&echarts_powers.length>0){
			for(var i=0;i<echarts_powers.length;i++){
				var da = echarts_powers[i];
				option.series[i]={
					name:da.deviceName,
					type : 'line',
					yAxisIndex : 0,
					itemStyle : {
						normal : {
							areaStyle : {
								color : 'transparent'
							},
							lineStyle : {
								width : 1
							}
						}
					},
					symbol : 'none',
					smooth: 'true',
					data : da.power
				};
			}
		}
		var windSpeed={
			name:"风速",
			type : 'line',
			yAxisIndex : 1,
			itemStyle : {
				normal : {
					areaStyle : {
						color : 'transparent'
					},
					lineStyle : {
						width : 1,
						color : "#FFC700"
					}
				}
			},
			symbol : 'none',
			smooth: 'true',
			data : echarts_windSpeed
		};
		option.series.push(windSpeed);
		myChart.setOption(option);
	}

	function getNewData(echarts_xaxisTime, echarts_legend, echarts_powers, echarts_windSpeed, $http, $scope){
		for(var i = 0;i<echarts_powers.length;i++){
			var newPowerArr = [];
			var curentPower = echarts_powers[i].power;
			for(var j = 0;j<curentPower.length;j++){
				var currentProportion = 0;
				if(Number(curentPower[j]) != 0 && Number(echarts_windSpeed[j]) != 0){
					currentProportion = (Number(curentPower[j])/Number(echarts_windSpeed[j]));
				}else{
					currentProportion = 0;
				}
				newPowerArr.push(currentProportion);
			}
			echarts_powers[i].power = [];
			echarts_powers[i].power = newPowerArr;
		}
		getPowerV(echarts_xaxisTime, echarts_legend, echarts_powers, echarts_windSpeed, $http, $scope);
	}
</script>
<div ng-controller="WpHistoryPowerLineCtrl" >
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">设备功率趋势图</span> -->
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<div class="col-sm-3" style="width: 350px;">
					<div class="col-sm-4 panel_top">
						设备总数
						<em>
							<span ng-bind="windTurbineList.length"></span>台
						</em>
					</div>
					<div class="col-sm-4 panel_top">
						已选择设备数
						<em>
							<span id="selectNum" ng-bind="selectedDevice.length"></span>台
						</em>
					</div>
					<button class="btn btn-info" data-toggle="modal" data-target="#modal-device" type="button">选择设备</button>
				</div>
				<div class="col-sm-4">
					<div class="input-group">
						<input type="text" id="begindate" name="begindate" class="form-control">
						<span class="input-group-addon">至</span>
						<input type="text" id="enddate" name="enddate" class="form-control">
						<span class="input-group-btn padder-l-sm ">
						<button class=" btn btn-sm btn-info" ng-click="getWpHistoryPowerLineData()" type="button">查询</button>
						</span>
					</div>
				</div>
			<!-- <div class="col-sm-3" style="line-height: 34px;"><input  type="checkbox" ng-checked="isChecked" ng-click="showScale()" style="vertical-align: sub;">风电机组归一化</div> -->
			</div>
			<div class="row wrapper">
				<hr style="margin-top: -15px;margin-bottom: 10px;">
				<div class="col-sm-1 m-t-xs" style="padding-top: 5px;">
					<span class="">已选中:</span>
				</div>
				<div class="col-sm-11 checkedDeviceList">
					<div id="selectDevIds" class="col-sm-2 wrapper-xs" ng-repeat=" windTurbine in selectedDevice">
						<span class="wrapper-xs body-bg-color" ng-bind="windTurbine.name"></span><span class="data-red wrapper-xs a-cur-poi body-bg-color" ng-click="selectWindTurbine(false,windTurbine.id,windTurbine.name)">X</span>
					</div>
				</div>
			</div>
			<div class="modal fade" id="modal-device">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<a class="icon-close modelCloseBtn time black-1" data-dismiss="modal"></a>
							<span>
								设备总数
								<em>
									<span ng-bind="windTurbineList.length"></span>台
								</em>
							</span>
							<span class="ml20">
								已选择设备数
								<em>
									<span ng-bind="selectedDevice.length"></span>台
								</em>
							</span>
						</div>
						<div class="modal-body" style=";max-height: 350px;overflow-y: auto;">
							<div class="row wrapper">
								<div class="col-sm-12">
									<div class="col-sm-4" ng-repeat="windTurbine in windTurbineList">
										<label>
											<input type="checkbox" ng-click="selectWindTurbine(windTurbine.invChk,windTurbine.serialnumber,windTurbine.name);" ng-model="windTurbine.invChk" value="{{windTurbine.serialnumber}}"/>
											<span ng-bind="windTurbine.name"></span>
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer text-center">
							<button class="btn btn-info" type="button" data-dismiss="modal">确定</button>
							<button class="btn undoChecked" type="button" style="margin-left: 15px;">清空</button>
							<button class="btn" style="margin-left: 15px;" type="button" data-dismiss="modal">取消</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="panel pr panel-default m-b-none">
			<div class="row wrapper">
				<div class="col-sm-12 no-padder" id="loadingDiv"></div>
				<div id="ssglqx" style="height: 350px;">
					<div class="noSearchStat"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="waterPlaceholder"></div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
