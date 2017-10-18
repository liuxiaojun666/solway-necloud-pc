<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/wp/dataAnalysisPage/curveDetailModel.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
.change{display:none;}
</style>
<div  ng-controller="curveDetailModelCtrl">
	<div class="detail-header clearfix">
		<div class="date-con">
			<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'" ></div>
		</div>
		<div class="tabs-con">
			<ul>
				<li ng-repeat="item in tabNames" ng-class="{'tab-active':tabActive == $index}"  ng-click="changeTab($index)"><span class="square"></span>{{item}}</li>
			</ul>
		</div>
	</div>
	<div class="curves-con">
		<div class="clearfix" style="margin: 30px 0 0;">
			<div class="pull-left year-con">
				<div id="curve-year" style="height: 200px;width:350px;margin:0 auto;"></div>
			</div>
			<div class="pull-right total-con">
				<div id="curve-total" style="height: 200px;width:350px;margin:0 auto;"></div>
			</div>
		</div>
		<div class="month-con">
			<div id="curve-month" style="height: 200px;width:750px;margin:0 auto;"></div>
		</div>
	</div>
</div>
<script>
app.controller('curveDetailModelCtrl',function($scope, $http, $state, $stateParams) {
	
	//初始化数据 默认取前一天
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM-dd");
	
	//改变时间
	$scope.$on('emitChangeDate', function(event, data) {
		var dtime =new Date(data.dtime).Format("yyyy-MM");
		var currentTime = new Date().Format("yyyy-MM");
		if(currentTime ==dtime){//如果是当前月，取昨天的日期
			$scope.dtime = rightDay.Format("yyyy-MM-dd");
		}else{//非当前月，取该月最后一天的日期
			var year = dtime.split("-")[0];
			var month = dtime.split("-")[1];
			$scope.dtime = dtime+"-"+getDaysInOneMonth(year,month);
		}
		getAlertData();
	});
	
	//参数类型的接收
	$scope.$on('detailType',function(event,data){
		$scope.detailType = data;
		$scope.tabActive = 0;
		init();
	});
	$scope.tabActive = 0;//默认显示第一个tab
	
	function init(){
		if($scope.detailType == "00"){
			$scope.detailTypeName = "发电	";
			$scope.tabNames = ["发电","限电"];
		}else if($scope.detailType == "10"){
			$scope.detailTypeName = "平均风速";
			$scope.tabNames = ["平均风速","理论风能"];
		}else if($scope.detailType == "20"){
			$scope.detailTypeName = "发电任务";
			$scope.tabNames = ["发电任务","技改任务"];
		}else if($scope.detailType == "30"){
			$scope.detailTypeName = "高效运行占比";
			$scope.tabNames = ["高效运行占比","PBA"];
		}else if($scope.detailType == "40"){
			$scope.detailTypeName = "收入";
			$scope.tabNames = ["收入","支出"];
		}else if($scope.detailType == "50"){
			$scope.detailTypeName = "故障率";
			$scope.tabNames = ["故障率","可利用率"];
		}
		getAlertData()
	}
	
	//弹框数据
	function getAlertData(){
		$http({
			method : "POST",
			url : "./WPOverView/getStationOverviewPower.htm",
			params : {
   				'dtime':$scope.dtime,
   				'module':$scope.detailType
   			}
		})
		.success(function (msg) {
			 //console.log(msg);
			 $scope.chartTotalData = msg;
			 getYearData();
			 getTotalData();
			 getMonthData();
		}).error(function(msg){
		}); 
	}
	
	//获取该月的天数
	function getDaysInOneMonth(year, month){  
		 month = parseInt(month, 10);  
		 var d= new Date(year, month, 0);  
		 return d.getDate();  
	}  
	
	//切换标签页
	$scope.changeTab = function(index){
		$scope.tabActive = index;
		
		if($scope.detailType == "00" || $scope.detailType == "01"){
			if(index == 0){
				$scope.detailTypeName = "发电";
				$scope.detailType = "00";
			}else if(index == 1){
				$scope.detailTypeName = "限电";
				$scope.detailType = "01";
			}
		}else if($scope.detailType == "10" || $scope.detailType == "11"){
			if(index == 0){
				$scope.detailTypeName = "平均风速";
				$scope.detailType = "10";
			}else if(index == 1){
				$scope.detailTypeName = "理论风能";
				$scope.detailType = "11";
			}
		}else if($scope.detailType == "20" || $scope.detailType == "21"){
			if(index == 0){
				$scope.detailTypeName = "发电任务";
				$scope.detailType = "20";
			}else if(index == 1){
				$scope.detailTypeName = "技改任务";
				$scope.detailType = "21";
			}
		}else if($scope.detailType == "30" || $scope.detailType == "31"){
			if(index == 0){
				$scope.detailTypeName = "高效运行占比";
				$scope.detailType = "30";
			}else if(index == 1){
				$scope.detailTypeName = "PBA";
				$scope.detailType = "31";
			}
		}else if($scope.detailType == "40" || $scope.detailType == "41"){
			if(index == 0){
				$scope.detailTypeName = "收入";
				$scope.detailType = "40";
			}else if(index == 1){
				$scope.detailTypeName = "支出";
				$scope.detailType = "41";
			}
		}else if($scope.detailType == "50" || $scope.detailType == "51"){
			if(index == 0){
				$scope.detailTypeName = "故障率";
				$scope.detailType = "50";
			}else if(index == 1){
				$scope.detailTypeName = "可利用率";
				$scope.detailType = "51";
			}
		}
		getAlertData()
		
	}

	//年累计发电量
	function getTotalData(){
		var totalData = $scope.chartTotalData.corrPowerList;
		var colorList = [];//负数表示下降，记为0，用红色表示，正数为上涨，记为1，用绿色表示
		/**totalData.time = [2012,2013,2014,2015,2016];
		totalData.yearY_pr = [-50,10,8,13,60];
		totalData.yearY = [700,800,1000,1600,1400];*/
		if(totalData && totalData.yearY_pr && totalData.yearY_pr.length > 0){
			for(var i = 0;i<totalData.yearY_pr.length;i++){
				if(totalData.yearY_pr[i] == null){
					colorList.push(0);
				}else if(totalData.yearY_pr[i] >=0){
					colorList.push(1);
				}else{
					totalData.yearY_pr[i] = -totalData.yearY_pr[i];
					colorList.push(0);
				}
			}
		}
		if(totalData && totalData.time && totalData.time.length > 0){
			for(var i = 0;i<totalData.time.length;i++){
				totalData.time[i] = totalData.time[i].substring(0,4);
			}
			
		}
		drawTotalCurve(totalData.time,totalData.yearY_pr,totalData.yearY,colorList);
	}
	//年总发电量
	function getYearData(){
		var yearData = $scope.chartTotalData.yearPowerList;
		var colorList = [];//负数表示下降，记为0，用红色表示，正数为上涨，记为1，用绿色表示
		/**yearData.time = [2012,2013,2014,2015,2016];
		yearData.yearY_pr = [-50,10,8,13,60];
		yearData.yearY = [700,800,1000,1600,1400];*/
		if(yearData && yearData.yearY_pr && yearData.yearY_pr.length > 0){
			for(var i = 0;i<yearData.yearY_pr.length;i++){
				if(yearData.yearY_pr[i] == null){
					yearData.yearY_pr[i] = "-";
					colorList.push(0);
				}else if(yearData.yearY_pr[i] >=0){
					colorList.push(1);
				}else{
					yearData.yearY_pr[i] = -yearData.yearY_pr[i];
					colorList.push(0);
				}
			}
			
		}
		if(yearData && yearData.time && yearData.time.length > 0){
			for(var i = 0;i<yearData.time.length;i++){
				if(yearData.time[i] == null){
					yearData.time[i] = "-";
				}
			}
		}
		if(yearData && yearData.yearY && yearData.yearY.length > 0){
			for(var i = 0;i<yearData.yearY.length;i++){
				if(yearData.yearY[i] == null){
					yearData.yearY[i] = "-";
				}
			}
		}
		drawYearCurve(yearData.time,yearData.yearY_pr,yearData.yearY,colorList);
		
	}
	//月发电量
	function getMonthData(){
		var monthData = $scope.chartTotalData.monthRealPowerList;
		var colorList = [];//负数表示下降，记为0，用红色表示，正数为上涨，记为1，用绿色表示
		/**monthData.time = ['201201','201302','201403','201504','201605'];
		monthData.year_pr = [-50,10,-8,13,60];
		monthData.currYear = [700,800,1000,1600,1400];
		monthData.preYear = [null,300,800,1000,1200];*/
		if(monthData && monthData.year_pr && monthData.year_pr.length > 0){
			for(var i = 0;i<monthData.year_pr.length;i++){
				if(monthData.year_pr[i] == null){
					colorList.push(0);
				}else if(monthData.year_pr[i] >=0){
					colorList.push(1);
				}else{
					monthData.year_pr[i] = -monthData.year_pr[i];
					colorList.push(0);
				}
			}
		}
		if(monthData && monthData.time && monthData.time.length > 0){
			for(var i = 0;i<monthData.time.length;i++){
				monthData.time[i] = monthData.time[i].substring(4,6);
			}
			
		}
		drawMonthCurve(monthData.time,monthData.year_pr,monthData.currYear,monthData.preYear,colorList);
	}
	
	//形成曲线--年
	function drawYearCurve(x,yBarData,yLineData,colorList){
		/* console.log("年");
		console.log(x);
		console.log(yBarData);
		console.log(yLineData);
		console.log(colorList); */
		var myChartYear = echarts.init(document.getElementById('curve-year'));
		window.addEventListener("resize", function() {
			myChartYear.resize();
		});
		var option = {
			title:{
				text:"年总" + $scope.detailTypeName,
				x:"center"
			},
			tooltip: {
				trigger: 'axis',
				formatter: function(params, ticket, callback) {
					if(!params[0].name) return;
					var value0 = "-";
					if(params[0].value){
						value0 = params[0].value;
					}
					var res = params[0].name + " 年"+$scope.detailTypeName+"：";
					res += value0;
					var value = "-";
					if(params[1].value){
						value = params[1].value;
						if(colorList[params[0].dataIndex] == 0){
							res +=" 同比下降"+value+"%";
						}else if(colorList[params[0].dataIndex] == 1){
							res +=" 同比提高"+value+"%";
						}
					}
					return res;
				}
			},
			grid: {
				borderWidth: '0px',
				x: '60px',
				x2: '40px',
				y: "55px",
				y2: "30px"
			},
			xAxis: [{
				type: 'category',
				axisTick: {
					show: false
				},
				axisLabel: {
					textStyle: {
						color: '#bbb',
						fontSize: 12
					}
				},
				axisLine: {
					lineStyle: {
						color: '#bbb',
						width: 1
					}
				},
				splitLine: {
					show: false
				},
				data: x
			}],
			yAxis: [{
				name: "kWh",
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				splitLine: {
					show: false
				},
				type: 'value'
			}, {
				name: '%',
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				splitLine: {
					show: false
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				type: 'value'
			}],
			series: [{
				type: 'line',
				itemStyle: {
					normal: {
						color: function(params) {
							return 'rgb(119,128,255)'
						},
						lineStyle: {
							type: "solid"
						}
					}

				},

				data: yLineData
			},{
				type: 'bar',
				yAxisIndex: 1,
				symbol: 'none',
				barWidth: 15,
				itemStyle: {
					normal: {
						color: function(params) {
							if(colorList[params.dataIndex] == 0){
								return 'rgb(251,133,139)'
							}else if(colorList[params.dataIndex] == 1){
								return 'rgb(133,251,188)'
							}
						}
					}
				},
				data: yBarData
			}]
		};
		myChartYear.setOption(option);
	}
	
	//形成曲线--累计
	function drawTotalCurve(x,yBarData,yLineData,colorList){
		/* console.log("累计");
		console.log(x);
		console.log(yBarData);
		console.log(yLineData);
		console.log(colorList); */
		var myChartTotal = echarts.init(document.getElementById('curve-total'));
		window.addEventListener("resize", function() {
			myChartTotal.resize();
		});
		var option = {
			title:{
				text:"年同期"+$scope.detailTypeName+"(截至" +$scope.dtime.substring(5,10) +")",
				x:"center"
			},
			tooltip: {
				trigger: 'axis',
				formatter: function(params, ticket, callback) {
					if(!params[0].name) return;
					var value0 = "-";
					if(params[0].value){
						value0 = params[0].value;
					}
					var res = params[0].name + " 年同期"+$scope.detailTypeName+"：";
					res += value0;
					var value = "-";
					if(params[1].value){
						value = params[1].value;
						if(colorList[params[0].dataIndex] == 0){
							res +=" 同比下降"+value+"%";
						}else if(colorList[params[0].dataIndex] == 1){
							res +=" 同比提高"+value+"%";
						}
					}
					return res;
				}
			},
			grid: {
				borderWidth: '0px',
				x: '60px',
				x2: '40px',
				y: "55px",
				y2: "30px"
			},
			xAxis: [{
				type: 'category',
				axisTick: {
					show: false
				},
				axisLabel: {
					textStyle: {
						color: '#bbb',
						fontSize: 12
					}
				},
				axisLine: {
					lineStyle: {
						color: '#bbb',
						width: 1
					}
				},
				splitLine: {
					show: false
				},
				data: x
			}/* , {
				type: 'category',
				show: false,

				data: x
			} */],
			yAxis: [{
				name: "kWh",
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				splitLine: {
					show: false
				},
				type: 'value'
			}, {
				name: '%',
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				splitLine: {
					show: false
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				type: 'value'
			}],
			series: [{
				type: 'line',
				itemStyle: {
					normal: {
						color: function(params) {
							return 'rgb(119,128,255)'
						},
						lineStyle: {
							type: "solid"
						}
					}

				},

				data: yLineData
			},{
				type: 'bar',
				yAxisIndex: 1,
				symbol: 'none',
				barWidth: 15,
				itemStyle: {
					normal: {
						color: function(params) {
							if(colorList[params.dataIndex] == 0){
								return 'rgb(251,133,139)'
							}else if(colorList[params.dataIndex] == 1){
								return 'rgb(133,251,188)'
							}
						}
					}
				},
				data: yBarData
			}]
		};
		myChartTotal.setOption(option);
	}
	
	//形成曲线--月
	function drawMonthCurve(x,yBarData,yLineData,yLineLastYearData,colorList){
		/* console.log("月");
		console.log(x);
		console.log(yBarData);
		console.log(yLineData);
		console.log(yLineLastYearData);
		console.log(colorList); */
		var myChartMonth = echarts.init(document.getElementById('curve-month'));
		window.addEventListener("resize", function() {
			myChartMonth.resize();
		});
		var option = {
			title:{
				text:"月"+$scope.detailTypeName,
				x:"center"
			},
			tooltip: {
				trigger: 'axis',
				formatter: function(params, ticket, callback) {
					if(!params[0].name) return;
					var value0 = "-";
					if(params[0].value){
						value0 = params[0].value;
					}
					var res = "月份：" + params[0].name + " 今年：";
					res += value0;
					var value1 = "-";
					if(params[1].value){
						value1 = params[1].value;
					}
					res += " 去年："+value1;
					var value = "-";
					if(params[2].value){
						value = params[2].value;
						if(colorList[params[0].dataIndex] == 0){
							res +=" 同比下降"+value+"%";
						}else if(colorList[params[0].dataIndex] == 1){
							res +=" 同比提高"+value+"%";
						}
					}
					return res;
				}
			},
			grid: {
				borderWidth: '0px',
				x: '60px',
				x2: '40px',
				y: "55px",
				y2: "30px"
			},
			xAxis: [{
				type: 'category',
				axisLabel: {
					textStyle: {
						color: '#bbb',
						fontSize: 12
					},
				},
				axisLine: {
					lineStyle: {
						color: '#bbb',
						width: 1
					}
				},
				data: x
			}],
			yAxis: [{
				name: "kWh",
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				splitLine: {
					show: false
				},
				type: 'value'
			}, {
				name: '%',
				axisLine: {
					lineStyle: {
						width: 1,
						color: '#bbb'
					}
				},
				splitLine: {
					show: false
				},
				axisLabel: {
					axisLabel: 10,
					textStyle: {
						color: '#bbb',
						fontSize: 13
					}
				},
				type: 'value'
			}],
			series: [{
				type: 'line',
				itemStyle: {
					normal: {
						color: function(params) {
							return 'rgb(119,128,255)'
						},
						lineStyle: {
							type: "solid"
						}
					}

				},

				data: yLineData
			},{
				type: 'line',
				itemStyle: {
					normal: {
						color: function(params) {
							return 'rgb(228,127,253)'
						},
						lineStyle: {
							type: "solid"
						}
					}

				},

				data: yLineLastYearData
			},{
				type: 'bar',
				yAxisIndex: 1,
				symbol: 'none',
				barWidth: 15,
				itemStyle: {
					normal: {
						color: function(params) {
							if(colorList.length > 0){
								if(colorList[params.dataIndex] == 0){
									return 'rgb(251,133,139)'
								}else if(colorList[params.dataIndex] == 1){
									return 'rgb(133,251,188)'
								}
							}
							
						}
					}
				},
				data: yBarData
			}]
		};
		myChartMonth.setOption(option);
	}
	
	
});

Date.prototype.Format = function (fmt) { //author: meizz
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
}
</script>
