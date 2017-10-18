<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
    <script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
			rules : {
				repaircontent:{ 
					required : true,
					maxlength : 50
				},
				operator:{ 
					required : true,
					maxlength : 40
				},
				repairdate:{
					required : true
				},
				repairresult:{ 
					maxlength : 500
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
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});
	});
	
	function saveForm(){
		if($("#picture2").val()==""){
			$("#picture2").attr("disabled","disabled");
		}
		if($("#picture1").val()==""){
			$("#picture1").attr("disabled","disabled");
		}
		if($("#picture0").val()==""){
			$("#picture0").attr("disabled","disabled");
		}
		$("#editForm").trigger("submit");
	}
	
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		$("#devicetype").val("0").change(); 
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Repair/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#pstationid").val(msg.pstationid);
					$("#pstationname").val(msg.pstationname);
					$("#deviceid").val(msg.deviceid);
					$("#devicename").val(msg.devicename);
					$("#operator").val(msg.operator);
					$("#repairdate").val(new Date(msg.repairdate).Format("yyyy-MM-dd"));
					$("#repaircontent").val(msg.repaircontent);
					$("#repairresult").val(msg.repairresult);
					$("#repairimg").val(msg.repairimg);
					$("#devicetype").val(msg.devicetype).change(); 
					$("#status").val(msg.status);
					//显示图片
					if(msg.repairimg != null && msg.repairimg !=""){
						var array = msg.repairimg.split(",");
						for (var i=0;i<array.length;i++){
							$("#oldFile"+i).val(array[i]);
							$("#billImg"+i).attr("src","${imgPath}/document/opDeviceRepairPicture/"+array[i]);
						}
					}
					var status=msg.status;
					//radio 选中处理
					if (status) {
						var ridaolen = document.editForm.status.length;
						for (var i = 0; i < ridaolen; i++) {
							if (status == document.editForm.status[i].value) {
								document.editForm.status[i].checked = true;
							}
						}
					}
				}
			});
		}
	}
	//设备查询地址	
	var url={
			"url0":"null",
			"url1":"${ctx}/HistoryData/getJunctionBox.htm",
			"url2":"${ctx}/HistoryData/getInverter.htm",
			"url3":"${ctx}/HistoryData/getBoxchange.htm",
			"url4":"${ctx}/HistoryData/getAmmeter.htm",
			"url5":"${ctx}/HistoryData/getAerograph.htm",
	}
	//下拉查询
		app.controller('OpdevicerepairCtrl', ['$http','$location','$rootScope','$scope','$state','$stateParams',
		                                      function($http, $location, $rootScope, $scope, $state,$stateParams){
			// 电站下拉查询-------------------------------Start------------------------------------------------------								
			$scope.stationd = {};
			$scope.station = null;
			$http({
				method : "POST",
				url : "${ctx}/PowerStation/selectAll.htm",
				params : {
//						id : $("#id").val()
				}
			})
					.success(
							function(result) {
								$scope.station = result;
// 								if ($scope.station != null&& $scope.station.length > 0) {
// 									$scope.station.unshift({id : "",stationname : '请选择'});
// 								}
								
								if ($("#pstationid").val() != null&& $("#pstationid").val() != "") {
									for (var i = 0, len = $scope.station.length; i < len; i++) {
										if ($scope.station[i].id == $("#pstationid").val()) {
											$scope.stationd.selected = {
												stationname : $scope.station[i].stationname,
												id : $("#pstationid").val()
											};
										}
									}
								} else {
									$scope.stationd.selected = {
										stationname : $scope.station[0].stationname,
										id : $scope.station[0].id
									};
								}
								//选择框变化触发
								$scope.textChange = function() {
									$("#pstationid").val(angular.copy($scope.stationd.selected.id));
									$("#pstationname").val(angular.copy($scope.stationd.selected.stationname));
								}
								$scope.textChange();
							});

		//根据设备类型查询设备---------------------------Start------------------------------------------------				
			$scope.deviced = {};
			$scope.device = null;
			selectDevice = $scope.selectDevice = function(type){
				$("#devicetype").val(type);
				$scope.deviceType=type;	
				$http({
					method : "POST",
					url : url["url"+type],
					params : {
					pstationid: $("#pstationid").val(),
				},
				}).success(function(result) {
					$scope.device = result;
					if($scope.device.length>0){
						 	$scope.device.unshift({id:"",name:'请选择'});
							for(var i=0;i<$scope.device.length;i++){
								if($("#deviceid").val() == $scope.device[i].id){
									$scope.deviced.selected= { name: $scope.device[i].name,id: $scope.device[i].id};
									break;
								}
							}
						} else {
							$scope.deviced.selected= {name: $scope.device[0].name,id: $scope.device[0].id};
					}
				})
			};			
			
			$scope.deviceChange=function(){
				$("#deviceid").val(angular.copy($scope.deviced.selected.id));
				$("#devicename").val(angular.copy($scope.deviced.selected.name));
			}
			
		 		initPageData($stateParams.InId);  
				$scope.backInverter = function(){
				$state.go('app.opdeviceRepair');
			  }
		}]);
	
	//日期控件 年
	$('#repairdate').datetimepicker({
		language: 'zh-CN',
		format:"yyyy-mm-dd",
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});	
	
	function getStation(id){
		$.ajax({
			type:"post",
			url:"${ctx}/Login/getLoginUser.htm",
			dataType : "json",
			async: false,
			success:function(uerstation){
				if(uerstation.pstationid != null ){
				    $("#pstationid").val(uerstation.pstationid);
				}
			}
		});
	}
