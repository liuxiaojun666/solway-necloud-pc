<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/powerview.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>
<style>
	.m_left{
		margin-left: -75px;
	}
</style>
<div class="hbox hbox-auto-xs hbox-auto-sm" >
<!-- 左侧div -->
<div class="col"  style="overflow: hidden;width: 210px;">
<div class="vbox">
<div  class="menu">
	<div class="menu_text">
		<div class="menu_center" >
			<span style="color:white;font-size:18px;" class=" pull-left m-b-xs">电站台账</span>
		</div>
	</div>
<!-- 按钮组	 -->
<div class="no-padder">
	<!-- 电站信息 -->
	<nav ui-nav="" class="ng-scope" >
		<ul id="li" class="nav">
			<li id="ids6" onclick="changeCss('6')" ui-sref-active="active">
				<a  onclick="upadteImg(1)" class="auto" ui-scroll="powerStationTile">
					<i class="m_left">
						<img id="powerImg" alt="" src="${ctx}/theme/images/powerStationNoS.png">
					</i>
					<span class="m-l-md">电站信息</span>
				</a>
			</li>
			<!-- 厂区划分 -->
			<li id="ids5" onclick="changeCss('5')" ui-sref-active="active">
			    <a  onclick="upadteImg(2)"  class="auto" ui-scroll="factoryTile">
			    	<i class="m_left">
						<img id="factoryImg" alt="" src="${ctx}/theme/images/factoryNoS.png">
			    	</i>
			    	<span class="m-l-md">厂区划分</span>
			    </a>
			</li>
			<!-- 设备台账 -->
			<li id="ids7" onclick="changeCss('7')" class="active">
				<a  onclick="upadteImg(3)" href="" class="auto"  >
					<i class="m_left">
						<img id="otherImg" alt="" src="${ctx}/theme/images/deviceNoS.png">
					</i>
					<span class="m-l-md"  style="position: relative; left: 3px; ">设备台账</span>

					<span class=" text-muted" style=" position: absolute;right: 10px;">
						<i class="fa fa-fw fa-angle-right text"></i>
						<i class="fa fa-fw fa-angle-down text-active"></i>
					</span>
				</a>
				<ul class="nav nav-sub dk powerUl">
					<li id="ids1" onclick="changeCss('1','1')" ui-sref-active="active">
						<a ui-scroll="boxChangeanchor">
							<span style="padding-right: 20px;" id="boxcolour">箱变</span>
							<span  class="pull-right" style="width:35px;">
								<span style="width:35px;" class="pull-right" id="boxChangeCount"></span>
							</span>
						</a>
					</li>
					<li id="ids2" onclick="changeCss('2','1')" ui-sref-active="active">
						<a  ui-scroll="inverteranchor">
							<span style="padding-right: 10px;">逆变器</span>
							<span id="inverterCount"  class="pull-right" style="width:35px;"></span>
						</a>
					</li>
					<li id="ids3" onclick="changeCss('3','1')" ui-sref-active="active">
						<a ui-scroll="junctionBoxanchor">
							<span style="padding-right: 10px;">汇流箱</span>
							<span id="junctionBoxCount" class="pull-right" style="width:35px;"></span>
						</a>
					</li>
					<li id="ids4" onclick="changeCss('4','1')" ui-sref-active="active">
						<a ui-scroll="otherDeviceanchor">
							<span style="padding-right: 0px;">其它设备</span>
							<span id="otherDeviceCount" class="pull-right" style="width:35px;"></span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</nav>
</div>
<div class="col-sm-12 text-center " style="margin-top:40px;">
	<button class="  btn m-b-xs w-xs   btn-info" id="saveButton" onclick="checkDataComplete();" type="button"><strong>检查数据完整性</strong></button>
</div>
</div>
</div>
</div>
<div class="col lter">
	<div class="vbox">
