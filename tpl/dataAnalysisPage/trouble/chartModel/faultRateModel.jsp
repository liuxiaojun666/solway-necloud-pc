<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="faultRateModelChartCtrl">
	<div class="pull-right">
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-minus" style="color:rgb(224,103,89)"></i> <span
					class="col-9 m-r-xs text-1-1x">故障率<small></small></span> 
			</span>
		</div >
	</div>
	<div id="faultRateChart" style="height:250px;"></div>
</div>

<script>
app.controller('faultRateModelChartCtrl',function($scope, $http, $state, $stateParams) {
	
	//初始化数据(月)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtimeModel = rightDay.Format("yyyy-MM");
	$scope.dataTypeModel = "month";
	
	$scope.$on('broadChangeDateToChildFault', function(event, data) {
		if(data){
			$scope.dataTypeModel = data.dataType;
			$scope.dtimeModel =data.dtime;
			$scope.faultRateData();
		}else{
			$scope.faultRateData();
		}
	});
	
	//各设备类型数据获取，并传值
	$scope.faultRateData = function(){
		var data;
		switch($scope.dataTypeModel){
			case "month" :
				$http.get("./BDFault/getStationListMonthFaultRateMonth.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy-MM")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "year" :
				$http.get("./BDFault/getStationListYearFaultRateYear.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "total" :
				$http.get("./BDFault/getStationListAllFaultRateAll.htm",{
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
		}
		
	}
	function parseData(data){
		var rate = [],date = [];
		if((data.faultRateVos != null) && (data.faultRateVos != undefined) && (data.faultRateVos.length)){
			for(var i = 0;i<data.faultRateVos.length;i++){
				rate.push(data.faultRateVos[i].rate);
				date.push(data.faultRateVos[i].date);
			}
		}
		drawChart(rate,date);
	}
	
	$scope.faultRateData();
	
	function drawChart(rate,date){
		var myChart = echarts.init(document.getElementById('faultRateChart'));
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
						 console.log(params)
						 	var res = params[0].seriesName + ' : ' +params[0].value+"次";
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
					boundaryGap : false,
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
							name : '故障率' ,
							type : 'line',
							smooth:true,
							itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(224,103,89)'
									}
								}
							},
							data : rate
						}]
		}
		myChart.setOption(option);
	}
});

</script>
