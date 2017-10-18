<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  class="modal fade" id="weatherModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-sm" style="width: 400px; " ng-controller="weatherCtrl" >
		<div class="modal-content col-sm-12 no-padder n-b-r" style="margin-top:250px;">
			<a class="dailymodelCloseBtn" data-dismiss="modal">
				<img src="theme/images/close.png"/>	
			</a>
			<div class="modal-body col-sm-12">
				<div class="col-sm-12 text-center font-h4 black-1">天气情况占比图</div>
				<div class="col-sm-12"><div id="kwhTotalMReport" style="width:350px;height:270px;"></div></div>
			</div>
		</div>
	</div>
</div>
<script>
app.controller('weatherCtrl',function($scope, $http, $state, $stateParams) {
	$http.get("${ctx}/Report/getStationWeatherDataForMonth.htm",{
		params : {
			stid:$scope.stid,
			month:$scope.mapTimeMonth
		}
	})
	.success(function(result) {
		weatherAnalyze(result.data)
	}).error(function(response) {
		
	});
});

function weatherAnalyze(weatherData) {
		var myChart = echarts.init(document.getElementById('kwhTotalMReport'));
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
				tooltip : {
			        trigger: 'item',
			        formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				calculable : true,
			    series : [
			        {
			            name:'天气情况占比图',
			            type:'pie',
			            radius : [30, 110],
			            center : ['50%', 150],
			            roseType : 'area',
			            x: '70%',               // for funnel
			            max: 40,                // for funnel
			            sort : 'ascending',     // for funnel
			            data:[
			                {value:weatherData.rate[0], 
			                 name:weatherData.weather[0],
			                 itemStyle :{
			                	normal :{
	              		        color: '#e5cf0d',
	              		        label : {
	              		            textStyle: {
	              		            	color: '#e5cf0d'
	              		            }
	              		        },
	              		        labelLine : {
	              		           lineStyle:{
	              		        	   color:"#e5cf0d"}
	              		           }
			    				}
			                }},
			                {value:weatherData.rate[4], name:weatherData.weather[4],
			                	 itemStyle :{
					                	normal :{
			              		        color: '#2ec7c9',
			              		        label : {
			              		            textStyle: {
			              		            	color: '#2ec7c9'
			              		            }
			              		        },
			              		        labelLine : {
			              		           lineStyle:{
			              		        	   color:"#2ec7c9"}
			              		           }
					    				}
					                }},
			               /*  {value:15, name:'多云',
			                	 itemStyle :{
					                	normal :{
			              		        color: '#b6a2de',
			              		        label : {
			              		            textStyle: {
			              		            	color: '#b6a2de'
			              		            }
			              		        },
			              		        labelLine : {
			              		           lineStyle:{
			              		        	   color:"#b6a2de"}
			              		           }
					    				}
					                }}, */
			                {value:weatherData.rate[2], name:weatherData.weather[1],
			                	 itemStyle :{
					                	normal :{
			              		        color: '#5ab1ef',
			              		        label : {
			              		            textStyle: {
			              		            	color: '#5ab1ef'
			              		            }
			              		        },
			              		        labelLine : {
			              		           lineStyle:{
			              		        	   color:"#5ab1ef"}
			              		           }
					    				}
					                }},
			                {value:weatherData.rate[3], name:weatherData.weather[3], itemStyle :{
			                	normal :{
		              		        color: '#ffb980',
		              		        label : {
		              		            textStyle: {
		              		            	color: '#ffb980'
		              		            }
		              		        },
		              		        labelLine : {
		              		           lineStyle:{
		              		        	   color:"#ffb980"}
		              		           }
				    				}
				                }},
			                {value:weatherData.rate[2], name:weatherData.weather[2], itemStyle :{
			                	normal :{
		              		        color: '#8d98b3',
		              		        label : {
		              		            textStyle: {
		              		            	color: '#8d98b3'
		              		            }
		              		        },
		              		        labelLine : {
		              		           lineStyle:{
		              		        	   color:"#8d98b3"}
		              		           }
				    				}
				                }}
			            ]
			        }
			    ]
			};
		myChart.setOption(option);
}
</script>
