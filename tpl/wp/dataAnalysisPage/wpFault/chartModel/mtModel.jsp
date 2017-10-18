<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/fonts/defind/iconfont.css">
<style>
</style>
<div class="mete-con clearfix" ng-controller="wpFaultRateModelChartCtrl">
	<!-- <div class="pull-right">
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-minus" style="color:rgb(238,184,49)"></i> <span
					class="col-9 m-r-xs text-1-1x">MTTR<small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<i class="fa fa-minus" style="color:rgb(52,197,189)"></i> <span
					class="col-9 m-r-xs text-1-1x">MTBF<small></small></span> 
			</span>
		</div >
	</div> -->
	<div id="mtChart" style="height:250px;"></div>
</div>

<script>
app.controller('wpFaultRateModelChartCtrl',function($scope, $http, $state, $stateParams) {
	var myChartmt;
	window.addEventListener("resize", function() {
		myChartmt.resize();
	});
	$scope.$on('mtChild', function(event, data) {
		if(data != null){
			data.sort(function (value1, value2) {
				return value1.time - value2.time;
			});
			var mttr = [],mtbf = [],x = [];
			for(var i = 0;i<data.length;i++){
				if(data[i].mttr != null){
					mttr.push(data[i].mttr);
				}else{
					mttr.push("-");
				}
				if(data[i].mtbf != null){
					mtbf.push(data[i].mtbf);
				}else{
					mtbf.push("-");
				}
				if(data[i].time != null){
					x.push(data[i].time);
				}else{
					x.push("-");
				}
			}
			drawChartmt(mttr,mtbf,x);
		}else{
			drawChartmt([],[],[]);
		} 
	});
	
	function drawChartmt(mttr,mtbf,date){
		myChartmt = echarts.init(document.getElementById('mtChart'))
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
					/** formatter: function (params,ticket,callback) {
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
					y : "100px",
					y2 : "30px"
				},
				legend : {
					data :["MTTR" , "MTBF"],
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
		myChartmt.setOption(option);
	}
	
	//drawChartmt([],[],[]);
	
});

</script>
