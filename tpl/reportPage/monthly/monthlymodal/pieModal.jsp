<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  class="modal fade" id="pieModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" >
	<div class="modal-dialog row modal-sm" style="width: 400px;">
		<div class="modal-content col-sm-12 no-padder n-b-r" style="margin-top:250px;">
			<a class="dailymodelCloseBtn" ng-click="closeModal()">
				<img src="theme/images/close.png"/>	
			</a>
			<div class="modal-body col-sm-12">
				<span class="font-h4 black-1 m-b-md col-sm-12 text-center" ng-bind="pieTitle"></span>
				<div class="col-sm-12 m-b">
					<span class="col-sm-4 no-padder a-cur-poi" style="width:110px;height: 110px" id="zhxl"></span>
					<span class="col-sm-4 no-padder a-cur-poi"  style="width:110px;height: 110px"  id="pr"></span>
					<span class="col-sm-4 no-padder a-cur-poi"  style="width:110px;height: 110px"  id="pba"></span>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

app.controller('pieDataCtrl',function($scope, $http, $state, $stateParams) {

	getZhxl($scope.self);
	getPba( $scope.area);
	getPr($scope.city);

});

function getZhxl(self){
	var myChart = echarts.init(document.getElementById('zhxl'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#56c6c7",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
						fontSize : '13',
						color : '#333',
						baseline : 'top'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		            formatter : function (params){
		                return self + '%'
		            },
		            textStyle: {
		            	fontSize : '22',
						color : '#56c6c7',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center',
		            textStyle: {
		                baseline : 'bottom'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: '#56c6c7'
		    }
		};
		var radius = [40, 45];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-self, itemStyle : labelBottom},
		                {name:'自身', value:self,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}

function getPr(area){
	var myChart = echarts.init(document.getElementById('pr'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#b4a3de",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
						fontSize : '13',
						color : '#333',
						baseline : 'top'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		            formatter : function (params){
		                return area + '%'
		            },
		            textStyle: {
		            	fontSize : '22',
						color : '#b4a3de',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center',
		            textStyle: {
		                baseline : 'bottom'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
		};
		var radius = [40, 45];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-area, itemStyle : labelBottom},
		                {name:'城市平均', value:area,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}

function getPba(city){
	var myChart = echarts.init(document.getElementById('pba'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#e47488",
		        label : {
		            show : true,
		            position : 'center',
		            formatter : '{b}',
		            textStyle : {
						fontSize : '13',
						color : '#333',
						baseline : 'top'
					}
		        },
		        labelLine : {
		            show : false
		        }
		    }
		};
		var labelFromatter = {
		    normal : {
		        label : {
		            formatter : function (params){
		                return city + '%'
		            },
		            textStyle: {
		            	fontSize : '22',
						color : '#e47488',
		                baseline : 'top'
		            }
		        }
		    },
		}
		var labelBottom = {
		    normal : {
		        color: '#ccc',
		        label : {
		            show : true,
		            position : 'center',
		            textStyle: {
		                baseline : 'bottom'
		            }
		        },
		        labelLine : {
		            show : false
		        }
		    },
		    emphasis: {
		        color: 'rgba(0,0,0,0)'
		    }
		};
		var radius = [40, 45];
		option = {
		    legend: {
		        x : 'center',
		        y : 'center',
		        data:[
		            ''
		        ]
		    },
		    series : [
		        {
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-city, itemStyle : labelBottom},
		                {name:'方圆50公里', value:city,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
</script>
