<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="app-content-full" ng-controller="taskListsCtrl">
	<div class="hbox hbox-auto-xs bg-light " ng-init="" ng-controller="companyMonitorCtrl">		
		<!-- column -->
		<div class="col w-md" id="mapChart" style="overflow: hidden;">
			<div class="vbox">
				<div class="row-row">
					<div class="cell">
						<div class="cell-inner wrapper-md"style="overflow: hidden; padding-top: 0px">
							<div class="row">
								<div class="col-sm-12">
									{{a}}
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /column -->
		<!-- 右面部分column -->
		<div class="col lter b-l">
	<!-- 		<div class="vbox">
				<div class="row-row">
					<div class="cell">
						<div class="cell-inner"> -->
							<div class="col-xs-12 col-3" id="taskList" style="padding-bottom:60px;padding-top:35px">
								<div class="col-xs-7"  ng-class="{'ownDiv':note.userId=='1','taskListDiv':note.userId!='1'}" ng-repeat="note in faultList"ng-click="showNoteContent({{note.id}})">
									<div class="col-xs-12 padder-v padder-no">
										<div class="col-xs-12 no-padder text-1-7x default-col">
											<span ng-show="note.sendusername!=null">
												<img src="${ctx}/theme/images/icon/people.png" class="zoom-5 m-t-n m-r-xs">
												<span ng-bind="note.sendusername"></span>
											</span>
											<span ng-show="note.sendusername==null">
												<img src="${ctx}/theme/images/icon/gear.png" class="zoom-5 m-t-n m-r-xs">系统
											</span>
											<span class="m-r-xs" ng-bind="note.cretime| date:'yyyy-MM-dd HH:mm:ss'"></span>
										</div>
										<div class="col-xs-12 no-padder text-1-5x">
											<span data-ng-bind-html="note.content|limitTo : 42"></span>
											<span ng-if="note.content.length >42">...</span>
										</div>
										<div class="col-xs-12 no-padder text-1-5x m-t-xs">
											<img class="col-xs-3 padder-xs zoomImg" ng-src="{{note.img1}}" ng-show="note.img1 != null"  ng-click="zoomPic('note.img1')"/>
											<img class="col-xs-3 padder-xs zoomImg" ng-src="{{note.img1}}" ng-show="note.img1 != null"  ng-click="zoomPic('note.img1')"/>
											<img class="col-xs-3 padder-xs zoomImg" ng-src="{{note.img1}}" ng-show="note.img1 != null"  ng-click="zoomPic('note.img1')"/>
										</div>
									</div>
								</div>
							</div>
		<!-- 				</div>
					</div>
				</div>
			</div> -->
		</div>
		<!-- /column -->
	</div>
</div>
<script type="text/javascript">
app.controller('taskListsCtrl',function($scope, $http,$stateParams,$state) {
		console.log(123)
		$scope.a="123123"
		$scope.faultList = [ 
		   {
				"id":"1",
				"userId":"14",
				"sendusername" : "赵坤",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了,因为没有人修理，所以我自己派给我自己了，",
				"statu":"待确认"
			},
		   {
				"id":"1",
				"sendusername" : "赵坤",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了,逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"sendusername" : "赵坤",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"userId":"13",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"userId":"13",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"userId":"13",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"userId":"13",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"userId":"1",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了"
			},
		   {
				"id":"1",
				"userId":"13",
				"cretime" : "345",
				"content" : "逆变器A-108 发生故障,所以我去修理了",
				"img1":"img/bg.jpg"
			}
		];
});
</script>
