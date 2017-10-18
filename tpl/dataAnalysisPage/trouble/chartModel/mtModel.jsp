<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="faultRateModelChartCtrl">
	<div class="pull-right">
		<span class="m-t-xs no-padder text-center">
				<span class="col-9 m-r-xs text-1-1x"><small></small></span> 
			</span>
	</div>
	<div id="mtChart" style="height:250px;"></div>
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
			$scope.mtData();
		}else{
			$scope.mtData();
		}
	});
	
	//各设备类型数据获取，并传值
	$scope.mtData = function(){
		var data;
		switch($scope.dataTypeModel){
			case "month" :
				$http.get("./BDFault/getStationListMonthMtrMtbMonth.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy-MM")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "year" :
				$http.get("./BDFault/getStationListYearMtrMtbYear.htm",{
					params : {
						dateString: new Date($scope.dtimeModel).Format("yyyy")
					}
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
			case "total" :
				$http.get("./BDFault/getStationListAllMtrMtbAll.htm",{
				}).success(function(res) {
					parseData(res);
				}).error(function(response) {
				});
				break;
		}
		
	}
	function parseData(data){
		var mttr = [],mtbf = [],date = [];
		if((data.mtrMtbs != null) && (data.mtrMtbs != undefined) && (data.mtrMtbs.length)){
			for(var i = 0;i<data.mtrMtbs.length;i++){
				if(data.mtrMtbs[i].mttr != null){mttr.push(data.mtrMtbs[i].mttr);}else{mttr.push(0);}
				if(data.mtrMtbs[i].mtbf != null){mtbf.push(data.mtrMtbs[i].mtbf);}else{mtbf.push(0);}
				date.push(data.mtrMtbs[i].day);
			}
		}
		drawChart(mttr,mtbf,date);
	}
	
	$scope.mtData();
	
	function drawChart(mttr,mtbf,date){
		var myChart = echarts.init(document.getElementById('mtChart'));
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
						 	var res = params[0].name;
				           	for (var i = 0, l = params.length; i < l; i++) {
				           		res += '<br/>' + params[i].seriesName + ' : ' +params[i].value+"h";			
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
					data :['MTTR','MTBF'],
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
					boundaryGap : false,
					data : date
				} ],
				yAxis : [{
					name:'h',
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
							name : 'MTTR' ,
							type : 'line',
							smooth:true,
							itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(238,184,49)'
									}
								}
							},
							data : mttr
						},{
							name : 'MTBF' ,
							type : 'line',
							smooth:true,
							itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(52,197,189)'
									}
								}
							},
							data : mtbf
						}]
		}
		myChart.setOption(option);
	}
});

</script>
