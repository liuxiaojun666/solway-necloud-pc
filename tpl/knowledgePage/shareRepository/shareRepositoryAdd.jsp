<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div ng-controller="ShareRepositoryCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">编辑知识库信息</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" 
					method="post" id="editForm" name="editForm">
					<input type="hidden" name="id" value="{{sRepos.id}}"
						id="id" class="formData" />
					<div class="form-group">
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>标题</label>
						<div class="col-lg-6">
							<input type="text" id="title" maxlength="100" value="{{sRepos.title}}" name="title" placeholder="请输入名称"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>类型</label>
						<div class="col-lg-3 tree-box">
							<div class="tree-show" ng-click="showTreeSelect()">
								<input type="text" name="typeName" id="typeName" placeholder="请输入类型" class="form-control formData">
								<p type="text" class="form-control formData pname"></p>
								<span class="tree-icon"></span>
							</div>
							<div class="tree-select" id="treeSelect">
								<ul id="classifyTree" class="ztree"></ul>
							</div>
							<input type="hidden" id="type" name="type" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">类别</label>
						<div class="col-lg-3">
							<ui-select ng-model="dicts.selected" theme="bootstrap" ng-change="dictsChange()">
								<ui-select-match placeholder="请输入类别">{{$select.selected.dictName}}</ui-select-match>
								<ui-select-choices repeat="item in dicts | filter: $select.search">
								  	<div ng-bind-html="item.dictName | highlight: $select.search"></div>
								</ui-select-choices>
						  	</ui-select>
						   	<input type="hidden" name="repclass" id="repclass" value="" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">生产厂商</label>
						<div class="col-lg-3">
                        	<ui-select  ng-model="manus.selected" theme="bootstrap" ng-change="manufChange()" ng-disabled="{'t':true, 'f':false}[selectStatus]">
                        		<ui-select-match placeholder="请输入关键字..." ng-model="manus.selected.manufname" >{{$select.selected.manufname}}</ui-select-match>
                        		<ui-select-choices repeat="item in manuf | filter: $select.search">
                        			<div ng-bind-html="item.manufname | highlight: $select.search"></div>
                        		</ui-select-choices>
							</ui-select>
							<input type="hidden" name ="manuFId" id="manuFId" class="form-control formData"/>
                        </div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">产品型号</label>
						<div class="col-lg-3">
							<ui-select ng-model="productd.selected" theme="bootstrap" ng-change="productChange()" ng-disabled="{'t':true, 'f':false}[selectStatus]">
							<ui-select-match placeholder="请输入关键字..." ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
                            	<ui-select-choices repeat="item in product | filter: $select.search">
									<div ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
                            	</ui-select-choices>
							</ui-select>
							<input type="hidden" id="productIdStr" name="productIdStr" class="form-control formData">
							<input type="hidden" id="productId" name="productId" class="form-control formData">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 control-label">概要</label>
						<div class="col-lg-6">
							<textarea class="form-control" id="introduce" name="introduce" 
								rows="3" placeholder="请输入概要">{{sRepos.introduce}}</textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">关键词</label>
						<div class="col-lg-6">
							<input type="text" name="keywords" placeholder="多个关键词，请以,隔开"
								class="form-control formData" value="{{sRepos.keywords}}">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>内容</label>
						<div class="col-lg-9">
							<!-- 加载编辑器的容器 -->
							<script id="container" name="content" type="text/plain" style="height:600px"></script>
						</div>
					</div>
					<%--
					<div class="form-group">
						<div class="f-box">
							<label class="col-lg-2 control-label">附件1</label>
							<div class="col-lg-3">
								<input type="text" disabled name="filename" placeholder="请上传附件" class="form-control formData" />
								<input type="hidden" disabled name="filepath" />
								<input type="hidden" readonly name="fileid" />
							</div>
							<div class="col-lg-1 f-pos">
								<button type="button" class="btn btn-link">上传</button>
								<input type="file" name="files" id="files1" class="f-file fileupload" />
							</div>

							<div class="col-lg-1 f-pos f-op">
								<a class="text-info f-op-info">
									<i class="fa fa-paperclip" ng-click="download(1)"></i>
								</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="text-danger f-op-danger">
									<i class="icon-trash" ng-click="deleteFile(1);"></i>
								</a>
							</div>

						</div>
					</div>
					<div class="form-group">
						<div class="f-box">
							<label class="col-lg-2 control-label">附件2</label>
							<div class="col-lg-3">
								<input type="text" disabled name="filename" placeholder="请上传附件" class="form-control formData" />
								<input type="hidden" disabled name="filepath" />
								<input type="hidden" readonly name="fileid" />
							</div>
							<div class="col-lg-1 f-pos">
								<button type="button" class="btn btn-link">上传</button>
								<input type="file" name="files" id="files2" class="f-file fileupload" />
							</div>
							<div class="col-lg-1 f-pos f-op">
								<a class="text-info f-op-info">
									<i class="fa fa-paperclip" ng-click="download(2)"></i>
								</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="text-danger f-op-danger">
									<i class="icon-trash" ng-click="deleteFile(2);"></i>
								</a>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="f-box">
							<label class="col-lg-2 control-label">附件3</label>
							<div class="col-lg-3">
								<input type="text" disabled name="filename" placeholder="请上传附件" class="form-control formData" />
								<input type="hidden" disabled name="filepath" />
								<input type="hidden" readonly name="fileid" />
							</div>
							<div class="col-lg-1 f-pos">
								<button type="button" class="btn btn-link">上传</button>
								<input type="file" name="files" id="files3" class="f-file fileupload" />
							</div>
							<div class="col-lg-1 f-pos">
								<a class="text-info f-op-info">
									<i class="fa fa-paperclip" ng-click="download(3)"></i>
								</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="text-danger f-op-danger">
									<i class="icon-trash" ng-click="deleteFile(3);"></i>
								</a>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="f-box">
							<label class="col-lg-2 control-label">附件4</label>
							<div class="col-lg-3">
								<input type="text" disabled name="filename" placeholder="请上传附件" class="form-control formData" />
								<input type="hidden" disabled name="filepath" />
								<input type="hidden" readonly name="fileid" />
							</div>
							<div class="col-lg-1 f-pos">
								<button type="button" class="btn btn-link">上传</button>
								<input type="file" name="files" id="files4" class="f-file fileupload" />
							</div>
							<div class="col-lg-1 f-pos f-op">
								<a class="text-info f-op-info">
									<i class="fa fa-paperclip" ng-click="download(4)"></i>
								</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="text-danger f-op-danger">
									<i class="icon-trash" ng-click="deleteFile(4);"></i>
								</a>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="f-box">
							<label class="col-lg-2 control-label">附件5</label>
							<div class="col-lg-3">
								<input type="text" disabled name="filename" placeholder="请上传附件" class="form-control formData" />
								<input type="hidden" disabled name="filepath" />
								<input type="hidden" readonly name="fileid" />
							</div>
							<div class="col-lg-1 f-pos">
								<button type="button" class="btn btn-link">上传</button>
								<input type="file" name="files" id="files5" class="f-file fileupload" />
							</div>
							<div class="col-lg-1 f-pos f-op">
								<a class="text-info f-op-info">
									<i class="fa fa-paperclip" ng-click="download(5)"></i>
								</a>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<a class="text-danger f-op-danger">
									<i class="icon-trash" ng-click="deleteFile(5);"></i>
								</a>
							</div>
						</div>
					</div>
					--%>

					<div class="form-group">
						<label class="col-lg-2 control-label">附件上传</label>
						<div class="col-lg-10">
							<div id="WebUploader" style="margin-left:10px"></div>
						</div>
					</div>

					<div class="form-group m-t-sm ">
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
				</form>
				<!-- form 结束 -->
			</div>
		</div>
	</div>
