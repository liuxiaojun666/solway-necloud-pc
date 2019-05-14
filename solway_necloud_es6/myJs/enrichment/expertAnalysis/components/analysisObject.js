ajaxData({
    //分析对象 - 设备列表
    queryStTreeWithDevices: {
        name: 'GETqueryStTreeWithDevices',
        data: {},
        later: true
    },
    //分析对象 - 电站列表、区域（部门）列表、集团列表
    queryTreeWithSt: {
        name: 'GETqueryTreeWithSt',
        data: {},
        later: true
    },
    //分析对象 - 机型列表
    queryStTreeWithProducts: {
        name: 'GETqueryStTreeWithProducts',
        data: {},
        later: true
    },
    
}, {
        __serviceName__: 'analysisObjectService'
    })('analysisObjectCtrl', ['$scope', 'analysisObjectService', 'actionRecord', '$timeout', 'toaster', '$ocLazyLoad', 'myAjaxData'], ($scope, _myAjaxData, historicalRecord, $timeout, toaster, $ocLazyLoad, parentmyAjaxData) => {

        //初始化树
        let zTree;

        //获取父级发送的数据
        $scope.$on('analysObDataNew', (item, data) => {
            if (data.analysObDataNew) {
                $scope.analysObDataNew = data.analysObDataNew;
                var arr = [];
                $scope.analysObDataNew.map((item) => {
                    if (item.k == 3) {
                        arr[0] = item;
                    } else if (item.k == 5) {
                        arr[1] = item;
                    } else if (item.k == 1) {
                        arr[2] = item;
                    }
                })
                $scope.analysObDataNew = arr;
                $scope.analysObDataNewDevice = data.analysObDataNewDevice;
                data.analysObDataNewDevice.map((item, i) => {
                    $scope.objectDevice[i] = [];
                })
                $scope.radioDevice();
            }
        })

        //默认获取第一项的数据
        setTimeout(() => {
            $scope.radioDevice();
        }, 0)

        //点击单个设备
        $scope.equipChoice = (item, index) => {
            //默认获取第一项的数据
            item = item ? item : $scope.analysObDataNewDevice[0];
            index = index ? index : 0;
            $scope.equipChoiceItem = item;
            parentmyAjaxData.config.dmsType = item.k;
            $scope.deviceK = item.k;
            treeData(item.k);
            $scope.equipChoiceIndex = index;
            $scope.$emit('deviceTimeLat', item.ll);
        }

        //处理点击设备radio
        $scope.radioDevice = () => {
            $scope.analysisObjectK = 99;
            $scope.$emit('radioToFather', { 'type': 'analysisObject', 'k': 99, 'value': '设备' });
            setTimeout(() => {
                $scope.equipChoice($scope.equipChoiceItem, $scope.equipChoiceIndex);
            }, 0)
        }

        //处理点击机型radio
        $scope.radioType = () => {
            $scope.analysisObjectK = 100;
            parentmyAjaxData.config.dmsType = 101;
            $scope.zNodes = [];
            treeData($scope.deviceK);
            $scope.$emit('radioToFather', { 'type': 'analysisObject', 'k': 100, 'value': '机型' });
        }

        //单选框选中-> 更改父级的值
        $scope.radioIndex = 0;
        $scope.radioToSelect = (item, index) => {
            parentmyAjaxData.config.dmsType = $scope.analysisObjectK = item.k;
            $scope.$emit('radioToFather', { 'type': 'analysisObject', 'k': item.k, 'value': item.v });
            $scope.radioIndex = index;
            treeData(item.k);
        }

        //tree数据的获取
        function treeData(k) {
            // 调 集团 电站 区域接口
            const st = {
                1: 3,
                5: 2,
                3: 1
            }
            // 调设备的接口
            const devices = {
                401: 1,
                402: 2,
                403: 3,
                404: 4,
                405: 5,
                417: 17,
                418: 18
            }
            if (k == 1 || k == 5 || k == 3) {
                $scope.queryTreeWithSt.getData({
                    busiType: st[k]
                })

                $scope.queryTreeWithSt.subscribe(res => {
                    $scope.zNodes = res.body;
                    $.fn.zTree.init($("#tree"), $scope.setting, $scope.zNodes);
                    $scope[key[$scope.analysisObjectK]].map((item) => {
                        item.map((son) => {
                            zTree.checkNode(zTree.getNodeByParam("id", son.id), true, true);
                        })
                    })
                });
            } else if (k.substr(0, 1) == "4" && $scope.analysisObjectK == 99) {
                $scope.queryStTreeWithDevices.getData({
                    deviceType: devices[k]
                })

                $scope.queryStTreeWithDevices.subscribe(res => {
                    $scope.zNodes = res.body;
                    $.fn.zTree.init($("#tree"), $scope.setting, $scope.zNodes);
                    $scope.objectDevice[$scope.equipChoiceIndex].map((item) => {
                        item.map((son) => {
                            zTree.checkNode(zTree.getNodeByParam("id", son.id), true, true);
                        })
                    })
                });
            } else if (k.substr(0, 1) == "4" && $scope.analysisObjectK == 100) {
                $scope.queryStTreeWithProducts.getData({
                    deviceType: devices[k]
                })

                $scope.queryStTreeWithProducts.subscribe(res => {
                    $scope.zNodes = res.body;
                    $.fn.zTree.init($("#tree"), $scope.setting, $scope.zNodes);
                    $scope[key[$scope.analysisObjectK]].map((item) => {
                        item.map((son) => {
                            zTree.checkNode(zTree.getNodeByParam("id", son.id), true, true);
                        })
                    })
                });
            }
        }

        //------------------------------------------------ztree 树形控件
        //ztree插件配置
        $scope.setting = {
            check: {
                enable: true
            },
            view: {
                showLine: false,
                showIcon: true,
                fontCss: getFontCss,
                dblClickExpand: false,
                nameIsHTML: false,
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pid",
                    rootPId: 0
                },
                key: {
                    name: "name"
                }
            },
            callback: {
                onClick: onNodeClick,
                onCheck: checkChangeFn
            }
        };

        // setTimeout(() => {
        //     $scope.analysObDataNewDevice.map((item, i) => {
        //         $scope.objectDevice[i] = [];
        //     })
        // }, 0)
        $scope.objectDevice = [];
        $scope.objectPower = [];
        $scope.objectArea = [];
        $scope.objectGroup = [];
        $scope.objectType = [];

        const key = {
            100: 'objectType',  //机型
            99: 'objectDevice', //设备
            3: 'objectPower', //电站
            5: 'objectArea', //区域 (部门)
            1: 'objectGroup' //集团 (公司)
        }
        //映射 取busiType
        const keyToType = {
            100: 5,
            99: 5,
            3: 1,
            5: 2,
            1: 3
        }
        //单击父节点展开 子节点
        function onNodeClick(e, treeId, treeNode) {
            zTree.expandNode(treeNode);
            $(".curSelectedNode").removeClass("curSelectedNode");
        }

        //独立添加
        $scope.oneRItem1 = {};  //电站
        $scope.oneRItem5 = {};  //区域
        $scope.oneRItem3 = {};  //集团
        $scope.oneRItem100 = [];  //机型、故障类型
        $scope.oneRItemDevice = {}; //设备
        $scope.checkedNode = [];
        $scope.oneAdd = () => {
            checkChangeFn();
            if ($scope.checkedNode.length == 0) {
                toaster.pop('error', '', '所选数据不能为空');
                return;
            }
            //根据busiType 筛选
            // var newMiddle = JSON.parse(JSON.stringify($scope.middleArr));

            var FTmiddleArr = $scope.middleArr.filter((item) => {
                return keyToType[$scope.analysisObjectK] == item.busiType;
            })
            
            if (FTmiddleArr.length == 0) {
                return
            }
            
            //机型/故障类型  获取根节点
            var typeArr = [];
            function rootNode(item){
                var parentNode = item.getParentNode();
                if(parentNode.level != 0){
                    rootNode(parentNode);
                } else {
                    if(typeArr.indexOf(parentNode) == -1){
                        parentNode.devices = [];
                        parentNode.devices.push($scope.deviceItem);
                        parentNode.isgroup = false;
                        typeArr.push(parentNode);
                    } else {
                        typeArr[typeArr.indexOf(parentNode)].devices.push($scope.deviceItem);
                    }
                }
            }

            FTmiddleArr.map((item)=>{
                $scope.deviceItem = item;
                rootNode(item);
            })

            FTmiddleArr.map((item) => {
                item.isgroup = false;
            })

            //把过滤后的 数据放到 对应的数组中
            if($scope.analysisObjectK == 100){
                typeArr.map((item) => {
                    var arr = [];
                    arr.push(item);
                    $scope[key[$scope.analysisObjectK]].push(arr);
                })
            } else {
                FTmiddleArr.map((item) => {
                    var arr = [];
                    arr.push(item);
                    if ($scope.analysisObjectK == 99) {
                        $scope.objectDevice[$scope.equipChoiceIndex].push(arr);
                    } else {
                        $scope[key[$scope.analysisObjectK]].push(arr);
                    }
                })
            }
            
            //---------------------独立添加的 数组去重
            //剔除 成组添加的数据
            var oneArr = [];
            var groupArr = [];
            if ($scope.analysisObjectK == 99) {
                $scope.objectDevice[$scope.equipChoiceIndex].map((item) => {
                    if (item.length == 1) {
                        oneArr.push(item);
                    } else {
                        groupArr.push(item);
                    }
                });
            } else {
                $scope[key[$scope.analysisObjectK]].map((item) => {
                    if (item.length == 1) {
                        oneArr.push(item);
                    } else {
                        groupArr.push(item);
                    }
                })
            }

            var arrfilter = [oneArr[0]];
            for (var i = 1; i < oneArr.length; i++) {
                var flag = true;
                for (var j = 0; j < arrfilter.length; j++) {
                    if (oneArr[i][0].busiId == arrfilter[j][0].busiId) {
                        flag = false;
                        break
                    }
                }
                if (flag) {
                    arrfilter.push(oneArr[i]);
                }
            }
            if ($scope.analysisObjectK == 99) {
                $scope.objectDevice[$scope.equipChoiceIndex] = [...arrfilter, ...groupArr];
            } else {
                $scope[key[$scope.analysisObjectK]] = [...arrfilter, ...groupArr];
            }
            if ($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5) {
                //组装接口需要的数据 (电站|区域(部门)|集团)
                $scope['oneRItem' + $scope.analysisObjectK] = {
                    "isGroup": 0,
                    "ids": []
                }
                FTmiddleArr.map((item) => {
                    $scope['oneRItem' + $scope.analysisObjectK].ids.push(item.busiId);
                })
            } else if ($scope.analysisObjectK == 99) {
                //组装接口需要的数据 (设备)
                $scope.oneRItemDevice = {
                    "isGroup": 0,
                    "st_eqids": []
                }
                FTmiddleArr.map((item) => {
                    $scope.oneRItemDevice.st_eqids.push(`${item.stids}-${item.busiId}`);
                })
            } else if ($scope.analysisObjectK == 100) {
                //组装接口需要的数据 (机型、故障类型)
                $scope['oneRItem' + $scope.analysisObjectK] = [];
                typeArr.map((item) => {
                    var oneRItem = {
                        "id": 0,
                        "st_eqids": []
                    }
                    oneRItem.id = item.busiId;
                    item['devices'].map((son)=>{
                        oneRItem.st_eqids.push(`${son.stids}-${son.busiId}`);
                    })
                    $scope['oneRItem' + $scope.analysisObjectK].push(oneRItem);
                })
            }
        }

        //成组添加
        $scope.groupResult1 = [];  //电站
        $scope.groupResult5 = [];  //区域
        $scope.groupResult3 = [];  //集团
        $scope.groupResult100 = [];  //机型、故障类型
        $scope.groupResultDevice = []; //设备
        $scope.groupAdd = () => {
            checkChangeFn();
            if ($scope.checkedNode.length == 0) {
                toaster.pop('error', '', '所选数据不能为空');
                return;
            }
            // var newMiddle = JSON.parse(JSON.stringify($scope.middleArr));

            var FTmiddleArr = $scope.middleArr.filter((item) => {
                return keyToType[$scope.analysisObjectK] == item.busiType;
            })

            if (FTmiddleArr.length == 0) {
                return
            }
            
            //机型/故障类型  获取根节点
            var typeArr = [];
            function rootNode(item){
                var parentNode = item.getParentNode();
                if(parentNode.level != 0){
                    rootNode(parentNode);
                } else {
                    if(typeArr.indexOf(parentNode) == -1){
                        parentNode.devices = [];
                        parentNode.devices.push($scope.deviceItem);
                        parentNode.isgroup = true;
                        typeArr.push(parentNode);
                    } else {
                        typeArr[typeArr.indexOf(parentNode)].devices.push($scope.deviceItem);
                    }
                }
            }

            FTmiddleArr.map((item)=>{
                $scope.deviceItem = item;
                rootNode(item);
            })

            if ($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5) {
                //组装接口需要的数据 (电站|区域(部门)|集团)
                var groupItem = {
                    "isGroup": 1,
                    'groupName': 'gp' + parseInt(Math.random() * 10000),
                    "ids": []
                }
                FTmiddleArr.map((item) => {
                    item.isgroup = true;
                    item.groupName = groupItem.groupName;
                    groupItem.ids.push(item.busiId);
                })

                $scope['groupResult' + $scope.analysisObjectK].push(groupItem);
                $scope[key[$scope.analysisObjectK]].push(FTmiddleArr);
            } else if ($scope.analysisObjectK == 99) {
                //组装接口需要的数据 (设备)
                var groupItem = {
                    "isGroup": 1,
                    'groupName': 'gp' + parseInt(Math.random() * 10000),
                    "st_eqids": []
                }
                FTmiddleArr.map((item) => {
                    item.isgroup = true;
                    item.groupName = groupItem.groupName;
                    groupItem.st_eqids.push(`${item.stids}-${item.busiId}`);
                })
                $scope.groupResultDevice.push(groupItem);
                $scope.objectDevice[$scope.equipChoiceIndex].push(FTmiddleArr);
            } else if ($scope.analysisObjectK == 100) {
                //组装接口需要的数据 (机型/故障类型)
                var groupItem = {
                    'groupName': 'gp' + parseInt(Math.random() * 10000),
                    'cdts' : [],
                }
                typeArr.map((item) => {
                    item.isgroup = true;
                    item.groupName = groupItem.groupName;
                })
                $scope[key[$scope.analysisObjectK]].push(typeArr);
                typeArr.map((item) => {
                    var cdtsItem = {
                        'id': 0,
                        "st_eqids": []
                    }
                    cdtsItem.id = item.busiId;
                    item['devices'].map((son)=>{
                        cdtsItem.st_eqids.push(`${son.stids}-${son.busiId}`);
                    })
                    groupItem['cdts'].push(cdtsItem);
                })
                $scope['groupResult' + $scope.analysisObjectK].push(groupItem);
            }
        }

        //点击多选框 ->右侧穿梭
        function checkChangeFn(event, treeId, treeNode) {
            $scope.checkedNode = zTree.getCheckedNodes(true);
            $scope.middleArr = [];
            $scope.checkedNode.map(item => {
                if (!item.children) {
                    $scope.middleArr.push(item);
                }
            })
        }

        //右侧删除小按钮
        $scope.delRight = (item, index) => {
            item.map((v) => {
                zTree.checkNode(zTree.getNodeByParam("id", v.id), false, true);
            })
            //根据index 删除 给接口传的数据 (电站|区域(部门)|集团)
            if ($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5) {
                //删除 页面显示的数据
                $scope[key[$scope.analysisObjectK]].splice(index, 1);
                item.map((v) => {
                    if (v.isgroup) {
                        $scope['groupResult' + $scope.analysisObjectK].map((son, i) => {
                            if (son.groupName == v.groupName) {
                                $scope['groupResult' + $scope.analysisObjectK].splice(i, 1);
                            }
                        })
                    } else {
                        var index = $scope['oneRItem' + $scope.analysisObjectK].ids.indexOf(v.busiId);
                        if (index != -1) {
                            $scope['oneRItem' + $scope.analysisObjectK].ids.splice(index, 1);
                        }
                    }
                })
                if ($scope[key[$scope.analysisObjectK]].length == 0) {
                    parentmyAjaxData.config.dmsTypeBs = [];
                }
                //删除 给接口传的数据 (设备)
            } else if ($scope.analysisObjectK == 99) {
                //删除 页面显示的数据
                $scope.objectDevice[$scope.equipChoiceIndex].splice(index, 1);
                item.map((v) => {
                    if (v.isgroup) {
                        $scope.groupResultDevice.map((son, i) => {
                            if (son.groupName == v.groupName) {
                                $scope.groupResultDevice.splice(i, 1);
                            }
                        })
                    } else {
                        var index = $scope.oneRItemDevice.st_eqids.indexOf(v.busiId);
                        if (index != -1) {
                            $scope.oneRItemDevice.st_eqids.splice(index, 1);
                        }
                    }
                })
                if ($scope.objectDevice[$scope.equipChoiceIndex].length == 0) {
                    parentmyAjaxData.config.dmsTypeAs = [];
                }
                //删除 给接口传的数据 (机型/故障类型)
            } else if ($scope.analysisObjectK == 100) {
                //删除 页面显示的数据
                $scope[key[$scope.analysisObjectK]].splice(index, 1);
                item.map((v) => {
                    if (v.isgroup) {
                        $scope['groupResult' + $scope.analysisObjectK].map((son, i) => {
                            if (son.groupName == v.groupName) {
                                $scope['groupResult' + $scope.analysisObjectK].splice(i, 1);
                            }
                        })
                    } else {
                        $scope['oneRItem' + $scope.analysisObjectK].map((son, i) => {
                            if (son.id == v.id) {
                                $scope['oneRItem' + $scope.analysisObjectK].splice(i, 1);
                            }
                        })
                    }
                })
                if ($scope[key[$scope.analysisObjectK]].length == 0) {
                    parentmyAjaxData.config.dmsTypeCs = [];
                    parentmyAjaxData.config.dmsTypeDs = [];
                }
            }
        }

        //全部删除
        $scope.delRightAll = () => {
            if (($scope.analysisObjectK == 99 && $scope.objectDevice[$scope.equipChoiceIndex].length == 0) || (($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5|| $scope.analysisObjectK == 100) && $scope[key[$scope.analysisObjectK]].length == 0)) {
                toaster.pop('error', '', '请至少选择一条');
            } else {
                $solway.confirm({ message: '确定全部删除吗？' }, () => {
                    zTree.checkAllNodes(false);
                    zTree.cancelSelectedNode();
                    $scope.checkedNode = [];
                    if ($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5 || $scope.analysisObjectK == 100) {
                        $scope[key[$scope.analysisObjectK]] = [];
                        $scope['oneRItem' + $scope.analysisObjectK] = $scope.analysisObjectK == 100 ? [] : {};
                        $scope['groupResult' + $scope.analysisObjectK] = [];
                        parentmyAjaxData.config.dmsTypeBs = [];
                    } else if ($scope.analysisObjectK == 99) {
                        $scope.objectDevice[$scope.equipChoiceIndex] = [];
                        $scope.oneRItemDevice = {};
                        $scope.groupResultDevice = [];
                        parentmyAjaxData.config.dmsTypeAs = [];
                    }
                    $scope.$apply();
                });
            }
        }

        //按需加载ztree文件
        $ocLazyLoad.load([
            'vendor/jquery/ztree/js/jquery.ztree.core.js', //ztree
        ]).then(() => $ocLazyLoad.load([
            'vendor/jquery/ztree/js/jquery.ztree.exhide.js', //ztree
            'vendor/jquery/ztree/js/jquery.ztree.excheck.js', //ztree        
        ])).then(() => $ocLazyLoad.load([
            'vendor/jquery/ztree/js/fuzzysearch.js', //ztree
        ])).then(() => {
            $.fn.zTree.init($("#tree"), $scope.setting, $scope.zNodes);
            zTree = $.fn.zTree.getZTreeObj("tree");
            //搜索功能
            fuzzySearch('tree', '#key', false, true);
        })

        //节点样式方法
        function getFontCss(treeId, treeNode) {
            return { color: '#fff' }
        }

        //取消
        $scope.cancel = () => {
            $scope.$emit('cancelCallback');
        }

        //获取到busiId 和 name 的映射(独立添加、成组添加)
        function busiIdToName() {
            var analyOjName = {};
            if ($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5) {
                $scope[key[$scope.analysisObjectK]].map(item => {
                    if (!item[0].isgroup) {
                        analyOjName[item[0].busiId] = item[0].name;
                    } else {
                        item.map((son, i) => {
                            if (i == 0) {
                                analyOjName[son.groupName] = '';
                            }
                            analyOjName[son.groupName] += son.name + '\xa0';
                        })
                    }
                })
            } else if ($scope.analysisObjectK == 99) {
                $scope.objectDevice[$scope.equipChoiceIndex].map(item => {
                    if (!item[0].isgroup) {
                        analyOjName[item[0].stids + '-' + item[0].busiId] = item[0].name;
                    } else {
                        item.map((son, i) => {
                            if (i == 0) {
                                analyOjName[son.groupName] = '';
                            }
                            analyOjName[son.groupName] += son.name + '\xa0';
                        })
                    }
                })
            }

            parentmyAjaxData.config.bIdToName = analyOjName;
        }

        //确定按钮
        $scope.confirm = () => {
            if ($scope.analysisObjectK == 1 || $scope.analysisObjectK == 3 || $scope.analysisObjectK == 5) {
                if ($scope[key[$scope.analysisObjectK]].length == 0) {
                    toaster.pop('error', '', '所选数据不能为空');
                    return;
                }
                parentmyAjaxData.config.dmsTypeAs = [];
                parentmyAjaxData.config.dmsTypeBs = Object.keys($scope['oneRItem' + $scope.analysisObjectK]).length == 0 ? [...$scope['groupResult' + $scope.analysisObjectK]] : $scope['groupResult' + $scope.analysisObjectK].length == 0 ? [$scope['oneRItem' + $scope.analysisObjectK]] : [...$scope['groupResult' + $scope.analysisObjectK], $scope['oneRItem' + $scope.analysisObjectK]];
            } else if ($scope.analysisObjectK == 99) {
                if ($scope.objectDevice[$scope.equipChoiceIndex].length == 0) {
                    toaster.pop('error', '', '所选数据不能为空');
                    return;
                }
                parentmyAjaxData.config.dmsTypeBs = [];
                parentmyAjaxData.config.dmsTypeAs = Object.keys($scope.oneRItemDevice).length == 0 ? [...$scope.groupResultDevice] : $scope.groupResultDevice.length == 0 ? [$scope.oneRItemDevice] : [...$scope.groupResultDevice, $scope.oneRItemDevice];
            } else if ($scope.analysisObjectK == 100) {
                if ($scope[key[$scope.analysisObjectK]].length == 0) {
                    toaster.pop('error', '', '所选数据不能为空');
                    return;
                }
                parentmyAjaxData.config.dmsTypeAs = [];
                parentmyAjaxData.config.dmsTypeBs = [];
                parentmyAjaxData.config.dmsTypeCs = $scope['oneRItem' + $scope.analysisObjectK];
                parentmyAjaxData.config.dmsTypeDs = $scope['groupResult' + $scope.analysisObjectK];
            }
            busiIdToName();
            $scope.$emit('addCallback');
        }
    });