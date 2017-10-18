<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="my-table" ng-class="{'scroll-y': scrollY}">
    <div class="my-table-head">
        <table>
            <thead>
                <th 
                    ng-repeat="item in column"
                    style="width:{{ item.width }};text-align: {{ item.align || 'left' }};cursor: {{item.sort ? 'pointer': ''}};"
                    ng-click="sort(item.sort, item.dataIndex)"
                    >
                    {{ item.title }}
                    <span ng-if="item.dataIndex == orderByDataIndex">
                        <i ng-if="!orderBy" class="fa fa-angle-up"></i>
                        <i ng-if="orderBy" class="fa fa-angle-down"></i>
                    </span>
                </th>
            </thead>
        </table>
    </div>
    <table ng-if="!datasource[0]">
        <tbody>
            <tr>
                <td style="text-align: center;">暂无数据</td>
            </tr>
        </tbody>
    </table>
    <div class="my-table-body" style="max-height: {{scrollY + 'px'}}">
        <table>
            <tbody>
                <tr 
                    ng-repeat="outerItem in datasource track by $index" 
                    ng-init="outerIndex=$index"
                    ng-click="trClick(outerItem, outerIndex)">
                    <td 
                        ng-repeat="item in column"
                        ng-bind-html="item.render ? item.render(outerItem[item.dataIndex], outerItem, outerIndex) : outerItem[item.dataIndex]" 
                        style="width:{{ item.width }};text-align: {{ item.align }};"
                        >
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>