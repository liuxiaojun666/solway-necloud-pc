<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .tree_info .table td {border-color: #ddd;}
    .table tbody tr td {height: 100px;padding-left: 100px;}
    .table tbody input.form-control {width: 60%;display: inline-block;margin-left: 8px;color: #999;cursor: text;}
    .table tbody input.inputShow {background-color: inherit;border-color: transparent;}
    .app-content > .app-content-full {bottom: 0;}
    #manageDepartmentForm .btn.disabled {background-color: #ccc;border-color: #ccc;}
</style>
<link rel="stylesheet" href="${ctx}/vendor/jquery/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.core.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.excheck.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exedit.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/ztree/js/jquery.ztree.exhide.min.js"></script>

<div ng-controller="baseRegionCtrl" id="baseRegion" class="hbox hbox-auto-xs bg-light">
    <div class="app-content-full" style="top:0px;bottom: 0px">
        <div class="hbox hbox-auto-xs hbox-auto-sm">
            <div class="col tree_wrap">
                <div class="vbox">
                    <div id="departmentTreeMask" class="pa none" style="top: 0;bottom: 0;left: 0;right: 0;z-index: 2;"></div>
                    <div class="font-h3 menu_text text-center">地域结构树</div>
                    <div class="row-row">
                        <div class="cell">
                            <div class="cell-inner">
                                <ul class="tree_manage" id="regionTree"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col lter tree_info">
                <div class="vbox">
                    <div class="row-row">
                        <div class="cell">
                            <div class="cell-inner">
                                <div class="wrapper-md">
                                    <div class="panel panel-default">
                                        <div class="col-sm-12 panel no-padder">
                                            <div class="row wrapper">
                                                <a href="javascript:;" class="btn btn-sm btn-info ml15" ng-click="editRegionData()">编辑</a>
                                            </div>
                                            <div class="panel-body">
                                                <form class="bs-example form-horizontal" method="post" action="${ctx}/BaseRegion/updateBaseRegion.htm" id="baseRegionForm" name="baseRegionForm">
                                                    <input type="hidden" ng-model="regionData.id" name="id" value="{{regionData.id}}" />
                                                    <div class="form-group" style="margin-bottom: 20px;">
                                                        <label class="col-lg-2 control-label">发电小时数</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="dayPowerHours" ng-model="regionData.dayPowerHours" class="form-control formData" type="text" readonly>
                                                                <div class="input-group-addon">小时</div>
                                                            </div>
                                                        </div>
                                                        <label class="col-lg-2 control-label">家庭用电电价</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="familyElecPrice" ng-model="regionData.familyElecPrice" class="form-control formData" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="margin-bottom: 20px;">
                                                        <label class="col-lg-2 control-label">全额上网电价</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="poolPurchasePrice" ng-model="regionData.poolPurchasePrice" class="form-control formData" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                        <label class="col-lg-2 control-label">地方度电补贴(省)</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="proviceSubsidy" ng-model="regionData.proviceSubsidy" class="form-control formData" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="margin-bottom: 20px;">
                                                        <label class="col-lg-2 control-label">地方度电补贴年限(省)</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="proviceSubsidyYear" ng-model="regionData.proviceSubsidyYear" class="form-control formData" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                        <label class="col-lg-2 control-label">地方度电补贴(市)</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="citySubsidy" ng-model="regionData.citySubsidy" class="form-control formData valid-required" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" style="margin-bottom: 20px;">
                                                        <label class="col-lg-2 control-label">地方度电补贴年限(市)</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="citySubsidyYear" ng-model="regionData.citySubsidyYear" class="form-control formData valid-required" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                        <label class="col-lg-2 control-label">地方度电补贴年限(市)</label>
                                                        <div class="col-lg-4 pos-rlt">
                                                            <div class="input-group">
                                                                <input name="installSubsidy" ng-model="regionData.installSubsidy" class="form-control formData valid-required" type="text" readonly>
                                                                <div class="input-group-addon">元</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group" id="editBox" style="margin: 30px 0;display: none">
                                                        <div class="col-lg-7">
                                                            <button type="button" class="m-l-sm pull-right btn m-b-xs w-xs btn-default" ng-click="cancelRegionData()"><strong>取消</strong></button>
                                                            <button type="button" ng-click="saveRegionData();" class=" pull-right btn m-b-xs w-xs btn-info"><strong>保 存</strong></button>
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
                </div>
            </div>

        </div>
    </div>
</div>
<script>
    var scopeTreeOnClick;
    app.controller('baseRegionCtrl', function($scope, $http, $state) {
        $scope.setting = {
            view: {
                selectedMulti: false
            },
            edit: {
                enable: true,
                editNameSelectAll: true
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onClick: treeOnClick
            }
        };

        scopeTreeOnClick = $scope.treeOnClick = function (event, treeId, treeNode) {
            $http({
                method : "POST",
                url: '${ctx}/BaseRegion/queryBaseRegionById.htm',
                params : {
                    id: treeNode.id
                }
            }).success(function(result) {
                if (result.key==0) {
                    $scope.regionData = result.data;
                    $scope.$applyAsync();
                    $scope.cancelRegionData();
                }
            });
        };

        $scope.initTree = function () {
            $http({
                method : "POST",
                url: '${ctx}/BaseRegion/queryBaseRegionTree.htm',
                params : {}
            }).success(function(result) {
                if (result.key==0) {
                    $scope.zNodes = result.data;
                    $scope.zTreeObj = $.fn.zTree.init($("#regionTree"), $scope.setting, $scope.zNodes);
                    $("#regionTree_2_a").click();
                }
            });
        };
        $scope.initTree();

        $scope.editRegionData = function () {
            $("#baseRegionForm input[type='text']").attr("readonly", false);
            $("#editBox").show();
        };
        $scope.cancelRegionData = function () {
            $("#baseRegionForm input[type='text']").attr("readonly", true);
            $("#editBox").hide();
        };
        $scope.saveRegionData = function () {
            var options = {
                dataType : "json",
                success : function(res) {
                    if (res.key == 0){
                        $(".curSelectedNode").click();
                        promptObj('success','',res.msg);
                        return;
                    }
                    promptObj('error','',res.msg);
                },
                error : function(json) {
                    promptObj('error','',res.msg);
                }
            };
            $("#baseRegionForm").ajaxSubmit(options);
        };
    });

    function treeOnClick(event, treeId, treeNode) {
        scopeTreeOnClick(event, treeId, treeNode);
    }
</script>
