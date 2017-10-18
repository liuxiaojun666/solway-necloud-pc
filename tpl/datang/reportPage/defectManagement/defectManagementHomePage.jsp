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
.m-r-8{margin-right:8px;}
.keywords-input{height: 30px;border: 1px solid rgb(183,183,183);text-indent:1em;    vertical-align: bottom;    width: 230px;}
.keywords-input::-webkit-input-placeholder {
	color:rgba(84,84,84,0.8);font-size:12px;text-indent:1em;
}
.more-search{line-height: 27px;    margin-left: 8px;}
</style>
<div ng-controller="dtDefectManagementHomePageCtrl">
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
						<div class="col-sm-2 no-padder">     
						    <button class="btn btn-sm btn-info m-r-8" ng-click="createIncomeSettlement();"> 新增</button>  
						    <button  class="btn btn-sm btn-default"  ng-click="deleteBatch();">批量删除</button>
						</div>
						<div class="col-sm-5 no-padder">
					        <input type="text" ng-model="keyWords" id="keyWords" class="keywords-input" placeholder="关键字"><button class="btn btn-sm btn-info" id="searchBtn" ng-click="onSelectPage(1);" type="button">查询</button> 
					        <!-- <a class="btn btn-sm btn-default more-search" >更多查询</a> -->        
						</div>
				      	<div class="col-sm-5 pull-right">
							<%@ include file="/common/pager.jsp"%>
						</div>
			   		</div>
					<table id="result_table" class="table table-striped b-t b-light">
						<thead style="background: #9fe8dd;">
							<tr>
								<th style="width: 20px;">
									<label class="i-checks m-b-none">
										<input type="checkbox" id="all" onclick="changeAll(this.checked,'ids');" /><i></i>
									</label>
								</th>
								<th>场站</th>
								<th>设备名称</th>
								<th class="text-center">缺陷类型</th>
								<th class="text-center">工作票号</th>
								<th class="text-center">操作</th>
							</tr>
						</thead>
						<tbody class="font12">
							<tr ng-repeat="vo in data">
								<td>
									<label class="i-checks m-b-none">
										<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
										<i></i>
									</label>
								</td>
								<td ng-bind="vo.stationName"></td>
								<td ng-bind="vo.deviceName"></td>
								<td class="text-center" ng-bind="vo.faultType"></td>
								<td class="text-center" ng-bind="vo.workTicketNum"></td>
								<td class="text-center">
									<a class="text-info"><i class="icon-note  font16" ng-click="showFillPage({{ vo}});" ></i></a>
									<a class="text-info"><i class="icon-trash font16" ng-click="deleteRow({{vo.id}});"></i></a>
								</td>
							</tr>
						</tbody>
					</table>
				</paging>
			</div>
			<div class="fill-page-con" ng-show="listOrFill == 'fillPage'">
				<div data-ng-include="'${ctx}/tpl/datang/reportPage/defectManagement/defectManagementFillModel.jsp'"></div>
			</div>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">

app.controller('dtDefectManagementHomePageCtrl', function($scope,$rootScope,$http, $state, $stateParams,$interval) {

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
	$scope.$on("changeHeaderTab",function(e,value){
		$scope.listOrFill = value;
	});
	
	$scope.$on("childPage",function(e,value){
		if(value == "listOrFill"){
			$scope.listOrFill = "listPage";
			$scope.onSelectPage(1);
		}else{
			$scope.listOrFill = "listPage";
		}
		$scope.$broadcast("closeFillTab");
	});
	
	//默认进列表页
	$scope.listOrFill = "listPage"; 
	initTableConfig($scope);
	$scope.onSelectPage = function(page) {
		if(!page){
			page = 1;
			$scope.currentPage=1;
		}
		
		$http({
	 		method : "POST",
	 		url : "${ctx}/rpdFault/page.htm",
	 		params : {
				stationId:$scope.stationId,
				pageIndex : page - 1,
				pageSize : $scope.pageSizeSelect,
				keyWords : $scope.keyWords,
			}
		 }).success(function(result) {
			getTableData($scope,result.data);
		 })
	};
	
	//新增
    $scope.createIncomeSettlement = function(){
    	$scope.listOrFill = "fillPage";
        $scope.$broadcast("fillItem",[null,null]);
    }
	
	//编辑
	$scope.showFillPage = function(item){
		$scope.listOrFill = "fillPage";
		$scope.$broadcast("fillItem",[item ,"commonTime"]);
	}
	
	//删除单条数据
    $scope.deleteRow = function(id){
    	if(confirm("确定要删除这条数据吗？")){
    		$http({
    			method : "POST",
    			url : "${ctx}/rpdFault/delete.htm",
    			params : {
    				'id' :id,
    			}
    		}).success(function(result) {
    			if(result.code == 0){
    				promptObj('success', '', "删除成功");
    				$scope.onSelectPage(1);
    			}else if(result.code == 1){
    				promptObj('error', '',"删除失败");
    			}
    		});
		}
	};
	
	//批量删除
	$scope.deleteBatch = function(){
		var conti= checkSelectMsg("ids","请至少选择一条记录!");
 		if(conti){
 			conti = confirm("确定要删除这些记录吗?");
 		}
		if (conti) {
			var checkedIds = [];
			var checkedInput = $("input[name=ids]:checked");
			for(var i = 0;i<checkedInput.length;i++){
				checkedIds.push(checkedInput[i].value);
			}
			$http({
				method : "POST",
				url : "${ctx}/rpdFault/deleteBatch.htm",
				params : {
					'ids' :checkedIds
				}
			}).success(function(result) {
				if(result.code == 0){
					promptObj('success', '', "删除成功");
					$scope.onSelectPage(1);
				}else if(result.code == 1){
					promptObj('error', '',"删除失败");
				}
			});
		}

	}
});

</script>