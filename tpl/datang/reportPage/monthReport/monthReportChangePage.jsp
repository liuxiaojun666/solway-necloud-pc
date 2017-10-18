<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.weekReportChange{
		width:100%;background: white;
	}
	.weekReportChange table{
		/*width: 100%;*/
		border-collapse: collapse;
	}
	.weekReportChange table th{
		padding: 10px 0;		
		border: 1px solid #1cb09a;
	}
	.weekReportChange table td{
		border: 1px solid #bbb;
		padding: 10px 0;
	}
	.weekReportChange table .changeContent{
		width:100%;
		height: 120px;
	}
	.trBorderT{
		border-top: 1px solid #1cb09a;
	}
	.tdHeight{
		height: 130px;
	}
	.saveBtn{
	}
.save-add-workticket{color:white;width:90px;height:45px;line-height:45px;text-align:center;background:#1cb09a;font-size:16px;}
.cancel-add-workticket{width:90px;height:45px;line-height:45px;text-align:center;background:white;border:1px solid #1cb09a;color:#1cb09a;font-size:16px;}
</style>
<div ng-controller="dtMonthReportChangePageCtrl" class="weekReportChange container">
	<table class="table" > 		
 		<thead style="background: #9fe8dd;" class="trBorderT ">
			<tr class="font16 ">
		 		<th class="col-sm-2">名称：</th>
		 		<th class="col-sm-4" > {{name}} </th>
		 		<th class="col-sm-2" >时间:</th>
		 		<th class="col-sm-4">
		 			<div data-ng-include="'${ctx}/tpl/datang/reportPage/model/changeDateToMonth.jsp'"></div>
		 		</th>
			</tr>
		</thead>
		<tbody class="font16">
			<tr class="tdHeight">
				<td><label for="weekFishedId">本月完成情况</label></td>
				<td colspan="3" ><textarea class="changeContent form-control" name="weekFished" rows="3" cols="20" ng-model="updateInfo.content1"></textarea></td>
			</tr>
			<tr class="tdHeight">
				<td><label for="weekPlanId">下月工作计划</label></td>
				<td colspan="3" ><textarea id="weekPlan" class="changeContent form-control" name="weekPlan" ng-model="updateInfo.content2"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" >填报人：<span ng-bind="updateInfo.createUserName"></span></td>
				<td colspan="2" >填报时间：<span ng-bind="updateInfo.createDate|date:'yyyy-MM'"></span>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="clearfix" style="margin-bottom: 15px;"><a class="pull-right cancel-add-workticket"  ng-click="cancel()">取消</a><a class="pull-right save-add-workticket" ng-click="saveBtn()" style="margin-right:12px;">保存</a></div>
</div>
<script>
app.controller('dtMonthReportChangePageCtrl',function($scope, $http, $state, $stateParams) {

	$scope.$on("emitChangeDateToMonth",function(e,value){
		var value = new Date(value);
		$scope.currentMonth = value.getFullYear()+"-"+(value.getMonth()+1);
	});
			
	$scope.$on("fillItem",function(e,value){
		var value = value[0];
		if(value != null){//编辑
			$scope.id = value.id;
            $scope.stationId = value.stationId;
			$scope.name = value.stationName;
			//获取接口
			getEditPageInfo(value);
		}else{//新增
			$scope.id = "";
            $scope.name = $scope.currentDataName;
            $scope.updateInfo = {"content1":"","content2":""}
			//获取填报人和时间的接口
			getFillInfoData();
		}
		
	});

	function emit(value){
		$scope.$emit("childPage",value);
	};

	//取消
	$scope.cancel = function(){
		emit("");
	}

	function getFillInfoData(){
        //获取当前用户
        $http.get("${ctx}/Login/getLoginUser.htm", {
            timeout : 5000
        }).success(function(result) {
            $scope.userId = result.userId;
            //获取填报人，时间
            $.ajax({
                type:"post",
                url:"${ctx}/Login/getLoginUser.htm",
                data:{"id":$scope.userId},
                success:function(msg){
                    $scope.updateInfo = {"content1":"","content2":"","createUserName":msg.realName,"createDate":msg.currentDate};
                    $scope.$apply();
                }
            });
        })

	}
	//获取编辑的信息
	function getEditPageInfo(params){
		var dateStr = new Date(parseInt(params.busiDate));
		var date = dateStr.getFullYear()+"-"+(dateStr.getMonth()+1);
		$http({
			method : "GET",
			url : "${ctx}/rpmSummary/selectCurrData.htm",
			params : {
				'id':params.id,
				'stationId' :params.stationId,
				'dateStr':date
			}
		}).success(function(result) {
			if(result.code == 0){
                $scope.updateInfo = result.data;
            }
		});		
	}

    $scope.update = function(){
        var weekFished = $("textarea[name = weekFished]").val();
        var weekPlan = $("textarea[name = weekPlan]").val();
        $http({
            method : "POST",
            url : "${ctx}/rpmSummary/update.htm",
            params : {
                "id":$scope.id,
                "content1":weekFished,
                "content2":weekPlan,
                "busiDate":$scope.currentMonth
            }
        }).success(function(result) {
            if(result.code == 0){
                promptObj('success', '', "保存成功");
                emit("listOrFill");
            }else if(result.code == 1){
                promptObj('error', '',"保存失败");
            }
        });
    }
	$scope.saveBtn = function(){
        $http({
            method : "GET",
            url : "${ctx}/rpmSummary/hasData.htm",
            params : {
                'stationId' :$scope.stationId,
                'dateStr':$scope.currentMonth
            }
        }).success(function(result) {
            console.log(result);
            if(result.code == 2){
                promptObj('error', '',"该月已经添加过数据");
                return false;
            }else if(result.code == 0){
                $scope.update();
            }
        });

	};

});

</script>