</script>
<script type="text/javascript">
 $("#picture0").css("display","block");
 function  getImg(obj,fileImgClass){
	  var fileImg = $("."+ fileImgClass);
      var explorer = navigator.userAgent;
      var imgSrc = $(obj)[0].value;
      if (explorer.indexOf('MSIE') >= 0) {
          if (!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/.test(imgSrc)) {
              imgSrc = "";
              fileImg.attr("src","/img/default.png");
              return false;
          }else{
              fileImg.attr("src",imgSrc);
          }
      }else{
          if (!/\.(jpg|jpeg|png|JPG|PNG|JPEG)$/.test(imgSrc)) {
              imgSrc = "";
              fileImg.attr("src","/img/default.png");
              return false;
          }else{
              var file = $(obj)[0].files[0];
              var url = URL.createObjectURL(file);
              fileImg.attr("src",url);
          }
      }
      var index=$(".imgfile .file").index($(obj));//获得当前元素的下标
      var imgs=$(".imgfile").children().size();
      if(index<imgs){
   	    var indexS=index+1;
        if(indexS==imgs){
       	 $(".imgfile").css("display","none");
        }
   	    $("#picture" + index).css("display","none");
        $("#picture"+(index+1)).css("display","block");
      }
 }
</script>
<div ng-controller="OpdevicerepairCtrl">
	<div class="wrapper-md bg-light b-b">
	<span class="font-h3 blue-1 m-n text-black">设备定期维护</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
          <!-- form 开始 -->
					<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid"
						action="${ctx}/Repair/update.htm" method="post" id="editForm"
						name="editForm">
						<input type="hidden" name="id" id="id" class="formData" />
						<div class="form-group">
								 <label
								class="col-lg-2 control-label">电站名称</label>
							<div class="col-sm-3">
								<ui-select ng-model="stationd.selected" theme="bootstrap"
									ng-change="textChange()"> <ui-select-match
									placeholder="请输入关键字..."
									ng-model="stationd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
								<ui-select-choices
									repeat="item in station | filter: $select.search">
								<div ng-bind-html="item.stationname | highlight: $select.search"></div>
								</ui-select-choices> </ui-select>
								<input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
								<input type="hidden" id="pstationname" name="pstationname" class="form-control formData">
							</div>
							
						</div>	
						
						<div class="form-group">
