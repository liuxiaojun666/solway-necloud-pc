<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<div>
	<div class="wrapper-md ng-scope" id="main">

		<div class="panel panel-default">
			<div class="row wrapper">
				<div class="col-sm-12 no-padder">
					<div class="col-sm-9  no-padder">
					<div class="col-lg-1">
					<font class="black-1 font-h2">时间</font>
					</div>
 						<div class="col-lg-3">
 							<input type="text" id="expectedtime" name="expectedtime" class="form-control formData" data-date-format="yyyy-mm">
             			</div>
							<span class="input-group-btn">
								<button class="btn btn-sm btn-info" onclick="search();"
									type="button">查询</button>
							</span>
						</div>
						
						<div  class="input-group p-r-sm" style="float: left;">
						<input class="btn btn-sm btn-info" type="button" value="按月显示" onclick="month();">
						<input class="btn btn-sm btn-info" type="button" value="按站显示" onclick="station();">
						</div>
					</div>
				</div>
			</div>
				<div id="monthChart" style="height: 600px;text-align: center;">
					<span id="title1" class="black-2 font-h1"></span>
					<br>
					<div id="11" style="width: 50%;height: 300px;float: left;" ></div>
					<div id="12" style="width: 50%;height: 300px;float: left;" ></div>
					<div id="13" style="width: 50%;height: 300px;float: left;" ></div>
					<div id="14" style="width: 50%;height: 300px;float: left;" ></div>
				</div>
				<div id="stationChart" style="height: 600px;text-align: center;">
					<span id="title2" class="black-2 font-h1"></span>
					<br>
					<div id="21" style="width: 50%;height: 300px;float: left;" ></div>
					<div id="22" style="width: 50%;height: 300px;float: left;" ></div>
					<div id="23" style="width: 50%;height: 300px;float: left;" ></div>
					<div id="24" style="width: 50%;height: 300px;float: left;" ></div>
				</div>
			</div>
		</div>
<script>
var d = new Date();
$('#expectedtime').val((d.getYear()+1900)+"-"+(d.getMonth()+1));
$('#expectedtime').datetimepicker({
	format: "yyyy-mm",startView:3,minView:3,todayBtn:true,language: 'zh-CN',
   	autoclose: true
});
var width = $("#main").width();
$("#monthChart").width(width);
$("#stationChart").width(width);
$("#11").width(width/2);
$("#12").width(width/2);
$("#13").width(width/2);
$("#14").width(width/2);
$("#21").width(width/2);
$("#22").width(width/2);
$("#23").width(width/2);
$("#24").width(width/2);
$("#stationChart").hide();
$("#title1").html($('#expectedtime').val()+"月故障损失分析");
$("#title2").html($('#expectedtime').val()+"月各电站故障损失分析");
//$('#expectedtime').SetFormat("yyyy-MM");
	search();
	//getYears();
	// 路径配置
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
	function month(){
		var width = $("#main").width();
		$("#monthChart").show();
		$("#monthChart").width(width);
		$("#stationChart").hide();
	}
	function station(){
		var width = $("#main").width();
		$("#monthChart").hide();
		$("#stationChart").width(width);
		$("#stationChart").show();
	}
	function search(){
		if($('#expectedtime').val()!=""){
		$.ajax({
			type:"post",
			url:"${ctx}/FaultLossAnalysis/getFaultLossData.htm",
			data:{
			"time":$('#expectedtime').val(),	
			},
			success:function(msg){
				drawMonthChart11(msg);
				drawMonthChart12(msg);
				drawMonthChart13(msg);
				drawMonthChart14(msg);
				drawStationChart21(msg);
				drawStationChart22(msg);
				drawStationChart23(msg);
				drawStationChart24(msg);
				//drawStationChart(msg);
			},error : function(json) {
				//alert("保存失败,请稍后重试!");
			} 
		});
		}
	}
	//获取年份
	function getYears(){
	   $("#year").empty();
	   var d=new Date();
       var endYear= d.getFullYear();
       var startYear= endYear-10;
       var str="";
       for(var i=startYear ; i<=endYear ; i++){
			str = str + "<option value='"+i+"'>"+i+"</option>";
	   }
	   $("#year").append(str);
	   $("#year").val(endYear);
	   $("#month").val((d.getMonth()+1));
	   
	}
	function drawMonthChart11(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('11'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障设备台数']
				    },
				    calculable : true,
					grid : {
							x : 30,
							y : 40,
							x2 : 30,
							y2 : 40
						},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series11.name,
				            type:'bar',
				            data:faultDatas.series11.data,
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawMonthChart12(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('12'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				 
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障停机小时']
				    },
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series12.name,
				            type:'bar',
				            data:faultDatas.series12.data,
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawMonthChart13(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('13'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				   
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障损失电量']
				    },
				    calculable : true,
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series13.name,
				            type:'bar',
				            data:faultDatas.series13.data,
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawMonthChart14(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('14'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
			
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障率']
				    },
				    calculable : true,
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series14.name,
				            type:'bar',
				            data:faultDatas.series14.data,
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawStationChart21(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('21'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障设备台数']
				    },
				    calculable : true,
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis2
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series21.name,
				            type:'bar',
				            data:faultDatas.series21.data,
				            barMaxWidth:50
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawStationChart22(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('22'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障停机小时']
				    },
				    calculable : true,
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis2
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series22.name,
				            type:'bar',
				            data:faultDatas.series22.data,
				            barMaxWidth:50
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawStationChart23(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('23'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障损失电量']
				    },
				    calculable : true,
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis2
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series23.name,
				            type:'bar',
				            data:faultDatas.series23.data,
				            barMaxWidth:50
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
	function drawStationChart24(faultDatas){
		require([ 'echarts', 'echarts/chart/bar', 'echarts/chart/line'], function(ec) {
			var myChart = ec.init(document.getElementById('24'));
			window.addEventListener("resize", function() {
				//alert(myChart);
				myChart.resize();
			});
			option = {
				    tooltip : {
				        trigger: 'axis'
				    },
				    legend: {
				        data:['故障率']
				    },
				    calculable : true,
					grid : {
						x : 30,
						y : 40,
						x2 : 30,
						y2 : 40
					},
				    xAxis : [
				        {
				            type : 'category',
				            data : faultDatas.xAxis2
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : [
				        {
				            name:faultDatas.series24.name,
				            type:'bar',
				            data:faultDatas.series24.data,
				            barMaxWidth:50
				        }
				    ]
				};
			myChart.setOption(option);
		});
	}
</script>
