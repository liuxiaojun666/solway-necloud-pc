<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  ng-controller="topModelCtrl" class="clearfix" style="    width: 600px;margin: 0 auto;">
	<div id="topLeft" class="pull-left"  style="height: 184px;width:300px;"></div>
	<div id="topRight" class="pull-left"  style="height: 184px;width:300px;"></div>
</div>
<script>
app.controller('topModelCtrl',function($scope, $http, $state, $stateParams) {

	$scope.$on('dataUp',function(e,data){
		if(data){
			initCurveLeft(data.pba);
			initCurveRight(data.h_oper_r);
		}
	});
	function initCurveLeft(nature){
		var myChart = echarts.init(document.getElementById('topLeft'));
		var isNull = false;
		if(nature === null){
			isNull = true;
			nature = 0;
		}
		var labelTop = {
		    normal : {
		    	color:"rgb(255,196,0)",
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		    	formatter : function (params){
	            	if(params.name == 'a'){
	            		if(isNull){
	            			return "-"
	            		}else{
	            			return params.value +"%"
	            		}
	            		
	            	}else{
	            		return "PBA"
	            	}
	            },
				 show : true,
		         position : 'center',
		         textStyle : {
		         	fontSize : '18',
					color : 'black',
		             baseline : 'bottom'
				 }
		    }
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        labelLine : {
		            show : false
		        }
		    },
		};
		var radius = [60, 70];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {	clockWise:false,
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', 
		            label : labelFromatter,
		            data : [
						{name:'a', value:nature,itemStyle : labelTop},
		                {name:'b', value:100-nature, itemStyle : labelBottom}
		            ]
		        }
		    ]
		};

		myChart.setOption(option);
	}
	
	function initCurveRight(nature){
		var myChart = echarts.init(document.getElementById('topRight'));
		var isNull = false;
		if(nature === null){
			isNull = true;
			nature = 0;
		}
		var labelTop = {
			    normal : {
			    	color:"rgb(92,113,192)",
			        labelLine : {
			            show : false
			        }
			    }
			};
			var labelFromatter = {
					normal : {
				    	formatter : function (params){
			            	if(params.name == 'a'){
			            		if(isNull){
			            			return "-"
			            		}else{
			            			return params.value +"%"
			            		}
			            		
			            	}else{
			            		return "高效占比"
			            	}
			            },
						 show : true,
				         position : 'center',
				         textStyle : {
				         	fontSize : '18',
							color : 'black',
				             baseline : 'bottom'
						 }
				    }
			}
			var labelBottom = {
			    normal : {
			        color: '#ccc',
			        labelLine : {
			            show : false
			        }
			    },
			};
			var radius = [60, 70];
			option = {
			    legend: {
			        x : 'center',
			        y : 'center',
			        data:[
			            ''
			        ]
			    },
			    series : [
			        {	clockWise:false,
			            type : 'pie',
			            center : ['50%', '50%'],
			            radius : radius,
			            x: '0%', 
			            label : labelFromatter,
			            data : [
							{name:'a', value:nature,itemStyle : labelTop},
			                {name:'b', value:100-nature, itemStyle : labelBottom}
			            ]
			        }
			    ]
			};
		myChart.setOption(option);
	}
});
</script>
