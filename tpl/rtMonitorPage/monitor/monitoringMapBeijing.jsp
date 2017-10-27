<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .toggletick .ico-active-right {color: #22c1aa;visibility: hidden;}
    .toggletick.active .ico-active-right {visibility: visible;}
</style>
<div ng-controller="mapMonitorBeijingCtrl" class="earth-bg">
    <div class="clearfix no-padder" style="height:100%;">
        <div class="map-navi clearfix">
            <div class="col-sm-3 no-padder">
                <img src="${imgPath}/{{currCompanyLogo | companyInfoFilter:'${currCompanyLogo}'}}" alt="" class="logo-img">
                <!-- <span class="font20" ng-bind="currCompanyName | companyInfoFilter:'${currCompanyName}'"></span> -->
            </div>
            <div class="col-sm-4 no-padder">
                <span class="system"><span  ng-bind="headCenterTitle"></span></span>
            </div>
            <div class="col-sm-5 no-padder">
                <ul class="header list-inline">
                    <li>
                        <a ui-fullscreen="" class="" title="全屏模式"><i class="fa fa-expand text"> </i><i class="fa fa-compress text-active"> </i></a>
                    </li>
                    <li>
                        <a class="ico-lockscreen" ng-click="lockMe();" title="锁屏"></a>
                    </li>
                    <li>
                        <i class="ico_power"></i>
                        <span class="label" data-toggle="modal" data-target="#switchPowerModal" style="margin-top: .2em;padding-bottom: .2em;display: inline-block;vertical-align: middle;">切换&gt;</span>
                    </li>
                    <li class="dropdown" dropdown>
                        <a href class="dropdown-toggle clear" dropdown-toggle>
                            <i class="ico_user"></i>
                            <span class="" ng-bind="realName"></span>
                            <!-- <span data-currentRole="currentRoleID" ng-bind="currentRoleName"></span> -->
                            <b class="caret"></b>
                        </a>
                        <!-- dropdown -->
                        <ul class="dropdown-menu animated fadeInRight w pull-right">
                            <li class="toggletick" ng-repeat="role in rolelist" ng-class="{'active': currentRoleID==role.roleId}">
                                <a ng-click="changeRole(role.roleId)" roleId="role.roleId">
                                    <i class="ico-family ico-active-right"></i>
                                    {{role.roleDisplayName}}
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <!-- <a ng-click="powerStationManage()"><i class="ico-family ico-null">&#xe604;</i>电站组管理</a> -->
                                <a data-toggle="modal" data-target="#powerStationManageModal"><i class="ico-family ico-null">&#xe604;</i>电站组管理</a>
                            </li>
                            <li>
                                <a ng-click="editUserData()"><i class="ico-family ico-null">&#xe604;</i>个人信息</a>
                            </li>
                                 <li>
                                <a ng-click="changePassword()"><i class="ico-family ico-null">&#xe604;</i>修改密码</a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a  onclick="logOut();"><i class="ico-family ico-null">&#xe604;</i>退出系统</a>
                            </li>
                        </ul>
                        <!-- / dropdown -->
                    </li>
                </ul>
            </div>
        </div>
        <!-- body地图 -->
        <div class="map-body">
            <div class="width-center con-center">
                    <div id="chinaChart" style="height:100%;"></div>
                    <div id="minMapBtn" class="hidden cp" ng-click="tiggerMapBtn()"><img src="theme/images/little_map.png"></div>
            </div>
        </div>
        <!-- 左右框 -->
        <div class="clearfix no-padder">
                <div class="width-left con-left pull-left">
                    <div class="square-con">
                        <div class="left-line1">
                            <p><img src="theme/images/common/power-icon.png" style="margin-right:4px;"><span>实时功率</span></p>
                            <p><span ng-bind="MonitorData.realTimePower[0]|dataNullFilter"></span><span style="font-size:16px;" ng-bind="MonitorData.realTimePower[1]|dataNullFilter"></span></p>
                            <p><span ng-bind="MonitorData.outputPowerRatio|dataNullFilter"></span>%</p>
                        </div>
                        <div class="left-line2 clearfix">
                            <div class="pull-left day-power">
                                <p>日发电量</p>
                                <p class="text-center"><span ng-bind="MonitorData.dayGeneratingPower[0]|dataNullFilter"></span><span style="font-size:12px;" ng-bind="MonitorData.dayGeneratingPower[1]|dataNullFilter"></span></p>
                                <!-- <p class="text-center">¥<span ng-bind="MonitorData.dayGeneratingPowerIncome[0]|dataNullFilter"></span></p> -->
                                <p class="text-center">¥<span ng-bind="MonitorData.dayGeneratingPower|incomeFilter"></span></p>
                                <p class="text-right font12"><span ng-bind="MonitorData.dayGeneratingPowerHour|dataNullFilter"></span>h</p>
                            </div>
                            <div class="pull-left month-power">
                                <p>月发电量</p>
                                <p class="text-center"><span ng-bind="MonitorData.monthGeneratingPower[0]|dataNullFilter"></span><span style="font-size:12px;" ng-bind="MonitorData.monthGeneratingPower[1]|dataNullFilter"></span></p>
                               <!--  <p class="text-center">¥<span ng-bind="MonitorData.monthGeneratingPowerIncome[0]|dataNullFilter"></span></p> -->
                               <p class="text-center">¥<span ng-bind="MonitorData.monthGeneratingPower|incomeFilter"></span></p>
                                <p class="text-right font12"><span ng-bind="MonitorData.monthGeneratingPowerHour|dataNullFilter"></span>h</p>
                            </div>
                        </div>
                        <div class="left-line3 clearfix">
                            <div class="pull-left year-power">
                                <p>年发电量</p>
                                <p class="text-center"><span ng-bind="MonitorData.yearGeneratingPower[0]|dataNullFilter"></span><span style="font-size:12px;" ng-bind="MonitorData.yearGeneratingPower[1]|dataNullFilter"></span></p>
                               <!--  <p class="text-center">¥<span ng-bind="MonitorData.yearGeneratingPowerIncome[0]|dataNullFilter"></span></p> -->
                                <p class="text-center">¥<span ng-bind="MonitorData.yearGeneratingPower|incomeFilter"></span></p>
                                <p class="text-right font12"><span ng-bind="MonitorData.yearGeneratingPowerHour|dataNullFilter"></span>h</p>
                            </div>
                            <div class="pull-left total-power">
                                <p>累计发电量</p>
                                <p class="text-center"><span ng-bind="MonitorData.accumulateGeneratingPower[0]|dataNullFilter"></span><span style="font-size:12px;" ng-bind="MonitorData.accumulateGeneratingPower[1]|dataNullFilter"></span></p>
                                <!-- <p class="text-center">¥<span ng-bind="MonitorData.accumulateGeneratingPowerIncome[0]|dataNullFilter"></span></p> -->
                                <p class="text-center">¥<span ng-bind="MonitorData.accumulateGeneratingPower|incomeFilter"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="width-right con-right pull-right">
                    <div class="square-con">
                        <div class="clearfix">
                            <div class="right-line line-right1 pull-right">
                                <p><img src="theme/images/common/station-num.png" style="vertical-align: text-top;margin-right:4px;"><span>电站数量</span></p>
                                <p><span ng-bind="MonitorData.powerStationNum|dataNullFilter"></span></p>
                                <p>总装机<span ng-bind="MonitorData.installedCapacity[0]|dataNullFilter"></span><span ng-bind="MonitorData.installedCapacity[1]|dataNullFilter"></span></p>
                            </div>
                        </div>
                        <div class="clearfix">
                            <div class="right-line line-right2 pull-right">
                                <p><span>植树</span></p>
                                <p class="text-center"><span ng-bind="MonitorData.plantedTree|dataNullFilter"></span><span style="font-size:16px;">棵</span></p>
                            </div>
                        </div>
                        <div class="clearfix">
                            <div class="right-line line-right3 pull-right">
                                <p><span>碳累计减排</span></p>
                                <p class="text-center"><span ng-bind="MonitorData.co2[0]|dataNullFilter"></span><span style="font-size:16px;" ng-bind="MonitorData.co2[1]|dataNullFilter"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <!-- footer -->
        <div class="map-footer">
            <div class="col-sm-5 no-padder footer-left">
                <span class="state-con-left" id="breakOff"><i class="white"></i><span class="state-name">中断</span><span id="breakStNum"></span></span>
                <span class="state-con"><i class="green"></i><span class="state-name">正常</span><span id="normalStNum"></span></span>
                <span class="state-con"><i class="red"></i><span class="state-name">故障</span><span id="faultStNum"></span></span>
                <span class="state-con"><i class="yellow"></i><span class="state-name">报警</span><span id="alarmStNum"></span></span>
            </div>
            <div class="col-sm-4 no-padder footer-center">
                <span id="stClassId0" class="state-con-left " ng-click="stationClassSelect('0' )"><i class="square"></i><span class="state-name">地面光伏</span></span>
                <span id="stClassId1" class="state-con " ng-click="stationClassSelect('1')"><i class="circle"></i><span class="state-name">分布式光伏</span></span>
                <span id="stClassId2" class="state-con " ng-click="stationClassSelect('2')"><i class="triangle-new"></i><span class="state-name">互用光伏</span></span>
                <span id="stClassId3" class="state-con " ng-click="stationClassSelect('3')"><i class="fan"></i><span class="state-name">风电</span></span>
            </div>
            <div class="col-sm-3 no-padder footer-right clearfix radiusMenu">
                <div class="col-sm-6 no-padder"><img src="theme/images/common/knowledge-base.png" ng-click="toKnowledge()" title="知识库"></div>
                 <div class="col-sm-6 no-padder">
                    <span style="position:relative;">
                        <img src="theme/images/common/bell.png" ng-click="toBaseMessage()" title="消息库">
                        <span class="badge badge-sm bg-danger pull-right-xs msg_center_num"></span>
                    </span>
                </div> 
                <!--<div class="text-center">
                    <span style="position:relative;">
                        <img src="theme/images/common/bell.png" ng-click="toBaseMessage()" title="消息中心">
                        <span class="badge badge-sm bg-danger pull-right-xs msg_center_num"></span>
                    </span>
                </div>-->
            </div>
        </div>
        <div class="modal fade" id="hasComInvite" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
           <div class="modal-dialog row">
                <div class="modal-content ">
                    <div class="modal-body wrapper-lg">
                        <div class="row">
                            <div class="col-sm-12">
                                <h4 class="m-t-none m-b font-thin" style="color:#000" >有公司邀请您加入，是否前往消息中心处理？</h4>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">   
                                        <button type="button" class=" m-l-sm pull-right btn m-b-xs w-xs btn-default" data-dismiss="modal"><strong>取消</strong></button>
                                        <button type="button" ng-click="toBaseMessage()" id="saveUserInformationButton" class="pull-right btn m-b-xs w-xs btn-info"><strong>确定</strong></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
    </div>
</div>
<div data-ng-include="'${ctx}/tpl/blocks/switchPower.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/powerStationManage.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/updateUserInformation.jsp'"></div>
<div data-ng-include="'${ctx}/tpl/blocks/loginUserChangePassword.jsp'"></div>
<script type="text/javascript" src="${ctx}/vendor/echarts/china-min.js"></script>
<script>
//发光城市
$(function(){
    var wHeight = $(window).height();
    $(".con-left").css("marginTop",(wHeight-440)/2);
    $(".con-right").css("marginTop",(wHeight-440)/2);
});

var normalstyle = {
        color: '#24d934',//点的颜色
        shadowColor: 'rgba(156, 74, 60, .5)',
        shadowBlur: 20
}
var falutstyle = {
        color: 'rgb(236, 67, 46)',//点的颜色
        shadowColor: 'rgba(156, 74, 60, .5)',
        shadowBlur: 20
}
var warnstyle= {
        color: 'rgb(246, 254, 57)',
        shadowColor: 'rgba(156, 74, 60, .5)',
        shadowBlur: 20
}
var breakstyle = {
        color: 'rgb(204, 204, 204)',
        shadowColor: 'rgba(204, 204, 204, .5)',
        shadowBlur: 20
}

function formatMapData(PartObj,idx) {
    var arrData = []
    var symbol = "";
    
    if(idx == 1){
        symbol = "rect";
    }else if(idx == 2){
        symbol = "circle";
    }else if(idx == 3){
        symbol = "triangle";
    }else if(idx == 4){
        symbol = "image://theme/images/WindTurbine_DJ.gif";
    }
    
    for (var j = 0; j < PartObj.data.length; j++) {
        var powerName = PartObj.data[j].name;
        var status = PartObj.data[j].status;
        var itemStyle;
        if(status == "0"){
            itemStyle =  normalstyle;
        }else if(status == "1"){
            itemStyle =  falutstyle;
        }else if(status == "2"){
            itemStyle =  warnstyle;
        }else if(status == "3"){
            itemStyle =  breakstyle;
        }
        var normalitemStyle = {normal : itemStyle};
        var obj = {
            name: powerName,
            id: PartObj.data[j].id,
            value: PartObj.data[j].value,
            symbol : symbol,
            itemStyle : normalitemStyle
        };
        //obj.value.push(PartObj.data[j]['value']);
        arrData.push(obj);
    }
    return arrData;
}
</script>
<script type="text/javascript">
$(".modal-backdrop").css("display","none")
var curIndx = 0;
var doubleClick=false;
var mapType = [ 'china',
    // 5个自治区
    '新疆', '广西', '宁夏', '内蒙古', '西藏',
    // 23个省
    '广东', '青海', '四川', '海南', '陕西', '甘肃', '云南', '湖南', '湖北', '黑龙江', '贵州', '山东',
            '江西', '河南', '河北', '山西', '安徽', '福建', '浙江', '江苏', '吉林', '辽宁', '台湾',
            // 4个直辖市
            '北京', '天津', '上海', '重庆',
            // 2个特别行政区
            '香港', '澳门' ];
var beijingMapType =  [{
                        name: '东城区',
                        value: 110871,
                        label: {
                            normal: {
                                show: false
                            }
                        }
                    }, {
                        name: '西城区',
                        value: 124558,
                        label: {
                            normal: {
                                show: false
                            }
                        }
                    }, {
                        name: '海淀区',
                        value: 90978,
                    }, {
                        name: '朝阳区',
                        value: 77642,
                    }, {
                        name: '石景山区',
                        value: 61234,
                        label: {
                            normal: {
                                show: false
                            }
                        }
                    }, {
                        name: '大兴区',
                        value: 47528,
                    }, {
                        name: '门头沟区',
                        value: 48570,
                    }, {
                        name: '昌平区',
                        value: 40335,
                    }, {
                        name: '通州区',
                        value: 47268,
                    }, {
                        name: '房山区',
                        value: 35560,
                    }, {
                        name: '丰台区',
                        value: 63413,
                    }, {
                        name: '顺义区',
                        value: 49521,
                    }, {
                        name: '怀柔区',
                        value: 35400,
                    }, {
                        name: '密云区',
                        value: 27347,
                    }, {
                        name: '延庆区',
                        value: 17942,
                    }, {
                        name: '平谷区',
                        value: 25776,
                    }]
var mt = mapType[0];
var stationMap;
var stationClassMap;
var timeTicket;
var timer2;
app.controller('mapMonitorBeijingCtrl', function($scope,$rootScope,$http, $state, $stateParams) {
    
    $rootScope.isGroup = 1;
    $rootScope.currentView = '00';
    
    $scope.$on("broadcastSwitchStation", function (event, msg) {
        $state.go($rootScope.firstMenuUrl["01"]["uisref"], {
            dataType: msg.stFlag
        });
    });
    
    //获取角色
    $http({
        method : "POST",
        url : "${ctx}/UserAuthHandle/getRoleListForPC.htm"
    }).success(function(res) {
        $scope.rolelist = res.rolelist; //用户列表
        $scope.currentRoleID = res.currentRole;//当前用户的ID‘
        $scope.roleType = res.roleType;//当前角色类型
        var currentRoleNum = getArrAtrNum($scope.rolelist, 'roleId', $scope.currentRoleID);
        $scope.currentRoleName = $scope.rolelist[currentRoleNum].roleDisplayName;//当前角色名
        
        //$scope.$emit('CtrlHeaderChange',[$scope.currentRoleID]);
    });
    
    //切换角色,默认跳到各角色的首页
    $scope.changeRole = function (Id) {
        $http({
            method : "POST",
            url : "${ctx}/UserAuthHandle/changeRoleNew.htm",
            params: {
                roleId: Id  //用户要切换的ID
            }
        }).success(function(response) {
            
            $scope.roleType = response.roleType;
            //角色
            $scope.currentRoleID = Id;//当前角色Id
            var currentRoleNum = getArrAtrNum($scope.rolelist, 'roleId', $scope.currentRoleID);
            $scope.currentRoleName = $scope.rolelist[currentRoleNum].roleDisplayName;//当前角色名

            var res = {};
            res.currCompanyName = response.comName;
            res.currCompanyLogo = response.comLogo;
            $scope.$emit("chCompanyInfo", res);
            
            if (response.roleType ==3 || response.roleType==99) {//集团管理员,系统管理员
                var uisref = getArrRealVal(response.rightlist, 'uisref');//获取第一个uisref不为空的值
                /**$scope.isRootRoleType = '0';
                $state.go(uisref, {
                    RoleId: $scope.currentRoleID
                },{reload: true});*/
                window.location.href="${ctx}/index.jsp";
            } else {//非集团系统角色
                window.location.href="${ctx}/index.jsp";
            };
        });
    };
    $scope.selectCompanyName = '全部';
    
    //更改session中 数据
    $http({
        method : "POST",
        url : "${ctx}/UserAuthHandle/goHome.htm"
    }).success(function(res) {
        
        //实时数据
        ($scope.getDayRDM = function() {
            $http({
                url : "${ctx}/MobileRtmDeviceMonitor/getRunTimeMonitor.htm",
                params: {
                    
                }
            }).success(function(res) {
                $scope.MonitorData = res;
            });
        })();
        
        //获取当前用户
        $http.get("${ctx}/Login/getLoginUser.htm", {
            timeout : 5000
        }).success(function(result) {
            $scope.loginName = result.userName;
            $scope.userId = result.userId;
            if(result.realName){
                $scope.realName = result.realName;
            }else{
                $scope.realName = result.userName;
            }
            if ($stateParams.comId) {
                $scope.selectCompanyId = $stateParams.comId;
                $scope.companyId = $stateParams.comId;
                if ($stateParams.comName != result.companyName) {
                    $scope.selectCompanyName = $stateParams.comName;
                }
            } else {
                $scope.selectCompanyId = result.companyid;
                $scope.companyId = result.companyid;
            }
            $scope.companyName = result.companyName;
            if (result.dataScope == 4) {
                getAllCustomer($http, $scope);
            }
            drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
        })
    });
    
    

    $scope.$on('$stateChangeStart', function(event) {
        $('.modal-backdrop').css("display","none");
        clearInterval(timer1);
        clearInterval(timer2);
        clearInterval(timeTicket);
    })

    $scope.roleId = $scope.currentRoleID;

    timer2 = setInterval(function() {
        $scope.$apply($scope.getDayRDM);
        //$scope.$apply($scope.refreshMap);
    }, 5000);

    //地图图例过滤
    $scope.filterMapData = function () {
        var oMapData = {};
        oMapData.normal = $scope.isUnNormal?[]:$scope.normalData;
        oMapData.fault  = $scope.isUnFault ?[]:$scope.faultData;
        oMapData.alarm  = $scope.isUnAlarm ?[]:$scope.alarmData;
        oMapData.breaks = $scope.isUnBreak ?[]:$scope.breakData;
        return oMapData;
    }
    $scope.mapAllData = function () {
        $scope.isUnAll = !$scope.isUnAll;
        if ($scope.isUnAll) {
            $scope.isUnNormal = true;
            $scope.isUnFault = true;
            $scope.isUnAlarm = true;
            $scope.isUnBreak = true;
        } else {
            $scope.isUnNormal = false;
            $scope.isUnFault = false;
            $scope.isUnAlarm = false;
            $scope.isUnBreak = false;
        }
        $scope.oMapData = $scope.filterMapData();
        drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
    }
    $scope.mapNormalData = function () {
        $scope.isUnNormal = !$scope.isUnNormal;
        $scope.oMapData = $scope.filterMapData();
        drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
    }
    $scope.mapFaultData = function () {
        $scope.isUnFault = !$scope.isUnFault;
        $scope.oMapData = $scope.filterMapData();
        drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
    }
    $scope.mapAlarmData = function () {
        $scope.isUnAlarm = !$scope.isUnAlarm;
        $scope.oMapData = $scope.filterMapData();
        drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
    }
    $scope.mapBreakData = function () {
        $scope.isUnBreak = !$scope.isUnBreak;
        $scope.oMapData = $scope.filterMapData();
        drawMap($scope.selectCompanyId, $http, $scope,mt, $scope.oMapData);
    }
    $scope.tiggerMapBtn = function(){
        $("#minMapBtn").addClass("hidden");
        doubleClick=true;
        mt = 'china';
        curIndx = 0;
        drawMap($scope.companyId, $http, $scope,mt,$scope.oMapData);
    }


    //进入电站监控
    $scope.showStationMonitor = function(){
        $http({
            method : "POST",
            url : "${ctx}/UserAuthHandle/changeDataType.htm",
            params: {
                id: clickStationId,
                dataType: 0,
                stClass : clickStationClass,
                isGroup : '0'
            }
        }).success(function(res) {
            $state.go($rootScope.firstMenuUrl[clickStationClass]["uisref"], {
                stationId : clickStationId
            });
            
        });
        
    }



    //消息中心
    $scope.toBaseMessage = function() {
        $http({
            method : "POST",
            url : "${ctx}/UserAuthHandle/setSTClass.htm",
            params: {
            }
        }).success(function(res) {
            $state.go("app.note", {
                recuserId : $scope.userId
            });
        });
        
    }
    $scope.toKnowledge = function () {
        $http({
            method : "POST",
            url : "${ctx}/UserAuthHandle/setSTClass.htm",
            params: {
            }
        }).success(function(res) {
            $state.go('app.knowledgeBaseSummary');
        });
    }
    $scope.toMonitoring = function () {
        $state.go($rootScope.firstMenuUrl["01"]["uisref"]);
    }
    $scope.toIncomeSettlement = function () {
        $state.go('app.incomeSettlement');
    }
    $scope.toAnalyze = function () {
        $state.go('analyzeHome');
    }
    $scope.toPowerStationView = function () {
        $state.go('app.powerStationView');
    }

    //锁屏
    $scope.lockMe = function() {
        $.ajax({
            url: '${ctx}/Login/logout.htm',
            type: 'POST',
            data: {},
        })
        .done(function(msg) {
            $state.go("lockme", {
                loginName : $scope.loginName,
                realName : $scope.realName
            });
        })
    }
    $scope.editUserData=function(){
        initPageDataUserMod($scope.userId);
        $('#userInformationUpdateModel').modal('show');
    }
    $scope.changePassword=function(){
        $('#userPasswordChangeModel').modal('show');
    }
    $scope.powerStationManage = function(){
        $('#powerStationManageModal').modal('show');
    }
    
    //判断是否有邀请 TODO
    $scope.hasCompanysInvite = function() {
        var storage = window.localStorage;
        var hasComInvite = storage["hasComInvite"];
        if(hasComInvite && hasComInvite == 1){
            $http({
                method : "POST",
                url : "${ctx}/BaseMessage/queryUserValidComInvite.htm",
                params: {
                }
            }).success(function(res) {
                var storage = window.localStorage;
                storage["hasComInvite"] = 0;
                if(res && res.code == 1 && res.data.length > 0){
                    $('#hasComInvite').modal('show');
                }
            });
        }
        
    }
    
    $scope.hasCompanysInvite();
    
    var staticClassMap = {
            "0" : '地面光伏',
            "1" : '分布式光伏',
            "2" : '户用光伏',
            "3" : '风电',
    }
    $scope.stationClassSelect = function (idx ) {
        var op = myChart.getOption();
        var isActive = $("#stClassId"+idx).hasClass("stClassNoActive");
        if(isActive){
            $("#stClassId"+idx).removeClass("stClassNoActive");
            op.legend[0].selected[staticClassMap[idx]] = true;
        }else{
            $("#stClassId"+idx).addClass("stClassNoActive");
            op.legend[0].selected[staticClassMap[idx]] = false;
        }
        myChart.setOption(op ,true);
        
    }
    
});
function refreshMap(){
        $.ajax({
            type : "post",
            url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationStatusDataNew2.htm",
            async : false,
            success : function(result) {
                //console.log(result);
                    stationMap = new MapDef();
                    stationClassMap = new MapDef();
                    var op = myChart.getOption();
                    if(result){
                        $("#normalStNum").html(result.normalNum);
                        $("#faultStNum").html(result.faultNum);
                        $("#alarmStNum").html(result.warnNum);
                        $("#breakStNum").html(result.breakNum);
                        
                        if(result.data && result.data.length ){
                            for (var i = 0; i < result.data.length; i++) {
                                var resdata = result.data[i].data;
                                if (resdata != null && resdata.length > 0) {
                                    for (var j = 0; j < resdata.length; j++) {
                                        var pst = resdata[j];
                                        stationMap.put(pst.name, pst.id);
                                        stationClassMap.put(pst.id, pst.stClass);
                                    }
                                }
                                
                                var resName = result.data[i].name;
                                if(resName =="地面"){
                                    op.series[0].data = formatMapData(result.data[i],"1");
                                }else if(resName =="分布"){
                                    op.series[1].data = formatMapData(result.data[i],"2");
                                }else if(resName =="户用"){
                                    op.series[2].data = formatMapData(result.data[i],"3");
                                }else if(resName =="风电"){
                                    op.series[3].data = formatMapData(result.data[i],"4");
                                }
                                
                            }
                            
                        }
                    }
                    myChart.setOption(op,true);
            }
        
    });
    //return option;
};
var myChart;
function drawMap(companyId, $http, $scope,mt, oMapData) {
    myChart = echarts.init(document.getElementById('chinaChart'));
    $.get('vendor/echarts/beijingMap.json', function (beijingJson) {
        echarts.registerMap('beijingMap', beijingJson);
        if(navigator.userAgent.indexOf("Firefox")>0){
            $(myChart._dom).height(window.innerHeight);
            myChart.resize();
        }
        window.addEventListener("resize", function() {
            if(navigator.userAgent.indexOf("Firefox")>0){
                $(myChart._dom).height(window.innerHeight);
                myChart.resize();
            }else{
                myChart.resize();
            }
            
        });
        var option = {
            tooltip : {
                trigger: 'item',
                formatter: '{b}'
            },
            grid : {
                x : '5px',
                x2 : '5px',
                y : "10px",
                y2 : "5px"
            },
            legend:{
                show:false,
                data:["地面光伏" , "分布式光伏","户用光伏","风电"]
            },
            geo: {
                map: 'beijingMap',
                roam: true,
                zoom:1,
                label: {
                    normal: {
                        show: true,
                        textStyle: {
                            color: "#04B1B0"//省份颜色
                        }
                    }
                },
                itemStyle: {
                    normal: {
                        areaColor: 'rgba(0,0,0,0.6)',
                        borderColor: '#52e7c8'
                    },
                    emphasis: {
                        areaColor: '#2a333d'
                    }
                },
                regions: [{
                    name: '怀柔区',
                    label: {
                        normal: {
                            show: true,
                            textStyle: {
                                color: "white"//省份颜色
                            }
                        }
                    },
                    itemStyle: {
                        normal: {
                            areaColor: 'rgba(42,51,61,1)',
                            color: 'rgba(82,231,200,0.4)'
                        }
                    }
                }]

            },

            series : [
                      {
                        name: '地面光伏',
                        //type: 'map',
                        //mapType: 'china',
                        type: 'scatter',
                        coordinateSystem: 'geo',
                        roam: false,
                        symbolSize: 8
                      },
                      {
                          name: '分布式光伏',
                          type: 'scatter',
                          coordinateSystem: 'geo',
                          roam: false,
                          symbolSize: 8,
                        //symbol: 'circle',
                          data: []
                      },
                      {
                          name: '户用光伏',
                          type: 'scatter',
                          coordinateSystem: 'geo',
                          roam: false,
                          symbolSize: 8,
                          //symbol: 'triangle',
                          data: []
                      },
                      {
                          name: '风电',
                          type: 'scatter',
                          coordinateSystem: 'geo',
                          roam: false,
                          symbolSize: 15,
                        //symbol: 'image://url',
                          data: []
                      }]
        };
        myChart.setOption(option,true);
        refreshMap();
        // 为echarts对象加载数据
        if(!timeTicket){
            timeTicket = setInterval(function (){
                refreshMap();
                //myChart.setOption(option);
            },5000);
        }

        // var ecConfig = require('echarts/config');
        //点击事件，判断是点击点 还是点击区域

        //var zrEvent = require('zrender/tool/event');
        myChart.on('click', function(param) {
            if (stationMap.get(param.name) != null) {//点击电站显示弹出层
                //alert('电站')
                clickMapArea(param, stationMap.get(param.name));
                
            } else {//返回全国
                //console.log("返回哪里")
                //curIndx = 0;
                //mt = 'china';
            }
            
            //option.geo.map = mt;
            //option.title.subtext = mt + ' （滚轮或点击切换）';
            //myChart.setOption(option, true);
        });

        //双击跳转到电站界面
        myChart.on('dblclick', function(param) {
            return;
            //closeMap();
            if (mapType.indexOf(param.name) >= 0) {
                var len = mapType.length;
                mt = mapType[curIndx % len];
                if (mt == 'china') {//点击全国地图中的省份进入该省地图
                    for ( var i in mapType) {
                        if (mapType[i] == param.name) {
                            mt = mapType[i];
                            curIndx = i;
                            break;
                        }
                    }
                    doubleClick=false;
                    $("#minMapBtn").removeClass("hidden");
                    option.geo.map = mt;
                    myChart.setOption(option, true);
                    refreshMap();
                }
            }else if (mapType.indexOf(param.name) < 0){
                //if(stationMap.get(param.name)){
                    //clickStationId = stationMap.get(param.name);
                    //$scope.showStationMonitor()
                //}
            }
        });
    })
    /**/
    
    
}
function closeMap() {
    //$("#showMap").css("left", "-999px");
    $('#showMap').modal("hide");
    $("#upJt").css("display", "none");
    $("#downJt").css("display", "none");
}
var clickStationId = null;
var clickStationClass = null;
function clickMapArea(param, id, ecConfig) {
    var xPos, yPos;
    var e = param.event || window.event;
    xPos = e.offsetX + document.body.scrollLeft
            + document.documentElement.scrollLeft  - 150;
    yPos = e.offsetY + document.body.scrollTop
            + document.documentElement.scrollTop - 360;
    $.ajax({
                type : "post",
                url : "${ctx}/MobileRtmDeviceMonitor/getPowerStationModalShowData.htm",
                data : {
                    "id" : id
                },
                success : function(msg) {
                    $("#myModalLabelName").html(param.name);
                    clickStationId = id;
                    clickStationClass = stationClassMap.get(id);
                    if(msg.factPic){
                        $("#stationModalImg").attr(
                                "src",
                                "${imgPath}/document/powerStationPicture/"
                                        + msg.factPic);
                    }else{
                        if(clickStationClass == '01'){
                            $("#stationModalImg").attr("src","${ctx}/theme/images/dailybg.jpg");
                        }else if(clickStationClass == '02'){
                            $("#stationModalImg").attr("src","${ctx}/theme/images/defaultWP.png");
                        }
                    }
                    if(msg.powerData.realTimePower){
                        $("#stationActPwr").html(msg.powerData.realTimePower[0]+ msg.powerData.realTimePower[1]);
                    }else{
                        $("#stationActPwr").html("-");
                    }
                    if(msg.powerData.dayGeneratingPower){
                        $("#stationDayPower").html(msg.powerData.dayGeneratingPower[0]+ msg.powerData.dayGeneratingPower[1]);
                    }else{
                        $("#stationDayPower").html("-");
                    }
                    if(msg.powerData.monthGeneratingPower){
                        $("#stationMonthPower").html(msg.powerData.monthGeneratingPower[0]+ msg.powerData.monthGeneratingPower[1]);
                    }else{
                        $("#stationMonthPower").html("-");
                    }
                    if(msg.powerData.yearGeneratingPower){
                        $("#stationYearPower").html(msg.powerData.yearGeneratingPower[0]+ msg.powerData.yearGeneratingPower[1]);
                    }else{
                        $("#stationYearPower").html("-");
                    }
                    //判断状态
                    if(msg.powerData.comm==1){
                        $("#stationStatus").html("<span class='black-5'>通讯中断</span>")
                    }else if(msg.powerData.comm==2){
                        $("#stationStatus").html("<span class='black-5'>初始化</span>")
                    }else{
                        if(msg.powerData.status==1){//故障
                            $("#stationStatus").html("<span class='map-red'>故障</span>")
                        }else if(msg.powerData.status==2){//报警
                            $("#stationStatus").html("<span class='map-yellow'>报警</span>")
                        }else {//正常
                            $("#stationStatus").html("<span class='map-green'>正常运行</span>")
                        }
                    }
                    //$('#myModal').modal({keyboard : true});
                    if (yPos < 0) {

                        $("#showMap").css({"left" : xPos,"top" : Math
                            .abs(e.clientY
                            + document.body.scrollTop
                            + document.documentElement.scrollTop) + 25
                        });
                        $("#downJt").css("display", "none");
                        $("#upJt").css("display", "block");
                        $('#showMap').modal("show");
                    } else if (xPos < 0) {
                        $("#showMap")
                                .css({"left" : Math.abs(e.clientX
                                        + document.body.scrollLeft
                                        + document.documentElement.scrollLeft) - 10,
                                        "top" : yPos});
                        $('#showMap').modal("show");
                    } else {
                        $("#showMap").css({"left" : xPos,"top" : yPos});
                        $("#upJt").css("display", "none");
                        $("#downJt").css("display", "block");
                        $('#showMap').modal("show");
                    }
                },
                error : function(json) {
                    //alert("保存失败,请稍后重试!");
                }
            });
}

//退出登录
function logOut(){
    $.ajax({
        type:"post",
        url:"${ctx}/Login/logout.htm",
        timeout : 5000,
        data:{},
        success:function(msg){
            window.location.href="${ctx}/login.jsp";
        },
        error:function(msg){
            window.location.href="${ctx}/login.jsp";
        }
    });
}

//消息中心
getNoticeCount1();
timer1 = setInterval(getNoticeCount1,5000)
function getNoticeCount1(){
    $.ajax({
        type : "POST",
        url : "${ctx}/BaseMessage/getNoReadBaseMessageCount.htm",
        data : {
            'searchKey':'',
            isRorS:true
        },
        success:function(result) {
            if(result > 0) {
                $(".msg_center_num").html(result);
            }else{
                $(".msg_center_num").html("");
            }
        }
    });
};

//根据数组中每项的每个属性的值查找在数组中的排序，找不到返回-1
function getArrAtrNum(arr, atr, value) {//getArrAtrNum([{id:1},{id:2}], "id", 3)
    for (var i = 0; i < arr.length; i++) {
        if (arr[i][atr] == value) {
            return i;
        }
    }
    return -1;
};
function getArrAtrNum2(arr, atr, value) {
    for (var i = 0; i < arr.length; i++) {
        if (arr[i][atr].substr(0,2) == value) {
            return i;
        }
    }
    return -1;
};
app.controller('oneStationMonitorCtrl', function($scope, $http, $state,$rootScope) {
    //进入电站监控
    $scope.showStationMonitor = function() {
        
        $http({
            method : "POST",
            url : "${ctx}/UserAuthHandle/changeDataType.htm",
            params: {
                id: clickStationId,
                dataType: 0,
                stClass : clickStationClass,
                isGroup : '0'
            }
        }).success(function(res) {
            $state.go($rootScope.firstMenuUrl[clickStationClass]["uisref"], {
                stationId : clickStationId
            });
        });
    }
});
</script>

<!-- 地图弹出层 -->
<!-- <div id="showMap"> -->
<div class="modal fade "id="showMap" tabindex="-1" role="dialog"aria-labelledby="myModalLabel" aria-hidden="true" >
<div class="modal-dialog modal-sm m-n" ng-controller="oneStationMonitorCtrl">
    <div id="upJt" class="upJt">
        <img src="${ctx}/theme/images/solway/icon/up.png" />
    </div>
    <div class="modal-content white-trans-70 modal-map">
        <div class="modal-header wrapper-sm">
            <button type="button" class="close green-new" onclick="closeMap()">×</button>
            <span class="modal-title font-h3" id="myModalLabelName"></span>
            <span class="font-h6 green-new a-cur-poi  m-l"
                ng-click="showStationMonitor();">进入电站 >></span>
        </div>
        <div class="modal-body no-padder">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel-body wrapper-sm" style="padding-bottom: 0px">
                        <div class="col-sm-12 no-padder white-1 font-h4">
                            <img id="stationModalImg" class="no-padder control-label"
                                style="width: 100%; height: 100px;" src="">
                        </div>
                        <div class="col-sm-12 no-padder" style="line-height: 40px;border-bottom: 1px solid rgba(0, 0, 0,.4);">
                                <span class="m-r-xs white-1">运行状态</span> 
                                <span id="stationStatus"></span>
                        </div>
                        <div class="col-sm-12 no-padder" style="line-height: 40px;">
                            <span class="white-1 font-h3">实时功率</span> <span
                                class="m-l-sm font-h2 data-orange" id="stationActPwr"></span> 
                        </div>
                        <div class="col-sm-12 no-padder white-1 font-h3"
                            style="line-height: 30px;">
                            <span class="col-sm-4 no-padder">
                                <div>日发电量</div>
                                <div class="font-h2 data-green" id="stationDayPower"></div>
                            </span> <span class="col-sm-4 no-padder">
                                <div>月发电量</div>
                                <div class="font-h2 data-blue" id="stationMonthPower"></div>
                            </span> <span class="col-sm-4 no-padder">
                                <div>年发电量</div>
                                <div class="font-h2 data-yellow" id="stationYearPower"></div>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="downJt" class="downJt">
            <img src="${ctx}/theme/images/solway/icon/down.png" />
        </div>
    </div>
    <!-- /.modal-dialog -->
</div>
</div>
