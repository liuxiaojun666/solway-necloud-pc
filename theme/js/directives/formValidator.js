function errorPlacement(error, element) {
    element.wrap('<div style="display:inline-block;width:100%;position:relative;"/>').parent().append('<span class="validator-error" style="position:absolute;bottom:-16px;left:5px;font-size:12px;color:red;z-index:9999;pointer-events: none;"/>').find('span').append(error)
}
function deleteError(element) {
    $(element).clone(true).replaceAll($(element).parent()).blur()
}

var errorStr = {
    vRequired: '为空不行啦',
    vEmail: '没见过这样的邮箱',
    vNumber: '有一种数字叫阿拉伯数字',
    vMobile: '手机号好像写错了',
    vPhone: '电话好像写错了',
}

/**
 * [必填验证]
 */
app.directive('vRequired', function() {
    return{
        restrict: 'A',
        scope: {},
        link: function ($scope, $element, $attrs) {
            $($element).on('blur', function () {
                if ($(this).next().eq(0).hasClass('validator-error')) { return deleteError(this) }
                if (!$(this).val().trim()) errorPlacement(errorStr.vRequired, $(this))
            })
        }
    }
})

/**
 * [邮箱验证]
 */
app.directive('vEmail', function() {
    return{
        restrict: 'A',
        scope: {},
        link: function ($scope, $element, $attrs) {
            $($element).on('blur', function () {
                var val = $(this).val().trim()
                if ($(this).next().eq(0).hasClass('validator-error')) { return deleteError(this) }
                if (!$attrs.required && val === '') {
                    return
                }
                if (!/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(val)) {
                    errorPlacement(errorStr.vEmail, $(this))
                }
            })
        }
    }
})

/**
 * [手机号验证]
 */
app.directive('vMobile', function() {
    return{
        restrict: 'A',
        scope: {},
        link: function ($scope, $element, $attrs) {
            $($element).on('blur', function () {
                var val = $(this).val().trim()
                if ($(this).next().eq(0).hasClass('validator-error')) { return deleteError(this) }
                if (!$attrs.required && val === '') {
                    return
                }
                if (!/^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\d{8}$/.test(val)) {
                    errorPlacement(errorStr.vMobile, $(this))
                }
            })
        }
    }
})


/**
 * [电话号验证]
 * ("XXX-XXXXXXX"、"XXXX-XXXXXXXX"、"XXX-XXXXXXX"、"XXX-XXXXXXXX"、"XXXXXXX"和"XXXXXXXX)
 */
app.directive('vPhone', function() {
    return{
        restrict: 'A',
        scope: {},
        link: function ($scope, $element, $attrs) {
            $($element).on('blur', function () {
                var val = $(this).val().trim()
                if ($(this).next().eq(0).hasClass('validator-error')) { return deleteError(this) }
                if (!$attrs.required && val === '') {
                    return
                }
                if (!/^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$/.test(val)) {
                    errorPlacement(errorStr.vPhone, $(this))
                }
            })
        }
    }
})

/**
 * [数字验证]
 * length="4"   固定长度
 */
app.directive('vNumber', function() {
    return{
        restrict: 'A',
        scope: {},
        link: function ($scope, $element, $attrs) {
            $($element).on('blur', function () {

                var re =new RegExp("^[0-9]+$","")

                var val = $(this).val().trim()

                if ($(this).next().eq(0).hasClass('validator-error')) { 
                    return deleteError(this) 
                }

                if (!$attrs.required && val === '') {
                    return
                }

                if (!re.test(val)) {
                    return errorPlacement(errorStr.vNumber, $(this))
                }

                re = new RegExp("^\\d{" + $attrs.length + "}$", "")
                if ($attrs.length && !re.test(val)) {
                    return errorPlacement('写'+$attrs.length+'位就可以了', $(this))
                }
            })
        }
    }
})


/**
 * [提交验证  验证给定作用域的]
 * v-Submit  属性值  为一个  选择器   不写验证整个页面
 */
app.directive('vSubmit', function($timeout) {
    return{
        restrict: 'A',
        scope: {},
        link: function ($scope, $element, $attrs) {
            var scope = $attrs.vSubmit || 'body'
            $($element).on('validator', function (e, fun) {
                $($element).parents(scope).find(Object.keys(errorStr).map(function (v, i) {
                    return '[v-'+v.toLocaleLowerCase().substr(1)+']'
                }).toString()).blur()
                $timeout(function () {
                    if ($('.validator-error').length === 0) {
                        fun()
                    }
                }, 0)
            })
        }
    }
})