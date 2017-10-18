<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 综合评估 -->
<div class="panel wrapper col-sm-12 m-n" ng-controller="inverterVCtrl">
<span class="font-h3 black-1 col-sm-12 m-b-n-md text-center inverterTabletitle">2016年3月逆变器发电效率分析</span>
<div class="hbox hbox-auto-xs" >
	<div class="col w-xxs" style="width: 65px">
			<div class="vbox flatBarUl">
				<p id="data1"ng-click="changeData('1')" class="active">PR</p>
				<p id="data2" ng-click="changeData('2')">PBA</p>
			</div>
		</div>
	<div class="col" style="padding:20px 0px;">
		<div class="vbox">
			<div class="col-sm-12" >
				<div id="inverterVData" style="height:300px;"></div>
			</div>
		</div>
	</div>
</div>
</div>
<script>
app.controller('inverterVCtrl',function($scope, $http, $state, $stateParams) {
	$scope.inverterV;//记录数据
	$scope.current; //本期
	$scope.last; //上期
	$scope.same; //去年同期
	$scope.title;
	
	$scope.getInvData=function(){
		$http.get(
				"${ctx}/Report/getStationInverterListForDevice.htm",{
					params : {
						stid:$scope.stid,
						month:$("#changeTimeId2").html()
					}
				})
				.success(function(result) { 
					$scope.inverterV=result.data;
					$scope.changeData('1');
				}).error(function(response) {
				});
	}
	$scope.getInvData();
	//柱状图改变状态，根据传回来的json 值 重新组织数据
	$scope.changeData=function(data){
		$("#data"+data).addClass("active")
		$("#data"+data).siblings().removeClass("active")
		if(data=="1"){
			$scope.title="PR"
			
			$scope.current=$scope.inverterV.cur_pr
			$scope.last=$scope.inverterV.last_pr
			$scope.same=$scope.inverterV.last_year_pr
		}else if(data=="2"){
			$scope.title="PBA"
			
			$scope.current=$scope.inverterV.cur_pba
			$scope.last=$scope.inverterV.last_pba
			$scope.same=$scope.inverterV.last_year_pba
		}
		inverterVAnalyze($scope.title,$scope.current,$scope.last,$scope.same,$scope.inverterV.eqname)
	}
	
});
function inverterVAnalyze(title,current,last,same,eqname) {
	console.log(title)
	console.log(current)
	console.log(last)
	console.log(same)
	console.log(eqname)
	var myChart = echarts.init(document.getElementById('inverterVData'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	option = {
			color:['#B5C334','#FCCE10','#999'],
			 tooltip : {
			        trigger: 'axis',
			        	 axisPointer:{
							 type: 'line',
							    lineStyle: {
							        color: '#bbb',
							        width: 1,
							        type: 'solid'
							    }
						 },
			    },
		    legend: {
		    	x:"right",
		        data:['本期','上期','去年同期']
		    },
			grid : {
				borderWidth : '0px',
				x : '40px',
				x2 : '30px',
				y : "50px",
				y2 : "20px"
			},
		    xAxis : [
		        {
		            type : 'category',
		            axisTick : {
						show : false
					},
		            axisLabel : {
						textStyle : {
							color : '#bbb',
							fontSize : 12
						}
					},
					type : 'category',
					axisLine : {
						lineStyle : {
							color : '#bbb',
							width : 1
						}
					},
					splitLine : {
						show : false
					},
		            data :eqname
		        }
		    ],
		    
		    yAxis : [
		        {	
		            axisLabel : {
						interval:59,
						textStyle : {
							color : '#bbb',
							fontSize : 12
						}
					},
					type : 'category',
					axisLine : {
						lineStyle : {
							color : '#bbb',
							width : 1
						}
					},
					splitLine : {
						show : false
					},
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'本期',
		            type:'bar',
		            data:current
		        },
		        {
		            name:'上期',
		            type:'bar',
		            data:last

		        },
		        {
		            name:'去年同期',
		            type:'bar',
		            data:same,
		            markLine : {
		            	symbol:"none",
		            	itemStyle:{
		            		normal:{
		            			lineStyle:{
		            				width:1,
		            				color:"#f05050",
		            				type:"solid"
		            			},
		            			label:{
		            				show:false
		            			}
		            		}
		            	},
		                data : [
		                    {type : 'average', name : '平均值'}
		                ]
		            },
				z:2
		        }
		    ]
		};
	myChart.setOption(option);  
}
</script>
