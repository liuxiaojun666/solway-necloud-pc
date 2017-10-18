<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="${ctx}/theme/css/knowledgeBase/knowledgeBaseQuery.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/knowledgeBase/knowledgeBaseDetailModel.css" />
<div ng-controller="KnowledgeBaseQueryCtr" class="page-knowledge">
	<header class="font16" ng-hide="hideKnowledgeHeader">知识库</header>
	<div class="body-main clearfix">
		<div class="search-con clearfix">
			<div class="tab-con pull-left clearfix">
				<a ng-class="{'active':modelType == 'proInfo'}" ng-click="changeTab('proInfo')"><span>产品资料</span></a>
				<a ng-class="{'active':modelType == 'faultGuidance'}" ng-click="changeTab('faultGuidance')"><span>故障指导</span></a>
				<a ng-class="{'active':modelType == 'historyRepair'}" ng-click="changeTab('historyRepair')"><span>历史维修</span></a>
			</div>
			<div class="search-condition pull-right">
				<div class="condition clearfix" ng-show="modelType == 'proInfo'">
					<div class="select-list">
						<select id="searchContentList">
							<option value="1">标题</option>
							<option value="2">关键词</option>
							<option value="3">简介</option>
							<option value="4">正文</option>
						</select>
						<img class="triangle-up" src="theme/images/knowledgeBase/triangle-up.png">
						<img class="triangle-down" src="theme/images/knowledgeBase/triangle-down.png">
					</div>
					<div class="input-container" ><input type="text" placeholder="搜索" ng-model="searchContentProInfo"></div>
					<div class="search-btn" ng-click="onSelectPage(1)"></div>
				</div>
				<div class="condition clearfix" ng-show="modelType == 'faultGuidance' ">
					<div class="select-list">
						<select id="searchContentListFault">
							<option value="1">故障码</option>
							<option value="2">故障描述</option>
						</select>
						<img class="triangle-up" src="theme/images/knowledgeBase/triangle-up.png">
						<img class="triangle-down" src="theme/images/knowledgeBase/triangle-down.png">
					</div>
					<div class="input-container" ><input type="text" placeholder="搜索" ng-model="searchContentFault"></div>
					<div class="search-btn" ng-click="onSelectPage(1)"></div>
				</div>
				<div class="condition clearfix" ng-show="modelType == 'historyRepair' ">
					<div class="select-list">
						<select id="searchContentListRepair">
							<option value="1">故障码</option>
							<option value="2">故障处理</option>
						</select>
						<img class="triangle-up" src="theme/images/knowledgeBase/triangle-up.png">
						<img class="triangle-down" src="theme/images/knowledgeBase/triangle-down.png">
					</div>
					<div class="input-container" ><input type="text" placeholder="搜索" ng-model="searchContentRepair"></div>
					<div class="search-btn" ng-click="onSelectPage(1)"></div>
				</div>
				<div class="clearfix" style="padding:10px 0;">
                  	<ui-select class="col-sm-6 no-padder"  ng-model="manus.selected" theme="bootstrap" ng-change="manufChange()" ng-disabled="{'t':true, 'f':false}[selectStatus]">
                  		<ui-select-match placeholder="请输入关键字..." ng-model="manus.selected.manufname" >{{$select.selected.manufname}}</ui-select-match>
                  		<ui-select-choices repeat="item in manuf | filter: $select.search">
                  			<div ng-bind-html="item.manufname | highlight: $select.search"></div>
                  		</ui-select-choices>
					</ui-select>
					
					<ui-select class="col-sm-6 no-padder" ng-model="productd.selected" theme="bootstrap" ng-change="productChange()" ng-disabled="{'t':true, 'f':false}[selectStatus]">
						<ui-select-match placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
                        <ui-select-choices repeat="item in product | filter: $select.search">
							<div ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
                        </ui-select-choices>
					</ui-select>
                </div>
				<div  class="condition-items">
					<h3  ng-class="{'activeTypeItem':repclass == null,'noactiveTypeItem':repclass != null}" ng-click="selectRepClass(null)" ng-show="modelType == 'proInfo'">全部文档分类</h3>
					<ul ng-show="modelType == 'proInfo'">
						<li ng-repeat="vo in repClassList"><span ng-class="{'activeTypeItem':repclass == vo.dictValue}" value="vo.dictName" ng-click="selectRepClass(vo.dictValue)">{{vo.dictName}}</span></li>
					</ul>
					
					<h3 ng-class="{'activeTypeItem':deviceType == null,'noactiveTypeItem':deviceType != null}" ng-click="selectDeviceType(null)" ng-show="modelType == 'faultGuidance' || modelType == 'historyRepair' ">全部设备分类</h3>
					<ul ng-show="modelType == 'faultGuidance' || modelType == 'historyRepair' ">
						<li ng-repeat="vo in allDeviceTypeList"><span ng-class="{'activeTypeItem':deviceType == vo.id}" value="vo.id" ng-click="selectDeviceType(vo.id)">{{vo.name}}</span></li>
					</ul>
				</div>
				
				
			</div>
		</div>
		
		<paging class="col-sm-12 no-padder" style="background: rgb(240,243,244);">
			<div class="clearfix">
				<div class="range" ng-show="modelType == 'proInfo'">
					<span ng-click="radioSelectProInfo('views')" style="margin:0 8px;" ng-class="{'activeOrderItem':currentSortFieldProInfo == 'views'}">浏览次数 </span>
					<i class="fa" ng-class="{'fa-arrow-down':proInfoViewUp == 'desc','fa-arrow-up':proInfoViewUp == 'asc'}" ng-click="proInfoUpOrDown('views')"></i>
					<span ng-click="radioSelectProInfo('time')" style="margin:0 8px;" ng-class="{'activeOrderItem':currentSortFieldProInfo == 'time'}">发布时间 </span>
					<i class="fa" ng-class="{'fa-arrow-down':proInfoTimeUp == 'desc','fa-arrow-up':proInfoTimeUp == 'asc'}" ng-click="proInfoUpOrDown('time')"></i>
				</div>
				<div class="range" ng-show="modelType == 'faultGuidance'">
					<span style="margin:0 8px;" ng-class="{'activeOrderItem':currentSortFieldFault == 'code'}" style="margin:0 8px;" >故障码 </span>
					<i class="fa" ng-class="{'fa-arrow-down':faultCodeUp == 'desc','fa-arrow-up':faultCodeUp == 'asc'}" ng-click="faultUpOrDown('code')"></i>
				</div>
				<div class="range" ng-show="modelType == 'historyRepair'">
					<span ng-click="radioSelectRepair('time')" style="margin:0 8px;" ng-class="{'activeOrderItem':currentSortFieldRepair == 'time'}">发布时间 </span>
					<i class="fa" ng-class="{'fa-arrow-down':repairTimeUp == 'desc','fa-arrow-up':repairTimeUp == 'asc'}" ng-click="repairUpOrDown('time')"></i>
					<span ng-click="radioSelectRepair('code')" style="margin:0 8px;" ng-class="{'activeOrderItem':currentSortFieldRepair == 'code'}" style="margin:0 8px;" >故障码 </span>
					<i class="fa" ng-class="{'fa-arrow-down':repairCodeUp == 'desc','fa-arrow-up':repairCodeUp == 'asc'}" ng-click="repairUpOrDown('code')"></i>
					<span ng-click="radioSelectRepair('views')" style="margin:0 8px;" ng-class="{'activeOrderItem':currentSortFieldRepair == 'views'}">浏览次数 </span>
					<i class="fa" ng-class="{'fa-arrow-down':repairViewUp == 'desc','fa-arrow-up':repairViewUp == 'asc'}" ng-click="repairUpOrDown('views')"></i>
				</div>
				<div ><%@ include file="/common/pagerForKnowledgeBase.jsp" %></div>
			</div>
			<div class="products-list clearfix">
				<!-- 产品资料 -->
				<div class="pro-item" ng-repeat="item in data" ng-click="showProductDetail(item)">
					<div class="clearfix">
						<div class="col-sm-8 no-padder">
							<h5>{{item.field1|dataNullFilter}}</h5>
							<p class="clearfix"><label class="pull-left">厂家名称</label><span>{{item.field2|dataNullFilter}}</span></p>
							<p class="clearfix"><label class="pull-left">产品型号</label><span>{{item.field3|dataNullFilter}}</span></p>
							<p class="clearfix"><label class="pull-left" ng-show="modelType == 'proInfo'">资料分类</label><label class="pull-left" ng-show="modelType == 'faultGuidance'">协议名称</label><label class="pull-left" ng-show="modelType == 'historyRepair'">维修时间</label><span>{{item.field4|dataNullFilter}}</span></p>
						</div>
						<div class="col-sm-4 no-padder">
							<p><img src="theme/images/knowledgeBase/eye.png" style="margin-right:7px;"><span>浏览次数</span></p>
							<p class="view-num">{{item.views|dataNull0Filter}}</p>
						</div>
					</div>
					<p class="detail">{{item.field5|dataNullFilter}}</p>
				</div>
				<!-- 故障指导  与   历史维修-->
				<!-- <div class="pro-item" ng-repeat="item in data">
					<div class="clearfix">
						<div class="col-sm-8 no-padder">
							<h5>汇流箱安装接线作业指导书</h1>
							<p><label>发布人</label><span>张三</span></p>
							<p><label>发布单位</label><span>大厦新能源104号</span></p>
							<p><label>发布时间</label><span>2017-01-01  10:10:10</span></p>
						</div>
						
					</div>
					<p class="detail">关于汇流箱的安装，根据设计的汇流箱的布置以及连接示意图安装</p>
				</div> -->
				<div class="no-data-con" id="no-data-con">
					<span style="position:relative;display: inline-block;">
						<img src="theme/images/knowledgeBase/no-data-icon.png">
						<div class="nodata-tip"><span class="triangle-tip"></span>暂时还没有数据哦！</div>
					</span>
					
				</div>
			</div>
		</paging>
	</div>
	<div data-ng-include="'${ctx}/tpl/rtMonitorPage/monitor/modal/powerModal.jsp'"></div>
