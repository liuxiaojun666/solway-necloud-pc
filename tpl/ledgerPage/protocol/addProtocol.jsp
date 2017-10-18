<div ng-controller="addprotocolCtrl">

	<!-- 弹出层界面 fault protocol -->
	<div id="faultProtocolEdit" data-ng-include="'${ctx}/tpl/ledgerPage/faultCodeReal/addFaultProtocol.jsp'"></div>
	<div id="faultProtocolView" data-ng-include="'${ctx}/tpl/ledgerPage/faultCodeReal/faultProtocolDetail.jsp'"></div>

	<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/Protocol/update.htm" method="post" id="editForm" name="editForm">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">协议配置</span>
	</div>
	<div class="wrapper-md ng-scope">
 	<div class="col-sm-12 wrapper panel">
		<input type="hidden" id="copyId" name="copyId">
 	<input type="hidden" id="id" name="id">
	<input type="hidden" id="faultdiagnosistype" name="faultdiagnosistype" value="2">
 	<input type="hidden" id="statusdata" name="statusdata">
			<div class="form-group  col-sm-12">
              <label class="col-lg-1 control-label ">生产厂商</label>
	              <div class="col-lg-3">
	             	<ui-select  ng-model="manus.selected" theme="bootstrap" ng-change="manufChange()" ng-disabled="{'t':true, 'f':false}[selectStatus]">
					<ui-select-match placeholder="请输入关键字..." ng-model="manus.selected.manufname" >{{$select.selected.manufname}}</ui-select-match>
				    <ui-select-choices repeat="item in manuf | filter: $select.search">
				    <div ng-bind-html="item.manufname | highlight: $select.search"></div>
				    </ui-select-choices>
					</ui-select>
	             	<input type="hidden" name ="manufid" id="manufid" class="form-control formData"/>
	              </div>

	              <label class="col-lg-1 control-label ">产品型号</label>
					<div class="col-lg-3">
						<ui-select ng-model="productd.selected" theme="bootstrap"
						ng-change="productChange()" ng-disabled="{'t':true, 'f':false}[selectStatus]"> <ui-select-match
						placeholder="请输入关键字..."
						ng-model="productd.selected.productname">{{$select.selected.productname}}-{{$select.selected.specification}}</ui-select-match>
						<ui-select-choices
						repeat="item in product | filter: $select.search">
						<div
						ng-bind-html="item.productname + '-' +item.specification | highlight: $select.search"></div>
						</ui-select-choices> </ui-select>
						<input type="hidden" id="productidStr" name="productidStr" class="form-control formData">
						<input type="hidden" id="productid" name="productid" class="form-control formData">
					</div >
					<label class="col-lg-1 control-label ">通讯规约</label>
	         	 <div class="col-lg-3">
	             	<ui-select  ng-model="protocols.selected" theme="bootstrap" ng-change="protocolChange()">
					<ui-select-match placeholder="请输入关键字..." ng-model="protocols.selected.name" >{{$select.selected.name}}-{{$select.selected.version}}</ui-select-match>
				    <ui-select-choices repeat="item in protocolf | filter: $select.search">
				    <div ng-bind-html="item.name + '-' + item.version | highlight: $select.search"></div>
				    </ui-select-choices>
					</ui-select>
	             	<input type="hidden" name="commid" id="commid" class="form-control formData"/>
	              </div>
	       		</div>

	            <div class="form-group col-sm-12" >
            	<label class="col-sm-1  control-label ">名称</label>
                	<div class="col-lg-3">
                		<input type="text" id="name" name="name" maxlength="50" class="form-control formData">
              		</div>


                	<label class="col-lg-1 control-label ">是否默认</label>
                	<div class="col-lg-2">
              			<label class="checkbox-inline i-checks ">
       			 			<input type="radio" name="isdefault" checked="true" id="statusdiagnosistype0" value="1"  class="form-control" >  <i></i> 是
         		 		</label>
         		 		<label class="checkbox-inline i-checks">
        			 		<input type="radio" name="isdefault"  id="statusdiagnosistype1" value="0"  class="form-control">  <i></i> 否
         		 		</label>
         			</div>

	          </div>
	         <div class="form-group col-sm-12">
              <label class="col-sm-1 control-label ">协议解析串</label>
              	<div class="col-lg-10">
              	  <textarea id="prostr" name="prostr" rows="5" maxlength="4096" class="form-control formData"></textarea>
              	</div>
             </div>


	</div>
