<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
/* #hoverLeft{width:100%;} */
.tab-left{margin:20px;padding:0}
	.tab-left li{    padding: 4px 10px;cursor: pointer;text-align: center;width: 80px;margin: 0 auto 15px;}
	.tab-left li.active{border:1px solid rgb(0,190,190);color:rgb(0,190,190);border-radius:15px;}
	.tab-right{margin:20px;padding:0}
	.tab-right li{margin-bottom:15px;padding: 4px 10px;    cursor: pointer;    text-align: center;float:right;    width: 80px;}
	.tab-right li.active{border:1px solid rgb(0,190,190);color:rgb(0,190,190);border-radius:15px;}
	#bottom{    border: 1px solid black;z-index:2;margin-bottom:10px;width:98%;
    position: absolute;
    display:none;
    background: white;}
	.left-navi li{    border-bottom: 1px solid rgb(207,207,207); height: 30px;line-height: 30px;text-align: center;}
	.hover-right tr{border-bottom: 1px solid rgb(207,207,207);}
	table td[class*="col-"]{
	    float: left;text-align:center;    border-right: 1px solid rgb(207,207,207);
	}
	table th[class*="col-"] {
	    float: left;text-align:center; 
	}
</style>
<div ng-controller="hoverBottomModelCtrl" ng-mouseleave="mouseleavef()" class="clearfix" >
	<!-- <a class="icon-close modelCloseBtn time black-1" ng-click="hiddenModal()"></a> -->
	<div class="clearfix col-sm-12">
		<div class="col-sm-10  no-padder clearfix" >
			<div class="col-sm-12 clearfix">
				<div id="hoverLeftBottom" style="height:380px;width:100%;"></div>
			</div>
		</div>
		<div class="col-sm-2  no-padder" style="    margin: 50px 0 0 0;">
			<table class="hover-right col-sm-12  no-padder">
				<tr ng-repeat="item in tableDataListDown" class="col-sm-12  no-padder item" repeat-finish>
					<td class="col-sm-4 no-padder">{{item[0]|dataNullFilter}}</td><td class="col-sm-4 no-padder">{{item[1]|dataNullFilter}}</td><td class="col-sm-4 no-padder">{{item[2]|dataNullFilter}}</td>
				</tr>
				<tr class="col-sm-12  no-padder" style="line-height:30px;border:none;">
					<th class="col-sm-4 no-padder">故障率</th><th class="col-sm-4 no-padder">MTBF</th><th class="col-sm-4 no-padder">MTTR</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<script>
