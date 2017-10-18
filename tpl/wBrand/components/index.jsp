<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript" src="${ctx}/vendor/echarts/echarts.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/echarts/china.js"></script>

<script src="${ctx}/theme/js/api.js" type="text/javascript"></script>

<script src="${ctx}/theme/js/wBrand/index.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/wBrand/commonHead.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/wBrand/wBrand.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/wBrand/wMap.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/wBrand/wLine.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/wBrand/bar-chart.js" type="text/javascript"></script>

<div class="" ng-controller="wBrandCtrl" style="min-width: 100px;overflow: auto;">

    <common-head 
        style="position: relative;z-index: 10;"
        >
    </common-head>

    <div class="clearfix" style="" d-loding="isLoding">

        <w-brand class="col-xs-4" style="height: 400px;padding: 10px"></w-brand>

        <div class="col-xs-8" style="height: 400px;padding: 10px;position: relative;">
            
            <div style="position: absolute;right: 50px;top: 40px;z-index: 100;cursor: pointer;">
                <span ng-click="mapOrLine='map'">map</span>
                <span ng-click="mapOrLine='line'">line</span>
            </div>

            <w-map ng-if="mapOrLine=='map'"></w-map>

            <w-line ng-if="mapOrLine=='line'"></w-line>
        </div>

        <div class="">
            <bar-chart class="col-xs-4" style="height: 300px;padding: 10px;"></bar-chart>
            <bar-chart class="col-xs-4" style="height: 300px;padding: 10px;"></bar-chart>
            <bar-chart class="col-xs-4" style="height: 300px;padding: 10px;"></bar-chart>
        </div>
    </div>
</div>

<script type="text/javascript">

    ajaxData({
        zdyName: {
            name: 'getBaseMessageList',
            data: {
                listTab:0,
                pageIndex:0,
                pageSize:10,
                searchKey:''
            }
        },
        zdyName2: {
            name: 'getCustomConfigByComId',
            data: {}
        }
    }, {
        /**
         * [area 地区列表，默认第一条，按顺序显示]
         * @type {Array}
         */
        area: [
          {name:'集团', value:'dark'},
          {name:'white', value:'light'},
          {name:'red', value:'dark'},
          {name:'blue', value:'dark'},
          {name:'yellow', value:'light'}
        ],
        /**
         * [indicators 指标列表，默认第一条，按顺序显示]
         * @type {Array}
         */
        indicators: [
          {name:'平均风速', value:'dark'},
          {name:'white', value:'light'},
          {name:'red', value:'dark'},
          {name:'blue', value:'dark'},
          {name:'yellow', value:'light'}
        ],
        /**
         * [dateType 可展示的日期类型，不展示为false   currentDateType 默认展示日期类型]
         * @type {Object}
         */
        dateType: { day: false, month: true, year: true, total: true, currentDateType: 'month' }
    })('wBrandCtrl', ['$scope', 'myAjaxData', '$timeout'], function($scope, myAjaxData, $timeout) {
        $scope.mapOrLine = 'map'
        $scope.zdyName.isLoding
        $scope.zdyName.res
        $scope.zdyName.promise.then(function () {
            
        })

        $timeout(function () {
            var promis = $scope.zdyName.getData({
                listTab:0,
                pageIndex:0,
                pageSize:10,
                searchKey:''
            })
            // promis.then(function () {
            //     // body...
            // })
        },10000)

        $timeout(function () {
            $scope.getData('getBaseMessageList', {
                listTab:0,
                pageIndex:0,
                pageSize:10,
                searchKey:''
            }).then(function (data) {
                
            }, function (data) {
                
            })
        }, 20000)

        myAjaxData.config
        myAjaxData.zdyName.isLoding
        myAjaxData.zdyName.res
        myAjaxData.isLoding
               
    })


</script>
