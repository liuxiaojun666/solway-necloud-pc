<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/mergeColumn.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript">
app.controller('producePlanCtrl', function($scope, $http, $state, $stateParams) {
	$scope.getCurrentDataName('00',0);
	$scope.$on('broadcastSwitchStation', function(event, data) {
		$scope.currentDataName = data.dataName;
		$scope.search();
	});

	$scope.ppId = $stateParams.ppId;
	$scope.$on('refreshViewDataForHead', function(event, data) {  
		$scope.search();
    });
	$scope.createProducePlan = function(id, name) {
		$state.go("app.addProducePlan", {
			ppId : id
		});
	}
	$scope.year = null;
	$http({
		method : "POST",
		url : "${ctx}/producePlan/getYearListForSearch.htm",
		params : {
			year:2015
		}
	}).success(function(result) {
		$scope.year = result.thisYear;
		$scope.yearList = result.yearList;
		//$("#year").val(result.thisYear);
		$scope.search();
	});
	$scope.search=function(){
		$http({
			method : "POST",
			url : "${ctx}/producePlan/producePlanList.htm",
			params : {
				year:$scope.year
				//year:$("#year").val()
			}
		}).success(function(result) {
			$scope.station = result;
		});
	};
	$scope.mergeCell = function(tableId,col){
		mergeColumn(tableId,col);
	}
});
</script>
<!-- 弹出层界面 -->
<div ng-controller="producePlanCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
		<span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
		<!-- <span class="font-h3 blue-1 m-n text-black">生产计划</span> -->
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
      
      <div class="col-sm-2 no-padder " style="margin-left:10px;">
      	<div class="col-sm-12  no-padder">
        <div class="input-group p-r-sm">
      <!--     <span class="input-group-btn">
            <button class="btn btn-sm btn-default" type="button">年份</button>
          </span> -->
        <select ng-model="year" id="year" class="form-control input-sm" ng-change="search()">
        <option ng-repeat="vo in yearList" value="{{vo}}"  ng-selected="year == vo">{{vo}}年</option>
        </select>
<!--         <span class="input-group-btn"> -->
<!--          	<button id="searchBtn" class="btn btn-sm btn-info" -->
<!-- 						ng-click="search();" type="button">查询</button> -->
<!--           </span> -->
        </div>
        </div>
      </div>
      <div class="col-sm-4 m-b-xs w-sm p-r-sm">     
          <button class="btn btn-sm btn-info m-r-xs" ng-click="createProducePlan();">填写生产计划</button>  
      </div>
       <div class="col-sm-3 no-padder">
       </div>
      <div class="col-sm-2 pull-right text-right-xs">
      	<span style="line-height:35px;">单位：kWh</span>
	  </div>
	</div>
		<table class="table table-striped b-t b-light bg-table" id="t">
			<tr >
			<th width="10%">企业名称</th>
			<th width="15%">电站</th>
			<th style="text-align: right;" width="10%">年度合计</th>
			<th style="text-align: right;" width="5%">1月</th>
			<th style="text-align: right;" width="5%">2月</th>
			<th style="text-align: right;" width="5%">3月</th>
			<th style="text-align: right;" width="5%">4月</th>
			<th style="text-align: right;" width="5%">5月</th>
			<th style="text-align: right;" width="5%">6月</th>
			<th style="text-align: right;" width="5%">7月</th>
			<th style="text-align: right;" width="5%">8月</th>
			<th style="text-align: right;" width="5%">9月</th>
			<th style="text-align: right;" width="5%">10月</th>
			<th style="text-align: right;" width="5%">11月</th>
			<th style="text-align: right;" width="5%">12月</th>
			</tr>
			<tr ng-repeat="vo in station" repeat-done="mergeCell('t',1);">
			<td ng-if="vo.companyname=='合计'" ng-bind="vo.companyname"  colspan="2" style="height: 80px"></td>
			<td ng-if="vo.companyname!='合计'" ng-bind="vo.companyname"></td>
			<td ng-if="vo.companyname!='合计'" ng-bind="vo.stationname">
			<td style="text-align: right;" ng-bind="vo.yearPlan  | number:0">
			<td style="text-align: right;" ng-repeat="plan in vo.producePlan" ng-bind="plan.plannedvalue | number:0"></td>
			</tr>
		</table>
		</div>
	</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>