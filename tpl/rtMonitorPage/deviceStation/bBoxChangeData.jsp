<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder panel fault-rt-b-t"
	ng-controller="boxChangeCtrl">
	<div id="boxChange-table2"></div>
	 <div ng-include="showBoxChangeColumn" id="showBoxChangeColumnId"></div>
</div>

<script type="text/javascript">
	var bcTimer;
	app.controller('boxChangeCtrl', function($scope, $http, $state, $document) {
		$document.on('screenfull.raw.fullscreenchange', function () {
			  //if(responseHeight){responseHeight();};
		});
		//过滤
		$scope.$on("filterPageBox", function (event, msg) {
			getbBoxChangeData($scope, $http);
		});

		$scope.gridOptions = {
			data : 'myDataBC',
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
						width : 150,
						pinned : true,
						cellTemplate : ' <span class="nowrap href-blur" data-toggle="tooltip" data-placement="bottom" style="line-height: 40px;" title="{{row.getProperty(col.field)}}"ng-click="showBoxChangeData(row.getProperty(\'sid\'),row.getProperty(\'did\'),row.getProperty(\'sid\'));">{{row.getProperty(col.field)}}</span>'
					},
					{
						field : 'dtime',
						displayName : '时间',
						width : 150,
						cellFilter : 'date:"yyyy-MM-dd HH:mm:ss"',
						pinned : true,
						cellClass : 'text-center'
					},{
						field : 'pa1',
						displayName : '绕组1A相有功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pb1',
						displayName : '绕组1B相有功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pc1',
						displayName : '绕组1C相有功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'qa1',
						displayName : '绕组1A相无功功率(kVar)',
						width : 160,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'qb1',
						displayName : '绕组1B相无功功率(kVar)',
						width : 160,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'qc1',
						displayName : '绕组1C相无功功率(kVar)',
						width : 160,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'ca1',
						displayName : '绕组1A相电流(A)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'cb1',
						displayName : '绕组1B相电流(A)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'cc1',
						displayName : '绕组1C相电流(A)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'ua1',
						displayName : '绕组1A相电压(V)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'ub1',
						displayName : '绕组1B相电压(V)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'uc1',
						displayName : '绕组1C相电压(V)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'f1',
						displayName : '绕组1频率(Hz)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'pf1',
						displayName : '绕组1功率因数',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'w1',
						displayName : '绕组1电量(kWh)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pa2',
						displayName : '绕组2A相有功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pb2',
						displayName : '绕组2B相有功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pc2',
						displayName : '绕组2C相有功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'qa2',
						displayName : '绕组2A相无功功率(kVar)',
						width : 160,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'qb2',
						displayName : '绕组2B相无功功率(kVar)',
						width : 160,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'qc2',
						displayName : '绕组2C相无功功率(kVar)',
						width : 160,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'ca2',
						displayName : '绕组2A相电流(A)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'cb2',
						displayName : '绕组2B相电流(A)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'cc2',
						displayName : '绕组2C相电流(A)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'ua2',
						displayName : '绕组2A相电压(V)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'ub2',
						displayName : '绕组2B相电压(V)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'uc2',
						displayName : '绕组2C相电压(V)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'f2',
						displayName : '绕组2频率(Hz)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'pf2',
						displayName : '绕组2功率因数',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'w2',
						displayName : '绕组2电量(kWh)',
						width : 120,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}, {
						field : 'ta',
						displayName : 'A相温度(℃)',
						width : 80,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					} , {
						field : 'tb',
						displayName : 'B相温度(℃)',
						width : 80,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					} , {
						field : 'tc',
						displayName : 'C相温度(℃)',
						width : 80,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					} , {
						field : 't',
						displayName : '温度(℃)',
						width : 80,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					} ]
		};
		$scope.showBoxChangeData2 = function(id,serialnumber,pstationid) {
			$http({
				method : "POST",
				url : "${ctx}/BoxChange/selectByConditionMap.htm",
				params : {
					stid: pstationid,
					sn: serialnumber
				}
				}).success(function(result) {
					if(result){
						$state.go("app.BoxChangeDetail", {
							InId : result.id,
							serialnumber : serialnumber,
							pstationid : pstationid
						});
					}

				});

		}
		$scope.$on('refreshViewDataForHead', function(event, data) {
			clearInterval($scope.bcTimer);
			getbBoxChangeData($scope, $http);
			$scope.bcTimer = setInterval(function() {
				if($scope.timerFlag == "箱变" ){
					getbBoxChangeData($scope, $http);
				}
			}, 5000);
		});
		if($scope.timerFlag == "箱变"){
		   getbBoxChangeData($scope, $http);
		}
		$scope.$on('$stateChangeStart', function(event) {
			clearInterval($scope.bcTimer);
		});
		$scope.bcTimer = setInterval(function() {
			if($scope.timerFlag == "箱变" ){
				getbBoxChangeData($scope, $http);
			}
		}, 5000);
	});
	function cleanbBoxChangeData($scope) {
		$scope.myDataBC= null;
	}
	var bbjsflag=0;
	function getbBoxChangeData($scope, $http, callback) {
		if(bbjsflag == 0){
			$scope.showBoxChangeColumn="${ctx}/tpl/rtMonitorPage/deviceStation/bBoxChangeDataColumn.jsp";
			//$("#boxChange-table").hide();
			CommonPerson.Base.LoadingPic.PartShow('boxChange-table2');
		}
		$http({
			method : "POST",
			url : "${ctx}/DeviceStation/getRealDataBBoxChange.htm",
			params : {
				pstationid: $scope.powerStationId,
				pageIndex: $('#curPage').text(),
				pageSize: $('#singleNum').val(),
				search: $('#searchWords').val(),
				status: showfilterArr()
			}
		}).success(function(result) {
			if(bbjsflag == 0){
				partHide('boxChange-table2');
				//$("#boxChange-table").show();
			}
			bbjsflag=1;
			var curTab = $('#tabList li.active').index();
			//if (curTab == 0) {
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
			$scope.myDataBC=$scope.RealData
			
		});
	}
	function responseHeight3(){
		//$("#showBoxChangeColumnId").css("height", $(window).height() - 200);
		$("#showBoxChangeColumnId").css("width", $("#deviceTabs").width()-20);
	}
	responseHeight3()
	//$(window).trigger("resize");
	window.addEventListener("resize", function() {
		responseHeight3();
	});
</script>