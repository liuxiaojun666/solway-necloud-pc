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
				url : "${ctx}/BusCfg/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
					promptObj('success', '', json.message);
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
			url : "${ctx}/BusCfg/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '',json.message);
				goPage(0);
			},
			error : function() {
				promptObj('error', '',json.message);
			}
		});
	}
	
	app.controller('BusCfgCtrl', function($scope, $http, $state) {
		$scope.showInformation = function(id,serialnumber,pstationid) {
			$state.go("app.BoxChangeDetail", {
				InId : id,
				serialnumber : serialnumber,
				pstationid : pstationid
			});
		}
		
		$scope.editPBuscfgData=function(id,modalId){
			$('#'+modalId).modal('show');
			initPageDeviceData(id);
		}
		
		$scope.addpbuscfg = function(id) {
			$state.go("app.addpbuscfg", {
				InId : id
			});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		//切换电站
		$scope.$on('broadcastSwitchStation', function(event, data) {
			initTableConfig($scope);
			$scope.onSelectPage(1);
		});
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if (page == 0) {
				page = 1;
			}
			$http({
				method : "POST",
				url : "${ctx}/BusCfg/pbuscfgList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					'keyWords' : $scope.keyWords,
					'name'     : $scope.name,
					'version'  : $scope.version,
					'pstationid' : $scope.pstationid
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		$scope.onSelectPage(1);
	});
</script>
 <!-- 弹出层界面 -->   
<div id="addPBuscfgEdit" data-ng-include="'${ctx}/tpl/ledgerPage/pstationConfig/pbuscfg/addPBuscfg.jsp'"></div>   
<div id="addPBuscfg" data-ng-include="'${ctx}/tpl/ledgerPage/pstationConfig/pbuscfg/addPBuscfg2.jsp'"></div>   
<div ng-controller="BusCfgCtrl">
	<div class="wrapper-md ng-scope">
			<paging class="col-sm-12">
			<div class="wrapper">
			<div class="col-sm-4 m-b-xs w-sm p-r-sm"> 
          <button class="btn btn-sm btn-info " ng-click="addData('addPBuscfg');"> 新增</button>
          <button class="btn btn-sm btn-default " onclick="deleteBatch();">批量删除</button>
      </div>
      <div class="col-sm-3 no-padder">
      	<div class="col-sm-9  no-padder">
        	<div class="input-group p-r-sm">
          <input type="text" id="keyWords"  ng-model="keyWords" class="input-sm form-control" placeholder="关键字" onkeypress="if(event.keyCode==13) {goPage(1);return false;}">
          <span class="input-group-btn">
           	<button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
          </span>
        </div>
        </div>
      </div>
      <div class="col-sm-5 pull-right">
		<%@ include file="/common/pager.jsp"%>
	  </div>
    </div>
		    <table id="result_table" class="col-sm-12 table-bordered table table-striped">
			<thead>
			
				<tr>
					<th style="width: 20px;">
						<label class="i-checks m-b-none">
							<input type="checkbox" id="all" onclick="changeAll(this.checked,'ids');" /><i></i>
						</label>
					</th>
					<th>总线名称</th>
					<th>总线模式</th>
					<th>超时时间(ms)</th>
					<th>总线分类</th>
					<th>通讯地址</th> 
					<th>操作</th>
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
					<td>
						<span ng-if="vo.passive=='0'">主动</span>
						<span ng-if="vo.passive=='1'">被动</span>
					</td>
					<td ng-bind="vo.timeout"></td>
					<td>
						<span ng-if="vo.type=='1'">TCP客户端总线</span>
						<span ng-if="vo.type=='2'">TCP服务端总线</span>
						<span ng-if="vo.type=='3'">全双工串行总线</span>
					</td>
					<td ng-bind="vo.hostaddr"></td>
					<td>
					    <a class="text-info"><img ng-click="editPBuscfgData({{vo.id}},'addPBuscfgDevice');" width="15px;" alt="" src="${ctx}/theme/images/Linked.png"></a>
						<a class="text-info"><i class="icon-note" ng-click="editData({{vo.id}},'addPBuscfg');"></i></a>
						<a class="text-info m-r-xs"><i class="icon-trash" ng-click="deleteRow({{vo.id}});"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
    </paging>
	</div>
	</div>
</div>
