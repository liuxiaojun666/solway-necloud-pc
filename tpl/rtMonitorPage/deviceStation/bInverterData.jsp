<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="col-sm-12 no-padder panel fault-rt-b-t"
	 ng-controller="inverMCtrl">
	<div id="inver-table2"></div>
	 <div ng-include="showInverColumn" id="showInverColumnId"></div>

</div>
<script type="text/javascript">
	//var invTimer;
	app.controller('inverMCtrl',function($scope, $http, $state, $document) {
		$document.on('screenfull.raw.fullscreenchange', function () {
			//if(responseHeight2){responseHeight2();};
		});
		$scope.$on("filterPageInvert", function (event, msg) {
			getbInverterDate($scope, $http);
		});

		$scope.gridOptions = {
			data : 'myDataInv',
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
					pinned : true,
				},
				{
					field : 'name',
					displayName : '名称',
					width : 120,
					pinned : true,
					cellTemplate : ' <span class="nowrap href-blur" data-toggle="tooltip" data-placement="bottom" style="line-height: 40px;" title="{{row.getProperty(col.field)}}" ng-click="showInformation(row.getProperty(\'id\'),row.getProperty(\'did\'),row.getProperty(\'sid\'));">{{row.getProperty(col.field)}}</span>'
				},
				{
					field : 'dtime',
					displayName : '时间',
					width : 120,
					cellFilter : 'date:"yyyy-MM-dd HH:mm:ss"',
					pinned : true,
					cellClass : 'text-center'
				},{
					field : 'dcu',
					displayName : 'DC电压(V)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'dcc',
					displayName : 'DC电流(A)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'dcp',
					displayName : 'DC功率(kW)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'acu',
					displayName : 'AC电压(V)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'acc',
					displayName : 'AC电流(A)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'acp',
					displayName : 'AC功率(kW)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 't',
					displayName : '温度(℃)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'ef',
					displayName : '效率(%)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right',
					cellTemplate :'<span class="nowrap"  style="line-height: 40px;" ng-bind="row.getProperty(\'ef\')*100|number:2"></span> '
				}, {
					field : 'f',
					displayName : '频率(Hz)',
					width : 80,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'pf',
					displayName : '功率因数',
					width : 90,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'dw',
					displayName : '日发电量(度)',
					width : 120,
					cellFilter : 'number:2',
					cellClass : 'text-right'
				}, {
					field : 'tw',
					displayName : '总发电量(度)',
					width : 120,
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
		/* $scope.showInformation = function(id,serialnumber,pstationid) {
			//alert("id:" + id + ", serialnumber:" + serialnumber + ", pstationid:" + pstationid);
			$http({
			method : "POST",
			url : "${ctx}/Inverter/selectByConditionMap.htm",
			params : {
				stid: pstationid,
				sn: serialnumber
			}
			}).success(function(result) {
				if(result){
					$state.go("app.inverterDetail", {
						InId : result.id,
						serialnumber : serialnumber,
						pstationid : pstationid
					});
				}
				
			});
			
		}; */
		$scope.$on('refreshViewDataForHead', function(event, data) {
			clearInterval($scope.invTimer);
			getbInverterDate($scope, $http);
			$scope.invTimer = setInterval(function() {
				if($scope.timerFlag == "逆变器" ){
					getbInverterDate($scope, $http);
				}
			}, 5000);
		});
		if($scope.timerFlag == "逆变器"){
			getbInverterDate($scope, $http);
		}
		//getbInverterDate($scope, $http);
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval($scope.invTimer);
		});
		$scope.invTimer = setInterval(function() {
			if($scope.timerFlag == "逆变器" ){
				getbInverterDate($scope, $http);
			}
		}, 5000);
	});

	function cleanbInverterData($scope) {
		$scope.myDataInv = null;
	}
	var bijsflag=0;
	function getbInverterDate($scope,$http,callback) {
		if(bijsflag == 0){
			$scope.showInverColumn="${ctx}/tpl/rtMonitorPage/deviceStation/bInverterDataColumn.jsp";
			//$("#inver-table").hide();
			CommonPerson.Base.LoadingPic.PartShow('inver-table2');
		}
		$http({
			method : "POST",
			//url : "${ctx}/DeviceStation/getStationData_bInverter.htm",
			url : "${ctx}/DeviceStation/getRealDataBInverter.htm",
			params : {
				pstationid: $scope.powerStationId,
				pageIndex: $('#curPage').text(),
				pageSize: $('#singleNum').val(),
				search: $('#searchWords').val(),
				status: showfilterArr(),
			}
		}).success(function(result) {
			if(bijsflag == 0){
				partHide('inver-table2');
				//$("#inver-table").show();
			}
			bijsflag = 1;
			var curTab = $('#tabList li.active').index();
			//if (curTab == 1) {
				var pageNums = Math.ceil(result.total/result.pageSize);
				$('#pageNums').text(pageNums);
				/**if (pageNums == 0) {
					$('#curPage1').show();
					$('#curPage').hide();
				} else {
					$('#curPage').show();
					$('#curPage1').hide();
				}*/
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
			$scope.myDataInv=$scope.RealData;
		});

	}
	function responseHeight2(){
		//$("#showInverColumnId").css("height", $(window).height() - 200);
		$("#showInverColumnId").css("width", $("#deviceTabs").width() - 16);
	}
	responseHeight2();
	window.addEventListener("resize", function() {
		responseHeight2();
	});
	
</script>
