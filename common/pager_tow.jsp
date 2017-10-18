<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<div class="col-sm-12 no-padder">
	<ul class="pull-right pagination pagination-sm no-padder m-n bg-white2"
		num-pages="tasks.pageCount" current-page="tasks.currentPage"
		on-select-page="selectPage(page)" style="background-color: transparent!important;">
		<li ng-class="{disabled: noPrevious()}">
			<a ng-click="selectPrevious()"><i class="fa fa-angle-left"></i></a>
		</li> 
		<!-- <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
			<a ng-click="selectPage(page)"><span ng-bind="page"></span></a>
		</li> -->
		<li ng-class="{disabled: noNext()}">
			<a ng-click="selectNext()" style="margin-left:5px;"><i class="fa fa-angle-right"></i></a>
		</li>
	</ul>
		<span class="pull-right">
	 	<small style="float: left;margin-top:8px;" class="text-muted m-l-xs m-r-xs font-h6">每页显示 :</small>
             <select id="pageSizeSelect" style="float: left;width:45px;height:30px;padding:0px" class="form-control" ng-model="pageSizeSelect" ng-change="onSelectPage_tow(1)">
                <option value="10">10</option>
                <option value="20">20</option>
                <option value="30">30</option>
                <option value="50">50</option>
                <option value="100">100</option>
            </select>
			<small class="text-muted inline m-b-sm m-l-sm m-r-sm font-h6" style="margin-top:8px;">
			  页数<span ng-bind="currentPage"></span> / <span ng-bind="totalPage"></span>
				<!-- <span ng-bind="total"></span>条记录) -->
			</small>
		</span>
	</div>