</div>

<link rel="stylesheet" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script src="${ctx}/vendor/jquery/ajaxfileupload/ajaxfileupload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/ueditor/ueditor.config.js" type="text/javascript"></script>
<script src="${ctx}/vendor/ueditor/ueditor.all.min.js" type="text/javascript"></script>
<script src="${ctx}/vendor/ueditor/lang/zh-cn/zh-cn.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>

<link rel="stylesheet" href="${ctx}/vendor/jquery/WebUploader/css/webuploader.css" type="text/css">
<script type="text/javascript" src="${ctx}/vendor/jquery/WebUploader/webuploader.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/WebUploader/MyWebUploader.0x01.js"></script>

<style type="text/css">
.f-pos{position:relative;overflow: hidden;}
.f-file{position: absolute;top: 0px;height: 30px;opacity: 0;cursor: pointer;}
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
.line{height:auto;}
.tree-box{position:relative;}
.tree-select{display:none;width:90%;position:absolute;top:33px;left:15px;z-index:1001;background:#fff;border:1px solid #cfdadd;max-height:260px;overflow:scroll;}
.tree-show{position:relative;}
.tree-icon{position:absolute;width:0px;height:0px;border-left: 8px solid transparent;border-right: 8px solid transparent;border-top: 12px solid #cfdadd;right:10px;top:12px;}
.pname{position: absolute;z-index: 1;top: 0px;opacity: 0;}
.f-op-info,.f-op-danger{display: none}
</style>
<script type="text/javascript">
var ue = UE.getEditor('container');
ue.addListener('blur',function(editor){
	if(!ue.hasContents()) {
		$('#container').append('<label id="content-error" class="error" for="title">必填项</label>');
	} else {
		$('#content-error').remove();
	}
})
var zTreeObj, zNodes;
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

function onCheck(event, treeId, treeNode){
	$("#typeName").val(treeNode.name);
	$("input[name='type']").val(treeNode.id);
	$("#treeSelect").slideUp(200);
}

$(function() {
	$("#editForm").validate({
		rules : {
			title : {
				required : true,
				maxlength : 100
			},
			typeName : {
				required : true
			},
			introduce : {
				maxlength : 1000
			}
		},
		submitHandler : function(form) {
			$("#saveButton").attr("disabled", "disabled");
			var data = {};
			data.id = $("input[name='id']").val();
			data.title = $("input[name='title']").val();
			data.type = $("input[name='type']").val();
			data.repclass = $("input[name='repclass']").val();
			data.productId = $("input[name='productId']").val();
			data.introduce = $("#introduce").val();
			data.keywords = $("input[name='keywords']").val();
			data.content = ue.getContent();
			data.attachment = [];
			if(!ue.hasContents()) {
				$('#container').append('<label id="content-error" class="error" for="title">必填项</label>');
			} else {
				$('#content-error').remove();
			}
			var fileData = $("#WebUploader").getFileData();
			$.each(fileData, function(i, v){
				data.attachment.push({
					filename: v.originalFileName,
					attachment: v.fileName
				});
			});
			/*
			$(".f-box").each(function(){
				var _obj = $(this);
				var filename = _obj.find("input[name='filename']").val();
				if(filename!=""){
					var filepathObj = _obj.find("input[name='filepath']");
					data.attachment.push({
						filename: filename,
						attachment: filepathObj.val()
					});
				}
			});
			*/

			$.post("${ctx}/shareRepository/update.htm", {
				"data": JSON.stringify(data)
			}, function(result, status){
				if(result.key != 0){
					promptObj('success', "","保存成功");
					$("#cancelBtn").trigger("click");
					return;
				}
				promptObj('error', '',"保存失败");
				$("#saveButton").attr("disabled", "");
			});
		}
	});
	$(document).on('change', '.fileupload', function() {
		ajaxFileUpload($(this).attr("id"));
	});
//	$(".fileupload").on("change", function(){
//		ajaxFileUpload($(this).attr("id"));
//	});
});

var Manufacturer=null;
var getProductList=null;
var RepclassFuc = null;
app.controller('ShareRepositoryCtrl',['$http','$scope','$stateParams','$state', function($http, $scope, $stateParams, $state) {
	var params = {};
	params.id = $stateParams.id;
	params.type = $stateParams.type;
	$scope.stationd = {};
	$scope.stationd.selected = {
		name : "请选择",
		id : null
	};
	$scope.station = null;
	$scope.repclass = null;

	Manufacturer=$scope.getA = function(){
		//所属厂商--------------------------start------------------------------------
		$scope.manus = {};
		$scope.manuf = null;
		$http({method:"POST",url:"${ctx}/Manufacturer/selectAll.htm",
			params:{ }
		}).success(function (result) {
		 	$scope.manuf = result;
		 	if($scope.manuf.length>0 && $scope.manuf !=null){
			 	$scope.manuf.unshift({id : null,manufname : '请选择'});
			 	$scope.manus.selected= { manufname: $scope.manuf[0].manufname,id:$scope.manuf[0].id};
		 		for (var i = 0, len = $scope.manuf.length; i < len; i++) {
					if($scope.manuf[i].id==$("#manuFId").val()){
						$scope.manus.selected= { manufname: $scope.manuf[i].manufname,id:$scope.manuf[i].id};
					}
				}
		 	}
		});
    }
	RepclassFuc = $scope.getRepClass = function(){
		//类别字典
		$http({
			method : "POST",
			url : "${ctx}/Basedictionary/selectAll.htm",
			params : {
				dictType: "REPOSITORY_CLASS"
			}
		}).success(function(result) {
			$scope.dicts = result;
			$scope.dicts.unshift({dictValue : null,dictName : '请选择'});
			$scope.dicts.selected = result[0];
			if ($("#repclass").val() != null) {
				angular.forEach($scope.dicts, function(data){
					if (data.dictValue == $("#repclass").val()) {
						$scope.dicts.selected = data;
					}
				});
			}
			$scope.dictsChange = function () {
			   $("#repclass").val(angular.copy($scope.dicts.selected.dictValue));
		   	};
		});
	}
	$scope.initPageData = function(){

		$http({
			url: '${ctx}/shareRepository/initPageData.htm',
			method: 'GET',
			params: params
		}).success(function(data,header,config,status){
			var _obj = getSelectedTree(data.tree);
			if(_obj!=null){
				$("#typeName").val(_obj.name);
				$("input[name='type']").val(_obj.id);
			}
			var nodes = setParentData(data.tree);
			if(!params.id && !!params.type){
				nodes = setSelectedNode(nodes, params.type);
			}
			zTreeObj = $.fn.zTree.init($("#classifyTree"), setting, nodes);

			var files = [];
			if(data.sRepos){
				$scope.sRepos = data.sRepos;
				var d = data.sRepos.attachment;
				$.each(d, function(i, v){
					files.push({
						id: v.id,
						fileName: v.attachment,
						originalFileName: v.fileName
					});
				});
				/*
				for(var i=0,ii=d.length;i<ii;i++){
					$("input[name='filename']").eq(i).val(d[i].fileName);
					$("input[name='filepath']").eq(i).val(d[i].attachment);
					$("input[name='fileid']").eq(i).val(d[i].id);
					if(d[i].id != null && d[i].id != ''){
						$('.f-op-info').eq(i).show();
						$('.f-op-danger').eq(i).show();
					}
				}
				*/

				ue.ready(function(){
					ue.setContent(angular.copy($scope.sRepos.content));
                });
                if ($scope.sRepos.repclass) {
					$("#repclass").val($scope.sRepos.repclass);
				}
				if ($scope.sRepos.manuFId) {
					$("#manuFId").val($scope.sRepos.manuFId);
					$("#productId").val($scope.sRepos.productId);
					$scope.getProductList($scope.sRepos.manuFId)
				}

			}
			$scope.initAttachment(files);
			//初始化类别
			RepclassFuc();
			//初始化厂商
			Manufacturer();
		}).error(function(data,header,config,status){
			alert("数据初始化失败");
		});


	};
	$scope.initPageData();
	$scope.textChange = function(){
		$("#type").val(angular.copy($scope.stationd.selected.id));
	};
	
	$scope.saveForm = function(){
		$("#editForm").trigger("submit");
	};
	
	$scope.backShareRepos = function(){
		$state.go('app.knowledge');
	};
	
	$scope.showTreeSelect = function(){
		var _obj = $("#treeSelect");
		if(_obj.is(":visible")){
			_obj.slideUp(200);
		}else{
			_obj.slideDown(500);
		}
	};

	$scope.manufChange = function () {
		a = angular.copy($scope.manus.selected.id);
		$("#manuFId").val(a);
		$scope.getProductList(a);
	}

	//产品型号
	getProductList=$scope.getProductList = function(manufid) {
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
				$scope.product.unshift({id : null,productname : '请选择'});
				if ($("#productId").val()!="" && $("#productId").val()!=null) {
					for (var i = 0, len = $scope.product.length; i < len; i++) {
						if ($scope.product[i].id == $("#productId").val()) {
							$("#manuFId").val($scope.product[i].manufid)
							$scope.getA();
							$scope.productd.selected = {
									productname : $scope.product[i].productname,
									specification : $scope.product[i].specification,
									productid : $scope.product[i].id,
							}
						}
					}
				} else {
					$scope.productd.selected = {
						productname : $scope.product[0].productname,
						productid : $scope.product[0].productid
					};
				}
			}
		});
	}

	$scope.productChange = function() {
		$("#productId").val($scope.productd.selected.id);
		$("#productIdStr").val($scope.productd.selected.productname);
	}
/*
	$scope.download = function(index){
		window.open("${ctx}/shareRepository/downloadAttachment.htm?id="+$("input[name='fileid']").eq(index - 1).val());
	}
	$scope.deleteFile = function(index){
		$("input[name='filename']").eq(index - 1).val('');
		$("input[name='filepath']").eq(index - 1).val('');
		$('.f-op-info').eq(index - 1).hide();
		$('.f-op-danger').eq(index - 1).hide();
	}
	*/

	$scope.initAttachment  = function(files){
		$("#WebUploader").powerWebUpload({
			url: '${ctx}/shareRepository/fileUpload.htm',
			deleteServerFlag: false,
			files: files,
			onDownload:function(v){
				window.open("${ctx}/shareRepository/downloadAttachment.htm?id="+ v.id);
			},
			innerOptions: {
				duplicate:true,
				resize: false,
				fileNumLimit: 5,//验证文件总数量, 超出则不允许加入队列
				fileVal: 'files',
				accept: {
					extensions: 'gif,jpg,jpeg,bmp,png,zip,rar,7z,doc,docx,xls,xlsx,ppt,pptx,txt,',
				}
			},
		});
	}
}]);


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

