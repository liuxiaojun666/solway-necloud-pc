<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="map-nav pos-rlt" style="background-color: #f9fafc;box-shadow: none;border-bottom: 1px solid #ddd;">
    <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;line-height: 50px;">{{currentDataName}}</span>
    <span style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
    <div ng-transclude class="clearfix" style="display: inline-block;"></div>
    <div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
</div>