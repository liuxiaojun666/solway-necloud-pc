<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.h{
		font-size: 18px;
		color: #333;
		font-weight: bold;
	}

	.productTable{
		border: 1px solid #a4dfd7;
	}
	.productTable th,.productTable td{
		text-align: center;
		padding: 15px;
	}
	.productTable th{
		border-right: 1px solid #6bd2c2;
	}.productTable td{
		border-right: 1px solid #a4dfd7;
	}
	.productTable thead{
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
	}

	.productTable thead tr, .productTable tbody tr {
	    display:table;
	    width:100%;
	    table-layout:fixed;
	}


	.bgCyan{
		background-color: #e9f8f7;
	}
	.bgWhite{
		background-color: #fff;
	}

	/*斜线*/
	.line-td{
		position: relative;
	}
	.line-td:before{
		content: "";
		position: absolute;
		width: 1px;
		height:253px;/*这里需要自己调整，根据td的宽度和高度*/
		top:0;
		left:0;
		background-color: #25b49e;
		display: block;
		transform: rotate(-79deg);/*这里需要自己调整，根据线的位置*/
		transform-origin: top;
	}
	/*斜线*/


	.my-list{
		margin: 0;
		padding: 0;
	}
	.my-list li{
		line-height: 3em;
		padding: 0;
		margin-bottom: 5px;
		text-indent: 1em;
	}
	.my-list li:nth-child(2n){
		background-color: #cfefed;
	}
	.my-list li:nth-child(2n-1){
		background-color: #beebe8;
	}
</style>
<div ng-controller="reportDayProductDataCtrl" class="" style="padding-left: 3em;padding-bottom: 50px;">
	
	<div style="margin-top: 30px;">
		<h3 class="h">一、两值两票执行份数</h3>

		<div style="padding-left: 100px;overflow: auto;">
			<table class="productTable" style="table-layout: fixed;min-width: 100%;">
				<thead style="display: block;">
					<tr>
						<th style="width: 250px;" class="line-td">
							<span style="position: absolute;bottom: 10px;left: 10px;">票种</span>
							<span style="position: absolute;right: 10px;top: 10px;">场站</span>
						</th>
						<th style="" ng-if="tableData[0].stationTicketNums" ng-repeat="item in tableData[0].stationTicketNums">{{item.stationName}}</th>
						<th style="min-width: 150px;">共计</th>
						<th style="min-width: 150px;">合格率</th>
					</tr>
				</thead>
				<tbody style="display: block;overflow: overlay;">
					<tr ng-repeat="outerItem in tableData" class="{{$index % 2 === 0 ? 'bgWhite' : 'bgCyan'}}" ng-init="">
						<td style="width: 250px;">{{ outerItem.ticketName }}</td>
						<td style="" ng-repeat="item in outerItem.stationTicketNums">{{ item.ticketOutNum }}</td>
						<td style="min-width: 150px;">{{ outerItem.ticketOutNum }}</td>
						<td style="min-width: 150px;">{{ outerItem.passRate }}</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div style="margin-top: 30px;">
		<h3 class="h">二、两票情况</h3>
		<ul class="my-list">
			<li ng-repeat="item in data2">{{ $index + 1 }}、{{ item.content }}</li>
		</ul>
	</div>

	<div style="margin-top: 30px;">
		<h3 class="h">三、两票执行情况分析</h3>
		<ul class="my-list">
			<li ng-repeat="item in data3">{{ $index + 1 }}、{{ item.content }}</li>
		</ul>
	</div>

	<div style="margin-top: 30px;">
		<h3 class="h">四、考核</h3>
		<ul class="my-list">
			<li ng-repeat="item in data4">{{ $index + 1 }}、{{ item.content }}</li>
		</ul>
	</div>

	<div style="margin-top: 30px;">
		<h3 class="h">五、整改措施</h3>
		<ul class="my-list">
			<li ng-repeat="item in data5">{{ $index + 1 }}、{{ item.content }}</li>
		</ul>
	</div>




</div>
<script>
	app.controller('reportDayProductDataCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

		var rightDay = new Date();
			rightDay.setMonth(rightDay.getMonth() - 1);
			$scope.date = rightDay.Format('yyyy-MM-dd')
			
			
		$scope.$on('broadChangeDate',function (e, data) {
			data && ($scope.date = data.dtime.Format('yyyy-MM-dd'))
			getData()
		});


		$scope.$watch('$viewContentLoading',function(event){
			$scope.$emit("getDate")
		})

		$scope.parameters = [
			'电气一种工作票',
			'电气二种工作票',
			'电力线路一种工作票',
			'电力线路二种工作票',
			'电气倒闸操作票',
			'风机工作票',
			'断电保护措施票',
			'动火工作票',
			'动土工作票'
		]

		/**
		 * [getData 取数据]
		 * @return {[type]} [description]
		 */
		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpmTicketNum/selectCurrData.htm",
				params: {
					dateStr: $scope.date
				}
			}).success(function(res) {
				$scope.tableData = res.data
			})

			for (var i = 1; i < 6; i++) {
				getOuterData(i)
			}

			function getOuterData(type) {
				$http({
					method : "GET",
					url : "${ctx}/rpmAnalysisData/selectCurrData.htm",
					params: {
						dateStr: $scope.date,
						analysisDataType: type
					}
				}).success(function(res) {
					$scope['data' + type] = res.data
				})
			}
		}

	})
</script>