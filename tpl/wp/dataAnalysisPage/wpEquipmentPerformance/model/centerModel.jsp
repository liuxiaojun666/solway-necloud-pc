<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
#selectYaxis{    -webkit-appearance: none;
    position: relative;
    top: 45px;left: 40px;z-index: 9999;
    border:none;background:white url("theme/images/wp/dataAnalysis/green-arrow-down.png") no-repeat;    background-position: 100%;
    padding: 0 15px 0 0px;}
</style>
<div ng-controller="centerModelCtrl" style="  background: white;margin: 10px;">
	<div class="pull-right">
		<div class="col-xs-12 wrapper-xs points" style="text-align: right;padding: 15px;">
			<span class="m-t-xs no-padder text-center">
				<span
					class="col-9 m-r-xs text-1-1x"><small></small></span> 
			</span>
			<span class="m-t-xs no-padder text-center">
				<span
					class="col-9 m-r-xs text-1-1x"><small></small></span> 
			</span>
		</div >
	</div>
	<select id="selectYaxis"><option value="PBA">PBA</option><option value="oper">高效占比</option></select>
	<div id="faultRateChart" style="height:350px;"></div>
</div>

<script>
app.controller('centerModelCtrl',function($scope, $http, $state, $stateParams) {
	$scope.Yaxis = "PBA";
	$scope.$on('faultRateChild', function(event, data) {
		$("#faultRateChart").empty();
		$scope.data = data;
		organizeData();

		/* if((data.faultRateVos != null) && (data.faultRateVos != undefined) && (data.faultRateVos.length)){
			var rate = [],date = [];
			for(var i = 0;i<data.faultRateVos.length;i++){
				rate.push(data.faultRateVos[i].rate);
				date.push(data.faultRateVos[i].date);
			}
			drawChart(rate,date);
		}else{
			$("#faultRateChart").html("暂无数据");
		} */
	});
	
	$("#selectYaxis").change(function(){
		var curVal = $("#selectYaxis option:selected").val();
		$scope.Yaxis = curVal;
		organizeData();
	});
	function organizeData(){
		var currentData;
		if($scope.data){
			if($scope.Yaxis ==  "PBA"){
				currentData = $scope.data.pbaList;
			}else if($scope.Yaxis ==  "oper"){
				currentData = $scope.data.operList;
			}
		}
		
		var xaxis = [],fanAll = [],fanSingle = [];
		if(currentData){
			for(var i = 0;i<currentData.length;i++){
				if(currentData[i].time){
					if($scope.dataType == 'month'){
						xaxis.push(currentData[i].time.substring(6,8));
					}else if($scope.dataType == 'year'){
						xaxis.push(currentData[i].time.substring(4,6));
					}
				}else{
					xaxis.push(currentData[i].time);
				}
				
				
				
				if(currentData[i].single != null){
					fanSingle.push(currentData[i].single);
				}else{
					fanSingle.push("-")
				}
				
				if(currentData[i].all != null){
					fanAll.push(currentData[i].all);
				}else{
					fanAll.push("-");
				}
			}
		}
		
		drawChart(xaxis,fanAll,fanSingle)
	}
	
	function drawChart(x,fanAll,fanSingle){
		var myChart = echarts.init(document.getElementById('faultRateChart'));
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
						 	var res = params[0].seriesName + ' : ' +params[0].value+"次";
				            return res;
				      }*/
			    },
			    legend : {
			    	show : true,
			    	data : ['全部风机','单台风机'],
			    	right: 10
			    	
			    },
				grid : {
					borderWidth : '0px',
					x : '50px',
					x2 : '50px',
					y : "20px",
					y2 : "80px"
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
					data : x,
					axisLabel : {
		            	formatter : function (value, index) {
		            	    if (index === (x.length -1)) {
		            	    	if($scope.dataType == 'month'){
		            	    		 return value + "日";
		    					}else if($scope.dataType == 'year'){
		    						 return value + "月";
		    					}
		            	       
		            	    }else{
		            	    	return value
		            	    }
		            	}
		            }
				} ],
				yAxis : [{
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
							name : '全部风机' ,
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
							data : fanAll
						},{
				            name:'单台风机',
				            type:'line',
				            smooth:true,
				            itemStyle : {
								normal : {
									areaStyle: {type: 'default'},
									color : function(params) {
										return 'rgb(65,126,183)'
									}
								}
							},
				            data:fanSingle
				        }]
		}
		myChart.setOption(option);
	}
});

</script>
