<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script> 
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script> 
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
    <script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
			rules : {
				code:{ 
					number: true,
					required : true,
					maxlength : 50
				},
				name:{ 
					maxlength : 6
				},
				
				pstationid:{ 
					maxlength : 11
				},
				factid:{ 
					maxlength : 11
				},
				
				boxchangeid:{ 
					maxlength : 11
				},
				
				inverterroom:{ 
					maxlength : 50
				},
				invertergid:{ 
					maxlength : 11
				},
				address:{ 
					maxlength : 50
				},
				repaircard:{ 
					maxlength : 50
				},
				manufid:{ 
					maxlength : 11
				},
				productid:{ 
					maxlength : 11
				},
				mainparameter:{ 
					maxlength : 20
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
		app.controller('InverterAddCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
			initPageData($stateParams.InId);  
			$scope.backInverter = function(){
				$state.go('app.faultThreshold');
			  }
		}]);
	});
	function saveForm(){
		$("#editForm").trigger("submit");
	}
	
	function dateFormat(time){
	var date= (new Date(time)).Format("yyyy-MM-dd HH:mm:ss")
		return date;
	}
	
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/Threshold/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#pstationid").val(msg.pstationid);
					$("#pstationname").val(msg.pstationname);
					$("#deviceid").val(msg.deviceid);
					$("#devicename").val(msg.devicename);
					if(msg.checkstartdate){
						$("#startdate").val(dateFormat(msg.checkstartdate));	
					}
					if(msg.checkenddate){
						$("#enddate").val(dateFormat(msg.checkenddate));
					}
					$("#averagev").val(msg.averagev);
					$("#deviationrange").val(msg.deviationrange);
				}
			});
			 getStation(null);
			 getSelected(id);
		}else{
			 getStation(null);
			 getSelected(null);
		}
	}
	//下拉查询
	function getSelected(id){
		app.controller('FaultThreshold', ['$http', '$scope', function($http, $scope){
			$scope.stationd = {};
			$scope.station = null;
			$scope.factd = {};
			$scope.fact = null;
	    	$http({method:"POST",url:"${ctx}/PowerStation/selectByParentId.htm",params:{}})
			.success(function (result) {
				$scope.station = result;
		    	 if($("#pstationid").val() != null && $("#pstationid").val() != "" ){
			    	 for(var i=0,len=$scope.station.length;i<len;i++){
						if($scope.station[i].id==  $("#pstationid").val()){
							$scope.stationd.selected= { stationname: $scope.station[i].stationname,id:  $("#pstationid").val()};
						}
					}
		    	 } else if(result.length==1){
		    		 $scope.stationd.selected= { stationname: $scope.station[0].pstationname,id:  $scope.station[0].pstationid};
		    		 $("#pstationid").val($scope.station[0].id);
		    	 }
		    	 
		    	 $scope.textChange= function () {
			         a = angular.copy($scope.stationd.selected.id); 
			         $("#pstationid").val(a);
			         $scope.factd.selected= { stationname: null,id:  null};
			         $http({method:"POST",url:"${ctx}/PowerStation/selectByParentId.htm",params:{parentid:a}})
			         .success(function (result) {
			        	 $scope.deviceName = result;
			        	 for(var i=0,len=$scope.deviceName.length;i<len;i++){
			 					if($scope.fact[i].id==  $("#factid").val()){
			 						$scope.factd.selected= { stationname: $scope.fact[i].stationname,id:  $("#factid").val()};
			 					}
			 				}
			        	 $scope.factChange= function () {
					         b = angular.copy($scope.factd.selected.id); 
					         $("#factid").val(b);
					        }
			         }); 
				} 
		    	 if($("#pstationid").val() != null && $("#pstationid").val() != "" ){
		    		 $scope.textChange();
		    	 }
		}); 
			
		 //所属电站---------------------------start----------------------------------
		 $scope.manufacturerd = {};
		 $scope.manufacturer = null;
		 $scope.productd = {};
		 $scope.product = null;
		 $http({method:"POST",url:"${ctx}/Manufacturer/selectAll.htm",params:{}})
			.success(function (result) {
		    	 $scope.manufacturer = result;
		    	 
		    	 if($("#manufid").val() != null && $("#manufid").val() != "" ){
			    	 for(var i=0,len=$scope.manufacturer.length;i<len;i++){
						if($scope.manufacturer[i].id==  $("#manufid").val()){
							$scope.manufacturerd.selected= { manufname: $scope.manufacturer[i].manufname,id:  $("#manufid").val()};
						}
					}
		    	 }
		    	 //下拉查询
		    	 $scope.getDeviceName= function () {
		    		 stationid = angular.copy($scope.stationd.selected.id); 
		    		 devicetype = angular.copy($scope.deviceType); 
// 		    		 alert(stationId);
			         $http({
			        	 	method:"POST",url:"${ctx}/Product/selectByManuf.htm",
			        	 	params:{
				        	 		deviceType:devicetype,
				        	 		stationId:stationid}
			         		}).success(function (resultproduct) {
			        	 		$scope.product = resultproduct;
			        	 		for(var i=0,len=$scope.product.length;i<len;i++){
			 					if($scope.product[i].id==  $("#productid").val()){
			 						$scope.productd.selected= { productname: $scope.product[i].productname,id:  $("#productid").val()};
			 					}
			 				}
			        	 $scope.productChange= function () {
					         b = angular.copy($scope.productd.selected.id); 
					         $("#productid").val(b);
					        }
			         }); 
				} 
		    	 if($("#manufid").val() != null && $("#manufid").val() != "" ){
		    		 $scope.manufChange();
		    	 }
			}); 
			//所属厂商、产品---------------------------end----------------------------------s
		}]);
	}
	
	//日期控件 年
	$('#startdate').datetimepicker({
		language: 'zh-CN',
		format:"yyyy-mm-dd hh:ii:ss",
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 4,
		forceParse: 0
	});	
	
	//日期控件 年
	$('#enddate').datetimepicker({
		language: 'zh-CN',
		format:"yyyy-mm-dd hh:ii:ss",
		weekStart: 1,
		todayBtn: 1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 4,
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
<div ng-controller="InverterAddCtrl">
<div ng-controller="FaultThreshold">
	<div class="wrapper-md bg-light b-b">
		<h1 class="font-h3 blue-1 m-n text-black">预警阀值</h1>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
		
		<!-- form 开始 -->
		<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/Threshold/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="{{$stateParams.InId}}" id="id" class="formData"/>
          
           <div class="form-group">
              <div class="form-group">
             <label class="col-lg-2 control-label">电站名称</label>
              <div class="col-lg-3">
	              	<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname" >{{$select.selected.stationname}}</ui-select-match>
		            <ui-select-choices  repeat="item in station | filter: $select.search">
		              <div ng-bind-html="item.stationname | highlight: $select.search"></div>
		            </ui-select-choices>
		          </ui-select>
		           <input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
              </div>
             <label class="col-lg-2 control-label">设备名称</label>
             <div class="col-lg-3">
				<div class="col-lg-6">
	              <select id="pageSizeSelect"  placeholder="请选择设备类型..." ng-model="deviceType" ng-change="getDeviceName()" class="btn btn-default form-control ui-select-match ng-valid ng-touched">
	                <option value="3">箱变</option>
	                <option value="1">汇流箱</option>
	                <option value="2">逆变器</option>
	                <option value="4">气象仪</option>
	                <option value="5">电表</option>
            	</select>
              	</div>
              	<div class="col-lg-6">
	              	<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.productname" >{{$select.selected.productname}}</ui-select-match>
		            <ui-select-choices  repeat="item in station | filter: $select.search">
		              <div ng-bind-html="item.productname | highlight: $select.search"></div>
		            </ui-select-choices>
		          </ui-select>
		           <input type="hidden" id="productname" name="productname" class="form-control formData">
              </div>
              </div>
            </div>
                <div class="form-group">
                
                
                </div>
              <div class="form-group">
              <label class="col-lg-2 control-label">开始时间</label>
              <div class="col-lg-3">
                <input type="text" id="startdate" name="checkstarttime" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">结束时间</label>
              <div class="col-lg-3">
                <input type="text" id="enddate" name="checkendtime" class="form-control formData">
              </div>
               </div>  
               
              <div class="form-group">
              <label class="col-lg-2 control-label">平均值</label>
              <div class="col-lg-3">
                <input type="text" id="averagev" name="averagev" class="form-control  dateTime">
              </div>
              <label class="col-lg-2 control-label">偏差幅度</label>
              <div class="col-lg-3">
                <input type="text" id="deviationrange" name="deviationrange" class="form-control formData">
              </div>
               </div> 
               
               <div class="form-group">
                <label class="col-lg-2 control-label">主要参数</label>
              <div class="col-lg-8">
                <textarea rows="2"  id="mainparameter" name="mainparameter" class="form-control formData"></textarea>
              </div>
            </div>
            
             <div class="form-group m-t-lg">
            <div class="col-lg-8">   
                <button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="backInverter();"><strong>取消</strong></button>
                 <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 </div>
   			 </div>
   			 
          </form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
 </div>
