<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js"type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/data-format.js" type="text/javascript"></script>

 <style>
.imgfile input[type="file"] {
    position: absolute;
    width: 66px;
    height: 66px;
    opacity: 0;
}
 .border_hide > thead > tr > th {
       border-right-color: #FFFFFF!important;
       border-top: none;
}
 .map-nav-ul > li > a:hover, .nav > li > a:focus {
    background: transparent;
    color: #06bebd;
}
.modal-header {
    background-color: #f7f7f7;
    border-radius: 3px 6px 0px 0px;
    padding: 11px;
    border: 0px;
}
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
.menu{
	position:fixed;
	float: left;
	width: 210px;
	text-align: center;
	margin: 0px 0px 0px ;
	background-color:White;
	height: 1000px;
}
.menuCss{
background: transparent;
    color: #06bebd;
}
.menu_text{
	width: 210px;
	background-color:#1caf9a;
	height: 50px;
}
.font_color{
	color: #1caf9a;
}
.menu_center{
	margin: 0 auto;
 	width:170px;
  	line-height:50px;
   	height:30px;"
}

.right_div{
   margin:0px 0px 0px 210px;
}
.outboard{
	background-color:Gainsboro ;
	float: left;
	width: 900px;
	margin: 10px 0px 0px 20px;
}
/* 
.list_top{
	float: left;
	width: 920px;
	margin: 0px 0px 0px 10px;
} */

.list_below{
	float: left;
	width: 920px;
	margin: 5px 0px 0px 10px;
}
.title{
	float: left;
	margin: -10px 0px 0px 10px;
	width: 920px;
	margin-top: 5px;
}
.subhead{
	height: 30px;
	line-height:30px;
}
.button{
	height: 30px;
	font-size: 15px;
	font-weight:bold;
}

.list-group-item {
    background-color: #fff;
    display: block;
    margin-bottom: -1px;
    padding: 10px 15px;
    border: medium none transparent;
    position: relative;
}
.data-bg-red{
background:white none repeat scroll 0 0;
}	
.w-xs{
	width: 120px;
}
.navi ul.nav li li a {
    padding-left: 73px;
    text-align: left
}

.table {
    background-color: transparent;
        border: transparent!important;
}
.b-light {
    border-color: transparent;
}
.table > thead > tr > th {
    padding: 12px 15px;
    border-bottom: 1px solid #e5e5e5;
    color: #040404;
}
.p-r-5{
padding-right: 7px;
}
.table-bordered > thead > tr > th {
    border-color: transparent;
        border: transparent!important;
}

.menu-right {
    position: absolute;
    right: 90px;
}
 </style>
 
<div  class="hbox hbox-auto-xs hbox-auto-sm" ng-controller="powerStationConfig" >
<!-- 左侧div -->
<div class="col"  style="overflow: hidden;width: 210px;">
<div class="vbox">
<div  class="menu"> 
	<div class="menu_text">
		<div class="menu_center clearfix" >
			<span style="color:white;font-size:18px;" class=" pull-left m-b-xs">电站台账</span>
		 </div>	
	</div>
<!-- 按钮组	 -->
<div class="no-padder">
<!-- 初始电量配置 -->
<nav ui-nav="" class=" ng-scope" >
<ul id="li" class="nav">
<li id="ids1" ui-sref-active="active" onclick="changeCss('1')" >
    <a onclick="upadteImg(1)" class="auto m-l-lg text-left" ui-scroll="initStationTile">      
       <i>
      	<img id="initPowerImg"  alt="" src="${ctx}/theme/images/initPowerS.png">
	  </i>
      <span class="m-l-xs" style="position: relative; ">初始电量配置</span>
    </a>
</li>
	  
<!-- 电价配置 -->
<li id="ids2" ui-sref-active="active" onclick="changeCss('2')" >
      <a onclick="upadteImg(2)" class="auto m-l-lg text-left" ui-scroll="powerPrice">      
       <i>
      	<img id="powerPriceImg" alt="" src="${ctx}/theme/images/powerPriceS.png">
      </i>
      <span class="m-l-xs" style="position: relative; ">电价配置</span>
    </a>
</li>
<li id="ids3" ui-sref-active="active" onclick="changeCss('3')" >
      <a onclick="upadteImg(3)" class="auto m-l-lg text-left" ui-scroll="communicationTile">      
       <i>
      	<img id="communicationImg" alt="" src="${ctx}/theme/images/communicationS.png">
      </i>
      <span class="m-l-xs" style="  position: relative;  " >通讯中断配置</span>
    </a>
</li>
<li id="ids4" ui-sref-active="active" onclick="changeCss('4')" >
      <a onclick="upadteImg(4)" class="auto m-l-lg text-left" ui-scroll="weatherConfigTile">      
       <i>
      	<img id="weatherConfigImg" alt="" src="${ctx}/theme/images/aerographS.png">
      </i>
      <span class="m-l-xs" >气象仪配置</span>
    </a>
</li>
<li id="ids5" ui-sref-active="active" onclick="changeCss('5')" >
      <a onclick="upadteImg(5)" class="auto m-l-lg text-left" ui-scroll="busConfigTile">      
       <i>
      	<img id="busConfigTileImg" alt="" src="${ctx}/theme/images/busCfgS.png">
      </i>
      <span class="m-l-xs" style="  position: relative; ">总线配置</span>
    </a>
</li>
	<li id="ids6" ui-sref-active="active" onclick="changeCss('6')" >
		<a onclick="upadteImg(6)" class="auto m-l-lg text-left" ui-scroll="videoConfigTile">
			<i>
				<img id="videoConfigTileImg" alt="" src="${ctx}/theme/images/busCfgS.png">
			</i>
			<span class="m-l-xs" style="  position: relative; ">视频监控点配置</span>
		</a>
	</li>
	<li id="ids7" ui-sref-active="active" onclick="changeCss('7')" >
		<a onclick="upadteImg(7)" class="auto m-l-lg text-left" ui-scroll="protocolConfigTitle">
			<i>
				<img id="protocolConfigImg" alt="" src="${ctx}/theme/images/busCfgS.png">
			</i>
			<span class="m-l-xs" style="  position: relative; ">协议配置</span>
		</a>
	</li>
