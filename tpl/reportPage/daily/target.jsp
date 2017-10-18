<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-sm-12 first-left no-padder" ng-controller="targetData" >
	<div ng-include="kwhTotleM" load-done="finishKwhTotleM()"></div>
	<div ng-include="pieModal" load-done="finishPieModal()"></div>
	<div class="col-sm-7 no-padder">
		<img id="stFirstImg" class="col-sm-12 no-padder" style="height: 205px;">
		<div class="target-cover ">
		<div class="target-cover-1">
			<div class="font-h4">辐射总量</div>
			<div class="font-h1 m-t-sm" >
			<span ng-bind="targetData.rad|dataNullFilter"></span>
			<small ng-bind="targetData.radUnit"></small>
			</div>
		</div>
		<div class="target-cover-2">
			<div class="font-h4">日照小时数</div>
			<div class="font-h1 m-t-sm ">
				<span ng-bind="targetData.sun_hours|dataNullFilter"></span>
				<small>h</small>
			</div>
		</div>
		</div>
		<div class="col-sm-3 no-padder text-center b-r targetWea" style="line-height: inherit;">
			<div style="">
				<i class="ico-family ico-sun sun_color" style="font-size:70px;" ng-show="targetData.weather=='晴'"></i>
				<i class="ico-family ico-yin yin_color" style="font-size:70px;" ng-show="targetData.weather=='阴'"></i>
				<i class="ico-family ico-rain rain_color" style="font-size:70px;" ng-show="targetData.weather=='雨'"></i>
				<i class="ico-family ico-snow snow_color" style="font-size:70px;" ng-show="targetData.weather=='雪'"></i>
				<i class="ico-family ico-smog smog_color" style="font-size:70px;" ng-show="targetData.weather=='霾'"></i>
				<i class="ico-family ico-weatherelse weatherelse_color" style="font-size:70px;" ng-show="targetData.weather=='其它'"></i>
				 <!-- <i class="icon iconfont" style="font-size:120px;color:#e5cf0d">&#xe614;</i> -->
				 <p ng-bind="targetData.weather|dataNullFilter" style="margin-top:-10px;"></p>
			</div>
			
		</div>
		<div class="col-sm-9 no-padder black-1 text-base">
			<span class="col-sm-12 font-h2  text-black targetWea-title" >
			天气指标</span>
			<div class="col-sm-4 targetWea-content b-r">
				<p class="black-3 m-t-xs" >平均风速</p>
				<p class="m-t-n-xs font-h3">
					<span ng-bind="targetData.ws_avg|dataNullFilter"></span>
					<span >m/s</span>
				</p>
			</div>
			<div class="col-sm-4 targetWea-content b-r">
				<p class="black-3 m-t-xs">平均湿度</p>
				<p class="m-t-n-xs font-h3" >
					<span ng-bind="targetData.hto_avg|dataNullFilter"></span>
					<span >%</span>
				</p>
			</div>
			<div class="col-sm-4 targetWea-content">
				<p class="black-3 m-t-xs">平均温度</p>
				<p class=" m-t-n-xs font-h3" >
				<span ng-bind="targetData.ta_avg|dataNullFilter"></span>
				<span>℃</span>
				</p>
			</div>
			
		</div>
	</div>
	<div class="col-sm-5  no-padder bg-white2 div-height black-1 font-h5">
		<div class="col-sm-12  targetDiv">
			<span class="col-sm-3 no-padder">理论发电量</span>
			<span class="col-sm-4 no-padder black-2 font-h4" >
				<span ng-bind="targetData.the_kwh|dataNullFilter"></span>
				<span ng-bind="targetData.the_kwhUnit"></span>
			</span>
			<span class="col-sm-2 no-padder">
				<span class="pull-left" >应发电量</span>
			</span>
			<span class="col-sm-3 no-padder black-2 font-h4 ">
				<span class="pull-right">
					<span ng-bind="targetData.shd_kwh|dataNullFilter"></span><span ng-bind="targetData.shd_kwhUnit"></span>
				</span>
			</span>
		</div>
		<div class="col-sm-12  targetDiv">
			<span class="col-sm-3 no-padder">发电量</span>
			<span class="col-sm-4 no-padder black-2 font-h4">
				<span ng-bind="targetData.real_kwh|dataNullFilter"></span>
				<span ng-bind="targetData.real_kwhUnit"></span>
			</span>
			<span class="col-sm-2 no-padder">
				<span class="pull-left">估算收入</span>
			</span>
			<span class="col-sm-3 no-padder black-2 font-h4 ">
				<span class="pull-right">￥<span ng-bind="targetData.income|dataNullFilter"></span><span ng-bind="targetData.incomeUnit|dataNullFilter"></span>
				
			</span>
			</span>
		</div>
		<div class="col-sm-12  targetDiv">
			<a class="col-sm-3 no-padder href-blur" ng-click="showKwh()">月度累计</a>
			<span class="col-sm-4 no-padder black-2 font-h4">
				<span ng-bind="targetData.kwh_total_m|dataNullFilter"></span>
				<span ng-bind="targetData.kwh_total_mUnit"></span>
			</span>
			<span class="col-sm-2 no-padder">
				<span class="pull-left">月完成率</span>
			</span>
			<span class="col-sm-3 no-padder black-2 font-h4 ">
				<span class="pull-right" >
					<span ng-bind="targetData.month_finish_r|dataNullFilter"></span>%
				</span>
			</span>
		</div>
		<div class="col-sm-12  targetDiv">
			<span class="col-sm-3 no-padder">年度累计</span>
			<span class="col-sm-4 no-padder black-2 font-h4">
				<span ng-bind="targetData.kwh_total_y|dataNullFilter"></span>
				<span ng-bind="targetData.kwh_total_yUnit"></span>
			</span>
			<span class="col-sm-2 no-padder">
				<span class="pull-left">年完成率</span>
			</span>
			<span class="col-sm-3 no-padder black-2 font-h4 ">
				<span class="pull-right" >
					<span ng-bind="targetData.year_finish_r|dataNullFilter"></span>%
				</span>
			</span>
		</div>
		<div class="col-sm-12  targetDiv">
			<span class="col-sm-3 no-padder">最大光照</span>
			<span class="col-sm-4 no-padder black-2 font-h4">
				<span ng-bind="targetData.max_sun|dataNullFilter"></span>
				<span ng-bind="targetData.max_sunUnit"></span>
			</span>
			<span class="col-sm-3 no-padder">
				<span class="pull-left" ng-bind="targetData. max_sun_time"></span>
			</span>
	
		</div>
		<div class="col-sm-12  targetDiv">
			<span class="col-sm-3 no-padder">最大功率</span>
			<span class="col-sm-4 no-padder black-2 font-h4">
				<span ng-bind="targetData.max_p|dataNullFilter"></span>
				<span ng-bind="targetData.max_pUnit"></span>
			</span>
			<span class="col-sm-3 no-padder">
				<span class="pull-left" ng-bind="targetData.max_p_time|dataNullFilter"></span>
			</span>

		</div>
		<div class="col-sm-12">
			<span  class="col-sm-4 no-padder a-cur-poi" style="height: 110px" id="zhxlPie"></span>
			<span  class="col-sm-4 no-padder a-cur-poi"  style="height: 110px"  id="prPie"></span>
			<span  class="col-sm-4 no-padder a-cur-poi"  style="height: 110px"  id="pbaPie"></span>
		</div>
	</div>
