<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.simThead {position: absolute;width: 100%;background-color: #fff;}
	.simThead .table {margin-bottom: 0;}
	.simThead-table thead {visibility: hidden;}
	.simThead.inverterTable th, .simThead-table.inverterTable td {width: 8.3333333%;}
</style>
<div class="col-sm-12  divshadow panel wrapper-xs m-n">
	<span class="font-h4 black-1 col-sm-12  inverterTabletitle">逆变器统计</span>
	<div class="col-sm-12 no-padder tab-bordered m-t-sm b-t inverterTablediv simThead_inverter" ng-controller="inverterTableCtrl">
		<div ng-include="inverterTotleM" load-done="finishInverterModal()"></div>
		<div class="simThead inverterTable">
			<table class="table table-striped b-t b-light bg-table tbody-scroll">
				<thead>
					<tr>
						<th ng-repeat="column in columns" class="a-cur-poi text-center"
							ng-click="sort.toggle(column)"
							ng-class="{sortable: column.sortable != false}">
							{{column.label}}
							<i ng-if="column.name === sort.column && sort.direction"
								class="glyphicon fa"
								ng-class="{true:'fa-angle-down', false:'fa-angle-up'}[sort.direction==-1]"></i>
							<p ng-show="column.labelAdd" class="m-n">{{column.labelAdd}}</p>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		<table class="table table-striped b-t b-light bg-table tbody-scroll simThead-table inverterTable">
			<thead>
				<tr>
					<th ng-repeat="column in columns" class="a-cur-poi text-center"
						ng-click="sort.toggle(column)"
						ng-class="{sortable: column.sortable != false}">
						{{column.label}}
						<i ng-if="column.name === sort.column && sort.direction"
							class="glyphicon fa"
							ng-class="{true:'fa-angle-down', false:'fa-angle-up'}[sort.direction==-1]"></i>
						<p ng-show="column.labelAdd" class="m-n">{{column.labelAdd}}</p>
					</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="inverter in inverterList|orderBy:sort.column:sort.direction===-1">
					<td class="text-center">
					<span class="href-blur a-cur-poi" ng-bind="inverter.name"
					ng-click="showInverter(inverter.eqid,$index)">
						</span>
					</td>
					<td class="text-center">
						<span ng-bind="inverter.inst_kw|dataNullFilter"></span>/
						<span ng-bind="inverter.acc_kw|dataNullFilter"></span>
					</td>
					<td class="text-center"><span ng-bind="inverter.real_kwh|dataNullFilter"></span>/
					<span ng-bind="inverter.shd_kwh|dataNullFilter"></span>
					</td>
					<td class="text-center"> <span ng-bind="inverter.load_r_max|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.tran_r_max|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.pba|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.last_pba|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.last_year_pba|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.pr|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.last_pr|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.last_year_pr|dataNullFilter"></span>%</td>
					<td class="text-center"><span ng-bind="inverter.c_dr_avg|dataNullFilter"></span>%</td>

				</tr>
			</tbody>
		</table>
	</div>
</div>
<script>
	$('.simThead_inverter').scroll(function(event) {
		$('.simThead_inverter .simThead').css('top', $(this).scrollTop());
	});
</script>
<script>
app.controller('inverterTableCtrl',function($scope, $http, $state, $stateParams) {
	$scope.$on('monthlyRefresh', function(event, data) {
	       if(data[0]){
	    	   $scope.mapTimeMonth=data[1]
	    	   $scope.getInverData()
	      	 }
	      });
	$scope.$on('refreshViewDataForHead', function(event, data) {  
		$scope.getInverData();
    });
	$scope.columns = [
		{
			label: '逆变器',
			name: 'eqname'
		},
		{
			label: '设计/接入容量(kW)',
			name: 'd_cap'
		},
		{
			label: '实发/应发电量(kWh)',
			name: 'shd_kwh'
		},
		{
			label: '最大负载率',
			name: 'load_r_max'
		},
		{
			label: '最大转换效率',
			name: 'tran_r_max'
		},
		{
			label: '本期',
			name: 'cur_pba'
		},
		{
			label: 'PBA',
			labelAdd: '上期',
			name: 'last_pba'
		},
		{
			label: '去年同期',
			name: 'last_year_pba'
		},
		{
			label: '本期',
			name: 'cur_pr'
		},
		{
			label: 'PR',
			labelAdd: '上期',
			name: 'last_pr'
		},
		{
			label: '去年同期',
			name: 'last_year_pr'
		},
		{
			label: '组串电流离散率',
			name: 'c_dr_avg'
		}
	];
	$scope.sort = {
		column: 'eqname',
		direction: -1,
		toggle: function(column) {
			if (column.sortable === false) {
				return;
			}
			if (this.column === column.name) {
				this.direction = -this.direction || -1;
			} else {
				this.column = column.name;
				this.direction = -1;
			}
		}
	};
	$scope.getInverData=function(){
		$http.get(
				"${ctx}/Report/getStationInverterListForMonth.htm",
				{
					params : {
						stid:$scope.stid,
						month:$scope.mapTimeMonth
					}
				}).success(function(response) {
					$scope.inverterList=response.devList
				}).error(function(response) {
				});
	}
	$scope.getInverData()
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