</ul>
</nav>
</div>
<div class="col-lg-12 text-center " style="margin-top:100px;">
<button class="  btn m-b-xs w-xs   btn-info" id="saveButton" onclick="checkBugCfgData();" type="button"><strong>检查数据完整性</strong></button>
</div>
</div>
</div>
</div>
<div class="col lter">
	<div class="vbox">
<!-- 右侧div -->
<div class=" wrapper col-lg-12">
<!-- 电量初始值显示 -->
<input type="hidden" id="pstationid">
<div class="col-sm-12 no-padder panel panel-default"  >
		<div id="initStationTile" class="no-padder col-sm-12" style="margin: -50px 0 0; border-top: 50px solid transparent;">
		<h4 class="modal-title  modal-header">
			<span class="font-h3 blue-1 m-n text-black" id="currentDataName1" style="padding-left: 10px;"></span>
			<span  style="cursor:pointer;color: #428bca;display:none" data-toggle="modal" id="switchPowerModalId" data-target="#switchPowerModal" >[切换]</span>
		<br/>初始电量配置</h4></div>
		<div id="bStationExpiry" class="col-sm-12 ">
			 <div class="form-group  col-sm-12 m-t-md">
			   <div class="col-lg-5">
				    <label class="col-lg-3 text-right control-label ">截止日期</label>
		             <div class="col-lg-3 no-padder black-4" ng-bind="vo.expirydate | date:'yyyy-MM-dd '"></div>
		             <label class="col-lg-5 control-label text-right">累计发电量(kWh)</label>
		             <div class="col-lg-1 no-padder black-4" ng-bind="vo.totaltw"></div>
	           </div> 
	           <div class="col-lg-5">
				    <label class="col-lg-4 control-label text-right">年发电量(kWh)</label>
		             <div class="col-lg-2 no-padder black-4" ng-bind="vo.yeartw"></div>
		             <label class="col-lg-4 control-label text-right">月发电量(kWh)</label>
		             <div class="col-lg-2 no-padder black-4" ng-bind="vo.monthtw"></div>
	           </div>
	           <div class="col-lg-1 m-t-xs" style="z-index: 1;">
						<a ng-click="expiryEdit('bStationExpiry','bStationExpiryEdit')">
							<span class="icon-pencil font_color m-t-xs"></span>
			              	<span  class="font_color m-t-xs">编辑</span>
	              	   </a>
			   </div>
			 </div>
		</div>