</div>
<script>
app.controller('targetData',function($scope, $http, $state, $stateParams) { 
	var pieModal=0;
	
		$scope.$on('dailyRefresh', function(event, data) {  
	       if(data[0]){
	    	   $scope.mapTimeDay=data[1]
	    	   $scope.getTargetData()
	      	 }
	      }); 
		$scope.$on('refreshViewDataForHead', function(event, data) {  
			$scope.getTargetData();
	    });
		$scope.getTargetData=function(){
			 $http.get(
						"${ctx}/Report/getStationBaseDataForDay.htm",{
							params : {
								stid:$scope.stid,
								dtime:$scope.mapTimeDayRefresh
							}
						})
						.success(function(result) { 
							$scope.targetData=result.data
							if(result.data && result.data.cmp_power_r){
								getZhxlPie(result.data.cmp_power_r)
							}else{
								getZhxlPie("")
							}
							if(result.data && result.data.pr){
								getPrPie(result.data.pr)
							}else{
								getPrPie("")
							}
							if(result.data && result.data.pba){
								getPbaPie(result.data.pba)
							}else{
								getPbaPie("")
							}
						}).error(function(response) {
							});
			 $http.get(
						"${ctx}/PowerStation/selectById.htm",{
							params : {
							}
						})
						.success(function(result) { 
							if(result.scenepictures != null && result.scenepictures !=""){
								var array = result.scenepictures.split(",");
								if(array[0]){
									$("#stFirstImg").attr("src","${imgPath}/document/powerStationPicture/"+array[0]);
								}else{
									$("#stFirstImg").attr("src","${ctx}/theme/images/dailybg.jpg");
								}
							}else{
								$("#stFirstImg").attr("src","${ctx}/theme/images/dailybg.jpg");
							}
						}).error(function(response) {
							});
		}
		 $scope.getTargetData()
	 // 显示综合评估
	 $scope.showPie=function(flag){
		 $http.get("${ctx}/Report/getStationEstimateDataForDay.htm",{
				params : {
					stid:$scope.stid,
					dtime:$scope.mapTimeDayRefresh
				}
			})
			.success(function(result) {
				 if(flag==1){
					 $scope.pieTitle="综合效率对比分析";
					 if(result.data.self && result.data.self.cmp_power_r){
						 $scope.self=parseFloat(result.data.self.cmp_power_r).toFixed(1)
					 }else{
						 $scope.self="";
					 }
					 if(result.data.area && result.data.area.cmp_power_r){
						 $scope.area=parseFloat(result.data.area.cmp_power_r).toFixed(1)
					 }else{
						 $scope.area="";
					 }
					 if(result.data.city && result.data.city.cmp_power_r){
						 $scope.city=parseFloat(result.data.city.cmp_power_r).toFixed(1)
					 }else{
						 $scope.city="";
					 }
					
				 }else if(flag==2){
					 $scope.pieTitle="PR对比分析"
					 if(result.data.self && result.data.self.pr){
						 $scope.self=parseFloat(result.data.self.pr).toFixed(1)
					 }else{
						 $scope.self="";
					 }
					 if(result.data.area && result.data.area.pr){
						 $scope.area=parseFloat(result.data.area.pr).toFixed(1)
					 }else{
						 $scope.area="";
					 }
					 if(result.data.city && result.data.city.pr){
						 $scope.city=parseFloat(result.data.city.pr).toFixed(1)
					 }else{
						 $scope.city="";
					 }
						
				 }else if(flag==3){
					 $scope.pieTitle="PBA对比分析"
					 if(result.data.self && result.data.self.pba){
						 $scope.self=parseFloat(result.data.self.pba).toFixed(1)
					 }else{
						 $scope.self="";
					 }
					 if(result.data.area && result.data.area.pba){
						 $scope.area=parseFloat(result.data.area.pba).toFixed(1)
					 }else{
						 $scope.area="";
					 }
					 if(result.data.city && result.data.city.pba){
						 $scope.city=parseFloat(result.data.city.pba).toFixed(1)
					 }else{
						 $scope.city="";
					 }
				 }
				 $scope.pieModal="${ctx}/tpl/reportPage/daily/dailymodal/pieModal.jsp";
				 $("#pieModal").modal({backdrop: 'static', keyboard: false});
				 	getSelf($scope.self);
				 	getArea($scope.area);
					getCity($scope.city);
			}).error(function(response) {
				
			});
		
	 }
	$scope.closeModal=function(){
				$("#pieModal").modal('hide');		
	 } 
	 $scope.finishPieModal=function(){
		 $scope.showPie();
	/* 	 if(pieModal=="0"){
			   $("#pieModal").modal({backdrop: 'static', keyboard: false});
			   targetModal++;
		   } */
		  
	 }
		var targetModal=0;
	   //发电量分析
	   $scope.showKwh=function(){
			$scope.kwhTotleM="${ctx}/tpl/reportPage/daily/dailymodal/kwh_total_m.jsp";
			$("#kwhMTotalModal").modal({backdrop: 'static', keyboard: false});
			$("#kwhMTotalModal").addClass('fade');
	   }
	   $scope.finishKwhTotleM=function(){
		   if(targetModal=="0"){
			   $("#kwhMTotalModal").modal({backdrop: 'static', keyboard: false});
			   targetModal++;
		   }
		  
	   }
	  
	 });
	var cmp_power_r;
	var pr;
	var pba;
