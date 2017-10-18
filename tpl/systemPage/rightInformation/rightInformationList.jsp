<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
				url : "${ctx}/Right/deleteBatch.htm?"
						+ $("input[name=ids]:checked").serialize(),
				success : function(json) {
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
			url : "${ctx}/Right/delete.htm",
			data : {
				"id" : id
			},
			dataType : "json",
			success : function(json) {
				goPage(0);
			},
			error : function() {
				promptObj('error', '',"删除失败");
			}
		});
	}

	app.controller('rightInformationCtrl', function($scope, $http, $state) {
		getCompany();
		$scope.createManufacturer = function(id, name) {
			$state.go("app.addRightInformation", {
				manId : id
			});
		}
		$scope.deleteRow = function(id) {
			deleteRow(id);
		}
		$scope.editData = function(id,modalId) {
			editData(id,modalId);
		}
		initTableConfig($scope);
		$scope.onSelectPage = function(page) {
			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/Right/rightInformationList.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					rightName : $scope.rightNameS,
					companyid : $scope.companyidS,
					keyWords : $scope.keyWords
				}
			}).success(function(result) {
				getTableData($scope,result);
			});
		};
		//get first page
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
	
	function getCompany(){
		$("#companyidS").empty();
		$.ajax({
			type:"post",
			url:"${ctx}/Company/selectAll.htm",
			dataType : "json",
			async: false,
			success:function(msg){
				$("#companyidS").append("<option value=''>请选择</option>");
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].comId+"'";
/* 					if(stationcode!=null&&msg[i].comId==stationcode){
						op+=" selected='selected' ";
					}
 */					op+=">"+msg[i].comName+"</option>";
					$("#companyidS").append(op);
				}
			}
		});
	}
</script>
<!-- 弹出层界面 -->
<div id="rightInformationEdit"
	data-ng-include="'${ctx}/tpl/systemPage/rightInformation/addRightInformation.jsp'"></div>
<div ng-controller="rightInformationCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">权限信息
	</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<paging class="col-sm-12 panel no-padder">
			<div class="row wrapper">
				<div class="col-sm-4 m-b-xs w-sm p-r-sm">
					<button class="btn btn-sm btn-info m-r-xs"
						onclick="addData('rightInformationModal');">新增</button>
					 <button class="btn btn-sm btn-default m-r-xs"
						onclick="deleteBatch('');">批量删除</button> 
				</div>
				<div class="col-sm-3 no-padder">
					<div class="col-sm-9 no-padder">
						<div class="input-group p-r-sm">
							<input type="text" ng-model="keyWords" id="keyWords"
								class="input-sm form-control" placeholder="关键字"> <span
								class="input-group-btn">
								<button class="btn btn-sm btn-info" ng-click="onSelectPage(1);"
									type="button">查询</button>
							</span>
						</div>
					</div>
					<a class="col-sm-3 text-info no-padder cwsearch"
						onclick="showSearch()"> <span class="searchTitle "><button
								class="btn btn-sm  btn-default">更多查询</button></span></a>
				</div>
				<div class="col-sm-5 pull-right">
				<%@ include file="/common/pager.jsp"%></div>
			</div>
			<div class="row hideSearchDiv wrapper">
			 <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">机构</button>
          </span>
        <select class="input-sm form-control w-sm inline v-middle" id="companyidS" name="companyidS" ng-model="companyidS">
        </select>
        </div>
      </div>
       <div class="col-sm-2">
       <div class="input-group">
          <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">权限名称</button>
          </span>
        <input type="text" class="input-sm form-control" id="rightNameS" name="rightNameS" ng-model="rightNameS"></div>
      </div>
			
				<div class="col-sm-1">
					<button id="searchBtn" class="btn btn-sm btn-info"
						ng-click="onSelectPage(1);" type="button">查询</button>
				</div>
			</div>
						<div>
				<paging class="col-sm-12 panel no-padder">
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th style="width: 20px;"><label class="i-checks m-b-none">
									<input type="checkbox" id="all"
									onclick="changeAll(this.checked,'ids');" /><i></i>
							</label></th>
							<th>权限编码</th>
							<th>权限名称</th>
							<th>所属机构</th>
							<th>父权限</th>
							<th>操作</th>

						</tr>
					</thead>
					<tbody>

						<tr ng-repeat="vo in data ">
							<td><label class="i-checks m-b-none">
								<input type="checkbox" name="ids" id="ids" value="{{vo.rightId }}" /> <i></i>
							</label>
							</td>
							<td ng-bind="vo.rightCode"></td>
							<td ng-bind="vo.rightName"></td>
							<td ng-bind="vo.companyName"></td>
							<td ng-bind="vo.parentRightName"></td>
							<td>
							<a class="text-info"><i class="icon-note" ng-click="editData({{ vo.rightId }},'rightInformationModal');" ></i></a>
							<a class="text-info"><i class="icon-trash" ng-click="deleteRow({{vo.rightId}});"></i></a>
							</td>
						</tr>
					</tbody>
				</table>
				</paging>
			</div>
			</paging>
			</div>
		</div>
	</div>
