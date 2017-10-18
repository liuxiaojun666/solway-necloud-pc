<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="powerGenerationForecastCtrl" class="powerGenerationForecast">
    <switch-power class="switch-power">
        <calendar 
            class="my-calendar"
            show-arrow="true"
            calendar-type="yyyy"
            date-time="dateTime1"
        ></calendar>
    </switch-power>

    <div class="pgf-block clearfix">
        <pgf-block
            title="去年总发电量"
            content="12000kWh"
        ></pgf-block>
        <pgf-block
            title="今年累计发电量"
            content="12000kWh"
        ></pgf-block>
        <pgf-block
            title="预计今年总发电量"
            content="12000kWh"
        ></pgf-block>
        <pgf-block
            title="今年计划发电量"
            content="12000kWh"
        ></pgf-block>
    </div>

    <div class="pgf-chart">
        <pgf-chart
            style="display: block;margin: 0 10px;"
        ></pgf-chart>
    </div>
</div>

<script type="text/html" id="pgf-block">
    <div>
        <div>
            <h4>{{ title }}</h4>
            <p>{{ content }}</p>
        </div>
    </div>
</script>