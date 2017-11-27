//添加、编辑
app.directive('taskAddTemp', ['myAjaxData', myAjaxData => {
    return {
        restrict: 'E',
        template: $('#task-add-temp').html(),
        replace: true,
        scope: {
            provinceList: '=',
            stationList:'=',
            cityList: '=',
            countryList: '=',
            getLatAndLong:'=',
            getRepairPersonList:'=',
            creatTask:"="
        },

        link ($scope, $element, $attrs) {
            
            $scope.stationChange = () =>{
                const lat = $scope.stationList.selected.lat;
                const long = $scope.stationList.selected.long;

                $scope.getMap(lat ,long, false);
            }
            $scope.getMap();
        },

        controller ($scope, $element) {

            $scope.radioValue = 1;

            $scope.getMap = (lat = 39.915 ,long = 116.404,first = true) =>{
                const map = new BMap.Map("allmap");
                const point = new BMap.Point(long,lat);
                
                if(!first){
                    //获取经纬度描点
                    const marker = new BMap.Marker(point);
                    map.addOverlay(marker);
                    /*const label = new BMap.Label("afsdfsd",{offset:new BMap.Size(20,-10)});
                    marker.setLabel(label);*/
                }
                map.centerAndZoom(point, 11);
                map.enableScrollWheelZoom(true); 

                //逆地址解析
                var geoc = new BMap.Geocoder();    

                /*map.addEventListener("click", function(e){        
                    var pt = e.point;
                    geoc.getLocation(pt, function(rs){
                        console.log(rs)
                    });        
                });*/
            }
            $scope.provinced = {};
            $scope.cityd = {};
            $scope.countyd = {};
            $scope.formData = {}
            

            const getProvinceList = () =>{
                $scope.provinceList.getData({
                    'treeLevel':1,
                    'parentId':1
                }).then(res =>{
                    console.log(res);
                    $scope.province = res;
                    $scope.provinced.selected= { regionName: $scope.province[0].regionName,id: $scope.province[0].id}

                    if($scope.provinced.selected.id != undefined && $scope.provinced.selected != null){
                       $scope.provinceChange() 
                    }
                })
            }
            getProvinceList();

            $scope.provinceChange = () =>{
                let a = angular.copy($scope.provinced.selected.id);
                $scope.cityList.getData({
                    "treeLevel":2,
                    "parentId":a
                }).then(res =>{
                    $scope.city = res;
                    $scope.cityd.selected = {regionName : $scope.city[0].regionName,id : $scope.city[0].id}

                    if($scope.cityd.selected.id != undefined && $scope.cityd.selected != null){
                       $scope.cityChange() 
                    }
                })        
            }

            $scope.cityChange = () =>{
                let b = angular.copy($scope.cityd.selected.id);
                $scope.countryList.getData({
                    "treeLevel":3,
                    "parentId":((b==null) || (b==""))?0:b
                }).then(res =>{
                    $scope.county = res;
                    $scope.countyd.selected = {regionName : $scope.county[0].regionName,id : $scope.county[0].id}

                })
            }
            
            $scope.getlatandlng = () =>{
                const province = $scope.provinced.selected ?$scope.provinced.selected.regionName :null
                const city = $scope.cityd.selected ? $scope.cityd.selected.regionName :null
                const country = $scope.countyd.selected ? $scope.countyd.selected.regionName :null
                const street = $("#address").val();
                if(province !=null && city != null && country != null && street != ""){
                    const str = province+city+country+street
                    $scope.getLatAndLong.getData({
                        "add":str
                    }).then(res =>{
                        $scope.longitude = res[0]
                        $scope.latitude = res[1]
                        $scope.getMap($scope.latitude ,$scope.longitude, false);
                    })

                }else{
                    alert("省市县街道均不能为空")
                }
            }

            //获取周边人员
            $scope.getPersonList = () =>{
                let lat = "",long = ""
                if($scope.radioValue == "1"){
                    lat = $scope.stationList.selected.latitude
                    long = $scope.stationList.selected.longitude
                }else if($scope.radioValue == "2"){
                    if($scope.longitude == "" || $scope.longitude == undefined || $scope.latitude == "" || $scope.latitude == undefined || $scope.distance == ""|| $scope.distance == undefined){
                        alert("经度、纬度、推送范围均不能为空")
                        return false
                    }else{
                        lat = $scope.latitude
                        long = $scope.longitude
                    }
                }
                

                $scope.getRepairPersonList.getData({
                    "latitude":lat,
                    "longitude":long,
                    "range":$scope.formData.sendScope
                }).then(res =>{
                    console.log(res)
                    if(res.code == 0 ){
                        //$scope.personList = res.body
                    }else{
                        alert(res.msg)
                    }
                })    
                
                $scope.personList = [{id:1,name:'张三'},{id:2,name:'asdgfsdg'},{id:3,name:'张三'},{id:4,name:'张三'},{id:5,name:'aaaaadgdg'},{id:6,name:'张三'},{id:7,name:'张三'},
                            {id:8,name:'asdfsf'},{id:9,name:'sdfs'},{id:10,name:'张三'},{id:11,name:'aaaaa'},]
            }

            let dateTime = new Date()
            $scope.endDate = new Date("2050,12,12")

            $scope.timeSetLine = [{time:dateTime,money:""}]

            $scope.addTimeLine = () =>{
                $scope.timeSetLine.push({time:dateTime,money:""});
            }

            $scope.deleteTimeLine = (index) =>{
                $scope.timeSetLine.splice(index,1);
            }
            
            $scope.release = () =>{
                if(validate()){
                    organizeParams()
                    $scope.creatTask.getData({
                        'taskVo':$scope.formData,
                        'opType':1,
                        'userIds':$scope.userIds
                    }).then(res =>{
                        console.log(res)
                    })

                }
               
            }

            const organizeParams = () =>{
                if($scope.radioValue == "1"){
                    $scope.formData['provinceId'] = $scope.stationList.selected.provinceid
                    $scope.formData['cityId'] = $scope.stationList.selected.cityid
                    $scope.formData['countyId'] = $scope.stationList.selected.countyid
                    $scope.formData['address'] = $scope.stationList.selected.address
                    $scope.formData['latitude'] = $scope.stationList.selected.latitude
                    $scope.formData['longitude'] = $scope.stationList.selected.longitude
                }else if($scope.radioValue == "2"){
                    $scope.formData['provinceId'] = $scope.provinced.selected.id
                    $scope.formData['cityId'] = $scope.cityd.selected.id
                    $scope.formData['countyId'] = $scope.countyd.selected.id
                    $scope.formData['address'] = $("#address").val()
                    $scope.formData['latitude'] = $scope.latitude
                    $scope.formData['longitude'] = $scope.longitude
                }

                for(let i = 0;i<$scope.timeSetLine.length;i++){
                    $scope.formData['bounsTime'+i] = $scope.timeSetLine[i].time
                    $scope.formData['bouns'+i] = $scope.timeSetLine[i].money
                }

                let checkedIds = []
                let checkedInput = $("input[name=ids]:checked")
                for(let i = 0;i<checkedInput.length;i++){
                    checkedIds.push(checkedInput[i].value)
                }
                $scope.userIds = checkedIds
                console.log($scope.formData)
                
            }
            const validate = () =>{
                let validateFlag = true

                //验证时间（时间从上到下，依次增大）
                let timeStrArr = []
                for(let i = 0;i<$scope.timeSetLine.length;i++){
                    timeStrArr[i] = $scope.timeSetLine[i].time.getTime()
                }
                let currentMaxTime = timeStrArr[0];
                for(let i = 1;i<timeStrArr.length;i++){
                    if(timeStrArr[i] <= currentMaxTime){
                        alert("上一个截止日期，不能大于下一个截止日期")
                        validateFlag = false
                        return validateFlag
                    }else{
                        currentMaxTime = timeStrArr[i]
                    }
                }

                return validateFlag
            }


            $scope.hiddenModalAdd = () =>{
                $('#powerIndexModalAdd').modal("hide");
            }
        }
    }
}])

