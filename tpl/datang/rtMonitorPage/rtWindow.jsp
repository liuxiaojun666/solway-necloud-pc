<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/datang/rtWindow.css">
<div class="fixed-window" ng-controller="rtWindowCtrl" ng-click="slideUp()">
    <div class="w-content" ng-click="$event.stopPropagation()">
        <div class="content-box">
            <div class="aside">
                <ul>
                    <li class="li-list active" ng-repeat="item in list track by $index" level="{{item.level}}">
                        <label class="i-checks m-b-none" id="{{item.id}}" ng-click="compute($index, item.level, this);$event.stopPropagation()"> 
                            <input type="checkbox" name="" id="" value="" ng-checked="true">
                            <i></i>
                            <span class="{{'space'+item.level}}">{{item.name}}</span>
                        </label>
                    </li>
                </ul>
            </div>
            <div class="article">
                <div class="status-bar clearfix" style="">
                    <table>
                        <tr>
                            <td ng-click="toggle = !toggle" ng-class="{'active': !toggle}">电站</td>
                            <td ng-click="toggle = !toggle" ng-class="{'active': toggle}">状态</td>
                        </tr>
                    </table>
                    <ul class="list-inline">
                        <li>
                            <label class="i-checks m-b-none" id="runing" ng-click=""> 
                                <input type="checkbox" name="" id="" value="" ng-checked="false">
                                <i></i>
                                <span class="status" ng-class="{'unchecked': !toggleState('runing')}">运行</span><span>{{stateNum('runing')}}台</span>
                            </label>
                        </li>
                        <li>
                            <label class="i-checks m-b-none" id="standby" ng-click=""> 
                                <input type="checkbox" name="" id="" value="" ng-checked="false">
                                <i></i>
                                <span class="status" ng-class="{'unchecked': !toggleState('standby')}">待机</span><span>{{stateNum('standby')}}台</span>
                            </label>
                        </li>
                        <li>
                            <label class="i-checks m-b-none" id="malfunction" ng-click=""> 
                                <input type="checkbox" name="" id="" value="" ng-checked="true">
                                <i></i>
                                <span class="status" ng-class="{'unchecked': !toggleState('malfunction')}">故障</span><span>{{stateNum('malfunction')}}台</span>
                            </label>
                        </li>
                        <li>
                            <label class="i-checks m-b-none" id="maintain" ng-click=""> 
                                <input type="checkbox" name="" id="" value="" ng-checked="true">
                                <i></i>
                                <span class="status" ng-class="{'unchecked': !toggleState('maintain')}">维护</span><span>{{stateNum('maintain')}}台</span>
                            </label>
                        </li>
                        <li>
                            <label class="i-checks m-b-none" id="offline" ng-click=""> 
                                <input type="checkbox" name="" id="" value="" ng-checked="true">
                                <i></i>
                                <span class="status" ng-class="{'unchecked': !toggleState('offline')}">离线</span><span>{{stateNum('offline')}}台</span>
                            </label>
                        </li>
                    </ul>
                </div>
                <div class="data-table">

                    <table ng-if="toggle" class="table" style="margin: 0;background-color: rgba(16,32,55,.8);">
                        <tr ng-repeat="(outerKey, outerValue) in byStatusData" class="{{outerKey}}" ng-if="toggleState(outerKey)">
                            <td style="width: 50px;text-align: center;padding: 13px;" rowspan="{{data.lenth}}">{{mapState[outerKey]}}</td>
                            <td style="padding: 0;border: none;">
                                <table border="1" class="table" style="margin: 0;min-height: 100px; background: transparent;">
                                    <tr ng-repeat="(key, value) in mapName" ng-if="toggleState(key)">
                                        <td style="width: 150px;position: relative;padding-left: 10px;">{{value.name}} <span style="position: absolute;right: 5px;">{{byStatusData[outerKey][key].length|dataNull0Filter}}台</span></td>
                                        <td style="padding: 0;vertical-align: top;"><span 
                                        class="cell" ng-repeat="item in byStatusData[outerKey][key] track by $index" class=""><i class="spritesheet {{outerKey + value.type}}"></i>{{item}}</span><span 
                                        class="cell" ng-repeat="item in spaceArr track by $index" ng-if="$index < (8 - byStatusData[outerKey][key].length % 8)">{{' '}}</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                    <table ng-if="!toggle" class="table" style="margin: 0;background-color: rgba(16,32,55,.8);">
                        <tr ng-repeat="outerItem in data" class="" ng-if="toggleState(outerItem.dzId)">
                            <td style="width: 50px;text-align: center;padding: 13px;">{{outerItem.name}}</td>

                            <td style="padding: 0;border: none;">
                                <table class="table" style="margin: 0;min-height: 150px; background: transparent;">
                                    <tr ng-repeat="(stKey, stValue) in outerItem.status" class="{{stKey}}" ng-if="toggleState(stKey)">
                                        <td style="width: 150px;position: relative;padding-left: 10px;">{{mapState[stKey]}} <span style="position: absolute;right: 5px;">{{stValue.length}}台</span></td>
                                        <td style="padding: 0;vertical-align: top;"><span 
                                        class="cell" ng-repeat="item in stValue track by $index"><i class="spritesheet {{stKey + outerItem.type}}"></i>{{item}}</span><span 
                                        class="cell" ng-repeat="item in spaceArr track by $index" ng-if="$index < (8 - stValue.length % 8)">{{' '}}</span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    app.controller('rtWindowCtrl',function($scope, $http, $state, $stateParams) {

        $scope.slideUp = function () {
            $('.fixed-window').slideUp()
        }

        $scope.$on('showWindow', function () {
        	
        	 $scope.getCurrentDeviceData();
        	
            $('.fixed-window').slideDown()
        })
        
        $scope.getCurrentDeviceData = function () {
        	$http({
				url : "${ctx}/currentPower/getCurrentDeviceData.htm",
			}).success(function(res) {
				console.log("-----");
				console.log(res);
				$scope.data = res.data.stationData;
				$scope.list = res.data.stations;
				
				$scope.mapState = {runing: '运行',standby: '待机', malfunction: '故障', maintain: '维护', offline: '离线'}

		        $scope.mapName = {}

		        $scope.spaceArr = ['','','','','','','','','']
		        console.log($scope.data)
		        console.log("=====----");
		        $scope.data.forEach(function (v, i) {
		            $scope.mapName[v.dzId] = {}
		            $scope.mapName[v.dzId]['name'] = v.name
		            $scope.mapName[v.dzId]['type'] = v.type
		        })
		        $scope.byStatusData = {
		            runing: setStatuData('runing'),
		            standby: setStatuData('standby'),
		            malfunction: setStatuData('malfunction'),
		            maintain: setStatuData('maintain'),
		            offline: setStatuData('offline')
		        }
			});
        }
        
        /* $scope.list = [
            {
                name: '集团',
                level: 0
            },
            {
                name: '北京',
                level: 1
            },
            {
                name: '青灰岭风电场',
                level: 2,
                dzId: 2
            },
            {
                name: '天津',
                level: 1
            },
            {
                name: '葛沽电站',
                level: 2,
                dzId: 3
            }
        ]

        $scope.data = [
            {
                name: '葛沽光伏电站',
                dzId: 1,
                type: 01,
                status: {
                    runing: [
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备'
                    ],
                    standby: [
                        '2号风机',
                        '2号风机',
                    ],
                    malfunction: [
                        '1号风机',
                        '2号设备',
                        '2号设备',
                        '2号设备'
                    ],
                    maintain: [
                        '1号风机',
                        '2号设备',
                        '2号设备',
                        '2号设备'
                    ],
                    offline: [
                        '2号设备',
                        '2号设备',
                        '2号设备'
                    ]
                }
            },{
                name: '青灰岭风电场',
                dzId: 2,
                type: 02,
                status: {
                    runing: [
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备'
                    ],
                    standby: [
                        '2号风机',
                        '2号风机'
                    ],
                    malfunction: [
                        '1号风机',
                        '2号设备',
                        '2号设备'
                    ],
                    maintain: [
                        '1号风机',
                        '2号设备',
                        '2号设备',
                        '2号设备'
                    ],
                    offline: [
                        '2号设备',
                        '2号设备'
                    ]
                }
            },{
                name: '葛沽电站',
                dzId: 3,
                type: 01,
                status: {
                    runing: [
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备',
                        '1号设备'
                    ],
                    standby: [
                        '2号风机',
                        '2号风机',
                        '2号风机',
                        '2号风机',
                        '2号风机',
                        '2号风机'
                    ],
                    malfunction: [
                        '1号风机',
                        '2号设备',
                        '2号设备',
                        '2号设备',
                        '2号设备'
                    ],
                    maintain: [
                        '1号风机',
                        '2号设备'
                    ],
                    offline: [
                        '2号设备',
                        '2号设备',
                        '2号设备'
                    ]
                }
            }
        ] */

        $scope.toggle = true

        $scope.toggleState = function (state) {
            return isChecked($('#'+state))
        }

        $scope.stateNum = function (state) {
            var num = 0
            for (key in $scope.mapName) {
                if ($scope.toggleState(key)) {
                    $scope.data.forEach(function (v, i) {
                        if (v.dzId == key) {
                        	if(v.status[state]){
	                            num += v.status[state].length;
                        	}else{
                        		num +=0;
                        	}
                        }
                    })
                }
            }
            return num
        }

        //避免点击事件执行两次
        $scope.clicked = false

        $scope.compute = compute

        function compute (index, level, that) {

            if (!$scope.clicked) {
                $scope.clicked = true
                return
            }

            var $li = $('.li-list').eq(index)



            var nextLi = $li.next()
            var prevLi = $li.prev()

            if ( isChecked($li) ) {
                $li.addClass('active')
                select()
            } else {
                $li.removeClass('active')
                unchecked()
            }

            $scope.clicked = false



            //选中执行函数
            function select () {

                var allChecked = true

                while (nextLi[0]) {
                    if (nextLi.attr('level') == level && !isChecked(nextLi)) {
                        allChecked = false
                        return
                    }
                    if (nextLi.attr('level') > level){
                        nextLi.addClass('active').find('[type=checkbox]').prop('checked', true)
                        nextLi = nextLi.next()
                        continue
                    }
                    break
                }


                while (prevLi[0]) {
                    if(prevLi.attr('level') == level && !isChecked(prevLi)){
                        allChecked = false
                        return
                    }
                    if (prevLi.attr('level') < level) {
                        break
                    }
                    prevLi = prevLi.prev()
                }

                if (allChecked && prevLi[0]) {
                    prevLi.addClass('active').find('[type=checkbox]').prop('checked', true)

                    $li = prevLi
                    prevLi = $li.prev()
                    nextLi = $li.next()
                    level--
                    select()
                }
            }

            //取消选中执行函数
            function unchecked (notFirst) {
                var inFlag = false
                while (prevLi[0]) {
                    if (prevLi.attr('level') == level && !isChecked(prevLi) && !inFlag) {
                        return
                    }
                    if (prevLi.attr('level') > level) {
                        prevLi = prevLi.prev()
                        inFlag = true
                        continue
                    }
                    if (prevLi.attr('level') < level) {
                        break
                    }
                    prevLi = prevLi.prev()
                }

                while (nextLi[0] && !notFirst) {
                    if (nextLi.attr('level') == level && !isChecked(nextLi)) {
                        return
                    }
                    if (nextLi.attr('level') > level) {
                        nextLi.removeClass('active').find('[type=checkbox]').prop('checked', false)
                        nextLi = nextLi.next()
                        continue
                    }
                    break
                }

                if (prevLi[0]) {
                    prevLi.removeClass('active').find('[type=checkbox]').prop('checked', false)
                    $li = prevLi
                    prevLi = $li.prev()
                    nextLi = $li.next()
                    level--
                    unchecked(true)
                }
            }
        }


        //数据操作
        function setStatuData(state) {
            var obj = {}
            $scope.data.forEach(function (v, i) {
                obj[v.dzId] = v.status[state]
            })
            return obj
        }

        //判断是否选中
        function isChecked (ele) {
            return ele.find('[type=checkbox]').prop('checked')
        }


    })
</script>
