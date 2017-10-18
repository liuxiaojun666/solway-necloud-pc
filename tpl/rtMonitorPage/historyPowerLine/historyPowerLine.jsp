	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/array.extend.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript">
	function responseHeight(){
		$("#ssglqxDay").css("height", $(window).height() - 255);
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
		endDate:new Date(new Date-24*60*60*1000)
	}).on('changeDate', function(ev){
		if(Date.parse(ev.date)>Date.parse($("#enddate").val())){
			$("#enddate").val(ev.date.Format("yyyy-MM-dd"));
		};
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
		endDate:new Date(new Date-24*60*60*1000)
	});
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
	app.controller('HistoryStatLineCtrl', function($scope, $http, toaster, $document, $stateParams) {
		$scope.getCurrentDataName('00',0);
		$scope.$on('broadcastSwitchStation', function(event, data) {
			$scope.currentDataName = data.dataName;
			$scope.getCurrentSTID();
			$('#ssglqxDay').html("");
		});

        $scope.isChecked = false;//默认显示功率

		$document.on('screenfull.raw.fullscreenchange', function () {
			  responseHeight();
		});
		($scope.getCurrentSTID = function() {
			$http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
				params : {
					}
			}).success(function(msg) {
				$scope.powerStationId = msg.currentSTID;
			})
		})()

		$scope.$on('refreshViewDataForHead', function(event, data) {
			$scope.getCurrentSTID();
		});
		// $scope.powerStationId = 1;

		$scope.getHistoryPowerLineData = function() {
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

			if(enddate.diff(begindate)>7){
				toaster.pop('error','','查询时间不能超过7天!');
				return false;
			}
			var nowToday = new Date().Format("yyyy-MM-dd");
			if (Date.parse($("#enddate").val()) >= Date.parse(nowToday)) {
				toaster.pop('error','','结束时间不能超过今天!');
				return false;
			}
			/*if((stationIdArray==null||stationIdArray.length==0)&&(deviceIdArray==null||deviceIdArray.length==0)){
				toaster.pop('error','','请选择电站或至少一台逆变器!');
				return false;
			}
			if(stationIdArray.length+deviceIdArray.length>5){
				toaster.pop('error','','电站和逆变器最多只能查看5条功率趋势图!');
				return false;
			}*/
			$("#ssglqxDay").hide();
			CommonPerson.Base.LoadingPic.PartShow('loadingDiv');//加载状态
			$http({
				method : "POST",
				url : "${ctx}/HistoryPowerLine/getHistoryPowerData.htm",
				params : {
					'stationid': $scope.powerStationId,
					// 'stationids':stationIdArray,
					// 'deviceIds':deviceIdArray,
					'begindate':$("#begindate").val(),
					'enddate':$("#enddate").val()
				}
			}).success(function(result) {
				var data = result.data
				partHide('loadingDiv');
				$("#ssglqxDay").show();
                var type  = "";
                $scope.isChecked ? type = "b" : type = "a";
                var instKw = data.inst_kw;
				getPowerV(data.echarts_xaxisTime, data.echarts_predictPower, data.echarts_power, data.echarts_luminousIntensity, $http, $scope,type,instKw);
			}).error(function(response){
				partHide('loadingDiv');
			});
		};

		$("#begindate").val((new Date(new Date-24*60*60*1000)).Format("yyyy-MM-dd"));
		$("#enddate").val((new Date(new Date-24*60*60*1000)).Format("yyyy-MM-dd"));
		
		$scope.showScale = function(){
            $scope.isChecked ? $scope.isChecked=false : $scope.isChecked=true;
			$scope.getHistoryPowerLineData();
		}
	});
	var myChart;
	function getPowerV(echarts_xaxisTime, echarts_predictPower, echarts_power, echarts_luminousIntensity, $http, $scope,type,instKw) {
		var scaleArr = [];
		if(instKw && instKw != 0){
			for(var i=0;i<echarts_power.length;i++){
				if(Number(echarts_power[i]) != 0 && Number(echarts_luminousIntensity[i]) > 25){
					var currentProportion = (Number(echarts_power[i]) * 1000/(Number(echarts_luminousIntensity[i]) * instKw)).toFixed(2);
				}else{
					var currentProportion = 0;
				}
				scaleArr.push(currentProportion);
			}
		}
		var legname = "功率";
		var legunit = "kW";
		if(type == "b"){
			legname = "功率归一化";
			legunit = "";
		}

		myChart = echarts.init(document.getElementById('ssglqxDay'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			/*title : {
				text : '功率趋势图',
				textStyle : {
					fontSize : 14,
					color : "#666",
					fontFamily : '微软雅黑',
					fontWeight : 'normal'
				}
			},*/
			tooltip: {
				trigger: 'axis',
				axisPointer: {
					type: 'line',
					lineStyle: {
						color: '#bbb',
						width: 1,
						type: 'dotted'
					}
				},
				/**formatter: function(params, ticket, callback) {
					var res = params[0].name;
					for (var i = 0, l = params.length; i < l; i++) {
						if (params[i].value != "" && !isNaN(params[i].value)) {
							res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
							if(i==1){
								res += "W/㎡";
							}else{
								res += "kW";
							}
						} else if (params[i].value == "") {
							res += '<br/>' + params[i].seriesName + ' : N/A';
						}
					}
					return res;
				}*/
			},
			noDataLoadingOption: {
				text: '暂无数据',
				effect: function(params, callback) {
					return "暂无数据"
				}
			},
			color: ['#f56669', '#ffc700'],
			calculable: true,
			grid: {
				borderWidth: '0px',
				x: '60',
				x2: '60',
				y: "60",
				y2: "70"
			},
		    legend : {
				x : 'right',
				y: 0,
				orient : 'horizontal',
				data :[{
                            name:legname,
                            textStyle:{color:'#f56669'}
                        },
                        {
                            name:'光照强度',
                            textStyle:{color:'orange'}
                }]

			},
			dataZoom:{
				show: true,
				// y: 280
			},
			xAxis: [{
				type: 'category',
				axisLine: {
					show: true,
					lineStyle: {
						color: '#999',
						width: 1
					}
				},
				axisLabel: {
					show: true,
					axisLabel: 5,
					textStyle: {
						align: 'center',
						color: '#666',
						fontSize: 13
					},
					formatter: function(params) {
						if(params.length > 11){
							params = params.substr(-11);
						}
						return params;
					}
				},
				splitLine: {
					show: false
				},
				axisTick: {
					show: false
				},
				boundaryGap: false,
				show: true,
				data: echarts_xaxisTime
			}],
			yAxis: [{
				// show: false,
				axisLabel: {
					textStyle: {
						color: '#666',
						fontSize: 12
					}
				},
				name : legunit,
				nameLocation: 'end',
				nameTextStyle: {
					color: "#000",
					fontSize: 14
				},
				font: {
					color: '#666'
				},
				axisLine: {
					lineStyle: {
						color: '#999',
						width: 1
					}
				},
				splitLine: {
					show: true,
					lineStyle: {
						type: 'dotted'
					}
				},
				/*splitArea: {
					show: true,
					areaStyle: {
						color: ['#fff', '#f6f6f6']
					}
				},*/
				type: 'value'
			}, {
				name : "W/㎡",
				nameLocation: 'end',
				nameTextStyle: {
					color: "#000",
					fontSize: 14
				},
				font: {
					color: '#666'
				},
				axisLine: {
					lineStyle: {
						color: '#999',
						width: 1
					}
				},
				splitLine: {
					show: false
				},
				type: 'value',
				axisLabel: {
					textStyle: {
						color: '#666',
						fontSize: 12
					},
					formatter: function(v) {
						return v;
					}
				}
			}],
			series:function(){
				if(type == "b"){
					return  [
						{
							name: '功率归一化',
							type: 'line',
							z: 1,
							itemStyle: {
								normal: {
									areaStyle: {
										color: 'transparent'
									},
									lineStyle: {
										color: '#f56669',
										width: 1
									}
								}
							},
							symbol: 'none',
							smooth: 'true',
							data: scaleArr
						},
						{
							name: '光照强度',
							type: 'line',
							yAxisIndex: 1,
							z: 2,
							smooth: 'true',
							itemStyle: {
								normal: {
									areaStyle: {
										color: 'transparent'
									},
									lineStyle: {
										type: 'dotted',
										color: '#ffc700',
										width: 1
									}
								}
							},
							symbol: 'none',
							data: echarts_luminousIntensity
						}]
				}else{
					return  [
						{
							name: '功率',
							type: 'line',
							z: 1,
							itemStyle: {
								normal: {
									areaStyle: {
										color: 'transparent'
									},
									lineStyle: {
										color: '#f56669',
										width: 1
									}
								}
							},
							symbol: 'none',
							smooth: 'true',
							data: echarts_power
						},
						{
							name: '光照强度',
							type: 'line',
							yAxisIndex: 1,
							z: 2,
							smooth: 'true',
							itemStyle: {
								normal: {
									areaStyle: {
										color: 'transparent'
									},
									lineStyle: {
										type: 'dotted',
										color: '#ffc700',
										width: 1
									}
								}
							},
							symbol: 'none',
							data: echarts_luminousIntensity
					}]
				}
			}()
		};
		myChart.setOption(option);
	}
</script>
<div ng-controller="HistoryStatLineCtrl" >
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">电站功率趋势图</span> -->
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<div class="col-sm-3" style="width: 120px;line-height: 34px;">
					功率趋势图
				</div>
				<div class="col-sm-5">
					<div class="input-group ">
						<input type="text" id="begindate" name="begindate" class="form-control">
						<span class="input-group-addon">至</span>
						<input type="text" id="enddate" name="enddate" class="form-control">
						<span class="input-group-btn padder-l-sm ">
						<button class=" btn btn-sm btn-info" ng-click="getHistoryPowerLineData()" type="button">查询</button>
						</span>
					</div>
				</div>
                <div class="col-sm-3" style="line-height: 34px;"><input  type="checkbox" ng-checked="isChecked" ng-click="showScale()" style="vertical-align: sub;">功率归一化</div>
			</div>
		</div>
		<div class="panel pr panel-default">
			<div class="row wrapper">
				<div class="col-sm-12 no-padder" id="loadingDiv"></div>
				<div id="ssglqxDay" style="min-height: 200px;">
					<div class="noSearchStat"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="waterPlaceholder"></div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
