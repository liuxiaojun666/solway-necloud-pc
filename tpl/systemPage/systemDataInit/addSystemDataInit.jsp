<%--
  User: GreenBook
  Date: 2017/5/31
  Time: 9:05
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

<script type="text/javascript">
    $(function() {
        $("#editForms").validate( {
            ignore:'',
            rules : {
                comId:{
                    required : true
                },
                sid:{
                    required : true
                },
                createTime:{
                    required : true
                },
                type:{
                    required : true
                },
                status:{
                    required : true
                }
            },
            submitHandler : function(form) {
                if ($('#type').val() == '00') {
                    if ($('#status').val() != '1') {
                        promptObj('info', '','任务执行情况 请选择 未执行');
                    }
                }
                if ($("#deviceType").val() == '') {
                    $("#deviceType").val($('#stationClass').val());
                }
                var options = {
                    dataType : "json",
                    success : function(result) {
                        if(result.code == 0) {
                            promptObj('success', '','保存成功');
                        }
                        hideModal("systemDataInitModal");
                        goPage(0);
                    },
                    error : function(result) {
                        promptObj('error', '',"操作失败，请稍后重试");
                    }
                };
                $('#editForms').ajaxSubmit(options);
            }
        });

        //日期控件 开始时间
        $('#beginTime').datetimepicker({
            language: 'zh-CN',
            format:"yyyy-mm-dd hh:ii:ss",
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 4,
            forceParse: 0
        });

        //日期控件 结束时间
        $('#endTime').datetimepicker({
            language: 'zh-CN',
            format:"yyyy-mm-dd hh:ii:ss",
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 4,
            forceParse: 0
        });
        //日期控件 任务生成时间
        $('#createTime').datetimepicker({
            language: 'zh-CN',
            format:"yyyy-mm-dd hh:ii:ss",
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 4,
            forceParse: 0
        });

        //日期控件 任务执行时间
        $('#executeTime').datetimepicker({
            language: 'zh-CN',
            format:"yyyy-mm-dd hh:ii:ss",
            weekStart: 1,
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 4,
            forceParse: 0
        });
    });
    function saveForm(){
        $("#editForms").trigger("submit");

    }
    //初始化页面数据
    function initPageData(id){
        $(".formData").val("");
        if(id != "" && id != null){
            $("#id").val(id);
            $.ajax({
                type:"get",
                url:"${ctx}/systemDataInit/selectById.htm",
                data:{"id":id},
                success:function(result){
                    var data = result.data;
                    $("#id").val(data.id);
                    $("#comId").val(data.comId);
                    $("#companyid").val(data.companyid);
                    $("#sid").val(data.sid);
                    $("#did").val(data.did);
                    $("#serialNumber").val(data.serialNumber);
                    $("#deviceType").val(data.deviceType);
                    $("#beginTime").val(data.beginTime);
                    $("#createTime").val(data.createTime);
                    $("#executeTime").val(data.executeTime);
                    $("#type").val(data.type);
                    $("#status").val(data.status);
                    getSelected(id);
                    console.info('11111111111111')
                }
            });
        }else{
            getSelected(null);
            console.info('2222222222222')
        }
    }


    var getSelected, getDeviceData, getStationData, initIsValid;
    app.controller('addSystemDataInitCtrl', ['$http',  '$scope',  function($http,$scope){
        getSelected = $scope.getA = function(id){

            /*
             */
            $scope.deviced = {};
            $scope.device = null;
            getDeviceData=$scope.getDevice = function(){
                var stid = $("#sid").val();
                if(stid != "" && stid != null){
                    $http({
                        method:"POST",
                        url:"${ctx}/PowerStation/selectDevicesByStation.htm",
                        params:{
                            stid: stid
                        }
                    }).success(function (result) {
                        $scope.device = result;
                        if($scope.device !=null&&$scope.device.length>0){
                            $scope.device.unshift({id:'',name:'请选择', serialNumber: '', deviceType: ''});
                        }
                        if($("#did").val()!=null && $("#did").val()!=""){
                            for(var i=0,len=$scope.device.length;i<len;i++){
                                if($scope.device[i].id ==  $("#did").val() && $scope.device[i].serialNumber ==  $("#serialNumber").val()){
                                    $scope.deviced.selected =  $scope.device[i];
                                }
                            }
                        } else {
                            $scope.deviced.selected =  $scope.device[0];
                        }
                        $scope.deviceChange= function () {
                            $("#did").val( angular.copy($scope.deviced.selected.id));
                            $("#serialNumber").val( angular.copy($scope.deviced.selected.serialNumber));
                            $("#deviceType").val( angular.copy($scope.deviced.selected.deviceType));
                        }
                    });
                } else {
                    $scope.deviced = {};
                    $scope.device = null;
                }
            }
            // 	设备end===============================================================

            $scope.stationd = {};
            $scope.station = null;
            getStationData=$scope.getStation = function(){
                var companyid = $("#comId").val();
                if(companyid != "" && companyid != null){
                    $http({method:"POST",
                        url:"${ctx}/PowerStation/selectByCompanyId.htm",
                        params:{
                            companyid:$("#comId").val()
                        }
                    }).success(function (result) {
                        $scope.station = result;
                        if($scope.station !=null&&$scope.station.length>0){
                            $scope.station.unshift({id:"",stationname:'请选择', stationClass: ''});
                        }
                        if($("#sid").val()!=null&&$("#sid").val()!=""){
                            for(var i=0,len=$scope.station.length;i<len;i++){
                                if($scope.station[i].id ==  $("#sid").val()){
                                    $scope.stationd.selected = $scope.station[i];
                                    $scope.getDevice();
                                }
                            }
                        } else {
                            $scope.stationd.selected = $scope.station[0];
                            $scope.getDevice();
                        }
                        $scope.textChange= function () {
                            $("#sid").val( angular.copy($scope.stationd.selected.id));
                            $("#stationClass").val( angular.copy($scope.stationd.selected.stationClass));
                            $scope.getDevice();
                        }
                    });
                } else {
                    $scope.stationd = {};
                    $scope.station = null;
                }
            }
            // 	电站end===============================================================

            $scope.companyd = {};
            $scope.company = null;
            $http({method:"POST",url:"${ctx}/Company/selectAllByAdmin.htm",params:{}})
                    .success(function (result) {
                        $scope.company = result;
                        if($scope.company !=null&&$scope.company.length>0){
                            $scope.company.unshift({comId:"",comName:'请选择'});
                        }
                        for(var i=0,len=$scope.company.length;i<len;i++){
                            if($scope.company[i].comId ==  $("#comId").val()){
                                $scope.companyd.selected = $scope.company[i];
                                $scope.getStation();
                                $scope.getDevice();
                            }
                        }

                        $scope.companyChange= function () {
                        	console.log($scope.companyd.selected.comId)
                            $("#comId").val(angular.copy($scope.companyd.selected.comId));
                            console.log( $("#comId").val())
                            $scope.getStation();
                            $scope.getDevice();
                        }
                    });
            // 	组织机构end===============================================================

            $scope.typed = {};
            $scope.type = null;
            $scope.statusd = {};
            $scope.status = null;
            $http({method:"POST",url:"${ctx}/systemDataInit/getConsumeSelectData.htm",params:{}})
                    .success(function (result) {
                        $scope.type = result.data.types;
                        if($scope.type !=null&&$scope.type.length>0){
                            $scope.type.unshift({key:"",name:'请选择'});
                        }
                        for(var i=0,len=$scope.type.length;i<len;i++){
                            if($scope.type[i].key==  $("#type").val()){
                                $scope.typed.selected = $scope.type[i];
                            }
                        }
                        $scope.typeChange= function () {
                            $("#type").val(angular.copy($scope.typed.selected.key));
                        }


                        $scope.status = result.data.statuses;
                        if($scope.status !=null&&$scope.status.length>0){
                            $scope.status.unshift({key:"",name:'请选择'});
                        }
                        for(var i=0,len=$scope.status.length;i<len;i++){
                            if($scope.status[i].key==  $("#status").val()){
                                $scope.statusd.selected = $scope.status[i];
                            }
                        }
                        $scope.statusChange= function () {
                            $("#status").val(angular.copy($scope.statusd.selected.key));
                        }
                    });
            // 	组织机构end===============================================================
        };
    }]);

