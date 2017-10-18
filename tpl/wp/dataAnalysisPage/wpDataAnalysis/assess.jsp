<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="col-sm-12 wrapper first-right" ng-controller="wpComprehensiveRadarCtrl">
		<div id="radarMap"  style="height:220px;"></div>
</div>
<script>
var echarts;
app.controller('wpComprehensiveRadarCtrl',function($scope, $http, $state, $stateParams) {
	
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
			$scope.selfData=[data.self.real_hours_score,
			                 data.self.pba_score,
			                 data.self.mtbf_score,
			                 data.self.mttr_score,
			                 data.self.wind_resource_score
						      ]
			$scope.cityData=[data.city.real_hours_score,
			                 data.city.pba_score,
			                 data.city.mtbf_score,
			                 data.city.mttr_score,
			                 data.city.wind_resource_score
						      ]
			$scope.areaData=[data.area.real_hours_score,
			                 data.area.pba_score,
			                 data.area.mtbf_score,
			                 data.area.mttr_score,
			                 data.area.wind_resource_score
						      ]
		}
		
		getZhpg(nullparse($scope.selfData),nullparse($scope.cityData),nullparse($scope.areaData))
	}
	
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
		    	                {text : 'PBA',max:100},
		    	                {text : 'MTBF',max:100},
		    	                {text : 'MTTR',max:100},
		    	                {text : '风资源',max:100}
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

});

</script>
