<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div ng-controller="deviceAttenuationCtrl" class="groupStringShadow">

    <switch-power></switch-power>

    <div class="content-body">
        <div class="content-left" style="width: 315px;min-width: 315px;">
            <content-left2 
                detail="detail"
                page-list="pageList"
                device-type="deviceType"
            ></content-left2>
        </div>

        <div class="content-right clearfix" d-loding="detail.isLoding">

            <div has-content="detail.res">
                <div class="switch">
                    <button ng-class="{'active': true}" ng-click="">年</button>
                    <button ng-class="{'active': false}" ng-click="">累计</button>
                </div>

                <div class="chart1">
                    <chart11 
                        style="height: 200px;display: block;"
                        detail="detail"
                    ></chart1>
                </div>

                <div class="chart1">
                    <chart22 
                        style="height: 200px;display: block;"
                        detail="detail"
                    ></chart2>
                </div>

                <div class="chart1">
                    <chart33 
                        style="height: 200px;display: block;"
                        detail="detail"
                    ></chart2>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- 这里是页面消息列表 -->
<script type="text/html" id="content-left2">
    <div class="message-remind">
        
        <div class="search-criteria clearfix">
            <div class="clearfix">
                <div class="pull-left">
                    <span>设备类型：</span><br/>
                    <select 
                        style="width: 136px;" 
                        ng-model="deviceTypeVal" 
                        ng-change="getDeviceName(deviceTypeVal - 1)">
                        <option value="">请选择设备类型</option>
                        <option ng-repeat="item in deviceType.res.data" value="{{ item.devid }}">{{ item.devtype }}</option>
                    </select>
                </div>
                <div class="pull-right">
                    <span>设备名称：</span><br/>
                    <select 
                        style="width: 136px;" 
                        ng-model="deviceName">
                        <option value="">请选择设备</option>
                        <option ng-repeat="item in deviceNames" value="{{ item.id }}">{{ item.name }}</option>
                    </select>
                </div>
            </div>

            <button 
                ng-click="search()">
                查询
            </button>
        </div>

        <div class="bg-white" d-loding="pageList.isLoding">
            <div class="operating-list">
                <my-table 
                    class="table" 
                    datasource="pageList.res.data.data" 
                    column="column"
                    tr-click="loadDetail"
                    scroll-y="tableScrollY"
               ></my-table>
            </div>
        </div>

        <my-paging 
            class="paging"
            get-data="pageList.getData" 
            paging="pageList.res.data"
            page-size="{{'none'}}"
        ></my-paging>
    </div>
</script>
<!-- 这里是页面消息列表 END -->