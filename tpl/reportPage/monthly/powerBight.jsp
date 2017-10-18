<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="panel wrapper col-sm-12 m-n " ng-controller="powerBightCtrl">
	<div class="col-sm-12 b-b" style="padding: 0px 0px 7px 0px;">
		<span class="font-h4 black-1 col-sm-6 no-padder" >故障情况</span>
	</div>
	<div class="hbox hbox-auto-xs" >
		<div class="col w-xxs" style="width: 65px">
			<div class="vbox flatBarUl">
				<p id="data1" ng-click="changeData('1')">故障台次</p>
				<p id="data2" ng-click="changeData('2')"class="active">故障小时</p>
				<p id="data3" ng-click="changeData('3')">损失电量</p>
				<p id="data4" ng-click="changeData('4')">MTTR</p>
				<p id="data5" ng-click="changeData('5')">MTBF</p>
			</div>
		</div>
		<div class="col" style="padding:20px 0px;">
			<div class="vbox">
				<div class="col-sm-8">
					<div id="faultBar" style="height:270px;"></div>
				</div>
				<div class="col-sm-4">
					<div class="ledgerCon col-sm-12 no-padder m-t-n-xxl">
						<span id="ledgerCon0" ng-click="changeLedGerCon('0')" class="col-sm-3 active">
							全部
						</span>
						<span id="ledgerCon1" ng-click="changeLedGerCon('3')" class="col-sm-3">
							箱变
						</span>
						<span id="ledgerCon2" ng-click="changeLedGerCon('2')" class="col-sm-3">
							逆变器
						</span>
						<span id="ledgerCon3" ng-click="changeLedGerCon('1')" class="col-sm-3">
							汇流箱
						</span>
					</div>
					<div id="faultPie" class="col-sm-12 no-padder" style="height:270px;"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('powerBightCtrl',function($scope, $http, $state, $stateParams) {
	$scope.changeData1="损失小时"
	$scope.changeLedGerCon="全部"
	$scope.ledGerConData="0";//类型
	$scope.faultBar;//柱状图的数据

	$scope.current; //本期
	$scope.last; //同期
	$scope.same; //上期

	$scope.$on('monthlyRefresh', function(event, data) {
		if(data[0]){
			$scope.mapTimeMonth=data[1]
			$scope.getPowerData();
		};
	});
	$scope.$on('refreshViewDataForHead', function(event, data) {
		$scope.getPowerData();
	});
	$scope.getPowerData=function(){
		$http.get(
				"${ctx}/Report/getStationFaultDataForMonth.htm",{
					params : {
						stid:$scope.stid,
						month:$scope.mapTimeMonth,
						type:$scope.ledGerConData
					}
				})
				.success(function(result) {
				//环形图
				getFaultPie(result)
				//故障台次
				$scope.faultBar=result
				$scope.changeData('2');//遍历条件
			}).error(function(response) {
		});
	}
	$scope.getPowerData();
	//柱状图改变状态，根据传回来的json 值 重新组织数据
	$scope.changeData=function(data){
		$("#data"+data).addClass("active")
		$("#data"+data).siblings().removeClass("active")
		if(data=="1"){
			$scope.changeData1="故障台次"

			$scope.current=$scope.faultBar.current_fault_count
			$scope.last=$scope.faultBar.last_fault_count
			$scope.same=$scope.faultBar.same_fault_count
		}else if(data=="2"){
			$scope.changeData1="损失小时"

			$scope.current=$scope.faultBar.current_fault_hours
			$scope.last=$scope.faultBar.last_fault_hours
			$scope.same=$scope.faultBar.same_fault_hours
		}else if(data=="3"){
			$scope.changeData1="损失电量"
			$scope.current=$scope.faultBar.current_fault_kwh
			$scope.last=$scope.faultBar.last_fault_kwh
			$scope.same=$scope.faultBar.same_fault_kwh
		}else if(data=="4"){
			$scope.changeData1="MTTR"
			$scope.current=$scope.faultBar.current_fault_mttr
			$scope.last=$scope.faultBar.last_fault_mttr
			$scope.same=$scope.faultBar.same_fault_mttr
		}else if(data=="5"){
			$scope.changeData1="MTBF"
			$scope.current=$scope.faultBar.current_fault_mtbf
			$scope.last=$scope.faultBar.last_fault_mtbf
			$scope.same=$scope.faultBar.same_fault_mtbf
		}
			getFaultBar($scope.faultBar.f,$scope.current,$scope.last,$scope.same);
	}

	$scope.changeLedGerCon=function(ledGerConData){
		$scope.ledGerConData=ledGerConData
		$("#ledgerCon"+ledGerConData).addClass("active")
		$("#ledgerCon"+ledGerConData).siblings().removeClass("active")
		$scope.getPowerData()
	}
});

function getFaultBar(f,current,last,same){
	console.log(current)
	var myChart = echarts.init(document.getElementById('faultBar'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	option = {
			color:['#e77467','#8fccdb','#b4a3de'],
			tooltip : {
				trigger: 'axis',
				axisPointer:{
					 type: 'line',
						lineStyle: {
							color: '#bbb',
							width: 1,
							type: 'solid'
						}
				 }
			},
			noDataLoadingOption:{
		        text : '暂无数据',
		        effect :function(params,callback){
		        	return "暂无数据"
		        }
		    },
			legend: {
				x:"right",
				data:['本期','同期','上期']
			},
			calculable : false,
			grid : {
				borderWidth : '0px',
				x : '40px',
				x2 : '40px',
				y : "50px",
				y2 : "30px"
			},
			xAxis : [
				{
					axisTick : {
						show : false
					},
					type : 'category',
					axisLabel : {
						textStyle : {
							color : '#bbb',
							fontSize : 12
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
					data : f
				}
			],

			yAxis : [
				{
					axisLabel : {
						textStyle : {
							color : '#bbb',
							fontSize : 12
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
					type : 'value'
				}
			],
			series : [
				{
					name:'本期',
					type:'bar',
					data:current
				},
				{
					name:'上期',
					type:'bar',
					data:last
				},
				{
					name:'同期',
					type:'bar',
					data:same
				}
			]
		};

	myChart.setOption(option);
}

function getFaultPie(wereData){
	var myChart = echarts.init(document.getElementById('faultPie'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	option = {
	color:['#c0504d','#ebc132','#999999'],
	 title: {
			text: '故障台次',
			x: 'center',
			y: 'center',
			itemGap: 20,
			textStyle : {
				color : '#333',
				fontSize : 16
			}
		},
   tooltip : {
	   show:false
	},
 calculable : false,
	series : [
		{
			name:'故障台次',
			type:'pie',
			radius : [50, 100],
			selectedMode:false,
			clickable:false,
			// for funnel
			x: '60%',
			width: '35%',
			funnelAlign: 'left',
			max: 1048,

			itemStyle : {
				normal : {
					label : {
						position : 'inner'
					},
					labelLine : {
						show : false
					}
				},emphasis:{
					 label : {
						 show : true,
						 formatter : "{b}\n{d}%"
					 }
				}
			},
			data:[
				{value:wereData.fault_r, name:'故障'+wereData.fault_r+"%"},
				{value:wereData.alarm_r, name:'报警'+wereData.alarm_r+"%"},
				{value:wereData.comloss_r, name:'中断'+wereData.comloss_r+"%"}
			]
		}
	]
};


	myChart.setOption(option);
}
</script>
