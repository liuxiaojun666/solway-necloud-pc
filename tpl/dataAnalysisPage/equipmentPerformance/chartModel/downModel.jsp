<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="equipDownModelChartCtrl">
	<div class="pull-right">
		<span class="m-t-xs no-padder text-center">
				<span class="col-9 m-r-xs text-1-1x"><small></small></span> 
			</span>
	</div>
	<div id="equipDownChart" style="height:250px;"></div>
</div>

<script>
app.controller('equipDownModelChartCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('downChild', function(event, data) {
		
	});
	
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
				$http.get("./BDDevicePerform/getStationsListMonthStrandMonth.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy-MM")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "year" :
				$http.get("./BDDevicePerform/getStationsListYearStrandYear.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "total" :
				$http.get("./BDDevicePerform/getStationsListCumulativeStrandCumulative.htm",{
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
		}
		
	}
	function parseData(data){
		if(data && data.chartList){
			var date = [];//日期
			var strandFault = [];//串故障次数
			var strandTired = [];//串受累次数
			for(var i = 0;i<data.chartList.length;i++){
				date.push(data.chartList[i].date);
				if(data.chartList[i].strandFault == null){
					strandFault.push(0);
				}else{
					strandFault.push(data.chartList[i].strandFault);
				}
				
				if(data.chartList[i].strandTired == null){
					strandTired.push(0);
				}else{
					strandTired.push(data.chartList[i].strandTired);
				}
				
			}
			
			var newDate = [];
			for(var i = 0;i<date.length;i++){
				newDate.push(Number(date[i]));
			}
			drawChart(date,strandFault,strandTired);
		}else{
			drawChart([],[],[]);
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
	function drawChart(date,strandFault,strandTired){
		var myChart = echarts.init(document.getElementById('equipDownChart'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
				tooltip : {
					trigger : 'axis',
					axisPointer : {
						type : 'line',
						lineStyle : {
							color : '#bbb',
							width : 1,
							type : 'solid'
						}
					},
					 /**formatter: function (params,ticket,callback) {
						 	var res = params[0].name;
				           	for (var i = 0, l = params.length; i < l; i++) {
				           		res += '<br/>' + params[i].seriesName + ' : ' +params[i].value+"次";			
				           	}
				            res += '<br/>'
				            return res;
				      }*/
			    },
				grid : {
					borderWidth : '0px',
					x : '70px',
					x2 : '30px',
					y : "30px",
					y2 : "30px"
				},
				legend : {
					data :['串均故障次数','串均受累次数'],
					right : 5
				},
				xAxis : [ {
					font : {
						color : '#fff'
					},
					type : 'category',
					 axisTick : {
							show : false
						},
					axisLabel : {
						textStyle : {
							align : 'center',
							color : 'rgba(187,187,187,0.9)',
							fontSize : 13
						}
					},
					axisLine : {
						lineStyle : {
							color : 'rgba(187,187,187,0.9)',
							width : 1
						}
					},
					splitLine : {
						show : false
					},
					boundaryGap : true,
					data : date
				} ],
				yAxis : [{
					name:'次',
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
						show : true,
						lineStyle : {
							color : 'rgba(187,187,187,0.4)',
							width : 1,
							type:'dashed'
						}
					},
					type : 'value'
				}],
				series : [
						  {
							name : '串均故障次数' ,
							type : 'line',
							smooth:true,
							itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(91,69,157)'
									}
								}
							},
							data : strandFault
						},{
							name : '串均受累次数' ,
							type : 'line',
							smooth:true,
							itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(59,175,218)'
									}
								}
							},
							data : strandTired
						}]
		}
		myChart.setOption(option);
	}
});

</script>
