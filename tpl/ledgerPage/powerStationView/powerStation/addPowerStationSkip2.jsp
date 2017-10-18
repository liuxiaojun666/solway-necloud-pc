<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
	.fileimgsize {
		border: 0px;
		float: left;
		height: 66px;
		margin-right: 10px;
		width: 66px;
	}

	.modal-header {
		background-color: #f7f7f7;
		border-radius: 3px 6px 0px 0px;
		padding: 11px;
		border: 0px;
	}
	.red_xing{
		font-size: xx-small;
		width: 12px;
		color: red;
	}
	.line_eight{
		height: 34px;
		line-height: 34px;
		margin-bottom:0px!important;
	}
	.w-xs-s {
		width: 60px;
	}
</style>

<div  ng-controller="StationCtrl">
<!-------------------------------------------------------------- 电站基本信息显示代码区 ---------------------------------------------------->
	<div class="ng-scope" id="showPowerData"  class="col-sm-12">
		<!-- form 开始 -->
             	<div class="form-group line_eight">
					<div class="col-lg-5 " >
					  <label class="col-lg-3  control-label" >电站编号</label>
							<div id="stationcodeDt" class="col-lg-3 no-padder black-4"  ng-bind="vo.stationcode" ></div>
					  <label class="col-lg-3 control-label">电站简称</label>
							<div id="stationnameDt" class="col-lg-3 no-padder black-4" ng-bind="vo.stationname"></div>
					</div>

					<div class="col-lg-5 " >
					  <!--  <label class="col-lg-3 control-label">所属企业</label>
					   		<div id="companynameDt" class="col-lg-3 no-padder black-4"  ng-bind="vo.companyname"></div> -->
					  <label class="col-lg-3 control-label">所属部门</label>
					   		<div id="companynameDt" class="col-lg-3 no-padder black-4"  ng-bind="vo.depname"></div>
					   <label class="col-lg-3 control-label" style="letter-spacing:2px;">负&nbsp;责&nbsp;人</label>
						    <div id="managernameDt" class="col-lg-3 no-padder black-4" ng-bind="vo.managername"></div>
					</div> 
					<div class="col-lg-2 ">
						<a onclick="powerEdit()">
							<span class="icon-pencil font_color m-t-xs"></span>
			              	<span  class="font_color m-t-xs">编辑</span>
	              	   </a>
					</div>
			  </div>

		 	<div class="form-group line_eight" >
				<div class="col-lg-5 " >
					<label class="col-lg-3 control-label">总装机量</label>
						<div id="buildcapacityDt" class="col-lg-2 no-padder black-4" ng-bind="vo.buildcapacity">
						</div>
					    <span class="col-lg-1 no-padder">kW</span>
					<label class="col-lg-3 control-label">投产时间</label>
						<div id="productiondateDt" class="col-lg-3 no-padder black-4" ng-bind="vo.productiondate | date:'yyyy-MM-dd'"></div>
				</div>

				<div class="col-lg-5 ">
					<label class="col-lg-3 control-label">停产时间</label>
						<div id="closedateDt" class="col-lg-3 no-padder black-4" ng-bind="vo.closedate | date:'yyyy-MM-dd'"></div>
				   	<label class="col-lg-3 control-label">联系电话</label>
						<div id="stationtelDt" class="col-lg-3 no-padder black-4" ng-bind="vo.stationtel"></div>
				</div>
		   </div>

		   <div class="form-group line_eight" >
				<div class="col-lg-5">
				  	<label class="col-lg-3 control-label" style="letter-spacing: 7px;">邮&nbsp;&nbsp;编</label>
						<div id="stationzipDt"  class="col-lg-3 no-padder black-4" ng-bind="vo.stationzip"></div>
					<label class="col-lg-3 control-label" style="letter-spacing:2px;">经&nbsp;纬&nbsp;度</label>
						<div id="longitudeLatitudeDt" class="col-lg-3 no-padder black-4" ng-bind="vo.longitude+','+vo.latitude"></div>
				</div>

				<div class="col-lg-5" >
					<label class="col-lg-3 control-label" style="letter-spacing: 7px;">地&nbsp;&nbsp;址</label>
						<div id="addressDt" class="col-lg-9 no-padder black-4" ng-bind="vo.addressall"></div>
				</div>
		   </div>

           <div class="form-group line_eight">
           	   <div class="col-lg-5">
           	   		<label class="col-lg-3 control-label" style="line-height: 70px;">实景图片</label>
		             <div id="picture" class="col-lg-9 imgfile no-padder">
		             	<div class="fileimgsize" id="imgdiv0">
		        			<img id="billImgDt0" class="fileImg0 fileimgsize" name = "billImg0"  >
		       			</div>
		       			<div class="fileimgsize" id="imgdiv1">
		        			<img id="billImgDt1" class="fileImg1 fileimgsize" name = "billImg1" >
		       			</div>
		       			<div class="fileimgsize" id="imgdiv2">
		        			<img id="billImgDt2" class="fileImg2 fileimgsize"  name = "billImg2" >
		       			</div>
		 			</div>
		          </div>
		     <div class="col-lg-5">
		     	<label class="col-lg-3 control-label" style="line-height: 70px;">其它介绍</label>
              		<div id ="descpDt"  class="col-lg-9 no-padder black-4" ng-bind="vo.descp"></div>
          	 </div>
		   </div>
		<div class="form-group line_eight" >
			<div class="col-lg-5">
				<label class="col-lg-3 control-label">电站类型</label>
				<div  class="col-lg-3 no-padder black-4" ng-bind="vo.stationType"></div>
			</div>
		</div>
		<div class="form-group line_eight" >
			<div class="col-lg-5">
				<label class="col-lg-3 control-label">电站全称</label>
				<div  class="col-lg-3 no-padder black-4" ng-bind="vo.stationfullname"></div>
			</div>
		</div>
     </div>

