<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.title{
		font-size: 30px;
		color: #1cb09a;
	}
	.workTickedTable{

	}
	.workTickedTable{
		border: 1px solid #a4dfd7;
	}
	.workTickedTable th,.workTickedTable td{
		text-align: center;
		padding: 15px;
	}
	.workTickedTable th{
		border-right: 1px solid #6bd2c2;
		word-break:keep-all;           /* 不换行 */
		white-space:nowrap;          /* 不换行 */
	}.workTickedTable td{
		border-right: 1px solid #a4dfd7;
	}
	.workTickedTable thead{
		background-color: #9fe8dd;
		border: 1px solid #1cb09a;
	}
	.bgCyan{
		background-color: #e9f8f7;
	}
	.bgWhite{
		background-color: #fff;
	}

	.workTickedTable thead tr, .workTickedTable tbody tr {
	    display:table;
	    width:100%;
	    table-layout:fixed;
	}


		.qxState .stateColor{
		width: 200px;
		padding-left: 0;
	}

	.qxState li{
		height: 30px;
		margin-top: 20px;
		line-height: 30px;
	}
	

	.type1{
		background-color: #c10000;
	}
	.type2{
		background-color: #00b1f1;
	}
	.type3{
		background-color: #ffff00;
	}
	.type4{
		background-color: #93d150;
	}
	.type5{
		background-color: #00b150;
	}
	.type6{
		background-color: #0070c1;
	}
</style>
<div class="" ng-controller="reportWorkTickedCtrl" style="padding: 20px;">

	<div style="overflow-x: auto;">
		<table class="workTickedTable" style="table-layout: fixed;min-width: 100%;">
			<!-- <caption style="text-align: center;"><h1 class="title">工作票</h1></caption> -->
			<thead style="display: block;">
				<tr>
					<th style="width: 10%">名称</th>
					<th style="width: 9%">工作票类型</th>
					<th style="width: 10%">工作内容</th>
					<th style="width: 10%">工作票号</th>
					<th style="width: 11%">工作票接收时间</th>
					<th style="width: 11%">许可开始时间</th>
					<th style="width: 11%">许可结束时间</th>
					<th style="width: 10%">工作票负责人</th>
					<th style="width: 10%">工作票许可人</th>
					<th style="">备注</th>
				</tr>
			</thead>
			<tbody class="text-left" style="display: block;max-height: 320px;overflow: overlay;">
				<tr ng-repeat="item in data" class="{{'type'+item.type}}">
					<td style="width: 10%">{{item.stationName}}</td>
					<td style="width: 9%">{{types[item.ticketType]}}</td>
					<td style="width: 10%">{{item.content}}</td>
					<td style="width: 10%">{{item.ticketNo}}</td>
					<td style="width: 11%">{{item.acceptTime}}</td>
					<td style="width: 11%">{{item.allowTime}}</td>
					<td style="width: 11%">{{item.endTime}}</td>
					<td style="width: 10%">{{item.chargeUser1}}</td>
					<td style="width: 10%">{{item.allowUser1}}</td>
					<td>{{item.remark}}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="qxState clearfix">
		<ul class="stateColor pull-left">
			<li class="type1"></li>
			<li class="type2"></li>
			<li class="type3"></li>
			<li class="type4"></li>
			<li class="type5"></li>
			<li class="type6"></li>
		</ul>
		<ul class="stateInfo pull-left">
			<li>动火工作票</li>
			<li>线路一票</li>
			<li>线路二票</li>
			<li>电器一票</li>
			<li>电器二票</li>
			<li>风机工作票</li>
		</ul>
	</div>
</div>
<script>
	app.controller('reportWorkTickedCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval,$location){

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

		$scope.types = {
			'1': '动火工作票',
			'2': '线路一票',
			'3': '线路二票',
			'4': '电器一票',
			'5': '电器二票',
			'6': '风机工作票'
		}


		/**
		 * 发请求，取数据
		 * @return {[type]} [description]
		 */
		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpdWorkTicket/selectCurrData.htm",
				params: {
					dateStr: $scope.date,
					type: 3
				}
			}).success(function(res) {
				$scope.data = res.data
			});
		}

	})
</script>