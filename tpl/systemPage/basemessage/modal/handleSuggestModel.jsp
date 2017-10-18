<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.bg-grey{background:rgb(229,229,229);border-right: 1px solid white;
    border-bottom: 1px solid white;}
.bg-dark-grey{background:rgb(183,183,183);border-right: 1px solid white;width:80px;
    border-bottom: 1px solid white;}
.table {
    margin-bottom:0;height:100%;word-wrap:break-word; word-break:break-all;
}
.table .t-title{height:30px;}
.table > tbody > tr > td{padding:0;text-align:center;border:none;height:100%;}
.table > tbody > tr > td.border-rb-white{    border-right: 1px solid white;border-bottom: 1px solid white;}
.vertical-top{vertical-align: top;}
.width-per25{width:25%;}
.attach-icon{    padding: 5px;
    display: inline-block;
    cursor: pointer;}
.attachment-link{color: rgb(0, 138, 205);font-weight: 600;cursor:pointer;    text-decoration: underline;}
.recommend-score{display:inline-block;width:60px;background:url("theme/images/knowledgeBase/star.png") repeat-x;height: 12px;line-height: 12px;overflow: hidden;}
.recommend-score>.rate-score{display:inline-block;height: 12px;line-height: 12px;background:url("theme/images/knowledgeBase/star-active.png") repeat-x;overflow: hidden;vertical-align: top;float:left;}
.table > tbody > tr > td.text-left{text-align:left;    text-indent: 1em;}
/* .border-b-grey{border-bottom:1px solid rgb(200,200,200);} */
</style>

<div class="handle-model" ng-controller="handleSuggestModelCtrl">
	<table class="table">
		<tr>
			<td class="bg-dark-grey border-rb-white">
				产品资料
			</td>
			<td>
				<table class="table">
					<tr>
						<td class="vertical-top width-per25">
							<table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">标题</td></tr>
								 <tr><td class="bg-grey border-rb-white" ng-bind="productSuggest.title|dataNullFilter"></td></tr>
							</table>
						</td>
						<td  class="vertical-top">
							 <table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">正文</td></tr>
								 <tr><td class="bg-grey border-rb-white text-left" ng-bind-html="productSuggest.content|dataNullFilter|replaceBrFilter"></td></tr>
							</table>
						</td>
						<td  class="vertical-top width-per25">
							<table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">附件</td></tr>
								 <tr>
									 <td class="bg-grey border-rb-white">
									 	<span class="attach-icon" ng-repeat="attachment in productSuggest.attachment" title="{{attachment.fileName}}" ng-click="downloadProductAttach({{attachment.id}})">
									 		<img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
									 	</span>
									 </td>
								 </tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table class="table">
		<tr>
			<td class="bg-dark-grey border-rb-white">
				故障指导
			</td>
			<td>
				<table class="table">
					<tr>
						<td  class="vertical-top width-per25">
							<table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">故障描述</td></tr>
								 <tr><td class="bg-grey border-rb-white" ng-bind="faultSuggest.faultDescCH|dataNullFilter"></td></tr>
							</table>
						</td>
						<td  class="vertical-top">
							 <table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">故障原因及处理流程</td></tr>
								 <tr><td class="bg-grey border-rb-white text-left" ng-bind-html="faultSuggest.faultHandle|dataNullFilter|replaceBrFilter"></td></tr>
							</table>
						</td>
						<td  class="vertical-top width-per25">
							<table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">附件</td></tr>
								 <tr>
									 <td class="bg-grey border-rb-white">
										 <span ng-if="faultSuggest.file1 != '' && faultSuggest.file1 != null" class="attach-icon" title="{{faultSuggest.fileName1}}" ng-click="downloadFaultAttach({{faultSuggest.id }}, '1')">
											 <img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
										 </span>
										 <span ng-if="faultSuggest.file2 != '' && faultSuggest.file2 != null" class="attach-icon" title="{{faultSuggest.fileName2}}" ng-click="downloadFaultAttach({{faultSuggest.id }}, '2')">
											 <img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
										 </span>
										 <span ng-if="faultSuggest.file3 != '' && faultSuggest.file3 != null" class="attach-icon" title="{{faultSuggest.fileName3}}" ng-click="downloadFaultAttach({{faultSuggest.id }}, '3')">
											 <img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
										 </span>
									 </td>
								 </tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
			
		</tr>
	</table>
	<table class="table">
		<tr>
			<td class="bg-dark-grey border-rb-white">
				历史维修
			</td>
			<td>
				<table class="table">
					<tr  style="background: rgb(183,183,183);">
						<td class=" t-title border-rb-white width-per25">主故障码(索引)</td>
					 	<td class=" t-title border-rb-white">维修内容</td>
					 	<td class=" t-title border-rb-white width-per25">附件</td>
					</tr>
					<tr ng-repeat="item in repairSuggest">
					 	<td class="bg-grey border-rb-white">
					 		<p class="border-b-grey" ng-bind="item.faultCodeMain|dataNullFilter"></p>
					 	</td>
					 	<td class="bg-grey border-rb-white text-left">
					 		<p  class="border-b-grey" ng-bind-html="item.taskContent|dataNullFilter|replaceBrFilter"  style="padding:5px;"></p>
					 	</td>
					 	<td class="bg-grey border-rb-white">
						 	<p >
						 		<span ng-if="item.image1 != '' && item.image1 != null" class="attach-icon" title="{{item.image1}}" ng-click="downloadRepairAttach('{{item.image1 }}')">
									 <img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
								 </span>
								 <span ng-if="item.image2 != '' && item.image2 != null" class="attach-icon" title="{{item.image2}}" ng-click="downloadRepairAttach('{{item.image2 }}')">
									 <img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
								 </span>
								 <span ng-if="item.image3 != '' && item.image3 != null" class="attach-icon" title="{{item.image3}}" ng-click="downloadRepairAttach('{{item.image3 }}')">
									 <img src="theme/images/knowledgeBase/attachment-icon.png" style="width:15px;">
								 </span>
						 	</p>
						 </td>
					 </tr>
				</table>
			</td>
		</tr>
	</table>
	<table class="table">
		<tr>
			<td class="bg-dark-grey border-rb-white">
				处理建议
			</td>
			<td>
				<table class="table">
					<tr>
						<td  class="vertical-top">
							 <table class="table ">
								 <tr><td class="bg-dark-grey t-title border-rb-white">具体建议</td></tr>
								 <tr>
								 	<td class="bg-grey border-rb-white text-left" >
								 		<p ng-bind="item.content|dataNullFilter" class="border-b-grey" ng-repeat="item in suggestionsList"></p>
								 		<p ng-show="suggestionsList.length<=0">-</p>
								 	</td>
								 </tr>
							</table>
						</td>
						<td  class="vertical-top width-per25">
							<table class="table">
								 <tr><td class="bg-dark-grey t-title border-rb-white">推荐指数</td></tr>
								 <tr>
									 <td class="bg-grey border-rb-white">
										<p ng-repeat="item in suggestionsList" class="border-b-grey"><span class="recommend-score"><span class="rate-score" style="width:{{item.num|dataNullFilter}}%"></span></span></p>
										<%-- <p ng-show="suggestionsList<=0">-</p> --%>
									 </td>
								 </tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