</div>

	<div class="wrapper-md ng-scope">
	<div class="col-sm-12 wrapper panel">
	<div class="form-group col-sm-12">
          <a ng-class="{'btn btn-info btn-sm m-r-xs': diffConfVisible, 'btn btn-default btn-sm m-r-xs': !diffConfVisible}" ng-click="changeCodeData(0);"> 状态码配置</a>
          <a ng-class="{'btn btn-info btn-sm m-r-xs': !diffConfVisible, 'btn btn-default btn-sm m-r-xs': diffConfVisible}" ng-click="changeCodeData(1);"> 故障码配置</a>
  	</div>
  	<div ng-show="diffConfVisible">
		<div class="form-group col-sm-12">
			<label class="col-lg-1 control-label">判断类型</label>
			<div class="col-lg-11">
				<label class="checkbox-inline i-checks ">
					<input type="radio"  name="statusdiagnosistype" onchange="hideDiv(this.value)" id="statustype0" value="1"  class="form-control " >  <i></i> 整型
				</label>

				<label class="checkbox-inline i-checks">
					<input type="radio" name="statusdiagnosistype" checked="true" onchange="hideDiv(this.value)"  id="statustype1" value="2"  class="form-control ">  <i></i> 按位(状态码全为0时所对应的索引位置为-1)
				</label>
			</div>
		</div>
		<table id="result_table" class="table table-striped b-t b-light">
			<thead>
				<tr>
					<th class="indexseat" width="15%">索引位置</th>
					<th class="statusval" width="15%">状态码值</th>
					<th width="15%">状态分类</th>
					<th width="30%">状态描述</th>
					<%--<th width="20%" >故障分类(汇流箱用)</th>--%>
					<th width="5%">操作</th>
				</tr>
			</thead>
			<tbody id="maxDiv">
				<tr id="del">
					<td class="hidden">
						<div class="form-group">
						  <div class="col-lg-12">
							  <input type="text"  id="fid"  maxlength="6" class="form-control formData ">
						 </div>
						</div>
					</td>

					<td class="indexseat">
						<div class="form-group">
						  <div class="col-lg-12">
							  <input type="text" id="faultcodeindex"  maxlength="6" placeholder="请输入数字类..." onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control formData faultcodeindex">
						 </div>
						</div>
					</td>

					<td class="statusval">
						<div class="form-group">
						  <div class="col-lg-12">
							  <input type="text" id="faultcode"  maxlength="50" placeholder="请输入数字类..." onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control formData  faultcode">
						 </div>
						</div>
					</td>

					<td>
						<div class="form-group">
						  <div class="col-lg-12">
							<select id="faultlevel"  class="form-control formData " onchange="selectfaultle(this.value)"></select>
							<input type="hidden" id="faultlevelVal" class="form-control formData">
						  </div>
						</div>
					</td>

					<td >
						 <div class="form-group">
							<div class="col-lg-12">
								<input type="text" id="faultdesc"  maxlength="50" class="form-control formData ">
						   </div>
						</div>
					</td>
					<%--
					<td >
						<div class="form-group">
						  <div class="col-lg-12">
							  <select   id="fclasscode" name="fclasscodeName"  class="form-control formData " onchange="selectfclass(this,this.value)"></select>
							  <input type="hidden" id="fclasscodeVal" class="form-control formData">
						 </div>
						</div>
					</td>
					--%>
					<td>
						<div class="form-group">
							<div class="col-lg-12" >
							<a onclick = "removeEt('del')">删除</a>
						   </div>
						</div>
					</td>
				</tr>
			</tbody>

			<tbody>
			   <tr style="height:50px;">
				<td class=" pull-left">
					<button type="button" onclick="appendVersion();" id="saveButton0" class=" m-l-sm pull-right btn m-b-xs w-xs btn-info" style="background-color:#4682B4; border-color:#4682B4"><strong>新增</strong></button>
				</td>
				<td class=" pull-left">
				</td>
				<td>
					<div class="showHint">
					<font id="showHint" color="#FF0000"></font>
					</div>
				</td>
					<td class="pull-right">
						<div class="form-group">
						   <div class="col-lg-12">
							<button type="button" ng-click="goProtocol()" id="cancelBtn" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"><strong>取消</strong></button>
							<button type="button" onclick="saveForm();" id="saveButton" class="m-l-sm pull-right  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
						 </div>
						</div>
					</td>
				   <td></td>
				</tr>
			</tbody>
		</table>
	</div>
  	<div ng-show="!diffConfVisible">
		<jsp:include page="../faultCodeReal/faultProtocolList.jsp"/>
  	</div>
	</div>
   </div>
 </form>
 </div>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript">
