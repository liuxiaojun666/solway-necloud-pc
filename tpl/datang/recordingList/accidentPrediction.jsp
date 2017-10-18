<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${ctx}/theme/css/datang/recordingList.css">

<script src="${ctx}/tpl/publicComponent/index.js" type="text/javascript"></script>
<script src="${ctx}/theme/js/api.js" type="text/javascript"></script>

<div ng-controller="accidentPredictionCtrl" class="accidentPrediction recordingList">

    <switch-power></switch-power>

    <div class="content-body" d-loding="isLoding">

        <div class="common-header">
            <a class="list-btn" ng-class="{'active':listOrFill == 'listPage'}" ng-click="listOrFillHeaderActive('listPage')">列表数据</a>

            <span class="selected-btn active" ng-show="false" ng-class="{'active':listOrFill == 'fillPage'}">
                <a class="list-btn" ng-click="listOrFillHeaderActive('fillPage')">新增</a>
                <a class="close-btn">×</a>
            </span>
        </div>

        <div class="operating-bar">
            <div class="operating-content">
                <button class="add-new">新增</button>
                <button class="batch-del">批量删除</button>

                <div class="search">
                    <input type="text" placeholder="关键字"><button>查询</button>
                </div>
                
                <paging getData="pageList.getData" paging="pageList.res.data"></paging>
            </div>
        </div>

        <div class="list">
            <div class="list-content">
                <my-table class="table" datasource="datasource" column="column"></my-table>
            </div>
        </div>

    </div>
</div>

<script type="text/html" id="">

</script>

<script type="text/javascript">

</script>



<!-- 这里是主控制器 -->
<script type="text/javascript">
    ajaxData({
        pageList: {
            name: 'rpdWorkTicketPage',
            data: {
                pageIndex:0,
                pageSize:10
            }
        }
    },{

    })('accidentPredictionCtrl', ['$scope', 'myAjaxData', '$timeout'], function ($scope, myAjaxData, $timeout) {
        

        $scope.pageList.promise.then(function (data) {
            $scope.datasource = $scope.pageList.res.data.data
        })
        
        $scope.column = [{
                          title: '集团',
                          dataIndex: 'companyName'
                        }, {
                          title: '电站',
                          dataIndex: 'stationName'
                        }, {
                          title: '时间',
                          dataIndex: 'busiDate',
                          render: function(text, record, index) {
                            return new Date(text).Format('yyyy-MM-dd')
                          }
                        }]
    })
</script>
<!-- 这里是主控制器 END -->