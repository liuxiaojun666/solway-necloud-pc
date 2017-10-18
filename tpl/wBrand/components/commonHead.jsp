<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
<style type="text/css">
    .head-warp .date-type .active{
        color: #1cb09a;
        border: none;
    }
    .head-warp .date-type span{
        cursor: pointer;
        padding: 0 10px;
    }
    .head-warp .zhibiao:hover div{
        display: block!important;
    }
    .head-warp .zhibiao p:hover{
        background-color: #1cb09a!important;
        color: #fff!important;
    }
</style>
    <div class="head-warp" style="height: 75px; padding-left: 20px; background-color: #f6f8f7; border-bottom: 1px solid #dee6e9;">
    
        <div class="pull-left zhibiao" style="margin-top: 25px;">
            <div style="width: 110px;height: 30px;position: relative;">
                <span style="display: block;width: 100%;height: 100%;background-color: #1cb09a;color: #fff;line-height: 30px;padding: 0 10px;">
                    {{ currentArea.name }}
                    <i class="glyphicon glyphicon-chevron-down" style="position: absolute;right: 10px;top: 8px;"></i>
                </span>
                <div style="position: absolute;top: 30px;left: 0;width: 110px;display: none;">
                    <p style="line-height: 30px;background-color: rgba(255,255,255,.8);color: #1cb09a;padding: 0 10px;" ng-repeat="item in arealist">{{item.name}}</p>
                </div>
            </div>
        </div>    

        <div class="pull-left zhibiao" style="margin-top: 25px;margin-left: 20px;">
            <div style="width: 110px;height: 30px;position: relative;">
                <span style="display: block;width: 100%;height: 100%;background-color: #1cb09a;color: #fff;line-height: 30px;padding: 0 10px;">
                    {{ currentIndicator.name }}
                    <i class="glyphicon glyphicon-chevron-down" style="position: absolute;right: 10px;top: 8px;"></i>
                </span>
                <div style="position: absolute;top: 30px;left: 0;width: 110px;display: none;">
                    <p style="line-height: 30px;background-color: rgba(255,255,255,.8);color: #1cb09a;padding: 0 10px;" ng-repeat="item in indicators">{{item.name}}</p>
                </div>
            </div>
        </div>

        <div class="date-type pull-left" style="margin-top: 25px;margin-left: 100px;font-size: 16px;">
            <span ng-class="dateType.currentDateType == 'day' ? 'active': ''" ng-click="changeDateType('day')" ng-if="dateType.day">日</span>
            <span ng-class="dateType.currentDateType == 'month' ? 'active': ''" ng-click="changeDateType('month')" ng-if="dateType.month">月</span>
            <span ng-class="dateType.currentDateType == 'year' ? 'active': ''" ng-click="changeDateType('year')" ng-if="dateType.year">年</span>
            <span ng-class="dateType.currentDateType == 'total' ? 'active': ''" ng-click="changeDateType('total')" ng-if="dateType.total">累计</span>
        </div>

        <div class="conditions pull-right" style="width: 255px;margin-top: 25px;position: relative;">
            <p>投产时间 > 2年</p>
            <p>投产台数 > 2台</p>
            <div toggle-div style="position: absolute;right:50px;top: 0;width: 100px;height: 50px;">
                <button style="border: none;color: #fff;background-color: #1cb09a;width: 100px;height: 40px;">筛选</button>
                <div style="display: none;position: absolute;top: 50px;right: 0;width:255px;height: 200px;background-color: #1cb09a;color: #fff;text-align: center;padding-top: 20px;">
                    <p>投产时间 > <input type="text" style="width: 50px;height: 30px;border: 1px solid #fff;background-color: transparent;text-align: center;"> 年</p>
                    <p style="margin-top: 20px;">投产时间 > <input type="text" style="width: 50px;height: 30px;border: 1px solid #fff;background-color: transparent;text-align: center; "> 年</p>
                    <button style="background-color: #fff;border: none;padding: 5px 20px;margin-top: 50px;color: #1cb09a">确定</button>
                </div>
            </div>
        </div>

        <div  style="position: absolute;left: 630px;top: 25px;min-width: 200px;">
            <div ng-if="dateType.currentDateType == 'month'" class="clearfix" ng-include="'${ctx}/tpl/datang/rtMonitorPage/model/changeMonth.jsp'">
            <div ng-if="dateType.currentDateType == 'day'" class="clearfix" ng-include="'${ctx}/tpl/datang/rtMonitorPage/model/changeDay.jsp'">
        </div>


    </div>
</div>