<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div ng-controller="economicEvaluationCtrl" class="economicEvaluation">
    <switch-power>
        <span style="margin-left: 100px;">累计</span>
    </switch-power>
    <div class="eeion-block clearfix">
        <eeion-block
            title="电价"
            content="0.5元"
            icon="dianjia"
        ></eeion-block>
        <eeion-block
            title="单位发电收益"
            content="1000万/kw"
            icon="shouyi"
        ></eeion-block>
        <eeion-block
            title="单位运维支出"
            content="200万/kw"
            icon="ywzc"
        ></eeion-block>
    </div>


    <div class="eeion-chart">
        <eeion-chart
            style="display: block;margin: 0 10px;"
        ></eeion-chart>
    </div>
</div>

<script type="text/html" id="eeion-block">
    <div>
        <div>
            <div class="left-icon">
                <i class="sprite" ng-class="icon"></i>
            </div>
            <div class="right-content">
                <h4>{{ title }}</h4>
                <p>{{ content }}</p>
            </div>
        </div>
    </div>
</script>