<style>
	.repairAttachImgModal {
		padding: 0 10px;
	}
	.repairAttachImgModal img {
		width: 80%;
		display: block;
		margin:  0 auto;
	}
</style>
<div class="modal fade noteModal" id="repairAttachImgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row">
		<div class="modal-content ">
			<div class="modal-header">
				<button type="button" class="close" onclick="closeRepairAttachImgModal()">&times;</button>
				<h4 class="modal-title">历史维修</h4>
			</div>
			<div class="modal-body col-sm-12 no-padder black-1 repairAttachImgModal m-t-md m-b-md">
				<img id="repairImg">
			</div>
			<div class="modal-footer">
				<div class="form-group">
					<div class="col-sm-12 text-center">
						<button type="button" class="taskBtn btn w-xs" onclick="closeRepairAttachImgModal()">关闭</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
app.controller("handleSuggestModelCtrl", function($scope, $http, paramsData) {
	var busino = paramsData.get('busino');
	$scope.getDataByType = function(type){
		$http({
			method : "POST",
			url : "${ctx}/shareRepository/getSuggest.htm",
			params : {
				'busino': busino,
				'type': type,
			}
		}).success(function(result) {
			if(type == 1){
				$scope.productSuggest = result.data.productSuggest;
				
				
			}else if(type == 2){
				$scope.faultSuggest = result.data.faultSuggest;
			}else if(type == 3){
				$scope.repairSuggest = result.data.repairSuggest;
				if(!$scope.repairSuggest || $scope.repairSuggest.length == 0){
					$scope.repairSuggest = [{faultCodeMain:"-",taskContent:"-"}];
				}
			}else if(type == 4){
				$scope.suggestionsList = result.data.recommendSuggest;
				if($scope.suggestionsList && $scope.suggestionsList.length > 0){
					for(var i=0;i<$scope.suggestionsList.length;i++){
						$scope.suggestionsList[i].num = 100 - i*10;
					}
				}else{
					$scope.suggestionsList = [{content:"-",num:"-"}];
				}
			}
			
			//$scope.repairSuggest = [{"faultCodeMain":"0","taskContent":"测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容"},
			                        //{"faultCodeMain":"0","taskContent":"测试具体建议内容测试具体建议内容测试具体建议内建议内容测试具体建议内容测试具体建议内容测试具建议内容测试具体建议内容测试具体建议内容测试具容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容测试具体建议内容"}]
			
			
		});
	}
	$scope.getDataByType(1);
	$scope.getDataByType(2);
	$scope.getDataByType(3);
	$scope.getDataByType(4);

	//处理建议的列表数据
	//$scope.suggestionsList = [{"content":"测试具体建议内容测试具体建议内容","score":65},{"content":"测试具体建议内容测试具体建议内容","score":50},{"content":"测试具体建议内容测试具体建议内容","score":75}];
	
	//下载产品附件
	$scope.downloadProductAttach = function(id){
		window.open("${ctx}/shareRepository/downloadAttachment.htm?id="+id);
	}
	//下载故障码附件
	$scope.downloadFaultAttach = function(id, index){
		window.open("${ctx}/PFaultCodeReal/downloadAttachment.htm?id=" + id + "&index=" + index);
	}
	$scope.downloadRepairAttach = function(imgUrl){
		$('#repairImg').attr('src', '/document/faultHand/' + imgUrl);
		$('#repairAttachImgModal').modal('show');
	}
});
function closeRepairAttachImgModal(){
	$('#repairAttachImgModal').modal('hide');
}
</script>