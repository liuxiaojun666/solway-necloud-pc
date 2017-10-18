<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script type="text/javascript">
//协议约定个数全局变量
var contentlen=0;
	$(function() {
		//表单验证功能
		$("#editForm").validate({
			rules : {
				ownerid : {
					required : true,
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success', '', json.message);
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
		app.controller('addOpentrustCtrl', ['$http','$location','$rootScope',
				'$scope','$state','$stateParams',
				function($http, $location, $rootScope, $scope, $state,$stateParams) {
					$scope.backCompany = function() {
						$state.go('app.opentrust');
					}
					//遍历协议约定start
					$.ajax({
						type : "post",
						url : "${ctx}/OpEntrust/selectcontent.htm",
						success : function(msg) {
							contentlen=msg.length;
							for(var i=0;i<=msg.length;i++){
								var a="<input type='radio' name='content"+i+"' value='0' disabled='disabled'/>只读";
								var b="<input type='radio' name='content"+i+"' value='1' disabled='disabled'/>读写<br/>";
								var str="content"+i;
								var c="<input name='checkstationnames"+msg[i][0]+"' type='checkbox' onclick='checkstationname(\""+str+"\")' id="+str+" /><span>"+msg[i][1]+"</span>";
								$("#xieyiyueding").append(c)
								$("#xieyiyueding").append(a);
								$("#xieyiyueding").append(b);
							}
						}
					});
					//初始化页面
					initPageData($stateParams.comId);
				} ]);
	});
	
	function getSelected(comId){
		app.controller('SelectedCtrl', ['$http', '$scope', function($http, $scope){
			//遍历运维电站名称start
			function nextdo(jiafangid){
				$.ajax({
					type : "post",
					url : "${ctx}/OpEntrust/selectpstationnames.htm",
					data : {
						"id" : jiafangid
					},
					success : function(msg) {
						for(var i=0;i<msg.length;i++){
							var str="<div class='col-sm-2  ng-scope'><input name='stationnames' type='checkbox' id='stationnames"+msg[i].id+"' value='"+msg[i].id+"' /><span>"+msg[i].stationname+"</span></div>";
							$("#stationname").append(str);
						}
						//回显运维电站名称
						yunwei(comId)
					}
				});
			}
			//甲方下拉框查询----------------------Start----------------------
			$scope.companyd = {};
	   		$scope.company = null;
			$http({method:"POST",url:"${ctx}/OpEntrust/selectCompanya.htm",params:{
			}})
			.success(function (result) {
			       $("#ownername").val(result[0].comName);
			       $("#ownerid").val(result[0].comId);
			       var jiafangid=result[0].comId;
			       //根据ID遍历运维电站名称
			       nextdo(jiafangid);
			       //甲方联系人下拉框查询----------------------Start----------------------
						$scope.linkmand = {};
				   		$scope.linkman = null;
						$http({method:"POST",url:"${ctx}/OpEntrust/selectLinkman.htm",params:{
							"comid":$("#ownerid").val()
						}})
						.success(function (result) {
					    	 $scope.linkman = result;
					    	 for(var i=0,len=$scope.linkman.length;i<len;i++){
									if($scope.linkman[i].userId==  $("#ownerman").val()){
										$scope.linkmand.selected= { realName: $scope.linkman[i].realName,userId:  $("#ownerman").val()};
									}
								}
					    	 $scope.linkmanChange= function () {
						         $("#ownerman").val(angular.copy($scope.linkmand.selected.userId));
							}
						});
			});
			//乙方下拉框查询----------------------Start----------------------
			$scope.companyda = {};
	   		$scope.companya = null;
			$http({method:"POST",url:"${ctx}/OpEntrust/selectCompany.htm",params:{}})
			.success(function (result) {
		    	 $scope.companya = result;
		    	 for(var i=0,len=$scope.companya.length;i<len;i++){
						if($scope.companya[i].comId==  $("#serviceid").val()){
							$scope.companyda.selected= { comName: $scope.companya[i].comName,comId:  $("#serviceid").val()};
						}
				 }
		    	 $scope.yifang();
		    	 $scope.companyChangea= function () {
		         	$("#serviceid").val(angular.copy($scope.companyda.selected.comId));
		         	$("#serviceman").val("");
		         	$scope.yifang();
				} 
			});
			$scope.yifang = function (){
				//乙方联系人下拉框查询----------------------Start----------------------
				$scope.linkmanda = {};
		   		$scope.linkmana = null;
				$http({method:"POST",url:"${ctx}/OpEntrust/selectLinkman.htm",params:{
					"comid":$("#serviceid").val()
				}})
				.success(function (result) {
			    	 $scope.linkmana = result;
			    	 for(var i=0,len=$scope.linkmana.length;i<len;i++){
							if($scope.linkmana[i].userId==  $("#serviceman").val()){
								$scope.linkmanda.selected= { realName: $scope.linkmana[i].realName,userId:  $("#serviceman").val()};
							}
						}
			    	 $scope.linkmanChangea= function () {
				         $("#serviceman").val(angular.copy($scope.linkmanda.selected.userId));
					}
				});
			}
			
		}]);
		//运维电站名称勾选
		function yunwei(comId){
			$.ajax({
				type : "post",
				url : "${ctx}/OpEntrust/selectstationById.htm",
				data : {
					"id" : comId
				},
				success : function(msg) {
					for(var i=0;i<msg.length;i++){
						var a=msg[i].bpowerstationid;
						$("input:checkbox[value='"+a+"']").attr('checked','true');
					}
				}
			});
		}
		
	}
	
	//协议约定复选框状态start
	function checkstationname(str){
		var a="#"+str;
		var test = document.getElementById(str).checked; 
		if(test==false){
			$("input[name='"+str+"']").attr("disabled",true);
			$("input[name='"+str+"']").removeAttr('checked');
		}
		if(test==true){
			$("input[name='"+str+"']").attr("disabled",false);
			var ss = $("input[name='"+str+"']");
			ss[0].checked = "checked";
		}
	}
	//日期控件
	$('#startdate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	$('#enddate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	$('#signdate').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	$('#ownercofirmtime').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	$('#servicecofirmtime').datetimepicker({
		format : "yyyy-mm-dd",
		minView : 2,
		language : 'zh-CN',
		todayHighlight : true,
		todayBtn : true,
		autoclose : true
	});
	function saveForm() {
		if($("input:checkbox[name='stationnames']:checked").length==0){
			alert("请至少选择一个运维电站");
			return;
		}
		//协议约定拼串start
		var content="";
		for(var i=0;i<contentlen;i++){
			var name = "content"+i;
			var a=$("input[name='"+name+"']:checked").val()
			if(a!= undefined){
			content=content+"0"+i+"-"+a;
			if(i!=contentlen-1)
			content=content+",";
			}
		}
		$("#content").val(content);
		//运维电站名称拼串start
		var a="";
		$('input[type="checkbox"][name="stationnames"]:checked').each(
		function() {
		a=a+$(this).val()+",";
		}
		);
		$("#pstationid").val(a);
		//提交表单
		$("#saveButton").button('loading');;
		$("#editForm").trigger("submit");
	}
	//运维电站名称复选框全选
	function checkall(){
		var s=$('input[type="checkbox"][name="stationnames"]');
		var shu=0;
		for(var i=0;i<s.length;i++){
			if(s[i].checked){
				shu++;
			}
		}
		if(shu==s.length){
			$('input[type="checkbox"][name="stationnames"]').each(
				function() {
					this.checked=false;
			});
		}else{
			$('input[type="checkbox"][name="stationnames"]').each(
				function() {
					if(!this.checked){
						this.checked=true;
				}
			});
		}
		
	}
	//初始化页面数据
	function initPageData(comId) {
		$(".formData").val("");
		if (comId != "" && comId != null) {
			$.ajax({
				type : "post",
				url : "${ctx}/OpEntrust/selectById.htm",
				data : {
					"id" : comId
				},
				success : function(msg) {
					$("#ownerid").val(msg.ownerid);
					$("#ownerman").val(msg.ownerman);
					$("#ownerphone").val(msg.ownerphone);
					$("#serviceid").val(msg.serviceid);
					$("#serviceman").val(msg.serviceman);
					$("#servicephone").val(msg.servicephone);
					$("#ownerconfirmman").val(msg.ownerconfirmman);
					var ownerconfirstatus=msg.ownerconfirstatus
			        var ridaolen=document.editForm.ownerconfirstatus.length;
			        for(var i=0;i<ridaolen;i++){
			            if(ownerconfirstatus==document.editForm.ownerconfirstatus[i].value){
			                document.editForm.ownerconfirstatus[i].checked=true
			            }
			        }
					var serviceconfirstatus=msg.serviceconfirstatus
			        var ridaolen1=document.editForm.serviceconfirstatus.length;
			        for(var i=0;i<ridaolen1;i++){
			            if(serviceconfirstatus==document.editForm.serviceconfirstatus[i].value){
			                document.editForm.serviceconfirstatus[i].checked=true
			            }
			        }
					$("#serviceconfirmman").val(msg.serviceconfirmman);
					$("#serviceconfirstatus").val(msg.serviceconfirstatus);
					$("#usestatus").val(msg.usestatus);
					if (msg.signdate) {
						$("#signdate").val(dateFormat(new Date(msg.signdate)));
					}
					if (msg.startdate) {
						$("#startdate")
								.val(dateFormat(new Date(msg.startdate)));
					}
					if (msg.enddate) {
						$("#enddate").val(dateFormat(new Date(msg.enddate)));
					}
					if (msg.ownercofirmtime) {
						$("#ownercofirmtime").val(
								dateFormat(new Date(msg.ownercofirmtime)));
					}
					if (msg.servicecofirmtime) {
						$("#servicecofirmtime").val(
								dateFormat(new Date(msg.servicecofirmtime)));
					}
					//协议约定复选框初始化
					var contentstr=msg.content.split(",");
					var idd;
					for(var i=0;i<contentstr.length;i++){
						var contentstr2=contentstr[i].split("-");
						if(contentstr2[0]!=""){
						var checkb="checkstationnames"+contentstr2[0];
						idd=$("input:checkbox[name="+checkb+"]");
						idd.attr('checked','true');
						}
						var ii=contentstr2[0].substr(contentstr2[0].length-1);
						$("input[name=content"+ii+"]").each(function () {
				            if ($(this).val() == contentstr2[1]) {
				            	$("input[name=content"+ii+"]").attr("disabled",false);
				                $(this).attr("checked", "checked");
				            }
				        });
					}
				}
			});
		}
		getSelected(comId);
	}
	//格式化时间
	function dateFormat(date) {
		var time = new Date(date).Format("yyyy-MM-dd");
		return time;
	}
</script>
<div ng-controller="addOpentrustCtrl">
<div ng-controller="SelectedCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">运维委托协议管理</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
			<div class="row wrapper">
				<!-- form 开始 -->
				<form class="bs-example form-horizontal ng-pristine ng-valid"
					action="${ctx}/OpEntrust/update.htm" method="post" id="editForm" name="editForm">
					<input type="hidden" name="id" value="{{$stateParams.comId}}" id="id" />
					<input type="hidden" name="usestatus" id="usestatus" />
					<div class="form-group">
						<label class="col-lg-2 control-label">甲方</label>
						<div class="col-sm-3">
							<input type="text" id="ownername" name="ownername" class="form-control formData" readonly="readonly">
							<input type="hidden" id="ownerid" name="ownerid" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">乙方</label>
						<div class="col-sm-3">
							<ui-select ng-model="companyda.selected" theme="bootstrap"
								ng-change="companyChangea()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="companyda.selected.comName">{{$select.selected.comName}}</ui-select-match>
							<ui-select-choices
								repeat="item in companya | filter: $select.search">
							<div ng-bind-html="item.comName | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="serviceid" name="serviceid" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">甲方联系人</label>
						<div class="col-sm-3">
							<ui-select ng-model="linkmand.selected" theme="bootstrap"
								ng-change="linkmanChange()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="linkmand.selected.realName">{{$select.selected.realName}}</ui-select-match>
							<ui-select-choices
								repeat="item in linkman | filter: $select.search">
							<div ng-bind-html="item.realName | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="ownerman" name="ownerman" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">乙方联系人</label>
						<div class="col-sm-3">
							<ui-select ng-model="linkmanda.selected" theme="bootstrap"
								ng-change="linkmanChangea()"> <ui-select-match
								placeholder="请输入关键字..." ng-model="linkmanda.selected.realName">{{$select.selected.realName}}</ui-select-match>
							<ui-select-choices
								repeat="item in linkmana | filter: $select.search">
							<div ng-bind-html="item.realName | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="serviceman" name="serviceman" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">甲方联系电话</label>
						<div class="col-lg-3">
							<input type="text" id="ownerphone" name="ownerphone"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">乙方联系电话</label>
						<div class="col-lg-3">
							<input type="text" id="servicephone" name="servicephone"
								class="form-control formData">
						</div>
					</div>
					<div class="row wrapper">
						<input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
						<label class="col-lg-2 control-label">运维电站名称</label>
						<div><input type="button" value="全选" onclick="checkall()"></div>
						<div class="col-sm-10 " id="stationname"></div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">签订时间</label>
						<div class="col-lg-3">
							<input type="text" id="signdate" name="signdate"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">服务开始日期</label>
						<div class="col-lg-3">
							<input type="text" id="startdate" name="startdate"
								class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">服务结束日期</label>
						<div class="col-lg-3">
							<input type="text" id="enddate" name="enddate" class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">协议约定</label>
						<div class="col-lg-3" id="xieyiyueding">
							<input type="hidden" id="content" name="content" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">甲方确认时间</label>
						<div class="col-lg-3">
							<input type="text" id="ownercofirmtime" name="ownercofirmtime"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">乙方确认时间</label>
						<div class="col-lg-3">
							<input type="text" id="servicecofirmtime"
								name="servicecofirmtime" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">甲方确认人</label>
						<div class="col-lg-3">
							<input type="text" id="ownerconfirmman" name="ownerconfirmman"
								class="form-control formData">
						</div>
						<label class="col-lg-2 control-label">乙方确认人</label>
						<div class="col-lg-3">
							<input type="text" id="serviceconfirmman"
								name="serviceconfirmman" class="form-control formData">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 control-label">甲方确认状态</label>
						  <div class="col-lg-10">
		           			 <label class="checkbox-inline i-checks">
		           			 <input type="radio" name="ownerconfirstatus"  id="ownerconfirstatus0" value="00"  class="form-control" >  <i></i>待确认
			           		 </label>
			           		 <label class="checkbox-inline i-checks">
		           			 <input type="radio" name="ownerconfirstatus"  id="ownerconfirstatus1" value="01"  class="form-control ">  <i></i>通过
			           		 </label>
			           		 <label class="checkbox-inline i-checks">
		           			 <input type="radio" name="ownerconfirstatus"  id="ownerconfirstatus2" value="02"  class="form-control ">  <i></i>拒绝
			           		 </label>
			              </div>
						<label class="col-lg-2 control-label">乙方确认状态</label>
						   <div class="col-lg-10">
		           			 <label class="checkbox-inline i-checks">
		           			 <input type="radio" name="serviceconfirstatus"  id="serviceconfirstatus0" value="00"  class="form-control" >  <i></i>待确认
			           		 </label>
			           		 <label class="checkbox-inline i-checks">
		           			 <input type="radio" name="serviceconfirstatus"  id="serviceconfirstatus1" value="01"  class="form-control ">  <i></i>通过
			           		 </label>
			           		 <label class="checkbox-inline i-checks">
		           			 <input type="radio" name="serviceconfirstatus"  id="serviceconfirstatus2" value="02"  class="form-control ">  <i></i>拒绝
			           		 </label>
			              </div>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-4">
							<button id="cancelBtn" type="button"
								class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"
								ng-click="backCompany();">
								<strong>取消</strong>
							</button>
							<button type="button" onclick="saveForm();" id="saveButton"
									data-loading-text="保存中..." autocomplete="off" class=" pull-right btn m-b-xs w-xs   btn-info">
								<strong>保 存</strong>
							</button>
						</div>
					</div>
				</form><!-- form 结束 -->
			</div>
		</div>
	</div>
</div>
</div>
