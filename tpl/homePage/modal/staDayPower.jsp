<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<div class="col-sm-12 no-padder"  ng-controller="staMonCtrl" >
<div class=""  id="distUserNav">
	<ul class="nav col-sm-12 no-padder nav-top b-b"  >
          <li class="col-sm-12 h3 no-padder text-center">
          	<a  data-dismiss="modal" ng-click="closeStatModal()" class="">
          		<span ng-bind="todayTimeForTitle"></span>功率趋势图
          	</a>
           </li>
          <li class="col-sm-1 no-padder">
          	
          </li>
        </ul>
</div>
<div class="col-sm-12 no-padder">
	<div class="col-sm-5 wrapper-xs points pull-right" >
			<div class="col-sm-4 no-padder text-center">
				<i class="fa fa-circle" style="color: #92aaff"></i> <span
					class="col-9 m-r-xs ">应发功率<small>(kW)</small></span>
				</span>
			</div>
			<div class="col-sm-4 no-padder text-center">
				<i class="fa fa-circle" style="color: #f56669"></i> <span
					class="col-9 m-r-xs ">实发功率<small>(kW)</small></span> 
			</div>
			<div class="col-sm-4 no-padder text-center">
				<span class="pull-right"> <i class="fa fa-circle"
					style="color: #efb800"></i> <span class="col-9 ">光照强度(W/㎡)</span>
				</span>
			</div>
	</div>
	<div class="col-sm-12 no-padder ">
		<div class="col-sm-12 no-padder rollDiv" id="load">
			<div id="ssglqxm" style="height:260px;"></div>
		</div>
	</div>

</div>
</div>
<script>
//	$(".rollDiv").css("height",$(window).height()-350)
	var myChart
	app.controller('staMonCtrl',function($scope, $http, $state,$rootScope) {
			var isDay=new Date().getDate()
			CommonPerson.Base.LoadingPic.PartShow('ssglqxm');			
			//得到当前月时间
			//$scope.analData=$scope.getDayData()
			//标题的时间
			$scope.todayTimeForTitle=new Date().Format("yyyy年MM月dd日")
			//向后台发送时间请求
			$scope.todayTimeForJson=new Date().Format("yyyy/MM/dd/")
		
			//切换时间
			$scope.changeData=function(nowData,obj){
				myChart.clear();
				$("#"+obj+"span").parent().siblings().children().removeClass("active animated fadeInLeft")
				$("#"+obj+"span").addClass("active");
				$scope.getstaDayPowerData(nowData)
			}
		
			$scope.getstaDayPowerData=function(nowData){
				//标题的时间
				$scope.todayTimeForTitle=new Date(nowData).Format("yyyy年MM月dd日")
				//向后台发送时间请求
				$scope.todayTimeForJson=new Date(nowData).Format("yyyy/MM/dd")
				$http({
					method : "POST",
					url : "${ctx}/MobileHmDeviceMonitor/getDayChartRealTimePower.htm",
					params : {
						'userId':1,
						'dateString':$scope.todayTimeForJson,
						'powerStationId':$scope.stationListId
					}
					})
					.success(function (msg) {
						partHide('ssglqxm')
						if(msg.echarts_xaxisTime==null){
							getPowerVModal([],[],[],[])
						}else{
							//$("#ssglqxm").height((msg.echarts_xaxisTime.length/60)*100)
							//$("#ssglqxm").width($(window).width())
							getPowerVModal(msg.echarts_xaxisTime,msg.echarts_predictPower,msg.echarts_power,msg.echarts_luminousIntensity);
						}
					}).error(function(msg){
					});
			
			}
			$scope.getstaDayPowerData(new Date().Format("yyyy/MM/dd/"))
	});
	function getPowerVModal(echarts_xaxisTime,echarts_predictPower,echarts_realTimePower,echarts_luminousIntensity) {
		 myChart = echarts.init(document.getElementById('ssglqxm'));	
			window.addEventListener("resize", function() {
				myChart.resize();
			});
			option = {
					addDataAnimation:false,
					title : {
						textStyle : {
							fontSize : 14,
							color : "#666",
							fontFamily : '微软雅黑',
							fontWeight : 'normal'
						}
					},
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
						 formatter: function (params,ticket,callback) {
					            var res = params[0].name;
					            console.log(params)
					            for (var i = 0, l = params.length; i < l; i++) {
					            	if(params[i].value!=""&&!isNaN(params[i].value)){
					            		console.log((parseFloat((params[i]).value)).toFixed(1))
					            		console.log((parseFloat((params[i]).value)).toFixed(1))
					                	res += '<br/>' + params[i].seriesName + ' : ' + (parseFloat((params[i]).value)).toFixed(1);
					                	/*if(i==1){
					                		res += powerVstr.name2;
					                	}else{
					                		res += powerVstr.name1;
					                	}*/
					            	} else if(params[i].value==""){
					                	res += '<br/>' + params[i].seriesName + ' : N/A';
					            	}
					            }
					            return res;
					      } 
				    },
				   
				    noDataLoadingOption:{
				        text : '暂无数据',
				        effect :function(params,callback){
				        	return "暂无数据"
				        }
				    },
					calculable : true,
					grid : {
						borderWidth : '0px',
						x : '60px',
						x2 : '40px',
						y : "20px",
						y2 : "20px"
					},
					xAxis : [ {
						axisTick : {
							show : false
						},
						axisLabel : {
							interval : 59,
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
						boundaryGap : false,
						data :echarts_xaxisTime
					} ],
					yAxis : [ {
						axisLabel : {
							textStyle : {
								color : '#bbb',
								fontSize : 12
							}
						},
						//name : powerVstr.name1,
						font : {
							color : '#bbb'
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
						type : 'value'
					}, {
						font : {
							color : '#bbb'
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
						type : 'value',
						axisLabel : {
							textStyle : {
								color : '#bbb',
								fontSize : 12
							},
							formatter : function(v) {
								return v;
							}
						}
						}  ],
					series : [  {
						symbol : 'none',
						name : '应发功率',
						type : 'line',
						
						z : 1,
						itemStyle : {
							normal : {
								color : 'rgb(66,139,202)',
								areaStyle : {
									color : 'transparent'
								},
								lineStyle : {
									/* 	type : 'none',
										width:2, */
									color : 'rgba(66,139,202,.9)',
									width : 2
								}
							}
						},
						data :  echarts_predictPower
					},{
						name : '实发功率',
						type : 'line',
						z : 2,
						itemStyle : {
							normal : {
								color : 'rgb(217, 83, 79)',
								areaStyle : {
									color : 'rgba(217, 83, 79,.8)'
								},
								lineStyle : {
									/* 	type : 'none',
										width:2, */
									color : 'rgba(217, 83, 79,.9)',
									width : 1
								}
							}
						},
						symbol : 'none',
						data : echarts_realTimePower
					}, {
						name : '光照强度',
						type : 'line',
						yAxisIndex :1,
						z : 3,
						itemStyle : {
							normal : {
								color : '#f0ad4e',
								areaStyle : {
									color : 'transparent'
								},
								lineStyle : {
									color : '#f0ad4e',
									width : 2
								}
							}
						},
						symbol : 'none',
						data : echarts_luminousIntensity
					}
					]
				};
			myChart.setOption(option);
	}
</script>
		
