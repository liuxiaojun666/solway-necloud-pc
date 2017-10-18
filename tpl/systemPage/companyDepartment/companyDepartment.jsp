<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="companyDepartmentCtrl">
	<div class="wrapper-md">
		<div class="panel panel-default">
			<dl class="unstyled pl80 clearfix">
				<dt class="bbdashed ml_80 pl20 lh50">
					基本信息
					<button class="btn btn-sm btn-info pull-right mt10 mr20" ng-click="editCompanyDepartment()">编辑</button>
				</dt>
				<dd class="col-sm-3 mt15">
					企业编码<span class="ml20 c9" ng-bind="ComInfo.comCode|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					企业名称<span class="ml20 c9" ng-bind="ComInfo.comName|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					企业简称<span class="ml20 c9" ng-bind="ComInfo.comShortName|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					注册资金<span class="ml20 c9" ng-bind="ComInfo.regMoney|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					企业法人<span class="ml20 c9" ng-bind="ComInfo.comCorp|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					企业性质<span class="ml20 c9" ng-bind="ComInfo.comBctCodeName|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15" style="padding-left: 87px;">
					<span class="pa" style="left: 15px;">企业类型</span>
					<span class="c9" style="word-wrap: nowrap;">
						<span ng-show="ComInfo.isowner == '1'">电站业主</span>&nbsp;
						<span ng-show="ComInfo.isepc == '1'">EPC</span>&nbsp;
						<span ng-show="ComInfo.isservice == '1'">运维公司</span>&nbsp;
						<span ng-show="ComInfo.ismanu == '1'">设备厂商</span>
						<span ng-hide="ComInfo.isowner+ComInfo.isepc+ComInfo.isservice+ComInfo.ismanu">-</span>
					</span>
				</dd>
				<dd class="col-sm-3 mt15">
					管理员账号<span class="ml20 c9" ng-bind="ComInfo.adminuserName|dataNullFilter"></span><button class="btn btn-sm btn-info pull-right mt10 mr20" onclick="changeadmin()">管理员移交</button>
				</dd>
			</dl>
			<dl class="unstyled pl80 clearfix">
				<dt class="bbdashed ml_80 pl20 lh50">联系信息</dt>
				<dd class="col-sm-3 mt15">
					<span class="ls4_3">联系人</span><span class="ml20 c9" ng-bind="ComInfo.comCont|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					联系电话<span class="ml20 c9" ng-bind="ComInfo.comTel|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					<span class="ls4_2">传真</span><span class="ml20 c9" ng-bind="ComInfo.comFax|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					电子邮件<span class="ml20 c9" ng-bind="ComInfo.comEmail|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					<span>接管时间</span><span class="ml20 c9" ng-bind="ComInfo.admintime|dataNullFilter"></span>
				</dd>
				<!-- <dd class="col-sm-6 mt15">
					<span class="ls4_2">网址</span><span class="ml20 c9" ng-bind=""></span>
				</dd> -->
				<dd class="col-sm-3 mt15">
					<span class="ls4_2">邮编</span><span class="ml20 c9" ng-bind="ComInfo.comZip|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-6 mt15">
					<span class="ls4_2">地址</span><span class="ml20 c9" >{{ComInfo.provinceid+ComInfo.cityid+ComInfo.countyid+ComInfo.comAddr |dataNullFilter}}</span>
				</dd>
			</dl>
			<dl class="unstyled pl80 clearfix">
				<dt class="bbdashed ml_80 pl20 lh50">应用信息</dt>
				<dd class="col-sm-3 mt15">
					二级域名<span class="ml20 c9" ng-bind="ComInfo.subdomains|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					系统名称<span class="ml20 c9" ng-bind="customConfig.os_title|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					英文名称<span class="ml20 c9" ng-bind="customConfig.os_en_title|dataNullFilter"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					<span class="ml20 c9"></span>
				</dd>
				<dd class="col-sm-3 mt15" id="logo_lg" ng-if="customConfig.logo_lg">
					登录页logo<span class="ml20 c9 ml20"><img style="max-height: 120px;max-width: 200px;vertical-align: top;" ng-src="{{'${ctx}/'+customConfig.logo_lg}}" alt="-"></span>
				</dd>
				<dd class="col-sm-3 mt15" id="logo_sm" ng-if="customConfig.logo_sm_flag == 0 && customConfig.logo_sm">
					登录页左上角logo<span class="ml20 c9 ml20"><img style="max-height: 120px;max-width: 200px;vertical-align: top;" ng-src="{{'${ctx}/'+customConfig.logo_sm}}" alt="-"></span>
				</dd>
				<dd class="col-sm-3 mt15">
					logo<span class="ml20 c9 ml20"><img style="max-height: 120px;max-width: 200px;vertical-align: top;" ng-src="{{'${ctx}/'+ComInfo.logo}}" alt="-"></span>
				</dd>
			</dl>
			<dl class="unstyled pl80 clearfix">
				<dt class="bbdashed ml_80 pl20 lh50">证件信息</dt>
				<dd class="mt15"><img height="160px" ng-src="{{}}" alt="-" style="max-height: 120px;max-width: 200px;vertical-align: top;"></dd>
			</dl>
			<dl  class="unstyled pl80 clearfix">
				<dt class="bbdashed ml_80 pl20 lh50">其他介绍</dt>
				<dd class="mt15">
					<p ng-bind="ComInfo.descp|dataNullFilter"></p>
				</dd>
			</dl>
		</div>
	</div>