<!-- 电量初始值编辑配置 -->
		<div id="bStationExpiryEdit" class="wrapper hidden col-lg-12">
			 <form class="s-example form-horizontal ng-pristine ng-valid" action="${ctx}/Expirytw/update.htm" method="post" id="editExpiryForm" name="editExpiryForm">
			<div class="col-lg-12 m-t-md">
			   <div class="form-group  col-lg-12 m-t-md">
				    <label class="col-lg-2 control-label">截止日期</label>
		             <div class="col-lg-2 no-padder">
		             	<input type="text" id ="expirydated"  name ="expirydate" placeholder="请选择日期" onMouseOut="cllarverify()" class="form-control formData powerInitVal"/>
		             		<img id="expiryverifyimg">
              		        <span id="expiryverify"></span>
		              </div>
		             <label class="col-lg-2 control-label">累计电量(kWh)</label>
		             <div class="col-lg-2 no-padder">
		                <input type="text" id ="totaltwd"  name ="totaltw" onMouseOut="cllarverify()" maxlength="14" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"  class="form-control formData powerInitVal"/>
		                 <img id="totalimg">
              		     <span id="total"></span>
		             </div>
	           </div> 
	           
	           <div class="form-group  col-lg-12">
				    <label class="col-lg-2 control-label m-t-xs">年发电量(kWh)</label>
		             <div class="col-lg-2 no-padder black-4">
		             	 <input type="text" id ="yeartwd" name ="yeartw" onMouseOut="cllarverify()" maxlength="14" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"  class="form-control formData powerInitVal"/>
		                  <span id="year"></span>
		             </div>
		             <label class="col-lg-2 control-label m-t-xs">月发电量(kWh)</label>
		             <div class="col-lg-2 no-padder">
		             	 <input type="text" id ="monthtwd" name ="monthtw" onMouseOut="cllarverify()" maxlength="14" placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control formData powerInitVal"/>
		                <span id="month"></span>
		              </div>
		        </div>
		        <input type="hidden" id="pstationidExpiry" name="pstationid"  class="form-control formData">
		        <input type="hidden" id="idExpiry" name="id"  class="form-control formData">
		        <div class="form-group">
             	   <div class="col-lg-7" style="z-index: 2;">   
	                	<button type="button" onclick="exitSaveExpiryEdit('bStationExpiryEdit','bStationExpiry', this)" id="exitExpiry" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ><strong>取消</strong></button>
	                	<button type="button" onclick="SaveExpiry('editExpiryForm');" id="saveExpiry" data-loading-text="保存中..." autocomplete="off" class="m-l-sm pull-right  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 	   </div>
   			 	</div>
	        </div>
		  </form>	
		</div>
		
	<div id="powerPrice" class="no-padder col-sm-12" style="margin: -50px 0 0; border-top: 50px solid transparent;" >
	<h4 class="modal-title modal-header">后台运行配置</h4></div>
	 <div class="wrapper  col-lg-12 m-t-md">
		 <div class="form-group">
			 <div class="col-lg-12 m-t-md">
				 <label class="checkbox-inline i-checks col-lg-2">
					 <input type="checkbox" name="isrectip" value="0"  class="form-control">  <i></i> 电站
				 </label>
				 <label class="checkbox-inline i-checks col-lg-2">
					 <input type="checkbox" name="isrectip" value="1"  class="form-control">  <i></i> 汇流箱
				 </label>
				 <label class="checkbox-inline i-checks col-lg-2">
					 <input type="checkbox" name="isrectip" value="2"  class="form-control" >  <i></i> 逆变器
				 </label>
				 <label class="checkbox-inline i-checks col-lg-2">
					 <input type="checkbox" name="isrectip"  value="3"  class="form-control">  <i></i> 箱变
				 </label>
				 <div class="col-lg-2 m-t-xs text-right" id="bpstationConfigEditButton" style="z-index: 1;margin-left: 40px;">
					 <a ng-click="BpstationConfigEdit()">
						 <span class="icon-pencil font_color m-t-xs"></span>
						 <span  class="font_color m-t-xs text-right">编辑</span>
					 </a>
				 </div>
			 </div>
			 <div class="col-lg-12 m-t-md">
				 <label class="checkbox-inline i-checks col-lg-2">
					 <input type="checkbox" name="isrectip"  value="4"  class="form-control">  <i></i> 电表
				 </label>
				 <label class="checkbox-inline i-checks col-lg-2">
					 <input type="checkbox" name="isrectip"  value="5"  class="form-control">  <i></i> 气象仪
				 </label>
				 <label class="checkbox-inline i-checks col-lg-2">时间提前量(分钟)</label>
				 <div class="col-lg-2">
					 <input type="text" name="leadvalue" class="input-sm form-control" />
				 </div>
			 </div>
		 </div>
		 <div class="form-group">
			 <div class="col-lg-7" id="bpstationConfig" style="z-index: 10;margin-top: 20px;display: none;">
				 <button type="button" ng-click="cancelBpstationConfig()" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ><strong>取消</strong></button>
				 <button type="button" ng-click="saveBpstationConfig();" data-loading-text="保存中..." autocomplete="off" class="m-l-sm pull-right  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
			 </div>
		 </div>
	 </div> 
	
	<!-- 通讯中断 显示 -->
	<div id="communicationTile" class="no-padder col-sm-12" style="margin: -50px 0 0; border-top: 50px solid transparent;">
		<h4 class="modal-title modal-header ">通讯中断配置</h4>
	</div>
	 <div id="faultTimeoutCfg" class="col-lg-12">
			 <div class="form-group  col-lg-12 m-t-md">
			 	<div class="col-lg-5">
	             	<label class="col-lg-3 no-padder control-label">电站超时(s)</label>
	             	<div class="col-lg-3 no-padder black-4" ng-bind="Timeout.stimeoutvalue">343</div>
	             	 <label class="col-lg-5 control-label text-right">设备超时(s)</label>
		             <div class="col-lg-1 no-padder black-4" ng-bind="Timeout.dtimeoutvalue">43434</div>
	             </div>
		          
		        <div class="col-lg-6 m-t-xs text-right" style="z-index: 1;">
						<a ng-click="TimeoutCgfEdit('faultTimeoutCfg','faultTimeoutCfgEdit')">
							<span class="icon-pencil font_color m-t-xs"></span>
			              	<span  class="font_color m-t-xs text-right">编辑</span>
	              	   </a>
			   </div> 
			 </div>
	</div> 
	
	<!-- 通讯中断 编辑 -->
			<div id="faultTimeoutCfgEdit" class="wrapper hidden col-lg-12">
			 <form class="s-example form-horizontal ng-pristine ng-valid" action="${ctx}/FaultTimeoutCgf/update.htm" method="post" id="editFaultTimeoutCgfForm" name="editFaultTimeoutCgfForm">
			 <div class="col-lg-12 m-t-md">
			   <div class="form-group  col-lg-12 m-t-md">
				    <label class="col-lg-2 control-label ">电站超时(s)</label>
		             <div class="col-lg-2 no-padder">
		              <input type="text" id ="stimeoutvalue" maxlength="9" name ="stimeoutvalue"  placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control"/>
		             </div>
		             <label class="col-lg-2 control-label ">设备超时(s)</label>
		             <div class="col-lg-2 no-padder">
		                  <input type="text" id ="dtimeoutvalue" maxlength="9" name ="dtimeoutvalue"  placeholder="请输入数字类型" onkeyup="value=value.replace(/[^\-?\d.]/g,'')" class="form-control"/>
		             </div>
		                  <input type="hidden" type="text" id ="TimeoutId" name="id"/>
		                  <input type="hidden" type="text" id ="TimeoutPstationId" name="pstationid"/>
	           </div> 
		        <div class="form-group" >
             	   <div class="col-lg-7" style="z-index: 10;">   
	                	<button type="button" onclick="exitSaveExpiryEdit('faultTimeoutCfgEdit','faultTimeoutCfg', this)" id="faultTimeoutBtn" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" ><strong>取消</strong></button>
	                	<button type="button" onclick="SaveFaultTimeoutCgf();" id="saveFaultTimeoutButton" data-loading-text="保存中..." autocomplete="off" class="m-l-sm pull-right  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 	   </div>
   			 	</div>
	        </div>
		  </form>	
		</div>
	
	<!-- 气象仪 显示 -->
	<div id="weatherConfigTile" class="no-padder col-sm-12" style="margin: -50px 0 0; border-top: 50px solid transparent;" >
		<h4 class="modal-title modal-header">气象仪配置</h4>
	</div>
	 <div id="weather" class="wrapper  col-lg-12" >
			 <div class="form-group  col-lg-12 m-t-md">
			 	   <div class="col-lg-6">
		             	<!-- <label class="col-lg-3  control-label">电站名称</label>
		             	<div class="col-lg-3 no-padder black-4" ng-bind="weatherData.pstationStr"></div> -->
		             	<label class="col-lg-3 control-label text-right">气象仪类型</label>
		                <div class="col-lg-3 no-padder black-4" ng-bind="weatherData.weatherdetailStr"></div>
	             	</div>
	             	
	             	<div class="col-lg-5">
	             		<label class="col-lg-3 control-label text-right">是否引用</label>
			             <div class="col-lg-1 no-padder black-4" ng-bind="weatherData.isborrowStr"></div>
		             	 <%--<label class="col-lg-4 control-label text-right">引用电站</label>--%>
		             	 <%--<div class="col-lg-2 no-padder black-4" ng-bind="weatherData.pstationStr"></div>--%>
		            </div> 
		            
			         <div class="col-lg-1 m-t-xs text-right">
							<a ng-click="weatherEdit('weather','weatherEdit')">
								<span class="icon-pencil font_color m-t-xs"></span>
				              	<span  class="font_color m-t-xs text-right">编辑</span>
		              	   </a>
				   	</div>
			 </div>
			  <div class="form-group  col-lg-12 m-t-md">
	             <%--<div class="col-lg-5">--%>
		              <%--<label class="col-lg-3 no-padder control-label" >引用气象站</label>--%>
			          <%--<div class="col-lg-3 no-padder black-4" ng-bind="weatherData.borrowdeviceidStr"></div>--%>
	         	 <%--</div>--%>
		     </div>
	</div> 
	
	<!-- 气象仪 编辑 -->
	<div id="weatherEdit"  class="wrapper hidden  col-lg-12">
	 <form class="s-example form-horizontal ng-pristine ng-valid" action="${ctx}/CfgWeather/update.htm" method="post" id="weatherForm" name="weatherForm">
	 <div class="col-lg-12 m-t-md">
	    <div class="form-group  col-lg-12 m-t-md">
		     <!-- <label class="col-lg-2 control-label ">电站名称</label>
             <div class="col-lg-2 no-padder">
             	<input type="text" readonly="readonly" id="pstationidStr"  class="form-control formData">
             </div> -->
             <label class="col-lg-2 control-label ">是否引用</label>
             <label class="checkbox-inline i-checks">
				 <input type="radio" ng-click="isborrowResult()" name="isborrow" id="isborrow1" value="1" checked="checked" 
					class="form-control"> <i></i> 是
			</label> 
			<label class="checkbox-inline i-checks">
				 <input type="radio" ng-click="isborrowResult()" name="isborrow" id="isborrow2" value="0" 
					class="form-control "> <i></i> 否
			</label>
        </div>

		 <div class="form-group  col-lg-12 m-t-md borrowBox" id="borrowBox1">
			 <label class="col-lg-1 control-label "></label>
			 <div class="col-lg-7">
				 <table id="result_table" class="table table-striped b-t b-light">
					 <thead>
						 <tr>
							 <th style="width: 20px;"></th>
							 <th>周边距离</th>
							 <th>水平光照</th>
							 <th>斜面光照</th>
						 </tr>
					 </thead>
					 <tbody >
						 <tr ng-repeat="around in aroundData" class="arround">
							 <td>
								 <label class="i-radio m-b-none">
									 <input type="radio" name="aroundid" stid="{{around.psId}}" eqid="{{around.aerographId}}" />
								 </label>
							 </td>
							 <td ng-bind="around.distance[0]+around.distance[1]">-</td>
							 <td ng-bind="around.planeLuminousIntensity[0]+around.planeLuminousIntensity[1]">-</td>
							 <td ng-bind="around.inclineLuminousIntensity[0]+around.inclineLuminousIntensity[1]">-</td>
						 </tr>
					 </tbody>
				 </table>
			 </div>
		 </div>

        <div class="form-group  col-lg-12 m-t-md borrowBox" id="borrowBox0" style="display:none;">
	    <label class="col-lg-2 control-label ">引用电站</label>
            <div class="col-lg-2 no-padder">
           		<ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textStationChange()">
           		   <ui-select-match
					  placeholder="请输入关键字..." ng-model="stationd.selected.stationname">{{$select.selected.stationname}}
				   </ui-select-match>
				   <ui-select-choices repeat="item in station | filter: $select.search">
				     <div ng-bind-html="item.stationname | highlight: $select.search"></div>
				   </ui-select-choices> 
				</ui-select>
			<input type="hidden" id="borrowpstationid" name="borrowpstationid" class="form-control formData">
            </div>
            
            <label class="col-lg-2 control-label ">引用气象站</label>
            <div class="col-lg-2 no-padder">
               <ui-select ng-model="weather.selected" theme="bootstrap" ng-change="textweatherChange()">
           		   <ui-select-match
					  placeholder="请输入关键字..." ng-model="weather.selected.name">{{$select.selected.name}}
				   </ui-select-match>
				   <ui-select-choices repeat="item in weather | filter: $select.search">
				     <div ng-bind-html="item.name | highlight: $select.search"></div>
				   </ui-select-choices> 
			   </ui-select>
            <input type="hidden" id="borrowdeviceid" name="borrowdeviceid" class="form-control formData">
            </div>
       </div> 
       
         <div class="form-group  col-lg-12 m-t-md">
	    <label class="col-lg-2 control-label ">气象仪类型</label>
            <div class="col-lg-10 no-padder">
            	     <label class="checkbox-inline i-checks">
				 <input type="radio" name="weatherdetail" id="weatherdetail1" value="0" checked="checked" onclick="getManufactureList(this.value)"
					class="form-control"> <i></i> 水平
			</label> 
			<label class="checkbox-inline i-checks">
				 <input type="radio" name="weatherdetail" id="weatherdetail2" value="1" onclick="getManufactureList(this.value)"
					class="form-control "> <i></i> 斜面
			</label>
			<label class="checkbox-inline i-checks">
				 <input type="radio" name="weatherdetail" id="weatherdetail3" value="2" onclick="getManufactureList(this.value)"
					class="form-control "> <i></i> 散射
			</label>
            </div>
            <input type="hidden" type="text" name="pstationid" id="weatherpstationid" >
            <input type="hidden" type="text" name="id" id="weatherid" >
       </div> 
       
        <div class="form-group">
           	   <div class="col-lg-7" style="z-index: 2;">   
               	<button type="button" onclick="exitSaveExpiryEdit('weatherEdit','weather', this)" id="exitweatherBtn" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default"><strong>取消</strong></button>
               	<button type="button" onclick="SaveweatherForm();" id="saveWeatherButton" data-loading-text="保存中..." autocomplete="off" class="m-l-sm pull-right  btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
 			 	   </div>
 		</div>
       </div>
  </form>	
