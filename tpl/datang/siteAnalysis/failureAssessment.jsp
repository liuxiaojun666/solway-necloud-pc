<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div ng-controller="failureAssessmentCtrl" class="groupStringShadow">

    <switch-power></switch-power>

    <div class="content-body">
        <div class="content-left">
            <content-left8 
                detail="detail"
                page-list="pageList"
                device-type="deviceType"
            ></content-left8>
        </div>

        <div class="content-right clearfix" d-loding="detail.isLoding">

            <div has-content="detail.res">
                <div class="fa-right-top">
                    <div class="gzChart1">
                        <fa-chart1
                            style="display: block;width: 300px;height: 280px;"
                        ></fa-chart1>
                    </div>
                    <div class="gzChart2">
                        <h4>综合评分</h4>
                        <div>
                            <span>45</span>
                        </div>
                    </div>
                    <div class="rate">
                        <fa-rate
                            number="'81'"
                            title="'故障率'"
                            content="'在场内4个设备中排名第二'"
                        ></fa-rate>
                        <fa-rate
                            number="'71'"
                            title="'MTTR'"
                            content="'在场内4个设备中排名第二'"
                        ></fa-rate>
                        <fa-rate
                            number="'61'"
                            title="'MTBF'"
                            content="'在场内4个设备中排名第二'"
                        ></fa-rate>
                    </div>
                </div>

                <div class="fa-right-bottom">
                    <my-table
                        datasource="datasource2" 
                        column="column2"
                        mounted="tableMounted"
                        before-mount="tableBeforeMount"
                        before-destroy="tableDestroy"
                    ></my-table>
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

<script type="text/html" id="fa-rate">
    <div>
        <div class="number">
            <span>{{ number }}</span>
        </div>
        <div class="content">
            <h4>{{ title }}</h4>
            <p>{{ content }}</p>
        </div>
    </div>
</script>