//getZhxlPie(cmp_power_r);
function getZhxlPie(cmp_power_r){
	if(cmp_power_r){
		cmp_power_r = parseFloat(cmp_power_r).toFixed(1);
	}
	var myChart = echarts.init(document.getElementById('zhxlPie'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"rgba(217, 83, 79,.8)",
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
		                return cmp_power_r + '%'
		            },
		            textStyle: {
		            	fontSize : '22',
						color : 'rgba(217, 83, 79,.8)',
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
		        	clockWise:false,
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-cmp_power_r, itemStyle : labelBottom},
		                {name:'综合效率', value:cmp_power_r,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
//getPrPie(pr);
function getPrPie(pr){
	if(pr){
		pr = parseFloat(pr).toFixed(1);
	}
	var myChart = echarts.init(document.getElementById('prPie'));
	window.addEventListener("resize", function() {
		myChart.resize();
	});
	var labelTop = {
		    normal : {
		    	color:"#f0ad4e",
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
		                return pr + '%'
		            },
		            textStyle: {
		            	fontSize : '22',
						color : '#f0ad4e',
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
		        	clockWise:false,
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-pr, itemStyle : labelBottom},
		                {name:'PR', value:pr,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
function getPbaPie(pba){
	if(pba){
		pba = parseFloat(pba).toFixed(1);
	}
	var myChart = echarts.init(document.getElementById('pbaPie'));
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
		                return pba + '%'
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
		        	clockWise:false,
		            type : 'pie',
		            center : ['50%', '50%'],
		            radius : radius,
		            x: '0%', // for funnel
		            itemStyle : labelFromatter,
		            data : [
		                {name:'', value:100-pba, itemStyle : labelBottom},
		                {name:'PBA', value:pba,itemStyle : labelTop}
		            ]
		        }
		    ]
		};

	myChart.setOption(option);
}
</script>
