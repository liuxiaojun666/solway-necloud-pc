ajaxData({
    selectVideos: {
        name: 'GETPowerStationMonitorSelectVideos',
        data: {},
        onlyLatest: true
    },
}, {
        __serviceName__: 'themeBasicSituationVedioService'
    })('themeBasicSituationVedioCtrl', ['$scope', 'themeBasicSituationVedioService', '$http'], ($scope, myAjaxData, $http) => {
        $scope.selectVideos.subscribe((res) => {
            $scope.params = [];
            const $videosContainer = $('#videosContainer');
            res.videos.forEach((item, i) => {
                $scope.params.push({
                    station_id: item.stId,
                    stream: [
                        {
                            name: item.monitorPointName,
                            source: item.monitorPointSource,
                            dest: item.monitorPointDest
                        }
                    ]
                });
                $videosContainer.append(
                    `<embed src="vendor/flash/videoPlayer.swf" 
                        style="float: ${(i % 2) === 0 ? 'left' : 'right'}"
                        width="640" 
                        height="377"
                        controls=console
                        quality="high" 
                        bgcolor="#000000"
                        name="videoPlayer" 
                        allowfullscreen="true" 
                        pluginspage="http://www.adobe.com/go/getflashplayer" 
                        flashvars="&amp;videoWidth=0&amp;videoHeight=0&amp;dsControl=manual&amp;dsSensitivity=100&amp;serverURL=${item.monitorPointDest}&amp;DS_Status=true&amp;streamType=live&amp;autoStart=true"
                        type="application/x-shockwave-flash" />`
                );
            });
            $scope.setInterval();
        });


        
        let timer;
        $scope.setInterval = function () {
            timer = setInterval(function () {
                $scope.params.forEach(item => {
                    $http({
                        method: "POST",
                        url: $scope.selectVideos.res.VIDEO_URL,
                        timeout: 4000,
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                            // "Access-Control-Allow-Origin": "*"
                        },
                        data: item,
                    });
                });
            }, 5000);
        };
        $scope.$on('$destroy', () => {
            clearInterval(timer);
        });
    });