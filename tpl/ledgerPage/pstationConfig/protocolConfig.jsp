<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div ng-controller="protocolConfigListCtrl" class="modal fade" id="protocolConfigList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg">
  <div class="modal-content ">
   <div class="modal-body col-sm-12 wrapper panel">
   
   	<div class="wrapper-md ng-scope">
	<div class="col-sm-12 wrapper panel">
	<div class="form-group col-sm-12">
  		<span class="font-h3 blue-1 m-n text-black" ng-bind="nameShow"></span>
  	</div>
  	<div class="form-group col-sm-12">
  		<input type="checkbox" id="allCheckBox" name="checkBoxNameAll" ng-click="selectAllCheckBox(1);"/>全选
  	</div>
  	<div class="form-group col-sm-12">
		<div class="col-sm-2 " ng-repeat="device in deviceList">
			<input type="checkbox" ng-checked="device.protocolID != null" ng-click="selectAllCheckBox(2);" name="checkBoxName" value="{{device.id}}"/><span ng-bind="device.name"></span>
		</div>
  	</div>
  	<div class="form-group col-sm-12">
  		<span class="font-h5 blue-1 m-n text-black" ng-show="deviceList.length == 0">(无设备)</span>
  	</div>
  	<div class="form-group m-t-sm ">
		<div class="col-lg-12 text-center ">
			<button type="button" ng-click="saveProtocolConfig();" id="saveButton" class="  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
			<button id="escCancelBtnDevice" type="button"class=" m-l-sm  btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
		</div>
	</div>
	</div>
   </div>   
</div>
</div>
</div>
</div>

<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script type="text/javascript">
app.controller('protocolConfigListCtrl',['$http','$scope','$stateParams','$state',
	function($http, $scope, $stateParams, $state) {
		
	$scope.$on('broadcastProtocolConfig', function(event, data) {
		$scope.deviceList = [];
		$scope.nameShow = data.pname +"-" +data.name;
		$scope.pstationid = data.pstationid;
		$scope.deviceType = data.deviceType;
		$scope.protocolId = data.protocolId;
		$http({method:"POST",
			url:"${ctx}/BpstationConfig/querySingleProtocolConfig.htm",
			params:{
				pstationid:data.pstationid,
				protocolId:data.protocolId,
				deviceType:data.deviceType,
				productId:data.productId
			}
		}).success(function (result) {
			$scope.deviceList = result.data;
			var isAll = true;
			for(var i=0;i<$scope.deviceList.length;i++){
				var dev = $scope.deviceList[i];
				if(!dev.protocolID){
					isAll = false;
					break;
				}
			}
			if(isAll){
				$("#allCheckBox").prop("checked" , true);
			}else{
				$("#allCheckBox").prop("checked" , false);
			}
		});
		$scope.selectAllCheckBox=function(type){
			if(type == 1){
				if($("#allCheckBox").prop("checked")){
					$("input[name='checkBoxName']").prop("checked", true);
				}else{
					$("input[name='checkBoxName']").prop("checked", false);
				}
				
			}else if(type == 2){
				var isAll = true;
				$("input[name=checkBoxName]").each(function(){
					if($(this).prop("checked") == false){
						isAll = false;
						return false;
					}
				});
				if(isAll){
					$("#allCheckBox").prop("checked" , true);
				}else{
					$("#allCheckBox").prop("checked" , false);
				}
			}
			
		} 
		
		$scope.saveProtocolConfig = function(){
			
			var idsselect = [];
			var idsnoselect = [];
			$("input[name=checkBoxName]").each(function(){
				if($(this).prop("checked")){
					idsselect.push($(this).val());
				}else{
					idsnoselect.push($(this).val());
				}
		    });
			if(idsselect == 0 && idsnoselect == 0){
				promptObj("success", '','无设备修改');
				hideModal("protocolConfigList");
				return;
			}
			$http({method:"POST",
				url:"${ctx}/BpstationConfig/updateProtocolConfig.htm",
				params:{
					pstationid:$scope.pstationid,
					protocolId:$scope.protocolId,
					deviceType:$scope.deviceType,
					idsselect:idsselect,
					idsnoselect:idsnoselect
				}
			}).success(function (result) {
				hideModal("protocolConfigList");
				if(result.key == 1){
					promptObj("success", '',result.msg);
				}else{
					promptObj("error", '',result.msg);
				}
				$scope.queryAllProtocolConfig();
			});
		}
		
    });
}]);
	
</script>

