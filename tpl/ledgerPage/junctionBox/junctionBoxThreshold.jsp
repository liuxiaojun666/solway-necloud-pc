<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
    <script type="text/javascript">
	$(function() {
		$("#formSt").validate( {
			rules : {
				code:{ 
					number: true,
					required : true,
					maxlength : 50
				},
				name:{
					required : true,
					maxlength : 20
				},
				pstationid:{
					maxlength : 11
				},
				factid:{ 
					maxlength : 11
				},
				inverterid:{
					required : true,
					maxlength : 11
				},
				address:{ 
					maxlength : 50
				},
				standardoper:{ 
					maxlength : 20
				},
				manufid:{ 
					maxlength : 11
				},
				productid:{ 
					maxlength : 11
				},
				mainparameter:{ 
					maxlength : 20
				},
				batterypower:{ 
					maxlength : 14
				},
				batterycount:{ 
					number: true
				},
				batterygcount:{ 
					number: true
				},
				deviationrange:
				{ 
					decimal2:true,
					maxlength : 11
				},
				maskcode:{ 
					number: true,
					maxlength : 20
				},
				averagev:{ 
					decimal2:true,
					maxlength : 11
				},
				batteryprodparameter:{ 
					maxlength : 20
				}
			},
			submitHandler : function(form) {
				var option = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
							$("#close").trigger("click");
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#formSt').ajaxSubmit(option);
			}
		});
		app.controller('JunctionBoxThreshold', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
// 			PageData($stateParams.JbId); 
			$scope.backJunctionBox = function(){
				$state.go('app.junctionBox');
			  }
		}]);
	});
	
	function saveForm(){
		var beginDate=$("#startdate").val();
		var endDate=$("#cosedate").val();
		if(beginDate && endDate){
			if(getDateToMs(beginDate)>getDateToMs(endDate)){
				promptObj('error','',"停用时间不小于安装时间");
						return false;
				}else{
					$("#formSt").trigger("submit"); 
				}
		}else{
			$("#formSt").trigger("submit"); 
		}
	}
	
	function getDateToMs(date){
		Todate = date.replace(new RegExp("-","gm"),"/");
		var TimeMs=new Date(Todate).getTime();
		return TimeMs;
	}
	
	//日期控件 
	$('#checkstartdate').datetimepicker({
		format: "hh:ii",
		startView: 0,
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true
	});	
	
	//日期控件
	$('#checkenddate').datetimepicker({
		format: "hh:ii",
		startView: 0,
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true
	});	
	
	//初始化页面数据
	function  PageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/JunctionBox/selectById.htm",
				data:{"id":id},
				success:function(msg){
// 					console.log(msg);
					$("#deviceCode").val(msg.code);
					$("#deviceName").val(msg.name);
					$("#deviceid").val(msg.id);
					$("#pstationids").val(msg.pstationid);
				}
			});
		}
	}
	
	//初始化预警阀值数据
	function initThresholdData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $.ajax({
				type:"post",
				url:"${ctx}/Threshold/selectByDeviceId.htm",
				data:{"deviceid":id},
				success:function(result){
					$("#thresholdId").val(result.id);
					if(result.checkstartdate){
						$("#checkstartdate").val(result.checkstartdate);	
					}
					if(result.checkstartdate){
						$("#checkenddate").val(result.checkenddate);
					}
					$("#averagev").val(result.averagev);
					$("#deviationrange").val(result.deviationrange);
					$("#maskcode").val(result.maskcode);
				}
			});
		}
	}
	
	function dateFormat(date){
	    var time = new Date(date).Format("yyyy-MM-dd HH:mm:ss"); 
	    return time;
	}
	
	
</script>
<div class="modal fade" id="junctionBoxThreshold" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog modal-lg">
<div class="modal-content ">
<div class="modal-body wrapper-lg">


<div ng-controller="JunctionBoxThreshold">
	<div class="wrapper-md">
		<span class="font-h4 blue-1 m-n text-black">汇流箱预警阀值</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="panel panel-default">
		<div class="row wrapper">
		<!-- form 开始 -->
		<form class="m-t-lg col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/Threshold/update.htm" method="post" id="formSt" name="formSt">
          <input type="hidden" name="id" id="thresholdId" class="formData"/>
          <input type="hidden" name="deviceid" id="deviceid" class="formData"/>
          <input type="hidden" id="pstationids" name="pstationid" class="form-control formData">
           
           <div class="form-group">
              <label class="col-lg-2 control-label">设备编号</label>
              <div class="col-lg-3">
                <input type="text" id="deviceCode" readonly="readonly" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">设备名称</label>
              <div class="col-lg-3">
                <input type="text" id="deviceName" readonly="readonly" name="devicename" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
              </div>
            </div>
            
       
           <div class="form-group">
              <label class="col-lg-2 control-label">开始时间</label>
              <div class="col-lg-3">
                <input type="text" id="checkstartdate" name="checkstartdate" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">结束时间</label>
              <div class="col-lg-3">
                <input type="text" id="checkenddate" name="checkenddate" class="form-control formData">
              </div>
           </div>   
              <div class="form-group">
              <label class="col-lg-2 control-label">平均值(A)</label>
              <div class="col-lg-3">
                <input type="text" id="averagev"  maxlength="11" name="averagev" class="form-control  formData">
              </div>
              <label class="col-lg-2 control-label">偏差幅度</label>
              <div class="col-lg-3">
                <input type="text" id="deviationrange" maxlength="11" name="deviationrange" class="form-control formData">
              </div>
             </div>
      		
      		  <div class="form-group">
              <label class="col-lg-2 control-label">电路屏蔽掩码</label>
              <div class="col-lg-3">
                <input type="text" id="maskcode" maxlength="20" name="maskcode" class="form-control  formData">
              </div>
             </div>
      		
             <div class="form-group">
             </div>
             <div class="form-group m-t-lg">
            <div class="col-lg-8">   
                <button type="button" id="close" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取 消</strong></button>
                <%--<button id="cancelBtn" type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="backJunctionBox();"><strong>取消</strong></button>--%>
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
</div>
</div>
</div>
