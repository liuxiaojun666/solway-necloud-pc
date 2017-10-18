<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<div class="col-sm-12 no-padder"  ng-controller="staMonCtrl" >
<div class=""  id="distUserNav">
	<ul class="nav col-sm-12 no-padder nav-top b-b"  >
          <li class="col-sm-12 no-padder text-center h3">
          	<a  data-dismiss="modal" ng-click="closeStatModal()" class="">
          		<span ng-bind="todayTimeForTitle"></span>发电量分析
          	</a>
           </li>
        </ul>
</div>
<div class="col-sm-12 no-padder">
	<div class="col-sm-5 pull-right wrapper-xs points" >
			<div class="col-sm-4 no-padder text-center pull-right">
				<span class="pull-right"> <i class="fa fa-circle"
					style="color: #ff9a00"></i> <span class="col-9 ">实发电量(kWh)</span>
				</span>
			</div>
			<div class="col-sm-4  no-padder text-center pull-right">
				<i class="fa fa-circle" style="color: #ffc700"></i> <span
					class="col-9 m-r-xs">应发电量<small>(kWh)</small></span> 
			</div>
	</div>
	<div class="col-sm-12 no-padder ">
		<div class="col-sm-12 no-padder">
		<div class="col-sm-12 text-center m-t-xs"id="loadFlags">
			 	</div>
			<div id="kwhTotalYReport" style="height:260px;"></div>
		</div>
	</div>

</div>
</div>
<script>
	var myChart;
	app.controller('staMonCtrl',function($scope, $http, $state,$rootScope) {
			//得到当前月时间
			//标题的时间
			//切换时间
			$scope.changeData=function(nowData,obj){
				myChart.clear();
				$.showLoading(loadFlags)
				
				$("#"+obj+"span").parent().siblings().children().removeClass("active")
				$("#"+obj+"span").addClass("active");
				$scope.getstaDayPowerData(nowData)
				
			}
			
			$scope.getstaDayPowerData=function(){
				CommonPerson.Base.LoadingPic.PartShow('kwhTotalYReport');
				//标题的时间
				$scope.todayTimeForTitle=new Date().Format("yyyy年")
				//向后台发送时间请求
				$scope.todayTimeForJson=new Date().Format("yyyy")
				$http({
					method : "POST",
					url : "${ctx}/MobileRtmDeviceMonitor/getYearChartGeneratingPower.htm",
					params : {
						'userId':1,
						'dateString':$scope.todayTimeForJson,
						'powerStationId':$scope.stationListId
					}
					})
					.success(function (msg) {
						partHide('kwhTotalYReport')
						if(msg.echarts_xaxisTime==null){
							powerAnalyze([],[],[])
						}else{
							powerAnalyze(msg.echarts_xaxisTime,
									msg.echarts_realGeneratingPower,
									msg.echarts_predictGeneratingPower,$http, $scope)
						}
						
					}).error(function(msg){
					});
			
			}
			$scope.getstaDayPowerData()
	});
	function powerAnalyze(echarts_xaxisTime,echarts_realGeneratingPower,echarts_predictGeneratingPower,$http, $scope){
		myChart = echarts.init(document.getElementById('kwhTotalYReport'));	
		window.addEventListener("resize", function() {
			myChart.resize();
		});
		option = {
			  	 tooltip : {
			        trigger: 'axis',
			  	 	  formatter: function (params,ticket,callback) {
			            var res ="";
			            for (var i = 0, l = params.length; i < l; i++) {
			            	res += params[i].seriesName+" : "+params[i].value +"<br/>" ;
			            }
			            return res;
			      }, 
			      axisPointer:{
						 type: 'line',
						    lineStyle: {
						        color: '#bbb',
						        width: 1,
						        type: 'solid'
						    }
					 }
			    },
			    grid : {
					borderWidth : '0px',
					x : '80px',
					x2 : '60px',
					y : "20px",
					y2 : "30px"
				},
				noDataLoadingOption:{
			        text : '暂无数据',
			        effect :function(params,callback){
			        	return "暂无数据"
			        }
			    },
				calculable : false,
				xAxis : [ {
					type : 'category',
					 axisTick : {
							show : false
						},
					axisLabel : {
						/* formatter:function (value){
							var time=new Date(value).Format("yyyy-mm")
							return time
						},  */
						textStyle : {
							color : '#bbb',
							fontSize : 12
						}
					},
					axisLine : {
						lineStyle : {
							color : '#bbb',
							width : 1
						}
					},
					splitLine : {
						show : false
					},
					data : echarts_xaxisTime
				} ,{
					type : 'category',
					show : false,
					data :echarts_xaxisTime
				} ],
				yAxis : [{
					type : 'value',
					axisLine : {
						lineStyle : {
							width : 1,
							color : '#bbb'
						}
					},
					axisLabel : {
						axisLabel : 15,
						textStyle : {
							color : '#bbb',
							fontSize : 13
						}
					},
					splitLine : {
						show : false
					}
				}],
				series : [
				  {
					name : '实发电量' ,
					type : 'bar',
					barWidth : 15,
					itemStyle : {
						normal : {
							color : function(params) {
								return '#ff9a00'
							}
						}
					},
					data : echarts_realGeneratingPower
				},{
					name : '应发电量',
					z:1,
					type : 'bar',
					xAxisIndex : 1,
					barWidth : 15,
					itemStyle : {
						normal : {
							color : function(params) {
								return '#ffc700'
							}
						}
					},
					data : echarts_predictGeneratingPower
				}]
			}
			myChart.setOption(option);
	}
</script>
		