<!-- 右侧div -->
<div class=" wrapper col-sm-12">
<!-- 电站 -->
<div class="col-sm-12 no-padder panel panel-default">
		<div id="powerStationTile" class="no-padder col-sm-12"  style="margin: -50px 0 0;border-top: 50px solid transparent;">
	      <!--  <h4 class="modal-title modal-header">电站信息</h4> -->
	        <h4 class="modal-title modal-header">
	        	<span class="font-h3 blue-1 m-n text-black" id="currentDataName1" style="padding-left: 10px;"></span>
				<span  style="cursor:pointer;color: #428bca;display:none" data-toggle="modal" id="switchPowerModalId" data-target="#switchPowerModal" >[切换]</span>
			</h4>
				
	    </div>
		<div class="wrapper  col-sm-12"  ng-include="'${ctx}/tpl/ledgerPage/powerStationView/powerStation/addPowerStationSkip2.jsp'" class="list_top"></div>
		<!-- <div class="m-t-md col-sm-12" id="powerDataeEdit" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/powerStation/addPowerStationSkip.jsp'" class="list_top"></div> -->
<%-- 		<div data-ng-include="'${ctx}/tpl/ledgerPage/powerStationView/powerFactory/addpowerFactorySkip2.jsp'"></div> --%>
	<div >
	<div id="factoryTile" class="no-padder col-sm-12" style="margin: -50px 0 0; border-top: 50px solid transparent;" >
	<h4 class="modal-title modal-header">厂区划分</h4>
	</div>
	 <div id="FactoryImg" class="list_below col-sm-12 hidden">
		<div class="text-center">
			<img alt="" class="m-lg" src="${ctx}/theme/images/addFactoryImg.png">
		</div>
		<div class="text-center m-b-md">
			<a>
			  <img id="" onclick="addfactory('factoryModal2')" src="${ctx}/theme/images/addFactory.png">
			</a>
		</div>
	</div>
	<div id="showFactoryDataSkip2" class="hidden list_top col-sm-12"  ng-include="'${ctx}/tpl/ledgerPage/powerStationView/powerFactory/addpowerFactorySkip2.jsp'" ></div>
	<div id="showFactoryData" class="hidden list_top col-sm-12"  ng-include="'${ctx}/tpl/ledgerPage/powerStationView/powerFactory/powerFactoryList.jsp'" ></div>
	</div>
<!---------------------------------------	设备台账       ----------------------------------->
	<div id="powerDataeEdit" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/fileUpload.jsp'" class="list_top"></div>
	<div id="importExcelDataModel" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/importExcelData.jsp'" class="list_top"></div>
	<div class="modal-header col-sm-12"  style="height: 50px;z-index:2">
			<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">设备台账</span>
		<%--
			<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">Excel版本：</span>
			<select id="version">
				<option value="00">2007版</option>
				<option value="01">2010版</option>
			</select>
		--%>
			<a>
				<%--<span onclick="exportExcel(0)" class="font-h3 blue-1 fa fa-arrow-circle-down p-r-5 font_color">下载模板</span>--%>
				<%--<span onclick="fileUpload('fileUpload');"  class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导入</span>--%>
				<span onclick="exportExcel(1)" class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导出</span>
			</a>
	</div>
<!--箱变 -->
<div id="showDeviceImg" class="list_below hidden">
	<div class="text-center" style="padding: 0px 95px;">
		<img  src="${ctx}/theme/images/downloadImg.png" width="100%">
	</div>
	<div class="text-center m-b-md">
		<a>
			<img onclick="exportExcel(0)" src="${ctx}/theme/images/downloadMould.png">
			<img onclick="fileUpload('fileUpload');"  src="${ctx}/theme/images/import.png">
			<img onclick="onlineEdit()" src="${ctx}/theme/images/onlineInput.png">
		</a>
	</div>
</div>

