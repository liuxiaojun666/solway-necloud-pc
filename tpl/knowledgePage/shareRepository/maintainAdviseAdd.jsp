<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
	.table .t_center{text-align:center;}
	.table .t_right{text-align:right;}
	.table .t_left{text-align:left;}
	.tree-box{position:relative;}
	.tree-select{display:none;width:90%;position:absolute;top:33px;left:15px;z-index:1001;background:#fff;border:1px solid #cfdadd;max-height:260px;overflow:scroll;}
	.tree-show{position:relative;}
	.tree-icon{position:absolute;width:0px;height:0px;border-left: 8px solid transparent;border-right: 8px solid transparent;border-top: 12px solid #cfdadd;right:10px;top:12px;}
	.pname{position: absolute;z-index: 1;top: 0px;opacity: 0;}
	.tree-box ul{height: auto;}
</style>
<div ng-controller="addMaintainAdvise">
	<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Protocol/update.htm" method="post" id="editForm" name="editForm">
		<div class="wrapper-md bg-light b-b">
			<span class="font-h3 blue-1 m-n text-black">编辑维修建议信息</span>
		</div>
		<div class="wrapper-md ng-scope">
			<div class="col-sm-12 wrapper panel">
				<div class="form-group col-sm-12" >
					<label class="col-sm-1 control-label">类型</label>
					<div class="col-lg-3 tree-box">
						<div class="tree-show" ng-click="showTreeSelect()">
							<input type="text" name="typeName" id="typeName" placeholder="请输入类型" class="form-control formData">
							<p type="text" class="form-control formData pname"></p>
							<span class="tree-icon"></span>
						</div>
						<div class="tree-select" id="treeSelect">
							<ul id="classifyTree" class="ztree"></ul>
						</div>
						<input type="hidden" ng-model="type" id="type" name="type" class="form-control formData">
					</div>
				</div>
				<div class="form-group col-sm-12" >
					<label class="col-sm-1  control-label ">生产厂商</label>
					<div class="col-lg-3">
						<ui-select  ng-model="manus.selected" theme="bootstrap" ng-change="queryProduct()">
							<ui-select-match placeholder="请输入关键字..." ng-model="manus.selected.manufname" >{{$select.selected.manufname}}</ui-select-match>
							<ui-select-choices repeat="d in manuf">
								<div ng-bind-html="d.manufname"></div>
							</ui-select-choices>
						</ui-select>
					</div>
					<label class="col-sm-1  control-label ">产品型号</label>
					<div class="col-lg-3">
						<ui-select  ng-model="productd.selected" theme="bootstrap" ng-change="queryProtocol()">
							<ui-select-match placeholder="请输入关键字..." ng-model="productd.selected.name" >{{$select.selected.productname}}</ui-select-match>
							<ui-select-choices repeat="p in product">
								<div ng-bind-html="p.productname"></div>
							</ui-select-choices>
						</ui-select>
					</div>
					<label class="col-sm-1  control-label ">协议名称</label>
					<div class="col-lg-3">
						<ui-select  ng-model="protocol.selected" theme="bootstrap" ng-change="queryFaultCodeList()">
							<ui-select-match placeholder="请输入关键字..." ng-model="protocol.selected.name" >{{$select.selected.name}}</ui-select-match>
							<ui-select-choices repeat="pro in protocols">
								<div ng-bind-html="pro.name"></div>
							</ui-select-choices>
						</ui-select>
					</div>
				</div>
			</div>
		</div>

		<div class="wrapper-md ng-scope">
			<div class="col-sm-12 wrapper panel">
				<div class="form-group col-sm-12">
					<span class="font-h3 blue-1 m-n text-black"> 维修建议配置</span>
				</div>
				<table id="result_table" class="table table-striped b-t b-light">
					<thead>
						<tr>
							<th width="10%" class="t_center">状态码值</th>
							<th width="20%" class="t_center">状态描述</th>
							<th width="70%" class="t_center">维修建议</th>
						</tr>
					</thead>
					<tbody>
						<tr ng-repeat="faultCode in faultCodes" on-finish-render>
							<input type="hidden" value="{{faultCode.id}}" name="faultCodeId">
							<td width="10%" class="t_left" ng-bind="faultCode.faultCode"></td>
							<td width="20%" class="t_left" ng-bind="faultCode.faultDesc"></td>
							<td width="70%" class="t_left">
								<!-- 加载编辑器的容器 -->
								<script id="container{{$index+ueEditorIndex}}" name="container" type="text/plain"
										style="height:100px"></script>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="form-group m-t-sm" id="operButton" style="display: none">
					<div class="col-lg-12 text-center ">
						<button type="button" ng-click="saveForm();" id="saveButton"
								class="btn m-b-xs w-xs   btn-info">
							<strong>保 存</strong>
						</button>
						<button id="cancelBtn" type="button"
								class=" m-l-sm  btn m-b-xs w-xs btn-default"
								ng-click="backShareRepos();">
							<strong>取消</strong>
						</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>
<link rel="stylesheet" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="${ctx}/vendor/ueditor/ueditor.config.js" type="text/javascript"></script>
<script src="${ctx}/vendor/ueditor/ueditor.all.min.js" type="text/javascript"></script>
<script src="${ctx}/vendor/ueditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>
<script type="text/javascript">
	var setting = {
		check: {
			enable: true,
			chkStyle: "radio",
			radioType: "all"
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			onCheck: onCheck
		}
	};
	var zTreeObj;
	app.controller('addMaintainAdvise', function($scope, $state, $stateParams, $http){
		if($stateParams.type){
			$scope.type = $stateParams.type;
		}
		$scope.protocol = {};
		$scope.ueEditors = [];
		$scope.ueEditorContents = [];
		$scope.ueEditorIndex = 0;
		$scope.manus = {};
		$scope.productd = {};
		var opts = {
			toolbars: [
				['fullscreen', 'source', 'undo', 'redo', 'bold', 'italic', 'underline',
					'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat',
					'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor',
					'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc']
			],
			elementPathEnabled : false,
			wordCount:false
		};
		//查询生产厂商
		$scope.queryManuf = function(){
			$http({
				method: "POST",
				url: "${ctx}/Manufacturer/selectAll.htm",
				params: {}
			}).success(function (result) {
				$scope.manuf = result;
				if ($scope.manuf.length > 0 && $scope.manuf != null) {
					$scope.manuf.unshift({id: null, manufname: '请选择'});
					$scope.manus.selected = {
						manufname: $scope.manuf[0].manufname,
						id: $scope.manuf[0].id
					};
				}
			});
		};
		$scope.queryManuf();

		$scope.queryProduct = function(){
			$http({
				method: "POST",
				url: "${ctx}/Product/selectByManuf.htm",
				params: {
					manufid : angular.copy($scope.manus.selected.id)
				}
			}).success(function(result) {
				$scope.product = result || {};
				$scope.product.unshift({id: null, productname: '请选择'});
				if ($scope.product != null && $scope.product.length > 0) {
					$scope.productd.selected = {
						productname: $scope.product[0].productname,
						id: $scope.product[0].id
					}
				}
			});
		};

		//查询协议列表
		$scope.queryProtocol = function(){
			$http({
				method:"POST",
				url:"${ctx}/shareRepository/queryProtocol.htm",
				params:{
					productId: angular.copy($scope.productd.selected.id)
				}
			}).success(function(result){
				if(result.key == "0"){
					$scope.protocols = result.data || {};
					$scope.protocols.unshift({id : null, name : '请选择'});
					if($scope.protocols != null && $scope.protocols.length > 0){
						$scope.protocol.selected = { id: $scope.protocols[0].id, name:$scope.protocols[0].name};
					}
				}
			});
		};

		//查询状态码
		$scope.queryFaultCodeList = function(){
			$("#operButton").hide();
			$http({
				method:"POST",
				url:"${ctx}/shareRepository/queryFaultCodeList.htm",
				params:{
					id : angular.copy($scope.protocol.selected.id)
				}
			}).success(function(result){
				if(result.key == "0"){
					for(var i= 0,ii=$scope.ueEditors.length;i<ii;i++){
						UE.delEditor("container"+($scope.ueEditorIndex+i));
					}
					$("textarea[name='container']").remove();
					$scope.faultCodes = result.data;
					$scope.$applyAsync();
				}
			});
		};

		//返回
		$scope.backShareRepos = function(){
			$state.go('app.knowledge');
		};

		//保存表单
		$scope.saveForm = function(){
			var data = [];
			if($scope.faultCodes != null && $scope.faultCodes.length > 0){
				var items = null;
				for (var i= 0,ii=$scope.faultCodes.length;i<ii;i++){
					items = {};
					items.type = $scope.type;
					items.faultCodeId = $scope.faultCodes[i].id;
					items.faultCodeName = $scope.faultCodes[i].faultCode;
					items.protocolId = $scope.protocol.selected.id;
					items.content = $scope.ueEditors[i].getContent();
					data.push(items);
				}
			}

			$http({
				method:"POST",
				url:"${ctx}/shareRepository/saveMatinAdvice.htm",
				params:{
					data : JSON.stringify(data)
				}
			}).success(function(result){
				if(result.key == "0"){
					promptObj('success', "","保存成功");
					$state.go("app.addMaintainAdvise",{
						"type": $stateParams.type
					});
					return;
				}
				promptObj('error', '',"保存失败");
			});
		};

		//监听ng-repeat渲染完成
		$scope.$on('onFinishRender', function(event){
			if($scope.faultCodes != null && $scope.faultCodes.length > 0){
				$("#operButton").show();
				var ue = null, content = null;
				$scope.ueEditors = [];
				$scope.ueEditorContents = [];
				for(var i= 0,ii=$scope.faultCodes.length;i<ii;i++){
					ue = UE.getEditor('container'+($scope.ueEditorIndex+i), opts);
					content = $scope.faultCodes[i].content;
					$scope.ueEditorContents[i] = (content == null?"":content);
					$scope.ueEditors.push(ue);
				}
				$scope.ueEditorIndex += $scope.ueEditors.length;
				$scope.ueReadyContent(0);
			}
		});

		$scope.ueReadyContent = function(index){
			if($scope.ueEditors[index] != undefined){
				$scope.ueEditors[index].addListener('ready', function(){
					$scope.ueEditors[index].setContent($scope.ueEditorContents[index]);
					if(index < $scope.ueEditors.length){
						$scope.ueReadyContent(++index);
					}
				});
			}
		};

		$scope.initTreeTypeData = function(){
			$http({
				url: '${ctx}/shareRepository/initPageData.htm',
				method: 'GET',
				params: {
					type: $stateParams.type
				}
			}).success(function(data){
				var _obj = getSelectedTree(data.tree);
				if(_obj!=null){
					$("#typeName").val(_obj.name);
					$("input[name='type']").val(_obj.id);
				}
				var nodes = setParentData(data.tree);
				if($stateParams.type){
					nodes = setSelectedNode(nodes, $stateParams.type);
				}
				zTreeObj = $.fn.zTree.init($("#classifyTree"), setting, nodes);
			}).error(function(data,header,config,status){
				alert("数据初始化失败");
			});
		};
		$scope.initTreeTypeData();

		$scope.showTreeSelect = function(){
			var _obj = $("#treeSelect");
			if(_obj.is(":visible")){
				_obj.slideUp(200);
			}else{
				_obj.slideDown(500);
			}
		};
	});

	function getSelectedTree(arr){
		for(var i=0,ii=arr.length;i<ii;i++) {
			var _obj = arr[i];
			if(_obj.flag == 1){
				return _obj;
			}
		}
	}

	function setParentData(arr){
		for(var i=0,ii=arr.length;i<ii;i++) {
			var _obj = arr[i];
			if(!_obj.pId){
				_obj.isParent = true;
			}
			if (_obj.children && _obj.children.length > 0) {
				setParentData(_obj.children);
			}
		}
		return arr;
	}

	function setSelectedNode(arr, type){
		for(var i=0,ii=arr.length;i<ii;i++){
			var _obj = arr[i];
			if(_obj.id == type){
				_obj.checked = true;
				$("#typeName").val(_obj.name);
				$("input[name='type']").val(_obj.id);
				setTreeOpen(_obj.pId,arr);
				return arr;
			}
		}
		return arr;
	}

	function setTreeOpen(pId, arr){
		(function treeOpen(pId){
			if(!pId) return;
			for(var i=0,ii=arr.length;i<ii;i++){
				var _obj = arr[i];
				if(_obj.id == pId){
					_obj.open = true;
					treeOpen(_obj.pId);
				}
			}
		})(pId);
		return arr;
	}

	function onCheck(event, treeId, treeNode){
		$("#typeName").val(treeNode.name);
		$("input[name='type']").val(treeNode.id);
		$("#treeSelect").slideUp(200);
	}
</script>
