$(function () {
    areaEvent();
    selLiEvent();
    saveData();
    cancelButton();
    selectEvent();
    selectSelEvent();
    canvasImageBackground();
});

function cancelButton() {
    $(".cancel_button").off().on("click", function () {
        window.parent.cancelSvgClick();
    });
}

function saveData() {
    $(".save_button").off().on("click", function () {
        var data = {};
        data.entityId = $(".st_content").attr("data-stid");
        data.name = $(".name_text input[name='name']").val();
        data.id = $("input[name='id']").val();
        data.isDisplay = $(".name_text input[name='isDisplay']:checked").length==1?1:0;
        if (validData(data)){
            window.parent.saveSvgDataToDataBase(data);
        }
    });
}

function validData(data) {
    if (!data.entityId){
        alert("请选择电站");
        return false;
    }
    if (!data.name){
        alert("请输入名称");
        return false;
    }

    var arrType = {"HLX":"汇流箱", "NBQ":"逆变器", "NBQHLX":"逆变器汇流箱", "XB":"箱变", "windTurbine":"风电机组", "windTower":"测风塔", "videoImage":"监控点", "Meter":"电表"};
    var paths = $("#svgcontent g");
    for (var i=0,ii=paths.length;i<ii;i++){
        var _obj = $(paths[i]);
        var type = _obj.attr("type");
        if (type != null && type != ""){
            if (!_obj.attr("deviceId")){
                alert("请绑" + arrType[type]);
                svgCanvas.clearSelection();
                svgCanvas.addToSelection([svgCanvas.getElem($(paths[i]).attr("id"))]);
                return false;
            }
        }
    }
    return true;
}

function setDataWithCreate(res) {
    $(".st_sel").empty();
    $("#stidListTmpl").tmpl(res).appendTo($(".st_sel"));
    $(".st_area").show();
    areaEvent();
    selLiEvent();
}

function setDataWithEdit(data) {
    $.get(ctx + '/' + data.svgPath + '?' + new Date().getTime(), function (svg) {//加载svg文件
        svgCanvas.setSvgString($(svg.documentElement).prop("outerHTML"));

        if($(svg.documentElement).find("#imageBackground image").length) {
            $('#imageBackground').parents('defs').attr('id', 'canvas_background_defs');//设置背景图片id
            var data = $(svg.documentElement).find("#imageBackground image").attr('xlink:href');
            $("#bgImage_canvas_tools .bgImage_upload").hide();
            $("#bgImage_canvas_tools .bgImage_image").empty();
            $("#bgImage_canvas_tools .bgImage_image").append(
                '<img src="' + data + '" width="60" height="40" />' +
                '<div class="delp"><a href="javascript:;" class="delA">删除</a></div>'
            ).show();
        }
    });
    $("input[name='id']").val(data.id);
    $(".st_content").text(data.stationname);
    $(".st_content").attr("data-stid", data.entityId);
    $(".name_text input[name='name']").val(data.name);
    $(".name_text input[name='isDisplay']").attr("checked", data.isDisplay==1);
    $(".st_area").unbind("click");
    $(".st_area").hide();

    window.parent.pStationSelectChange(data.entityId);
}

function areaEvent() {
    $(".st_area").off().on("click", function (event) {
        event.stopPropagation();
        var _obj = $(".st_sel");
        if (_obj.is(":visible")){
            _obj.slideUp(200);
        }else{
            _obj.slideDown(500);
        }
    });
}

function selLiEvent() {
    $(".st_sel li").off().on("click", function () {
        var _this = $(this);
        $(".st_content").attr("data-stid", _this.attr("data-stid"));
        $(".st_content").text(_this.text());
        $(".st_sel").slideUp(200);
        window.parent.pStationSelectChange(_this.attr("data-stid"));
    });
}

/**
 * 分机下拉事件
 */
function selectEvent() {
    $(".select_input_area").off().on("click", function(event){
        event.stopPropagation();
        var _obj = $(this).parents(".select_box").find(".select_sel");
        if (_obj.is(":visible")){
            _obj.slideUp(200);
        }else{
            _obj.slideDown(500);
        }
    });
}

/**
 * 选择事件
 */
function selectSelEvent() {
    $(".select_sel li").off().on("click", function () {
        var _this = $(this);
        $(".select_input_content").text(_this.text());
        $(".select_input_content").attr("data-id", _this.attr("data-id"));
        $(".select_sel").slideUp(200);
        svgCanvas.changeSelectLi(_this.parents(".select_box").find(".select_input_content").attr("type"));
    });
}

var deviceData = {};
function dataInitSelect(res, type) {
    //var _obj = $("#"+ type +"_panel").find(".select_sel");
    //_obj.empty();
    //$("#deviceListTmpl").tmpl(res).appendTo(_obj);
    //selectSelEvent();
    deviceData[type] = res.data;
    updateSelLiData(type);
}