<div id="showDeviceRunData" class="m-t-xs hidden col-sm-12">
	<div id="boxChangeanchor"  class="m-t-xs col-sm-12 no-padder wrapper" style=" margin: -50px 0 0;
    border-top: 50px solid transparent; z-index: 1;">
		<span style="padding-left: 12px; font-size:16px;">箱变</span>
		<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">Excel版本：</span>
		<select name="version_3">
			<option value="0">2007版</option>
			<option value="1">2010版</option>
		</select>
		<a>
			<span onclick="exportExcelData(3)" class="font-h3 blue-1 fa fa-arrow-circle-down p-r-5 font_color">下载模板</span>
			<span onclick="importExcelData(3, 'importExcelData');"  class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导入</span>
		</a>
		<hr class="no-padder" style="border:1px dotted rgba(154, 150, 150, 0.31);margin-top: 2px;">
	</div>
    <div id="boxChange" class="list_top col-sm-12" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/boxChange/boxChangeList.jsp'" ></div>

 	<div id="inverteranchor"  class="m-t-xs col-sm-12 no-padder" style="margin-top:10px; margin: -50px 0 0;
    border-top: 50px solid transparent; z-index: 1;">
		<span  style="padding-left: 12px; font-size:16px;">逆变器</span>
		<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">Excel版本：</span>
		<select name="version_2">
			<option value="0">2007版</option>
			<option value="1">2010版</option>
		</select>
		<a>
			<span onclick="exportExcelData(2)" class="font-h3 blue-1 fa fa-arrow-circle-down p-r-5 font_color">下载模板</span>
			<span onclick="importExcelData(2, 'importExcelData');"  class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导入</span>
		</a>
		<hr class="no-padder" style="border:1px dotted rgba(154, 150, 150, 0.31);margin-top: 2px;">
	</div>
 	<div id="inverter" class="list_top  col-sm-12" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/inverter/inverterList.jsp'"  ></div>

 	<div id="junctionBoxanchor" class="m-t-xs col-sm-12 no-padder" style="margin-top:10px; margin: -50px 0 0;
    border-top: 50px solid transparent; z-index: 1;">
		<span  style="padding-left: 12px; font-size:16px;">汇流箱</span>
		<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">Excel版本：</span>
		<select name="version_1">
			<option value="0">2007版</option>
			<option value="1">2010版</option>
		</select>
		<a>
			<span onclick="exportExcelData(1)" class="font-h3 blue-1 fa fa-arrow-circle-down p-r-5 font_color">下载模板</span>
			<span onclick="importExcelData(1, 'importExcelData');"  class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导入</span>
		</a>
		<hr class="no-padder" style="border:1px dotted rgba(154, 150, 150, 0.31);margin-top: 2px;">
	</div>
 	<div id="junctionBox" class="list_top  col-sm-12" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/junctionBox/junctionBoxList.jsp'" ></div>

 	<div id="otherDeviceanchor"  class="m-t-xs col-sm-12 no-padder" style="margin-top:10px; margin: -50px 0 0;
    border-top: 50px solid transparent; z-index: 1;">
		<span style="padding-left: 12px; font-size:16px;">其它设备</span>
		<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">Excel版本：</span>
		<select name="version_4">
			<option value="0">2007版</option>
			<option value="1">2010版</option>
		</select>
		<a>
			<span onclick="exportExcelData(4)" class="font-h3 blue-1 fa fa-arrow-circle-down p-r-5 font_color">下载模板</span>
			<span onclick="importExcelData(4, 'importExcelData');"  class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导入</span>
		</a>
		<hr class="no-padder" style="border:1px dotted rgba(154, 150, 150, 0.31);margin-top: 2px;">
	</div>
 	<div id="otherDevice" class="list_top  col-sm-12" ng-include="'${ctx}/tpl/ledgerPage/powerStationView/otherDevice/otherDeviceList.jsp'" ></div>
</div>
</div>
</div>
</div>
</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">

//无数据 厂区新增数据方法
$(function() {
	$("#saveFactoryData").validate( {
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
			parentid:{
				required : true,
				maxlength : 11
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
							promptObj(json.type, '', json.message);
							$("#showhint").removeClass('hidden');
						}else{
							promptObj(json.type, '', json.message);
							findPowerDetailData();
							cancelPowerViewData();
						}
					},error : function(json) {
						getPrompt('error', '',"保存失败,请稍后重试");
						cancelPowerViewData();
					}
				};
				$('#saveFactoryData').ajaxSubmit(options);
			}
	});
});

function saveFactoryForm(){
	$("#saveFactoryData").trigger("submit");
}

//检查数据完整性
function checkDataComplete() {
	if(!$("#stationid").val()){
		alert("未配置电站基本信息");
	}else{
		$.ajax({
				type : "post",
					url : "${ctx}/PowerStation/checkDataComplete.htm",
					data : {
						"id" : $("#stationid").val()
					},success : function(json) {
 						// promptObj(json.type, '',json.message);
						alert(json.message);
						// promptObj(json.type, '',json.message);
					},
					error : function(json) {
						promptObj("error", '',"操作失败,请稍后重试");
					}
				});
	    	}
		}