<!-----------------------------------------------------------电站基本信息编辑代码区 -------------------------------------------------------->

<div  id="powerDataeEdit" class="hidden" class="col-sm-12">
	<div class="ng-scope">
		<div class="wrapper">
		<!-- form 开始 -->
		<form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/PowerStation/update.htm" method="post" method="post" id="savePowerData" name="savePowerData" enctype="multipart/form-data">
           <input type="hidden" name="id"  id="stationid" />
             <div class="form-group col-sm-12">
             	<label class="col-lg-1 m-t-sm no-padder   control-label">所属部门</label>
	            <div class="col-sm-4" >
		          	  <ui-select  ng-model="depd.selected" theme="bootstrap" ng-change="depChange()">
		              <ui-select-match placeholder="请输入关键字..." ng-model="depd.selected.name" >{{$select.selected.name}}</ui-select-match>
		              <ui-select-choices  repeat="item in department | filter: $select.search">
		              <div ng-bind-html="item.name | highlight: $select.search" style="margin-left: {{item.level*10}}px;"></div>
		              </ui-select-choices>
			          </ui-select>
			          <input type="hidden" id="depid" name="depid" class="form-control formData">
			         <input type="hidden" id="companyid" name="companyid" class="form-control formData">
				</div>
           		<label class="col-lg-1 m-t-sm no-padder control-label"><i class="fa fa-asterisk text-required"/>电站编号</label>
				<div class="col-lg-2">
            	   <input  type="text" id="stationcode" maxlength="11" name="stationcode" placeholder="请输入电站编号" class="form-control formData" readonly="readonly">
				</div>

           		 <label class="col-lg-1 m-t-sm no-padder control-label"><i class="fa fa-asterisk text-required"/>电站简称</label>
           		 <div class="col-lg-3">
                	<input type="text" id="stationname" maxlength="8" name="stationname" placeholder="请输入电站名称" class="form-control formData">
				</div>

            </div>
            
            <div class="form-group col-sm-12" >
            
            	<label class="col-lg-1 m-t-sm no-padder control-label">电站全称</label>
           		 <div class="col-lg-4">
                	<input type="text" id="stationfullname" maxlength="20" name="stationfullname" placeholder="请输入电站全称" class="form-control formData">
				</div>
				
				<label class="col-lg-1 no-padder m-t-sm control-label" ><i class="fa fa-asterisk text-required"/>电站类型</label>
				<div class="col-lg-2">
					<ui-select ng-model="stationTyped.selected" theme="bootstrap" ng-change="stationTypeChange()">
						<ui-select-match placeholder="请输入..." ng-model="stationTyped.selected.regionName" >{{$select.selected.typeName}}</ui-select-match>
						<ui-select-choices  repeat="item in stationType | filter: $select.search">
							<div ng-bind-html="item.typeName | highlight: $select.search"></div>
						</ui-select-choices>
					</ui-select>
                       <input type="hidden" name="stationType" id="stationType" value="" />
				</div>
				
				
			</div>
			
           <div class="form-group col-sm-12">
       		  <label class="col-lg-1 control-label" style="letter-spacing:2px;">负&nbsp;责&nbsp;人</label>
             <div class="col-lg-2">
                 <input type="hidden" type="hidden" id="managerid" name="managerid" class="form-control formData">
	           	<ui-select ng-model="managerd.selected" theme="bootstrap" ng-change="managerChange()">
	            <ui-select-match placeholder="请输入关键字..." ng-model="managerd.selected.realName" >{{$select.selected.realName}}</ui-select-match>
	            <ui-select-choices  repeat="item in manager | filter: $select.search">
	              <div ng-bind-html="item.realName | highlight: $select.search"></div>
	            </ui-select-choices>
	         	 </ui-select>
             </div>

       		 <label class="col-lg-1 no-padder m-t-sm control-label">总装机量</label>
         		<div class="col-lg-2 no-padder">
         		<div  class="col-lg-11">
           			<input type="text"  id="buildcapacity" name="buildcapacity" placeholder="例如：111" maxlength="10" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')">
         	 	</div>
         	 		<label class="col-lg-1 no-padder m-t-sm control-label">kw</label>
         		</div>

		<label class="col-lg-1 no-padder m-t-sm control-label">投产时间</label>
		         <div  class="col-lg-2 m-b-xs">
		             <input type="text" id ="productiondate" placeholder="请选择时间" name ="productiondate"   class="form-control formData"/>
		         </div>
		<label class="col-lg-1 no-padder m-t-sm control-label">停产时间</label>
		         <div  class="col-lg-2">
		             <input type="text" id ="closedate" placeholder="请选择时间" name ="closedate"   class="form-control formData"/>
		         </div>
            </div>
            <div class="form-group col-sm-12">
            	<hr  style="border:1px dotted rgba(154, 150, 150, 0.31);margin-left:2%; width: 110%">
            </div>
            
            <div class="form-group  col-sm-12">
		         <label class="col-lg-1 no-padder m-t-sm control-label" ><i class="fa fa-asterisk text-required"/>地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址</label>
	              <div class="col-lg-2">
				            <ui-select ng-model="provinced.selected" theme="bootstrap" ng-change="provinceChange()">
				            <ui-select-match placeholder="请输入..." ng-model="provinced.selected.regionName" >{{$select.selected.regionName}}</ui-select-match>
				            <ui-select-choices  repeat="item in province | filter: $select.search">
				              <div ng-bind-html="item.regionName | highlight: $select.search"></div>
				            </ui-select-choices>
				          	</ui-select>
		              <input type="hidden" name ="provinceid"  id="provinceid"  class="form-control formData"/>
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
             	<div class="col-lg-5">
             		<input type="text" id="address" placeholder="请填写详细地址" name="address" maxlength="50" class="form-control formData">
             	</div>
             </div>
             
             <div class="form-group col-sm-12">

               		<label class="col-lg-1 no-padder m-t-sm control-label">经&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度</label>
		              <div class="col-lg-2">
		                <input type="text" id="longitude" placeholder="例如：119.25" maxlength="10" name="longitude" class="form-control formData">
		              </div>
	             	<label class="col-lg-1 no-padder m-t-sm control-label">纬&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度</label>
		              <div class="col-lg-2">
		                <input type="text" id="latitude" placeholder="例如：11.16" maxlength="10" name="latitude" class="form-control formData">
		              </div>
		              <div class="col-lg-2">
                		<button type="button" ng-click="getlatandlng()" class="btn" style="color: #ffffff;background-color: #1caf9a"><strong>计算经纬度</strong></button>
   			 		  </div>
             </div>
             
            <div class="form-group col-sm-12">
                <label class="col-lg-1 no-padder m-t-sm control-label"><i class="fa fa-asterisk text-required"/>联系电话</label>
		           <div class="col-lg-2">
		             <input type="text" id="stationtel" maxlength="18" name="stationtel" placeholder="区号-电话-分机   或  手机号" class="form-control formData">
		           </div>

             	<label class="col-lg-1 no-padder m-t-sm control-label">邮&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;编</label>
              		<div class="col-lg-2">
                	  <input type="text" id="stationzip" name="stationzip" placeholder="例如：10000" maxlength="6" class="form-control formData" onkeyup="value=value.replace(/\D/g,'')">
               		</div>
             </div>

             <div class="form-group col-sm-12">
            	<hr  style="border:1px dotted rgba(154, 150, 150, 0.31);margin-left:2%; width: 110%; padding: 0 0 0 0px;">
            </div>
             <div class="form-group col-sm-12">
	                <label class="col-lg-1 no-padder control-label" style="line-height: 70px;">实景图片</label>
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

			 		<label  class="col-lg-1 no-padder control-label" style="line-height: 70px;">其他介绍</label>
                 	<div  class="col-lg-5">
               			 <textarea rows="3" maxlength="300" name ="descp" id ="descp" class="form-control formData"></textarea>
			 		</div>
             </div>

            <div class="form-group">
            	<div class="col-sm-offset-1" style="padding-left:25px;">
                	<button type="button" onclick="savePowerViewData();" data-loading-text="保存中..." autocomplete="off" id="savePowerButton" class=" btn m-b-xs w-xs-s  btn-info"><strong>保 存</strong></button>
               		<button id="cancelBtn" onclick="cancelPowerViewData();" type="button" class=" m-l-sm  btn m-b-xs w-xs-s btn-default" style="border:none;"><strong style="color: #1caf9a !important;">取消</strong></button>
   			 	</div>
          		<div id="showhintError"  class="m-b-sm col-sm-offset-3 hidden"><font color="#FF0000">数据已存在,请勿重复插入!!!</font></div>
   			 </div>
          </form>
		<!-- form 结束 -->
     </div>
   </div>
