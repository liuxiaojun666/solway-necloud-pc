<%--
  User: GreenBook
  Date: 2017/6/27
  Time: 9:46
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div ng-controller="videoLiveCtrl">
    <div id="embedDiv"></div>
</div>
<script>
var timer;
app.controller('videoLiveCtrl',function($scope, $http, $state,$stateParams) {

    var embedTpl ='<embed src="${ctx}/vendor/flash/videoPlayer.swf" width="640" height="377" id="videoEmbed"' +
            'quality="high" bgcolor="#000000" name="videoPlayer" allowfullscreen="true"' +
            'pluginspage="http://www.adobe.com/go/getflashplayer"' +
            'flashvars="&amp;videoWidth=0&amp;videoHeight=0&amp;dsControl=manual&amp;dsSensitivity=100&amp;serverURL={{serverURL}}&amp;DS_Status=true&amp;streamType=live&amp;autoStart=true"' +
            'type="application/x-shockwave-flash"/>';

    $scope.$on('videoLiveItem', function(event, v) {
        $scope.VIDEO_URL = v.VIDEO_URL;
        $scope.currItem = v.video;
//        console.log('ooo', $scope.currItem)
        clearInterval(timer);

        $scope.params = {
            station_id: $scope.currItem.stId,
//            station_id: '3015',//测试电站ID
            stream: [
                {name: $scope.currItem.monitorPointName, source: $scope.currItem.monitorPointSource, dest: $scope.currItem.monitorPointDest}
            ]
        };
        $('#embedDiv').empty().append(embedTpl.replace('{{serverURL}}', $scope.currItem.monitorPointDest));
        $scope.setInterval();
    });
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
                console.info(result);
            });
        }, 5000);
    }

});
</script>