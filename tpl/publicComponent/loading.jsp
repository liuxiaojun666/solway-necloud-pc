<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div>
  <div ng-transclude class="clearfix" style="height:100%;"></div>
  <div class="loding-view" ng-if="dLoding" style="position:absolute;width:100%;height:100%;top:0;left:0;z-index:9999;text-align:center;background:rgba(255,255,255,.8)">
    <div class="spinner">
      <div class="rect1"></div>
      <div class="rect2"></div>
      <div class="rect3"></div>
      <div class="rect4"></div>
      <div class="rect5"></div>
    </div>
  </div>
</div>