var deviceType;
$(function() {
	$("#editForm").validate( {
		rules : {
			name:{
				required : true,
				maxlength : 50
			},
			version:{
				required : true,
				maxlength : 30
			},
			prostr:{
				required : true,
				maxlength : 4096
			},
			productid : {
				required : true
			},
			manufid : {
				required : true
			},
			commid : {
				required : true
			}

		},
		submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(json) {
					promptObj('success','',json.message);
					$("#cancelBtn").trigger("click");
				},
				error : function(json) {
					promptObj('error','',json.message);
					$("#errorFlag").trigger('click');
				}
			};
			$('#editForm').ajaxSubmit(options);
		}
	});

});
var tr = null;
//根据设备类型决定故障分类是否能选择
function changeFaultStatus(deviceType){
	if(deviceType == '1'){
		$("select[name='fclasscodeName']").attr("disabled",false);
	}else{
		$("select[name='fclasscodeName']").val("");
		$("select[name='fclasscodeName']").attr("disabled",true);
	}
}

function saveForm(){

	if($("#file2").val()==""){
		$("#file2").attr("disabled","disabled");
	}
	if($("#file1").val()==""){
		$("#file1").attr("disabled","disabled");
	}
	if($("#file0").val()==""){
		$("#file0").attr("disabled","disabled");
	}
	var val = $("input[name='statusdiagnosistype']:checked").val();
	if(val==1){
		$(".faultcodeindex").val(0);
	}else{
		$(".faultcode").val(1);
	}
	var arry =[];
	var ia = 0;
	var arrys = "";
	var formParam = new Array();
	$("#maxDiv").find("tr").each(function(){
		var trRow = {};
		var codeFlag = 0;
		$(this).find("select , input[id]").each(function(){
			var name = $(this).attr("id");
			var value = $(this).val();
			if(val==1){
				if(name == "faultcode"){
					var index = $.inArray(value, arry);
					if(index >=0) {
						arrys = arrys + value + ",";
					}else{
						arry[ia++]=value;
					}
				}
			}else{
				if(name == "faultcodeindex"){
					var index = $.inArray(value, arry);
					if(index >=0) {
						arrys = arrys + value + ",";
					}else{
						arry[ia++]=value;
					}
				}
			}
 			if(name && value && "" != value){
 				if(name == "faultcodeindex" && value == -1 ){
 					trRow["faultcode"] = "0";
 					value = "0";
 				}
 				if(name == "faultcode" && trRow["faultcode"] == "0" ){
 					value = "0";
 				}
				trRow[name] = value;
 			}
		});
		formParam.push(trRow);
	});
	$("#statusdata").val(JSON.stringify(formParam));
	if(arrys != ""){
		arrys = arrys.substr(0,arrys.length-1);
		if(val==1){
			$("#showHint").html("状态码值" + arrys +"重复!");
			return;
		}else{
			$("#showHint").html("索引位置" + arrys +"重复!");
			return;
		}

	}
	var requires = [
	                {"id":"faultcodeindex","msg":"索引位置不可为空!"},
	                {"id":"faultcode","msg":"状态码不可为空 !"},
	                /*{"id":"fclasscode","msg":"请选择故障分类 !"},*/
	                {"id":"faultlevel","msg":"请选择故障级别 !"}
	                ];
	var errorMsg = null;
	if(formParam.length == 0){
		$("#showHint").html("请添加状态码配置!!!");
					return;
	} else {
		for(var i=0, length = formParam.length; i<length; i++){
			for(var j = 0, reqLength = requires.length; j<reqLength; j++){
				if(!formParam[i][requires[j].id]){
					$("#showHint").html(requires[j].msg);
					return;
				}
			}

		}
	}
	$("#editForm").trigger("submit");
// 	if(($("#faultcodeindex").val()!="" && $("#faultcodeindex").val()!=null)
// 	&& ($("#faultcode").val()!="" && $("#faultcode").val()!=null)){
// 		if($("#fclasscode").val()!="" && $("#fclasscode").val()!=null){
// 			if($("#faultlevel").val()!="" && $("#faultlevel").val()!=null){
// 				$("#editForm").trigger("submit");
// 			}else{
// 				$("#showHint").html("请选择故障级别 !!!");
// 			}
// 		}else{
// 				$("#showHint").html("请选择故障分类 !!!");
// 		}

// 	}else{
// 				$("#showHint").html("索引位置或状态码不可为空 !!!");
// 	}



}

	function removeEt(obj){
		$("#"+obj).remove();
	}

