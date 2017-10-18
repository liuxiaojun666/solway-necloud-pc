<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div ng-controller="ShareRepositoryCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">知识库信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid"
					action="${ctx}/shareRepository/update.htm" method="post" id="editForm"
					name="editForm">
					<input type="hidden" name="id" value="{{$stateParams.id}}"
						id="id" class="formData" />
					<div class="form-group">
						<label class="col-lg-2 text-right">标题</label>
						<div class="col-lg-6">
							{{sRepos.title}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">类型</label>
						<div class="col-lg-3">
							{{stationd.selected.name}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">类别</label>
						<div class="col-lg-3">
							{{sRepos.repclassName}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">生产厂商</label>
						<div class="col-lg-3">
							{{sRepos.manFName}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">产品型号</label>
						<div class="col-lg-3">
							{{sRepos.productName}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">简介</label>
						<div class="col-lg-6">
							{{sRepos.introduce}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">关键词</label>
						<div class="col-lg-6">
							{{sRepos.keywords}}
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 text-right">内容</label>
						<div class="col-lg-9">
							<div id="content"></div>
						</div>
					</div>
					
					<div class="form-group" ng-repeat="attachment in sRepos.attachment">
						<div class="f-box">
							<label class="col-lg-2 text-right">附件{{$index+1}}</label>
							<div class="col-lg-6 d-load">
								<a href="javascript:;" class="download" attachmentId="" 
										ng-click="download({{attachment.id}})">{{attachment.fileName}}</a>
							</div>
						</div>
					</div>
					
					<div class="form-group m-t-sm ">
						<div class="col-lg-10 text-center ">
							<button id="cancelBtn" type="button"
								class=" m-l-sm  btn m-b-xs w-xs btn-default"
								ng-click="backShareRepos();">
								<strong>返回</strong>
							</button>
						</div>
					</div>
				</form>
				<!-- form 结束 -->
			</div>
		</div>
	</div>
</div>

<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"
	type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"
	type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<style type="text/css">
.d-load a:hover{color:#f60;text-decoration:underline;}
</style>
<script type="text/javascript">
app.controller('ShareRepositoryCtrl',['$http','$scope','$stateParams','$state',
	function($http, $scope, $stateParams, $state) {
	var id = $stateParams.id;
	$scope.stationd = {};
	$scope.stationd.selected = {
		name : null,
		id : null
	};
	$scope.station = null;
	$scope.initPageData = function(){
		$http({
			url: '${ctx}/shareRepository/initPageData.htm',
			method: 'GET',
			params: {
				"id" : id
			}
		}).success(function(data,header,config,status){
			$scope.station = data.tree;
			for(var obj in $scope.station){
				if($scope.station[obj].flag == 0){
					$scope.stationd.selected.name = $scope.station[obj].name;
					$scope.stationd.selected.id = $scope.station[obj].id;
				}
			}
			if(data.sRepos){
				$scope.sRepos = data.sRepos;
				$("#content").html($scope.sRepos.content);
			}
		}).error(function(data,header,config,status){
			alert("数据初始化失败");
		});
	};
	$scope.initPageData();
	
	$scope.backShareRepos = function(){
		$state.go('app.knowledge');
	};
	
	$scope.download = function(id){
		window.open("${ctx}/shareRepository/downloadAttachment.htm?id="+id);
	}
}]);
</script>

