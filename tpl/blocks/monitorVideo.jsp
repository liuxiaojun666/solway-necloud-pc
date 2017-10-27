<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<script src="${ctx}/theme/js/RongIMLib-2.2.5.min.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/video.js" type="text/javascript"></script> 
<div ng-controller="monitorVideoCtrl">
    <div class="modal fade" id="expertSupportAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog row">
            <div class="modal-content ">
                <div class="modal-body wrapper-lg">
                    <div class="row">
                        <div class="col-sm-12">
                            <h4 class="m-t-none m-b font-thin" style="color:#000" >{{message}}</h4>
                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-10">   
                                    <button type="button" ng-click="rejectVedioPage()" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal">
                                        <strong>取消</strong>
                                    </button>
                                    <button type="button" ng-click="showVedioPage()"  class="pull-right btn m-b-xs w-xs btn-info">
                                        <strong>确定</strong>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>  
</div>  


<script type="text/javascript">


    app.controller('monitorVideoCtrl',function($scope, $http,$timeout) {
        $http({
            method : "GET",
            url : "${ctx}/AdminUser/selectById.htm",
        }).success(function(result) {
            
            $scope.cphone= result.userName;
            window.vframe.init(openVideo);
            window.vframe.token($scope.cphone);
            
        });


        function openVideo(v){
            $scope.message = v;
            $('#expertSupportAlert').modal('show');
            //弹出对话框，提示有视频连接，对口框里面暂时显示信息v，如果点击确认，执行window.vframe.accept(cphone)，否则执行window.vframe.reject();

        } 

        $scope.showVedioPage = function(){
            window.vframe.accept($scope.cphone)
        }

        $scope.rejectVedioPage = function(){
            window.vframe.reject();
        }
    
    });



</script>

