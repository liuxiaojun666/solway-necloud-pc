<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 wrapper first-right" ng-controller="comprehensiveRadarCtrl">
		<div id="radarMap"  style="height:220px;"></div>
</div>
<script>
app.controller('comprehensiveRadarCtrl',function($scope, $http, $state, $stateParams) {
	
	$scope.$on('broadRadar', function(event, data) {  
       renderRadar(data);
    }); 
	function nullparse(data){
		for (var i = 0; i < data.length; i++) {
			if (!data[i]) {
				data[i] = '';
			};
		}
		return data;
	}
	function renderRadar(data){
		if(data){
			for (var i = 0; i < data.length; i++) {
				if (data[i].personnelEfficiency === null) {
					data[i].personnelEfficiency = '';
				};
			};
			$scope.selfData=[data[0].generatingPowerHours,
			                 data[0].pr,
			                 data[0].mtbf,
			                 data[0].mttr,
			                 data[0].personnelEfficiency
						      ]
			$scope.cityData=[data[1].generatingPowerHours,
			                 data[1].pr,
			                 data[1].mtbf,
			                 data[1].mttr,
			                 data[1].personnelEfficiency
						      ]
			$scope.areaData=[data[2].generatingPowerHours,
			                 data[2].pr,
			                 data[2].mtbf,
			                 data[2].mttr,
			                 data[2].personnelEfficiency
						      ]
		}
		
		getZhpg(nullparse($scope.selfData),nullparse($scope.cityData),nullparse($scope.areaData))
	}
	
	
});
function getZhpg(selfData,cityData,areaData){
	var myChart = echarts.init(document.getElementById('radarMap'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	option = {
			color:['#56c6c7','#b4a3de','#e47488'],//自身，城市平均，方圆50公里
		    tooltip : {
		        trigger: 'item',
		        confine : true
		    },
		    legend: {
		        data: ['自身','城市平均', '方圆50公里'],
		        orient : 'vertical',
		        left : 0
		    },
		    noDataLoadingOption:{
		        text : '暂无数据',
		        effect :function(params,callback){
		        	return "暂无数据"
		        }
		    },
		    calculable : false,
		    radar:[
	           {
	        	   indicator : [
		    	                {text : '发电小时数',max:100},
		    	                {text : 'PR',max:100},
		    	                {text : 'MTBF',max:100},
		    	                {text : 'MTTR',max:100},
		    	                {text : '光资源',max:100}
		    	    ],  
		    	    center : ['60%', '50%'],
		    	    radius:80
	           }
	              
	        ],
		    series : [
		        {
		            type: 'radar',
		            data : [
		                
		                {
		                	value :cityData,
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
		                },
		                {
		                    value :selfData ,
		                    name : '自身',
		                    z : 3,
		                    itemStyle : {
		    					normal : {
		    						color:'rgba(46, 199, 201,.4)',
		    						areaStyle : {
		    							color : 'rgba(46, 199, 201,.4)'
		    						},
		    						label:{
		    							textStyle:{
			    							color:'#fff'
		    							}
		    						},
		    						lineStyle : {
		    							color : 'rgba(46, 199, 201,.9)',
		    							width : 1
		    						},textStyle:{
		    							color:'rgba(46, 199, 201,.9)'
		    						}
		    					},
		    					emphasis:{
		    						color:"rgba(46, 199, 201,.9)"
		    					}
		    				}
		                }
		            ]
		        }
		    ]
		};
	myChart.setOption(option);                  
}

</script>