</div>
	
	
<!---------------------------------------	设备台账       ----------------------------------->
	<div id="busConfigTile"  class="col-lg-12 no-padder" style="margin: -50px 0 0; border-top: 50px solid transparent;">
		<div  class="col-lg-12 modal-title modal-header">
			<div ng-include="'${ctx}/tpl/ledgerPage/powerStationView/fileUpload.jsp'" class="list_top"></div>
			<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">总线配置</span>
			<a><span onclick="fileUpload('fileUpload');"  class="font-h3 blue-1 fa fa-arrow-circle-up p-r-5 font_color">导入</span></a>
		</div>
	</div>
	<!--箱变 -->
	<div id="showDeviceRunData" class="m-t-xs">
		<div id="boxChange" class="list_top col-lg-12" ng-include="'${ctx}/tpl/ledgerPage/pstationConfig/pbuscfg/PBuscfgList.jsp'" ></div>
	</div>

	<!-------------------------      电站监控点配置     ------------------------------------>
	<div id="videoConfigTile"  class="col-lg-12 no-padder">
		<div  class="col-lg-12 modal-title modal-header">
			<span class="font-h3 blue-1" style="padding-right: 7px; font-size:18px;">视频监控点配置</span>
		</div>
	</div>
	<div class="m-t-xs">
		<div class="list_top col-lg-12" ng-include="'${ctx}/tpl/ledgerPage/videoconfig/listVideoConfig.jsp'" ></div>
	</div>
	
	
	<!-- 协议配置 -->
	<div id="protocolConfigTitle" class="no-padder col-sm-12" style="margin: -50px 0 0; border-top: 50px solid transparent;">
		<h4 class="modal-title modal-header ">协议配置</h4>
	</div>
	 <div id="protocolConfig" class="col-lg-12">
			 <div class="form-group  col-lg-12 m-t-md">
			 	<div class="col-lg-12">
	             	<label class="col-lg-3 no-padder control-label">汇流箱(还剩{{allProtocolList.data.noprotocol1}}台未配置):</label>
	             	<span  ng-repeat="bcp in allProtocolList.data['1']" >
							<a  ng-click="editProtocolConfig('1',bcp.productId,bcp.protocolid,bcp.pname,bcp.name)">{{bcp.pname}}-{{bcp.name}}({{bcp.num}})</a>
					</span>
	             </div>
			 </div>
			 <div class="form-group  col-lg-12 m-t-md">
			 	<div class="col-lg-12">
	             	<label class="col-lg-3 no-padder control-label">逆变器(还剩{{allProtocolList.data.noprotocol2}}台未配置):</label>
	             	<span  ng-repeat="bcp in allProtocolList.data['2']" >
							<a ng-click="editProtocolConfig('2',bcp.productId,bcp.protocolid,bcp.pname,bcp.name)">{{bcp.pname}}-{{bcp.name}}({{bcp.num}})</a>
					</span>
	             </div>
			 </div>
			 <div class="form-group  col-lg-12 m-t-md">
			 	<div class="col-lg-12">
	             	<label class="col-lg-3 no-padder control-label">箱变(还剩{{allProtocolList.data.noprotocol3}}台未配置):</label>
	             	<span  ng-repeat="bcp in allProtocolList.data['3']" >
							<a  ng-click="editProtocolConfig('3',bcp.productId,bcp.protocolid,bcp.pname,bcp.name)">{{bcp.pname}}-{{bcp.name}}({{bcp.num}})</a>
					</span>
	             </div>
			 </div>
			 <div class="form-group  col-lg-12 m-t-md">
			 	<div class="col-lg-12">
	             	<label class="col-lg-3 no-padder control-label">电表(还剩{{allProtocolList.data.noprotocol4}}台未配置):</label>
	             	<span  ng-repeat="bcp in allProtocolList.data['4']" >
							<a  ng-click="editProtocolConfig('4',bcp.productId,bcp.protocolid,bcp.pname,bcp.name)">{{bcp.pname}}-{{bcp.name}}({{bcp.num}})</a>
					</span>
	             </div>
			 </div>
			 <div class="form-group  col-lg-12 m-t-md">
			 	<div class="col-lg-12">
	             	<label class="col-lg-3 no-padder control-label">气象站(还剩{{allProtocolList.data.noprotocol5}}台未配置):</label>
	             	<span  ng-repeat="bcp in allProtocolList.data['5']" >
							<a  ng-click="editProtocolConfig('5',bcp.productId,bcp.protocolid,bcp.pname,bcp.name)">{{bcp.pname}}-{{bcp.name}}({{bcp.num}})</a>
					</span>
	             </div>
			 </div>
	</div> 
	<div id="addProtocolConfig" data-ng-include="'${ctx}/tpl/ledgerPage/pstationConfig/protocolConfig.jsp'"></div>