<!-- 							<input type="hidden"  name="devicetype" id="devicetype"> -->
							<label class="col-lg-2 control-label">设备类型</label>
							<div class="col-sm-3 " id="userType_Div">
								   <select class="form-control formData" name="devicetype" onchange="selectDevice(this.value);" id="devicetype" >
					                <option value="0">请选择</option>
					                <option value="3">箱变</option>
					                <option value="2">逆变器</option>
					                <option value="1">汇流箱</option>
					                <option value="5">气象仪</option>
					                <option value="4">电能表</option>
					                </select>
							</div>
							
							<label class="col-lg-2 control-label">设备名称</label>
							 <div class="col-sm-3 ">
				              	<ui-select ng-model="deviced.selected" theme="bootstrap" ng-change="deviceChange()">
					            <ui-select-match  placeholder="请选择设备..." ng-model="deviced.selected.name" >{{$select.selected.name}}</ui-select-match>
					            <ui-select-choices  repeat="item in device | filter: $select.search">
					              <div ng-bind-html="item.name | highlight: $select.search"></div>
					            </ui-select-choices>
					         	 </ui-select> 
			                	<input type="hidden" id="deviceid" name="deviceid" class="form-control formData">
			                	<input type="hidden" id="devicename" ng-model="deviced.selected.name" name="devicename" class="form-control formData">
			              </div> 
							
						</div>
          
               
              <div class="form-group">
              	<label class="col-lg-2 control-label">维修项目</label>
              		<div class="col-lg-3">
                		<input type="text" id="repaircontent" maxlength="50" name="repaircontent" class="form-control formData">
              		</div>
              	<label class="col-lg-2 control-label">维修时间</label>
              		<div class="col-lg-3">
                		<input type="text" id="repairdate" name="repairdate" class="form-control formData">
              		</div>
              
               </div>  
               
               
               <div class="form-group">
                <label class="col-lg-2 control-label">维修执行人</label>
              		<div class="col-lg-3">
                		<input type="text" id="operator" name="operator" maxlength="40" class="form-control formData">
              		</div>
               </div>
          
               
               
            <div class="form-group">
             <label class="col-lg-2 control-label">维修结果</label>
              <div class="col-lg-8">
               <textarea rows="4" maxlength="500" name="repairresult" id="repairresult" class="form-control formData"></textarea>
              </div>
            </div>
            
            <div class="form-group">
             <label  class="col-lg-2 control-label">结果图片</label>
             <div class="col-lg-7 imgfile" style="width:510px">
             	<div class="fileimgsize">
        			<img id="billImg0" class="fileImg0 fileimgsize" name = "billImg0" src="theme/images/uploadImg.png">
        			<input type="file" name="picture0" id ="picture0" class="file form-control formData" 
        			onchange="getImg(this,'fileImg0')"/>
       			</div>
       			<div class="fileimgsize">
        			<img id="billImg1" class="fileImg1 fileimgsize" name = "billImg1" src="theme/images/uploadImg.png">
        			<input type="file"  name="picture1" id ="picture1" class="file form-control formData" onchange="getImg(this,'fileImg1')"/>
       			</div>
       			<div class="fileimgsize">
        			<img id="billImg2" class="fileImg2 fileimgsize"  name = "billImg2" src="theme/images/uploadImg.png">
        			<input type="file"  name="picture2" id ="picture2" class="file form-control formData" onchange="getImg(this,'fileImg2')"/>
       			</div>
            		<input type="hidden" name="oldFile0" id ="oldFile0"  />
            		<input type="hidden" name="oldFile1" id ="oldFile1"  />
            		<input type="hidden" name="oldFile2" id ="oldFile2"  />
			 	</div>
			 	<div class="col-lg-2 no-padder" style="line-height:95px;">*最多上传三张照片</div>
         	 </div>   
            
            <div class="form-group">
           	<label class="col-lg-2 control-label">状态</label>
				<div id="userType_Div" class="col-lg-3">
						<label class="checkbox-inline i-checks"> <input
							type="radio" class="form-control" value="00" id="status00"
							name="status"> <i></i> 临时
						</label> <label class="checkbox-inline i-checks"> <input
							type="radio" class="form-control " value="01" id="status01"
							name="status"> <i></i> 正式
						</label> <label class="checkbox-inline i-checks"> <input
							type="radio" class="form-control " value="02" id="status02"
							name="status"> <i></i> 作废
						</label>
				</div>
           </div>    
               
               
             <div class="form-group m-t-lg">
            <div class="col-lg-12 text-center ">   
                <button type="button" onclick="saveForm();" id="saveButton" class="btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
                <button id="cancelBtn" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" ng-click="backInverter();"><strong>取消</strong></button>
   			 </div>
   			 </div>
   			 
          </form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
