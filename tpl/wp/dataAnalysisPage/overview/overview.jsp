<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="./theme/css/wp/dataAnalysisPage/overview.css">
<div  ng-controller="wpOverviewCtrl">
	<div class="overview-title" >
		<div class="clearfix">
			<div class="pull-left">
				<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
				<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
			</div>
		</div>
	</div>
	<div class="clearfix wp-container">
		<!-- 1  -->
		<div class="pull-left item" ng-click="showDetail('00')">
			<div class="item-title item1">
				<img alt="" src="./theme/images/wp/dataAnalysis/overview/icon1.png" style="margin-bottom: 5px;">
				<span>电量</span>
			</div>
			<div class="clearfix info-con">
				<div class="pull-left">
					<p class="info-title">发电量</p>
					<p class="info-num">{{weatherData.real_kwh[0]|dataNullFilter}}</p>
					<p class="info-unit">{{weatherData.real_kwh[1]|dataNullFilter}}</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.real_kwh_pr && weatherData.real_kwh_pr < 0),'up-line':(weatherData.real_kwh_pr && weatherData.real_kwh_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.real_kwh_pr && weatherData.real_kwh_pr < 0),'up-percent':(weatherData.real_kwh_pr && weatherData.real_kwh_pr >= 0)}">
						{{weatherData.real_kwh_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.real_kwh_pr && weatherData.real_kwh_pr < 0),'green':(weatherData.real_kwh_pr && weatherData.real_kwh_pr >= 0)}"></span>
					</p>
				</div>
				<div class="pull-right">
					<p class="info-title">限电量</p>
					<p class="info-num">{{weatherData.restrict_kwh|dataNullFilter}}</p>
					<p class="info-unit">kWh</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.restrict_kwh_pr && weatherData.restrict_kwh_pr < 0),'up-line':(weatherData.restrict_kwh_pr && weatherData.restrict_kwh_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.restrict_kwh_pr && weatherData.restrict_kwh_pr < 0),'up-percent':(weatherData.restrict_kwh_pr && weatherData.restrict_kwh_pr >= 0)}">
						{{weatherData.restrict_kwh_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.restrict_kwh_pr && weatherData.restrict_kwh_pr < 0),'green':(weatherData.restrict_kwh_pr && weatherData.restrict_kwh_pr >= 0)}"></span>
					</p>
				</div>
			</div>
		</div>
		<!-- 2  -->
		<div class="pull-left item" ng-click="showDetail('10')">
			<div class="item-title item2">
				<img alt="" src="./theme/images/wp/dataAnalysis/overview/icon2.png" style="margin-bottom: 5px;">
				<span>资源</span>
			</div>
			<div class="clearfix info-con">
				<div class="pull-left">
					<p class="info-title">平均风速</p>
					<p class="info-num">{{weatherData.ws_avg.toFixed(2)|dataNullFilter}}</p>
					<p class="info-unit">m/s</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.ws_avg_pr && weatherData.ws_avg_pr < 0),'up-line':(weatherData.ws_avg_pr && weatherData.ws_avg_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.ws_avg_pr && weatherData.ws_avg_pr < 0),'up-percent':(weatherData.ws_avg_pr && weatherData.ws_avg_pr >= 0)}">
						{{weatherData.ws_avg_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.ws_avg_pr && weatherData.ws_avg_pr < 0),'green':(weatherData.ws_avg_pr && weatherData.ws_avg_pr >= 0)}"></span>
					</p>
				</div>
				<div class="pull-right">
					<p class="info-title">有效风速</p>
					<p class="info-num">{{weatherData.ews_avg.toFixed(2)|dataNullFilter}}</p>
					<p class="info-unit">m/s</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.ews_avg_pr && weatherData.ews_avg_pr < 0),'up-line':(weatherData.ews_avg_pr && weatherData.ews_avg_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.ews_avg_pr && weatherData.ews_avg_pr < 0),'up-percent':(weatherData.ews_avg_pr && weatherData.ews_avg_pr >= 0)}">
						{{weatherData.ews_avg_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.ews_avg_pr && weatherData.ews_avg_pr < 0),'green':(weatherData.ews_avg_pr && weatherData.ews_avg_pr >= 0)}"></span>
					</p>
				</div>
			</div>
		</div>
		<!-- 3  -->
		<div class="pull-left item" ng-click="showDetail('20')">
			<div class="item-title item3">
				<img alt="" src="./theme/images/wp/dataAnalysis/overview/icon3.png" style="margin-bottom: 5px;">
				<span>生产</span>
			</div>
			<div class="clearfix info-con">
				<div class="pull-left">
					<p class="info-title">发电任务</p>
					<div class="info-num">
						<span style="margin-right:10px;">{{weatherData.finish_r|dataNullFilter}}%</span>
						<div style="position:relative;    display: inline-block;">
							<img alt="" src="./theme/images/wp/dataAnalysis/overview/ask.png" id="ask">
							<div class="hover-alert">
								<p>年计划发电量</p>
								<p class="num">{{weatherData.shd_kwh[0]|dataNullFilter}}{{weatherData.shd_kwh[1]|dataNullFilter}}</p>
								<p>年实际发电量</p>
								<p class="num">{{weatherData.real_kwh[0]|dataNullFilter}}{{weatherData.real_kwh[1]|dataNullFilter}}</p>
							</div>
						</div>
					</div>
					<p class="info-unit"></p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.finish_r_pr && weatherData.finish_r_pr < 0),'up-line':(weatherData.finish_r_pr && weatherData.finish_r_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.finish_r_pr && weatherData.finish_r_pr < 0),'up-percent':(weatherData.finish_r_pr && weatherData.finish_r_pr >= 0)}">
						{{weatherData.finish_r_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.finish_r_pr && weatherData.finish_r_pr < 0),'green':(weatherData.finish_r_pr && weatherData.finish_r_pr >= 0)}"></span>
					</p>
				</div>
				<div class="pull-right">
					<p class="info-title">技改任务</p>
					<p class="info-num">{{weatherData.t_finish_r|dataNullFilter}}%</p>
					<p class="info-unit"></p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.t_finish_r && weatherData.t_finish_r < 0),'up-line':(weatherData.t_finish_r && weatherData.t_finish_r >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.t_finish_r && weatherData.t_finish_r < 0),'up-percent':(weatherData.t_finish_r && weatherData.t_finish_r >= 0)}">
						{{weatherData.finish_r_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.t_finish_r && weatherData.t_finish_r < 0),'green':(weatherData.t_finish_r && weatherData.t_finish_r >= 0)}"></span>
					</p>
				</div>
			</div>
		</div>
		<!-- 4  -->
		<div class="pull-left item" ng-click="showDetail('30')">
			<div class="item-title item4">
				<img alt="" src="./theme/images/wp/dataAnalysis/overview/icon4.png" style="margin-bottom: 5px;">
				<span>运行</span>
			</div>
			<div class="clearfix info-con">
				<div class="pull-left">
					<p class="info-title">高效运行占比</p>
					<p class="info-num">{{weatherData.fail_r|dataNullFilter}}</p>
					<p class="info-unit">次</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.h_oper_r_pr && weatherData.h_oper_r_pr < 0),'up-line':(weatherData.h_oper_r_pr && weatherData.h_oper_r_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.h_oper_r_pr && weatherData.h_oper_r_pr < 0),'up-percent':(weatherData.h_oper_r_pr && weatherData.h_oper_r_pr >= 0)}">
						{{weatherData.h_oper_r_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.h_oper_r_pr && weatherData.h_oper_r_pr < 0),'green':(weatherData.h_oper_r_pr && weatherData.h_oper_r_pr >= 0)}"></span>
					</p>
				</div>
				<div class="pull-right">
					<p class="info-title">PBA</p>
					<p class="info-num">{{weatherData.pba.toFixed(2)|dataNullFilter}}%</p>
					<p class="info-unit"></p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.pba_pr && weatherData.pba_pr < 0),'up-line':(weatherData.pba_pr && weatherData.pba_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.pba_pr && weatherData.pba_pr < 0),'up-percent':(weatherData.pba_pr && weatherData.pba_pr >= 0)}">
						{{weatherData.pba_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.pba_pr && weatherData.pba_pr < 0),'green':(weatherData.pba_pr && weatherData.pba_pr >= 0)}"></span>
					</p>
				</div>
			</div>
		</div>
		<!-- 5  -->
		<div class="pull-left item" ng-click="showDetail('40')">
			<div class="item-title item5">
				<img alt="" src="./theme/images/wp/dataAnalysis/overview/icon5.png" style="margin-bottom: 5px;">
				<span>费用</span>
			</div>
			<div class="clearfix info-con">
				<div class="pull-left">
					<p class="info-title">收入</p>
					<p class="info-num">{{weatherData.income|dataNullFilter}}</p>
					<p class="info-unit">万元</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.income_pr && weatherData.income_pr < 0),'up-line':(weatherData.income_pr && weatherData.income_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.income_pr && weatherData.income_pr < 0),'up-percent':(weatherData.income_pr && weatherData.income_pr >= 0)}">
						{{weatherData.income_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.income_pr && weatherData.income_pr < 0),'green':(weatherData.income_pr && weatherData.income_pr >= 0)}"></span>
					</p>
				</div>
				<div class="pull-right">
					<p class="info-title">支出</p>
					<p class="info-num">{{weatherData.pay|dataNullFilter}}</p>
					<p class="info-unit">万元</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.pay_pr && weatherData.pay_pr < 0),'up-line':(weatherData.pay_pr && weatherData.pay_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.pay_pr && weatherData.pay_pr < 0),'up-percent':(weatherData.pay_pr && weatherData.pay_pr >= 0)}">
						{{weatherData.pay_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.pay_pr && weatherData.pay_pr < 0),'green':(weatherData.pay_pr && weatherData.pay_pr >= 0)}"></span>
					</p>
				</div>
			</div>
		</div>
		<!-- 6  -->
		<div class="pull-left item" ng-click="showDetail('50')">
			<div class="item-title item6">
				<img alt="" src="./theme/images/wp/dataAnalysis/overview/icon4.png" style="margin-bottom: 5px;">
				<span>故障</span>
			</div>
			<div class="clearfix info-con">
				<div class="pull-left">
					<p class="info-title">故障率</p>
					<p class="info-num">{{weatherData.fail_r|dataNullFilter}}</p>
					<p class="info-unit">次</p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.fail_r_pr && weatherData.fail_r_pr < 0),'up-line':(weatherData.fail_r_pr && weatherData.fail_r_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.fail_r_pr && weatherData.fail_r_pr < 0),'up-percent':(weatherData.fail_r_pr && weatherData.fail_r_pr >= 0)}">
						{{weatherData.fail_r_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.fail_r_pr && weatherData.fail_r_pr < 0),'green':(weatherData.fail_r_pr && weatherData.fail_r_pr >= 0)}"></span>
					</p>
				</div>
				<div class="pull-right">
					<p class="info-title">可利用率</p>
					<p class="info-num">{{weatherData.available_r|dataNullFilter}}%</p>
					<p class="info-unit"></p>
					<hr class="orientation-line" ng-class="{'down-line':( weatherData.available_r_pr && weatherData.available_r_pr < 0),'up-line':(weatherData.available_r_pr && weatherData.available_r_pr >= 0)}"/>
					<p class="percent" ng-class="{'down-percent':( weatherData.available_r_pr && weatherData.available_r_pr < 0),'up-percent':(weatherData.available_r_pr && weatherData.available_r_pr >= 0)}">
						{{weatherData.available_r_pr|dataNullFilter}}%
						<span class="arrow-con" ng-class="{'red':( weatherData.available_r_pr && weatherData.available_r_pr < 0),'green':(weatherData.available_r_pr && weatherData.available_r_pr >= 0)}"></span>
					</p>
				</div>
			</div>
		</div>
	</div>
	<div data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/modal/powerModal.jsp'"></div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div> 
<script>
app.controller('wpOverviewCtrl',function($scope, $http, $state, $stateParams) {
	$scope.getCurrentDataName('02',0);
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
    });
	
	$scope.showPowerIndexData="tpl/wp/dataAnalysisPage/overview/model/curveDetailModel.jsp";//弹框模板
	
	init();
	function init(){
		$http({
			method : "POST",
			url : "./WPOverView/getStationOverviewInfo.htm"
		})
		.success(function (msg) {
			$scope.weatherData = msg;
		}).error(function(msg){
		}); 
	}
	$("#ask").hover(function(){
		$(".hover-alert").show();
	},function(){
		$(".hover-alert").hide();
	});
	
	//点击弹框
	$scope.showDetail = function(type){
		$scope.$broadcast("detailType",type);//传参数类型（00，01..）
		$('#powerIndexModal').modal();
	}
	
	
	//关闭弹出层
	$scope.hiddenModal=function(){
		$('#powerIndexModal').modal("hide");
	};
});

</script>