</div>
</div>
</div>
</div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<script type="text/javascript">

/*******************************************************电站初始量更新及事件操作代码区 ********************************************/
$(function() {
	$("#editExpiryForm").validate( {
		rules : {
			totaltw:{
				number: true,
				maxlength : 14,
				required : true
			},
			yeartw:{
				number: true,
				maxlength : 14,
				required : true
			},
			monthtw:{
				number: true,
				maxlength : 14,
				required : true
			}
		},
		submitHandler : function(form) {
			var options = {
				dataType : "json",
				success : function(json) {
					if(json.type=="error"){
						promptObj(json.type,'',json.message);
// 						$("#showhint").removeClass('hidden');
					}else{
						promptObj(json.type,'',json.message);
						$("#exitExpiry").trigger('click');
						findExpiryData($("#pstationid").val());
					}
				},
				error : function(json) {
						promptObj("error", '',"操作失败,请稍后重试");
						$("#exitExpiry").trigger('click');
				}
			};
			$('#editExpiryForm').ajaxSubmit(options);
		}
	});
});


function SaveExpiry(expiryId){
	$btn = $("#saveExpiry");
	//判断截止日期是否为空，为空则初始值全部为空，不为空则初始值至少一个有值
	var expiryValue=$("#expirydated").val();
	var totaltwValue=$("#totaltwd").val();
	var yeartwValue=$("#yeartw").val();  
	var monthtwValue=$("#monthtw").val();  
	if(expiryValue){
		if(totaltwValue || yeartwValue || monthtwValue){
			$btn.button('loading');
			$("#editExpiryForm").trigger("submit");
		}else {
			tymvalidat();
		}
	}else{
		if(totaltwValue=="" && yeartwValue=="" && monthtwValue==""){
			expiryVerify();
			 tymvalidat();
		}else if(totaltwValue !=""){
			expiryVerify();
		}else if(yeartwValue !=""){
			expiryVerify();
		}else if( monthtwValue !=""){
			expiryVerify();
		}
	}
}

function tymvalidat(){
	//$("#total").html("累计发电量 、或年发电量 、 或月发电量 ,不为空");
	$("#totalimg").attr("src","images/validator/check_n.gif");
	$("#totaltwd").css("border-color","#FF0000");
	$("#yeartwd").css("border-color","#FF0000");
	$("#monthtwd").css("border-color","#FF0000");
}

function expiryVerify(){
	$("#expiryverify").html("截止日期不可为空");
	$("#expiryverifyimg").attr("src","images/validator/check_n.gif");
	$("#expirydate").css("border-color","#FF0000");
}

