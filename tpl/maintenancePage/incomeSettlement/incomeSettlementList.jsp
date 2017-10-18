<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function goPage(pageIndex){
		$("#searchBtn").trigger("click");
	}
	function deleteBatch(){
		var conti= checkSelectMsg("ids","请至少选择一条记录!");
 		if(conti){
 			conti = confirm("确定要删除这些记录吗?");
 		}
 		if(conti){
 			var options = {
 					type:"post",
 					dataType:"json",
 					url : "${ctx}/IncomeSettlement/deleteBatch.htm?"+$("input[name=ids]:checked").serialize(),
 					success:function(json){
 						promptObj('success', '', json.message);
 						goPage(0);
 					},
 					error:function(json){
 						promptObj('error', '',"删除失败");
 					}
 				};
 				$.ajax(options);
 			}
	}
	
	function deleteRow(id){
		if(confirm("确定要删除这条数据吗？")){
			singledel(id);
		}
	}
	function singledel(id){
		$.ajax({
			type : "post",
			url : "${ctx}/IncomeSettlement/delete.htm",
			data:{"id":id},
			dataType : "json",
			success : function(json) {
				goPage(0);
				promptObj('success', '', json.message);
			},error:function(){
				promptObj('error', '',"删除失败");
			}
		});
	}
   app.controller('IncomeSettlementCtrl', function ($scope, $http,$state) {
	   $scope.getCurrentDataName('00',0);
	   $scope.$on('broadcastSwitchStation', function(event, data) {
		   $scope.currentDataName = data.dataName;
		   initTableConfig($scope);
		   $scope.onSelectPage(1);
	   });

		$scope.createIncomeSettlement = function(id,name){
			  $state.go("app.addIncomeSettlement",{InId:id});
		};
		$scope.$on('refreshViewDataForHead', function(event, data) {  
			initTableConfig($scope);
			$scope.onSelectPage(1);
	    });
		$scope.deleteRow = function(id){
			deleteRow(id);
		};
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/IncomeSettlement/incomeSettlementList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
        			keyWords:$scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
    });
</script>
 <!-- 弹出层界面 -->     
<div ng-controller="IncomeSettlementCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">电费结算管理</span>  -->
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
		<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">     
          <button class="btn btn-sm btn-info" ng-click="createIncomeSettlement();"> 新增</button>  
          <button  class="btn btn-sm btn-default" onclick="deleteBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
		<div class="col-sm-9  no-padder">
		<div class="input-group p-r-sm">
          <input type="text" ng-model="keyWords" id="keyWords" class="input-sm form-control" placeholder="关键字">
          <span class="input-group-btn">
			<button class="btn btn-sm btn-info" id="searchBtn" ng-click="onSelectPage(1);"
				type="button">查询</button>         
		</span>
        </div>
        </div>
      </div>
      <div class="col-sm-5 pull-right">
			<%@ include file="/common/pager.jsp"%>
		</div>
    </div>
			<table id="result_table" class="table table-striped b-t b-light">
			<thead>
				<tr>
					<th style="width: 20px;">
						<label class="i-checks m-b-none">
							<input type="checkbox" id="all"
					onclick="changeAll(this.checked,'ids');" /><i></i>
						</label>
					</th>
					<th>电站名称</th>
					<th style="text-align: center;">结算周期</th>
					<th style="text-align: center;">结算时间</th>
					<th style="text-align: right;">结算电量（kWh）</th>
					<th style="text-align: right;">结算金额（元）</th>
					<th>结算人</th>
					<th>操作</th>
					
				</tr>
			</thead>
			<tbody>
				<tr  ng-repeat="vo in data ">
					<td>
					<label class="i-checks m-b-none">
					<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
					<i></i></label>
					</td>
					<td ng-bind="vo.pstationname"></td>
					<td  style="text-align: center;" >
						{{vo.startdate | date:'yyyy-MM-dd'}}至{{vo.enddate | date:'yyyy-MM-dd'}}
					</td>
				
					<td  style="text-align: center;" ng-bind="vo.settledate | date:'yyyy-MM-dd'"></td>
					<td  style="text-align: right;" ng-bind="vo.settlepowerv | number : 2">
					<td  style="text-align: right;" ng-bind="vo.settlemoney | currency:'￥ '">
					<td ng-bind="vo.settlePeople">
					</td>
					<td>
						<a class="text-info"><i class="icon-note" ng-click="createIncomeSettlement({{ vo.id }});" ></i></a>
						<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
	</paging>
</div>
</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
