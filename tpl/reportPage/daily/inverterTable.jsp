<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	.simThead {position: absolute;width: 100%;background-color: #fff;}
	.simThead .table {margin-bottom: 0;}
	.simThead-table thead {visibility: hidden;}
	.simThead.inverterTable th,
	.simThead-table.inverterTable td {
		width: 12.5%;
	}
</style>
<div class="col-sm-12  divshadow panel wrapper-xs m-n">
<span class="font-h4 black-1 col-sm-12  inverterTabletitle">逆变器统计</span>
	<div class="col-sm-12 no-padder tab-bordered m-t-sm b-t inverterTablediv simThead_inverter" ng-controller="inverterTableCtrl">
		<div ng-include="inverterTotleM" load-done="finishInverterModal()"></div>
		<div class="simThead inverterTable">
			<table class="table table-striped b-t b-light bg-table">
				<thead>
					<tr>
						<th ng-repeat="column in columns" class="a-cur-poi text-center"
							ng-click="sort.toggle(column)"
							ng-class="{sortable: column.sortable !== false}">
							{{column.label}}<i
							ng-if="column.name === sort.column && sort.direction"
							class="glyphicon {{sort.direction|orderClass}}"></i>
						</th>
					</tr>
				</thead>
			</table>
		</div>
		<table class="table table-striped b-t b-light bg-table inverterTable simThead-table">
			<thead>
				<tr>
					<th ng-repeat="column in columns" class="a-cur-poi text-center"
						ng-click="sort.toggle(column)"
						ng-class="{sortable: column.sortable !== false}">
						{{column.label}}<i
						ng-if="column.name === sort.column && sort.direction"
						class="glyphicon {{sort.direction|orderClass}}"></i>
					</th>
				</tr>
			</thead>
			<tbody >
				<tr ng-repeat="inverter in inverterList|orderBy:sort.column:sort.direction===-1">
					<td class="text-center">
					<span class="href-blur a-cur-poi" ng-bind="inverter.name"
					ng-click="showInverter(inverter.eqid,inverter.stid,inverter.name,$index)">
						12</span>
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
					<td class="text-center"><span ng-bind="inverter.pr|dataNullFilter"></span>%</td>
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
	var inverterModal=0;
	$scope.$on('dailyRefresh', function(event, data) {
	       if(data[0]){
	    	   $scope.mapTimeDay=data[1]
	    	   $scope.getInverTable()
	      	 }
	      });
	$scope.$on('refreshViewDataForHead', function(event, data) {
		$scope.getInverTable();
    });
	$scope.columns = [
      	    {
      	      label: '逆变器',
      	      name: 'eqname'//表头 name 需要和table 的列 一致
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
       	      label: 'PBA',
       	      name: 'pba'
       	    },
       	    {
       	      label: 'PR',
       	      name: 'pr'
       	    },
       	    {
       	      label: '组串电流离散率',
       	      name: 'c_dr_avg'
       	    }
      	  ];
	$scope.sort = {
			    column: 'eqname',//默认有排序的列
			    direction: -1,
			    toggle: function(column) {
			      if (column.sortable === false)
			        return;

			      if (this.column === column.name) {
			        this.direction = -this.direction || -1;
			      } else {
			        this.column = column.name;
			        this.direction = -1;
			      }
			    }
			  };


	$scope.getInverTable=function(){
		$http.get(
				"${ctx}/Report/getStationInverterListForDay.htm",
				{
					params : {
						stid:$scope.stid,
						dtime:$scope.mapTimeDayRefresh
					}
				}).success(function(response) {
					$scope.inverterList=response.devList
				}).error(function(response) {
				});
	}
	 $scope.getInverTable()

	//点击某一个逆变器
	$scope.showInverter=function(eqid,stid,eqname,inverIndex){

		$scope.eqIndex=inverIndex+1;//记录当前元素在table里面的下标
		$scope.eqid=eqid;
		$scope.eqnameTitle=eqname;
		$scope.inverterTotleM="${ctx}/tpl/reportPage/daily/dailymodal/inverterModal.jsp";
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
