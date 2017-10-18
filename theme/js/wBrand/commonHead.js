var urlPre = document.getElementById('routerJS').getAttribute('param')
app.directive('commonHead', function(myAjaxData) {
    // 将对象return出去
    return{
        restrict: 'E',
        templateUrl: urlPre + '/tpl/wBrand/components/commonHead.jsp',
        replace: true, 
        transculde: true,

        scope: {
            // arealist: '=',
            // indicators: '=',
            // dateType: '='
        },

        link: function ($scope, $element, $attrs) {
            // body...
        },

        controller: function ($scope) {
            $scope.arealist = myAjaxData.config.area
            $scope.indicators = myAjaxData.config.indicators
            $scope.dateType = myAjaxData.config.dateType

            $scope.currentArea = $scope.arealist[0]
            $scope.currentIndicator = $scope.indicators[0]

            $scope.changeDateType = function (type) {
                $scope.dateType.currentDateType = type
            }
        }
    }
})

app.directive('toggleDiv', function() {
    // 将对象return出去
    return{
        restrict: 'A',
        // templateUrl: urlPre + '/tpl/wBrand/components/commonHead.jsp',
        // replace: true, 
        // transculde: true,

        scope: true,

        link: function ($scope, $element, $attrs) {
            $element.click(function () {
                return false
            }).children('button').click(function () {
                $(this).css({'height': '50px'})
                $element.find('div').show()
            })

            $(document).click(function () {
                $element.children('button').css('height', '40px')
                $element.find('div').hide()
            })
        },

        controller: function ($scope) {

            
        }
    }
})