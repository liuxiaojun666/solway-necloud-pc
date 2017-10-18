<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.modal-open {
    overflow-y: auto;
}
.page-padding{padding:0 20px 20px;}
.background-white{background:white;}
.word-black{color:#545454;}
.table > thead > tr > th {
    color:#545454;
}
.table-striped > tbody > tr:nth-child(odd) {
    background-color: white;
}
.table-striped > tbody > tr:nth-child(even) {
    background-color: #f1fbfa;
}
.table-striped > tbody > tr:nth-child(odd) > td, .table-striped > tbody > tr:nth-child(odd) > th {
    background-color: white;
}
.btn-info {
    width: 65px;
    height: 38px;    border-radius: 0;
}
.btn-default {
    width: 95px;
    height: 38px;
}
.m-r-8{margin-right:8px;}
.keywords-input{height: 38px;border: 1px solid rgb(183,183,183);text-indent:1em;    vertical-align: bottom;    width: 230px;}
.keywords-input::-webkit-input-placeholder {
	color:rgb(84,84,84,0.8);font-size:12px;text-indent:1em;
}
.more-search{line-height: 27px;    margin-left: 8px;}
</style>
<div ng-controller="dtDayReportListPageCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
	</div>
	<div class="page-padding word-black">
		<div data-ng-include="'${ctx}/tpl/datang/reportPage/model/reportHeader.jsp'"></div>
		<div class="clearfix">
			<div class="list-page-con background-white" ng-show="listOrFill == 'listPage'">
				<paging>
					<div class="col-sm-12 font16 wrapper">
						<!-- <div class="col-sm-2 no-padder">     
						    <button class="btn btn-sm btn-info m-r-8" ng-click="createIncomeSettlement();"> 新增</button>  
						    <button  class="btn btn-sm btn-default" onclick="deleteBatch('');">批量删除</button>
						</div> -->
						<div class="col-sm-5">
					        <input type="text" ng-model="keyWords" id="keyWords" class="keywords-input" placeholder="关键字"><button class="btn btn-sm btn-info" id="searchBtn" ng-click="onSelectPage(1);" type="button">查询</button> 
					        <a class="btn btn-sm btn-default more-search" >更多查询</a>        
						</div>
				      	<div class="col-sm-5 pull-right">
							<%@ include file="/common/pager.jsp"%>
						</div>
			   		</div>
					<table id="result_table" class="table table-striped b-t b-light">
						<thead style="background: #9fe8dd;">
							<tr>
								<th>统计日期</th>
								<th class="text-center">名称</th>
								<th class="text-center">填报人</th>
								<th class="text-center">上报时间</th>
								<th class="text-right">操作</th>
							</tr>
						</thead>
						<tbody class="font12">
							<tr ng-repeat="vo in tableListResult">
								<td ng-bind="vo.time"></td>
								<td class="text-center" ng-bind="vo.name"></td>
								<td class="text-center" ng-bind="vo.fillPerson"></td>
								<td class="text-center" ng-bind="vo.fillTime"></td>
								<td  class="text-right">

									<a class="text-info" ng-click="showFillPage({{ vo.itemData }}, processData);" ng-show="{{vo.operation == 0}}">查看<i class="icon-note  font16" ></i></a>

									<a class="text-info" ng-click="showFillPage({{ vo.itemData }}, processData);" ng-show="{{vo.operation == 1}}">编辑<i class="icon-note  font16" ></i></a>

									<a class="text-info" ng-click="showFillPage({{ vo.itemData }}, processData);" ng-show="{{vo.operation == 2}}">审核<i class="icon-note  font16" ></i></a>
									<!-- <a class="text-info"><i class="icon-trash font16" ng-click="deleteRow({{vo.id}});"></i></a> -->
								</td>
							</tr>
						</tbody>
					</table>
				</paging>
			</div>
			<div class="fill-page-con" ng-show="listOrFill == 'fillPage'">
				 <div data-ng-include="'${ctx}/tpl/datang/reportPage/model/fillReportPage.jsp'"></div>
			</div>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">

app.controller('dtDayReportListPageCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval) {

	$scope.getCurrentDataName('00',0,function(value){
		$scope.stationId = value.currentSTID;
		$scope.onSelectPage(1);
	});
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		initTableConfig($scope);
		$scope.getCurrentDataName('00',0,function(value){
			$scope.stationId = value.currentSTID;
			$scope.onSelectPage(1);
		});
	});
	   
	//headerTab	切换后接收
	$scope.$on("changeHeaderTab",function(e, value, reload){
		$scope.listOrFill = value
		reload && $scope.onSelectPage()
	});
	
	//默认进列表页
	$scope.listOrFill = "listPage";
	//$scope.listOrFill = "fillPage";
	
	
	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}

		$http({
			method : "POST",
			url : "${ctx}/rpds/page.htm",
			params: {
				stationId:$scope.stationId,
				pageSize: $scope.pageSizeSelect,
				pageIndex: page-1,
				processId: '',
				processName: '',
				item: ''
			}
		}).success(function(res) {

			$scope.processData = res.data.processData

			$scope.tableListResult = res.data.pageData.data.map(function (v, i) {
				return {
					time: new Date(v.busiDate).Format("yyyy-MM-dd"),
					name: v.stationName,
					fillPerson: v.createUserName,
					fillTime: new Date(v.createDate).Format("yyyy-MM-dd"),
					operation: v.operation,
					itemData: v
				}
			})

			getTableData($scope, res.data.pageData);

			// $state.go($rootScope.firstMenuUrl["01"]["uisref"], {
			// 	stationId : stationId
			// });
		});
	};
	
	$scope.showFillPage = function(item, processData){
		$scope.listOrFill = "fillPage";
		$scope.$broadcast("fillItem",item, processData);
	}
});

</script>