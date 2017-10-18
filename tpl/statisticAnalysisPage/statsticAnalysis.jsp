<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .nav-bottom-active{
        background-color: #1b262d;
        border-bottom: 1px solid #06bebd;
        color: #fff;
    }
    .app-content { margin-left: 0!important;}
    .app-aside {display: none!important}
</style>
<link rel="stylesheet" href="${ctx}/tpl/statisticAnalysisPage/css/solway.css" type="text/css" />
<script type="text/javascript" src="${ctx}/vendor/echarts/echarts.js"></script>
<script>
    var ctx = "${ctx}/";
</script>
<div class="col-sm-12 no-padder" ng-controller="staAllCtrl">
    <div class="col-sm-12 no-padder">
        <ul class="nav  no-padder text-center nav-black-jd m-b-sm m-t-n-md" >
            <div class="container nav  no-padder text-center nav-black-jd" style="box-shadow: 0px 0px 0px !important;">
            <li class="active" ui-sref-active="active">
                <a ui-sref='app.statistics.staDay({roleId: currentRole})' class="wrapper" ng-click="changeDate('1')">
                    <span>日</span>
                </a>
            </li>
            <li ui-sref-active="active">
                <a ui-sref='app.statistics.staMon({roleId: currentRole})' class="wrapper" ng-click="changeDate('2')">
                    <span>月</span>
                </a>
            </li>
            <li ui-sref-active="active">
                <a ui-sref='app.statistics.staYear({roleId: currentRole})' class="wrapper" ng-click="changeDate('3')">
                    <span>年</span>
                </a>
            </li>
            <li  ui-sref-active="active" >
                <a ui-sref='app.statistics.staAll({roleId: currentRole})' class="wrapper" ng-click="changeDate('4')">
                    <span>累计</span>
                </a>
            </li>
            <li class="" style="margin-left:80px;" >
                <div class="wrapper changeJt">
                    <i class="fa fa-angle-left map-jt" ng-click="dateLeft()"></i>
						<span style="font-size:18px;margin:10px;">
							<!-- <div id="expectedverifyCT" class="col-sm-12 control-label m-t-sm black-1 no-padder"></div> -->
							<span id="changeTimeId1" ng-bind="mapTimeDay| date:'yyyy/MM/dd'"></span>
							<span id="changeTimeId2" class="hidden" ng-bind="mapTimeMonth"></span>
							<span id="changeTimeId3" class="hidden m-l-sm m-r-sm" ng-bind="mapTimeYear"></span>
							<span id="changeTimeId4" class="hidden m-t-xs m-r-sm" ><span id="nowTimes"></span> - 至今</span>
						</span>
                    <i class="fa fa-angle-right map-jt"ng-click="dateRight()"  ng-class="{'effiJt':dailyJt}"></i>
                </div>
            </li>
            </div>
        </ul>
    </div>
    <div class="container no-padder" style="margin-top:40px;">
	    <div id="statcontent">
	        <div  class="col-sm-12 no-padder" ui-view ></div>
	    </div>
	
	    <div class="col-sm-12 no-padder" ng-controller="staAllRankCtrl">
	        <div class="col-sm-12 no-padder" style="margin-top:20px;" >
	            <ul class="nav col-sm-12 no-padder text-1-3x">
	                <li class="col-sm-6 no-padder" id="rank0">
	                    <span><img src="./theme/images/downScore.png" style="width: 20px; margin-top: -5px;margin-right: 5px;"/>PR效率排名前三名</span>
	                </li>
	                <li class="col-sm-6 no-padder" id="rank1">
	                    <span class="m-l-sm"><img src="./theme/images/upScore.png"  style="width: 20px; margin-top: -5px;margin-right: 5px;"/>PR效率排名后三名</span>
	                </li>
	            </ul>
	        </div>
	        <div class="col-sm-6 wrapper-sm no-padder" style="margin-top:10px;padding-right:5px!important">
	        	<div class="">
	            <div class="col-sm-12  m-b-sm bg-white-only" ng-repeat="pr in prRank" >
                    <div ng-click="showSyScore(pr.id)" class="cp" style="height:50px;">
	                <div class="d-t" style="height:50px;width: 10%">
	                    <img src="${ctx}/theme/images/statisticAnalysisPage/top.png" class="rankTop " ng-show="$index==0">
	                    <span class="d-t-c">
	                        <img src="${ctx}/theme/images/statisticAnalysisPage/1.png" class="w-30"  ng-show="$index==0"/>
	                        <img src="${ctx}/theme/images/statisticAnalysisPage/2.png" class="w-30" ng-show="$index==1"/>
	                        <img src="${ctx}/theme/images/statisticAnalysisPage/3.png" class="w-30" ng-show="$index==2"/>
	                    </span>
	                </div>
	                <div class="d-t m-l m-r" style="height:50px;width: 20%">
	                    <span class="d-t-c" ng-show="$index==0">
	                        <span class="text-center" style="color:#e9692c"><span ng-bind="pr.percen"></span>%</span>
	                        <div class="progress-xxs col-sm-12 no-padder progress m-b-sm " value="25" animate="true" type="warning">
	                            <div class="progress-bar bg-white" ng-style="{width: pr.percen + '%'}" style="background-color:#e9692c"></div>
	                        </div>
	                    </span>
	                    <span class="d-t-c" ng-show="$index==1">
	                        <span  class="text-center" style="color:#e9b623"><span ng-bind="pr.percen"></span>%</span>
	                        <div class="progress-xxs col-sm-12 no-padder progress m-b-sm " value="25" animate="true" type="warning">
	                            <div class="progress-bar bg-white" ng-style="{width: pr.percen + '%'}" style="background-color:#e9b623"></div>
	                        </div>
	                    </span>
	                    <span class="d-t-c" ng-show="$index==2">
	                        <span  class="text-center" style="color:#a9c606"><span ng-bind="pr.percen"></span>%</span>
	                        <div class="progress-xxs col-sm-12 no-padder progress m-b-sm " value="25" animate="true" type="warning">
	                            <div class="progress-bar bg-white" ng-style="{width: pr.percen + '%'}" style="background-color:#a9c606"></div>
	                        </div>
	                    </span>
	                </div>
	                <div class="d-t" style="height:50px;">
	                    <span ng-bind="pr.generatingStationName" class="d-t-c"></span>
	                </div>
                    </div>
	            </div>
	            </div>
	        </div>
	        <div class="col-sm-6 wrapper-sm no-padder" style="margin-right:0px;margin-top:10px;padding-left:10px!important">
	        	<div class="">
	            <div class="col-sm-12  m-b-sm bg-white-only"  style="margin-right:0px" ng-repeat="pr in prRankReverse" >
                    <div ng-click="showSyScore(pr.id)" class="cp" style="height: 50px;">
	                <div class="d-t m-l m-r" style="height:50px;width: 20%">
	                    <span class="d-t-c">
	                        <span class="text-center" ><span ng-bind="pr.percen"></span>%</span>
	                        <div class="progress-xxs col-sm-12 no-padder progress m-b-sm " value="25" animate="true" type="warning">
	                            <div class="progress-bar" ng-style="{width: pr.percen + '%'}"  style="background-color: #999"></div>
	                        </div>
	                    </span>

	                </div>
	                <div class="d-t" style="height:50px;">
	                    <span ng-bind="pr.generatingStationName" class="d-t-c"></span>
	                </div>
                    </div>
	            </div>
	            </div>
	        </div>
	    </div>
</div>

    <!--公用模态框-->
    <div  class="modal statModal col-sm-12 no-padder "  id="statModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg m-n">
            <div class="modal-content col-sm-12 no-padder">
                <div class="modal-body no-padder"  id="text" style="overflow-y: auto; overflow-x: hidden;">
                    <div id="statDataPageID" ng-include="statDataPage" /></div>
            </div>
        </div>
    </div>
</div>
<!--模态框结束-->
<!--公用模态框-->
<div  class="modal statModal col-sm-12 no-padder"  id="statModal2" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg m-n">
        <div class="modal-content col-sm-12 no-padder">
            <div class="modal-body no-padder"  id="text" style="overflow-y: auto; overflow-x: hidden;">
                <div id="statDataPageID2" ng-include="statDataPage2" /></div>
        </div>
    </div>
</div>
</div>
<!--模态框结束-->
</div>
<script src="${ctx}/tpl/statisticAnalysisPage/js/controllers/statisticsAll.js"></script>
