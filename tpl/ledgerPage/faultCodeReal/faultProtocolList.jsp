<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="form-group col-sm-12">
    <label class="col-lg-1 control-label">判断类型</label>
    <div class="col-lg-11">
        <label class="checkbox-inline i-checks ">
            <input type="radio" ng-change="changeFaultCodeReal()" ng-model="faultCodeReal" ng-value="true" class="form-control">  <i></i> 整型
        </label>

        <label class="checkbox-inline i-checks">
            <input type="radio" ng-change="changeFaultCodeReal()" ng-model="faultCodeReal" ng-value="false" class="form-control">  <i></i> 按位(故障码全为0时所对应的索引位置为-1)
        </label>
    </div>
</div>

<paging class="col-sm-12 panel no-padder">
    <div class="row wrapper">
        <div class="col-sm-4 m-b-xs w-sm p-r-sm">
            <a class="btn btn-sm btn-info m-r-xs" onclick="addSlaveData('faultProtocolModal');"> 新增</a>
            <a class="btn btn-sm btn-default m-r-xs" ng-click="deleteBatchSlaveData('');">批量删除</a>
        </div>
        <div class="col-sm-3 no-padder">
            <div class="col-sm-9  no-padder">
                <div class="input-group p-r-sm">
                    <input type="text" id="keyWords" ng-model="$parent.keyWords"  class="input-sm form-control" placeholder="关键字">
                    <span class="input-group-btn">
                        <button id="searchBtn" class="btn btn-sm btn-info" ng-click="onSelectPage(1);" type="button">查询</button>
                    </span>
                </div>
            </div>
        </div>
        <div class="col-sm-5 pull-right">
        <%@ include file="/common/pager.jsp"%>
        </div>
    </div>
    <table id="fault_result_table" class="table table-striped b-t b-light">
        <thead>
            <tr>
                <th style="width: 20px;">
                    <label class="i-checks m-b-none">
                        <input type="checkbox" id="all" onclick="changeAll(this.checked,'fcrids');" /><i></i>
                    </label>
                </th>
                <th ng-if="faultCodeReal" width="10%">故障代码</th>
                <th ng-if="!faultCodeReal" width="10%">故障索引</th>
                <th width="15%">故障中文描述</th>
                <th width="15%">故障分类</th>
                <th width="30%">故障原因及处理流程</th>
                <th width="15%">附件</th>
                <th width="8%">操作</th>
            </tr>
        </thead>
        <tbody>
                <tr ng-repeat="vo in data">
                    <td>
                        <label class="i-checks m-b-none">
                            <input type="checkbox" name="fcrids" id="fcrids" value="{{vo.id }}" /> <i></i>
                        </label>
                    </td>
                    <td ng-show="faultCodeReal">
                        <a class="text-info" href="javascript:void(0);" ng-click="viewSlaveData({{vo.id}}, 'faultProtocolDetailModal');">{{vo.faultCode}}</a>
                    </td>
                    <td ng-show="!faultCodeReal">
                        <a class="text-info" href="javascript:void(0);" ng-click="viewSlaveData({{vo.id}}, 'faultProtocolDetailModal');">{{vo.faultCodeIndex}}</a>
                    </td>
                    <td ng-bind="vo.faultDescCH"></td>
                    <td ng-bind="vo.faultTypeName"></td>
                    <td ng-bind="vo.faultHandle"></td>
                    <td>
                        <a ng-if="vo.file1 != '' && vo.file1 != null" class="text-info" title="{{vo.fileName1}}">
                            <i class="fa fa-paperclip" ng-click="download({{vo.id }}, '1')"></i>
                        </a>
                        <span ng-if="!(vo.file1 != '' && vo.file1 != null)" class="text-muted" title="未上传附件">
                            <i class="fa fa-paperclip"></i>
                        </span>
                        <a ng-if="vo.file2 != '' && vo.file2 != null" class="text-info" title="{{vo.fileName2}}">
                            <i class="fa fa-paperclip" ng-click="download({{vo.id }}, '2')"></i>
                        </a>
                        <span ng-if="!(vo.file2 != '' && vo.file2 != null)" class="text-muted" title="未上传附件">
                            <i class="fa fa-paperclip"></i>
                        </span>
                        <a ng-if="vo.file3 != '' && vo.file3 != null" class="text-info" title="{{vo.fileName3}}">
                            <i class="fa fa-paperclip" ng-click="download({{vo.id }}, '3')"></i>
                        </a>
                        <span ng-if="!(vo.file3 != '' && vo.file3 != null)" class="text-muted" title="未上传附件">
                            <i class="fa fa-paperclip"></i>
                        </span>
                    </td>
                    <td>
                        <a class="text-info"><i class="icon-note" ng-click="editSlaveData({{vo.id }}, 'faultProtocolModal');"></i></a>
                        <a class="text-info"><i class="icon-trash" ng-click="deleteOneSlaveData(vo.id, '${ctx}/PFaultCodeReal/delete.htm');"></i></a>
                    </td>
                </tr>
            </tr>
        </tbody>
    </table>

</paging>