//初始化页面数据
function initPageData(id,isCopy){
	$(".formData").val("");
	if(id != "" && id != null){
		
		if(!isCopy){
			$("#id").val(id);
		}
		 $.ajax({
			type:"post",
			url:"${ctx}/Protocol/selectById.htm",
			data:{"id":id},
			success:function(msg){
				deviceType = msg.deviceType;
				if(!isCopy){
					$("#name").val(msg.name);
				}
				$("#version").val(msg.version);
				$("#prostr").val(msg.prostr);
				$("#productid").val(msg.productid);
				$("#commid").val(msg.commid);
				$("#faultdiagnosistype").val(msg.faultdiagnosistype);

				var statustype=msg.statusdiagnosistype;
				var statuslen=document.editForm.statusdiagnosistype.length;
				for(var a=0;a<statuslen;a++){
					if(statustype==document.editForm.statusdiagnosistype[a].value){
		                document.editForm.statusdiagnosistype[a].checked=true
		            }
				}
				//hideDiv(msg.statusdiagnosistype);
				var isdefault=msg.isdefault
		        var ridaolen=document.editForm.isdefault.length;
		        for(var i=0;i<ridaolen;i++){
		            if(isdefault==document.editForm.isdefault[i].value){
		                document.editForm.isdefault[i].checked=true
		            }
		        }
				 Manufacturer();
				 initFalultData(id);
				 if(getProductList!=null){
				 	getProductList(null);
				 }
				 if(getProtocolsList!=null){
					 getProtocolsList();
				 }
			}
		});
	}else{
		//hideDiv(2);
		
		Manufacturer();
		initFalultData(id);
		 if(getProductList!=null){
			 	getProductList(null);
		 }

		 if(getProtocolsList!=null){
			getProtocolsList();
		 }
		 changeFaultStatus(deviceType);

	}
}

function initFalultData(id){
	if(id != "" && id != null){
		 $.ajax({
			type:"post",
			url:"${ctx}/PFaultCode/selectAll.htm",
			data:{"protocolid":id},
			success:function(msg){
// 				$("#productid").val(msg.productid);
				$("#productname").val(msg.productname);
				$("#faultdesc").val(msg.faultdesc);
				$("#standardoper").val(msg.standardoper);
				if(msg.length==0){
					$("#del").remove();
				}
				for(var i=0;i<msg.length;i++){
					if(i == 0){
						$("#fid").val(msg[i].id);
						if(msg[i].faultcode == "0"){
							$("#faultcodeindex").val(-1);
						}else{
							$("#faultcodeindex").val(msg[i].faultcodeindex);
						}
						$("#faultcode").val(msg[i].faultcode);
						$("#fclasscode").val(msg[i].fclasscode);
						$("#faultlevel").val(msg[i].faultlevel);
						$("#faultdesc").val(msg[i].faultdesc);
					}else {
						$("#maxDiv").find("tr:last").after(tr);
						$tr = $("#maxDiv").find("tr:last");
						$tr.find("#fid").val(msg[i].id);
						if(msg[i].faultcode == "0"){
							$tr.find("#faultcodeindex").val(-1);
						}else{
							$tr.find("#faultcodeindex").val(msg[i].faultcodeindex);
						}
						$tr.find("#faultcode").val(msg[i].faultcode);
						$tr.find("#faultlevel").val(msg[i].faultlevel);
						$tr.find("#fclasscode").val(msg[i].fclasscode);
						$tr.find("#faultdesc").val(msg[i].faultdesc);

						var time = new Date().getTime();
						$tr.attr("id", time);
						$("#"+time).find("a").attr("onClick", "removeEt("+time+")");

					}
				}
				changeFaultStatus(deviceType);
				var statusType = $("input[name='statusdiagnosistype']:checked").val();
				hideDiv(statusType);

			}
		});
		}else{
				getFaulType();
				getFaultLevel();
				hideDiv(2);
	}
}

