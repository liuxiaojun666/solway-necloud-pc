<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 排班计划 -->
<script type="text/javascript">
	app.controller('SchedulingCtr', function($scope,$http,$state) {
	    var date = new Date();
	    var d = date.getDate();
	    var m = date.getMonth();
	    var y = date.getFullYear();
	    $scope.events = [
	      //{title:'我是标题', start: new Date(y, m, d - 7), end: new Date(y, m, d - 2), className: ['bg-success bg'], location:'HD City', info:'xxx'}
	    ];
	    $scope.precision = 400;
	    $scope.lastClickTime = 0;
	    $scope.uiConfig = {
	      calendar:{
	        height: 450,
	        editable: true,
	        header:{
	          left: 'prev',
	          center: 'title',
	          right: 'next'
	        },
	        monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
	        monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
	        dayNames: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
	        dayNamesShort: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
	        //点击事件
		    eventClick : function(event){
// 		    	alert(event.title);
		    	return false; 
		    }
	      }
	    };
 	    $scope.changeView = function(view, calendar) {
	      $('.calendar').fullCalendar('changeView', view);
	    }; 
	    $scope.eventSources = [$scope.events];

	    
	    //时间字符串转换为日期
		$scope.dateStrToDate = function(dateStr){
			dateStr = dateStr.replace(/-/g,"/");
			return new Date(dateStr);
		}
		
	    $http({method:"POST",url:"${ctx}/scheduling/schedulingList.htm",params:{}})
		.success(function (result) {
	    	 var schedulingData = result.data;
	    	 $.each(schedulingData,function(i,shceObj){
	    		 var eventObj = {};
	    		 eventObj.title = shceObj.teamName;
	    		 eventObj.start = $scope.dateStrToDate(shceObj.startdate);
	    		 eventObj.end = $scope.dateStrToDate(shceObj.enddate);
	    		 eventObj.className = ['bg-success bg'];
	    		 eventObj.location = 'HD City';
	    		 eventObj.info = "";
	    		 $scope.events.push(eventObj);
	    	 })
		}); 
		
	    //切换到人工排班页面
		$scope.manualScheduling = function(){
			  $state.go("app.manualScheduling");
		}
		
		
	});
</script>

<div ng-controller="SchedulingCtr">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h1 blue-1 m-n text-black">排班计划</span>
	  	<button class="btn btn-primary pull-right">自动排班</button>
	  	<button class="btn btn-primary pull-right" ng-click="manualScheduling();">人工排班</button>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="col-sm-12  panel padder-l-sm no-padder">
				<div class="hbox hbox-auto-xs hbox-auto-sm">
				  <div class="col wrapper-md">
				    <div class="pos-rlt">
				      <div class="calendar" ng-model="eventSources" config="uiConfig.calendar" ui-calendar="uiConfig.calendar"></div>
				    </div>
				  </div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 更新排班模块 -->
<div class="modal fade" id="updateSchModal"
	tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	aria-hidden="true">
	<div class="modal-dialog row">
		<div class="modal-content ">
			<div class="modal-body wrapper-lg">
				<div class="row">
					<div class="col-sm-12">
						<h3 class="m-t-none m-b font-thin" id="myModalLabel">班组信息管理</h3>
						<div class="panel-body">
							<form class="bs-example form-horizontal ng-pristine ng-valid"
								action="${ctx}/opTeam/update.htm" method="post"
								id="editForm" name="editForm">
								<input type="hidden" name="id" value="" id="id" class="formData" />
								<div class="form-group">
									<label class="col-lg-2 control-label">班组编号</label>
									<div class="col-lg-10">
										<input type="text" id="teamNo" name="teamNo"
											class="form-control formData">
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-2 control-label">班组名称</label>
									<div class="col-lg-10">
										<input type="text" id="teamName" name="teamName"
											class="form-control formData">
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-offset-2 col-lg-10">
										<button type="button"
											class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"
											data-dismiss="modal">
											<strong>取消</strong>
										</button>
										<button type="button" onclick="saveForm();" id="saveButton"
											class=" pull-right btn m-b-xs w-xs   btn-info">
											<strong>保 存</strong>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>