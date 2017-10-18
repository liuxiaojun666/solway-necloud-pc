<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 no-padder m-n divshadow" ng-controller="analyBarCtrl" >
	<div class="col-sm-9 no-padder">
		<!-- 发电量分析开始 -->
		<div ng-include="'${ctx}/tpl/reportPage/monthly/powerEffic.jsp'"></div>
		<!-- 发电量分析结束 -->
	</div>
	<div class="col-sm-3" style="padding:0px 0px 0px 15px;">
		<div class="col-sm-12 panel panel-default no-padder" style="height: 340px;">
			<div class="panel-heading">
				<span class="font-h4 black-1">运维报告</span>
				<span class="pull-right ledgerCon m-t-xs">
					<span id="analBar0" ng-click="changeAnalBar('0')" class="active" style="padding: 8px 15px;">
							日报
					</span>
					<span id="analBar1" ng-click="changeAnalBar('1')" class="" style="padding: 8px 15px;">
						月报
					</span>
				</span>
			</div>
			<div class="col-sm-12" >
				<div ng-repeat="anal in analData">
					<div class="col-sm-12 wrapper-sm-md  a-cur-poi b-b" ng-class="{'data-orange':{{$index}}=='0'}"
					ng-click="goEffi(anal.dataFlag)">
						<span ng-bind="anal.data| date:'yyyy-MM-dd'" ></span>运维报告
						<span ng-bind="anal.titleData| date:'yyyy-MM-dd'" class="pull-right"></span>
					</div>
				</div>

				<div class="col-sm-12 wrapper-sm-md">
					<span class="pull-right green a-cur-poi" ng-click="goEffi()">查看更多 ></span>
				</div>

			</div>
		</div>
	</div>