//在线编辑
function onlineEdit(){
	if(!$("#stationid").val()){
		alert("未配置电站基本信息");
	}else{
		$("#showFactoryData").removeClass("hidden");
		$("#showDeviceRunData").removeClass("hidden");
	}
}

function addfactory(modalId){
	if(!$("#stationid").val()){
		alert("未配置电站基本信息");
	}else{
		$('#showFactoryDataSkip2').removeClass('hidden')
		getFactoryData2($("#stationid").val());
		generatePowerCode2();
		$('#'+modalId).modal('show');
	}
}

function fileUpload(modalId){
	if(!$("#stationid").val()){
		alert("未配置电站基本信息");
	}else{
		$('#'+modalId).modal('show');
	}
}
function downloadMould(){
	var url = "${imgPath}/document/powerStationExcelTemplet/powerStationExcelTemplet.xlsx";
	window.location.href = url;
}

function importExcel(){
	$("#importExcelData").click();
}

function exportExcel(sign){
	if(!$("#stationid").val()){
		alert("未配置电站基本信息");
	}else{
		var url = "${ctx}/PowerStation/downloadPowerData.htm";
		if(sign == 0){
			url = "${ctx}/PowerStation/downloadTemplet.htm";
		}
		CommonPerson.Base.LoadingPic.FullScreenShow("数据导出中，请稍后...");
		url +='?id='+$("#stationid").val();
		url += '&version='+$("#version").val();
		url +='&&sign='+sign;
		window.location.href = url;
		CommonPerson.Base.LoadingPic.FullScreenHide();
	}
}

function exportExcelData(type) {
	var version = $('select[name=version_' + type + ']').val();
    var url = "${ctx}/PowerStation/downloadTemplate.htm";
    url +='?stid='+$("#stationid").val();
    url += '&version='+version;
    url +='&deviceType='+type;
    window.location.href = url;
}
function importExcelData(type, modalId) {

    var version = $('select[name=version_' + type + ']').val();

    if(!$("#stationid").val()){
        alert("未配置电站基本信息");
    }else{
        $("#importExcelDataStid").val($("#stationid").val());
        $('#importExcelDataDeviceType').val(type);
        $('#'+modalId).modal('show');
    }

}

function changeCss(flag,type){
	$("#ids"+flag).children().addClass("menuCss")
	$("#ids"+flag).siblings().children().removeClass("menuCss")
	if(type){
		$("#otherImg").attr("src","${ctx}/theme/images/deviceNoS.png")
		$("#factoryImg").attr("src","${ctx}/theme/images/factoryNoS.png")
		$("#powerImg").attr("src","${ctx}/theme/images/powerStationNoS.png")
	};
}
function upadteImg(type){

	if(type==1){
		$("#otherImg").attr("src","${ctx}/theme/images/deviceNoS.png")
		$("#factoryImg").attr("src","${ctx}/theme/images/factoryNoS.png")

		$("#powerImg").attr("src","${ctx}/theme/images/powerStationNoSe.png")
	}else if(type==2){
		$("#otherImg").attr("src","${ctx}/theme/images/deviceNoS.png")
		$("#powerImg").attr("src","${ctx}/theme/images/powerStationNoS.png")

		$("#factoryImg").attr("src","${ctx}/theme/images/factoryNoSe.png")
	}else if(type==3){
		$("#factoryImg").attr("src","${ctx}/theme/images/factoryNoS.png")
		$("#powerImg").attr("src","${ctx}/theme/images/powerStationNoS.png")

		$("#otherImg").attr("src","${ctx}/theme/images/deviceNoSe.png")
	}
}

function getDataType() {
	$.ajax({
		type : "post",
			url : "${ctx}/UserAuthHandle/getCurrentInfoNew.htm",
			data : {
				currentView : '03',
				isGroup : 0
			},success : function(result) {
				if(result.currentDataName){
	       			$("#currentDataName1").html(result.currentDataName);
	       		}else{
	       			$("#currentDataName1").html("-请选择-");
	       		}
				
			},
		});
}
//getDataType();
</script>
