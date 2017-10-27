'use strict';

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

ajaxData({
    pageList: {
        name: 'GETanalysisPage',
        data: {
            pageIndex: 0,
            pageSize: 10,
            startDate: new Date(new Date().setDate(new Date().getDate() - 7)).Format('yyyy-MM-dd'),
            endDate: new Date().Format('yyyy-MM-dd')
        }
    },
    detail: {
        name: 'GETselectEqPaintingData',
        later: !0
    },
    deviceType: {
        name: 'GETgetDeviceType',
        data: {}
    }
}, {})('fengyunListCtrl', ['$scope', 'myAjaxData'], function ($scope, myAjaxData) {
    _newArrowCheck(void 0, void 0);

    $scope.dateTime1 = new Date(new Date().setDate(new Date().getDate() - 7));
    $scope.dateTime2 = new Date();

    $scope.datasource = new Array(10).fill('').map(function (v, i) {
        _newArrowCheck(void 0, void 0);

        return {
            name: ['习近平', '李克强', '栗战书', '汪洋', '王沪宁', '赵乐际', '韩正'][i],
            phone: '1' + (Math.random() + '').slice(-10),
            email: (Math.random() + '').slice(-10) + '@qq.com',
            company: '大唐北京公司',
            ranking: i + 1
        };
    }.bind(void 0));

    $scope.column = [{
        title: null,
        dataIndex: 'ranking',
        width: '50px',
        align: 'center',
        render: function () {
            function render(text, item, index) {
                return '<span class="jiangbei jiangbei-' + [1, 2, 3][text - 1] + '"></span>';
            }

            return render;
        }()
    }, {
        title: null,
        dataIndex: 'name',
        width: '150px',
        align: 'left',
        render: function () {
            function render(text) {
                return '<span class="icon-user"></span> ' + (text || '');
            }

            return render;
        }()
    }, {
        title: null,
        dataIndex: 'company',
        width: '200px',
        align: 'left',
        render: function () {
            function render(text) {
                return '<span class="fa fa-building-o"></span> ' + text;
            }

            return render;
        }()
    }, {
        title: null,
        dataIndex: 'phone',
        width: '150px',
        align: 'center',
        render: function () {
            function render(text) {
                return '<span class="fa fa-phone"></span> ' + text;
            }

            return render;
        }()
    }, {
        title: null,
        dataIndex: 'email',
        width: '150px',
        align: 'center',
        render: function () {
            function render(text) {
                return '<span class="fa fa-envelope-o"></span> ' + text;
            }

            return render;
        }()
    }];
}.bind(void 0));