</script>
<div ng-controller="addSystemDataInitCtrl"  class="modal fade" id="systemDataInitModal" tabindex="-1" right="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog row">
        <div class="modal-content ">
            <div class="modal-body wrapper-lg">
                <div class="row">
                    <div class="col-sm-12">
                        <span class="font-h3 m-t-none m-b font-thin" id="myModalLabel">系统数据修改操作记录</span>
                        <div class="panel-body">
                            <form class="bs-example form-horizontal ng-pristine ng-valid" action="${ctx}/systemDataInit/update.htm" method="post" id="editForms" name="editForms">
                                <input type="hidden" name="id" value="" id="id" class="formData"/>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>公司</label>
                                    <div class="col-lg-4">
                                        <ui-select ng-model="companyd.selected" theme="bootstrap" ng-change="companyChange()">
                                            <ui-select-match placeholder="请输入关键字..." ng-model="companyd.selected.comName" >{{$select.selected.comName}}</ui-select-match>
                                            <ui-select-choices  repeat="item in company | filter: $select.search">
                                                <div ng-bind-html="item.comName | highlight: $select.search"></div>
                                            </ui-select-choices>
                                        </ui-select>
                                        <input type="hidden" id="comId" name="comId" class="form-control formData">
                                        <div class="valid-error"></div>
                                    </div>
                                    <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>电站</label>
                                    <div class="col-lg-4">
                                        <ui-select ng-model="stationd.selected" theme="bootstrap" ng-change="textChange()">
                                            <ui-select-match placeholder="请输入关键字..." ng-model="stationd.selected.stationname" >{{$select.selected.stationname}}</ui-select-match>
                                            <ui-select-choices  repeat="item in station | filter: $select.search">
                                                <div ng-bind-html="item.stationname | highlight: $select.search"></div>
                                            </ui-select-choices>
                                        </ui-select>
                                        <input type="hidden" id="sid" name="sid" class="form-control formData">
                                        <input type="hidden" id="stationClass" name="stationClass" class="form-control formData">
                                        <div class="valid-error"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">设备</label>
                                    <div class="col-lg-4">
                                        <ui-select ng-model="deviced.selected" theme="bootstrap" ng-change="deviceChange()">
                                            <ui-select-match placeholder="请输入关键字..." ng-model="deviced.selected.comName" >{{$select.selected.name}}</ui-select-match>
                                            <ui-select-choices  repeat="item in device | filter: $select.search">
                                                <div ng-bind-html="item.name | highlight: $select.search"></div>
                                            </ui-select-choices>
                                        </ui-select>
                                        <input type="hidden" id="did" name="did" class="form-control formData">
                                        <input type="hidden" id="serialNumber" name="serialNumber" class="form-control formData">
                                        <input type="hidden" id="deviceType" name="deviceType" class="form-control formData">
                                    </div>
                                    <label class="col-lg-2 control-label"></label>
                                    <div class="col-lg-4">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label">开始时间</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="beginTime" name="beginTime" class="form-control formData">
                                    </div>
                                    <label class="col-lg-2 control-label">结束时间</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="endTime" name="endTime" class="form-control formData">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>任务生成时间</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="createTime" name="createTime" class="form-control formData">
                                        <div class="valid-error"></div>
                                    </div>
                                    <label class="col-lg-2 control-label">任务执行时间</label>
                                    <div class="col-lg-4">
                                        <input type="text" id="executeTime" name="executeTime" class="form-control formData">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>类型</label>
                                    <div class="col-lg-4">
                                        <ui-select ng-model="typed.selected" theme="bootstrap" ng-change="typeChange()">
                                            <ui-select-match placeholder="请输入..." ng-model="typed.selected.name" >{{$select.selected.name}}</ui-select-match>
                                            <ui-select-choices  repeat="item in type | filter: $select.search">
                                                <div ng-bind-html="item.name | highlight: $select.search"></div>
                                            </ui-select-choices>
                                        </ui-select>
                                        <input type="hidden" id="type" name="type" class="form-control formData"/>
                                        <div class="valid-error"></div>
                                    </div>

                                    <label class="col-lg-2 control-label"></label>
                                    <div class="col-lg-4">
                                    </div>
                                    <!--
                                    <label class="col-lg-2 control-label"><i class="fa fa-asterisk text-required"/>任务执行情况</label>
                                    <div class="col-lg-4">
                                        <ui-select ng-model="statusd.selected" theme="bootstrap" ng-change="statusChange()">
                                            <ui-select-match placeholder="请输入..." ng-model="statusd.selected.name" >{{$select.selected.name}}</ui-select-match>
                                            <ui-select-choices  repeat="item in status | filter: $select.search">
                                                <div ng-bind-html="item.name | highlight: $select.search"></div>
                                            </ui-select-choices>
                                        </ui-select>
                                        <input type="hidden" id="status" name="status" class="form-control formData"/>
                                        <div class="valid-error"></div>
                                    </div>
                                    -->
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                                        <button type="button" onclick="saveForm();" id="saveButton" class=" pull-right btn m-b-xs w-xs   btn-info" style="margin-left: 10px"><strong>保 存</strong></button>
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