function getFaultLevel(dictId, $select){
	if(!$select){
		$select = $("#faultlevel");
	}

	$select.empty();
	$.ajax({
		type:"post",
		url:"${ctx}/PFaultCode/getFaultLevel.htm",
		dataType : "json",
		async: false,
		success:function(msg){
			$select.append("<option value=''>请选择</option>");
			for(var i=0,len=msg.length;i<len;i++){
				for(var i=0,len=msg.length;i<len;i++){
					var op="<option value='"+msg[i].id+"'";
					if(dictId!=null&&msg[i].id==dictId){
						op+=" selected='selected' ";
					}
					op+=">"+msg[i].dictName+"</option>";
					$select.append(op);
				}
			}
		}
	});
}
function getFaulType(dictId, $select){
	if(!$select){
		$select = $("#fclasscode")
	}
	$select.empty();
	$.ajax({
		type:"post",
		url:"${ctx}/PFaultCode/getFaulType.htm",
		dataType : "json",
		async: false,
		success:function(msg){
			$select.append("<option value=''>请选择</option>");
			for(var i=0,len=msg.length;i<len;i++){
				for(var i=0,len=msg.length;i<len;i++){
					var op='<option value="'+msg[i].id+'"';
					if(dictId!=null&&msg[i].id==dictId){
						op+=' selected="selected" ';
					}
					op+=">"+msg[i].dictName+"</option>";
					$select.append(op);
				}
			}
				var op='<option value="-1">自定义</option>'
					$select.append(op);
		}
	});
}
	function selectfclass(val){
		//$("#fclasscode").val(val);
	}
	function selectfaultle(val){
		//$("#faultlevel").val(val);
	}
	function hideDiv(val){
		if(val==1){
			$(".indexseat").hide();
			$(".statusval").show();
			//$(".faultcodeindex").val(0);
		}else{
			$(".statusval").hide();
			$(".indexseat").show();
			//$(".faultcode").val(1);
		}
	}

	function appendVersion(){
		var $lastTr = $("#maxDiv").find("tr:last");
		if($lastTr && $lastTr.html()){
			$lastTr.after(tr);
		} else {
			$("#maxDiv").append(tr);
		}
		var $tr = $("#maxDiv").find("tr:last");
		var time = new Date().getTime();
		$tr.attr("id", time);
		$("#"+time).find("a").attr("onClick", "removeEt("+time+")");
		var val=$("input[name='statusdiagnosistype']:checked").val();
		hideDiv(val);
		//滚动到底部
		var h = $(document).height()-$(window).height();
		$(document).scrollTop(h);
		changeFaultStatus(deviceType);
	}
