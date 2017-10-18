<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="cleaningAdviceCtrl" class="cleaningAdvice">
    <switch-power class="switch-power">
        <calendar
            style="margin-left: 50px;display: inline-block;"
            calendar-type="yyyy-MM-dd"
            date-time="dateTime1"
            end-date="dateTime2"
        ></calendar>
        <span>至</span>
        <calendar
            style="display: inline-block;"
            calendar-type="yyyy-MM-dd"
            date-time="dateTime2"
            start-date="dateTime1"
        ></calendar>
        <button>确认</button>
    </switch-power>

    <div class="color-blocks clearfix">
        <color-block
            title="今日天气"
            background="{{'#f0c254'}}"
            icon="qingtian"
            content="晴"
        ></color-block>
        <color-block
            title="今日积灰指数"
            background="{{'#7861b0'}}"
            icon="huichen"
            content="0.5"
        ></color-block>
        <color-block
            title="清洗建议"
            background="{{'#52b25b'}}"
            icon="qingxi"
            content="清洗"
        ></color-block>
    </div>

    <div class="chart">
        <div>
            <cleaning-advice-chart
                style="display: block;"
            ></cleaning-advice-chart>
        </div>
    </div>
</div>

<script type="text/html" id="color-block">
    <div>
        <div style="background-color: {{ background }};">
            <div class="title clearfix">
                <span>{{ title }}</span>
                <i class="sprite" ng-class="icon"></i>
            </div>
            <div class="content">{{ content }}</div>
        </div>
    </div>
</script>