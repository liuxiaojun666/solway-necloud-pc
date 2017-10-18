<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/base.css"/>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>   
 <script type="text/javascript">   
 

//页面加载,默认查询客户日统计信息 
$(function(){
	var date = new Date();
	var year=date.getFullYear();
	var newMonth=date.getMonth()+1;
	var month;
	$("#form_year").val(year);
	if(newMonth<10){
	month="0"+newMonth
	}else{
	month=newMonth	
	}
	$("#form_month").val(month);
	var busidate=year+"-"+month;
 	var param={"busidate":"%"+busidate+"%","companyid":"1"};
	var url="${ctx}/analysis/customerDay.htm";
	readSuccess(param,url,0);
})

//日期拼装方法
function mergeYearMonth(year,month){
	var busidate=year+newMonth
	var newMonth;
	if(month+1<10){
	newMonth="0"+month;
	}else{
	newMonth=month;	
	}
	return busidate;
}


function readSuccess(param,url,sign){
   	$.ajax({
		async : false,
		type : "POST",
		data : param ,
		dataType : "JSON",
		url :url ,
		beforeSend : function() {
		},
		success : function(result) {
			if(sign==2){
			formatPigData(result)	
			}else{
			formBartData(result,sign);
			}
		},
		error : function() {
		}
	});
}	  


//格式化柱形图需要数据
function formBartData(json,sign){
	var companyname=new Array();
	var delecv=new Array();
	var dforecastelecv=new Array();
	var pstationname=new Array();
	var busidate=new Array();
	for(var i= 0;i<json.length;i++){
		companyname[i]=json[i].companyname
		delecv[i]=json[i].delecv
		dforecastelecv[i]=json[i].dforecastelecv
		pstationname[i]=json[i].pstationname
		var date=new Date(json[i].busidate);
		var newMonth;
		if(date.getMonth()<10 && date.getDate()<10){
			newMonth="0"+date.getMonth();
			newDay="0"+date.getDate();
		}else{
			newMonth=date.getMonth();
			newDay=date.getDate();
		}
		busidate[i]=date.getFullYear()+"-"+newMonth+"-"+newDay;
	}
	if(sign==0){
		getCustomerBar(busidate,companyname,delecv,dforecastelecv);
	}else{
		getPowerBar(pstationname,delecv,dforecastelecv);
	}
}



function formatPigData(json){
	var companyname=new Array();
	for(var i= 0;i<json.length;i++){
		companyname[i]=json[i]
	}
	 getCharPowerPie(companyname);
	
}


	//柱形图点击事件
	function showPowerChart(companyname){
			var year=$("#form_year").val();
			var month=$("#form_month").val();
			var busidate=year+"-"+month;
		if(year !=null && month !=null){
			//电站柱形图
			var param={"companyname":companyname,"busidate":"%"+busidate+"%"};
			var url="${ctx}/analysis/PowerStationDay.htm";	
			readSuccess(param,url,1);
			
			//电站饼图
			var paramPig={"companyname":companyname,"busidate":"%"+busidate+"%"};
			var urlPig="${ctx}/analysis/powerStationDayPie.htm";	
			readSuccess(paramPig,urlPig,2);
			
		}else{
			//电站柱形图
			var param={"companyname":companyname,"busidate":"%"+busidate+"%"};
			var url="${ctx}/analysis/powerstation.htm";	
			readSuccess(param,url,1);
			
			//电站饼图
			var paramPig={"companyname":companyname,"busidate":"%"+busidate+"%"};
			var urlPig="${ctx}/analysis/powerstation.htm";	
			readSuccess(paramPig,urlPig,2);
		}	
	}
	 
	
	//日期控件 年
	$('.form_year').datetimepicker({
		language: 'zh-CN',
		format:"yyyy",
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 4,
		minView: 4,
		forceParse: 0
	});	
	
	//日期控件 月
	$('.form_month').datetimepicker({
		language: 'zh-CN',
		format:"mm",
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 3,
		minView: 3,
		forceParse: 0
	});	
	
	// 日期点击控件
	$("#dateButton").click(
			function(){	
			var year=$("#form_year").val();
			var month=$("#form_month").val();
			var busidate = year+"-"+month;
			//if 日查询  月查询
			if(year !=null && month !=null){
				param={"busidate":"%"+busidate+"%","companyid":"1"};
				var url="${ctx}/analysis/customerDay.htm"
					readSuccess(param,url,0)
			}else{
				var param= {"companyname":companyname,"busidate":"%"+busidate+"%"};
				var url="${ctx}/analysis/customerDay.htm"
					readSuccess(param,url,1)
			}
			}
		   )
	