function cllarverify(){
	var expiryValue=$("#expirydated").val();
	var totaltwValue=$("#totaltwd").val();
	var yeartwValue=$("#yeartwd").val();  
	var monthtwValue=$("#monthtwd").val(); 
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

//日期控件
$('#expirydated').datetimepicker({
	format : "yyyy-mm-dd",
	minView : 2,
	language : 'zh-CN',
	todayHighlight : true,
	todayBtn : true,
	//startDate : new Date(),
	autoclose : true
});


//取消编辑
function exitSaveExpiryEdit(att,remove, obj){
	$(obj).next().button('reset');
	$("#"+att).attr("class","hidden"); ;
	$("#"+remove).removeClass("hidden");
	$(".formData").val("");
}

function dateFormat(date) {
	var time = new Date(date).Format("yyyy-MM-dd");
	return time;
}

//检查数据完整性
function checkBugCfgData() {
	if(!$("#pstationid").val()){
		alert("未配置电站基本信息");
	}else{
		$.ajax({
				type : "post",
					url : "${ctx}/BusCfg/checkBugCfgData.htm",
					data : {
						"pstationid" : $("#pstationid").val()
					},success : function(json) {
						alert(json.message);
// 						promptObj(json.type, '',json.message);
					},
					error : function(json) {
						promptObj("error", '',"操作失败,请稍后重试");
					}
				});
	    	} 
		}

function changeCss(flag){
	$("#ids"+flag).children().addClass("menuCss")
	$("#ids"+flag).siblings().children().removeClass("menuCss")
}
function upadteImg(type){
	
	if(type==1){
		$("#powerPriceImg").attr("src","${ctx}/theme/images/powerPriceS.png");
		$("#communicationImg").attr("src","${ctx}/theme/images/communicationS.png")	;
		$("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographS.png");
		$("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographS.png");
        $("#videoConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");

		$("#initPowerImg").attr("src","${ctx}/theme/images/initPowerSe.png");
	}else if(type==2){
		$("#initPowerImg").attr("src","${ctx}/theme/images/initPowerS.png");
		$("#communicationImg").attr("src","${ctx}/theme/images/communicationS.png")	;
		$("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographS.png");
		$("#busConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");
        $("#videoConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");

		$("#powerPriceImg").attr("src","${ctx}/theme/images/powerPriceSe.png");
	}else if(type==3){
		$("#initPowerImg").attr("src","${ctx}/theme/images/initPowerS.png");
		$("#powerPriceImg").attr("src","${ctx}/theme/images/powerPriceS.png");
		$("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographS.png");
		$("#busConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");
        $("#videoConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");
		
		$("#communicationImg").attr("src","${ctx}/theme/images/communicationSe.png");
	}else if(type==4){
		$("#initPowerImg").attr("src","${ctx}/theme/images/initPowerS.png");
		$("#powerPriceImg").attr("src","${ctx}/theme/images/powerPriceS.png");
		$("#communicationImg").attr("src","${ctx}/theme/images/communicationS.png");
		$("#busConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");
        $("#videoConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");
		
		$("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographSe.png");
	}else if(type==5){
		$("#initPowerImg").attr("src","${ctx}/theme/images/initPowerS.png")	;
		$("#powerPriceImg").attr("src","${ctx}/theme/images/powerPriceS.png");
		$("#communicationImg").attr("src","${ctx}/theme/images/communicationS.png");
		$("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographS.png");
        $("#videoConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");
		
		$("#busConfigTileImg").attr("src","${ctx}/theme/images/busCfgSe.png");
	}else if(type==6){
        $("#initPowerImg").attr("src","${ctx}/theme/images/initPowerS.png");
        $("#powerPriceImg").attr("src","${ctx}/theme/images/powerPriceS.png");
        $("#communicationImg").attr("src","${ctx}/theme/images/communicationS.png");
        $("#weatherConfigImg").attr("src","${ctx}/theme/images/aerographS.png");
        $("#busConfigTileImg").attr("src","${ctx}/theme/images/busCfgS.png");

        $("#videoConfigTileImg").attr("src","${ctx}/theme/images/busCfgSe.png");
    }
}
/*******************************************电价配置*************************************************/






/**************************************** 通讯中断更新操作及事件代码区********************************************/
$("#editFaultTimeoutCgfForm").validate( {
	rules : {
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
				if(json.type=="error"){
					promptObj(json.type,'',json.message);
//					$("#showhint").removeClass('hidden');
				}else{
					promptObj(json.type,'',json.message);
					$("#faultTimeoutBtn").trigger('click');
					findFaultTimeoutCgfData($("#pstationid").val());
				}
			},
			error : function(json) {
					promptObj("error", '',"操作失败,请稍后重试");
					$("#faultTimeoutBtn").trigger('click');
			},
		};
		$("#saveFaultTimeoutButton").button('loading');
		$('#editFaultTimeoutCgfForm').ajaxSubmit(options);
	}
});
	
//submit 事件	
function SaveFaultTimeoutCgf(){
	$("#editFaultTimeoutCgfForm").trigger("submit"); 
}


/**************************************** 气象引用更新及事件操作代码区********************************************/
$("#weatherForm").validate( {
	rules : {
// 		stimeoutvalue:{
// 			required: true,
// 			maxlength : 9	
// 		},
// 		dtimeoutvalue:{
// 			required: true,
// 			maxlength : 9
// 		}
	},
	submitHandler : function(form) {
		var options = {
			dataType : "json",
			success : function(json) {
				if(json.type=="error"){
// 					promptObj(json.type,'',json.message);
//					$("#showhint").removeClass('hidden');
				}else{
					promptObj(json.type,'',json.message);
					$("#exitweatherBtn").trigger('click');
					findweatherataData($("#pstationid").val());
					
				}
			},
			error : function(json) {
					promptObj("error", '',"操作失败,请稍后重试");
					$("#exitweatherBtn").trigger('click');
			},
		};
		$('#weatherForm').ajaxSubmit(options);
	}
});
	
//submit 事件	
function SaveweatherForm(){
	var isborrow = $("input[name='isborrow']:checked").val();
	if(isborrow == 1){
		var arroundid = $("#borrowBox1 input[name='aroundid']:checked");
		if(arroundid.length == 0){
			alert("请选择气象站");
			return;
		}
		$("#borrowpstationid").val(arroundid.attr("stid"));
		$("#borrowdeviceid").val(arroundid.attr("eqid"));
	}else{
		if($("#borrowdeviceid").val() == "" ||
				$("#borrowdeviceid").val() == null){
			alert("请选择气象站");
			return;
		}
	}
	$("#saveWeatherButton").button('loading');
	$("#weatherForm").trigger("submit"); 
}