</div>

<div ng-controller="changeadminCtrl" class="modal fade" id="changeadmin">
    <div class="modal-dialog">
        <div class="modal-content wrapper-lg">
			<form class="form-horizontal" id="addRoleForm" name="addRoleForm">
				<div class="inverterTablediv simThead_fault pr">
					<table class="table text-center table-striped b-t b-light">
					<input id="clickon" type="hidden" ng-click="clic()">
						<thead>
							<tr>
								<th></th>
								<th>姓名</th>
								<th>电话</th>
							</tr>
						</thead>
						<tbody id="roleTablePop">
							<tr ng-repeat="vo in powerData">
								<td class="table-roleCode"><input type="radio" name="changeus" ng-bind="vo.userid"></td>
								<td class="table-roleCode" ng-bind="vo.realname"></td>
								<td class="table-roleCode" ng-bind="vo.phone"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="text-center mt20">
					<button type="button" class="btn btn-info" data-loading-text="保存中..."onclick="savadata('');">保存</button>
					<button type="button" class="btn ml15" data-dismiss="modal" name="resetAddRole" id="resetAddRole">取消</button>
				</div>
			</form>
        </div>
    </div>
</div>

<script>
	jQuery.extend(jQuery.validator.messages, {

		required:'<div class="popover fade bottom in" role="tooltip" style="display: block;margin: 40px 10px;"><div style="padding: 2px 7px;font-size: 12px;">必填项</div></div>',
		fax:'<div class="popover fade bottom in" role="tooltip" style="display: block;margin: 40px 10px;"><div style="padding: 2px 7px;font-size: 12px;"><i class="fa fa-exclamation-triangle text-danger m-r-xs"/>请检查您的传真号码</div></div>',
	});
</script>
<script>

	app.controller('companyDepartmentCtrl', function($scope, $http, $state) {
		$http.get('${ctx}/Company/baseInfo.htm')
		.success(function(res) {
			if (res.key==2) {
				$scope.customConfig = res.customConfig;
				$scope.ComInfo = res.data;
				//$scope.ComInfo.logo.replace(/\//g,'\\');
				$scope.ComInfo.comBctCodeName = null;
				switch($scope.ComInfo.comBctCode){
					case 32:
						$scope.ComInfo.comBctCodeName = '国有企业';
						break;
					case 33:
						$scope.ComInfo.comBctCodeName = '股份制企业';
						break;
					case 34:
						$scope.ComInfo.comBctCodeName = '私营企业';
						break;
					case 35:
						$scope.ComInfo.comBctCodeName = '联营企业';
						break;
					case 36:
						$scope.ComInfo.comBctCodeName = '外商投资企业';
						break;
					case 37:
						$scope.ComInfo.comBctCodeName = '港、澳、台';
						break;
					case 38:
						$scope.ComInfo.comBctCodeName = '股份合作企业';
						break;
					case 39:
					$scope.ComInfo.comBctCodeName = '集体所有制';
					break;
				}
			}
		}).error(function(res) {

		});

		$scope.editCompanyDepartment = function() {
			$state.go('app.addCompanyDepartment');
		};

	});

	app.controller('changeadminCtrl', function($scope, $http, $state) {
		$scope.clic = function(){
			$http({
				method : "POST",
				url : "${ctx}/Company/selectadminuser.htm"
			}).success(function(result) {
				$scope.powerData = result;
			}).error(function(res) {
				
			});
		};

	});
	function changeadmin(){
		$('#changeadmin').modal();
		$('#clickon').trigger('click');
	}
	function savadata(){
		var usid=$("input[name='changeus']:checked").text();
		if(usid==null||usid==""){
			alert("请选择人员!")
			return;
		}
		var options = {
			type : "post",
			dataType : "json",
			url : "${ctx}/Company/changeadminuser.htm?userid="+usid,
			success : function(json) {
				promptObj('success', '', json.message);
				alert('移交成功,请重新登录!')
				window.location.href="${ctx}/login.jsp";
			},
			error : function(json) {
				promptObj('error', '',"操作失败");
			}
		};
		$.ajax(options);
	}
</script>
