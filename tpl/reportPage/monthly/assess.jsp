<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 wrapper first-right first-left-mon" ng-controller="getStationEstimateDataForMonth">
<span class="col-sm-12 text-center font-h4 black-1">综合评估</span>
	<div class="col-sm-12" >
		<div id="assessment" style="height:320px;"></div>
	</div>
</div>
<script>
app.controller('getStationEstimateDataForMonth',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('monthlyRefresh', function(event, data) {  
       if(data[0]){
    	   $scope.mapTimeMonth=data[1]
    	   $scope.getStationData();
      	 }
      }); 
	$scope.$on('refreshViewDataForHead', function(event, data) {  
		 $scope.getStationData();
    });
	$scope.getStationData=function(){
		$http.get("${ctx}/Report/getStationEstimateDataForMonth2.htm",{
			params : {
				stid:$scope.stid,
				month:$scope.mapTimeMonth
			}
		})
		.success(function(result) {
			$scope.stationEstimateDataForDay=result;
			$scope.selfData=["","","","","",""];
			$scope.cityData=["","","","","",""];
			$scope.areaData=["","","","","",""];
			if(result.radarCompared){
				for (var i = 0; i < result.radarCompared.length; i++) {
					if (result.radarCompared[i].personnelEfficiency === null) {
						result.radarCompared[i].personnelEfficiency = '';
					};
				};
				$scope.selfData=[result.radarCompared[0].generatingPowerHours,
							      result.radarCompared[0].personnelEfficiency,
							      result.radarCompared[0].mttr,
							      result.radarCompared[0].mtbf,
							      result.radarCompared[0].pr
							      ]
				$scope.cityData=[result.radarCompared[1].generatingPowerHours,
							      result.radarCompared[1].personnelEfficiency,
							      result.radarCompared[1].mttr,
							      result.radarCompared[1].mtbf,
							      result.radarCompared[1].pr
							      ]
				$scope.areaData=[result.radarCompared[2].generatingPowerHours,
							      result.radarCompared[2].personnelEfficiency,
							      result.radarCompared[2].mttr,
							      result.radarCompared[2].mtbf,
							      result.radarCompared[2].pr
							      ]
			}
			console.log($scope.selfData)
			console.log($scope.cityData)
			console.log($scope.areaData)
			arrFromNullToEmpty($scope.selfData);
			arrFromNullToEmpty($scope.cityData);
			arrFromNullToEmpty($scope.areaData);
			getZhpg($scope.selfData,$scope.cityData,$scope.areaData)
		}).error(function(response) {
			
		});
	}
	$scope.getStationData()
	
});
function getZhpg(selfData,cityData,areaData){
	var myChart = echarts.init(document.getElementById('assessment'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	option = {
			color:['#56c6c7','#b4a3de','#e47488'],
		    tooltip : {
		        trigger: 'axis',
		        formatter: function (params,ticket,callback) {
		            var res = params[0].indicator +"得分";
		            var units ="";
		            /*if(res == '平均间隔时间' || res == '平均恢复时间'){
		            	units = "h";
		            }else if(res == '故障率' || res == 'PBA效率'){
		            	units = "%";
		            }*/
		            for (var i = 0, l = params.length; i < l; i++) {
		            	if(params[i].value){
			                res += '<br/>' + params[i].name + ' : ' + params[i].value + '' + units;
		            	}else{
		            		res += '<br/>' + params[i].name + ' : - ' + units;
		            	}
		            }
		           	//callback(ticket, res);
		            return res;
		        }
		    },
		    legend: {
		        x : 'center',
		        data:[{
		        	name:"自身",
		        	textStyle:{
		        		fontSize:"19px;"
		        	}

		        },'城市平均','方圆50公里']
		    },
		   
		    calculable : false,
		    polar : [
		        {
		            indicator : [
		                {text : '发电小时数'},
		                {text : '人员效率'},
		                {text : 'MTTR'},
		                {text : 'MTBF'},
		                {text : 'PR'}
		            ],
		            radius : 100
		        }
		    ],
		    series : [
		        {
		            type: 'radar',
		            data : [
		                {
		                    value : selfData,
		                    name : '自身',
		                    z : 3,
		                    itemStyle : {
		    					normal : {
		    						color:'rgba(46, 199, 201,.7)',
		    						areaStyle : {
		    							color : 'rgba(46, 199, 201,.4)'
		    						},
		    						lineStyle : {
		    							color : 'rgba(46, 199, 201,.9)',
		    							width : 1
		    						}
		    					},
		    					emphasis:{
		    						color:"#000"
		    					}
		    				}
		                },
		                {
		                    value : cityData,
		                    name : '城市平均',
		                    z : 2,
		                    itemStyle : {
		    					normal : {
		    						color : 'rgba(182, 162, 222,.9)',
		    						areaStyle : {
		    							color : 'rgba(182, 162, 222,.4)'
		    						},
		    						lineStyle : {
		    							color : 'rgba(182, 162, 222,.9)',
		    							width : 1
		    						}
		    					}
		    				}
		                },
		                {
		                    value : areaData,
		                    z : 1,
		                    name : '方圆50公里',
		                    itemStyle : {
		    					normal : {
		    						color : 'rgb(217, 83, 79)',
		    						areaStyle : {
		    							color : 'rgba(217, 83, 79,.4)'
		    						},
		    						lineStyle : {
		    							color : 'rgba(217, 83, 79,.9)',
		    							width : 1
		    						}
		    					}
		    				},
		                }
		            ]
		        }
		    ]
		};
	myChart.setOption(option);                  
}

</script>
