<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/select.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$('#productiondate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		   	autoclose: true
		});
		$('#closedate').datetimepicker({
		    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
		    autoclose: true
		});
		
	// 	预警阀值
/* 	$('#checkstarttime').datetimepicker({
		format: "hh:ii",
		startView: 0,
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true
	});	
	
	
	$('#checkendtime').datetimepicker({
		format: "hh:ii",
		startView: 0,
		language: 'zh-CN',
		todayHighlight:true,
		todayBtn:true,
	   	autoclose: true
	});	 */
	
	$('#expirydate').datetimepicker({
	    format: 'yyyy-mm-dd',minView: 2,language: 'zh-CN',
	   	autoclose: true
	});
	
	//时间验证 格式:xx:xx
	jQuery.validator.addMethod("dateVerify", function(value, element) {
		var  pattern = /^([01]\d|2[01234]):([0-5]\d|60)$/;
		return this.optional(element) || ((pattern.test(value)) && (value.substring(0,2)<24));
	 },"请输入正确时间格式 如: 09:00");
	
	
		$("#editForm").validate( {
			rules : {
				stationcode:{ 
					number: true,
					required : true,
					maxlength : 11
				},
				stationname:{ 
					required : true,
					maxlength : 20
				},
				parentid:{ 
					maxlength : 11
				},
				companyid:{ 
					required : true,
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
					number: true,
					maxlength : 10
				},
				latitude:{
					number: true,
					maxlength : 10
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
				stationzip:{
					zipcode: true,
					maxlength : 6
				},
				descp:{
					maxlength : 300
				},
				totaltw:{
					number: true,
					maxlength : 14	
				},
				yeartw:{
					number: true,
					maxlength : 14	
				},
				monthtw:{
					number: true,
					maxlength : 14	
				},
				checkstarttime: {
					required: true,
					dateVerify:true
				},
				checkendtime:{
					required: true,
					dateVerify:true
				},
				stimeoutvalue:{
					required: true,
					maxlength : 9	
				},
				dtimeoutvalue:{
					required: true,
					maxlength : 9
				}
				
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if (json.message == "Nunique"){
							$("#showhint").removeClass('hidden');
						}else if(json.message == "Usuccess"){
							promptObj('success', '',"更新成功");
							$("#cancelBtn").trigger("click");
						}else{
							promptObj('success', '',"保存成功");
							$("#cancelBtn").trigger("click");
						} 
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					},
					error : function(json) {
						promptObj('error', '',"保存失败,请稍后重试");
						if(""!=$('#url').val()){
							window.location.href=$('#url').val();
						}else{
							$("#cancelBtn").trigger("click");
						}
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
			
		});
		app.controller('PowerStationAddCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
			$scope.backPowerStation11 = function(){
				$state.go('app.powerStation');
			}
			if($rootScope.last_unfinish_bpowerstation_id!="" && $rootScope.last_unfinish_bpowerstation_id!=null){
				$('#last_unfinish_bpowerstation_id').val($rootScope.last_unfinish_bpowerstation_id);
				initPageData($rootScope.last_unfinish_bpowerstation_id);
			}else if($('#last_unfinish_bpowerstation_id').val()!="" && $('#last_unfinish_bpowerstation_id').val()!=null){
				initPageData($('#last_unfinish_bpowerstation_id').val());
			}else{
				initPageData($stateParams.psId);
			}
		}]);
		
	
	});
	
	
	function getProbablyNull(n){
		if(null == n){return null;}
		return n;
	}
	
	function saveForm(url,isfinish){
		if(url != null && url !=""){
			$('#url').val(url);
		}else{
			$('#url').val("");
		}
		
		if(isfinish != null && isfinish !=""){
			$('#finishflag').val(isfinish);
		}else{
			$('#finishflag').val("");
		}
		
		
		if($("#picture2").val()==""){
			$("#picture2").attr("disabled","disabled");
		}
		if($("#picture1").val()==""){
			$("#picture1").attr("disabled","disabled");
		}
		if($("#picture0").val()==""){
			$("#picture0").attr("disabled","disabled");
		}
		
/**************************************** 电量初始值验证********************************************/

		//判断截止日期是否为空，为空则初始值全部为空，不为空则初始值至少一个有值
		var expiryValue=$("#expirydate").val();
		var totaltwValue=$("#totaltw").val();
		var yeartwValue=$("#yeartw").val();  
		var monthtwValue=$("#monthtw").val();  
		if(expiryValue){
			if(totaltwValue || yeartwValue || monthtwValue){
				$("#editForm").trigger("submit"); 
			}else {
				$("#total").html("累计发电量 、或年发电量 、 或月发电量 ,不为空");
				$("#totalimg").attr("src","images/validator/check_n.gif");
				$("#totaltw").css("border-color","#FF0000");
				$("#yeartw").css("border-color","#FF0000");
				$("#monthtw").css("border-color","#FF0000");
			}
		}else{
			if(totaltwValue=="" && yeartwValue=="" && monthtwValue==""){
				$("#editForm").trigger("submit"); 
			}else if(totaltwValue !=""){
				expiryVerify();
			}else if(yeartwValue !=""){
				expiryVerify();
			}else if( monthtwValue !=""){
				expiryVerify();
			}
		}
	}
	
	function expiryVerify(){
		$("#expiryverify").html("截止日期不可为空");
		$("#expiryverifyimg").attr("src","images/validator/check_n.gif");
		$("#expirydate").css("border-color","#FF0000");
	}
	
	function cllarverify(){
		var expiryValue=$("#expirydate").val();
		var totaltwValue=$("#totaltw").val();
		var yeartwValue=$("#yeartw").val();  
		var monthtwValue=$("#monthtw").val(); 
		$("#expirydate").css("border-color","#cfdadd");
		$("#totaltw").css("border-color","#cfdadd");
		$("#yeartw").css("border-color","#cfdadd");
		$("#monthtw").css("border-color","#cfdadd");
		$("#totalimg").removeAttr("src");
		$("#expiryverifyimg").removeAttr("src");
		if(!expiryValue){
		$("#expiryverify").html("")
		}else if(totaltwValue || yeartwValue || monthtwValue){
		$("#expiryverify").html("")	
		}
		
		if(!totaltwValue){
		$("#total").html("");	
		}else if(expiryValue){
		$("#total").html("");		
		}
		
		if(!yeartwValue){
		$("#yeartw").html("");
		}else if(expiryValue){
		$("#yeartw").html("");	
		}
		
		if(!monthtwValue){
		$("#month").html("")	
		}else if(expiryValue){
		$("#month").html("")		
		}
	}
	
	function getDateToMs(date){
		var TimeMs=new Date(date).getTime();
		return TimeMs;
	}
	
	//初始化页面数据
	function initPageData(id){
		$(".formData").val("");
		if(id != "" && id != null){
			 $("#id").val(id);
			 $.ajax({
				type:"post",
				url:"${ctx}/PowerStation/selectStationById.htm",
				data:{"id":id},
				success:function(result){
				var	msg=result.bpowerstation;
				var expirytw=result.expirytw
				var timeoutcgf=result.timeoutcgf
					$("#stationcode").val(msg.stationcode);
					$("#stationname").val(msg.stationname);
					$("#parentid").val(msg.parentid);
					$("#companyid").val(msg.companyid);
					$("#managerid").val(msg.managerid);
					$("#provinceid").val(msg.provinceid);
					$("#cityid").val(msg.cityid);
					$("#countyid").val(msg.countyid);
					getData();
					$("#address").val(msg.address);
					$("#buildcapacity").val(msg.buildcapacity);
					$("#longitude").val(msg.longitude);
					$("#latitude").val(msg.latitude);
					$("#statusrating").val(msg.statusrating);
					$("#valuesrating").val(msg.valuesrating);
					$("#stationtel").val(msg.stationtel);
					$("#stationzip").val(msg.stationzip);
					$("#descp").val(msg.descp);
					$("#checkstarttime").val(timeoutcgf.checkstarttime);
					$("#checkendtime").val(timeoutcgf.checkendtime);
					$("#stimeoutvalue").val(timeoutcgf.stimeoutvalue);
					$("#dtimeoutvalue").val(timeoutcgf.dtimeoutvalue);
					if(expirytw!=null){
						$("#expirydate").val(new Date(expirytw.expirydate).Format("yyyy-MM-dd"));
//	 					var expirydate=expirytw.expirydate
						$("#totaltw").val(expirytw.totaltw);
						$("#yeartw").val(expirytw.yeartw);
						$("#monthtw").val(expirytw.monthtw);
						//隐藏域id赋值
						$("#expirytwid").val(expirytw.id);
					}
					if(timeoutcgf){
						$("#timeoutcgfid").val(timeoutcgf.id);
					}
					if(msg.productiondate != null && msg.productiondate != ""  ){
						 var date = new Date(msg.productiondate);						
						 var   year=date.getFullYear();     
			             var   month=date.getMonth()+1;     
			             var   date=date.getDate();     
			             productiondateStr=   year+"-"+month+"-"+date;     
						$("#productiondate").val(productiondateStr);
					}

					if(msg.closedate != null && msg.closedate != ""  ){
						 var date = new Date(msg.closedate);						
						 var   year=date.getFullYear();     
			             var   month=date.getMonth()+1;     
			             var   date=date.getDate();     
			             closedateStr=   year+"-"+month+"-"+date;     
						$("#closedate").val(closedateStr);
					}
					$("#status").val(msg.status);
					if(msg.scenepictures != null && msg.scenepictures !=""){
						var array = msg.scenepictures.split(",");
						for (var i=0;i<array.length;i++){
							$("#oldFile"+i).val(array[i]);
							$("#billImg"+i).attr("src","${imgPath}/document/powerStationPicture/"+array[i]);
						}
					}
					getRpdsStationCount(id);
				}
			});
		}else{
			setTimeout('getData()',50);
		}
	}
	
	
	function getRpdsStationCount(id){
		if(id != "" && id != null){
			 $.ajax({
				type:"post",
				url:"${ctx}/Rpds/selectByStationIdCount.htm",
				data:{"stationId":id},
				success:function(result){
				if(result !=0){
					$(".powerInitVal").attr("disabled","disabled");
				}else{
					$(".powerInitVal").removeAttr("disabled");
				}
				}
			});
		}
	}
	
	var getData;
	app.controller('StationCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
		$scope.backPowerStation = function(){
			$state.go('app.powerStation');
		}
		getData=$scope.getData=function(){
//电站下拉框查询	-------------------------------Start------------------------------------------------------
		$scope.stationd = {};
   		$scope.station = null;
   		$scope.getStation = function(){
		$http({method:"POST",url:"${ctx}/PowerStation/selectAll.htm",params:{id:$("#id").val()}})
		.success(function (result) {
			$scope.station = result;
			$scope.station.unshift({id:"",stationname:'请选择'});
			if($("#parentid").val()!=null&&$("#parentid").val()!=""){
				for(var i=0,len=$scope.station.length;i<len;i++){
					if($scope.station[i].id==  $("#parentid").val()){
						$scope.stationd.selected= { stationname: $scope.station[i].stationname,id:  $("#parentid").val()};
					}
				}
			} else {
					$scope.stationd.selected= { stationname: $scope.station[0].stationname,id:  $scope.station[0].id};
			}
	    	 $scope.textChange= function () {
		         $("#parentid").val( angular.copy($scope.stationd.selected.id));
			} 
		}); 
   	}
   		
 //所属企业下拉框查询-------------------------------------Start------------------------------------------ 		
		$scope.companyd = {};
   		$scope.company = null;
		$http({method:"POST",url:"${ctx}/Company/selectAll.htm",params:{}})
		.success(function (result) {
	    	 $scope.company = result;
	    	 for(var i=0,len=$scope.company.length;i<len;i++){
					if($scope.company[i].comId==  $("#companyid").val()){
						$scope.companyd.selected= { comName: $scope.company[i].comName,comId:  $("#companyid").val()};
						$scope.getStation();
					}
				}
	    	 
	    	 $scope.companyChange= function () {
		         $("#companyid").val(angular.copy($scope.companyd.selected.comId));
		         $scope.getStation();
			} 
		}); 

//负责人下拉框查询-------------------------------------Start------------------------------------------ 			
		$scope.managerd = {};
     	$scope.manager = null;
		$http({method:"POST",url:"${ctx}/AdminUser/selectAll.htm",params:{}})
		.success(function (result) {
	    	 $scope.manager = result;
	    	 if( $scope.manager.length>0){
	    		 $scope.manager.unshift({userId:"",realName:'请选择'});
	    	 }
	    	 for(var i=0,len=$scope.manager.length;i<len;i++){
					if($scope.manager[i].userId==  $("#managerid").val()){
						$scope.managerd.selected= { realName: $scope.manager[i].realName,userId:  $("#managerid").val()};
					}
				}
	    	 $scope.managerChange= function () {
		         $("#managerid").val(angular.copy($scope.managerd.selected.userId));
			} 
		}); 	
		
//		地址省市县start	===============================================================
		 $scope.provinced = {};
		 $scope.province = null;
	     $scope.cityd = {};
		 $scope.city = null; 
		 $scope.countyd = {};
		 $scope.county = null; 
		 
		 $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":1,"parentId":1}})
			.success(function (result) {
		    	 $scope.province = result;
		    	 if($("#provinceid").val() != null && $("#provinceid").val() != "" ){
			    	 for(var i=0,len=$scope.province.length;i<len;i++){
						if($scope.province[i].id==  $("#provinceid").val()){
							$scope.provinced.selected= { regionName: $scope.province[i].regionName,id:  $("#provinceid").val()};
						}
					}
		    	 }
		    	 
		    	 $scope.provinceChange= function () {
		    		provinceMapName=$scope.provinced.selected.regionName;
		    		 var a = angular.copy($scope.provinced.selected.id); 
		    		 $("#provinceid").val(a);
		    		 $scope.cityd.selected = {regionName : null,id : null};
		    		 $scope.countyd.selected = {regionName :null,id : null};
			         $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":2,"parentId":a}})
			         .success(function (resultcity) {
			        	 $scope.city = resultcity;
			        	 for(var i=0,len=$scope.city.length;i<len;i++){
			 					if($scope.city[i].id==  $("#cityid").val()){
			 						$scope.cityd.selected= { regionName: $scope.city[i].regionName,id:  $("#cityid").val()};
			 					}
			 				}
			        	 
				        	 $scope.cityChange= function () {
				        		 //输入后调用经纬度
						    	cityMapName=$scope.cityd.selected.regionName;
						        var b = angular.copy($scope.cityd.selected.id); 
						        $("#cityid").val(b);
						        $scope.countyd.selected= { regionName: null,id:  null};
						        
						        $http({method:"POST",url:"${ctx}/BaseRegion/selectByTreeLevel.htm",params:{"treeLevel":3,"parentId":((b==null) || (b==""))?0:b}})
						        .success(function (resultcounty) {
						        	
						        	$scope.county = resultcounty;
							        	for(var i=0,len=$scope.county.length;i<len;i++){
		 				 					if($scope.county[i].id==  $("#countyid").val()){
		 				 						$scope.countyd.selected= { regionName: $scope.county[i].regionName,id:  $("#countyid").val()};
		 				 						countyMapName=$scope.countyd.selected.regionName
		 				 					}
		 				 				}
							         $scope.countyChange= function () {
							        	 countyMapName=$scope.countyd.selected.regionName
						        		 $("#countyid").val($scope.countyd.selected.id);
						        	 }
						        });
					       }
			        	 if($("#countyid").val() != null && $("#countyid").val() != "" ){
				    		 $scope.cityChange();
				    	 }
			         }); 
				} 
		    	 if($("#cityid").val() != null && $("#cityid").val() != "" ){
		    		 $scope.provinceChange();
		    	 }
			}); 
//地址省市县 end ================================================
}
	}]);
	
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
<script type="text/javascript">
//根据地址获取经纬度
	var provinceMapName;
	var cityMapName;
	var countyMapName;
    var map = new BMap.Map("");
    var localSearch = new BMap.LocalSearch(map);
    localSearch.enableAutoViewport(); //允许自动调节窗体大小
	function searchByStationName() {
    	var keyword=provinceMapName+cityMapName+countyMapName
    localSearch.setSearchCompleteCallback(function (searchResult) {
        var poi = searchResult.getPoi(0);
        $("#longitude").val(poi.point.lng);
        $("#latitude").val(poi.point.lat);
    });
    localSearch.search(keyword);
} 

    function checkTude(obj){//经度纬度,如果详细地址为空，获取上面的地址
    	if($("#"+obj).is(':checked')){
    		 if($("#address").value==""||typeof($("#address").value)=="undefind"){
    			 var tudes=provinceMapName+cityMapName+countyMapName;
    			 if(tudes==""||typeof(tudes=="undefind")){
        			return false;
        		}else{
        		 searchByStationName(tudes)
        		} 
        	}else{
        		searchByStationName($("#address").val())
        	}
    	}else{
    		$("#longitude").val("");
    		$("#latitude").val("");
    	}
    }
