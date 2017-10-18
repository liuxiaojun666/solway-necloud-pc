<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<style>
	.nav-top > li > a:hover, .nav-top > li > a:focus {
   	 background-color: transparent!important;
	}

</style>
<div class="modal fade noteModal" id="powerIndexModal" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog row modal-lg">
		<div class="modal-content col-sm-12 no-padder">
			<a class="icon-close modelCloseBtn time black-1" ng-click="hiddenModal()"></a>
			<div class="modal-body "  id="text" style="overflow-y: auto; overflow-x: hidden;">
				<div id="power_index" ng-include="showPowerIndexData"></div>
			</div>
		</div>
	</div>
</div>
