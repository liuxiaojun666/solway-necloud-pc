<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div  ng-controller="bottomModelCtrl" style="  background: white;margin: 10px;">
	 <div id="powerCurve" style="height:400px;"></div>
</div>
<script>
app.controller('bottomModelCtrl',function($scope, $http, $state, $stateParams) {
	var myChart;
	$scope.$on('bottomData',function(e,data){
		console.log(data);//?????组合数据
		$scope.data = data;
		initData();
	});
	
	function initData(){
		/* var scatter =  [
		                [0, 49.8], [2.3, 49.2], [2, 73.2], [2.5, 20.8], [2, 68.8],
		                [3, 50.6], [3.5, 82.5], [3.9, 57.2], [3.6, 87.8], [3, 72.8],
		                [4, 54.5], [4, 59.8],[3, 50.6], [6.5, 82.5], [6, 72.8], [8.5, 57.2], [9.3, 87.8],[7.5, 82.5], [6.9, 72.8], [9.4, 57.2]
		            ];
		var line = [10,30,40,18,70,90,120,140,150,160,160];
		var bar =  [20,50,90,26,28,70,175,182,148,180,123];
		var x = [0,1,2,3,4,5,6,7,8,9,10];  */
		//散点
		var scatter = [];
		if($scope.data && $scope.data.pointList){
			var scatterData = $scope.data.pointList;
			for(var i=0;i<scatterData.length;i++){
				scatter.push([scatterData[i].ws,scatterData[i].number]);
			}
		}
		
		//曲线
		var line = [];
		if($scope.data && $scope.data.powerLineList){
			var lineData = $scope.data.powerLineList;
			for(var i = 0;i<lineData.length;i++){
				line.push(lineData[i].number); 
			}
		}
		//柱形
		var bar = [];
		var x = [];
		if($scope.data && $scope.data.windList){
			var windList = $scope.data.windList;
			for(var i = 0;i<windList.length;i++){
				bar.push(windList[i].number*100);
			}
			
			for(var i = 0;i<windList.length;i++){
				x.push(windList[i].ws);
			} 
		}
		
		initCurve(x,scatter,line,bar);
	}
	
	function initCurve(x,scatter,line,bar){
		myChart = echarts.init(document.getElementById('powerCurve'));
		var x0=0;
		if(x && x.length > 0){
			x0 = x.length-1
		}
		
		option = {
			tooltip : {
		        trigger: 'item',
	  	 	  	formatter: function (params,ticket,callback) {
	  	 	  		if(params.seriesName == "scatter"){
	  	 	  			var res = params.value[0]+'：<br/>';
	  	 	  			res += "散点："+params.value[1]+"kw";
	  	 	  		}else if(params.seriesName == "line"){
	  	 	  			var res = params.name+'：<br/>';
	  	 	  			res += "功率曲线："+params.value+"kw";
	  	 	  		}else if(params.seriesName == "bar"){
	  	 	  			var res = params.name+'：<br/>';
	  	 	  			res += "柱形："+params.value+"%";
	  	 	  		}
	  	 	  		return res;
		      	}
		    },
			grid: {
				borderWidth: '0px',
				x: '40px',
				x2: '40px',
				y: "55px",
				y2: "30px"
			},
			xAxis: [{
	            type : 'value',
	            position:'top',
	            show:false,
	            boundaryGap:false,
	            interval:'1',
	            min:0,
	            max:x0,
	            splitLine: {
	                show: false
	            }
	        },{
				type : 'category',
				position:'bottom',
				splitLine : {
					show : false,
				},
				boundaryGap:false,
				data : x,
	            axisLabel : {
	            	formatter : function (value, index) {
	            	    if (index === (x.length -1)) {
	            	        return value + "m/s";
	            	    }else{
	            	    	return value
	            	    }
	            	}
	            }
			}],
			yAxis: [{
				name:"kW",
				type : 'value',
			},{
				name:"%",
				type : 'value',
			}],
			series: [{
				type:'scatter',
				name:'scatter',
				data:scatter
			},{
				type : 'line',
				name:'line',
				xAxisIndex: 1,
				smooth : true,
				itemStyle : {
					normal : {
						areaStyle : {
							color : 'transparent'
						},
						lineStyle : {
							color : 'rgb(245,102,105)',
							width : 1
						}
					}
				},	
				data : line
			},{
	            type:'bar',
	            name:'bar',
	            barWidth:8,
	          	xAxisIndex: 1,
			    yAxisIndex: 1,
	            itemStyle : {
					normal : {
						color:"rgb(255,205,130)"
					}
				},	
	            data:bar
	        }]
		};
		myChart.setOption(option);
	}
});
</script>
