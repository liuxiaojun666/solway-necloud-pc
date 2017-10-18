<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div class="modal fade bs-example-modal-lg" id="photosModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog row modal-lg">
	      <div class="modal-content ">
	<div  class="modal-body wrapper-lg">
	<a class="icon-close modelCloseBtn" data-dismiss="modal" ></a>
	      <div class="panel b-a" set-ng-animate="false">
	        <carousel interval="myInterval">
	          <slide ng-repeat="slide in slides" active="slide.active">
	            <img ng-src="{{slide.image}}" class="img-full">
	          </slide>
	        </carousel>
	      </div>
	</div>
	</div>
	</div>
</div>
