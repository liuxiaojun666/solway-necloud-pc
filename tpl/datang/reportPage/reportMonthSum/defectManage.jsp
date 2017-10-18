<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.title{
		font-size: 30px;
		color: #1cb09a;
		text-align: center;
	}
	.title .date{
		margin-left: 30px;
	}

	.defectTable{
		border-left: 1px solid #818181;
	}

	.defectTable thead{
		border-top: 1px solid #1cb09a;
		border-bottom: 1px solid #1cb09a;
		background-color: #9fe8dd;
		word-break:keep-all;           /* 不换行 */
		white-space:nowrap;          /* 不换行 */
	}
	.defectTable td,.defectTable th{
		padding: 15px;
	}
	.defectTable th{
		border-right: 1px solid #6bd2c2;
	}
	.defectTable td{
		border-right: 1px solid #818181;
		border-bottom: 1px solid #c6c6c6;
	}

	.defectTable thead tr, .defectTable tbody tr {
	    display:table;
	    width:100%;
	    table-layout:fixed;
	}
	
	.qxState{
		
	}
	.qxState ul{
		
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
	

	.state1{
		background-color: #16a53f;
	}
	.state2{
		background-color: #fb0006;
	}
	.state3{
		background-color: #f38437;
	}
	.state4{
		background-color: #ffff0c;
	}
	.state5{
		background-color: #b1b1b1;
	}
</style>
<div ng-controller="reportDayProductDataCtrl" class="" style="padding: 15px;">
	

	<div style="overflow-x: auto;">
		<table class="defectTable text-center" style="table-layout: fixed;min-width: 100%;">
			<!-- <caption><h1 class="title">缺陷统计</h1></caption> -->
			<thead class="" style="display: block;">
				<tr>
					<th style="width: 6%">电站</th>
					<th style="width: 8%">设备名称</th>
					<th style="width: 10%">缺陷内容</th>
					<th style="width: 5%">类型</th>
					<th style="width: 8%">工作票号</th>
					<th style="width: 8%">停运时间</th>
					<th style="width: 12%">停用风速（M/S）</th>
					<th style="width: 8%">消缺时间</th>
					<th style="width: 11%">修复启动时间</th>
					<th style="width: 8%">处理经过</th>
					<th style="width: 8%;">原因分析</th>
					<th style="width: 6%">备注</th>
				</tr>
			</thead>
			<tbody style="display: block;max-height: 306px;overflow: overlay;">
				<tr ng-repeat="item in data" class="{{'state'+item.faultType}}">
					<td style="width: 6%">{{item.stationName}}</td>
					<td style="width: 8%">{{item.device_name}}</td>
					<td style="width: 10%">{{item.faultContent}}</td>
					<td style="width: 5%">{{item.faultType}}</td>
					<td style="width: 8%">{{item.workTicketNum}}</td>
					<td style="width: 8%">{{item.stopTime}}</td>
					<td style="width: 12%">{{item.illuminationIntensity}}</td>
					<td style="width: 8%">{{item.deOxygenTime}}</td>
					<td style="width: 11%">{{item.repairStartupTime}}</td>
					<td style="width: 8%;">{{item.doProcess}}</td>
					<td style="width: 8%;">{{item.reason}}</td>
					<td style="width: 6%">{{item.remark}}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="qxState clearfix">
		<ul class="stateColor pull-left">
			<li class="state1"></li>
			<li class="state2"></li>
			<li class="state3"></li>
			<li class="state4"></li>
			<li class="state5"></li>
		</ul>
		<ul class="stateInfo pull-left">
			<li>运行状态</li>
			<li>停运状态</li>
			<li>待备件、条件不允许维护等状态</li>
			<li>技改状态</li>
			<li>四类缺陷</li>
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





		function getData() {
			$http({
				method : "GET",
				url : "${ctx}/rpdFault/selectCurrData.htm",
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