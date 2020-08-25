
var i18nLanguage = "zh_CN";
function execI18n(){
var optionEle = $("#i18n_pagename");
var sourceName = optionEle.attr('content');
sourceName = sourceName.split();
i18nLanguage = window.localStorage.userLanguage?window.localStorage.userLanguage:"zh_CN"
      jQuery.i18n.properties({
          name : sourceName,//资源文件名称fffffffffffff
          path : i18nLanguage +'/',//资源文件路径
          mode : 'map', //用Map的方式使用资源文件中的值
          language : i18nLanguage,
          callback : function() {//加载成功后设置显示内容
              var insertEle = $(".i18n");
              insertEle.each(function() {
                  // 根据i18n元素的 name 获取内容写入
                  $(this).html($.i18n.prop($(this).attr('name')));

              });
              var insertInputEle = $(".i18n-input");
              insertInputEle.each(function() {
                  var selectAttr = $(this).attr('selectattr');
                  if (!selectAttr) {
                      selectAttr = "value";
                  };
                  $(this).attr(selectAttr, $.i18n.prop($(this).attr('selectname')));
              });
          }
      });
}

/*页面执行加载执行*/
$(function(){

  /*执行I18n翻译*/
  execI18n();

  /*将语言选择默认选中缓存中的值*/
  $("#language option[value="+i18nLanguage+"]").attr("selected",true);

  /* 选择语言 */
  $("#language").on('change', function() {
      var language = $(this).children('option:selected').val()
      window.localStorage.userLanguage = language
      execI18n();
  });
});