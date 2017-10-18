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
	});
	
	app.controller('StationCtrl', ['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams', function($http, $location, $rootScope, $scope, $state, $stateParams){
		$scope.backPowerStation = function(){
			$state.go('app.powerStation');
		}
		$scope.getData=function(){
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
		 $scope.getData();
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
<div ng-controller="StationCtrl">
	<div class="ng-scope">
		<div class="wrapper">
		<!-- form 开始 -->
		<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PowerStation/update.htm" method="post" id="editForm" name="editForm" enctype="multipart/form-data">
           <input type="hidden" name="id" value="{{$stateParams.psId}}" id="id" class="formData"/>
           <input type="hidden" id="url"/>
           <input type="hidden" id="finishflag" name="finishflag"/>
           <input type="hidden" name="expirytwid" id="expirytwid"/>
           <input type="hidden" name="timeoutcgfid"  id="timeoutcgfid"/>
             <div class="form-group col-sm-12">
           		<label class="col-lg-1 m-t-xs no-padder control-label">电站编号</label>
				<div class="col-lg-2">
            	   <input  type="text" id="stationcode" maxlength="11" name="stationcode" placeholder="请输入数字类型"   class="form-control formData">
				</div>

           		 <label class="col-lg-1 m-t-xs no-padder control-label">电站名称</label>
           		 <div class="col-lg-4">
                	<input type="text" id="stationname" maxlength="20" name="stationname" class="form-control formData">
				</div>

              <label class="col-lg-1 m-t-xs no-padder   control-label">所属企业</label>
              <div class="col-sm-3" >
	          	  <ui-select  ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
	              <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
	              <ui-select-choices  repeat="item in company | filter: $select.search">
	              <div ng-bind-html="item.comName | highlight: $select.search"></div>
	              </ui-select-choices>
		          </ui-select>
		         <input type="hidden" id="companyid" name="companyid" class="form-control formData">
			</div>  
             	</div>
       
           <div class="form-group col-sm-12">
       		  <label class="col-lg-1 control-label">负责人</label>
              <div class="col-lg-2">
                 <input type="hidden" id="managerid" name="managerid" class="form-control formData">
	           	<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	              <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
             </div>
             	
       		 <label class="col-lg-1 no-padder m-t-xs control-label">总装机量</label>	
         		<div class="col-lg-3">
           			<input type="text"  id="buildcapacity" name="buildcapacity" maxlength="10" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
         		</div>
         	 		<span class="col-lg-1 m-t-xs">kW</span>
             	
             <label class="col-lg-1 no-padder m-t-xs control-label">投产时间</label>	
		         <div  class="col-lg-2">
		             <input type="text" id ="productiondate" name ="productiondate"   class="form-control formData"/>
		         </div>
            </div>
<!--            <hr class="col-sm-11 text-center" style="border-top:1px dashed #F00;"> -->
			
            <div class="form-group col-sm-12">
                <label class="col-lg-1 no-padder m-t-xs control-label">联系电话</label>
		           <div class="col-lg-2">
		             <input type="text" id="stationtel" maxlength="18" name="stationtel" placeholder="区号-电话-分机   或  手机号" class="form-control formData">
		           </div>
             	
             	<label class="col-lg-1 no-padder m-t-xs control-label">邮编</label>
              		<div class="col-lg-2">
                	  <input type="text" id="stationzip" name="stationzip" maxlength="6" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
               		</div>
             </div>
             
             <div class="form-group  col-sm-12">
		         <label class="col-lg-1 control-label">地址</label>
	              <div class="col-lg-2">
		              <input type="hidden" name ="provinceid" id="provinceid"  class="form-control formData"/>
				            <ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
				            <ui-select-match placeholder="请输入..." ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
				            <ui-select-choices  repeat="item in province | filter: $select.search">
				              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
				            </ui-select-choices>
				          	</ui-select> 
		          </div>
		              <div class="col-lg-2 ">
		               <ui-select ng-model="cityd.selected" theme="bootstrap" ng-change="cityChange()">
				            <ui-select-match placeholder="请输入..." ng-model="cityd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
				            <ui-select-choices  repeat="item in city | filter: $select.search">
				              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
				            </ui-select-choices>
				          	</ui-select> 
				          	<input type="hidden" name ="cityid" id="cityid"  class="form-control formData"/>
		              </div>
		               <div class="col-lg-2 ">
		               <ui-select ng-model="countyd.selected" theme="bootstrap" ng-change="countyChange()">
				            <ui-select-match placeholder="请输入..." ng-model="countyd.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
				            <ui-select-choices  repeat="item in county | filter: $select.search">
				              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
				            </ui-select-choices>
				          	</ui-select> 
				          	<input type="hidden" name ="countyid" id="countyid"  class="form-control formData"/>
	             	</div>
	             <div class="col-lg-2 no-padder">
	             	<label class="col-lg-3 no-padder m-t-xs control-label">经度</label>
		              <div class="col-lg-8">
		                <input type="text" id="longitude" maxlength="10" name="longitude" class="form-control formData">
		              </div>
	             </div>
	             <div class="col-lg-2 no-padder">
	             	<label class="col-lg-3 no-padder m-t-xs control-label">纬度</label>
		              <div class="col-lg-8">
		                <input type="text" id="latitude" maxlength="10" name="latitude" class="form-control formData">
		              </div>
	             </div>
             </div>
             
             <div class="form-group col-sm-12">
             	<div class="col-lg-1 no-padder"></div>
	                <div class="col-lg-6">
	             		 <input type="text" id="address" name="address" maxlength="50" class="form-control formData">
	             	</div>
	             
             </div>
            
              <div class="form-group col-sm-12">
	                <label class="col-lg-1 no-padder control-label" style="line-height: 50px;">实景图片</label>	
	                <div class="col-lg-5 imgfile">
	                	<div class="fileimgsize">
		          			<img id="billImg0" class="fileImg0 fileimgsize" name = "billImg0" src="theme/images/uploadImg.png">
		          			<input type="file" name="picture0" id ="picture0" class="file form-control formData" 
		          			onchange="getImg(this,'fileImg0')"/>
	          			</div>
	          			<div class="fileimgsize">
		          			<img id="billImg1" class="fileImg1 fileimgsize" name = "billImg1" src="theme/images/uploadImg.png">
		          			<input type="file"  name="picture1" id ="picture1" class="file form-control formData" onchange="getImg(this,'fileImg1')"/>
	          			</div>
	          			<div class="fileimgsize" onclick>
		          			<img id="billImg2" class="fileImg2 fileimgsize"  name = "billImg2" src="theme/images/uploadImg.png">
		          			<input type="file"  name="picture2" id ="picture2" class="file form-control formData" onchange="getImg(this,'fileImg2')"/>
	          			</div>
	               		<input type="hidden" name="oldFile0" id ="oldFile0"  />
	               		<input type="hidden" name="oldFile1" id ="oldFile1"  />
	               		<input type="hidden" name="oldFile2" id ="oldFile2"  />
				 	</div>
			 	
			 		<label  class="col-lg-1 no-padder control-label">其他介绍</label>
                 	<div  class="col-lg-5">
               			 <textarea rows="2" maxlength="300" name ="descp" id ="descp" class="form-control formData"></textarea>
			 		</div> 
             </div>
             
            <div class="form-group">
          <div id="showhint"  class="hidden text-center m-b-sm"><font color="#FF0000">数据已存在,请勿重复插入!!!</font></div>
            	<div class="col-sm-offset-1" style="padding-left:25px;">
                	<button type="button" ng-click="savePowerViewData();" id="saveButton" class=" btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
               		<button id="cancelBtn" ng-click="cancelPowerViewData();" type="button" class=" m-l-sm  btn m-b-xs w-xs btn-default" ><strong>取消</strong></button>
   			 </div>
   			 </div>
          </form>
		<!-- form 结束 -->
     </div>
   </div>
</div>