</div>
</div>
<script type="text/javascript">
 
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

		$("#savePowerData").validate( {
			rules : {
				stationcode:{
					number: true,
					required : true,
					maxlength : 15
				},
				stationname:{
					required : true,
					maxlength : 8
				},
				stationfullname:{
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
					required : true,
					maxlength : 11
				},
				cityid:{
					required : true,
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
				address:{
					maxlength : 50,
					required : true,
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
					required : true,
					phone:true
				},
				stationzip:{
					zipcode: true,
					maxlength : 6
				},
				descp:{
					maxlength : 300
				},
				provinceid:{
					required : true,
				},
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						if(json.type=="error"){
							$("#showhintError").removeClass('hidden');
						}else{
							var stid=json.newSTID;
							$("#stationid").val(stid);
							findPowerDetailData(stid);
							promptObj(json.type, '', json.message);
							cancelPowerViewData();
						}
					},error : function(json) {
						getPrompt('error', '',"保存失败,请稍后重试");
						cancelPowerViewData();
					}
				};
				$("#savePowerButton").button('loading');
				$('#savePowerData').ajaxSubmit(options);
			}
		});
	});

    //保存
 	function savePowerViewData() {
 		if($("#picture2").val()==""){
			$("#picture2").attr("disabled","disabled");
		}
		if($("#picture1").val()==""){
			$("#picture1").attr("disabled","disabled");
		}
		if($("#picture0").val()==""){
			$("#picture0").attr("disabled","disabled");
		}
		$("#savePowerData").trigger("submit");
	}
    //取消
	function cancelPowerViewData() {
		$("#showPowerData").removeClass("hidden");
		$("#powerDataeEdit").addClass("hidden");

	}
	if (location.href.indexOf("createPower=true") != -1) {
		$("#showPowerData").addClass("hidden");
		$("#powerDataeEdit").removeClass("hidden");
	}
	//编辑台账
	function powerEdit(){
		$("#savePowerButton").button('reset');
		$("#showPowerData").addClass("hidden");
		$("#powerDataeEdit").removeClass("hidden");
		findPowerDetailData($("#stationid").val(),1);
	}


	 var findPowerDetailData;
	 var getPrompt
     app.controller('StationCtrl', ['$http', 'toaster','$location', '$rootScope', '$scope', '$state', '$stateParams',
	                               function($http, toaster,$location, $rootScope, $scope, $state, $stateParams){
    	$rootScope.currentView = '03';
     	$rootScope.isGroup = 0;
     	$scope.getCurrentDataName('03',0);
    	 $scope.broadcastSwitchStation = function () {
			 //电站基本信息页面加载初始化
			 $http({
				method : "POST",
				url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
				params: {
				}
			}).success(function(response) {
				$stateParams.inId = response.currentSTID;
				$scope.findPowerDetailData($stateParams.inId,1);
			});
     	}
		$scope.$on('broadcastSwitchStation', function(event, data) {
			$("#currentDataName1").html(data.dataName);
			$scope.broadcastSwitchStation();
	    });
     		
    	   getPrompt=$scope.getPrompt = function(type,title,message){
    	        toaster.pop(type,title,message);
    	    };

			// 页面初始化 查询是否有厂区数据
			$scope.selectFactoryData = function(id) {
					if(id){
						$http({
							method : "POST",
							url : "${ctx}/PowerStation/selectAllData.htm",
							params : {
								'parentid' : id,
							}
						}).success(function(result) {
							if(result.length){
								$("#showFactoryData").removeClass("hidden");
								$("#FactoryImg").addClass("hidden");
							}else{
								$("#FactoryImg").removeClass("hidden");
								$("#showFactoryData").addClass("hidden");
							}
						})
					}
			};

					// 页面初始化 查询电站下，是否配有设备
					$scope.selectDeviceCount = function(id) {
						if(id){
							$http({
								method : "POST",
								url : "${ctx}/PowerStation/selectDeviceCount.htm",
								params : {
									'id' : id,
								}
							}).success(function(result) {
								$scope.sum=result;
								$("#boxChangeCount").html(result.bboxchangeCount);
								$("#inverterCount").html(result.binverterCount);
								$("#junctionBoxCount").html(result.bjunctionboxCount);
								$("#otherDeviceCount").html(result.botherdeviceCount);
								if(result.deviceSum>0){
									$("#showDeviceRunData").removeClass("hidden");
								}else{
									$("#showDeviceImg").removeClass("hidden");
									}
							 	 })
								}
							};

		$scope.getData=function(){

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
		 $http({
			 method:"POST",
			 url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
			 params:{
				     "treeLevel":1,
				     "parentId":1
				     }
			 }).success(function (result) {
		    	 $scope.province = result;
		    	 $scope.province.unshift({id : "",regionName : '请选择'});
		    	 if($("#provinceid").val() != null && $("#provinceid").val() != "" ){
			    	 for(var i=0,len=$scope.province.length;i<len;i++){
						if($scope.province[i].id==  $("#provinceid").val()){
							$scope.provinced.selected= { regionName: $scope.province[i].regionName,id:  $("#provinceid").val()};
						}
					}
		    	 }
		    	 if($("#cityid").val() != null && $("#cityid").val() != "" ){
		    		 $scope.provinceChange();
		    	 }
			});
		}
		//获取经纬度
		$scope.getlatandlng = function (){
			var add="";
			var address=$('#address').val();
			if($("#provinceid").val() != null && $("#provinceid").val() != ""){
				add=add+provinceMapName;
			}
			if($("#cityid").val() != null && $("#cityid").val() != "" ){
				add=add+cityMapName;
			}
			if($("#countyid").val() != null && $("#countyid").val() != "" ){
				add=add+countyMapName;
			}
			if(address!=null){
				add=add+address;
			}
			if(add!=null && add!=""){
				$.ajax({
		        	 method:"POST",
		        	 url:"${ctx}/GetLatAndLngByBaidu/getlatandlng.htm",
		        	 data:{
		        		 "add":add
		        		 }
		        	 }).success(function (o) {
		        		 if(o!=null){
		        			 $("#longitude").val(o[0]);
		        			 $("#latitude").val(o[1]);
		        		 }
		        	 });
			}
		}
		 $scope.provinceChange= function () {
	    		provinceMapName=$scope.provinced.selected.regionName;
	    		 var a = angular.copy($scope.provinced.selected.id);
	    		 $scope.cityd.selected = {regionName : null,id : null};
	    		 $scope.countyd.selected = {regionName :null,id : null};
	    		 $("#provinceid").val(a);
		         $http({
		        	 method:"POST",
		        	 url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
		        	 params:{
		        		 "treeLevel":2,
		        		 "parentId":a
		        		 }
		        	 }).success(function (resultcity) {
		        	 $scope.city = resultcity;
		        	 $scope.city.unshift({id : "",regionName : '请选择'});
		        	 $scope.cityd.selected = {regionName : $scope.city[0].regionName,id : $scope.city[0].id};
		        	 if(!$scope.provinced.selected.id){
		        		 $("#cityid").val("");
			    		}else{
		        	  for(var i=0,len=$scope.city.length;i<len;i++){
		 					if($scope.city[i].id==  $("#cityid").val()){
		 						$scope.cityd.selected= { regionName: $scope.city[i].regionName,id:  $("#cityid").val()};
		 					}
			    		  }
		 				}

		        	 if($("#countyid").val() != null && $("#countyid").val() != "" ){
			    		 $scope.cityChange();
			    	 }
		         });
		}

		$scope.cityChange= function () {
   		 //输入后调用经纬度
	    	cityMapName=$scope.cityd.selected.regionName;
	        var b = angular.copy($scope.cityd.selected.id);

	        $("#cityid").val(b);
	        $scope.countyd.selected= { regionName: null,id:  null};
	        $http({
	        	method:"POST",
	        	url:"${ctx}/BaseRegion/selectByTreeLevel.htm",
	        	params:{
	        		"treeLevel":3,
	        		"parentId":((b==null) || (b==""))?0:b
	        		}
	        	}).success(function (resultcounty) {
	        	$scope.county = resultcounty;
	        	$scope.county.unshift({id : "",regionName : '请选择'});
	        	$scope.countyd.selected = {regionName : $scope.county[0].regionName,id : $scope.county[0].id};
	        	 if(!$scope.cityd.selected.id){
	        		 $("#countyid").val("");
		    		}else{
	        		for(var i=0,len=$scope.county.length;i<len;i++){
		 					if($scope.county[i].id==  $("#countyid").val()){
		 						$scope.countyd.selected= { regionName: $scope.county[i].regionName,id:  $("#countyid").val()};
		 						countyMapName=$scope.countyd.selected.regionName
		 					}
		 				  }
		    		  }
		         $scope.countyChange= function () {
		        	 countyMapName=$scope.countyd.selected.regionName
	        		 $("#countyid").val($scope.countyd.selected.id);
	        	 }
	        });
      }

	//自动生成编号
	$scope.generatePowerCode = function(code) {
				$http({
					method : "POST",
					url : "${ctx}/PowerStation/generatePowerCode.htm",
					params : {
						'parentid' : 1,
						'comcode':code
					}
				}).success(function(result) {
					$("#stationcode").val(result);
				  })
			 };

	$scope.getCompanyCode=function(id){
		//$scope.companyd = {};
   		//$scope.company = null;
		$http({method:"POST",url:"${ctx}/Company/selectById.htm",
			params:{
				comId:id
			}
		}).success(function (result) {
			$scope.generatePowerCode(result.comCode);
		});
	}
       $scope.stationTypeArr = new Array();
       $scope.stationTypeArr["01"] = "地面电站";
       $scope.stationTypeArr["02"] = "分布式电站";
       $scope.stationTypeArr["03"] = "用户电站";
       $scope.stationType = [
           {"typeId":"01", "typeName":"地面电站"},
           {"typeId":"02", "typeName":"分布式电站"},
           {"typeId":"03", "typeName":"用户电站"}];
       $scope.stationTyped = {};
       $scope.stationTypeChange = function () {
           $("#stationType").val(angular.copy($scope.stationTyped.selected.typeId));
       };
		//基本信息查询方法
		findPowerDetailData=$scope.findPowerDetailData = function(id,type) {
				if(id){
					//查询是否有厂区数据
					$scope.selectFactoryData(id);
					//查询是否设备数据
					$scope.selectDeviceCount(id);
				}else{
					$("#FactoryImg").removeClass("hidden");
					$("#showDeviceImg").removeClass("hidden");
					$scope.getData();
					$scope.generatePowerCode();
				}
				$http({
					method : "POST",
					url : "${ctx}/PowerStation/selectById.htm",
					params : {
						'id' : id,
					}
				}).success(function(result) {
					$scope.vo=result;
					$("#stationid").val(id);
					if($scope.vo.scenepictures != null && $scope.vo.scenepictures !=""){
						$("#picture").show();
						var array = $scope.vo.scenepictures.split(",");
						for (var i=0;i<3;i++){
							if(array[i]){
								$("#imgdiv"+i).show();
								$("#billImgDt"+i).attr("src","${imgPath}/document/powerStationPicture/"+array[i]);
							}else{
								$("#imgdiv"+i).hide();
							}
							$("#picture" + i).css("display","block");
						}
					}else{
						$("#picture").hide();
					}
					if($scope.vo.stationname){
		       			$("#currentDataName1").html($scope.vo.stationname);
		       		}
					//编辑页面
					if(type==1){
                        $("#stationcode").val($scope.vo.stationcode);
                        $("#stationname").val($scope.vo.stationname);
                        $("#stationfullname").val($scope.vo.stationfullname);

                        $("#parentid").val($scope.vo.parentid);
                        $("#companyid").val($scope.vo.companyid);
                        $("#depid").val($scope.vo.depid);
                        $("#managerid").val($scope.vo.managerid);
                        $("#provinceid").val($scope.vo.provinceid);
                        $("#cityid").val($scope.vo.cityid);
                        $("#countyid").val($scope.vo.countyid);
                        $("#address").val($scope.vo.address);
                        $("#buildcapacity").val($scope.vo.buildcapacity);
                        $("#longitude").val($scope.vo.longitude);
                        $("#latitude").val($scope.vo.latitude);
                        $("#statusrating").val($scope.vo.statusrating);
                        $("#valuesrating").val($scope.vo.valuesrating);
                        $("#stationtel").val($scope.vo.stationtel);
                        $("#stationzip").val($scope.vo.stationzip);
                        if($scope.vo.productiondate){
                            $("#productiondate").val(new Date($scope.vo.productiondate).Format("yyyy-MM-dd"));
                        }
                        if($scope.vo.closedate){
                            $("#closedate").val(new Date($scope.vo.closedate).Format("yyyy-MM-dd"));
                        }
                        $("#descp").val($scope.vo.descp);
                        if($scope.vo.scenepictures != null && $scope.vo.scenepictures !=""){
                            var array = $scope.vo.scenepictures.split(",");
                            for (var i=0;i<array.length;i++){
                                $("#oldFile"+i).val(array[i]);
                                $("#billImg"+i).attr("src","${imgPath}/document/powerStationPicture/"+array[i]);
                            }
                        }
                        $("#picture2").removeAttr("disabled");
                        $("#picture1").removeAttr("disabled");
                        $("#picture0").removeAttr("disabled");
                        $scope.getData();
                        if ($scope.vo.stationType == null){
                            $scope.stationTyped.selected = {"typeId": "", "typeName": "请选择..."};
                        }else{
                            $scope.stationTyped.selected = {"typeId": $scope.vo.stationType, "typeName": $scope.stationTypeArr[$scope.vo.stationType]};
                            $("#stationType").val(angular.copy($scope.stationTyped.selected.typeId));
                        }
					}
                    $scope.vo.stationType = $scope.stationTypeArr[$scope.vo.stationType];
					
					//所属部门下拉框查询-------------------------------------Start------------------------------------------
					$scope.depd = {};
			   		$scope.department = null;
					$http({method:"POST",url:"${ctx}/authDepartment/getDepartmentTree.htm",
						params:{
							comid : $scope.vo.companyid
						}
					}).success(function (result) {
				    	 $scope.department = result;
				    	 for(var i=0,len=$scope.department.length;i<len;i++){
								if($scope.department[i].id==  $("#depid").val()){
									$scope.depd.selected= { name: $scope.department[i].name,id:  $("#depid").val()};
								}
							}
				    	 $scope.depChange= function () {
					         $("#depid").val(angular.copy($scope.depd.selected.id));
					        //$scope.getCompanyCode(angular.copy($scope.depd.selected.id));
						}
					});

				});
			};
	if($stateParams.inId){
		$scope.findPowerDetailData($stateParams.inId);
	}else{
		
		$http({
			method : "POST",
			url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
			params: {
			}
		}).success(function(response) {
			console.log(response.currentSTID+"=====currentSTID");
			$stateParams.inId = response.currentSTID;
			if(response.currentSTID){
				$("#switchPowerModalId").show();
			}
			$scope.findPowerDetailData($stateParams.inId);
		});
		
	}
	
	 
}]);

</script>

