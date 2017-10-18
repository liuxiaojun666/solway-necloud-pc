<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div ng-controller="groupStringShadowCtrl" class="groupStringShadow">

    <switch-power></switch-power>

    <div class="content-body">
        <div class="content-left">
            <content-left 
                detail="detail"
                page-list="pageList"
                device-type="deviceType"
            ></content-left>
        </div>

        <div class="content-right clearfix" d-loding="detail.isLoding">

            <div has-content="detail.res">
                <div class="chart1">
                    <chart1 
                        style="height: 290px;display: block;"
                        detail="detail"
                    ></chart1>
                </div>

                <div class="chart2">
                    <chart2 
                        style="display: block;"
                        detail="detail"
                    ></chart2>
                </div>
            </div>



        </div>
    </div>
</div>

<!-- 这里是页面消息列表 -->
<script type="text/html" id="content-left">
    <div class="message-remind">
        
        <div class="search-criteria clearfix">
            <div class="clearfix">
                <div class="pull-left">
                    <span>设备类型：</span><br/>
                    <select 
                        ng-model="deviceTypeVal" 
                        ng-change="getDeviceName(deviceTypeVal - 1)">
                        <option value="">请选择设备类型</option>
                        <option 
                            ng-repeat="item in deviceType.res.data" 
                            ng-if="item.devid < 3" 
                            value="{{ item.devid }}">
                            {{ item.devtype }}
                        </option>
                    </select>
                </div>
                <div class="pull-right">
                    <span>设备名称：</span><br/>
                    <select ng-model="deviceName">
                        <option value="">请选择设备</option>
                        <option 
                            ng-repeat="item in deviceNames" 
                            value="{{ item.serialnumber }}">
                            {{ item.name }}
                        </option>
                    </select>
                </div>
            </div>
            <div class="clearfix">

                <span style="display: block;">选择时间：</span>

                <div class="pull-left">
                    <calendar
                        calendar-type="{{'yyyy-MM-dd'}}"
                        date-time="dateTime1"
                        end-date="dateTime2"
                    ></calendar>
                </div>

                <p class="pull-left">至</p>

                <div class="pull-right">
                    <calendar
                        calendar-type="{{'yyyy-MM-dd'}}"
                        date-time="dateTime2"
                        start-date="dateTime1"
                    ></calendar>
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
