<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/controllers/file-upload.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>

<div ng-controller="ProducePlanAddCtrl">
	<div class="wrapper-md bg-light b-b">
		<span class="font-h3 blue-1 m-n text-black">填写生产计划</span>
	</div>
	<div class="wrapper-md ng-scope">
		<div class="col-sm-2 padder-r-sm " style="padding:0px">
			<div class="col-sm-12  no-padder">
				<div class="input-group p-r-sm">
					<select ng-model="year" id="year" class="form-control input-sm" ng-change="changeYear()">
			        	<option ng-repeat="vo in yearList" value="{{vo}}"  ng-selected="year == vo">{{vo}}年</option>
			        </select>
		        </div>
	        </div>
	       <!--  
			<div id="yearSelect" class="col-sm-12 no-padder " style="background-color: #4697CF;"  onclick="selectYear()">
           		<div style="height: 90px;width: 70%;float: left;padding: 18px">
           			<font class="font-h2 white-1">年</font>
           			<br>
           			<font id="yearFont" class="font-h white-1">请选择</font>
           		</div>
           		<div style="height: 90px;width: 30%;float: left;background-color: #428DC4;text-align: center;">
           			<img alt="" src="${ctx}/theme/images/producePlan/year.png" style="margin-top: 28px">
           		</div>
           	</div>
           	<div id="yearDiv" class="col-sm-12 " style="line-height:90px;height: 90px;background-color: #4697CF;display: none;">
           		<div id="year2015" class="unSelect" onclick="year('2015')">
           			<font class="font-h3">2015</font>
           		</div>
           		<div id="year2016" class="unSelect" onclick="year('2016')">
           			<font class="font-h3">2016</font>
           		</div>
           		<div id="year2017" class="unSelect" onclick="year('2017')">
           			<font class="font-h3">2017</font>
           		</div>
           	</div>
           	-->
		</div>
           	<!--  
            	<div class="col-sm-4 padder-r-sm " style="padding:0px">
           	<div id="companySelect" class="col-sm-12 no-padder "  style="background-color: #40B5BF;" onclick="selectCompany()">
           		<div  style="height: 90px;width: 70%;float: left;padding: 18px">
           			<font class="font-h2 white-1">区</font>
           			<br>
           			<font id="companyFont" class="font-h white-1">请选择</font>
           		</div>
           		<div style="height: 90px;width: 30%;float: left;background-color: #3FABB7;text-align: center;">
           			<img alt="" src="${ctx}/theme/images/producePlan/company.png" style="margin-top: 28px">
           		</div>
           	</div>
           	<div id="companyDiv"class="col-sm-12 " style="height: 90px;margin:0px 1.5%;background-color: #40B5BF;padding: 18px;display: none;">
           	</div>
           	</div> 
           	-->
           	<!--  
           <div class="col-sm-4 " style="padding:0px">
           	<div id="pstationidSelect" class="col-sm-12 no-padder "  style="background-color: #8AC149;" onclick="selectPstationid()">
           		<div style="height: 90px;width: 70%;float: left;padding: 18px">
           			<font class="font-h2 white-1">站</font>
           			<br>
           			<font id="pstationidFont" class="font-h white-1">请选择</font>
           		</div>
           		<div style="height: 90px;width: 30%;float: left;background-color: #83B846;text-align: center;">
           			<img alt="" src="${ctx}/theme/images/producePlan/station.png" style="margin-top: 28px">
           		</div>
           	</div>
           	<div id="pstationidDiv" class="col-sm-12 " style="height: 90px;margin:0px 1.5%;background-color: #8AC149;padding: 18px;display: none;">
           		<font class="font-h white-1">请选择区域</font>
           	</div>
           	</div>
           	-->
           	   <div class="col-sm-12 no-padder">
           	   	<span class="pull-right" style=" margin: 15px 5px -15px 0px;">单位:kWh</span>
           	   </div>
           <div class="col-sm-12 no-padder">
		<div class="panel panel-default" style="margin-top: 20px;">
			
		<div class="row">
		<!-- form 开始 -->
		<form class="col-sm-12 form-horizontal ng-pristine ng-valid" action="${ctx}/producePlan/update.htm" method="post" id="editForm" name="editForm" enctype="multipart/form-data">
         	<input type="hidden" name="year" value="{{year}}"/>
         	<input id="company" name="company" type="hidden"/>
         	<input id="pstationid" name="pstationid" type="hidden"/>
         	<table >
         		<tr style="height: 50px;text-align: center;font-size: 16px;color: #6BB497">
         			<th>1月</th>
         			<th>2月</th>
         			<th>3月</th>
         			<th>4月</th>
         			<th>5月</th>
         			<th>6月</th>
         			<th>7月</th>
         			<th>8月</th>
         			<th>9月</th>
         			<th>10月</th>
         			<th>11月</th>
         			<th>12月</th>
         		</tr>
         		<tr  style="height: 80px;text-align: center;font-size: 16px;">
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues0" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues1" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues2" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues3" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues4" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues5" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues6" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues7" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues8" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues9" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues10" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         			<td style="border:1px solid #D8DFE5"><input style="border: 0px;" type="text"  id="plannedvalues11" name="plannedvalues"  onchange="calc2();" class="form-control formData" onkeyup="value=value.replace(/[^\-?\d.]/g,'')"></td>
         		</tr>
         		<tr style="height: 50px;text-align: center;font-size: 14px;">
         		<td >年度总和</td>
         		<td>
         		<span id="totalvalue" name="totalvalue" ></span>
