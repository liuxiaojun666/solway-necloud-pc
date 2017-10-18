<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" data-ng-app="app">
<head>
  <meta charset="utf-8" />
  <title ng-bind="currCompanyName | companyInfoFilter:'${currCompanyName}' + '- Powered by Solway Online'"></title>
  <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <link rel="stylesheet" href="${ctx}/vendor/bootstrap/css/bootstrap.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/animate.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/font-awesome.min.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/simple-line-icons.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/font.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/app.css" type="text/css" />
  <link rel="stylesheet" href="${ctx}/theme/css/base.css" type="text/css" />
  <link type="image/x-icon" rel="shortcut icon" ng-href="${imgPath}/{{currCompanyLogo | companyInfoFilter:'${currCompanyLogo}'}}">
</head>
<body ng-controller="AppCtrl">
  <div class="app ng-scope app-header-fixed app-aside-fixed" id="app" ng-class="{'app-header-fixed':app.settings.headerFixed,
   'app-aside-fixed':app.settings.asideFixed, 'app-aside-folded':app.settings.asideFolded,
   'app-aside-dock':app.settings.asideDock, 'container':app.settings.container}" ui-view=""></div>
  <div id="loadAnimation" class="data-bg-green"></div>
  <div id="loadinfo">正在加载中...</div>
  <!-- jQuery -->
  <script src="${ctx}/vendor/jquery/jquery.min.js"></script>
  <script type="text/javascript" src="${ctx}/theme/js/CommonPerson.js"></script>
  <script src="${ctx}/theme/js/select.js" type="text/javascript"></script>
  <script src="${ctx}/theme/js/checkSelected.js" type="text/javascript"></script>
  <script src="${ctx}/vendor/jquery/validate/jquery.form.js" type="text/javascript"></script>
  <script src="${ctx}/vendor/jquery/validate/jquery.validate.min.js"></script>
  <script src="${ctx}/vendor/jquery/validate/jquery.validate.solway.js" type="text/javascript"></script>
  <script src="${ctx}/vendor/jquery/validate/messages_cn.js" type="text/javascript"></script>
  <script src="${ctx}/vendor/jquery/validate/jquery.validate.work.js"></script>
  <!-- Angular -->
  <script src="vendor/angular/angular.min.js"></script>
  <script src="vendor/angular/angular-animate/angular-animate.js"></script>
<!--   <script src="vendor/angular/angular-cookies/angular-cookies.js"></script> -->
  <script src="vendor/angular/angular-resource/angular-resource.js"></script>
  <script src="vendor/angular/angular-sanitize/angular-sanitize.js"></script>
  <script src="vendor/angular/angular-touch/angular-touch.js"></script>
<!-- Vendor -->
  <script src="vendor/angular/angular-ui-router/angular-ui-router.js"></script>
  <script src="vendor/angular/ngstorage/ngStorage.js"></script>

  <!-- bootstrap -->
  <script src="vendor/angular/angular-bootstrap/ui-bootstrap-tpls.js"></script>
  <!-- lazyload -->
  <script src="vendor/angular/oclazyload/ocLazyLoad.js"></script>
  <!-- translate -->
  <script src="vendor/angular/angular-translate/angular-translate.js"></script>
  <script src="vendor/angular/angular-translate/loader-static-files.js"></script>
  <script src="vendor/angular/angular-translate/storage-cookie.js"></script>
  <script src="vendor/angular/angular-translate/storage-local.js"></script>

  <!-- App -->
  <script src="theme/js/app.js"></script>
  <script src="theme/js/config.js"></script>
  <script src="theme/js/config.lazyload.js"></script>
  <script id="routerJS" param="${ctx}" src="theme/js/config.router.js"></script>
  <script src="theme/js/main.js"></script>
  <script src="theme/js/services/ui-load.js"></script>
  <script src="theme/js/filters/fromNow.js"></script>
  <script src="theme/js/directives/setnganimate.js"></script>
  <script src="theme/js/directives/ui-butterbar.js"></script>
  <script src="theme/js/directives/ui-focus.js"></script>
  <script src="theme/js/directives/ui-fullscreen.js"></script>
  <script src="theme/js/directives/ui-jq.js"></script>
  <script src="theme/js/directives/ui-module.js"></script>
  <script src="theme/js/directives/ui-nav.js"></script>
  <script src="theme/js/directives/ui-scroll.js"></script>
  <script src="theme/js/directives/ui-shift.js"></script>
  <script src="theme/js/directives/ui-toggleclass.js"></script>
  <script src="theme/js/directives/ui-validate.js"></script>
  <script src="theme/js/controllers/bootstrap.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  window.BMap_loadScriptTime = (new Date).getTime();
  window.UEDITOR_HOME_URL = "${ctx}/vendor/ueditor/";
  </script>
  <script type="text/javascript" src="vendor/echarts/getscript.js"></script>
  <!-- <script type="text/javascript" src="vendor/echarts/echart-v3/echarts.min3.js"></script> -->
  <script type="text/javascript" src="vendor/echarts/echarts3.js"></script>
  <!--   <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aBsOf0A0mp32b7M6A15dvByz"></script> -->
  <!-- Lazy loading -->
</body>
</html>
