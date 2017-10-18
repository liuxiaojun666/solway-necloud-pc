<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.fill-title{color:#1cb09a;margin:17px 0 22px;}
.m-l-20{margin-left:20px;}
.border-green{border: 1px solid rgba(28,176,154,0.4);}
.fill-statistics{margin-top:5px;}
.table > tbody > tr > td, .table > tfoot > tr > td {
    padding: 5px 15px;border-right: 1px solid rgba(28,176,154,0.1);
}
.table > thead > tr > th {
   border-right: 1px solid rgba(28,176,154,0.1);
}
.input-disabled {
	border: none;
	background: transparent;
}
td input{width:100%;height: 29px;}
.word-red{color:#f75f5f;}
.defect-statistics >h3{color:#3f3f3f;border:1px solid #9fe8dd;height:40px;line-height:40px;    background: white;text-align: center;margin: 0;border-bottom: none;}
.today-finished-work{margin-bottom:20px;}
.today-finished-work >h3{color:#3f3f3f;border:1px solid #9fe8dd;height:40px;line-height:40px;    background: white;text-align: center;margin: 0;border-bottom: none;}
input:disabled{border: none;background-color: transparent;}
.m-b-no{margin-bottom:0;}
.add-tr-con{ background: white; height: 30px;line-height: 30px;padding-left: 17px;}
.blueword{color:#0072ff;}
.tomorrow-finished-work >h3{color:#3f3f3f;border:1px solid #9fe8dd;height:40px;line-height:40px;    background: white;text-align: center;margin: 0;border-bottom: none;}
</style>
<div  ng-controller="dtfillReportPageCtrl">
	<div class="page-title">
		<p class="clearfix" ng-if="dailyOperData.operation == 1">
			<a class="pull-right btn btn-sm btn-info m-r-8" style="padding: 10px 20px;width: auto;" ng-click="saveDailyOper(0)">保存</a>
			<a class="pull-right btn btn-sm btn-info m-r-8" style="padding: 10px 20px;width: auto;" ng-click="saveDailyOper(1)">保存并提交</a>
		</p>
		<p class="clearfix" ng-if="dailyOperData.operation == 2">
			<a class="pull-right btn btn-sm btn-info m-r-8" style="padding: 10px 20px;width: auto;" ng-click="doApproval(0)">通过</a>
			<a class="pull-right btn btn-sm btn-info m-r-8" style="padding: 10px 20px;width: auto;" ng-click="doApproval(-1)">不通过</a>
		</p>
		<h3 class="fill-title font26 text-center">{{dailyOperData.item.stationName}}运行情况日报表</h3>
		<div class="clearfix font14">
			<div class="pull-left" style="width:38%;"><span>报表编号：</span><span class="m-l-20">wtdrpt－1116661476－20170614</span></div>
			<div class="pull-left" style="width:28%;"><span>报表单位：</span><span class="m-l-20">{{dailyOperData.item.companyName}}</span></div>
			<div class="pull-left text-right" style="width:34%;"><span>统计时间：</span><span class="m-l-20">{{dailyOperData.item.busiDate}}</span></div>
		</div>
	</div>
	<div class="fill-statistics">
		<form id="serialize">
			<table id="result_table" class="table table-striped b-t b-light border-green">
				<thead style="background: #9fe8dd;">
					<tr class="font16">
						<th style="color:#f75f5f;">项目</th>
						<th class="text-center">数据统计</th>
						<th class="text-center">单位</th>
						<th style="color:#f75f5f;">项目</th>
						<th class="text-center">数据统计</th>
						<th class="text-center">单位</th>
					</tr>
				</thead>
				<tbody class="font14">
					<tr>
						<td>日发电量</td>
						<td class="text-center"><input name="dTW" ng-model="dailyOperData.item.dTW" type="text"></td>
						<td class="text-center">kWh</td>
						<td>日限电比</td>
						<td class="text-center"><input name="limitsTWRatio" type="text" ng-model="dailyOperData.item.limitsTWRatio" ></td>
						<td class="text-center">%</td>
					</tr>
					<tr>
						<td>日上网电量</td>
						<td class="text-center"><input name="dNetTW" type="text" ng-model="dailyOperData.item.dNetTW"></td>
						<td class="text-center">kWh</td>
						<td>日故障影响电量</td>
						<td class="text-center"><input name="dFaultEffectTW" type="text" ng-model="dailyOperData.item.dFaultEffectTW"></td>
						<td class="text-center">kWh</td>
					</tr>
					<tr>
						<td>日平均温度</td>
						<td class="text-center"><input name="dAvgC" ng-model="dailyOperData.item.dAvgC" type="text"></td>
						<td class="text-center">℃</td>
						<td>日维护影响电量</td>
						<td class="text-center"><input name="dMaintainEffectTW" type="text" ng-model="dailyOperData.item.dMaintainEffectTW"></td>
						<td class="text-center">kWh</td>
					</tr>
					<tr>
						<td>日总辐射量</td>
						<td class="text-center"><input name="dRadiation" type="text" ng-model="dailyOperData.item.dRadiation"></td>
						<td class="text-center">MJ/㎡</td>
						<td>日受累影响电量</td>
						<td class="text-center"><input name="dInvolvedEffectTW" type="text" ng-model="dailyOperData.item.dInvolvedEffectTW"></td>
						<td class="text-center">kWh</td>
					</tr>
					<tr>
						<td>日理论电量</td>
						<td class="text-center"><input name="dThoryTW" type="text" ng-model="dailyOperData.item.dThoryTW"></td>
						<td class="text-center">kWh</td>
						<td>日机组性能下降影响电量</td>
						<td class="text-center"><input name="dPerformanceDeclineEffectTW" type="text" ng-model="dailyOperData.item.dPerformanceDeclineEffectTW"></td>
						<td class="text-center">(%)</td>
					</tr>
					<tr>
						<td>日发电时间</td>
						<td class="text-center"><input name="dhours" type="text" ng-model="dailyOperData.item.dhours"></td>
						<td class="text-center">h</td>
						<td>日电站可利用率</td>
						<td class="text-center"><input name="dStationUtilizeRatio" type="text" ng-model="dailyOperData.item.dStationUtilizeRatio"></td>
						<td class="text-center">%</td>
					</tr>
					<tr>
						<td>日购网电量</td>
						<td class="text-center"><input name="dNetBuyTW" type="text" ng-model="dailyOperData.item.dNetBuyTW"></td>
						<td class="text-center">kWh</td>
						<td>月计划电量</td>
						<td class="text-center"><input name="mPlanTW" type="text" ng-model="dailyOperData.item.mPlanTW"></td>
						<td class="text-center">kWh</td>
					</tr>
					<tr>
						<td>日备用电侧购网电量</td>
						<td class="text-center"><input name="dNetSideBuyTWBack" type="text" ng-model="dailyOperData.item.dNetSideBuyTWBack"></td>
						<td class="text-center">kWh</td>
						<td>月发电量</td>
						<td class="text-center"><input name="mTW" type="text" ng-model="dailyOperData.item.mTW"></td>
						<td class="text-center">%</td>
					</tr>
					<tr>
						<td>日场用电量</td>
						<td class="text-center"><input name="dFUseTW" type="text" ng-model="dailyOperData.item.dFUseTW"></td>
						<td class="text-center">%</td>
						<td>月度计划完成率</td>
						<td class="text-center"><input name="mPlanCompleteRatio" type="text" ng-model="dailyOperData.item.mPlanCompleteRatio"></td>
						<td class="text-center">%</td>
					</tr>
					<tr>
						<td>日场用电率</td>
						<td class="text-center"><input name="dFUseTWRatio" type="text" ng-model="dailyOperData.item.dFUseTWRatio"></td>
						<td class="text-center">kWh</td>
						<td>年计划电量</td>
						<td class="text-center"><input name="yPlanTW" type="text" ng-model="dailyOperData.item.yPlanTW"></td>
						<td class="text-center">kWh</td>
					</tr>
					<tr>
						<td>日综合场用电量</td>
						<td class="text-center"><input name="dComFUseTW" type="text" ng-model="dailyOperData.item.dComFUseTW"></td>
						<td class="text-center">kWh</td>
						<td>年发电量</td>
						<td class="text-center"><input name="yTW" type="text" ng-model="dailyOperData.item.yTW"></td>
						<td class="text-center">%</td>
					</tr>
					<tr>
						<td>日综合场用电率</td>
						<td class="text-center"><input name="dComFUseTWRatio" type="text" ng-model="dailyOperData.item.dComFUseTWRatio"></td>
						<td class="text-center">%</td>
						<td>年度计划完成率</td>
						<td class="text-center"><input name="yPlanCompleteRatio" type="text" ng-model="dailyOperData.item.yPlanCompleteRatio"></td>
						<td class="text-center">%</td>
					</tr>
					<tr>
						<td>日电网调峰影响电量</td>
						<td class="text-center"><input name="dMaintainEffectTW" type="text" ng-model="dailyOperData.item.dMaintainEffectTW"></td>
						<td class="text-center">kWh</td>
						<td></td>
						<td class="text-center"></td>
						<td class="text-center"></td>
					</tr>
				</tbody>
			</table>		
		</form>
	</div>
	<div class="defect-statistics">
		<h3 class="font18">缺陷统计</h3>
		<table id="defect_table" class="table table-striped b-t b-light border-green">
			<thead style="background: #9fe8dd;">
				<tr class="font16">
					<th class="text-center">风场</th>
					<th class="text-center">设备名称</th>
					<th class="text-center">缺陷内容</th>
					<th class="text-center">类型</th>
					<th class="text-center">工作票号</th>
					<th class="text-center">停运时间</th>
					<th class="text-center">停运风速（m/s）</th>
					<th class="text-center">消缺时间</th>
					<th class="text-center">处理经过</th>
				</tr>
			</thead>
			<tbody class="font14">
				<tr ng-repeat="item in defectStatisticsList">
					<td class="" >{{item.stationName}}</td>
					<td class="text-center blueword">{{item.device_name}}</td>
					<td class="text-center">{{item.faultContent}}</td>
					<td class="text-center">{{item.faultType}}</td>
					<td class="text-center">{{item.workTicketNum}}</td>
					<td class="text-center">{{item.stopTime}}</td>
					<td class="text-center">{{item.illuminationIntensity}}</td>
					<td class="text-center">{{item.deOxygenTime}}</td>
					<td class="text-center">{{item.doProcess}}</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="today-finished-work">
		<h3 class="font18">当日计划完成工作情况</h3>
		<table id="currentWork_table" class="table table-striped b-t b-light border-green m-b-no">
			<thead style="background: #9fe8dd;">
				<tr class="font16">
					<th class="text-center" style="width:150px;">风电场</th>
					<th class="text-center" style="width:130px;">计划工作日期</th>
					<th class="text-center">计划工作内容</th>
					<th class="text-center" style="width:80px;">填报人</th>
					<th class="text-center" style="width:100px;">是否完成</th>
					<th class="text-center" style="width:200px;">备注</th>
					<th ng-if="dailyOperData.operation == 1" class="text-center" style="width:80px;">操作</th>
				</tr>
			</thead>
			<tbody class="font14">
				<tr ng-repeat="item in todayFinishedWorkList" class="workRows" id="workRows{{item.id}}">
					<td><input type="text"  name="name" ng-model="item.name" ng-disabled="true"></td>
					<td><input type="text" name="time" ng-model="item.time" ng-disabled="true"></td>
					<td><input type="text" name="desc" ng-model="item.desc" ng-disabled="editOrSave{{item.id}} != 'save'"></td>
					<td><input type="text" name="username" ng-model="item.username" ng-disabled="true"></td>
					<td>
						<select ng-class="(editOrSave{{item.id}} != 'save') ? 'input-disabled' : ''" name="ifFinished" ng-model="item.ifFinished" ng-disabled="editOrSave{{item.id}} != 'save'">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
						<!-- <input type="text" name="ifFinished" ng-model="item.ifFinished" ng-disabled="editOrSave{{item.id}} != 'save'"> -->
					</td>
					<td><input type="text" name="remarks" ng-model="item.remark"  ng-disabled="editOrSave{{item.id}} != 'save'"></td>
					<td ng-if="dailyOperData.operation == 1">
						<a class="text-info" ng-hide="editOrSave{{item.id}} == 'save'"><i class="icon-note font16" ng-click="editTodayItemWorkRow({{item}})" ></i></a>
						<a class="text-info" ng-show="editOrSave{{item.id}} == 'save'"><i class="icon-action-undo font16" ng-click="saveTodayItemWorkRow(0, item, $index, 'currentWork_table')" ></i></a>
						<a class="text-info"><i class="icon-trash font16" ng-click="deleteTodayItemWorkRow({{item.id}}, '0')"></i></a>
					</td>
				</tr>
				<!-- 新添加的行 -->
				<tr ng-repeat="item in addNewRowsCurrentDay" class="addRows">
					<td><input type="text"  name="name" class="input-disabled" ng-model="dailyOperData.item.stationName" ng-disabled="true"></td>
					<td><input type="text" name="time" class="input-disabled" ng-model="dailyOperData.item.busiDate"  ng-disabled="true"></td>
					<td><input type="text" name="desc"></td>
					<td><input type="text" name="username" ng-model="dailyOperData.item.createUserName" ng-disabled="true"></td>
					<td>
						<select name="ifFinished">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
						<!-- <input type="text" name="ifFinished" ng-disabled="editOrSaveAdd{{$index}} == 'save'"> -->
					</td>
					<td><input type="text" name="remarks"></td>
					<td>
						<a class="text-info" ng-show="editOrSaveAdd{{$index}} == 'save'"><i class="icon-note font16" ng-click="editTodayItemAddRow($index)" ></i></a>
						<a class="text-info" ng-hide="editOrSaveAdd{{$index}} == 'save'"><i class="icon-action-undo font16 "  ng-click="saveTodayAddRow($index, '0', 'addRows')"></i></a>
						<a class="text-info"><i class="icon-trash font16"  ng-click="deleteTodayAddRow($index)"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
		<p ng-if="dailyOperData.operation == 1" class="add-tr-con"><a class="inline-block" ng-click="addTrInputRowCurrentDay()"><img src="theme/images/datang/report/add-row-btn.png" style="margin-right:12px; vertical-align: text-bottom;width: 20px;"><span class="font16 blueword">增加</span></a></p>
	</div>
	<div class="tomorrow-finished-work">
		<h3 class="font18">次日计划完成工作情况</h3>
		<table id="tomorrowWork_table" class="table table-striped b-t b-light border-green m-b-no">
			<thead style="background: #9fe8dd;">
				<tr class="font16">
					<th class="text-center" style="width:150px;">风电场</th>
					<th class="text-center" style="width:130px;">计划工作日期</th>
					<th class="text-center">计划工作内容</th>
					<th class="text-center" style="width:80px;">填报人</th>
					<th class="text-center" style="width:100px;">是否完成</th>
					<th class="text-center" style="width:200px;">备注</th>
					<th ng-if="dailyOperData.operation == 1" class="text-center" style="width:80px;">操作</th>
				</tr>
			</thead>
			<tbody class="font14">
				<tr ng-repeat="item in tomorrowFinishedWorkList" id="tomorrowWorkRows{{item.id}}">
					<td><input type="text"  name="name" ng-model="item.name" ng-disabled="true"></td>
					<td><input type="text" name="time" ng-model="item.time" ng-disabled="true"></td>
					<td><input type="text" name="desc" ng-model="item.desc" ng-disabled="editOrSaveTomorrow{{item.id}} != 'save'"></td>
					<td><input type="text" name="username" ng-model="item.username" ng-disabled="true"></td>
					<td>
						<select ng-class="(editOrSaveTomorrow{{item.id}} != 'save') ? 'input-disabled' : ''" name="ifFinished" ng-model="item.ifFinished" ng-disabled="editOrSaveTomorrow{{item.id}} != 'save'">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
						<!-- <input type="text" name="ifFinished" ng-model="item.ifFinished" ng-disabled="editOrSaveTomorrow{{item.id}} != 'save'"> -->
					</td>
					<td><input type="text" name="remarks" ng-model="item.remark"  ng-disabled="editOrSaveTomorrow{{item.id}} != 'save'"></td>
					<td ng-if="dailyOperData.operation == 1">
						<a class="text-info" ng-hide="editOrSaveTomorrow{{item.id}} == 'save'"><i class="icon-note font16" ng-click="editTomorrowItemWorkRow({{item}})" ></i></a>
						<a class="text-info" ng-show="editOrSaveTomorrow{{item.id}} == 'save'"><i class="icon-action-undo font16" ng-click="saveTodayItemWorkRow(1, item, $index, 'tomorrowWork_table')" ></i></a>
						<a class="text-info"><i class="icon-trash font16" ng-click="deleteTodayItemWorkRow({{item.id}}, '1')"></i></a>
					</td>
				</tr>
				<!-- 新添加的行 -->
				<tr ng-repeat="item in addNewRowsTomorrow" class="addRowsTomorrow">
					<td><input type="text"  name="name" class="input-disabled" ng-model="dailyOperData.item.stationName" ng-disabled="true"></td>
					<td><input type="text" name="time" class="input-disabled" ng-model="dailyOperData.item.busiDate"  ng-disabled="true"></td>
					<td><input type="text" name="desc"></td>
					<td><input type="text" name="username" ng-model="dailyOperData.item.createUserName" ng-disabled="true"></td>
					<td>
						<select name="ifFinished">
							<option value="0">是</option>
							<option value="1">否</option>
						</select>
					<!-- <input type="text" name="ifFinished" ng-disabled="editOrSaveTomorrowAdd{{$index}} == 'save'"> -->
					</td>
					<td><input type="text" name="remarks"></td>
					<td>
						<a class="text-info" ng-show="editOrSaveTomorrowAdd{{$index}} == 'save'"><i class="icon-note font16" ng-click="editTomorrowItemAddRow($index)" ></i></a>
						<a class="text-info" ng-hide="editOrSaveTomorrowAdd{{$index}} == 'save'"><i class="icon-action-undo font16 "  ng-click="saveTodayAddRow($index, '1', 'addRowsTomorrow')"></i></a>
						<a class="text-info"><i class="icon-trash font16"  ng-click="deleteTomorrowAddRow($index)"></i></a>
					</td>
				</tr>
			</tbody>
		</table>
		<p ng-if="dailyOperData.operation == 1" class="add-tr-con"><a class="inline-block" ng-click="addTrInputRowTomorrow()"><img src="theme/images/datang/report/add-row-btn.png" style="margin-right:12px; vertical-align: text-bottom;width: 20px;"><span class="font16 blueword">增加</span></a></p>
	</div>
</div>
<script>
app.controller('dtfillReportPageCtrl',function($scope, $http, $state, $stateParams, $timeout) {

	$scope.$on('fillItem', function (e, data, processData) {
		fillItemFun(data, processData)
	})

	/**
	 * 获取填报数据
	 * [fillItemFun description]
	 * @return {[type]} [description]
	 */
	function fillItemFun(data, processData) {
		$http({
			method : "GET",
			url : "${ctx}/rpds/getApplyData.htm",
			params: {
				stationId: data.stationId,
				processId: processData.processId,
				processName: processData.processName,
				orderId: data.orderId,
				taskId: data.taskId,
				dateStr: new Date(data.busiDate).Format('yyyy-MM-dd')
			}
		}).success(function(res) {

			res.item.busiDate = new Date(res.item.busiDate).Format('yyyy-MM-dd')
			res.item.createDate = new Date(res.item.createDate).Format('yyyy-MM-dd')
			res.item.modifyDate = new Date(res.item.modifyDate).Format('yyyy-MM-dd')

			$scope.dailyOperData = res

			if (res.operation !== 1) {
				$('#result_table input').prop('disabled', true).addClass('input-disabled')
			} else {
				$('#result_table input').prop('disabled', false).removeClass('input-disabled')
			}

			init()
		});
	}

	/**
	 * 取数据， 缺陷数据   完成情况数据（今日，明日）
	 * [init description]
	 * @return {[type]} [description]
	 */
	function init(){
		getDefectStatisticsData();//获取缺陷统计接口
		getTodayFinishedWorkData('0');//获取完成工作情况接口（今日）
		getTodayFinishedWorkData('1');//获取完成工作情况接口（次日）
	}
	
	/**
	 * [getDefectStatisticsData 获取缺陷统计接口]
	 * @return {[type]} [description]
	 */
	function getDefectStatisticsData(){
		//接口
		$http({
			method : "GET",
			url : "${ctx}/rpdFault/selectCurrData.htm",
			params: {
				dateStr: $scope.dailyOperData.item.busiDate,
				stationId: $scope.dailyOperData.item.stationId,
				type: 1
			}
		}).success(function(res) {
			$scope.defectStatisticsList = res.data
		})
	}
	
	/**
	 * [getTodayFinishedWorkData 获取完成工作情况接口]
	 * @param  {[type]} type 0 今日  1 次日
	 * @return {[type]}      [description]
	 */
	function getTodayFinishedWorkData(type){
		//接口
		$http({
			method : "GET",
			url : "${ctx}/rpdBriefing/selectCurrData.htm",
			params: {
				dateStr: $scope.dailyOperData.item.busiDate,
				type: type,
				stationId: $scope.dailyOperData.item.stationId
			}
		}).success(function(res) {
			var result = res.data.map(function (v, i) {
				return {
					id: v.id,
					name: v.stationName,
					time: new Date(v.busiDate).Format('yyyy-MM-dd'),
					desc: v.completeContent,
					username: v.createUserName,
					ifFinished: v.completeStatus,
					remark: v.remark
				}
			})
			if (type === '0') {
				$scope.todayFinishedWorkList = result
			} else if (type === '1') {
				$scope.tomorrowFinishedWorkList = result
			}
		});
	}


	/**
	 * [updateData 更新今日明日数据]
	 * @param  {[type]} type       0 今日   1次日
	 * @param  {[type]} remarks    备注
	 * @param  {[type]} desc       内容
	 * @param  {[type]} ifFinished 0完成  1未完成
	 * @param  {[type]} id         该条计划id 不传 加数据  传 修改数据
	 * @return {[type]}            [description]
	 */
	function updateData(type,remarks,desc,ifFinished,id) {
		$http({
			method : "POST",
			url: "${ctx}/rpdBriefing/update.htm",
			headers:{'Content-Type': 'application/x-www-form-urlencoded'},
			data: {
				busiDate: $scope.dailyOperData.item.busiDate,
				type: type,
				stationId: $scope.dailyOperData.item.stationId,
				remark: remarks,
				completeContent: desc,
				completeStatus: ifFinished,
				id: id || ''
			},
			transformRequest:function(data){
                return $.param(data)
			}
		}).success(function(res) {
			getTodayFinishedWorkData(type)
		});
	}

	/**
	 * 审核
	 * @param  {number} approval 0 通过 -1不通过
	 * @return {[type]}          [description]
	 */
	$scope.doApproval = function (approval) {
		$http({
			method : "POST",
			url: "${ctx}/snaker/flow/doApproval.htm",
			headers:{'Content-Type': 'application/x-www-form-urlencoded'},
			data: {
				processId: $scope.dailyOperData.processId,
				orderId: $scope.dailyOperData.orderId,
				taskId: $scope.dailyOperData.taskId,
				taskName: $scope.dailyOperData.taskName,
				taskKey: $scope.dailyOperData.taskKey,
				state: approval,
				description: ''
			},
			transformRequest:function(data){
                return $.param(data)
			}
		}).success(function(res) {
			if (res.code != 0) {
				promptObj('error', '', "审批失败")
				return
			}
			promptObj('success', '', "审批成功")

			$timeout(function() {
				$("#selectedList").hide()
				$scope.$emit("changeHeaderTab", "listPage", true)
			}, 3000);
		});
	}
	
	
	//保存电厂运行情况日报表
	$scope.saveDailyOper = function(isSubmit){

		var data = $('#serialize').parseForm()
		data.processId = $scope.dailyOperData.processId
		data.taskId = $scope.dailyOperData.taskId
		data.operation = $scope.dailyOperData.operation
		data.id = $scope.dailyOperData.item.id
		data.companyId = $scope.dailyOperData.item.companyId
		data.stationId = $scope.dailyOperData.item.stationId
		data.busiDate = $scope.dailyOperData.item.busiDate
		data.modifyFlag = 0
		data.processFlag = isSubmit

		$http({
			method : "POST",
			url : "${ctx}/rpds/update.htm",
			// headers:{'Content-Type': 'application/x-www-form-urlencoded'},
			params: data
		}).success(function(res) {
			if (res.code != 0) {
				promptObj('success', '', "保存失败")
				return
			}
			promptObj('success', '', "保存成功")

			$timeout(function() {
				$("#selectedList").hide()
				$scope.$emit("changeHeaderTab", "listPage", true);
			}, 3000);
		});
	}
	//编辑-当日
	$scope.editTodayItemWorkRow = function(item){
		$scope['editOrSave'+item.id] = "save";
	}
	
	//保存-当日/次日
	$scope.saveTodayItemWorkRow = function(type, item,index,ele){
		
		var $currentTr = $("#" + ele).find("tr").eq(index+1);
		var desc = $currentTr.find("input[name = 'desc']").val();
		var username = $currentTr.find("input[name = 'username']").val();
		var ifFinished = $currentTr.find("[name = 'ifFinished']").val();
		var remarks = $currentTr.find("input[name = 'remarks']").val();

		if (type == 0) {
			$scope['editOrSave'+item.id] = "edit";
		} else {
			$scope['editOrSaveTomorrow'+item.id] = "edit";			
		}
		// 保存接口
		updateData(type, remarks,desc,ifFinished,item.id)

	}
	
	//删除-当日/次日
	$scope.deleteTodayItemWorkRow = function(id,type){
		if(confirm("确定删除此条数据吗？")){
			//删除接口？？？？（需要返回删除后的最新数据）
			$("#workRows"+id).remove();

			$http({
			method : "POST",
			url: "${ctx}/rpdBriefing/delete.htm",
			headers:{'Content-Type': 'application/x-www-form-urlencoded'},
			data: {
				busiDate: $scope.dailyOperData.item.busiDate,
				type: type,
				stationId: $scope.dailyOperData.item.stationId,
				id: id
			},
			
			transformRequest:function(data){
                return $.param(data)
			}
		}).success(function(res) {
			getTodayFinishedWorkData(type)
		});
		}
	}
	
	//添加一行----当日
	$scope.addNewRowsCurrentDay = [];
	$scope.addTrInputRowCurrentDay = function(){
		$scope.addNewRowsCurrentDay.push([]);
	}
	
	//编辑-当日（新增）
	$scope.editTodayItemAddRow = function(index){
		$scope['editOrSaveAdd'+index] = "edit";
	}
	//保存-当日/次日 计划（新增）
	$scope.saveTodayAddRow = function(index, type, ele, id){
		var $currentTr =$('.' + ele).eq(index);
		var desc = $currentTr.find("input[name = 'desc']").val();
		var username = $currentTr.find("input[name = 'username']").val();
		var ifFinished = $currentTr.find("[name = 'ifFinished']").val();
		var remarks = $currentTr.find("input[name = 'remarks']").val();

		$currentTr.remove()

		
		// 保存接口？？？（需要返回最新数据）
		
		if (type === '0') {
			$scope['editOrSaveAdd'+index] = "save";
			$scope.addNewRowsCurrentDay.shift()
		} else if (type === '1') {
			$scope['editOrSaveTomorrowAdd'+index] = "save";		
			$scope.addNewRowsTomorrow.shift()
		} 



		updateData(type, remarks,desc,ifFinished,id)
	}
	//删除-当日（新增）
	$scope.deleteTodayAddRow = function(index){
		$(".addRows").eq(index).remove();
		$scope.addNewRowsCurrentDay.splice(index,1);
	}
	
	/* -----------------次日开始 ------------------ */
	
	//编辑-次日
	$scope.editTomorrowItemWorkRow = function(item){
		$scope['editOrSaveTomorrow'+item.id] = "save";
	}
	
	//保存-次日
	$scope.saveTomorrowItemWorkRow = function(item,index){
		
		var $currentTr = $("#tomorrowWork_table").find("tr").eq(index+1);
		var name = $currentTr.find("input[name = 'name']").val();
		var time = $currentTr.find("input[name = 'time']").val();
		var desc = $currentTr.find("input[name = 'desc']").val();
		var username = $currentTr.find("input[name = 'username']").val();
		var ifFinished = $currentTr.find("input[name = 'ifFinished']").val();
		var remarks = $currentTr.find("input[name = 'remarks']").val();
		
		// 保存接口？？？（需要返回最新数据）
		
		$scope['editOrSaveTomorrow'+item.id] = "edit";
	}
	
	//添加一行----次日
	$scope.addNewRowsTomorrow = [];
	$scope.addTrInputRowTomorrow = function(){
		$scope.addNewRowsTomorrow.push([]);
	}
	
	//编辑-次日（新增）
	$scope.editTomorrowItemAddRow = function(index){
		$scope['editOrSaveTomorrowAdd'+index] = "edit";
	}
	//保存-次日（新增）
	$scope.saveTomorrowAddRow = function(index){
		var $currentTr =$(".addRowsTomorrow").eq(index);
		var name = $currentTr.find("input[name = 'name']").val();
		var time = $currentTr.find("input[name = 'time']").val();
		var desc = $currentTr.find("input[name = 'desc']").val();
		var username = $currentTr.find("input[name = 'username']").val();
		var ifFinished = $currentTr.find("input[name = 'ifFinished']").val();
		var remarks = $currentTr.find("input[name = 'remarks']").val();
		
		// 保存接口？？？（需要返回最新数据）
		
		$scope['editOrSaveTomorrowAdd'+index] = "save";
		
	}
	//删除-次日（新增）
	$scope.deleteTomorrowAddRow = function(index){
		$(".addRowsTomorrow").eq(index).remove();
		$scope.addNewRowsTomorrow.splice(index,1);
	}
	
});


   (function($){
        $.fn.parseForm=function(){
            var serializeObj={};
            var array=this.serializeArray();
            var str=this.serialize();
            $(array).each(function(){
                if(serializeObj[this.name]){
                    if($.isArray(serializeObj[this.name])){
                        serializeObj[this.name].push(this.value);
                    }else{
                        serializeObj[this.name]=[serializeObj[this.name],this.value];
                    }
                }else{
                    serializeObj[this.name]=this.value; 
                }
            });
            return serializeObj;
        };
    })(jQuery);

    function getDateForStringDate(strDate){
		//切割年月日与时分秒称为数组
		var s = strDate.split(" ");
		var s1 = s[0].split("-");
		return new Date(s1[0],s1[1]-1,s1[2],00,00,00);
	}

</script>