</script>
<div ng-controller="PowerStationAddCtrl">
<div ng-controller="StationCtrl">

	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n">电站信息管理</span>  
	</div>
	<div class="wrapper-md ng-scope">
	<div class="panel panel-default">
		<div class="row wrapper">
		<!-- form 开始 -->
		<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PowerStation/update.htm" method="post" id="editForm" name="editForm" enctype="multipart/form-data">
           <input type="hidden" name="id" value="{{$stateParams.psId}}" id="id" class="formData"/>
           <input type="hidden" id="url"/>
           <input type="hidden" id="finishflag" name="finishflag"/>
           <input type="hidden" name="expirytwid" id="expirytwid"/>
           <input type="hidden" name="timeoutcgfid"  id="timeoutcgfid"/>
             <div class="form-group">
              
               <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>电站编号</label>
              <div class="col-lg-3">
                <input type="text" id="stationcode" maxlength="11" name="stationcode" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"  class="form-control formData">
              </div>
               <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>电站名称</label>
              <div class="col-lg-3">
                <input type="text" id="stationname" maxlength="20" name="stationname" class="form-control formData">
              </div>
             </div>
<!--             <div class="form-group"> -->
<!--              <label class="col-lg-2 control-label">电站名称</label> -->
<!--               <div class="col-lg-8"> -->
<!--                 <input type="text" id="stationname" maxlength="30" name="stationname" class="form-control formData"> -->
<!--               </div> -->
<!--             </div> -->
           <div class="form-group">
              
            		 <label class="col-lg-2 control-label">所属企业</label>
	               <div class="col-sm-3" >
		          	<ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
		            <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
		            <ui-select-choices  repeat="item in company | filter: $select.search">
		              <div ng-bind-html="item.comName | highlight: $select.search"></div>
		            </ui-select-choices>
			          </ui-select>
			         <input type="hidden" id="companyid" name="companyid" class="form-control formData">
					</div>
					