</div>

<script type="text/javascript">
app.controller('KnowledgeBaseQueryCtr', function($scope, $http, $state) {
	//分页初始化
	initTableConfig($scope);
	//默认一页的查询数量为6
	$scope.pageSizeSelect = 6;
	
	//默认查询标题
	$scope.searchFieldTypeProInfo = "1";
	//产品资料默认按浏览次数排序
	$scope.currentSortFieldProInfo = 'views'
	//按浏览次数上升还是下降排序
	$scope.proInfoViewUp = 'desc';//默认下降
	//按发布时间排序
	$scope.proInfoTimeUp = 'desc';//默认下降
		
	//默认查询故障码
	$scope.searchFieldTypeFault = "1";
	//故障指导故障码排序
	$scope.currentSortFieldFault = 'code';
	$scope.faultCodeUp = 'desc';//默认下降
	
	//默认查询故障码
	$scope.searchFieldTypeRepair = "1";
	//历史维修默认按发布时间排序
	$scope.currentSortFieldRepair = 'time';
	$scope.repairTimeUp = 'desc';//默认下降
	$scope.repairViewUp = 'desc';//默认下降
	$scope.repairCodeUp = 'desc';//默认下降
	
	$scope.repClass = null;
	
	//默认显示产品资料模块
	$scope.modelType = "proInfo";//默认产品资料
	$scope.changeTab = function(type){
		$scope.modelType = type;
		if($scope.modelType == 'proInfo'){
			$scope.onSelectPage($scope.currentPageProInfo);
		}else if($scope.modelType == 'faultGuidance'){
			$scope.onSelectPage($scope.currentPageFault);
		}else if($scope.modelType == 'historyRepair'){
			$scope.onSelectPage($scope.currentPageRepair);
		}
		initDetailModel();
	}
	
	//查看产品详情
	function initDetailModel(){
		if($scope.modelType == 'proInfo'){
			$scope.showPowerIndexData="tpl/knowledgePage/summaryQuery/model/productDetailModel.jsp";
		}else if($scope.modelType == 'faultGuidance'){
			$scope.showPowerIndexData="tpl/knowledgePage/summaryQuery/model/faultDetailModel.jsp";
		}else if($scope.modelType == 'historyRepair'){
			$scope.showPowerIndexData="tpl/knowledgePage/summaryQuery/model/historyDetailModel.jsp";
		}
	}
	initDetailModel();
	
	//打开弹出层
	$scope.showProductDetail = function(item){
		var id = item.id;//当前产品的id
		$scope.$broadcast('detail', item);
		$('#powerIndexModal').modal();
	}
	
	//关闭弹出层
	$scope.hiddenModal=function(){
		$('#powerIndexModal').modal("hide");
	};
	$scope.onSelectPage = function(page) {
		if (!page) {
			page = 1;
			$scope.currentPage = 1;
		}
		var searchFieldType,searchContent,sortField,ascOrDesc;
		//当前查询产品资料时
		if($scope.modelType == 'proInfo'){
			sortField = $scope.currentSortFieldProInfo;
			if($scope.currentSortFieldProInfo == 'views'){
				ascOrDesc = $scope.proInfoViewUp;
			}else if($scope.currentSortFieldProInfo == 'time'){
				ascOrDesc = $scope.proInfoTimeUp;
			}
			
			searchFieldType = $scope.searchFieldTypeProInfo;
			searchContent = $scope.searchContentProInfo;
			
		}else if($scope.modelType == 'faultGuidance'){
			sortField = $scope.currentSortFieldFault;
			ascOrDesc = $scope.faultCodeUp;
			
			searchFieldType = $scope.searchFieldTypeFault;
			searchContent = $scope.searchContentFault;
			
		}else if($scope.modelType == 'historyRepair'){
			sortField = $scope.currentSortFieldRepair;
			if($scope.currentSortFieldRepair == 'views'){
				ascOrDesc = $scope.repairViewUp;
			}else if($scope.currentSortFieldRepair == 'time'){
				ascOrDesc = $scope.repairTimeUp;
			}else if($scope.currentSortFieldRepair == 'code'){
				ascOrDesc = $scope.repairCodeUp;
			}
			searchFieldType = $scope.searchFieldTypeRepair;
			searchContent = $scope.searchContentRepair;
			
		}
		
		$http({
			method : "POST",
			url : "${ctx}/shareRepository/selectByPageShareRepository.htm",
			params : {
				//公共
				'pageIndex' : page - 1,
				'pageSize' : $scope.pageSizeSelect,
				'queryType' : $scope.modelType,
				'sortField' : sortField,
				'ascOrDesc' : ascOrDesc,
				'searchFieldType' : searchFieldType,
				'searchContent' : searchContent,
				'manuFId' : $scope.manuFId,
				'productId' : $scope.productId,
				//产品资料
				'repclass' : $scope.repclass,
				//故障指导，历史检修
				'devicetype' : $scope.deviceType,
			}
		}).success(function(result) {
			console.log(result)
			//var random = Math.ceil(Math.random()*15);
			/**var result = {"total":99,"totalPage":25,"pageIndex":random,"pageSize":5,"previousIndex":0,"nextPageIndex":0,"lastPageIndex":0,"showStart":1,"showEnd":2,
					"data":[{"id":37,"phone":"15901109688","realname":"董卫国","userName":"15901109688","invitestatus":"接受邀请"},
					        {"id":3,"phone":"01082800866","realname":"演示用户","userName":"gkdemo","invitestatus":"接受邀请"},
					        {"id":7,"phone":"15901109688","realname":"董卫国","userName":"15901109688","invitestatus":"接受邀请"},
					        {"id":34,"phone":"01082800866","realname":"演示用户","userName":"gkdemo","invitestatus":"接受邀请"},
					        {"id":1234,"phone":"01082800866","realname":"演示用户","userName":"gkdemo","invitestatus":"接受邀请"}]}
			*/
			
			if($scope.modelType == 'proInfo'){
				$scope.currentPageProInfo = result.pageIndex+1;
			}else if($scope.modelType == 'faultGuidance'){
				$scope.currentPageFault = result.pageIndex+1;
			}else if($scope.modelType == 'historyRepair'){
				$scope.currentPageRepair = result.pageIndex+1;
			}
			console.log($scope.totalPage +"==$scope.totalPage")
			getTableData($scope, result);
			$scope.$broadcast("pages");
			if(result.total <= 0){
				$("#no-data-con").show();
				$("#paginationForKnowledgePage.pagination").hide();
			}else{
				$("#no-data-con").hide();
				$("#paginationForKnowledgePage.pagination").show();
			}
		});
		
		/* 模拟请求接口数据 */
		
	};
	//默认获取第一页的数据
	$scope.onSelectPage(1);
	
	$scope.proInfoUpOrDown = function(ctype){
		//当未被选中时，点击排序无效
		if($scope.currentSortFieldProInfo != ctype) return;
		if(ctype == 'views'){
			if($scope.proInfoViewUp == 'desc'){
				$scope.proInfoViewUp = 'asc'
			}else if($scope.proInfoViewUp == 'asc'){
				$scope.proInfoViewUp = 'desc'
			}
		}else if(ctype == 'time'){
			if($scope.proInfoTimeUp == 'desc'){
				$scope.proInfoTimeUp = 'asc'
			}else if($scope.proInfoTimeUp == 'asc'){
				$scope.proInfoTimeUp = 'desc'
			}
		}
		$scope.onSelectPage(1);
	}
	
	$scope.faultUpOrDown = function(ctype){
		//当未被选中时，点击排序无效
		if($scope.currentSortFieldFault != ctype) return;
		if(ctype == 'code'){
			if($scope.faultCodeUp == 'desc'){
				$scope.faultCodeUp = 'asc'
			}else if($scope.faultCodeUp == 'asc'){
				$scope.faultCodeUp = 'desc'
			}
		}
		$scope.onSelectPage(1);
		//$scope.viewNumUp = !$scope.viewNumUp;
	}
	
	$scope.repairUpOrDown = function(ctype){
		//当未被选中时，点击排序无效
		if($scope.currentSortFieldRepair != ctype) return;
		if(ctype == 'views'){
			if($scope.repairViewUp == 'desc'){
				$scope.repairViewUp = 'asc'
			}else if($scope.repairViewUp == 'asc'){
				$scope.repairViewUp = 'desc'
			}
		}else if(ctype == 'code'){
			if($scope.repairCodeUp == 'desc'){
				$scope.repairCodeUp = 'asc'
			}else if($scope.repairCodeUp == 'asc'){
				$scope.repairCodeUp = 'desc'
			}
		}else if(ctype == 'time'){
			if($scope.repairTimeUp == 'desc'){
				$scope.repairTimeUp = 'asc'
			}else if($scope.repairTimeUp == 'asc'){
				$scope.repairTimeUp = 'desc'
			}
		}
		$scope.onSelectPage(1);
		//$scope.viewNumUp = !$scope.viewNumUp;
	}
	
	$scope.radioSelectProInfo = function(ctype){
		$scope.currentSortFieldProInfo = ctype;
		$scope.onSelectPage(1);
		//$scope.proInfoTimeUp = !$scope.proInfoTimeUp;
	}
	
	$("#searchContentList").on("change",function(e) {
		$scope.searchFieldTypeProInfo = $("#searchContentList").val();
	})
	
	$("#searchContentListFault").on("change",function(e) {
		$scope.searchFieldTypeFault = $("#searchContentListFault").val();
	})
	
	$("#searchContentListRepair").on("change",function(e) {
		$scope.searchFieldTypeRepair = $("#searchContentListRepair").val();
	})
	
	$scope.getRepClass = function(){
		//类别字典
		$http({
			method : "POST",
			url : "${ctx}/Basedictionary/selectAll.htm",
			params : {
				dictType: "REPOSITORY_CLASS"
			}
		}).success(function(result) {
			$scope.repClassList = result;
		});
	}
	//文档分类
	$scope.getRepClass();
	
	//切换文档分类
	$scope.selectRepClass = function(rtype){
		$scope.repclass = rtype;
		$scope.onSelectPage(1);
	}
	
	$scope.manufChange = function () {
		$scope.manuFId = angular.copy($scope.manus.selected.id);
		$scope.productId = null;
		$scope.getProductList($scope.manuFId);
	}
	
	$scope.getManuF = function(){
		//所属厂商--------------------------start------------------------------------
		$scope.manus = {};
		$scope.manuf = null;
		$http({method:"POST",url:"${ctx}/Manufacturer/selectAll.htm",
			params:{ }
		}).success(function (result) {
		 	$scope.manuf = result;
		 	if($scope.manuf.length>0 && $scope.manuf !=null){
			 	$scope.manuf.unshift({id : null,manufname : '-请选择设备厂商-'});
			 	$scope.manus.selected= { manufname: $scope.manuf[0].manufname,id:$scope.manuf[0].id};
		 	}
		});
    }

	//产品型号
	$scope.getProductList = function(manufid) {
		
		$scope.product = null;
		$scope.productd = {};
		$http({
			method : "POST",
			url : "${ctx}/Product/selectByManuf.htm",
			params : {
				manufid : manufid,
			}
		}).success(function(resultproduct) {
			$scope.product = resultproduct;
			if ($scope.product != null&& $scope.product.length > 0) {
				$scope.product.unshift({id : null,productname : '-请选择产品型号-'});
				$scope.productd.selected = {
						productname : $scope.product[0].productname,
						id : $scope.product[0].productid
				};
			}
		});
	}

	$scope.productChange = function() {
		$scope.productId = angular.copy($scope.productd.selected.id);
	}
	
	
	$scope.getManuF();
	$scope.getProductList();
	
	//获取所有设备分类
	$scope.getAllDeviceType = function(){
		//类别字典
		$http({
			method : "POST",
			url : "${ctx}/shareRepository/selectAllDeviceType.htm",
		}).success(function(result) {
			console.log(result)
			$scope.allDeviceTypeList = result;
		});
	}
	$scope.getAllDeviceType();
	
	//切换设备分类
	$scope.selectDeviceType = function(rtype){
		$scope.deviceType = rtype;
		$scope.onSelectPage(1);
	}
	
	//历史维修排序
	$scope.radioSelectRepair = function(ctype){
		$scope.currentSortFieldRepair = ctype;
		$scope.onSelectPage(1);
	}
	
	//查看卡片时，浏览次数加1
	$scope.viewsCountAdd = function(id){
		$http({
			method : "POST",
			url : "${ctx}/shareRepository/addViewsCount.htm",
			params : {
				'id': id,
				'queryType' : $scope.modelType
			}
		}).success(function(result) {
			
		});
	}
});
</script>
