<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="col-sm-12 no-padder panel fault-rt-b-t"
	ng-controller="meterBoxChangeCtrl">
	<div id="boxChange-table2"></div>
	<div class="col-sm-12 no-padder" ng-grid="gridOptions"
		id="boxChange-table"></div>
</div>

<script type="text/javascript">
	var bcTimer;
	app.controller('meterBoxChangeCtrl', function($scope, $http, $state, $document) {
		$document.on('screenfull.raw.fullscreenchange', function () {
			  if(responseHeight){responseHeight();};
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
						width : 250,
						pinned : true,
						cellTemplate : ' <span class="nowrap href-blur" data-toggle="tooltip" data-placement="bottom" style="line-height: 40px;" title="{{row.getProperty(col.field)}}"ng-click="showBoxChangeData(row.getProperty(\'sid\'),row.getProperty(\'did\'),row.getProperty(\'sid\'));">{{row.getProperty(col.field)}}</span>'
					},
					{
						field : 'dtime',
						displayName : '时间',
						width : 150,
						cellFilter : 'date:"yyyy-MM-dd HH:mm:ss"',
						pinned : true,
						cellClass : 'text-right'
					},{
						field : 'pa1',
						displayName : '有功功率（kW）',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pb1',
						displayName : '无功功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					},{
						field : 'pc1',
						displayName : '视在功率(kW)',
						width : 150,
						cellFilter : 'number:2',
						cellClass : 'text-right'
					}]
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
			$("#boxChange-table").hide();
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
				$("#boxChange-table").show();
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
		$("#boxChange-table").css("height", $(window).height() - 210);
		$("#boxChange-table").css("width", $("#deviceTabs").width());
	}
	responseHeight3();
	window.addEventListener("resize", function() {
		responseHeight3();
	});
</script>