function updateSelLiData(type, deviceId) {
    var $eles = svgCanvas.getVisibleElements();
    var currDeviceTypeData = new Array();
    var deviceIds = new Array();
    $.each($eles, function(index, eleData){
        var $type = $(eleData).attr('type');
        if (type == $type) {
            var eleDeviceId = $(eleData).attr('deviceId');
            if (eleDeviceId != '' && eleDeviceId != null && eleDeviceId != deviceId) {
                deviceIds.push(eleDeviceId);
            }
        }
    });

    if(deviceIds.length > 0){
        $.each(deviceData[type], function(i, data) {
            var flag = false;
            $.each(deviceIds, function(i, thisDeviceId) {
                if (thisDeviceId === data.serialNumber) {
                    flag = true;
                }
            });
            if (!flag) {
                currDeviceTypeData.push(data);
            }
        });
    } else {
        currDeviceTypeData = deviceData[type];
    }
    var _obj = $("#"+ type +"_panel").find(".select_sel");
    _obj.empty();
    $("#deviceListTmpl").tmpl({data: currDeviceTypeData}).appendTo(_obj);
    selectSelEvent();
}

/*********背景图************/
function canvasImageBackground(){
    //var bgImageFlag = false;
    //function uploadImage() {
        //bgImageFlag = true;
        $(document).on('change', '#fileBgImage', function () {
        //$("#fileBgImage").change(function () {
        //    var file = this.files[0];
            var file = this.files[0];
            if(file.size>2097152){
                alert("上传图片请小于2M");
                return false;
            }
            if(!/image\/\w+/.test(file.type)){
                alert("请确保文件为图像类型");
                return false;
            }

            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function(e){
                var data = this.result;
                var image = new Image();
                image.src = this.result;
                image.onload = function() {
                    var width = image.width;
                    var height = image.height;
                    var bgWidth = $("#canvasBackground").attr("width");
                    var bgHeight = $("#canvasBackground").attr("height");

                    $("#bgImage_canvas_tools .bgImage_image").empty();
                    $("#bgImage_canvas_tools .bgImage_image").append(
                        '<img src="' + data + '" width="60" height="40" />' +
                        '<div class="delp"><a href="javascript:;" class="delA">删除</a></div>');
                    $("#gridpattern")[0].setAttribute("width", bgWidth + 2);
                    $("#gridpattern")[0].setAttribute("height", bgHeight + 2);
                    $("#gridpattern image")[0].setAttribute("width", bgWidth);
                    $("#gridpattern image")[0].setAttribute("height", bgHeight);
                    $("#gridpattern image")[0].setAttribute("xlink:href", data);

                    var defs = null;
                    if ($("#canvas_background_defs").length == 0) {
                        defs = document.createElementNS("http://www.w3.org/2000/svg", "defs");
                        defs.setAttribute("id", "canvas_background_defs");
                        $("#svgcontent g:eq(0)")[0].appendChild(defs);
                    } else {
                        defs = $("#svgcontent g:eq(0) defs")[0];
                        $("#svgcontent #imageBackground").remove();
                    }
                    defs.appendChild($("#gridpattern")[0].cloneNode(true));
                    $("#svgcontent g:eq(0) #gridpattern")[0].setAttribute("id", "imageBackground");
                    $("#canvas_background")[0].setAttribute("fill", "url(#imageBackground)");

                    $("#bgImage_canvas_tools .bgImage_image").show();
                    $("#bgImage_canvas_tools .bgImage_upload").hide();
                    //delImage();
                }
            }
        });
    //}
    //uploadImage();

    //function delImage() {
        $(document).on("click", '#bgImage_canvas_tools .delA', function () {
        //$("#bgImage_canvas_tools .delA").on("click", function () {
            $("#bgImage_canvas_tools .bgImage_upload").empty();
            $("#bgImage_canvas_tools .bgImage_upload").append('<p>上传</p><input type="file" id="fileBgImage"/>').show();
            $("#bgImage_canvas_tools .bgImage_image").hide();
            $("#gridpattern image")[0].setAttribute("xlink:href", "");
            $("#canvas_background_defs").remove();
            $("#canvas_background")[0].setAttribute("fill", $("#canvas_color rect")[0].getAttribute("fill"));
            //uploadImage();
        });
    //}

    $("#bgImage_canvas_tools .bgImage_box").mouseover(function () {
        //if (bgImageFlag){
            $("#bgImage_canvas_tools .delp").animate({"bottom": 0});
        //}
    });

    $("#bgImage_canvas_tools .bgImage_box").mouseleave(function () {
        //if (bgImageFlag){
            $("#bgImage_canvas_tools .delp").animate({"bottom": -20});
        //}
    });
}

/**
 * 将以base64的图片url数据转换为Blob
 * @param urlData
 *            用url方式表示的base64图片数据
 */
function convertBase64UrlToBlob(urlData){
    var dataArr = urlData.split(',');

    var bytes = window.atob(dataArr[1]);        //去掉url的头，并转换为byte
    var type = dataArr[0].substring(dataArr[0].indexOf(':')+1, dataArr[0].indexOf(';'));

    //处理异常,将ascii码小于0的转换为大于0
    var ab = new ArrayBuffer(bytes.length);
    var ia = new Uint8Array(ab);
    for (var i = 0; i < bytes.length; i++) {
        ia[i] = bytes.charCodeAt(i);
    }

    return new Blob( [ab] , {type :type});
}