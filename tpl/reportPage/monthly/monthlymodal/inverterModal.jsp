<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  class="modal fade" id="inverterModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" ng-controller="inverterVCtrl">
	<div class="modal-dialog row modal-lg">
		<div class="modal-content col-sm-12 no-padder n-b-r" style="margin-top:250px;">
			<a class="dailymodelCloseBtn" data-dismiss="modal">
					<img src="theme/images/close.png"/>
			</a>
			<div class="modal-body col-sm-12">
				<div class="col-sm-12 no-padder">
					<span class="col-sm-3 no-padder">
						<a class="no-padder"> 
							<i class="fa fa-angle-left font-h1"class="m-r-xs"ng-click="dateLeft()"></i>
							<span><span id="changeTimeIdModal" class="m-l m-r  font-h2" ng-bind="inverTimeDay| date:'yyyy-MM-dd'"></span>
							<i class="fa fa-angle-right font-h1" class="m-r-xs" ng-class="{'black-4':downJt}" ng-click="dateRight()"></i>
						</a>
					</span>
					<span class="black-1 col-sm-6  no-padder font-h3 text-center m-b-xs">逆变器A-01发电效率趋势分析</span>
				</div>
					<span class="invModalLeft" id="inLeft" ng-click="changeInverUp()">
						<i class="fa fa-angle-left m-t m-l-sm white-1 font-h1"class="m-r-xs"></i>
					</span>
					<!-- 查看设备运行数据 -->
					<div id="inverterV" class="col-sm-12" style="width:860px;height:300px;"></div>
					<span class="invModalRight"  id="inRight" ng-click="changeInverDown()">
						<i class="fa fa-angle-right m-t m-l-sm white-1 font-h1"class="m-r-xs"></i>
					</span>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('inverterVCtrl',function($scope, $http, $state, $stateParams) {
	//切换时间
	$scope.inverTimeDay=new Date().getTime();
	$scope.today=new Date().getTime();
	$scope.downJt=($scope.inverTimeDay+1000*60*60*24)==($scope.today+1000*60*60*24)
	$scope.dateLeft=function(){
		
		$scope.inverTimeDay=$scope.inverTimeDay-1000*60*60*24;
		$scope.downJt=($scope.inverTimeDay+1000*60*60*24)==($scope.today+1000*60*60*24)
	}
	$scope.dateRight=function(){
		if($scope.inverTimeDay==$scope.today){
			return false
		}
		$scope.inverTimeDay=$scope.inverTimeDay+1000*60*60*24;
		$scope.downJt=($scope.inverTimeDay+1000*60*60*24)==($scope.today+1000*60*60*24)
	}
	//获得逆变器的详情统计图
	$scope.inverId=1
	getInverterAnalyze($http, $scope,$scope.inverId,$scope.stid);
	
	//切换上一个电站
	$scope.changeInverUp=function(){
		if(($scope.eqIndex-1)<1){
			$("#inLeft").addClass("chartActive")
			return false;
		}else{
			//得到table 的下标，并将下标标识减去1
			getInverterAnalyze($http, $scope,$scope.inverterList[$scope.eqIndex-1].eqid,$scope,$scope.inverterList[$scope.eqIndex-1].stid);
			$scope.eqIndex=$scope.eqIndex-1;
		}	
	}
	//切换下一个电站
	$scope.changeInverDown=function(){
		if(($scope.eqIndex+1)>=$scope.inverterList.length){
			$("#inRight").addClass("chartActive")
			return false;
		}else{
			//得到table 的下标，并将下标标识减去1
			getInverterAnalyze($http, $scope,$scope.inverterList[$scope.eqIndex+1].eqid,$scope.inverterList[$scope.eqIndex+1].stid);
			$scope.eqIndex=$scope.eqIndex+1;
		}	
	}
});
function getInverterAnalyze($http,$scope,inverId,stid) {
	console.log(inverId)
	console.log(stid)
	console.log(new Date($scope.inverTimeDay).Format("yyyy-MM-dd"))
	$http.get(
			"${ctx}/Report/getStationInvPowerDataForMonth.htm",
			{
				params : {
					stid:stid,
					eqid:inverId,
					month:new Date($scope.inverTimeDay).Format("yyyy-MM-dd")
				}
			}).success(function(response) {
				inverterV(response,$http, $scope);
			}).error(function(response) {

			});
}
function inverterV(powerVstr,$http, $scope) {
	
		var myChart = echarts.init(document.getElementById('inverterV'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
				color:['#B5C334','#999'],
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
			    legend: {
			        data:['本期','去年同期'],
			        x:"right"
			    },
			    grid : {
					borderWidth : '0px',
					x : '40px',
					x2 : '30px',
					y : "50px",
					y2 : "20px"
				},
			    calculable : false,
			    xAxis : [
			        {
			        	 type : 'category',
			        	 axisTick : {
								show : false
							},
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
			            data :powerVstr.day
			        }
			    ],
			    yAxis : [
						{	name:"(%)",
						    axisLabel : {
								interval:59,
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
			            type:'line',
			            data:powerVstr.current_tran_r
			            
			        },
			        {
			            name:'去年同期',
			            type:'line',
			            data:powerVstr.same_tran_r
			           
			        }
			    ]
			};
			                    
		myChart.setOption(option);
			
}

</script>

</script>
