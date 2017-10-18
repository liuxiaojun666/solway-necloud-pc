<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <script type="text/javascript">      
	$(function() {
		$("#editForm").validate( {
			rules : {
				pstationid:{
					required : true,
				},
				sysVersion:{
					required : true,
					maxlength : 10
				},
				collectAddr:{
					required : true,
					maxlength : 50
				},
				managerAddr:{
					required : true,
					maxlength : 50
				}
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						hideModal("productModal");
						//$('#manufacturerModal').modal('hide');
						goPage(0);
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
		$("#editForm").trigger("submit");
	}
	
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/BPDatacollCfg/selectById.htm",
				data:{"id":id},
				success:function(msg){
					$("#pstationid").val(msg.pstationid);
					$("#pstationname").val(msg.pstationname);
					$("#sysVersion").val(msg.sysVersion);
					$("#collectAddr").val(msg.collectAddr);
					$("#managerAddr").val(msg.managerAddr);
				}
			});
			 getStationList();
		}else{
			 getStationList();
		}
	}
	app.controller('addBPDatacollCfgCtrl', ['$http',  '$scope','$stateParams','$state',  function($http,$scope,$stateParams, $state){
		$scope.stationd = {};
		getStationList = $scope.getStationList = function() {
			$http({method : "POST",
						url : "${ctx}/PowerStation/selectByParentId.htm",
						params : {}
					}).success(function(result) {
								$scope.station = result;
								if(result.length>0){
									$scope.station.unshift({id:"",stationname:'请选择'});
									$scope.stationd.selected = {stationname : $scope.station[0].stationname,id : $scope.station[0].stationname.id};
								}
									
								if ($("#pstationid").val() != null && $("#pstationid").val() != "") {
									for (var i = 0, len = $scope.station.length; i < len; i++) {
										if ($scope.station[i].id == $("#pstationid").val()) {
											$scope.stationd.selected = {stationname : $scope.station[i].stationname,id : $("#pstationid").val()};
										}
									}
								} 
							});
		}
		
		$scope.textChange = function(){
			pstationid = angular.copy($scope.stationd.selected.id);
			$("#pstationid").val(pstationid);
			if(pstationid){
			$("#pstationname").val($scope.stationd.selected.stationname);
			}else{
				$("#pstationname").val("");	
			}
		}
		
		initPageData($stateParams.InId);
	}]);

</script>
<div   ng-controller="addBPDatacollCfgCtrl"   class="modal fade" id="productModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h4 m-t-none m-b font-thin" id="myModalLabel">电站软件版本配置</span>
      <div class="panel-body">
          <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/BPDatacollCfg/update.htm" method="post" id="editForm" name="editForm">
          <input type="hidden" name="id" value="" id="id" class="formData"/>
          <div class="form-group">
              <label class="col-lg-2 control-label">电站名称</label>
						<div class="col-lg-4">
							<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
							 <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname">{{$select.selected.stationname}}</ui-select-match>
							<ui-select-choices repeat="item in station | filter: $select.search">
							<div ng-bind-html="item.stationname | highlight: $select.search"></div>
							</ui-select-choices> </ui-select>
							<input type="hidden" id="pstationid" name="pstationid" class="form-control formData">
							<input type="hidden" id="pstationname" name="pstationname" class="form-control formData">
						</div>
              
              <label class="col-lg-2 control-label">系统版本</label>
              <div class="col-lg-4">
                <input type="text" id="sysVersion" name="sysVersion" maxlength="10" class="form-control formData">
              </div>
           </div>
           <div class="form-group">
              <label class="col-lg-2 control-label">数据接收访问地址</label>
              <div class="col-lg-10">
                <input type="text" id="collectAddr" name="collectAddr" maxlength="50" class="form-control formData">
              </div>
            </div>
        
             <div class="form-group">
              <label class="col-lg-2 control-label">管理接口地址</label>
              <div class="col-lg-10">
                <input type="text" id="managerAddr" name="managerAddr" maxlength="50" class="form-control formData">
              </div>
             </div>
       
    
             <div class="form-group">
             <div class="col-lg-offset-2 col-lg-10">   
                <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                 <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 </div>
   			 </div>
          </form>
        </div>
    </div>
  </div>
</div>
</div>
</div>
</div>
