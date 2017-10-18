<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  class="modal fade" id="inverterModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" ng-controller="inverterVCtrl">
	<div class="modal-dialog row modal-lg" style="width: 990px !important;">
		<div class="modal-content col-sm-12 no-padder n-b-r" style="margin-top:250px;height:357px;">
			<a class="icon-close modelCloseBtn time black-1" ng-click="hiddenModal()"></a>
			<!-- <a class="dailymodelCloseBtn" data-dismiss="modal">
					<img src="theme/images/close.png"/>
			</a> -->
			<span class="invModalRight" id="inRight" ng-click="changeInverDown()">
				<i class="fa fa-angle-right m-t m-l-sm white-1 font-h1"class="m-r-xs"></i>
			</span>
			<span class="invModalLeft"  id="inLeft" ng-click="changeInverUp()">
				<i class="fa fa-angle-left m-t m-l-sm white-1 font-h1"class="m-r-xs"></i>
			</span>
			<div class="modal-body col-sm-12">
				<div class="col-sm-12 no-padder">
					<span class="col-sm-3 no-padder"  >
						<a class="no-padder"> 
							<i class="fa fa-angle-left font-h1" ng-click="dateLeft()" class="m-r-xs"></i>
							<span><span id="changeTimeId1" class="m-l m-r  font-h2" ng-bind="inverTimeDay| date:'yyyy-MM-dd'"></span>
							<i class="fa fa-angle-right font-h1" class="m-r-xs" ng-class="{'black-4':downJt}" ng-click="dateRight()"></i>
						</a>
					</span>
					<span class="black-1 col-sm-6  no-padder font-h3 text-center m-b-xs"><span ng-bind="inverTimeDay| date:'yyyy-MM-dd'"></span>
						<span ng-bind="eqnameTitle"></span>发电效率趋势分析</span>
				</div>
					<!-- 查看设备运行数据 -->
					<div id="inverterV" class="col-sm-12" style="width:950px;height:300px;"></div>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('inverterVCtrl',function($scope, $http, $state, $stateParams) {
	$scope.hiddenModal = function() {
		$('#inverterModal').modal('hide');
	}
	//切换时间
	$scope.inverTimeDay=new Date().getTime();
	$scope.today=new Date().getTime();
	$scope.downJt=($scope.inverTimeDay+1000*60*60*24)==($scope.today+1000*60*60*24)
	$scope.dateLeft=function(){
		
		$scope.inverTimeDay=$scope.inverTimeDay-1000*60*60*24;
		$scope.downJt=($scope.inverTimeDay+1000*60*60*24)==($scope.today+1000*60*60*24)
		getInverterAnalyze($http, $scope,$scope.eqid,$scope.stid);
	}
	$scope.dateRight=function(){
		if($scope.inverTimeDay==$scope.today){
			return false
		}
		$scope.inverTimeDay=$scope.inverTimeDay+1000*60*60*24;
		$scope.downJt=($scope.inverTimeDay+1000*60*60*24)==($scope.today+1000*60*60*24)
		getInverterAnalyze($http, $scope,$scope.eqid,$scope.stid);
	}
	//获得逆变器的详情统计图
	$scope.inverId=$scope.eqid;
	getInverterAnalyze($http, $scope,$scope.eqid,$scope.stid);
	//切换上一个电站
	$scope.changeInverUp=function(){
		if(($scope.eqIndex-1)<1){
			$("#inLeft").addClass("chartActive")
			return false;
		}else{
			//得到table 的下标，并将下标标识减去1
			getInverterAnalyze($http, $scope,$scope.inverterList[$scope.eqIndex-1].eqid,$scope.inverterList[$scope.eqIndex-1].stid);
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
//得到点击的逆变器的统计图
function getInverterAnalyze($http, $scope,inverId,stid) {
	$http.get(
			"${ctx}/Report/getInvCurveDataForDay.htm",
			{
				params : {
					stid:stid,
					eqid :inverId,
					dtime:new Date($scope.inverTimeDay).Format("yyyy-MM-dd")
				}
			}).success(function(response) {
				$("#inverterV").removeClass("hidden")
				inverterV(response,$http, $scope);
			}).error(function(response) {
				$("#inverterV").addClass("hidden")
			});
}
function inverterV(powerVstr,$http, $scope) {
		var myChart = echarts.init(document.getElementById('inverterV'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			tooltip : {
				 trigger: 'axis',
				 axisPointer:{
					 type: 'line',
					    lineStyle: {
					        color: '#bbb',
					        width: 1,
					        type: 'solid'
					    }
				 },
				 formatter: function (params,ticket,callback) {
			            var res = params[0].name;
			            for (var i = 0, l = params.length; i < l; i++) {
			            	if(params[i].value!=""&&!isNaN(params[i].value)){
			                	res += '<br/>' + params[i].seriesName + ' : ' + params[i].value;
			                	if(i==0){
			                		res += "W/㎡";
			                	}else if(i==3){
			                		res += "%";
			                	}else{
			                		res += "kW";
			                	}
			            	} else if(params[i].value==""){
			                	res += '<br/>' + params[i].seriesName + ' : N/A';
			            	}
			            }
			            return res;
			      }
		    },
			legend : {
				x : 'right',
				orient : 'horizontal',
				data : [ '光照强度', '实时功率','应发功率']

			},
			calculable : false,
			grid : {
				borderWidth : '0px',
				x : '40px',
				x2 : '30px',
				y : "50px",
				y2 : "20px"
			},
			xAxis : [ {
				axisTick : {
					show : false
				},
				axisLabel : {
					interval:59,
					textStyle : {
						color : '#bbb',
						fontSize : 12
					},
					formatter : function(v) {
						var arr = v.split(" ");
						return arr[1];
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
				data : powerVstr.echarts_xaxisTime
			} ],
			yAxis : [ {
				axisLabel : {
					textStyle : {
						color : '#bbb',
						fontSize : 12
					}
				},
				name : "kW",
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
				type : 'value'
			}, {
				name : "W/㎡",
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
			/* #e74c3c */
			series : [ {
				name : '光照强度',
				type : 'line',
				z : 3,
				yAxisIndex : 1,
				itemStyle : {
					normal : {
						color : '#f0ad4e',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : '#f0ad4e',
							width : 2
						}
					}
				},
				symbol : 'none',
				data : powerVstr.echarts_luminousIntensity
			}, {
				symbol : 'none',
				name : '实时功率',
				type : 'line',
				
				z : 2,
				itemStyle : {
					normal : {
						color : 'rgb(217, 83, 79)',
						areaStyle : {
							color : 'rgba(217, 83, 79,.8)'
						},
						lineStyle : {
						/* 	type : 'none',
							width:2, */
							color : 'rgba(217, 83, 79,.9)',
							width : 1
						}
					}
				},
				data : powerVstr.echarts_powers[0].power
			}, {
				symbol : 'none',
				name : '应发功率',
				type : 'line',
				
				z : 1,
				itemStyle : {
					normal : {
						color : 'rgb(66,139,202)',
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
						/* 	type : 'none',
							width:2, */
							color : 'rgba(66,139,202,.9)',
							width : 2
						}
					}
				},
				data : powerVstr.echarts_powers[0].shdpower
			} ]
		};
		myChart.setOption(option);
	}

</script>

</script>
