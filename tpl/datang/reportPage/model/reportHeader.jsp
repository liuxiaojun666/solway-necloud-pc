<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.list-btn{display: inline-block;margin-right: 15px; height: 35px;width: 130px;line-height: 35px;    border: 1px solid #1cb09a;font-size: 16px;text-align: center;vertical-align: top}
.list-btn.active{    background-color: #1caf9a;
    color: #fff;}
.selected-btn{    display: inline-block;margin-right: 15px;width: 168px;height: 35px;border: 1px solid #1cb09a;}
.selected-btn.active{    background: #1cb09a;}
.selected-btn.active .selected-content{color:white;}
.selected-content{    display: inline-block;width: 123.3px;height: 100%;    line-height: 35px; color: #545454;}
.close-btn{    display: inline-block;width: 40px; height: 100%;font-size: 33px;text-align: center;background: #1cb09a;vertical-align: top;border: 1px solid #1cb09a;line-height: 31px;color: white;}
.inline-block{display:inline-block;}
#selectedList{display:none;}
</style>
<div  ng-controller="dtReportHeaderCtrl" style="margin: 10px 0;">
	<a class="list-btn" ng-class="{'active':listOrFill == 'listPage'}" ng-click="listOrFillHeaderActive('listPage')">列表数据</a>
	<span class="inline-block" id="selectedList">
		<span class="selected-btn"  ng-class="{'active':listOrFill == 'fillPage'}">
			<a class="selected-content font16 text-center" ng-click="listOrFillHeaderActive('fillPage')" ng-bind="showTitle|dataNullFilter"></a>
			<a class="close-btn" ng-click="closeCurrentTab()">×</a>
		</span>
	</span>
</div>
<script>
app.controller('dtReportHeaderCtrl',function($scope, $http, $state, $stateParams) {

	$scope.$on("fillItem",function(e,params){
    console.log(value);
		var value = params[0];
		var type = params[1];
		$("#selectedList").show();
        if(value && value.ticketNo){
            $scope.showTitle = value.ticketNo;
        }else if(value && value.busiDate){
            if(type == "commonTime"){
                $scope.showTitle = new Date(value.busiDate).Format("yyyy-MM-dd");
            }else if(type == "month"){
                $scope.showTitle = new Date(value.busiDate).Format("yyyy-MM");
            }else if(type == "week"){
                $scope.showTitle = "第"+value.weekNum+"周";
            }
        }else if(value == null){
            $scope.showTitle = "新增";
        }
    });

	$scope.$on("closeFillTab",function(){
		$("#selectedList").hide();
	});
	//切换标题
	$scope.listOrFillHeaderActive = function(value){
		$scope.$emit("changeHeaderTab",value);
	}
	
	//关闭当前header选项
	$scope.closeCurrentTab = function(){
		$("#selectedList").hide();
		$scope.$emit("changeHeaderTab","listPage");
	}
});

</script>