// 引入echars		   
	function getCustomerBar(busidate,companyname,delecv,dforecastelecv){
        // 路径配置
        require.config({
            paths: {
            	echarts : 'vendor/echarts'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('chartbar')); 
                	myChart.on('click',function(param){
                		showPowerChart(param.name);
                	});
            	option = {
            			title : {
            				text : '厂区日发电量'
            			},
        				tooltip : {
        					show : true,
        					trigger : 'tem'
        				},
        				legend : {
        					orient : 'horizontal',
        					data : [ '预测发电量', '实际发电量' ],
        					x : 'right',
        				},
        				grid : {
        					borderWidth : '0px',
        					x : '30px',
        					x2 : '30px',
        					y2 : "20px"
        				},
        				calculable : true,
        				xAxis : [ {
        					type : 'category',
        					axisLine : {
        						lineStyle : {
        							color : '#cccccc'
        						}
        					},
        					splitLine : {
        						show : false
        					},
        					data : busidate
        				}, {
        					type : 'category',
        					axisLine : {
        						lineStyle : {
        							color : '#cccccc'
        						}
        					},
        					splitLine : {
        						show : false
        					},
        					data : companyname
        				} ],
        				yAxis : [ {
        					type : 'value',
        					axisLine : {
        						lineStyle : {
        							color : '#cccccc'
        						}
        					},
        					splitLine : {
        						show : false
        					},
        				} ],
        				series : [ {
        					name : '实际发电量',
        					type : 'bar',
        					//xAxisIndex:0,
        					barWidth : 30,
        					itemStyle : {
        						normal : {
        							color : function(params) {
        								return '#ABD87B'
        							}
        						}
        					},
        					//stack : '总量',
        					data : delecv
        				}, {
        					name : '预测发电量',
        					type : 'bar',
        					xAxisIndex : 1,
        					barWidth : 30,
        					itemStyle : {
        						normal : {
        							color : function(params) {
        								return '#ffc400'
        							}
        						}
        					},
        					//stack : '总量',
        					data : dforecastelecv,
        					markLine : {
        						data : [ {
        							type : 'average',
        							name : '平均值',
        							itemStyle : {
        								normal : {
        									lineStyle : {
        										type : 'solid',
        										color : '#e74c3c'
        									}
        								}
        							}
        						} ]
        					}
        				} ]
        			};
        			myChart.setOption(option);
            }
        );
		
	}	
	
	
	
//电站发电量        
	function getPowerBar(pstationname,delecv,dforecastelecv){
	require([ 'echarts', 'echarts/chart/bar' ], function(ec) {
		var myChart = ec.init(document.getElementById('charTbarPower'));
		window.addEventListener("resize", function() {
			//alert(myChart);
			myChart.resize();
		});
		option = {
			title : {
				text : '电站发电量'
			},
			tooltip : {
				show : true,
				trigger : 'item'
			},
			legend : {
				orient : 'vertical',
				data : [ '预测发电量', '实际发电量' ],
				x : 'right',
			},
			grid : {
				borderWidth : '0px',
				x : '30px',
				x2 : '30px'
			},
			calculable : true,
			xAxis : [ {
				type : 'category',
				axisLine : {
					lineStyle : {
						color : '#cccccc'
					}
				},
				splitLine : {
					show : false
				},
				data :pstationname
			} ],
			yAxis : [ {
				type : 'value',
				axisLine : {
					lineStyle : {
						color : '#cccccc'
					}
				},
				splitLine : {
					show : false
				},
			} ],
			series : [ 
			{
				name : '实际发电量',
				type : 'bar',
				barWidth : 30,
				itemStyle : {
					normal : {
						color : function(params) {
							return '#ABD87B'
						}
					}
				},
				stack : '总量',
				data : delecv
			}, {
				name : '预测发电量',
				type : 'bar',
				itemStyle : {
					normal : {
						color : function(params) {
							return '#ffc400'
						}
					}
				},
				stack : '总量',
				data : dforecastelecv,
			} ]
		};
		myChart.setOption(option);
    }
    );
		}
  
  
  
function getCharPowerPie(companyname){
          
  	require([ 'echarts', 'echarts/chart/pie' ], function(ec) {
  		var myChart = ec.init(document.getElementById('chartPie'));
  		window.addEventListener("resize", function() {
  			//alert(myChart);
  			myChart.resize();
  		});
  		option = {
  			    title : {
  			        text: '电站日发电量',
  			        subtext: '电站',
  			        x:'center'
  			    },
  			    tooltip : {
  			        trigger: 'item',
  			        formatter: "{a} <br/>{b} : {c} ({d}%)"
  			    },
  			    legend: {
  			        orient : 'vertical',
  			        x : 'left',
  			        data:['大唐电站','湖北电站','陕西电站','河南电站','上海电站 ']
  			    },
  			    toolbox: {
  			        show : true,
  			        feature : {
  			            mark : {show: true},
  			            dataView : {show: true, readOnly: false},
  			            magicType : {
  			                show: true, 
  			                type: ['pie', 'funnel'],
  			                option: {
  			                    funnel: {
  			                        x: '25%',
  			                        width: '50%',
  			                        funnelAlign: 'left',
  			                        max: 1548
  			                    }
  			                }
  			            },
  			            restore : {show: true},
  			            saveAsImage : {show: true}
  			        }
  			    },
  			    calculable : true,
  			    series : [
  			        {
  			            name:'访问来源',
  			            type:'pie',
  			            radius : '55%',
  			            center: ['50%', '60%'],
  			            data:companyname
  			        }
  			    ]
  			};
  		myChart.setOption(option);
      }
      );
      }  
 
            
    </script>
  
    <div class="col-sm-6 col-sm-offset-6 no-padder">
    	<div class="form-group pull-right col-sm-10 no-padder m-t-sm">
    		<div class="col-sm-6">
    			<!-- <label for="dtp_input2" class="col-sm-2 control-label"></label> -->
	      		<div class="input-group date form_date  form_year" data-date="" >
	      			<input class="form-control" id="form_year" size="16" type="text" value="" readonly>
	       			<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	            </div>
    		</div>
			<div class="col-sm-6">
	           <div class="input-group date form_date  form_month" data-date="" >
	      			<input class="form-control" id="form_month" size="16" type="text" value="" readonly>
	       			<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
			        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
	           </div>
           </div>
		    <button class="btn btn-sm col-sm-6 col-sm-offset-6 m-t-sm btn-info" id="dateButton" type="button">查询</button>
		</div>	
    </div>

<div id="main" class="col-sm-12 ">
   <div id="chartbar" style="height:400px;"></div>
   <div style="height:50px;"></div>
   <div id="charTbarPower" style="height:400px;" class="col-sm-6 "></div>
   <div id="chartPie" style="height:400px;"  class="col-sm-6 "></div>
</div>
<div>
</div>


		
		
										