</div>
<script>
app.controller('analyBarCtrl',function($scope, $http, $state, $stateParams) {
		$scope.ledGerConData=0
		$scope.refreshViewDataForHead = function () {

			$scope.getTargetData();
    	}
    	$scope.$on("refreshViewDataForHead", $scope.refreshViewDataForHead);

		$scope.getTargetData=function(){
			//当前时间
			 $http.get(
						"${ctx}/Report/getStationBaseDataForMonth.htm",{
							params : {
								stid:$scope.stid,
								month:$scope.mapTimeMonth.substring(0,7)
							}
						})
						.success(function(result) {
							$scope.targetData=result.data
							getRealKwh(46)
						}).error(function(response) {
			});
		}
		$scope.getTargetData();
		//改变状态
		 $scope.changeAnalBar=function(ledGerConData){
			//改变日和月的选中状态
			$scope.ledGerConData=ledGerConData
			$("#analBar"+ledGerConData).siblings().removeClass("active")
			$("#analBar"+ledGerConData).addClass("active")
			$scope.mapTimeDay=new Date().getTime();
			var oneDay=1000*60*60*24

			if(ledGerConData=="0"){//日
				$scope.analData=
						[
						 {"data":FormatDate($scope.mapTimeDay-oneDay),
						  "dataFlag":$scope.mapTimeDay-oneDay,
						  "titleData":$scope.mapTimeDay-oneDay},
						 {"data":FormatDate($scope.mapTimeDay-2*oneDay),
								  "dataFlag":$scope.mapTimeDay-2*oneDay,
								  "titleData":$scope.mapTimeDay-2*oneDay},
						 {"data":FormatDate($scope.mapTimeDay-3*oneDay),
									  "dataFlag":$scope.mapTimeDay-3*oneDay,
									  "titleData":$scope.mapTimeDay-3*oneDay},
						 {"data":FormatDate($scope.mapTimeDay-4*oneDay),
										  "dataFlag":$scope.mapTimeDay-4*oneDay,
										  "titleData":$scope.mapTimeDay-4*oneDay},
						  {"data":FormatDate($scope.mapTimeDay-5*oneDay),
							  "dataFlag":$scope.mapTimeDay-5*oneDay,
							  "titleData":$scope.mapTimeDay-5*oneDay}
						]

			}else if(ledGerConData=="1"){//月
				$scope.mapTimeMonth1=new Date().getMonth()+1//获得当前月份，用来计算
				$scope.mapTimeMonth_1=new Date().getMonth()+1//获得当前月份，用来标注当前日期
				//用来传参用(统一界面用同样的字段)
				if($scope.mapTimeMonth1 < 10){
					$scope.mapTimeMonth=new Date().getFullYear()+'-0'+$scope.mapTimeMonth1;
				}else{
					$scope.mapTimeMonth=new Date().getFullYear()+'-'+$scope.mapTimeMonth1;
				}

				$scope.analData=[
					{
					 	"data":$scope.changeDataFormat($scope.mapTimeMonth1),
						"dataFlag":$scope.mapTimeMonthY+","+$scope.mapTimeMonth1,
					  	"titleData":$scope.changeDataFormat($scope.mapTimeMonth1)
					},
					{	"data":$scope.changeDataFormat($scope.mapTimeMonth1-1),
						"dataFlag":$scope.mapTimeMonthY+","+$scope.mapTimeMonth1,
						"titleData":$scope.changeDataFormat($scope.mapTimeMonth1)
					},
					{
						"data":$scope.changeDataFormat($scope.mapTimeMonth1-1),
						"dataFlag":$scope.mapTimeMonthY+","+$scope.mapTimeMonth1,
						"titleData":$scope.changeDataFormat($scope.mapTimeMonth1)
					},
					{
						"data":$scope.changeDataFormat($scope.mapTimeMonth1-1),
						"dataFlag":$scope.mapTimeMonthY+","+$scope.mapTimeMonth1,
						"titleData":$scope.changeDataFormat($scope.mapTimeMonth1)
					},
					{
						"data":$scope.changeDataFormat($scope.mapTimeMonth1-1),
						"dataFlag":$scope.mapTimeMonthY+","+$scope.mapTimeMonth1,
						"titleData":$scope.changeDataFormat($scope.mapTimeMonth1)
					}
				]
			}
		}

			$scope.mapTimeMonth1=new Date().getMonth()+1//获得当前月份，用来计算
			$scope.mapTimeMonth_1=new Date().getMonth()+1//获得当前月份，用来标注当前日期

			//用来传参用(统一界面用同样的字段)
			if($scope.mapTimeMonth1 < 10){
				$scope.mapTimeMonth=new Date().getFullYear()+'-0'+$scope.mapTimeMonth1;
			}else{
				$scope.mapTimeMonth=new Date().getFullYear()+'-'+$scope.mapTimeMonth1;
			}

			//用来转化格式(界面美化需要)
			$scope.mapTimeMonthNow=new Date().getFullYear()+'年'+$scope.mapTimeMonth1+"月";

			//获得当前月份，用来计算
			$scope.mapTimeMonthY=new Date().getFullYear();

			//根据毫秒数格式化日期格式
			$scope.changeDataFormat=function(mapTimeMonth){
					if(mapTimeMonth<=0){
						mapTimeMonth=mapTimeMonth+12
						$scope.mapTimeMonthY=$scope.mapTimeMonthY-1
						$scope.mapTimeMonth1=12
					}else{
						mapTimeMonth=mapTimeMonth;
					}
					$scope.mapTimeMonth1=mapTimeMonth;
					return $scope.mapTimeMonthY+'年'+mapTimeMonth+"月";

			}
			 $scope.changeAnalBar($scope.ledGerConData);

			 //从当前界面跳转到选中状态下的其他时间
			 $scope.goEffi=function(analData){
				  if($scope.ledGerConData=='0'){
					 $state.go("app.daily", {
						 analData :analData,
						 stid: $scope.stid
						});
				 }else{
					 if(analData){
						 var anal=analData.split(',')
						 analData=$scope.mapTimeMonthYStatement+"-"+$scope.mapTimeMonthStatement
						 $state.go("app.monthly", {
							 analData :anal[0],
							 analMon:anal[1],
							 stid: $scope.stid
						 });
					 }else{
						 $state.go("app.monthly", {
						 	stid: $scope.stid
						 });
					 }
					
				 }
			 }
	});
function FormatDate (strTime) {
    var date = new Date(strTime);
    return date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日";
}
//发电量
function getRealKwh(pba){
	var myChart = echarts.init(document.getElementById('realKwh'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#56c6c7",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
						fontSize : '13',
						color : '#333',
						baseline : 'top'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		            formatter : function (params){
		                return 100 - params.value + '%'
		            },
		            textStyle: {
		            	fontSize : '22',
						color : '#56c6c7',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center',
		            textStyle: {
		                baseline : 'bottom'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
		};
		var radius = [90, 100];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-pba, itemStyle : labelBottom},
		                {name:'PBA', value:pba,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
</script>
