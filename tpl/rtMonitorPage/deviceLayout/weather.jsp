<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade bs-example-modal-sm" id="weatherModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row ">
		<div class="modal-content ">
			<a class="icon-close modelCloseBtn" data-dismiss="modal"></a>
			<div class="modal-body ">
				<div >
					<div class="text-center wrapper-sm" style="height:250px;background-image: url('${ctx}/theme/images/equipLayOut/weatherBg.jpg');">
						<div class="col-sm-12">
							<font class="pull-left white-2 font-h2 m-b-md m-t-sm" ng-bind="weatherData.today">2015年11月10日  星期二</font>
						</div>
						<div class="col-sm-12 no-padder m-b-sm">
						<div class="col-sm-5 no-padder">
							<font style="color: white;font-size: 82px;line-height:75px" ng-bind="weatherData.ta"></font>
							<font class="white-trans-80" style="font-size: 52px;line-height: 75px">℃</font>
						</div>
						<div class="col-sm-5 white-trans-80 no-padder font-h1" style="margin-top:40px">
						<span class="m-n" ng-bind="weatherData.wd"></span>
						<span ng-bind="weatherData.ws"></span>m/s
						</div>
					</div>
					<div class="col-sm-12 no-padder m-b-sm">
						<div class="col-sm-3 no-padder">
							<font style="color: white;font-size: 26px;"><span ng-bind="weatherData.lh"></span><span>W/㎡</span></font>
							<br>
							<font class="white-trans-80">水平面光照强度</font>
						</div>
						<div class="col-sm-3 no-padder text-center">
								<font style="color: white;font-size: 26px;"><span ng-bind="weatherData.h2o"></span>%<span></span></font>
								<br>
								<font class="white-trans-80" >湿度</font>
						</div>
						<div class="col-sm-3 no-padder text-center">
							<font style="color: white;font-size: 26px;"><span ng-bind="weatherData.p"></span><span>kPa</span></font>
							<br>
							<font class="white-trans-80">气压</font>
						</div>
					</div>	
				</div>
				<div style="height: 150px;padding: 15px 0px">
					<div class="col-sm-12 no-padder m-b-sm font-h black-1 text-center-xs">
					<div class="col-sm-4 no-padder" ng-repeat="vo in next3DayWeatherData">
					<div ng-bind="vo.date"></div>
					<div ng-bind="vo.weather"></div>
					<div><span ng-bind="vo.temperature"></span>℃</div>
					</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>
</div>
<script type="text/javascript">
function drawMonthChart(){
	require.config({
		paths : {
			echarts : 'vendor/echarts'
		}
	});
	require([ 'echarts', 'echarts/chart/pie'], function(ec) {
	var myChart = ec.init(document.getElementById('pie'));
	window.addEventListener("resize", function() {
		//alert(myChart);
		myChart.resize();
	});
	option = {
		    calculable : true,
		    series : [
		        {
		            type:'pie',
		            radius : ['0%', '80%'],
		            itemStyle : {
		                normal : {
		                    label : {
		                        show : false
		                    },
		                    labelLine : {
		                        show : false
		                    }
		                },
		                emphasis : {
		                    label : {
		                        show : true,
		                        position : 'center',
		                        textStyle : {
		                            fontSize : '30',
		                            fontWeight : 'bold'
		                        }
		                    }
		                }
		            },
		            data:[
		                {value:5},
		                {value:95}
		                
		            ]
		        }
		    ]
		};
	myChart.setOption(option);
});
}
</script>