function getSelectedTree(arr){
	for(var i=0,ii=arr.length;i<ii;i++) {
        var _obj = arr[i];
        if(_obj.flag == 1){
        	return _obj;
        }
    }
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

function setParentData(arr){
    for(var i=0,ii=arr.length;i<ii;i++) {
        var _obj = arr[i];
        if(!_obj.pId){
            _obj.isParent = true;
        }
        if(_obj.flag == 1){
            _obj.checked = true;
            arr = setTreeOpen(_obj.pId, arr);
        }
    }
    return arr;
}
/*
function ajaxFileUpload(fileId) {
    $.ajaxFileUpload
    (
        {
            url: '${ctx}/shareRepository/fileUpload.htm', 
            secureuri: false, 
            fileElementId: fileId, 
            formName: "file",
            dataType: 'json', 
            success: function (data, status)  
            {
            	if(data.key != 0){
            		var $fBox = $("#"+fileId).parents(".f-box");
            		$fBox.find("input[name='filename']").val($("#"+fileId).val());
            		$fBox.find("input[name='filepath']").val(data.path);
            		promptObj('success', "","上传成功");

            		$fBox.find('.f-op-danger').show();
            		return;
            	}
            	promptObj('error', "","上传失败");
            },
            error: function (data, status, e)
            {
            	promptObj('error', "","上传失败");
            }
        }
    )
    return false;
}
*/
</script>

