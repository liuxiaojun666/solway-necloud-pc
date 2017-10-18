<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
.fileimgsizes {
    border: 1px solid #cfdadd;
    width: 80px;
    height: 65px;
    margin-right: 10px;
    float: left;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#saveFactory").validate( {
			rules : {
				stationcode:{
					number: true,
					required : true,
					maxlength : 11
				},
				stationname:{
					required : true,
					maxlength : 50
				},
				companyid:{
					maxlength : 11
				},
				managerid:{
					maxlength : 11
				},
				provinceid:{
					maxlength : 11
				},
				countyid:{
					maxlength : 11
				},
				cityid:{
					maxlength : 11
				},
				address:{
					maxlength : 50
				},
				buildcapacity:{
					number: true,
					maxlength : 10
				},
				longitude:{
					number: true
				},
				latitude:{
					number: true
				},
				productiondate:{
					dateISO:true
				},
				closedate:{
					dateISO:true
				},
				stationtel:{
					phone:true
				},
				descp:{
					maxlength : 300
				},
				checkstarttime:{
					dateVerify:true
				},
				checkendtime:{
					dateVerify:true
				}
			},
			submitHandler : function(form) {
				var options = {
						dataType : "json",
						success : function(json) {
							if(json.type=="error"){
								$("#factorynotonly").removeClass('hidden');
							}else{
								hideModal("factoryModal");
								$("#searchFactoryBtn").trigger("click");
								promptObj(json.type, '', json.message);
							}
						},error : function(json) {
							promptObj('error', '',"保存失败,请稍后重试");
						}
					};
					$("#saveFactoryButton").button('loading');
					$('#saveFactory').ajaxSubmit(options);
				}
		});
	});



	function saveFactoryForm(){
		$("#saveFactory").trigger("submit");
	}

	function getDateToMs(date){
		var TimeMs=new Date(date).getTime();
		return TimeMs;
	}

	//初始化页面数据
	function initFactoryPageData(id){
		$("#facparentid").val($("#stationid").val());
		$(".formData").val("");
		if(id != "" && id != null){
			$("#factoryid").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/PowerStation/selectById.htm",
				data:{"id":id,"isFac":1},
				success:function(result){
					var msg=result
					$("#facstationcode").val(msg.stationcode);
					$("#facstationname").val(msg.stationname);
					$("#faccompanyid").val(msg.companyid);
					$("#facmanagerid").val(msg.managerid);
					$("#facprovinceid").val(msg.provinceid);
					$("#faccityid").val(msg.cityid);
					$("#faccountyid").val(msg.countyid);
					$("#facaddress").val(msg.address);
					$("#facbuildcapacity").val(msg.buildcapacity);
					$("#faclongitude").val(msg.longitude);
					$("#faclatitude").val(msg.latitude);
					$("#facstatusrating").val(msg.statusrating);
					$("#facvaluesrating").val(msg.valuesrating);
					$("#facstationtel").val(msg.stationtel);
					$("#facstationzip").val(msg.stationzip);
					$("#facdescp").val(msg.descp);
					getFactoryData();
				 	address();
				}
			});
		}else{
			getFactoryData();
			address();
			generatePowerCode();
		}
	}
	var getFactoryData;
	var address;
	var generatePowerCode;
	app.controller('powerFactoryEditCtr', ['$http', 'toaster','$location', '$rootScope', '$scope', '$state', '$stateParams',
	    	                               function($http, toaster,$location, $rootScope, $scope, $state, $stateParams){


	//自动生成编号
	generatePowerCode=$scope.generatePowerCode = function() {
				$http({
					method : "POST",
					url : "${ctx}/PowerStation/generatePowerCode.htm",
					params : {
						'parentid' : 0,
						'comcode':0
					}
				}).success(function(result) {
					$("#facstationcode").val(result);
				  })
				};




		    $scope.stationd = {};
	    	$scope.station = null;
	getFactoryData=$scope.getFactoryData = function(){
		     //负责人下拉框查询-------------------------------------Start------------------------------------------
			$scope.managerd = {};
	    	$scope.manager = null;
			$http({method:"POST",url:"${ctx}/AdminUser/selectAll.htm",
				params:{

				}
			}).success(function (result) {
		    	 $scope.manager = result;
		    	 if( $scope.manager.length>0){
		    		 $scope.manager.unshift({userId:"",realName:'请选择'});
		    	 }
		    	 for(var i=0,len=$scope.manager.length;i<len;i++){
	 					if($scope.manager[i].userId==  $("#facmanagerid").val()){
	 						$scope.managerd.selected= { realName: $scope.manager[i].realName,userId:  $("#facmanagerid").val()};
	 					}
	 				}
		    	 $scope.managerChange= function () {
			         $("#facmanagerid").val(angular.copy($scope.managerd.selected.userId));
				}

			});
	}

	address=$scope.address=function(){
//	 		地址省市县start	===============================================================
			 $scope.provinced = {};
			 $scope.province = null;
		     $scope.cityd = {};
			 $scope.city = null;
			 $scope.countyd = {};
			 $scope.county = null;
			 $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
				 params:{
					 "treeLevel":1,
					 "parentId":1}
			 }).success(function (result) {
			    	 $scope.province = result;
			    	 if($("#facprovinceid").val() != null && $("#facprovinceid").val() != "" ){
				    	 for(var i=0,len=$scope.province.length;i<len;i++){
							if($scope.province[i].id==  $("#facprovinceid").val()){
								$scope.provinced.selected= { regionName: $scope.province[i].regionName,id:  $("#facprovinceid").val()};
							}
						}
			    	 }

			    	 $scope.provinceChange= function () {
			    		 var a = angular.copy($scope.provinced.selected.id);
			    		 $("#facprovinceid").val(a);
			    		 $scope.cityd.selected = {regionName : null,id : null};
			    		 $scope.countyd.selected = {regionName :null,id : null};
				         $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
				        	 params:{
				        		 "treeLevel":2,
				        		 "parentId":a
				        		 }})
				         .success(function (resultcity) {
				        	 $scope.city = resultcity;
				        	 for(var i=0,len=$scope.city.length;i<len;i++){
				 					if($scope.city[i].id==  $("#faccityid").val()){
				 						$scope.cityd.selected= { regionName: $scope.city[i].regionName,id:  $("#faccityid").val()};
				 					}
				 				}

					        	 $scope.cityChange= function () {
							        var b = angular.copy($scope.cityd.selected.id);
							        $("#faccityid").val(b);
							        $scope.countyd.selected= { regionName: null,id:  null};

							        $http({method:"POST",
							        	url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
							        	params:{
							        		"treeLevel":3,
							        		"parentId":((b==null) || (b==""))?0:b}})
							        .success(function (resultcounty) {
							        	$scope.county = resultcounty;
								        	for(var i=0,len=$scope.county.length;i<len;i++){
			 				 					if($scope.county[i].id==  $("#faccountyid").val()){
			 				 						$scope.countyd.selected= { regionName: $scope.county[i].regionName,id:  $("#faccountyid").val()};
			 				 					}
			 				 				}
								         $scope.countyChange= function () {
							        		 $("#faccountyid").val($scope.countyd.selected.id);
							        	 }
							        });
						       }
				        	 if($("#faccountyid").val() != null && $("#faccountyid").val() != "" ){
					    		 $scope.cityChange();
					    	 }
				         });
					}
			    	 if($("#faccityid").val() != null && $("#faccityid").val() != "" ){
			    		 $scope.provinceChange();
			    	 }
				});
			}
	}]);