//审核，发红包
app.directive('taskExamineTemp',['myAjaxData',myAjaxData => {
    return {
        restrict:'E',
        template:$('#task-examine-temp').html(),
        replace:true,
        scope:{
            statusType:"="
        },
        link($scope,$element,$attrs){

        },
        controller($scope,$element){
            const dateTime = new Date()
            //接口
            const getExamine = () =>{
                $scope.personList = [{id:1,name:'张三'},{id:2,name:'asdgfsdg'},{id:3,name:'张三'},{id:4,name:'张三'},{id:5,name:'aaaaadgdg'},{id:6,name:'张三'},{id:7,name:'张三'},
                            {id:8,name:'asdfsf'},{id:9,name:'sdfs'},{id:10,name:'张三'}]

                $scope.timeSetLine = [{time:dateTime,money:""},{time:dateTime,money:""},{time:dateTime,money:""}]
                $scope.imageList = [1,2,3,4]
            }

            getExamine()

            //通过
            $scope.pass = () =>{
                
            }

            //不通过
            $scope.notPass = () =>{
                
            }

            //发红包
            $scope.handOutMoney = () =>{

            }

            $scope.hiddenModalExamine = () =>{
                $('#taskExamineModal').modal("hide");
            }
        }
    }
}])
ajaxData({
    pageList: {
        name: 'GETTaskList',
        data: {
            pageIndex:0,
            pageSize:10,
        }
    },
    stationsPosition:{
        name:'GETStationsPos',
        data: {},
        later:true
    },
    provinceList:{
        name: 'POSTSelectProvince',
        data: {},
        later:true
    },
    cityList:{
        name: 'POSTSelectCity',
        data: {},
        later:true
    },
    countryList:{
        name: 'POSTSelectCountry',
        data: {},
        later:true
    },
    getLatAndLong:{
        name:'POSTLatandlng',
        data: {},
        later:true
    },
    getRepairPersonList:{
        name:'GETSelectRepairPerson',
        data: {},
        later:true
    },
    creatTask:{
        name:'POSTCreatTask',
        data:{},
        later:true
    }
},{

})('issueTaskListCtrl', ['$scope', 'myAjaxData','$ocLazyLoad'], ($scope, myAjaxData,$ocLazyLoad) => {
    
    $ocLazyLoad.load([
        "http://api.map.baidu.com/api?v=2.0&ak=aBsOf0A0mp32b7M6A15dvByz"
    ]).then(()=>{
        //添加
        $scope.showAddModel =  () =>{
            //获取电站列表
            $scope.stationsPosition.getData({
            }).then(res =>{
                console.log(res)
                if(res.code == 0){
                    $scope.stationList = res.body
                    $scope.stationList.selected = $scope.stationList[0]
                }
            })
            /*$scope.stationList = [{id:1,name:'电站1',lat:'40.915',long:'116.404'},
                                {id:2,name:'电站2',lat:'38.915',long:'116.404'},
                                {id:3,name:'电站3',lat:'40.615',long:'116.404'}]*/
            $('#powerIndexModalAdd').modal();
        };
    })


    /*$scope.search = () => {
        $scope.pageList.getData()
    }*/
    $scope.data = [1,223,6,657,75]
    /*$scope.pageList.promise.then(res=>{
        })
    */
   
    $scope.examineInfo = (type) =>{
        $scope.statusType = type
        $('#taskExamineModal').modal();
    }
    
})