<!--          		<input type="text" id="totalvalue" name="totalvalue"  readonly="readonly" class="form-control formData"> -->
         		</td>
         		</tr>
         	</table>
         </form>
		<!-- form 结束 -->
		<div class="form-group m-t-lg">
            <div class="col-lg-12">
            	<button id="cancelBtn" type="button" class=" m-l-sm pull-right m-r-sm btn m-b-xs w-xs btn-default" ng-click="backProducePlan();"><strong>取消</strong></button>   
                 <button type="button" ng-click="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info"><strong>保 存</strong></button>
   			 </div>
     </div>
     </div>
   </div>
   </div>
   </div>
   </div>
<script type="text/javascript">
	$(function() {
		$("#editForm").validate( {
			rules : {
			},
			submitHandler : function(form) {
				var options = {
					dataType : "json",
					success : function(json) {
						promptObj('success','',json.message);
						$("#cancelBtn").trigger("click");
					},
					error : function(json) {
						$("#errorFlag").trigger('click');
					}
				};
				$('#editForm').ajaxSubmit(options);
			}
		});

	app.controller('ProducePlanAddCtrl', [
				'$http',
				'$location',
				'$rootScope',
				'$scope',
				'$state',
				'$stateParams',
				function($http, $location, $rootScope, $scope, $state,
						$stateParams) {
					$scope.$on('refreshViewDataForHead', function(event, data) {  
						getProducePlanData($scope.year);
				    });
					$scope.backProducePlan = function() {
						$state.go('app.producePlan');
					};
					$scope.saveForm = function() {
						if (!$("#year").val()) {
							promptObj('error', '', '请选择年份');
							return false;
						}
						saveForm();
					};
					$scope.changeYear = function(){
						getProducePlanData($scope.year);
					}
					getYearList($scope, $http);
				} 
	]);
});

	function saveForm() {
		$("#editForm").trigger("submit");
	}
	function calc2() {
		var NumTotal = 0;
		var plannedvalues = $("[name='plannedvalues']");
		for (var i = 0; i < plannedvalues.length; i++) {
			var val = plannedvalues[i].value;
			if (val) {
				NumTotal += parseInt(val);
			}
		}
		$("#totalvalue").html(NumTotal);
	}

	/* function getCompany() {
		$("#companyDiv").html("");
		$.ajax({
			type : "post",
			url : "${ctx}/Company/selectAll.htm",
			dataType : "json",
			async : false,
			success : function(msg) {
				for (var i = 0, len = msg.length; i < len; i++) {
					for (var i = 0, len = msg.length; i < len; i++) {
						var op = '<div id="company' + msg[i].comId
								+ '" class="unSelect" onclick="company('
								+ msg[i].comId + ',\'' + msg[i].comName
								+ '\')">';
						op += "<font class='font-h4'>" + msg[i].comShortName
								+ "</font>";
						//op+="<font class='font-h3 white-1'>"+msg[i].comId+"</font>";
						op += "</div>";
						$("#companyDiv").append(op);
						//var op="<option value='"+msg[i].comId+"'";
						//op+=">"+msg[i].comName+"</option>";
						//$("#company").append(op);
					}
				}
				if (msg != null && msg.length == 1) {
					company(msg[0].comId, msg[0].comShortName);
				}
			}
		});
	} */
	/* function getStation(companyid) {
		$("#pstationidDiv").html("");
		$.ajax({
			type : "post",
			url : "${ctx}/PowerStation/selectByCompany.htm",
			data : {
				"companyid" : companyid
			},
			dataType : "json",
			async : false,
			success : function(msg) {
				for (var i = 0, len = msg.length; i < len; i++) {
					for (var i = 0, len = msg.length; i < len; i++) {
						var op = '<div id="station' + msg[i].id
								+ '" class="unSelect" onclick="station('
								+ msg[i].id + ',\'' + msg[i].stationname
								+ '\')">';
						op += "<font class='font-h4'>" + msg[i].stationname
								+ "</font>";
						//op+="<font class='font-h3 white-1'>"+msg[i].id+"</font>";
						op += "</div>";
						$("#pstationidDiv").append(op);
						//var op="<option value='"+msg[i].id+"'";
						//op+=">"+msg[i].stationname+"</option>";
						//$("#pstationid").append(op);
					}
				}
				if (msg != null && msg.length == 1) {
					station(msg[0].id, msg[0].stationname);
				}
			}
		});
	} */
	function getYearList($scope, $http) {
		$http({
			method : "POST",
			url : "${ctx}/producePlan/getYearListForSearch.htm",
			params : {
				year:2015
			}
		}).success(function(result) {
			$scope.year = result.thisYear;
			$scope.yearList = result.yearList;
			getProducePlanData(result.thisYear);
		});
	}
	/* function selectYear() {
		$("#yearSelect").hide();
		$("#yearDiv").show();
	}
	function selectCompany() {
		$("#companySelect").hide();
		$("#companyDiv").show();
	}
	function selectPstationid() {
		$("#pstationidSelect").hide();
		$("#pstationidDiv").show();
	} 
	function year(year) {
		$("#year").val(year);
		$("#yearDiv").hide();
		$("#yearFont").html(year)
		$("#yearSelect").show();
		getProducePlanData();
		//$("#year"+year).removeClass("unSelect");
		//$("#year"+year).addClass("selected");
	}
	function company(company, name) {
		$("#company").val(company);
		$("#companyDiv").hide();
		$("#companyFont").html(name)
		$("#companySelect").show();

		$("#pstationid").val("");
		$("#pstationidDiv").hide();
		$("#pstationidFont").html("请选择");
		$("#pstationidSelect").show();
		getStation(company);

		//$("#company"+company).removeClass("unSelect");
		//$("#company"+company).addClass("selected");
	}
	function station(station, name) {
		$("#pstationid").val(station);
		//$("#station"+station).removeClass("unSelect");
		//$("#station"+station).addClass("selected");
		$("#pstationidDiv").hide();
		$("#pstationidFont").html(name)
		$("#pstationidSelect").show();
		getProducePlanData();
	}*/
	function getProducePlanData(year) {
		for (var i = 0; i < 12; i++) {
			$("#plannedvalues" + i).val(null);
			$("#totalvalue").html(null);
		}
		if (year == null || year == "") {
			return false;
		}
		$.ajax({
			type : "post",
			url : "${ctx}/producePlan/getProducePlanData.htm",
			dataType : "json",
			data : {
				"year" : year
			},
			async : false,
			success : function(response) {
				for (var i = 0,ii=response.length; i < ii; i++) {
					$("#plannedvalues" + i).val(response[i]);
				}
				calc2();
			}
		});
	}
</script>
<style>
.selected{
width: 20%;
float: left;
margin-right: 5%;
background-color: white;
border-radius: 8px;
text-align: center;
color: black;
cursor:pointer;
}
.unSelect{
width: 20%;
float: left;
margin-right: 5%;
text-align: center;
color: white;
cursor:pointer;
}
</style>
