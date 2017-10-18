<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	function goPage(pageIndex) {
		$("#searchBtn").trigger("click");
	}
	function deleteBatch() {
		var conti = checkSelectMsg("ids", "请至少选择一条记录!");
		if (conti) {
			conti = confirm("确定要删除这些记录吗?");
		}
		if (conti) {
			var options = {
				type : "post",
				dataType : "json",
				url : "${ctx}/CommProtocol/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
					//alert(json.message);
					promptObj(json.type, '', json.message);
					goPage(0);
				},
				error : function(json) {
					promptObj('error', '',"删除失败");
				}
			};
			$.ajax(options);
		}
	}
	
	function deleteRow(id) {
		if (confirm("确定要删除这条数据吗？")) {
			singledel(id);
		}
	}
	function singledel(id) {
		$.ajax({
			type : "post",
			url : "${ctx}/CommProtocol/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '', json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}
	
	app.controller('CommProtocolCtrl', function($scope, $http, $state) {
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.editData = function(id, modalId) {
			editData(id, modalId);
		}
		$scope.addData = function(id) {
			$state.go("app.addCommProtocol", {
				InId : id
			});
		}
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/CommProtocol/protocolList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					keyWords : $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
		
		//点击  Enter  键  查询
		document.onkeydown = function(e)
		{
		   var e = window.event   ?   window.event   :   e; 
		   if(e.keyCode == 13){
			   $scope.onSelectPage(1);
			}
		}	
	});
</script>
 <!-- 弹出层界面 -->     
<%-- <div id="productEdit" data-ng-include="'${ctx}/tpl/ledgerPage/CommProtocol/addProtocol.jsp'"></div> --%>

<div ng-controller="CommProtocolCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h4 blue-1 m-n text-black">通讯规约管理</span>
	</div>
	<div class="wrapper-md ng-scope">
	
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">     
          <button class="btn btn-sm btn-info m-r-xs" ng-click="addData();"> 新增</button>   
          <button class="btn btn-sm btn-default m-r-xs" onclick="deleteBatch('');">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        <div class="input-group p-r-sm">
          <input type="text" id="keyWords" ng-model="keyWords"  class="input-sm form-control" placeholder="关键字">
          <span class="input-group-btn">
          <button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
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
			<th>协议名称</th>
			<th>版本号</th>
<!-- 			<th>库文件版本号</th> -->
			<th width="7%">操作</th>
		</tr>
	</thead>
	<tbody >
			<tr ng-repeat="vo in data ">
				<td>
				<label class="i-checks m-b-none">
				<input type="checkbox" name="ids" id="ids" value="{{vo.id}}" />
				<i></i></label>
				</td>
				<td ng-bind="vo.name"></td>
				<td ng-bind="vo.version"></td>
				
<!-- 				<td ng-bind="vo.libVersion"></td> -->
				<td>
					<a class="text-info"><i class="icon-note" ng-click="addData({{ vo.id }});" ></i></a>
					<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
				</td>
			</tr>
	</tbody>
</table>
</paging>
</div>
</div>
</div>
