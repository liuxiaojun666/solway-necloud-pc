<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
.green{color:rgb(34,174,153);}
.ticketExecuteNumber{margin-top:40px;}
.form-con{padding: 0 200px;position:relative;    margin-top: 20px;}
.save-formdata-btn{position: absolute;
    top: -42px;
    right: 200px;
    background: rgb(34,174,153);
    padding: 8px 20px;
    color: white;}
.border-green{border:1px solid rgb(34,174,153);}
.thead-other{position:absolute;right:5px;top:5px;}
.thead-ticket-type{position:absolute;left:5px;bottom:5px;}
.thead-line{height: 1px;
    background: rgb(34,174,153);
    width: 165px;
    position: absolute;
    transform: rotate(15.5deg);
    -ms-transform: rotate(15.5deg);
    -webkit-transform: rotate(15.5deg);
    -moz-transform: rotate(15.5deg);
    left: -3px;
    top: 22px;	}
.ticketExecuteNumber .table-striped > tbody > tr > td {
    border-right:1px solid rgb(34,174,153);
}

/* 两票情况 */
.ticket-situation{    margin-bottom: 30px;}
.add-line-btn{background: rgb(34,174,153);padding: 8px 20px;color: white;    float: right;}
.ticket-situation .list-item{margin-bottom:3px;height:40px;}
.ticket-situation .list-item:nth-child(even){background:rgb(188,234,231)}
.ticket-situation .list-item:nth-child(odd){background:rgb(206,238,235)}
.ticket-situation .list-item input{width:100%;background:transparent;height: 30px;margin: 5px 0 0;border: 1px solid rgb(159,159,159);}
.ticket-situation .list-item input:disabled {
    border: none;
    background-color: transparent;
}
</style>
<div  ng-controller="dtTicketAnalysisFillModelCtrl" class="page-con">
	<div class="text-center green">
		<h3 class="font22 ">葛沽两票分析</h3>
		<p>
			<span>时间：</span>
			<span class="input-append date form_datetime date-time-con" id="changeTimeId-stopTime" data-link-field="stopTime">
				<input type="hidden"  id="stopTime"/>
				<span id="showStopTime" class="showdate m-l m-r  font-h2" ng-bind="stopTime | date:'yyyy-MM'"></span>
				<span class="add-on" ng-hide="dateTimeAbleChange"><i class="icon-calendar" ></i></span>
			</span>
		</p>
	</div>
	<div class="ticketExecuteNumber">
		<h4 class="font18">一、两值两票执行份数</h4>
		<div class="form-con">
			<a ng-click="saveFormData()" class="save-formdata-btn">保存</a>
			<table class="table border-green table-striped">
				<thead style="background: #9fe8dd;">
					<tr class="font16" style="border-bottom:1px solid rgb(34,174,153);">
						<th style="position:relative;width: 160px;border-right: 1px solid rgb(34,174,153);border-bottom: 1px solid rgb(34,174,153);">
							<div class="thead-line"></div>
							<span class="thead-other">其他</span>
							<span class="thead-ticket-type">票种</span>
						</th>
						<th class="text-center" style="border-right: 1px solid rgb(34,174,153);border-bottom: 1px solid rgb(34,174,153);">发出数</th>
						<th class="text-center" style="border-right: 1px solid rgb(34,174,153);border-bottom: 1px solid rgb(34,174,153);">收回数</th>
						<th class="text-center" style="border-bottom: 1px solid rgb(34,174,153);">合格率</th>
					</tr>
				</thead>
				<tbody class="font12">
					<tr ng-repeat="item in formData">
						<td>{{item.ticketName}}</td>
						<td class="text-center"><input type="text" ng-model="item.ticketOutNum"></td>
						<td class="text-center"><input type="text" ng-model="item.ticketInNum"></td>
						<td class="text-center"><input type="text" ng-model="item.passRate"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 两票情况           二         -->
	<div class="ticket-situation clearfix" id="ticketType2">
		<div class="col-sm-12 no-padder clearfix">
			<div class="col-sm-6 no-padder"><h4 class="font18">二、两票情况</h4></div>
			<div class="col-sm-6 no-padder"><a ng-click="addTicketSituationLine()" class="add-line-btn">添加</a></div>
		</div>
		<div ng-repeat="item in ticketSituationList" class="col-sm-12 no-padder clearfix list-item"  id="ticketRowsType2{{item.id}}">
			<div class="col-sm-11"><input type="text" ng-model="item.content" name="content" ng-disabled="editOrSaveTicketSituation{{item.id}} != 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-hide="editOrSaveTicketSituation{{item.id}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketSituationRow({{item}})" ></i></a>
				<a class="text-info" ng-show="editOrSaveTicketSituation{{item.id}} == 'save'"><i class="icon-action-undo font16" ng-click="saveEditRow({{item}},$index,2)" ></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteEditRow({{item.id}},$index,2)"></i></a>
			</div>
		</div>
		<!-- 新添加的行 -->
		<div ng-repeat="item in addNewRowsTicketSituation" class="col-sm-12 no-padder clearfix list-item addRowsType2">
			<div class="col-sm-11"><input type="text" ng-model="item.content" name="content" ng-disabled="editOrSaveTicketSituationAdd{{$index}} == 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-show="editOrSaveTicketSituationAdd{{$index}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketSituationRowAdd($index)" ></i></a>
				<a class="text-info" ng-hide="editOrSaveTicketSituationAdd{{$index}} == 'save'"><i class="icon-action-undo font16" ng-click="saveAddRow($index,2)" ></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteAddRow($index,2)"></i></a>
			</div>
		</div>
		<p ng-show="ticketSituationList.length<=0 && addNewRowsTicketSituation.length<=0"  class="col-sm-12 no-padder clearfix list-item" style="padding-left: 1em !important;line-height:40px;">无</p>
	</div>
	
	<!-- 两票执行情况分析    三      -->
	<div class="ticket-situation clearfix" id="ticketType3">
		<div class="col-sm-12 no-padder clearfix">
			<div class="col-sm-6 no-padder"><h4 class="font18">三、两票执行情况分析</h4></div>
			<div class="col-sm-6 no-padder"><a ng-click="addTicketAnalysisLine()" class="add-line-btn">添加</a></div>
		</div>
		<div ng-repeat="item in ticketAnalysisList" class="col-sm-12 no-padder clearfix list-item"  id="ticketRowsType3{{item.id}}">
			<div class="col-sm-11"><input type="text" ng-model="item.content" name="content"   ng-disabled="editOrSaveTicketAnalysis{{item.id}} != 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-hide="editOrSaveTicketAnalysis{{item.id}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketAnalysisRow({{item}})" ></i></a>
				<a class="text-info" ng-show="editOrSaveTicketAnalysis{{item.id}} == 'save'"><i class="icon-action-undo font16" ng-click="saveEditRow({{item}},$index,3)" ></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteEditRow({{item.id}},$index,3)"></i></a>
			</div>
		</div>
		<!-- 新添加的行 -->
		<div ng-repeat="item in addNewRowsTicketAnalysis" class="col-sm-12 no-padder clearfix list-item addRowsType3">
			<div class="col-sm-11"><input type="text" ng-model="item.content"  name="content" ng-disabled="editOrSaveTicketAnalysisAdd{{$index}} == 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-show="editOrSaveTicketAnalysisAdd{{$index}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketAnalysisRowAdd($index)" ></i></a>
				<a class="text-info" ng-hide="editOrSaveTicketAnalysisAdd{{$index}} == 'save'"><i class="icon-action-undo font16"  ng-click="saveAddRow($index,3)"></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteAddRow($index,3)"></i></a>
			</div>
		</div>
		<p ng-show="ticketAnalysisList.length<=0 && addNewRowsTicketAnalysis.length<=0"  class="col-sm-12 no-padder clearfix list-item" style="padding-left: 1em !important;line-height:40px;">无</p>
	</div>
	
	<!-- 考核        四          -->
	<div class="ticket-situation clearfix" id="ticketType4">
		<div class="col-sm-12 no-padder clearfix">
			<div class="col-sm-6 no-padder"><h4 class="font18">四、考核</h4></div>
			<div class="col-sm-6 no-padder"><a ng-click="addTicketCheckLine()" class="add-line-btn">添加</a></div>
		</div>
		<div ng-repeat="item in ticketCheckList" class="col-sm-12 no-padder clearfix list-item"  id="ticketRowsType4{{item.id}}">
			<div class="col-sm-11"><input type="text" ng-model="item.content" name="content"  ng-disabled="editOrSaveTicketCheck{{item.id}} != 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-hide="editOrSaveTicketCheck{{item.id}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketCheckRow({{item}})" ></i></a>
				<a class="text-info" ng-show="editOrSaveTicketCheck{{item.id}} == 'save'"><i class="icon-action-undo font16" ng-click="saveEditRow({{item}},$index,4)" ></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteEditRow({{item.id}},$index,4)"></i></a>
			</div>
		</div>
		<!-- 新添加的行 -->
		<div ng-repeat="item in addNewRowsTicketCheck" class="col-sm-12 no-padder clearfix list-item addRowsType4">
			<div class="col-sm-11"><input type="text" ng-model="item.content"  name="content"  ng-disabled="editOrSaveTicketCheckAdd{{$index}} == 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-show="editOrSaveTicketCheckAdd{{$index}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketCheckRowAdd($index)" ></i></a>
				<a class="text-info" ng-hide="editOrSaveTicketCheckAdd{{$index}} == 'save'"><i class="icon-action-undo font16"  ng-click="saveAddRow($index,4)"></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteAddRow($index,4)"></i></a>
			</div>
		</div>
		<p ng-show="ticketCheckList.length<=0 && addNewRowsTicketCheck.length<=0"  class="col-sm-12 no-padder clearfix list-item" style="padding-left: 1em !important;line-height:40px;">无</p>
	</div>
	
	<!-- 整改措施            五         -->
	<div class="ticket-situation clearfix" id="ticketType5">
		<div class="col-sm-12 no-padder clearfix">
			<div class="col-sm-6 no-padder"><h4 class="font18">五、整改措施</h4></div>
			<div class="col-sm-6 no-padder"><a ng-click="addTicketMeasuresLine()" class="add-line-btn">添加</a></div>
		</div>
		<div ng-repeat="item in ticketMeasuresList" class="col-sm-12 no-padder clearfix list-item"  id="ticketRowsType5{{item.id}}">
			<div class="col-sm-11"><input type="text" ng-model="item.content"  name="content" ng-disabled="editOrSaveTicketMeasures{{item.id}} != 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-hide="editOrSaveTicketMeasures{{item.id}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketMeasuresRow({{item}})" ></i></a>
				<a class="text-info" ng-show="editOrSaveTicketMeasures{{item.id}} == 'save'"><i class="icon-action-undo font16" ng-click="saveEditRow({{item}},$index,5)" ></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteEditRow({{item.id}},$index,5)"></i></a>
			</div>
		</div>
		<!-- 新添加的行 -->
		<div ng-repeat="item in addNewRowsTicketMeasures" class="col-sm-12 no-padder clearfix list-item addRowsType5">
			<div class="col-sm-11"><input type="text" ng-model="item.content" name="content" ng-disabled="editOrSaveTicketMeasuresAdd{{$index}} == 'save'"></div>
			<div class="col-sm-1 text-center" style="line-height: 40px;">
				<a class="text-info" ng-show="editOrSaveTicketMeasuresAdd{{$index}} == 'save'"><i class="icon-note font16" ng-click="editItemTicketMeasuresRowAdd($index)" ></i></a>
				<a class="text-info" ng-hide="editOrSaveTicketMeasuresAdd{{$index}} == 'save'"><i class="icon-action-undo font16"  ng-click="saveAddRow($index,5)" ></i></a>
				<a class="text-info"><i class="icon-trash font16" ng-click="deleteAddRow($index,5)"></i></a>
			</div>
		</div>
		<p ng-show="ticketMeasuresList.length<=0 && addNewRowsTicketMeasures.length<=0"  class="col-sm-12 no-padder clearfix list-item" style="padding-left: 1em !important;line-height:40px;">无</p>
	</div>
</div>
<script>
app.controller('dtTicketAnalysisFillModelCtrl',function($scope, $http, $state, $stateParams) {
	
	//新增或者编辑
	$scope.ifAdd = false;
	function init(busiDate){
		initDate(busiDate);//时间初始化
		getTicketExecuteNumData();//获取两票执行份数数据
		
		for(var i = 2;i<6;i++){
			getTicketSituationData(i);//获取两票（二--------------五）
		}
	}
	
	$scope.ticketNames = [{"ticketName":"电气一种工作票","ticketType":108},
	                      {"ticketName":"电气二种工作票","ticketType":109},
							{"ticketName":"电力线路一种工作票","ticketType":110},
	                    	{"ticketName":"电力线路二种工作票","ticketType":111},
							{"ticketName":"电气倒闸操作票","ticketType":115},
	                    	{"ticketName":"断电保护措施票","ticketType":112},
							{"ticketName":"动火工作票","ticketType":113},
	                    	{"ticketName":"动土工作票","ticketType":114}];
	$scope.$on("fillItem",function(e,value){
		if(value != null){
			$scope.ifAdd = false;
			$scope.dateTimeAbleChange = true;
			
			$scope.dateStr = value.busiDate;
			$scope.stationId = value.stationId;
			$scope.id = value.id;
			init(value.busiDate);
			$scope.addNewRowsTicketSituation = [];
			$scope.addNewRowsTicketAnalysis = [];
			$scope.addNewRowsTicketCheck = [];
			$scope.addNewRowsTicketMeasures = [];
		}else{
			$scope.ifAdd = true;
			$scope.dateTimeAbleChange = false;
			
			$scope.dateStr = null;
			initDate(null);
			
			for(var i = 0;i<$scope.ticketNames.length;i++){
				$scope.ticketNames[i]["stationId"] = $scope.stationId;
				$scope.ticketNames[i]["ticketOutNum"] = null;
				$scope.ticketNames[i]["ticketInNum"] = null;
				$scope.ticketNames[i]["passRate"] = null;
			}
			$scope.formData = $scope.ticketNames;
			
			$scope.ticketSituationList = [];
			$scope.addNewRowsTicketSituation = [];
			$scope.ticketAnalysisList = [];
			$scope.addNewRowsTicketAnalysis = [];
			$scope.ticketCheckList = [];
			$scope.addNewRowsTicketCheck = [];
			$scope.ticketMeasuresList = [];
			$scope.addNewRowsTicketMeasures = [];
			
		}
	});
	
	
	//查询详情一
	function getTicketExecuteNumData(){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpmTicketNum/selectCurrData.htm",
	 		params : {
	 			stationId : $scope.stationId,
	 			dateStr:(new Date($scope.dateStr)).Format("yyyy-MM"),
			}
		 }).success(function(result) {
			 $scope.formData = result.data;
			 
		 })
	}
	
	//查询详情（二---------五）
	function getTicketSituationData(type){
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpmAnalysisData/selectCurrData.htm",
	 		params : {
	 			stationId : $scope.stationId,
	 			dateStr:(new Date($scope.dateStr)).Format("yyyy-MM"),
	 			analysisDataType:type,
			}
		 }).success(function(result) {
			 if(type == 2){
				 $scope.ticketSituationList = result.data;
			 }else if(type == 3){
				 $scope.ticketAnalysisList = result.data;
			 }else if(type == 4){
				 $scope.ticketCheckList = result.data;
			 }else if(type == 5){
				 $scope.ticketMeasuresList = result.data;
			 }
			
		 })
	}
	
	/* --------公用部分-------------- */
	
	//保存编辑
	$scope.saveEditRow = function(item,index,type){
		var $currentTr = $("#ticketType"+type).find("div.list-item").eq(index);
		var content = $currentTr.find("input[name = 'content']").val();
		$http({
	 		method : "POST",
	 		headers: {'Content-Type': 'application/x-www-form-urlencoded'},
	 		url : "${ctx}/rpmAnalysisData/update.htm",
            transformRequest: function (data) {
                return $.param(data);
            },
            data : {
            	id:item.id,
            	analysisId :$scope.id,
            	stationId: $scope.stationId,
            	dateStr:(new Date($scope.dateStr)).Format("yyyy-MM"),
            	content:content,
            	analysisDataType:type
            }
		 }).success(function(result) {
		 })
		 if(type == 2){
			 $scope['editOrSaveTicketSituation'+item.id] = "edit";
		 }else if(type == 3){
			 $scope['editOrSaveTicketAnalysis'+item.id] = "edit";
		 }else if(type == 4){
			 $scope['editOrSaveTicketCheck'+item.id] = "edit";
		 }else if(type == 5){
			 $scope['editOrSaveTicketMeasures'+item.id] = "edit";
		 }
	}
	
	//保存新增
	$scope.saveAddRow = function(index,type){
		var $currentTr =$(".addRowsType"+type).eq(index);
		var content = $currentTr.find("input[name = 'content']").val();
		var id = $currentTr.find("input[name = 'content']").attr("addTypeId"+type);
		$http({
	 		method : "POST",
	 		headers: {'Content-Type': 'application/x-www-form-urlencoded'},
	 		url : "${ctx}/rpmAnalysisData/update.htm",
            transformRequest: function (data) {
                return $.param(data);
            },
            data : {
            	id:id,
            	analysisId : $scope.id,
            	stationId: $scope.stationId,
            	dateStr:(new Date($scope.dateStr)).Format("yyyy-MM"),
            	content:content,
            	analysisDataType:type
            }
		 }).success(function(result) {
			 if(result.data){
				 $currentTr.find("input[name = 'content']").attr("addTypeId"+type,result.data)
			 }
		 })
		 if(type == 2){
			 $scope['editOrSaveTicketSituationAdd'+index] = "save";
		 }else if(type == 3){
			 $scope['editOrSaveTicketAnalysisAdd'+index] = "save";
		 }else if(type == 4){
			 $scope['editOrSaveTicketCheckAdd'+index] = "save";
		 }else if(type == 5){
			 $scope['editOrSaveTicketMeasuresAdd'+index] = "save";
		 }
		
	}
	
	//删除编辑
	$scope.deleteEditRow = function(id,index,type){
		if(confirm("确定删除此条数据吗？")){
			$http({
				method : "POST",
				url: "${ctx}/rpmAnalysisData/delete.htm",
				headers:{'Content-Type': 'application/x-www-form-urlencoded'},
				data: {
					id: id
				},
				transformRequest:function(data){
	                return $.param(data)
				}
			}).success(function(res) {
				$("#ticketRowsType"+type+id).remove();
			});
		}
	}
	
	//删除新增
	$scope.deleteAddRow = function(index,type){
		var $currentTr =$(".addRowsType"+type).eq(index);
		var id = $currentTr.find("input[name = 'content']").attr("addTypeId"+type);
		if(id){
			if(confirm("确定删除此条数据吗？")){
				
				$http({
					method : "POST",
					url: "${ctx}/rpmAnalysisData/delete.htm",
					headers:{'Content-Type': 'application/x-www-form-urlencoded'},
					data: {
						id: id
					},
					transformRequest:function(data){
		                return $.param(data)
					}
				}).success(function(res) {
				});
			}
		}
		
		$(".addRowsType"+type).eq(index).remove();
		if(type == 2){
			$scope.addNewRowsTicketSituation.splice(index,1);
		}else if(type == 3){
			$scope.addNewRowsTicketAnalysis.splice(index,1);
		}else if(type == 4){
			$scope.addNewRowsTicketCheck.splice(index,1);
		}else if(type == 5){
			$scope.addNewRowsTicketMeasures.splice(index,1);
		}
	}
	/* --------2、两票情况-------------- */
	
	//编辑-两票情况
	$scope.editItemTicketSituationRow = function(item){
		$scope['editOrSaveTicketSituation'+item.id] = "save";
	}
	
	//添加一行----两票情况
	$scope.addNewRowsTicketSituation = [];
	$scope.addTicketSituationLine = function(){
		$scope.addNewRowsTicketSituation.push([]);
	}
	
	//编辑-两票情况（新增）
	$scope.editItemTicketSituationRowAdd = function(index){
		$scope['editOrSaveTicketSituationAdd'+index] = "edit";
	}
	
	/* --------3、两票执行情况分析-------------- */
	
	//编辑-
	$scope.editItemTicketAnalysisRow = function(item){
		$scope['editOrSaveTicketAnalysis'+item.id] = "save";
	}

	//添加一行---
	$scope.addNewRowsTicketAnalysis = [];
	$scope.addTicketAnalysisLine = function(){
		$scope.addNewRowsTicketAnalysis.push([]);
	}
	
	//编辑-（新增）
	$scope.editItemTicketAnalysisRowAdd = function(index){
		$scope['editOrSaveTicketAnalysisAdd'+index] = "edit";
	}
	
	/* --------4、考核-------------- */
	
	//编辑
	$scope.editItemTicketCheckRow = function(item){
		$scope['editOrSaveTicketCheck'+item.id] = "save";
	}
	
	//添加一行
	$scope.addNewRowsTicketCheck = [];
	$scope.addTicketCheckLine = function(){
		$scope.addNewRowsTicketCheck.push([]);
	}
	
	//编辑-（新增）
	$scope.editItemTicketCheckRowAdd = function(index){
		$scope['editOrSaveTicketCheckAdd'+index] = "edit";
	}

	/* --------5、整改措施-------------- */
	
	//编辑
	$scope.editItemTicketMeasuresRow = function(item){
		$scope['editOrSaveTicketMeasures'+item.id] = "save";
	}
	
	//添加一行
	$scope.addNewRowsTicketMeasures = [];
	$scope.addTicketMeasuresLine = function(){
		$scope.addNewRowsTicketMeasures.push([]);
	}
	
	//编辑-（新增）
	$scope.editItemTicketMeasuresRowAdd = function(index){
		$scope['editOrSaveTicketMeasuresAdd'+index] = "edit";
	}
	
	function initDate(ParamTime){
		var rightDay = new Date();
		rightDay.setDate(rightDay.getDate() - 1);
		$scope.today = rightDay;
		
		if(ParamTime != null){
			var rightDay2 = new Date(ParamTime);
			$scope.stopTime = rightDay2;
			$("#stopTime").val($scope.stopTime.Format("yyyy-MM"));
			$("#showStopTime").text(new Date(ParamTime).Format("yyyy-MM"));
		}else{
			$scope.stopTime = null;
			$("#stopTime").val("");
		}
		
		$("#changeTimeId-stopTime").datetimepicker({
			language : 'zh-CN',
			format : "yyyy-mm",
			startView: 3,  
	        minView: 3,
			autoclose : true,
			todayBtn : true,
			endDate : $scope.today,
			initialDate : $scope.stopTime,
			pickerPosition : "bottom-left"
		});
		
		$("#changeTimeId-stopTime").on('hide',function(ev) {
			var stringTime = $("#stopTime").val();
			$scope.judgeSelectTime(stringTime,function(value){
				if(!value){
					alert("请选择未填写过的时间");
					return false;
				}else{
					var timestamp = Date.parse(getDateForStringDate(stringTime));
					$("#showStopTime").text(new Date(timestamp).Format("yyyy-MM"));
				}
			});
			
		});
	}
	
	
	//判断当前选择的时间是否符合通过
	$scope.judgeSelectTime = function(time,callback){
		var flag ;
		$http({
	 		method : "GET",
	 		url : "${ctx}/rpmTicketAnalysis/hasData.htm",
	 		params : {
	 			stationId : $scope.stationId,
	 			dateStr:(new Date(time)).Format("yyyy-MM"),
			}
		 }).success(function(result) {
			 if(result.code == 0){
				 flag = true;
			 }else{
				 flag = false;
			 }
			 
			 callback(flag);
		 })
	}
	
	//保存
	$scope.saveFormData = function(){
		
		
		if(!$scope.ifAdd){
			for(var i = 0;i<$scope.formData.length;i++){
				$scope.formData[i].stationId = $scope.stationId;
				$scope.formData[i].busiDate = (new Date($scope.dateStr)).Format("yyyy-MM");
			}
			saveFormData();
		}else{
			var stringTime = $("#stopTime").val();
			if(stringTime == ""){
				alert("请选择填报时间");
				return false;
			}
			for(var i = 0;i<$scope.formData.length;i++){
				$scope.formData[i].busiDate = (new Date(stringTime)).Format("yyyy-MM");
			}
			
			//判断当前是否选择了时间，选择并且通过即可，否则提示要选择合适的时间
			$scope.judgeSelectTime(stringTime,function(value){
				if(!value){
					alert("请选择未填写过的时间");
					return false;
				}else{
					
					saveFormData();
				}
			});
		}
	}
	
	//两值两票执行份数，保存接口
	function saveFormData(){
		$http({
			method : "POST",
			url: "${ctx}/rpmTicketNum/update.htm",
			data: $scope.formData
		}).success(function(result) {
			if(result.code == 0){
				promptObj('success', '', "保存成功");
			}else if(result.code == 1){
				promptObj('error', '',"保存失败");
			}
		});
	}
});
function getDateForStringDate(strDate){
	//切割年月日与时分秒称为数组
	var s = strDate.split(" ");
	var s1 = s[0].split("-");
	var s2 = s[1].split(":");
	if(s2.length==2){
		s2.push("00");
	}
	return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
}
</script>
