<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.modal-open {
    overflow-y: auto;
}

.benchmarkingHead{

}
.benchmarkingHead ul{
    margin: 0;
}
.benchmarkingHead ul li{
    background-color: #1d2b36;
}
.benchmarkingHead ul li.active{
    background-color: #1cb09a;
}
.benchmarkingHead ul li a{
    display: block;
    padding: 5px 10px;
}
.c_b{
    color: #1cb09a;
}

    .workBriefingTable{
        margin-bottom: 50px;
        min-width: 100%;
        border-left: 1px solid #a4dfd7;
        border-bottom: 1px solid #a4dfd7;
    }
    .workBriefingTable thead{
        text-align: center;
        border: 1px solid #1cb09a;
    }
    .workBriefingTable th{
        padding: 15px;
        border-right: 1px solid #6bd2c2;
    }
    .workBriefingTable td{
        border-right: 1px solid #a4dfd7;
        padding: 15px;
    }
    .bgCyan{
        background-color: #e9f8f7;
    }
    .bgWhite{
        background-color: #fff;
    }
</style>
<link rel="stylesheet" type="text/css" href="${ctx}/vendor/bootstrap/css/bootstrap-datetimepicker.min.css"/>

<div class="" ng-controller="benchmarkingDayCtrl">
    <div class="b-b benchmarkingHead wrapper-md">
        <!--  -->
    </div>
    <div style="padding: 30px;">
        
        <div class="row" style="font-size: 18px; padding: 10px 0;">
            <div class="col-sm-4">
                <span class="c_b">公司外部对标</span>
            </div>
            <div class="col-sm-6 input-group ">

                <span class="input-append date form_datetime" id="sStartTime" data-link-field="date-day">
                    <input type="hidden" id="date-day" value="" />
                    <span id="showDate-day" class="showdate m-l m-r c_b time-color" style="vertical-align: super;border: 1px solid #ccc; padding: 5px 20px; background: #fff;" ng-bind="mapTimeDay | date:'yyyy-MM'"></span>
                </span>

                <!-- <input type="text" id="sStartTime" name="sStartTime" class="form-control"> -->

                <span class="c_b" style="vertical-align: top;">—</span>

                <!-- <input type="text" id="sEndTime" name="sEndTime" class="form-control"> -->

                
                <span class="input-append date form_datetime" id="sEndTime" data-link-field="date-day2">
                    <input type="hidden" id="date-day2" value="" />
                    <span id="showDate-day2" class="showdate m-l m-r c_b time-color" style="vertical-align: super;border: 1px solid #ccc; padding: 5px 20px; background: #fff;" ng-bind="mapTimeDay2 | date:'yyyy-MM'"></span>
                </span>

            </div>

        </div>

        <div>
            <table class="workBriefingTable" style="">
                <thead>
                    <tr style="background: #9fe8dd;border-top: 1px solid #1cb09a">
                        <th style="width: 350px;">日期</th>
                        <th ng-repeat="item in data">{{item.busiDate | MyDataFormat}}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="outerItem in names"  class="{{$index % 2 === 0 ? 'bgCyan' : 'bgWhite'}}" ng-init="key = keys(outerItem)">
                        <td>{{ outerItem[key] }}</td>
                        <td ng-repeat="item in data">{{ item[key] }}</td>
                    </tr>
                </tbody>
            </table>
        </div>


    </div>

<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.js" type="text/javascript"></script>
<script src="${ctx}/vendor/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" type="text/javascript"></script>

    </div>
</div>

<script>
function getDateForStringDate(strDate){
    //切割年月日与时分秒称为数组
    var s = strDate.split(" ");
    var s1 = s[0].split("-");
    var s2

    if (s[1]) {
        s2 = s[1].split(":");
        if(s2.length==2){
            s2.push("00");
        }
    } else {
        s2 = ['00','00','00']
    }
    
    return new Date(s1[0],s1[1]-1,s1[2],s2[0],s2[1],s2[2]);
}
app.filter("MyDataFormat",function () {
    return function (src) {
        var arr = src.split('-')
        return arr[0] + '年' + arr[1] + '月'
    }
})
app.controller('benchmarkingDayCtrl', function($scope, $http, $state,$stateParams) {

    $scope.keys = function (obj) {
        return Object.keys(obj)[0]
    }
    $scope.mapTimeDay = new Date
    $scope.mapTimeDay.setMonth($scope.mapTimeDay.getMonth() - 11)
    $scope.mapTimeDay2 = new Date

    //日期控件
    $('#sStartTime').datetimepicker({
        format: "yyyy-mm",
        language: 'zh-CN',
        todayHighlight:true,
        todayBtn:true,
        autoclose: true,
        endDate:$scope.mapTimeDay2,
        minView : 3,
        startView: 3,
        initialDate : $scope.mapTimeDay,
        pickerPosition : "bottom-left"
    })
    .on('hide',function(ev) {
        var stringTime = $("#date-day").val();//2016-08-31 14:12:57
        if(stringTime){
            var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
            $scope.mapTimeDay = new Date(timestamp);
            $("#showDate-day").text(new Date(timestamp).Format("yyyy-MM"));
            $('#sEndTime').datetimepicker('setStartDate', stringTime.split(' ')[0]);
        }
        getData()
    });


          //日期控件
    $('#sEndTime').datetimepicker({
        format: "yyyy-mm",
        language: 'zh-CN',
        todayHighlight:true,
        todayBtn:true,
        autoclose: true,
        endDate:new Date(),
        startDate: $scope.mapTimeDay,
        minView : 3,
        startView: 3,
        initialDate : $scope.mapTimeDay2,
        pickerPosition : "bottom-left"
    })
    .on('hide',function(ev) {
        var stringTime = $("#date-day2").val();//2016-08-31 14:12:57
        if(stringTime){
            var timestamp = Date.parse(getDateForStringDate(stringTime));//1472623977000,(Wed Aug 31 2016 14:12:57 GMT+0800 (中国标准时间)
            $scope.mapTimeDay2 = new Date(timestamp);
            $("#showDate-day2").text(new Date(timestamp).Format("yyyy-MM"));
            $('#sStartTime').datetimepicker('setEndDate', stringTime.split(' ')[0]);
        }
        getData()
    });

    $scope.names = [
        { MUtilizeHours: '月利用小时数' },
        { MUseHours1: '月利用小时与同一线路（同一汇集站）平均水平差值 ' },
        { MUseHours2Diff: '与同区域集团内部其它公司风电场平均水平差值，' },
        { MUseHours3Diff: '与区域优秀标杆风电场差值' },
        { analysis2: '对标分析' },
        { remark2: '备注' }
    ]

    /**
     * [getData 发请求取数据]
     * @return {[type]} [description]
     */
    function getData() {
        $http({
            method : "GET",
            url : "${ctx}/rpms/out/benchmark/company.htm",
            params: {
                startDateStr: $scope.mapTimeDay.Format('yyyy-MM-dd'),
                endDateStr: $scope.mapTimeDay2.Format('yyyy-MM-dd')
            }
        }).success(function(res) {
            $scope.data = res.data
        });
    }
    getData()

})

</script>