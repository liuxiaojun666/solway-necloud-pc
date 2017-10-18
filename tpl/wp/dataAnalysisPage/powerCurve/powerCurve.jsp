<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/css/wp/dataAnalysisPage/powerCurve.css">
<div  ng-controller="powerCurveCtrl">
	<div class="hbox " >
		<div class="col">
			<div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
				<div class="col-sm-12 overview-title" >
					<div class="clearfix">
						<div class="pull-left">
							<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
							<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
						</div>
						<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/model/analyChangeDate.jsp'"></div>
					</div>
				</div>
			</div>
            <div  style="margin:20px;overflow: auto;background:white;" >
               <div class="clearfix" style="width: 300px;margin: 0 auto;">
               		<div class="pull-left" style="margin-right:50px;">
               			<span>风场</span>
               			<select class="dimention">
               				<option value="">风场</option>
               			</select>
               		</div>
               		<div class="pull-right">
               			<span>风机</span>
               			<select class="dimention" ng-change="changeFans()" ng-model="fanId">
							<option value="all">全部风机</option>
							<option ng-repeat="item in fans" value="{{item.eqid}}">{{item.name}}</option>
						</select>
               		</div>
               </div>
               <div id="powerCurve" style="height:400px;"></div>
            </div>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script>
app.controller('powerCurveCtrl',function($scope, $http, $state, $stateParams) {
	$scope.getCurrentDataName('02',0);
	
	var myChart = echarts.init(document.getElementById('powerCurve'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		init();
    });
	$scope.$on("emitChangeDate",function(e,data){
		$scope.dataType = data.dataType;
		$scope.dtime = data.dtime;
		init();
	});
	
	//初始化
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	$scope.fanId = "all";
	var dtime ,dateType;
	$scope.eqid = "";
	$scope.initOption = false;//判断图表是否初始化了option的标志
	init();
	getFansData();
	
	//判断是否初始化了option
	function ifInitOption(x,y){
		if($scope.initOption){
			reDrawChart(x,y);
		}else{
			initOption(x,y);
			$scope.initOption = true;
		}
	}
	function init(){
		switch($scope.dataType){
			case "day" :dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
						dateType = 'd'
				break;
			case "month" : dtime = new Date($scope.dtime).Format("yyyy-MM");
							dateType = 'm'
				break;
			case "year" : dtime = new Date($scope.dtime).Format("yyyy");
							dateType = 'y'
				break;
			case "total" :dtime = '';
						dateType = 'a'
				break;
			default:
				dtime = new Date($scope.dtime).Format("yyyy-MM");
		}
		initData();
	}
	//获取所有风机数据
	function getFansData(){
		$http.get("./WPDevicePerform/getStationDevicePerformWind.htm")
		.success(function(msg) {
			$scope.fans = msg.windList;
		}).error(function(response) {
		});
	}
	
	//切换风机
	$scope.changeFans = function(){
		var fanId = $scope.fanId;
		if(fanId == "all"){
			$scope.eqid = "";
		}else{
			$scope.eqid = fanId;
		}
		initData();
	}
	
	function initData(){
        $http({
   			method : "POST",
   			url : "./WPPowerLine/getStationPowerLine.htm",
   			params : {
   				'dtime':dtime,
   				'model':dateType,
   				'eqid':$scope.eqid
   			}
   		})
   		.success(function (msg) {
   			console.log(msg);
   			if(msg.wtList){
   				ifInitOption(msg.wtList.ws,msg.wtList.kw);
   			}else{
   			}
   		}).error(function(msg){
   		});          
	}
	//重绘图表
	function reDrawChart(x,y){
		var opt = myChart.getOption();//取不到？？？？why
		//var opt = option;//暂代(有问题)
		opt.xAxis[0].data = x;
		opt.series[0].data = y;
		myChart.setOption(opt); 
	}
	//初始化option
	function initOption(x,y){
		option = {
			tooltip: {
				
			},
			grid: {
				borderWidth: '0px',
				x: '40px',
				x2: '40px',
				y: "55px",
				y2: "30px"
			},
			noDataLoadingOption: {
                text: '暂无数据',
                effect: 'bubble',
                effectOption: {
                    effect: {
                        n: 0
                    }
                }
			},
			xAxis: [{
	            type : 'category',
				data:x
			}],
			yAxis: [{
				type : 'value'
			}],
			series: [{
				type:'line',
				data:y
			}]
		};
		myChart.setOption(option);   
	}
});
</script>
