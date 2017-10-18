<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
    <script type="text/javascript">      
	
	//初始化页面数据
	function initPageData(id){
		selectCfgCount(id);
		$("#id").val(id);
	}
	
	function deleteRow() {
		$.ajax({
			type : "post",
			url : "${ctx}/PowerStation/delete.htm",
			data : {
				"id" : $("#id").val()
			},
			dataType : "json",
			success : function(json) {
				promptObj(json.type, '', json.message);
				$("#cancelbtn").trigger('click');
				goPage(0);
				
			},
			error : function() {
				promptObj(json.type, '', json.message);
			}
		});
	}
	
	var selectCfgCount
	app.controller('deleteFactory', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams',
	                                function($http,$location,$rootScope,$scope,$state,$stateParams){
		selectCfgCount=$scope.selectCfgCount = function(id) {
			$http({
				method : "POST",
				url : "${ctx}/PowerStation/selectCfgCount.htm",
				params : {
					'id' : id,
				}
			}).success(function(result) {
				$scope.vo=result;
			});
		};
	}]);
</script>
<div ng-controller="deleteFactory" class="modal fade" id="deleteFactory" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog row">
      <div class="modal-content ">
<div class="modal-body wrapper-lg">
<div class="row">
    <div class="col-sm-12">
            <span class="font-h3  m-b ng-binding" id="myModalLabel">电站相关配置信息 </span>
            <input type="hidden" id="id">
      <div class="panel-body">
              <div class="col-sm-12 m-b">
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">厂区用户</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.authuser}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">人</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">授权用户</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.userstationrel}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">人</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">箱变设备</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.bboxchange}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">台</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">逆变器设备</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.binverter}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">台</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">汇流箱设备</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.bjunctionbox}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">台</p>
				</div>
					<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">其它设备</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.botherdevice}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">台</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">派工消息</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.optask}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div>
			<!-- 	<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">软件版本</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.datacollcfg}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">版</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">总线配置</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.pbuscfg}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div> -->
			<!-- 	<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">分钟数据</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.pbuscfg}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div> -->
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">电费结算单</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.opincomesettlement}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">张</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">运维支出单</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.oppaysettlement}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">张</p>
				</div>
				<!-- <div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">生产计划</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.produceplan}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div> -->
				<!-- <div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">日统计数据</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.rpds}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">月统计数据</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.rpms}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">季统计数据</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.rmqs}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div>
				<div class="col-sm-6 no-padder">
					<p class="col-sm-5 no-padder font-h3 black-2">年统计数据</p>
					<p class="col-sm-2 font-h3  no-padder">{{vo.rmys}}</p>
					<p class="col-sm-1 no-padder font-h3 black-2">条</p>
				</div> -->
			</div>
			<div class="font-h3 m-b font-bold ng-binding">
			删除厂区，相关配置信息将一起被删除,请谨慎操作 ! ! !   
			</div>
             <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">   
                <button type="button"  id="cancelbtn"  class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                <button type="button" onclick="deleteRow();" id="deleteRow" class=" pull-right btn m-b-xs w-xs   btn-info" ><strong>确定</strong></button>
   			 </div>
        </div>
        	</div>
</div>
</div>
</div>
</div>
</div>
</div>


