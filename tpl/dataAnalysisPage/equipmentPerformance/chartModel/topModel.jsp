<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="equipTopModelChartCtrl">
	<div class="pull-right">
		<span class="m-t-xs no-padder text-center">
				<span class="col-9 m-r-xs text-1-1x"><small></small></span> 
			</span>
	</div>
	<div id="equipTopChart" style="height:250px;"></div>
</div>

<script>
app.controller('equipTopModelChartCtrl',function($scope, $http, $state, $stateParams) {
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtimeModel = rightDay.Format("yyyy-MM");
	$scope.dataTypeModel = "month";
	
	$scope.$on('broadChangeDateToChildEP', function(event, data) {
		if(data){
			$scope.dataTypeModel = data.dataType;
			$scope.dtimeModel =data.dtime;
			$scope.topModelData();
		}else{
			$scope.topModelData();
		}
	});
	
	//各设备类型数据获取，并传值
	$scope.topModelData = function(){
		var data;
		switch($scope.dataTypeModel){
			case "month" :
				$http.get("./BDDevicePerform/getStationsListMonthPerformMonth.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy-MM")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "year" :
				$http.get("./BDDevicePerform/getStationsListYearPerformYear.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "total" :
				$http.get("./BDDevicePerform/getStationsListCumulativePerformCumulative.htm",{
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
		}
		
	}
	var axesArrMaxMin = {};
	function parseData(data){
		axesArrMaxMin = {};
		if(data && data.chartList){
			var date = [];//日期
			var stationRation = [];//电站离散率
			var axesArr = [];
			for(var i = 0;i<data.chartList.length;i++){
				date.push(data.chartList[i].date);
				var maxv=0,minv=0;
				if(data.chartList[i].invtRations){
					for(var k = 0;k<data.chartList[i].invtRations.length;k++){
						if(k == 0 ){
							maxv = data.chartList[i].invtRations[k];
							minv = data.chartList[i].invtRations[k];
						}else{
							if(data.chartList[i].invtRations[k] > maxv){
								maxv = data.chartList[i].invtRations[k];
							}
							if(data.chartList[i].invtRations[k] < minv){
								minv = data.chartList[i].invtRations[k];
							}
						}
						axesArr.push([i,data.chartList[i].invtRations[k]]);
						//axesArr.push(data.chartList[j].invtRations[k]);
						axesArrMaxMin[data.chartList[i].date+""] = [maxv,minv];
					}
				}else{
					axesArr.push([i,""]);
				}
				
				stationRation.push(data.chartList[i].stationRation);
			}
			 drawChart(axesArr,stationRation,date);
		}else{
			drawChart([],[]);
		}
	}
	
	$scope.topModelData();
	
	function sortNum(array){
		var i = 0,
	    len = array.length,
	    j, d;
	    for (; i < len; i++) {
	        for (j = 0; j < len; j++) {
	            if (array[i] < array[j]) {
	                d = array[j];
	                array[j] = array[i];
	                array[i] = d;
	            }
	        }
	    }
	    return array;
	}
	function drawChart(date,stationRation,aaa){
		var myChart = echarts.init(document.getElementById('equipTopChart'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
				tooltip : {
					//trigger : 'item',
					trigger : 'axis',
					axisPointer : {
						type : 'line',
						lineStyle : {
							color : '#bbb',
							width : 1,
							type : 'solid'
						}
					},
					formatter: function (params,ticket,callback) {
						if(params){
							var yaxes = params[0].name;
				            var res = yaxes;
							for(var j=0;j<params.length;j++){
								if(params[j].seriesIndex == 0){
									res += '<br/>逆变器功率离散率：'
									if(axesArrMaxMin[params[j].name]){
										res += '<br/>最大值：' + axesArrMaxMin[params[j].name][0];
										res += '<br/>最小值：' + axesArrMaxMin[params[j].name][1];
									}
								}else if(params[j].seriesIndex == 1){
									if(params[j] && params[j].value){
							            res += '<br/>电站离散率：'+ params[j].value.toFixed(2);
						            }else{
						            	 res += '<br/>电站离散率：';
						            }
								}
							}
						}
			            return res;
				     }
			    },
			    grid : {
					borderWidth : '0px',
					x : '60px',
					x2 : '30px',
					y : "50px",
					y2 : "50px"
				},
				legend : {
					data :['逆变器功率离散率','电站平均离散率'],
					right : 5
				},
				calculable : false,
				xAxis : [ {
					type : 'category',
					scale : true,
					axisTick : {
						show : false
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					axisLabel : {
						textStyle : {
							align : 'center',
							color : 'rgba(187,187,187,0.9)',
							fontSize : 13
						}
					},
					splitLine : {
						show : false,
					},
					data : aaa
				} ],
				yAxis : [{
					name:'%',
					type : 'value',
					scale : true,
					axisLabel : {
						margin:20,
						textStyle : {
							color : 'rgba(187,187,187,0.9)',
							fontSize : 12
						}
					},
					
					font : {
						color : '#666'
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					splitLine : {
						show : false,
					} 
					
				}],
				series : [
					 {
							type : 'scatter',
							symbolSize:5,
							data : date,
							name : '逆变器功率离散率'
					},{
						type : 'line',
						name : '电站平均离散率',
						itemStyle : {
							normal : {
								areaStyle : {
									color : 'transparent'
								},
								lineStyle : {
									color : 'rgb(245,102,105)',
									width : 1
								}
							}
						},	
						data : stationRation
				}]
			}
			myChart.setOption(option);
	}
});

</script>
