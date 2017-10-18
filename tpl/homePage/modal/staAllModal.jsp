<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<div class="col-sm-12 no-padder"  ng-controller="staMonCtrl" >
<div  id="distUserNav">
	<ul class="nav col-sm-12 no-padder nav-top b-b"  >
          <li class="col-sm-12 no-padder text-center h3">
          	<a  data-dismiss="modal">
          		累计发电量分析
          	</a>
           </li>
        </ul>
</div>
<div class="col-sm-12 no-padder">
	<div class="col-sm-5 wrapper-xs points pull-right" >
			<div class="col-sm-4  no-padder text-center">
				<i class="fa fa-circle" style="color: #ffc700"></i> <span
					class="col-9 m-r-xs ">应发电量<small>(kWh)</small></span> 
			</div>
			<div class="col-sm-4 no-padder text-center">
				<span class="pull-right"> <i class="fa fa-circle"
					style="color: #ff9a00"></i> <span class="col-9 ">实发电量(kWh)</span>
				</span>
			</div>
			<div class="col-sm-4 no-padder text-center">
				<span class="pull-right"> <i class="fa fa-circle"
					style="color: #4a8bca"></i> <span class="col-9 ">发电小时数(h)</span>
				</span>
			</div>
	</div>
	<div class="col-sm-12 no-padder ">
		<div class="col-sm-12 no-padder rollDiv">
			<div id="kwhTotalYReport" style="height:260px;"></div>
		</div>
	</div>

</div>
</div>
<script>
	app.controller('staMonCtrl',function($scope, $http, $state,$rootScope) {
		CommonPerson.Base.LoadingPic.PartShow('kwhTotalYReport');
			$scope.getstaDayPowerData=function(nowData){
				$http({
					method : "POST",
					url :"${ctx}/MobileRtmDeviceMonitor/getAccumulateChartGeneratingPower.htm",
					params : {
						'userId':1,
						//'dateString':$scope.mapTimeMonth,
						'powerStationId':$scope.stationListId
					}
					})
					.success(function (msg) {
						partHide('kwhTotalYReport')
						powerAnalyze(msg.echarts_xaxisTime,
								msg.echarts_realGeneratingPower,
								msg.echarts_predictGeneratingPower,
								msg.echarts_generatingPowerHours,$http, $scope)
					}).error(function(msg){
					});
			
			}
			$scope.getstaDayPowerData()
	});
	function powerAnalyze(echarts_xaxisTime,echarts_realGeneratingPower,echarts_predictGeneratingPower,echarts_generatingPowerHours,$http, $scope){
		var myChart = echarts.init(document.getElementById('kwhTotalYReport'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			  	 tooltip : {
			        trigger: 'axis',
			  	 	  formatter: function (params,ticket,callback) {
			            var res ="";
			            for (var i = 0, l = params.length; i < l; i++) {
			            	res += params[i].seriesName+" : "+params[i].value +"<br/>" ;
			            }
			            return res;
			      }, 
			      axisPointer:{
						 type: 'line',
						    lineStyle: {
						        color: '#bbb',
						        width: 1,
						        type: 'solid'
						    }
					 }
			    },
			    grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '60px',
					y : "20px",
					y2 : "30px"
				},
				noDataLoadingOption:{
			        text : '暂无数据',
			        effect :function(params,callback){
			        	return "暂无数据"
			        }
			    },
				calculable : false,
				xAxis : [ {
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
					axisLine : {
						lineStyle : {
							color : '#bbb',
							width : 1
						}
					},
					splitLine : {
						show : false
					},
					data : echarts_xaxisTime
				},{
					type : 'category',
					show : false,
					data : echarts_xaxisTime
				} ],
				yAxis : [{
					type : 'value',
					axisLine : {
						lineStyle : {
							width : 1,
							color : '#bbb'
						}
					},
					axisLabel : {
						axisLabel : 10,
						textStyle : {
							color : '#bbb',
							fontSize : 13
						}
					},
					splitLine : {
						show : false
					}
				},{
					type : 'value',
					axisLine : {
						lineStyle : {
							width : 1,
							color : '#bbb'
						}
					},
					axisLabel : {
						axisLabel : 10,
						textStyle : {
							color : '#bbb',
							fontSize : 13
						}
					},
					splitLine : {
						show : false
					}
				}],
				series : [
				 {
					name : '实发电量' ,
					type : 'bar',
					barWidth :15,
					itemStyle : {
						normal : {
							color : function(params) {
								return '#ff9a00'
							}
						}
					},
					data :echarts_realGeneratingPower
				},{
					name : '应发电量',
					z:1,
					type : 'bar',
					xAxisIndex : 1,
					barWidth :15,
					itemStyle : {
						normal : {
							color : function(params) {
								return '#ffc700'
							}
						}
					},
					data :echarts_predictGeneratingPower
				},{
					barWidth : 15,
					name : '发电小时数',
					type : 'bar',
					xAxisIndex : 1,
					itemStyle : {
						normal : {
							color : function(params) {
								return '#4a8bca'
							}
						}
					},
					data : echarts_generatingPowerHours
				},{
					barWidth : 15,
					yAxisIndex : 1,
					name : '发电小时数',
					yAxisIndex : 1,
					type : 'bar',
					itemStyle : {
						normal : {
							color : function(params) {
								return '#4a8bca'
							}
						}
					},
					data : echarts_generatingPowerHours
				}]
			}
			myChart.setOption(option);
	}
</script>
		
