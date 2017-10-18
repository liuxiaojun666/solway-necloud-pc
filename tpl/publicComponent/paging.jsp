<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="page-number">
    <span ng-if="pageSize !== 'none'" class="text">每页显示：</span>
    <select ng-model="showPageSize" ng-if="pageSize !== 'none'" ng-change="mygetData({pageIndex: 0, pageSize: showPageSize}, showPageSize == paging.pageSize)">
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="30">30</option>
        <option value="50">50</option>
        <option value="100">100</option>
    </select>
    <span class="page-num">页数{{ paging.totalPage ? paging.pageIndex + 1 : 0 }}/{{ paging.totalPage }}</span>
    <span ng-click="mygetData({pageIndex: paging.previousIndex}, paging.pageIndex == 0)" class="page-pre" ng-class="{'disabled': paging.pageIndex == 0}"><i class="fa fa-chevron-left"></i></span>
    <input ng-model="pageIndex" type="text">
    <span ng-click="mygetData({pageIndex: (pageIndex - 1) < 0 ? 0 : pageIndex - 1}, (pageIndex - 1) == paging.pageIndex || (pageIndex - 1) == -1)" class="page-go">跳转</span>
    <span ng-click="mygetData({pageIndex: paging.nextPageIndex}, paging.pageIndex == paging.totalPage - 1)" class="page-next" ng-class="{'disabled': paging.pageIndex == paging.totalPage - 1 || paging.total == 0}"><i class="fa fa-chevron-right"></i></span>
</div>