<!-- 					 <label class="col-lg-2 control-label">所属电站</label> -->
<!-- 	          <div class="col-sm-3" > -->
<!-- 	          	<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()"> -->
<!-- 	            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname" >{{$select.selected.stationname}}</ui-select-match> -->
<!-- 	            <ui-select-choices  repeat="item in station | filter: $select.search"> -->
<!-- 	              <div ng-bind-html="item.stationname | highlight: $select.search"></div> -->
<!-- 	            </ui-select-choices> -->
<!-- 	         	 </ui-select> -->
<!-- 	           <input type="hidden" id="parentid" name="parentid" class="form-control formData"> -->
<!-- 				</div> -->
	          </div>
            <div class="form-group">
               <label class="col-lg-2 control-label">负责人</label>
              <div class="col-lg-3">
                 <input type="hidden" id="managerid" name="managerid" class="form-control formData">
	           	<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	              <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
             </div>
               <label class="col-lg-2 control-label">联系电话</label>
              <div class="col-lg-3">
                 <input type="text" id="stationtel" maxlength="18" name="stationtel" placeholder="区号-电话-分机   或  手机号" class="form-control formData">
             </div>
            </div>
            <div class="form-group">
              <label class="col-lg-2 control-label">总装机量</label>
              <div class="col-lg-2">
                <input type="text" id="buildcapacity" name="buildcapacity" maxlength="10" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
              </div>
              <label class="col-lg-1 control-label">kW</label>
              <label class="col-lg-2 control-label">邮编</label>
              <div class="col-lg-3">
                <input type="text" id="stationzip" name="stationzip" maxlength="6" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
              </div>
             </div>
             <div class="form-group">
              <label class="col-lg-2 control-label">地址</label>
              <div class="col-lg-2">
              <input type="hidden" name ="provinceid" id="provinceid"  class="form-control formData"/>
		            <ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
		            <ui-select-match placeholder="请输入..." ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in province | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
              </div>
              <div class="col-lg-3">
               <ui-select ng-model="cityd.selected" theme="bootstrap" ng-change="cityChange()">
		            <ui-select-match placeholder="请输入..." ng-model="cityd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in city | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
		          	<input type="hidden" name ="cityid" id="cityid"  class="form-control formData"/>
              </div>
               <div class="col-lg-3">
               <ui-select ng-model="countyd.selected" theme="bootstrap" ng-change="countyChange()">
		            <ui-select-match placeholder="请输入..." ng-model="countyd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
		            <ui-select-choices  repeat="item in county | filter: $select.search">
		              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
		            </ui-select-choices>
		          	</ui-select> 
		          	<input type="hidden" name ="countyid" id="countyid"  class="form-control formData"/>
              </div>
             </div>
             
             <div class="form-group">
              <label class="col-lg-2 control-label">详细地址</label>
                <div class="col-lg-8">
             	 <input type="text" id="address" name="address" maxlength="50" class="form-control formData">
             	</div>
             </div>
            <div class="form-group">
              <label class="col-lg-2 control-label">经度</label>
              <div class="col-lg-2">
                <input type="text" id="longitude" maxlength="10" name="longitude" class="form-control formData">
              </div>
              <label class="col-lg-2 control-label">纬度</label>
              <div class="col-lg-2">
                <input type="text" id="latitude" maxlength="10" name="latitude" class="form-control formData">
              </div>
              <div class="col-lg-2 m-t-sm">
               <label class="i-checks m-b-none"> 
				 <input type="checkbox" name="tude" id="tude"onclick="checkTude('tude')"/> <i></i>
			  </label>
			   <span>自动获取 </span>
              </div>
            </div>
            
           <div class="form-group">
              <label class="col-lg-2 control-label">投产时间</label>
              <div  class="col-lg-3">
              <input    type="text" id ="productiondate" name ="productiondate"   class="form-control formData"/>
              </div>
              <label class="col-lg-2 control-label">停产时间</label>
               <div  class="col-lg-3">
             	 <input    type="text" id ="closedate" name ="closedate"   class="form-control formData"/>
              </div>
            </div>
            
              <div class="form-group">
                <label  class="col-lg-2 control-label">实景图片</label>
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
                <label  class="col-lg-2 control-label">其他介绍</label>
                 <div  class="col-lg-8">
               		 <textarea rows="2" maxlength="300" name ="descp" id ="descp" class="form-control formData"></textarea>
                </div>
             </div>