var findExpiryData;
var findFaultTimeoutCgfData;
var findweatherataData;
var isborrowResult;
app.controller('powerStationConfig',
		['$http', '$location', '$rootScope', '$scope', '$state', '$stateParams',
		 function($http, $location, $rootScope, $scope, $state, $stateParams){
			
			$scope.getCurrentDataName('03',0);
			//切换电站
			$scope.$on('broadcastSwitchStation', function(event, data) {
				$("#currentDataName1").html(data.dataName);
				$stateParams.inId = data.dataId;
				$("#pstationid").val($stateParams.inId);
				$scope.pstationid = $stateParams.inId;
				$scope.findExpiryData($("#pstationid").val());
				$scope.findFaultTimeoutCgfData($("#pstationid").val());	
				$scope.findweatherataData($("#pstationid").val());
				
		    });
			if(!$stateParams.inId){
				$("#switchPowerModalId").show();
				 $http({
						method : "POST",
						url : "${ctx}/UserAuthHandle/getCurrentInfo.htm",
						params: {
						}
					}).success(function(response) {
						$stateParams.inId = response.currentSTID;
						$("#pstationid").val($stateParams.inId);
						$scope.pstationid = $stateParams.inId;
						if(response.currentSTName){
							$("#currentDataName1").html(response.currentSTName);
						}
					});
			}else{
				// 电站Id获取入口
				$("#pstationid").val($stateParams.inId);
				$scope.pstationid = $stateParams.inId;
				$http({
					method : "POST",
					url : "${ctx}/PowerStation/selectById.htm",
					params : {
						'id' : $scope.pstationid,
					}
				}).success(function(result) {
					if(result.stationname){
		       			$("#currentDataName1").html(result.stationname);
		       		}
				});
			}
			
			
            
/******************************* 电量初始值数据查询 ****************************************************************/
		findExpiryData=$scope.findExpiryData = function(pstationid) {
				$http({
					method : "POST",
					url : "${ctx}/Expirytw/selectByStationId.htm",
					params : {
						'pstationid' : pstationid,
					}
				}).success(function(result) {
				  		$scope.vo=result;
				  		$("#totaltwd").val(result.totaltw)
				  		$("#yeartwd").val(result.yeartw)
				  		$("#monthtwd").val(result.monthtw)
				  		$("#pstationidExpiry").val(result.pstationid)
				  		$("#idExpiry").val(result.id)
				  		if(result.expirydate){
				  		$("#expirydated").val(dateFormat(result.expirydate))
				  		}
					})
				};
		
		$scope.findExpiryData($("#pstationid").val());			
		
//编辑电量初始值
$scope.expiryEdit=function(att,remove){
	$("#"+remove).removeClass("hidden");
	$("#"+att).attr("class","hidden");
	$scope.findExpiryData($("#pstationid").val());
}

/******************************************************** 通讯中断****************************************************/
	//数据查询
	findFaultTimeoutCgfData=$scope.findFaultTimeoutCgfData = function(pstationid) {
		$http({
			method : "POST",
			url : "${ctx}/FaultTimeoutCgf/selectByStationId.htm",
			params : {
				'pstationid' : pstationid,
			}
		}).success(function(result) {
		  		$scope.Timeout=result;
		  		$("#stimeoutvalue").val(result.stimeoutvalue);
		  		$("#dtimeoutvalue").val(result.dtimeoutvalue);
		  		$("#TimeoutPstationId").val(result.pstationid);
		  		$("#TimeoutId").val(result.id);
		  		
			})
		};

$scope.findFaultTimeoutCgfData($("#pstationid").val());

//后台运行配置
$scope.bpstationConfigData = null;
$scope.initBpstationConfigEdit = function () {
	$http({
		method : "POST",
		url : "${ctx}/BpstationConfig/queryBpstationConfig.htm",
		params : {
			'pstationid' : $("#pstationid").val()
		}
	}).success(function(result) {
		if (result.key == 0){
			$scope.bpstationConfigData = result.data;
			$("input[name='leadvalue']").val($scope.bpstationConfigData.leadvalue);
			var isrectip = $scope.bpstationConfigData.isrectip.split(",");
			for (var i=0,ii=isrectip.length;i<ii;i++){
				$("input[name='isrectip'][value='"+isrectip[i]+"']").attr("checked", true);
			}
			return;
		}
		promptObj('error', '',result.msg);
	});
};
$scope.initBpstationConfigEdit();
$scope.BpstationConfigEdit = function () {
	$scope.initBpstationConfigEdit();
	$("#bpstationConfig").show();
	$("#bpstationConfigEditButton").hide();
};
$scope.cancelBpstationConfig = function () {
	$("#bpstationConfig").hide();
	$("#bpstationConfigEditButton").show();
};
$scope.saveBpstationConfig = function () {
	var isrectip = [], leadvalue;
	$("input[name='isrectip']:checked").each(function () {
		isrectip.push($(this).val());
	});
	if (isrectip.length == 0){
		alert("请选择设备类型");
		return;
	}
	leadvalue = $("input[name='leadvalue']").val();
	if (leadvalue == null || leadvalue == ""){
		alert("请输入时间提前量");
		return;
	}

	$http({
		method : "POST",
		url : "${ctx}/BpstationConfig/updateBpstationConfig.htm",
		params : {
			'pstationid' : $("#pstationid").val(),
			'isrectip': isrectip.join(","),
			'leadvalue': leadvalue
		}
	}).success(function(result) {
		if (result.key == 0){
			promptObj('success', '', result.msg);
			$scope.initBpstationConfigEdit();
			$("#bpstationConfig").hide();
			$("#bpstationConfigEditButton").show();
			return;
		}
		promptObj('error', '',result.msg);
	});
};

//通讯编辑事件
$scope.TimeoutCgfEdit=function(att,remove,type){
	$("#"+remove).removeClass("hidden");
	$("#"+att).attr("class","hidden");
	$scope.findFaultTimeoutCgfData($("#pstationid").val());
};


/****************************************************气象数据查询*****************************************************************/
 	findweatherataData=$scope.findweatherataData=function(pstationid){
		$http({
			method : "POST",
			url : "${ctx}/CfgWeather/selectByStationId.htm",
			params : {
				'pstationid' : pstationid,
			}
		}).success(function(result) {
		  		$scope.weatherData=result;
		  		$("#weatherid").val(result.id);
				$("#weatherpstationid").val(pstationid);
		  		$("#borrowpstationid").val(result.borrowpstationid);
		  		$("#borrowdeviceid").val(result.borrowdeviceid);
		  		$("#pstationidStr").val(result.pstationStr)
				var isborrow =result.isborrow;
		  		if (isborrow) {
					var ridaolen = document.weatherForm.isborrow.length;
					for (var i = 0; i < ridaolen; i++) {
						if (isborrow == document.weatherForm.isborrow[i].value) {
							document.weatherForm.isborrow[i].checked = true;
							if(isborrow==0){
								$scope.isborrowResult();
							}
						}else{
							
						}		$scope.isborrowResult();
					}
				}

				if(isborrow == 1){
					$("#borrowBox1 input[name='aroundid'][stid='"+result.borrowpstationid+"']")
							.attr("checked", "checked");
				}
		  		
		  		var weatherdetail=result.weatherdetail
		  		if(weatherdetail){
		  			var weatherridaolen = document.weatherForm.weatherdetail.length;
					for (var i = 0; i < weatherridaolen; i++) {
						if (weatherdetail == document.weatherForm.weatherdetail[i].value) {
							document.weatherForm.weatherdetail[i].checked = true;
						}
					}
		  		}
// 		  		 $scope.getStationData();
		  		 $scope.getWeather($("#pstationid").val());
			})
		}; 

	$scope.findweatherataData($("#pstationid").val());
	
	//气象编辑事件
	$scope.weatherEdit=function(att,remove,type){
		$("#"+remove).removeClass("hidden");
		$("#"+att).attr("class","hidden");
		$scope.findweatherataData($("#pstationid").val());

		$http({
			method : "POST",
			url : "${ctx}/MobileHmDeviceMonitor/getStationWeaterAround.htm",
			params : {
				'powerStationId':$("#pstationid").val()
			}
		}).success(function (msg) {
			if(msg==null){
				//无数据
				return;
			}
			$scope.aroundData=msg.list;
		}).error(function(msg){
			return
		});
	};
	
	//是否引用事件
	isborrowResult=$scope.isborrowResult=function(){
		var isborrowValue=$("input[name='isborrow']:checked").val();
		if(isborrowValue==0){
			//电站
			$scope.getStationData($("#pstationid").val());
			$("#borrowpstationid").val($("#pstationid").val());
			//气象站
			$scope.getWeather($("#pstationid").val());
		}else{
			$scope.getStationData();
		}
		$(".borrowBox").hide();
		$("#borrowBox"+isborrowValue).show();
	}


	
	
	
	
	
	
	
/************************************************气象仪配置 电站下拉,气象站下拉 查询**************************************************/
			$scope.stationd = {};
	    	$scope.station = null;
	    	
	    	$scope.getStationData = function(id){
			$http({method:"POST",
					url:"${ctx}/PowerStation/selectAll.htm",
					params:{
					id: id
						}
				}).success(function (result) {
					$scope.station = result;
					if($scope.station !=null&&$scope.station.length>1){
						$scope.station.unshift({id:"",stationname:'请选择'});
					}
					if($("#borrowpstationid").val()!=null&&$("#borrowpstationid").val()!=""){
						for(var i=0,len=$scope.station.length;i<len;i++){
							if($scope.station[i].id==  $("#borrowpstationid").val()){
								$scope.stationd.selected= { stationname: $scope.station[i].stationname,id:  $("#borrowpstationid").val()};
												  break;
							}else{
								$scope.stationd.selected= { stationname: $scope.station[0].stationname,id:  $scope.station[0].id};
							}
						}
					} else {
							$scope.stationd.selected= { stationname: $scope.station[0].stationname,id:  $scope.station[0].id};
					}
				$("#borrowpstationid").val( angular.copy($scope.stationd.selected.id));
				$scope.textStationChange= function () {
			         $("#borrowpstationid").val( angular.copy($scope.stationd.selected.id));
			         $scope.getWeather($scope.stationd.selected.id);
			         $("#borrowdeviceid").val("");
				} 
			}); 
	    }		
		    	

/************************************************气象设备查询**入参:电站Id*************************************************/
		    	 	$scope.weather = {};
			    	$scope.weather = null;
			    	
			    	$scope.getWeather = function(pstationid){
			    		if(pstationid){
					$http({method:"POST",
							url:"${ctx}/OtherDevice/selectAll.htm",
							params:{
							pstationid:pstationid,
							devicetype:5
								    }
						}).success(function (result) {
						$scope.weather = result;
						if($scope.weather !=null&&$scope.weather.length>0){
							$scope.weather.unshift({id:"",name:'请选择'});
						}
						if($("#borrowdeviceid").val()!=null&&$("#borrowdeviceid").val()!=""){
			 				for(var i=0,len=$scope.weather.length;i<len;i++){
			 					if($scope.weather[i].serialnumber==  $("#borrowdeviceid").val()){
			 						$scope.weather.selected= { name: $scope.weather[i].name,id:  $("#borrowdeviceid").val()};
			 					}
			 				}
						} else {
								$scope.weather.selected= { name: $scope.weather[0].name,id:  $scope.weather[0].serialnumber};
						}
				    	 $scope.textweatherChange= function () {
					         $("#borrowdeviceid").val( angular.copy($scope.weather.selected.serialnumber));
						} 
					}); 
			    }else{
			    	$scope.weather=null;
			    	$("#borrowdeviceid").val("");
			    }	
			 }
			    	
/************************************************协议配置*************************************************/
			    	
			$scope.editProtocolConfig=function(deviceType,productId,protocolId,pname,name){
				var  msg = {};
				msg.deviceType=deviceType;
				msg.pstationid=$("#pstationid").val();
				msg.protocolId=protocolId;
				msg.pname=pname;
				msg.name=name;
				msg.productId=productId;
				$scope.$broadcast('broadcastProtocolConfig', msg);
				$('#protocolConfigList').modal('show');
				
			}   	
			 
			$scope.queryAllProtocolConfig = function(){
				$http({method:"POST",
					url:"${ctx}/BpstationConfig/queryAllProtocolConfig.htm",
					params:{
						pstationid:$("#pstationid").val(),
					}
				}).success(function (result) {
					$scope.allProtocolList = result;
				});
			}
			$scope.queryAllProtocolConfig();
			    	
		}]);

</script>