var getProductList=null;
var Manufacturer=null;
var goSlavePage;
app.controller('addprotocolCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams',
                                   function($http,$location,$rootScope,$scope,$state,$stateParams){
	$scope.selectStatus = !!$stateParams.InId?'t':'f';
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
    	 		if($scope.manuf[i].id==$("#manufid").val()){
    	 			 $scope.manus.selected= { manufname: $scope.manuf[i].manufname,id:$scope.manuf[i].id};
    	 		}
    	 	}
    	 }
	});
}


   	 $scope.manufChange = function () {
   		  a = angular.copy($scope.manus.selected.id);
	      $("#manufid").val(a);
			 $scope.getProductList(a);
            }

	//通讯规约
 	$scope.protocols = {};
  	$scope.protocolf = null;
  	
  //型号
	getProtocolsList=$scope.getProtocolsList = function() {
		$http({method:"POST",url:"${ctx}/CommProtocol/selectAll.htm",
	 		params:{ }
	 	}).success(function (result) {
	 	 $scope.protocolf = result;
	 	 if($scope.protocolf.length>0 && $scope.protocolf !=null){
	 		 $scope.protocolf.unshift({id : null,name : '请选择'});
	 		 $scope.protocols.selected= { name: $scope.protocolf[0].name,id:$scope.protocolf[0].id};
	 	 for (var i = 0, len = $scope.protocolf.length; i < len; i++) {
	 	 		if($scope.protocolf[i].id==$("#commid").val()){
	 	 			 $scope.protocols.selected= { name: $scope.protocolf[i].name,id:$scope.protocolf[i].id,version:$scope.protocolf[i].version};
	 	 		}
	 	 	}
	 	 }
		});
  }
 	

 	$scope.protocolChange = function () {
	      $("#commid").val($scope.protocols.selected.id);
          }

	//返回List
	$scope.goProtocol=function(){
		$state.go('app.protocol');
	}

	//型号
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
							if ($("#productid").val()!="" && $("#productid").val()!=null) {
								for (var i = 0, len = $scope.product.length; i < len; i++) {
									if ($scope.product[i].id == $("#productid").val()) {
										$("#manufid").val($scope.product[i].manufid)
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
			deviceType = $scope.productd.selected.devicetype;
			changeFaultStatus(deviceType);
			$("#productid").val($scope.productd.selected.id);
			$("#productidStr").val($scope.productd.selected.productname);
				}

		getFaulType();
		getFaultLevel();
		$("#maxDiv").find("option[selected='selected']").removeAttr("selected");
		tr = $("#maxDiv").html();
		
		
		if($stateParams.copyId){
			$('#copyId').val($stateParams.copyId);
			initPageData($stateParams.copyId,true);
		}else{
			initPageData($stateParams.InId,false);
		}

		$scope.diffConfVisible = true;
		$scope.faultCodeReal = $scope.preFaultCodeReal = $('#faultdiagnosistype').val() == '1';

		$scope.hasProtocol = function(){
			var id = $("#id").val();
			if(id == "" || id == null){
				return false;
			}
			return true;
		}
		//判断故障码类型
		$scope.checkStateType = function(){
			var protocolID = $("#id").val();
			if(!$scope.hasProtocol()) {
				return;
			}
			$http({
				method : "POST",
				url : "${ctx}/PFaultCodeReal/checkStateType.htm",
				params : {
					protocolID: protocolID
				}
			}).success(function(data) {
				if (data.code == 0) {
					$scope.faultCodeReal = $scope.preFaultCodeReal = false;
					if (data.data == 1) {
						$scope.faultCodeReal = $scope.preFaultCodeReal = true;
					} else {
						$scope.faultCodeReal = $scope.preFaultCodeReal = false;
					}
				} else {
					$scope.changeFaultCodeRealStatus(true);
				}
			});
		}
		$scope.checkStateType();
		//判断是否已经存在数据
		$scope.hasFaultCodeRealOfProtocol = function(protocolID){
			$http({
				method : "POST",
				url : "${ctx}/PFaultCodeReal/hasFaultCodeReal.htm",
				params : {
					protocolID: protocolID
				}
			}).success(function(data) {
				if (!data) {
					if (confirm("切换故障码类型，将清空数据已填的故障码数据。\n确认清空吗？")) {
						$scope.deleteFaultCodeRealByProtocol(protocolID);
					} else {
						$scope.changeFaultCodeRealStatus(false);
					}
				} else {
					$scope.changeFaultCodeRealStatus(true);
				}
			});
		};
		//删除保存数据
		$scope.deleteFaultCodeRealByProtocol = function(protocolID){
			$http({
				method : "POST",
				url : "${ctx}/PFaultCodeReal/deleteByProtocol.htm",
				params : {
					protocolID: protocolID
				}
			}).success(function(data) {
				if (data.code == 0) {
					promptObj("success", '', data.message);
					$scope.onSelectPage(1);
					$scope.changeFaultCodeRealStatus(true);
				} else {
					$scope.changeFaultCodeRealStatus(false);
				}
			});
		};

		//fault model add xuqs
		//切换 状态码、故障码
		$scope.changeCodeData = function(type){
			if (type == 0) {
				$scope.diffConfVisible = true;
			}
			if (type == 1) {
				if(!$scope.hasProtocol()) {
					$scope.diffConfVisible = true;
					promptObj("error", '', "请先保存协议");
					return;
				}
				$scope.diffConfVisible = false;
				$scope.$broadcast('faultCodeReal', $scope.faultCodeReal);

				$scope.onSelectPage(1);
			}
		}
		//切换故障码类型
		$scope.changeFaultCodeReal = function(){
			var id = $("#id").val();
			if(!$scope.hasProtocol()) {
				promptObj("error", '', "请先保存协议");
				return;
			}
			$scope.hasFaultCodeRealOfProtocol(id);
		}

		//切换故障码类型 显示状态
		$scope.changeFaultCodeRealStatus = function(flag) {
			if (flag) {
				 $scope.preFaultCodeReal = $scope.faultCodeReal;
				var faultdiagnosistype = $scope.faultCodeReal? '1': '2'
				$http({
					method : "POST",
					url : "${ctx}/Protocol/updateFaultCodeRealType.htm",
					params : {
						'id' : $("#id").val(),
						'faultdiagnosistype': faultdiagnosistype
					}
				}).success(function(result) {
					if(result.code == 0) {
						$('#faultdiagnosistype').val(faultdiagnosistype);
					}
				});
			} else {
        		$scope.faultCodeReal = $scope.preFaultCodeReal;
			}
			$scope.$broadcast('faultCodeReal', $scope.faultCodeReal);
		}

		initTableConfig($scope);
		goSlavePage = $scope.onSelectPage = function(page) {
			if(!$scope.hasProtocol()) {
				promptObj("error", '', "请先保存协议");
				return;
			}

			if(!page){
				page = 1;
				$scope.currentPage=1;
			}
			$http({
				method : "POST",
				url : "${ctx}/PFaultCodeReal/list.htm",
				params : {
					'pageIndex' : page - 1,
					'pageSize' : $scope.pageSizeSelect,
					'protocolID' : $("#id").val(),
					'keyWords' : $scope.keyWords
				}
			}).success(function(result) {
				var firstData = result;
				getTableData($scope, result);
			});
		};
		$scope.editSlaveData = function(id, modalId) {
			editSlaveData(id, modalId);
		};
	   	$scope.viewSlaveData = function(id, modalId) {
		   	viewSlaveData(id, modalId);
	   	};
		//点击  Enter  键  查询
		document.onkeydown = function(e) {
		   var e = window.event   ?   window.event   :   e;
		   if(e.keyCode == 13){
			   $scope.onSelectPage(1);
			}
		}

		//下载故障码附件
		$scope.download = function(id, index){
			window.open("${ctx}/PFaultCodeReal/downloadAttachment.htm?id=" + id + "&index=" + index);
		}



		//单条删除
		$scope.deleteOneSlaveData = function(dataId,durl) {
			if (confirm("确定要删除这条数据吗？")) {
				$http({
					method : "POST",
					url : durl,
					params : {"id" : dataId}
				}).success(function(result) {
					promptObj("success", '', "删除成功");
					$scope.onSelectPage($scope.currentPage);
				}).error(function(){
				});
			}
		};
		//批量删除
		$scope.deleteBatchSlaveData = function(url){
			var ids = [];
			$("input[name='fcrids']:checked").each(function(){
				ids.push($(this).val());
			});
			if(ids.length == 0){
				alert("请至少选择一条记录!");
				return;
			}
			if(confirm("确定要删除这些记录吗?")){
				$http({
					method : "GET",
					url : "${ctx}/PFaultCodeReal/deleteBatch.htm",
					params : {
						"ids": ids
					}
				}).success(function(result) {
					if(result.code == 0){
						promptObj("success", '', "删除成功");
						$scope.onSelectPage($scope.currentPage);
						return;
					}
					promptObj("error", '', "删除失败");
				});
			}
		};
}]);


</script>