var lineHeight;
app.directive('repeatFinish',function(){
    return {
        link: function(scope,element,attr){
            if(scope.$last == true){
            	$(".hover-right tr.item").css("line-height",lineHeight+'px');
            }
        }
    }
})
app.controller('hoverBottomModelCtrl',function($scope, $http, $state, $stateParams) {
	var myChartLeftBottom = echarts.init(document.getElementById('hoverLeftBottom'));
	window.addEventListener("resize", function() {
		myChartLeftBottom.resize();
	});
	
	$scope.mouseleavef=function(){
		$("#bottom").hide();
	};
	
	var regExp =  /^\d{1,}\-1$/;
	$scope.$on("hoverBottomData",function(event,params){
		$scope.data = params;
		eHover();
	});
	
	
	function eHover() {
        hoverLeft();
		hoverRight();
        //$("#bottom").css("top",0);
    }
	function hoverRight(){
		 var tableData = $scope.data.faultValuesList;//数组中每一项中的三个值分别为故障率，MTBF，MTTR
		 $scope.tableDataListDown = [];
		 if(tableData){
			 for(var i = tableData.length-1; i>=0; i--){//倒序
				 $scope.tableDataListDown.push(tableData[i]);
			 }
		 }
	}
	
	function hoverLeft(){
		 /* var hours = ['0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24'];
	     var days = ['偏航', '液压', '叶轮','变桨', '电控'];
	      */
	      /* var data = [[0,0,1],[0,1,1],[0,2,0],[0,3,0],[0,4,0],[0,5,0],[0,6,0],[0,7,0],[0,8,0],[0,9,0],[0,10,0],[0,11,1],[0,12,0],[0,13,1],[0,14,1],[0,15,0],[0,16,0],[0,17,0],[0,18,0],[0,19,1],[0,20,1],[0,21,0],[0,22,1],[0,23,1],
          [1,0,7],[1,1,0],[1,2,0],[1,3,0],[1,4,0],[1,5,0],[1,6,0],[1,7,0],[1,8,0],[1,9,0],[1,10,0],[1,11,0],[1,12,1],[1,13,1],[1,14,1],[1,15,0],[1,16,1],[1,17,0],[1,18,0],[1,19,1],[1,20,1],[1,21,1],[1,22,1],[1,23,1],
          [2,0,1],[2,1,1],[2,2,0],[2,3,0],[2,4,0],[2,5,0],[2,6,0],[2,7,0],[2,8,0],[2,9,0],[2,10,3],[2,11,2],[2,12,1],[2,13,9],[2,14,8],[2,15,10],[2,16,6],[2,17,5],[2,18,5],[2,19,5],[2,20,7],[2,21,4],[2,22,2],[2,23,4]
		]; */
		/*  data = data.map(function (item) {
			    return [item[1], item[0], item[2] || '-'];
			});  */
          var days = $scope.data.subSysNamesList;
		  if(days && days.length > 0){
		     lineHeight = (278/days.length).toFixed(2);
		  }else{
			 days= [];
			 lineHeight =0;
		  }
	      var hours = $scope.data.subSysTimeList;
	      if(!hours){
	    	  hours = [];
	      }
	      var data = $scope.data.subSysValuesList;
	      var newArr = [];
	      if(data){
	    	  for(var i = 0;i<data.length;i++){
		    	  var curItem = data[i];
		    	  var arr = [];
		    	  if(curItem[0] === "" || curItem[0] === null){
		    		  arr.push("-");
		    	  }else{
		    		  arr.push(curItem[0]);
		    	  }
		    	  if(curItem[1] === "" || curItem[1] === null){
		    		  arr.push("-");
		    	  }else{
		    		  arr.push(curItem[1]);
		    	  }
		    	  if(curItem[2] === "" || curItem[2] === null){
		    		  arr.push("-");
		    	  }else{
		    		  arr.push(curItem[2]);
		    	  }
		    	  newArr.push(arr);
		      } 
	      }
	     
		 option = {
				 tooltip : {
						trigger : 'item',
						axisPointer : {
							type : 'line',
							lineStyle : {
								color : '#bbb',
								width : 1,
								type : 'solid'
							}
						},
						 formatter: function (params,ticket,callback) {
							 	var res = params.name+'<br/>';
							 	var status = "正常";
							 	if(params.value[2] == 1){
							 		status = "故障";
							 	}
					            res += '状态：'+status+'<br/>'
					            return res; 
					      }
				    },
			    animation: false,
			    grid : {
					x : '60px',
					x2 : '0px',
					y : "50px",
					y2 : "50px"
				},
			    xAxis: {
			        type: 'category',
			        data: hours,
			        axisLabel :{  
			        	formatter:function(val,index) {
			        		var newAxis = [];
			        		var dateType = $scope.dataType;
			        		if(dateType == "month"){
			        			return val;
			        		}else if(dateType == "year"){
			        			 if(regExp.test(val)){
									return val;
			        			} 
			        		}
			             },
			             interval : 0
			        },
			        axisTick:{show:false},
			        splitArea: {
			            show: true,
			        }
			    },
			    yAxis: {
			        type: 'category',
			        data: days,
			        splitArea: {
			            show: true
			        }
			    },
			    visualMap: {
			        min: 0,
			        max: 1,
			        calculable: true,
			        orient: 'horizontal',
			        left: 'center',
			        bottom: '15%',
			        show:false
			    },
			    series: [{
			        name: 'Punch Card',
			        type: 'heatmap',
			        data: newArr,
			    }]
		};
		myChartLeftBottom.resize();
		myChartLeftBottom.setOption(option);
		
	}
	//关闭弹出层
	$scope.hiddenModal=function(){
		$("#bottom").hide();
	};
});
</script>
