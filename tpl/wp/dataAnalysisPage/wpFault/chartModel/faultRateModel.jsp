<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="wpFaultRateModelChartCtrl">
	<!-- <div class="pull-right">
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-minus" style="color:rgb(224,103,89)"></i> <span
					class="col-9 m-r-xs text-1-1x">故障率<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-minus" style="color:rgb(65,126,183)"></i> <span
					class="col-9 m-r-xs text-1-1x">完好率<small></small></span> 
			</span>
		</div >
	</div> -->
	<div id="faultRateChart" style="height:250px;"></div>
</div>

<script>
app.controller('wpFaultRateModelChartCtrl',function($scope, $http, $state, $stateParams) {
	var myChartfault;
	window.addEventListener("resize", function() {
		myChartfault.resize();
	});
	
	$scope.$on('faultRateChild', function(event, data) {
		if(data != null){
			data.sort(function (value1, value2) {
				return value1.time - value2.time;
			});
			var fail_r = [],intact_r = [],x = [];
			for(var i = 0;i<data.length;i++){
				if(data[i].time != null){
					x.push(data[i].time);
				}else{
					x.push("-");
				}
				
				if(data[i].fail_r != null){
					fail_r.push(data[i].fail_r);
				}else{
					fail_r.push("-");
				}
				
				if(data[i].intact_r != null){
					intact_r.push(data[i].intact_r);
				}else{
					intact_r.push("-");
				}
				
			}
			drawChartfault(x,fail_r,intact_r);
		}else{
			drawChartfault([],[],[]);
		} 
	});
	
	function drawChartfault(x,fail_r,intact_r){
		myChartfault = echarts.init(document.getElementById('faultRateChart'));
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
						 	var res = "故障率: " +params[0].value+"次"+'<br/>';
						 	res += "完好率："+params[1].value+"%";
				            return res;
				      }*/
			    },
				grid : {
					borderWidth : '0px',
					x : '70px',
					x2 : '30px',
					y : "100px",
					y2 : "30px"
				},
				legend : {
					data :["故障率" , "完好率"],
					right : 5
				},
				xAxis : [ {
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
					data : x
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
				},{
		            type : 'value',
		            name : '%'
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
							data : fail_r
						},{
				            name:'完好率',
				            type:'line',
				            smooth:true,
				            yAxisIndex: 1,
				            itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(65,126,183)'
									}
								}
							}, 
				            data:intact_r
				 }]
				
		}
		myChartfault.setOption(option);
	}
	
	//drawChartfault([],[],[]);
});

</script>
