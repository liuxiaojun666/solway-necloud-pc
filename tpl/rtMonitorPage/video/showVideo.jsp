<%--
  User: GreenBook
  Date: 2017/6/26
  Time: 9:49
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css" />
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>
<style>
.video-icon{display:inline-block;width:26px;height:22px;background:url("theme/images/common/video-grey.png") no-repeat;}
.video-icon.active{background:url("theme/images/common/video-green.png") no-repeat;}
.video-name{color:#717171;}
.video-name.active{color:#10cbb4;}
.pointer{cursor:pointer;}
input[type="radio"]{
    display: none;
}

label:before{
    display: inline-block;
    content: "";
    width: 14px;
    height: 14px;
    padding: 2px;
    border-radius: 50%;    vertical-align: middle;
    border: 2px solid rgb(233,233,233);
}

input[type="radio"]:checked + label:before{
	background-color:#10cbb4;
	border: 2px solid #10cbb4;
    background-origin: content-box, padding-box;
    background-clip: content-box, padding-box;
    vertical-align: middle;
}
.time-con{border:1px solid #565656;    line-height: 28px;height: 30px;display: inline-block;margin-left:10px;}
.time-con >.time-label{
    background: #b7b7b7;
    line-height: 31px;
    height: 28px;
    display: inline-block;
    padding: 0 10px;
}
.time-con .arrow-down-con{
    display: inline-block;
    width: 20px;
    text-align: center;
    vertical-align: top;
}
.modal-open {
    overflow-y: auto;
}
</style>
<div ng-controller="videoListCtrl" style="overflow-y:auto;">
    <div class="wrapper-md bg-light b-b">
        <span class="font-h3 blue-1 m-n text-black" style="padding-left: 10px;">{{currentDataName | companyInfoFilter:parentName}}</span>
        <span  style="cursor:pointer;color: #428bca;" data-toggle="modal" data-target="#switchPowerModal" >[切换]</span>
    </div>
    <!-- <div class="row">
        <div class="col-sm-12 panel no-padder" style="padding: 10px 0 !important;">
            <a class="btn btn-info " ng-repeat="item in items" ng-bind="item.monitorPointName" ng-click="liveVideo(item)" style="margin: 5px"></a>
            <div class="col-sm-2 no-padder text-center pointer" ng-repeat="item in items"  ng-click="liveVideo(item,$index)">
            	<div style="margin-bottom: 10px;"><span class="video-icon" ng-class="{'active':activeIndex == $index}"></span></div>
            	<p ng-bind="item.monitorPointName" class="video-name" ng-class="{'active':activeIndex == $index}"></p>
            </div>
        </div>
    </div> -->
    
	<div class="text-center" style="background:white;margin-bottom: 1rem;padding-top: 1rem;">
		<span class="pointer" style="width:16%;display:inline-block;margin-bottom: 20px;" ng-repeat="item in items"  ng-click="liveVideo(item,$index)">
			<div style="margin-bottom:5px;"><span class="video-icon" ng-class="{'active':activeIndex == $index}"></span></div>
           	<p ng-bind="item.monitorPointName" class="video-name" ng-class="{'active':activeIndex == $index}"></p>
        </span>
        <p ng-show="items.length <= 0 ">暂无摄像头</p>
    </div>
    <div class="clearfix" style="background: white;">
    	<!--<div class="clearfix" style="width: 750px;margin: 20px auto;height: 32px;text-align:center;">
    		<div class="pull-left" style="width:10%;line-height: 31px;text-align:left;">
    			<input type="radio" id="realtime" name="videoTime" checked="checked" value="realtime">
				<label for="realtime">
					<span style="padding-bottom:1em;vertical-align: middle;">实时</span>
				</label>
    		</div>
    		  <div class="pull-right"  style="width:90%;line-height: 31px;text-align:right;">
    			<input type="radio" id="history" name="videoTime" value="history">
				<label for="history">
					<span style="padding-bottom:1em;vertical-align: middle;">历史</span>
				</label>
				<span>
					<span class="time-con">
						<span class="time-label">开始时间</span>
						<span class="input-append date form_datetime" id="changeTimeIdTimer-day-begin" data-link-field="date-day-begin">
							<input type="hidden" id="date-day-begin" value="" />
							<span id="showDate-day-begin" class="showdate  font-h2" ng-bind="mapTimeDay | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
						<span class="arrow-down-con"><img src="theme/images/common/arrow-down.png"></span>
					</span>
					<span class="time-con">
						<span class="time-label">结束时间</span>
						<span class="input-append date form_datetime" id="changeTimeIdTimer-day-end" data-link-field="date-day-end">
							<input type="hidden" id="date-day-end" value="" />
							<span id="showDate-day-end" class="showdate  font-h2" ng-bind="mapTimeDay | date:'yyyy-MM-dd hh:mm:ss'"></span>
						</span>
						<span class="arrow-down-con"><img src="theme/images/common/arrow-down.png"></span>
					</span>
					<a class="btn btn-info" ng-show="historyTime" style="padding: 4px 10px;vertical-align: top;margin-left:5px;">查询</a>
				</span>
    		</div>
    	</div>-->
        <div class="col-sm-12 text-center" id="embedDiv">
			
        </div>
    </div>
    <div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
</div>


<script>
    var timer;
    app.controller('videoListCtrl',function($scope, $http, $state,$stateParams) {

    	$scope.historyTime = false;
    	$("input[name = 'videoTime']").click(function(){
    		var html = $(this).siblings("label").find("span").html();
    		if(html == "历史"){
    			$scope.historyTime = true;
    		}else{
    			$scope.historyTime = false;
    		}
    		$scope.$apply();
    	});
    	
    	var rightDay2 = new Date();
		rightDay2.setDate(rightDay2.getDate() - 1);
		$scope.mapTimeDay = rightDay2;
		
		
    	//点击选择时间-开始
    	$("#changeTimeIdTimer-day-begin").datetimepicker({
    		language : 'zh-CN',
    		format : "yyyy-mm-dd hh:ii:ss",
    		minuteStep:10,
    		//minView : 2,
    		autoclose : true,
    		todayBtn : true,
    		endDate : $scope.today,
    		initialDate : $scope.mapTimeDay,
    		pickerPosition : "bottom-left"
    	});
    	
    	//选择完日期，关闭时触发（日）-开始
    	$("#changeTimeIdTimer-day-begin").on('hide',function(ev) {
    		var stringTime = $("#date-day-begin").val();//2016-08-31 14:12:57
    		if(stringTime){
    			var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
    			$scope.mapTimeDay = new Date(timestamp);
    			$("#showDate-day-begin").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
    		}
    	
    	});
    			
    	//点击选择时间 -结束
    	$("#changeTimeIdTimer-day-end").datetimepicker({
    		language : 'zh-CN',
    		format : "yyyy-mm-dd hh:ii:ss",
    		minuteStep:10,
    		autoclose : true,
    		todayBtn : true,
    		endDate : $scope.today,
    		initialDate : $scope.mapTimeDay,
    		pickerPosition : "bottom-left"
    	});
    	
    	//选择完日期，关闭时触发（日）-结束
    	$("#changeTimeIdTimer-day-end").on('hide',function(ev) {
    		var stringTime = $("#date-day-end").val();//2016-08-31 14:12:57
    		if(stringTime){
    			var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
    			$scope.mapTimeDay = new Date(timestamp);
    			$("#showDate-day-end").text(new Date(timestamp).Format("yyyy-MM-dd hh:mm:ss"));
    		}
    	
    	});
    			
        $scope.getCurrentDataName('00',0);
        $scope.$on('broadcastSwitchStation', function(event, data) {
        	
        	$scope.historyTime = false;
        	$scope.activeIndex = null;
			$($('#realtime').eq(0)).prop('checked',true);
			
            $scope.currentDataName = data.dataName;
            $scope.getPowerStation();
            $('#embedDiv').empty();
            
            //$scope.$apply();
            
        });
        $scope.getPowerStation = function () {
            $http({
                method : "POST",
                url : "${ctx}/PowerStationMonitor/selectVideos.htm",
            }).success(function(result) {
                $scope.items = result.videos;
                $scope.VIDEO_URL = result.VIDEO_URL;
            });
        }
        $scope.getPowerStation();

        var embedTpl ='<embed src="${ctx}/vendor/flash/videoPlayer.swf" width="640" height="377" id="videoEmbed"' +
            'quality="high" bgcolor="#000000" name="videoPlayer" allowfullscreen="true"' +
            'pluginspage="http://www.adobe.com/go/getflashplayer"' +
            'flashvars="&amp;videoWidth=0&amp;videoHeight=0&amp;dsControl=manual&amp;dsSensitivity=100&amp;serverURL={{serverURL}}&amp;DS_Status=true&amp;streamType=live&amp;autoStart=true"' +
            'type="application/x-shockwave-flash"/>';
        $scope.liveVideo = function (item,index) {
            clearInterval(timer);

            //点击当前视频按钮高亮显示
            $scope.activeIndex = index;
            
            $scope.currItem = item;
            $scope.params = {
                station_id: item.stId,
//                station_id: '3015',//测试电站ID
                stream: [
                    {name: item.monitorPointName, source: item.monitorPointSource, dest: item.monitorPointDest}
                ]
            };
            $('#embedDiv').empty().append(embedTpl.replace('{{serverURL}}', item.monitorPointDest));
            $scope.setInterval();
        };
        $scope.$on('$stateChangeStart', function(event) {
            clearInterval(timer);
        });
        $scope.setInterval = function() {
            timer = setInterval(function() {
                $http({
                    method : "POST",
                    url : $scope.VIDEO_URL,
                    timeout: 4000,
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    data: $scope.params
                }).success(function(result) {
                });
            }, 5000);
        }

    });
    function getDateForStringDate(strDate){
    	//切割年月日与时分秒称为数组
    	var s = strDate.split(" ");
    	var s1 = s[0].split("-");
    	var s2 = s[1].split(":");
    	if(s2.length==2){
    		s2.push("00");
    	}
    	return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
    }
</script>