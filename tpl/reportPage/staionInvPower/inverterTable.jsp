<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="col-sm-12  divshadow panel wrapper-xs m-n" style="padding-top:0px">
	<div class="col-sm-12 no-padder tab-bordered " ng-controller="inverterTableCtrl">
		<div ng-include="inverterTotleM" load-done="finishInverterModal()"></div>
		<table class="table table-striped  b-light bg-table">
			<thead>
				<th class="text-center">排名</th>
				<th class="text-center">逆变器</th>
				<th class="text-center">设计/接入容器</th>
				<th class="text-center">实发/应发电量</th>
				<th class="text-center">本期</th>
				<th class="text-center">PBA上期</th>
				<th class="text-center">去年同期</th>
				<th class="text-center">本期</th>
				<th class="text-center">PR上期</th>
				<th class="text-center">去年同期</th>
			</thead>
			<tbody >
				<tr ng-repeat="inverter in inverterList">
					<td class="text-center">排名</td>
					<td class="text-center">
					<span class="href-blur a-cur-poi" ng-bind="inverter.eqname" ng-click="showInverter({{inverter.eqid}},$index)">
						</span>
					</td>
					<td class="text-center">
						<span ng-bind="inverter.d_cap"></span>/ 
						<span ng-bind="inverter.a_cap"></span>
					</td>
					<td class="text-center">
						<span ng-bind="inverter.shd_kwh"></span>/ 
						<span ng-bind="inverter.real_kwh"></span>
					</td>
					<td class="text-center"><span ng-bind="inverter.cur_pba"></span></td>
					<td class="text-center"><span ng-bind="inverter.last_pba"></span></td>
					<td class="text-center"><span ng-bind="inverter.last_year_pba"></span></td>
					<td class="text-center"><span ng-bind="inverter.cur_pr"></span></td>
					<td class="text-center"><span ng-bind="inverter.last_pr"></span></td>
					<td class="text-center"><span ng-bind="inverter.last_year_pr"></span></td>
					
				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
app.controller('inverterTableCtrl',function($scope, $http, $state, $stateParams) {
	$http.get(
			"${ctx}/Report/getStationInverterListForMonth.htm",
			{
				params : {
					stid:$scope.stid,
					month:$("#changeTimeId2").html()
				}
			}).success(function(response) {
				$scope.inverterList=response.data.list
			}).error(function(response) {
			});
	var inverterModal=0;
	//点击某一个逆变器
	$scope.showInverter=function(eqid,inverIndex){
		$scope.eqIndex=inverIndex+1;//记录当前元素在table里面的下标
		$scope.eqid=eqid;
		$scope.inverterTotleM="${ctx}/tpl/reportPage/monthly/monthlymodal/inverterModal.jsp";
		$("#inverterModal").modal({backdrop: 'static', keyboard: false});
	}
	//点击某一个逆变器，加载后执行
	$scope.finishInverterModal=function(){
		 if(inverterModal=="0"){
			   $("#inverterModal").modal({backdrop: 'static', keyboard: false});
			   inverterModal++;
		   }
	}
	
});
</script>