<!--通讯中断 Start-->
         <div class="form-group">
              <label class="col-lg-2 control-label">汇流箱通讯中断时间</label>
              <div  class="col-lg-1">
              <input    type="text" id ="checkstarttime" name ="checkstarttime" placeholder="请输入时分  如: 09:00" value="08:00"   class="form-control"/>
              </div>
               <span class="col-lg-1 control-label text-center" style="background-color:#edf1f2; padding:6px; 12px; border:1px solid #ccc">至</span>
               <div  class="col-lg-1">
             	 <input   type="text" id ="checkendtime" name ="checkendtime" placeholder="请输入时分  如: 09:10" value="17:00" class="form-control"/>
              </div>
         </div>
               <div class="form-group">
              <label class="col-lg-2 control-label">电站超时(s)</label>
               <div  class="col-lg-3">
             	 <input    type="text" id ="stimeoutvalue" maxlength="9" name ="stimeoutvalue" value="300" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control"/>
              </div>
               <label class="col-lg-2 control-label">设备超时(s)</label>
               <div  class="col-lg-3">
             	 <input   type="text" id ="dtimeoutvalue" maxlength="9" name ="dtimeoutvalue" value="300" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control"/>
              </div>
            </div>
<!--  通讯中断结束end -->

<!-- 电量初始值 Start-->
		<div class="form-group">
              <label class="col-lg-2 control-label">截止日期</label>
              <div  class="col-lg-3">
              <input    type="text" id ="expirydate"  name ="expirydate" onMouseOut="cllarverify()" class="form-control formData powerInitVal"/>
              		<img id="expiryverifyimg">
              		<span id="expiryverify"></span>
              </div>
              <label class="col-lg-2 control-label">累计发电量(kWh)</label>
               <div  class="col-lg-3">
             	 <input    type="text" id ="totaltw"  name ="totaltw" onMouseOut="cllarverify()" maxlength="14" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control formData powerInitVal"/>
              		<img id="totalimg">
              		<span id="total"></span>
              </div>
            </div>
			<div class="form-group">
			 <label class="col-lg-2 control-label">年发电量(kWh)</label>
               <div  class="col-lg-3">
             	 <input    type="text" id ="yeartw" name ="yeartw" onMouseOut="cllarverify()" maxlength="14" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"  class="form-control formData powerInitVal"/>
              	    <span id="year"></span>
              </div>
              <label class="col-lg-2 control-label">月发电量(kWh)</label>
               <div  class="col-lg-3">
             	 <input    type="text" id ="monthtw" name ="monthtw" onMouseOut="cllarverify()" maxlength="14" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control formData powerInitVal"/>
              		<span id="month"></span>
              </div>
		</div>

<!-- 电量初始值end -->
            <div class="form-group m-t-sm">
          <div id="showhint"  class="hidden text-center m-b-sm"><font color="#FF0000">数据已存在,请勿重复插入!!!</font></div>
            <div class="col-lg-12 text-center">   
                <button type="button" onclick="saveForm();" id="saveButton" class=" btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
<!--                 <button type="button" id="cancelBtn" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取 消</strong></button> -->
                <button id="cancelBtn" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" ng-click="backPowerStation11();"><strong>取消</strong></button>
   			 </div>
   			 </div>
          </form>
		<!-- form 结束 -->
     </div>
     </div>
   </div>
 </div>
</div>
