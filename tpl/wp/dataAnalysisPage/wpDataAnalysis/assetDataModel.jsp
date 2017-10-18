<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="dataAnalysis-con" ng-controller="wpAssetDataModelCtrl">
	<div class="score">
		<div class="score-circle">{{data.togetherScore|dataNullFilter|limitTo:4}}</div>
		<p class="score-title">综合得分</p>
		<p class="score-params">{{data.descStr|dataNullFilter}}</p>
	</div>
	<div class="evaluate-detail">
		<div class="graph">
			<div ng-include="'${ctx}/tpl/wp/dataAnalysisPage/wpDataAnalysis/assess.jsp'"></div>
		</div>
		<div class="detail-center">
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{self.real_hours_score|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">发电小时数</p>
					<p class="p-detail">{{self.real_hours_desc|dataNullFilter}}</p>
				</div>
			</div>
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{self.mttr_score|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">MTTR</p>
					<p class="p-detail">{{self.mttr_desc|dataNullFilter}}</p>
				</div>
			</div>
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{self.pba_score|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">PBA</p>
					<p class="p-detail">{{self.pab_desc|dataNullFilter}}</p>
				</div>
			</div>
		</div>
		<div class="detail-right">
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{self.wind_resource_score|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">风资源</p>
					<p class="p-detail">{{self.wind_resource_desc|dataNullFilter}}</p>
				</div>
			</div>
			<div class="clearfix">
				<div class="num-con col-sm-2 no-padder">
					<span class="circle-num">{{self.mtbf_score|dataNullFilter}}</span>
				</div>
				<div class="col-sm-10 no-padder">
					<p class="p-title">MTBR</p>
					<p class="p-detail">{{self.mtbf_desc|dataNullFilter}}</p>
				</div>
			</div>
		</div>
	</div>
	<div class="table-data">
		<table  class="table  table-striped b-t b-light bg-table">
			<thead>
				<th class="text-center"></th>
				<th class="text-center">风资源</th>
				<th class="text-center">发电小时数</th>
				<th class="text-center">PBA</th>
				<th class="text-center">MTBF</th>
				<th class="text-center">MTTR</th>
			</thead>
			<tbody >
				<tr>
					<td class="text-center">
						 <span>自身</span>
					</td>
					<td class="text-center">
						 <span>{{self.wind_resource_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{self.real_hours_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{self.pba_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{self.mtbf_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{self.mttr_score|dataNullFilter}}</span>
					</td>
				</tr>
				<tr>
					<td class="text-center">
						 <span>城市平均</span>
					</td>
					<td class="text-center">
						 <span>{{city.wind_resource_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{city.real_hours_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{city.pba_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{city.mtbf_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{city.mttr_score|dataNullFilter}}</span>
					</td>
				</tr>
				<tr>
					<td class="text-center">
						 <span>方圆50</span>
					</td>
					<td class="text-center">
						 <span>{{area.wind_resource_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{area.real_hours_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{area.pba_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{area.mtbf_score|dataNullFilter}}</span>
					</td>
					<td class="text-center">
						 <span>{{area.mttr_score|dataNullFilter}}</span>
					</td>
				</tr>
			</tbody>
	</table>
	</div>
</div>

<script>
app.controller('wpAssetDataModelCtrl',function($scope, $http, $state, $stateParams) {

	//初始化数据(日)
	var rightDay = new Date();
	rightDay.setDate(rightDay.getDate() - 1);
	$scope.dtime = rightDay.Format("yyyy-MM");
	$scope.dataType = "month";
	
	$scope.$on('broadChangeDate', function(event, data) {
		if(data){
			$scope.dataType = data.dataType;
			$scope.dtime = data.dtime;
			getData();
		}
	});
	
	$scope.$on('broadcastSwitchStation', function(event, data) {
		getData();
    });
	
	getData();
	//页面数据
	function getData(){
		var dtime,dateType;
		switch($scope.dataType){
			case "day" :dtime = new Date($scope.dtime).Format("yyyy-MM-dd");
						dateType = 'd'
				break;
			case "month" : dtime = new Date($scope.dtime).Format("yyyy-MM");
							dateType = 'm'
				break;
			case "year" : dtime = new Date($scope.dtime).Format("yyyy");
							dateType = 'y'
				break;
			case "total" :dtime = '';
						dateType = 'a'
				break;
			default:
				dtime = new Date($scope.dtime).Format("yyyy-MM");
		}
		$http({
			method : "POST",
			url : "./WPEstimate/getStationEstimateInfo.htm",
			params : {
				'dtime':dtime,
				'model':dateType
			}
		})
		.success(function (msg) {
			$scope.data = msg;
			
			if(msg.targetInfo != null){
				$scope.selfData = msg.targetInfo.self;
				renderTable(msg.targetInfo);
				broadcastRadar(msg.targetInfo);
			}
			
		}).error(function(msg){
		}); 
	};
	
	//table的数据填充
	function renderTable(data){
		$scope.self = data.self;
		$scope.city = data.city;
		$scope.area = data.area;
	};
	//给雷达图子页面传值
	function broadcastRadar(data){
		 $scope.$broadcast('broadRadar',data);
	}
});

</script>