</script>

<div ng-controller="powerFactoryEditCtr"  class="modal fade col-sm-12" id="factoryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
 <div class="modal-dialog ">
      <div class="modal-content ">
		<div class="modal-body">
	<div class="">
		<span class="font-h3 blue-1 m-n ">厂区信息管理</span>
	</div>
	<div class="wrapper-md ng-scope">
	<div class="panel panel-default">
		<div class="wrapper">
		<!-- form 开始 -->
		<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PowerStation/update.htm" method="post"  id="saveFactory" name="saveFactory">
			<input type="hidden" id="factoryid" name="id" class="formData">
			<input type="hidden" id="facparentid" name="parentid">
			<div class="form-group">
				<label class="col-lg-2 control-label">厂区编号</label>
				<div class="col-lg-4">
					<input type="text" readonly="readonly" id="facstationcode" maxlength="20" name="stationcode"  class="form-control formData">
				</div>
				<label class="col-lg-2 control-label">厂区名称</label>
				<div class="col-lg-4">
					<input type="text" id="facstationname" maxlength="30" name="stationname" class="form-control formData">
				</div>
			</div>

			<div class="form-group">
				<label class="col-lg-2 control-label">装机容量</label>
				<div class="col-lg-3">
					<input type="text" id="facbuildcapacity" name="buildcapacity" maxlength="10" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
				</div>
				<label class="col-lg-1 control-label">kW</label>
				<label class="col-lg-2 control-label">负责人</label>
				<div class="col-lg-4">
					<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
					<ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
					<ui-select-choices  repeat="item in manager | filter: $select.search">
					<div ng-bind-html="item.realName | highlight: $select.search"></div>
				</ui-select-choices>
			</ui-select>
			<input type="hidden" id="facmanagerid" name="managerid" class="form-control formData">
		</div>
	</div>
	<div class="form-group">
		<label class="col-lg-2 control-label">地址</label>
		<div class="col-lg-3">
			<ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
			<ui-select-match placeholder="请输入..." ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
			<ui-select-choices  repeat="item in province | filter: $select.search">
			<div ng-bind-html="item.regionName | highlight: $select.search"></div>
		</ui-select-choices>
	</ui-select>
	<input type="hidden" name ="provinceid" id="facprovinceid"  class="form-control formData"/>
</div>
<div class="col-lg-3 ">
	<ui-select ng-model="cityd.selected" theme="bootstrap" ng-change="cityChange()">
	<ui-select-match placeholder="请输入..." ng-model="cityd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
	<ui-select-choices  repeat="item in city | filter: $select.search">
	<div ng-bind-html="item.regionName | highlight: $select.search"></div>
</ui-select-choices>
</ui-select>
<input type="hidden" name ="cityid" id="faccityid"  class="form-control formData"/>
</div>
<div class="col-lg-4 ">
	<ui-select ng-model="countyd.selected" theme="bootstrap" ng-change="countyChange()">
	<ui-select-match placeholder="请输入..." ng-model="countyd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
	<ui-select-choices  repeat="item in county | filter: $select.search">
	<div ng-bind-html="item.regionName | highlight: $select.search"></div>
</ui-select-choices>
</ui-select>
<input type="hidden" name ="countyid" id="faccountyid"  class="form-control formData"/>
</div>
</div>
<div class="form-group">
	<div class="col-lg-2"></div>
	<div class="col-lg-10">
		<input type="text" id="facaddress" name="address" maxlength="50" class="form-control formData">
	</div>
</div>

<div class="form-group m-t-lg">
	<div id="factorynotonly"  class="hidden text-center m-b-sm"><font color="#FF0000">数据已存在,请勿重复插入!!!</font></div>
	<div class="col-lg-12 text-center">
		<button type="button" onclick="saveFactoryForm();" data-loading-text="保存中..." autocomplete="off" id="saveFactoryButton" class=" btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
		<button id="cancelFactoryBtn" type="button" class="m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
	</div>
</div>
</form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
</div>
</div>
</div>
