<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="col-sm-12 no-padder panel fault-rt-b-t"
	ng-controller="juncBoxMCtrl">
	<div id="juncBox-table2"></div>
	 <div ng-include="showJuncBoxColumn" id="showJuncBoxColumnId"></div>

</div>

<script type="text/javascript">
//var bjTimer;
	app.controller('juncBoxMCtrl',function($scope, $http, $state, $document) {
		$document.on('screenfull.raw.fullscreenchange', function () {
			  if(responseHeight1){responseHeight1();};
		});
		$scope.$on("filterPageJunction", function (event, msg) {
			getbJunctionData($scope, $http);
		});

						//汇流箱监控
						/* $scope.toJunctionBoxMonitor = function(id,serialnumber, pstationid) {
							
							$http({
								method : "POST",
								url : "${ctx}/JunctionBox/selectByConditionMap.htm",
								params : {
									stid: pstationid,
									sn: serialnumber
								}
								}).success(function(result) {
									if(result){
										$state.go("app.junctionBoxMonitor", {
											InId : result.id,
											serialnumber : serialnumber,
											pstationid : pstationid
										});
									}
									
								});
							
						} */
						$scope.gridOptions = {
							data : 'myData',
							enablePinning : true,
							enableCellSelection : true,
							columnDefs : [
									{
										field : 'statusDesc',
										displayName : '状态',
										width : 80,
										pinned : true,
										cellClass : 'text-center',
										cellTemplate: 'tpl/rtMonitorPage/deviceStation/colourOf-COMM_STATUS.html'
									},
									{
										field : 'did',
										displayName : '编号',
										width : 60,
										pinned : true
									},
									{
										field : 'name',
										displayName : '名称',
										width : 120,
										pinned : true,
										cellTemplate : ' <span class="nowrap href-blur" data-toggle="tooltip" data-placement="bottom" style="line-height: 40px;" title="{{row.getProperty(col.field)}}" ng-click="toJunctionBoxMonitor(row.getProperty(\'sid\'),row.getProperty(\'did\'),row.getProperty(\'sid\'));">{{row.getProperty(col.field)}}</span>'
									},
									{
										field : 'dtime',
										displayName : '时间',
										width : 120,
										cellFilter : 'date:"yyyy-MM-dd HH:mm:ss"',
										pinned : true,
										cellClass : 'text-center'
									}, {
										field : 'k',
										displayName : '开关',
										width : 60,
										pinned : true,
										cellClass : 'text-center',
										cellTemplate :
										'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'k\')==\'0\'">无效</span> <span'+
										' ng-if="row.getProperty(\'k\')==\'1\'"><img title="无效" class="icon-size"  src=\'${ctx}/theme/images/junctionBoxMonitor/unknow.png\'></span> <span'+
										' ng-if="row.getProperty(\'k\')==\'2\'"><img title="闭合" class="icon-size"  src=\'${ctx}/theme/images/junctionBoxMonitor/run.png\'></span> <span'+
										' ng-if="row.getProperty(\'k\')==\'3\'"><img title="开启" class="icon-size" src=\'${ctx}/theme/images/junctionBoxMonitor/close.png\'></span></span> '

									}, {
										field : 'arrester',
										displayName : '防雷器',
										width : 60,
										pinned : true,
										cellClass : 'text-center',
										cellTemplate :'<span  style="line-height: 40px;"><span ng-if="row.getProperty(\'arrester\')==\'0\'">无效</span> <span'+
										' ng-if="row.getProperty(\'arrester\')==\'1\'"><img title="无效" class="icon-size"  src=\'${ctx}/theme/images/junctionBoxMonitor/blzUnknow.png\'></span> <span'+
										' ng-if="row.getProperty(\'arrester\')==\'2\'"><img title="正常" class="icon-size"  src=\'${ctx}/theme/images/junctionBoxMonitor/blzRun.png\'></span> <span'+
										' ng-if="row.getProperty(\'arrester\')==\'3\'"><img title="异常" class="icon-size"  src=\'${ctx}/theme/images/junctionBoxMonitor/blzFault.png\'></span></span> '
							
									}, {
										field : 'u',
										displayName : '电压(V)',
										width : 80,
										pinned : true,
										cellFilter : 'number:2',
										cellClass : 'text-right'
									}, {
										field : 'c',
										displayName : '电流(A)',
										width : 80,
										pinned : true,
										cellFilter : 'number:2',
										cellClass : 'text-right'
									}, {
										field : 'p',
										displayName : '功率(kW)',
										width : 80,
										pinned : true,
										cellFilter : 'number:2',
										cellClass : 'text-right'
									}, {
										field : 'c1',
										displayName : '1',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
										 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[0]\')== \'1\'}"'+
											'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[0]\')==\'3\'">'+
												'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
											'</span>'+
											'<span ng-if="row.getProperty(\'statuFlags[0]\')==\'0\'" class="handle3">'+
												'<span> - </span>'+
											'</span>'+
											'<span ng-if="row.getProperty(\'statuFlags[0]\')==\'1\'" class="data-red">'+
												'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
											'<span ng-if="row.getProperty(\'statuFlags[0]\')==\'2\'" class="data-yellow">'+
												'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
											'</span></div></div>'
									}, {
										field : 'c2',
										displayName : '2',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[1]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[1]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[1]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[1]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[1]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c3',
										displayName : '3',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[2]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[2]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[2]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[2]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[2]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c4',
										displayName : '4',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[3]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[3]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[3]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[3]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[3]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c5',
										displayName : '5',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[4]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[4]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[4]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[4]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[4]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c6',
										displayName : '6',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[5]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[5]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[5]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[5]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[5]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c7',
										displayName : '7',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[6]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[6]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[6]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[6]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[6]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c8',
										displayName : '8',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[7]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[7]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[7]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[7]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[7]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c9',
										displayName : '9',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[8]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[8]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[8]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[8]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[8]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c10',
										displayName : '10',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[9]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[9]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[9]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[9]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[9]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c11',
										displayName : '11',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[10]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[10]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[10]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[10]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[10]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c12',
										displayName : '12',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[11]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[11]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[11]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[11]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[11]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c13',
										displayName : '13',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[12]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[12]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[12]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[12]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[12]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c14',
										displayName : '14',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[13]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[13]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[13]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[13]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[13]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c15',
										displayName : '15',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[14]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[14]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[14]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[14]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[14]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c16',
										displayName : '16',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[15]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[15]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[15]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[15]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[15]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c17',
										displayName : '17',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[16]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[16]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[16]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[16]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[16]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c18',
										displayName : '18',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[17]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[17]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[17]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[17]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[17]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c19',
										displayName : '19',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[18]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[18]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[18]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[18]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[18]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, {
										field : 'c20',
										displayName : '20',
										width : 80,
										cellFilter : 'number:2',
										cellClass : 'text-right',
										cellTemplate :
											 '<div ng-class="{\'coverDiv\':row.getProperty(\'shadowFlags[19]\')== \'1\'}"'+ 
												'<div class="ngCellText"><span ng-if="row.getProperty(\'statuFlags[19]\')==\'3\'">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[19]\')==\'0\'" class="handle3">'+
													'<span> - </span>'+
												'</span>'+
												'<span ng-if="row.getProperty(\'statuFlags[19]\')==\'1\'" class="data-red">'+
													'<span> {{row.getProperty(col.field) | sDecimalFilter: 2}}</span></span>'+
												'<span ng-if="row.getProperty(\'statuFlags[19]\')==\'2\'" class="data-yellow">'+
													'<span>{{row.getProperty(col.field) | sDecimalFilter: 2}}</span>'+
												'</span></div></div>'
									}, ]
						};

						$scope.$on('$stateChangeStart', function(event) {
							clearInterval($scope.bjTimer);
						});
						$scope.$on('refreshViewDataForHead', function(event, data) {  
							getbJunctionData($scope, $http);
							$scope.bjTimer = setInterval(function() {
								clearInterval($scope.bjTimer);
								if($scope.timerFlag == "汇流箱" ){
									getbJunctionData($scope, $http);
								}
							}, 5000);
						});
						if($scope.timerFlag == "汇流箱"){
							getbJunctionData($scope, $http);
						}
						$scope.bjTimer = setInterval(function() {
							if($scope.timerFlag == "汇流箱" ){
								getbJunctionData($scope, $http);
							}
						}, 5000);
					});
	function cleanbJunctionData($scope) {
		$scope.myData = null;
	}
	var bjjsflag = 0;
	function getbJunctionData($scope, $http, callback) {
		if(bjjsflag == 0){
			$scope.showJuncBoxColumn="${ctx}/tpl/rtMonitorPage/deviceStation/bJunctionDataColumn.jsp";
			//$("#juncBox-table").hide();
			CommonPerson.Base.LoadingPic.PartShow('juncBox-table2');
		}
		$http({
			method : "POST",
			url : "${ctx}/DeviceStation/getRealDataBJunction.htm",
			params : {
				pstationid : $scope.powerStationId,
				pageIndex: $('#curPage').text(),
				pageSize: $('#singleNum').val(),
				search: $('#searchWords').val(),
				status: showfilterArr()
			}
		}).success(function(result) {
			if(bjjsflag == 0){
				partHide('juncBox-table2');
				//$("#juncBox-table").show();
			}
			bjjsflag = 1;
			var curTab = $('#tabList li.active').index();
			//if (curTab == 2) {
				var pageNums = Math.ceil(result.total/result.pageSize);
				$('#pageNums').text(pageNums);
				if (pageNums == 0) {
					$('#curPage1').show();
					$('#curPage').hide();
				} else {
					$('#curPage').show();
					$('#curPage1').hide();
				}
				if ($('#prevPage')<=1) {$('#nextPage').addClass('disabled');}
				if (pageNums > $('#curPage').text()) {
					$('#nextPage').removeClass('disabled');
				} else {
					$('#nextPage').addClass('disabled');
				}
			//}
			if (result.data !== null) {
				for (var i = 0; i < result.data.length; i++) {
					result.data[i].dtime = parseInt(result.data[i].dtime)*1000;
				}
			}
			$scope.RealData = result.data;
			$scope.myData=$scope.RealData
		});
	}
	function responseHeight1(){
		//$("#showJuncBoxColumnId").css("height", $(window).height() - 200);
		$("#showJuncBoxColumnId").css("width", $("#deviceTabs").width() - 16);
	}
	responseHeight1();
	window.addEventListener("resize", function() {
		responseHeight1();
	});
</script>
