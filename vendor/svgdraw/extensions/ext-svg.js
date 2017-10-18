/**
 * Created by wt on 2016/10/27.
 */
methodDraw.addExtension("svg", function (S) {
    if (!window.ExtShape){
        window.ExtShape = [];
    }
    $.extend(window.ExtShape, ["HLX", "NBQ", "XB", "windTurbine", "windTower", "Meter"]);
    //$.extend(window.ExtShape, ["HLX", "NBQ", "NBQHLX", "XB", "windTurbine", "windTower", "Meter"]);

    var canv = methodDraw.canvas;
    var mode_id = 'svglib', current_d, type;
    var cur_lib, library = {}, lastBBox = {}, cur_svg;

    var categories = {
        // wind: "风电"
    };

    function loadLibrary(cat_id){
        var lib = library[cat_id];
        if(!lib){
            $('#svg_buttons').html('Loading...');
            $.getJSON('extensions/svglib/' + cat_id + '.json', function(result, textStatus) {
                cur_lib = library[cat_id] = {
                    data: result.data,
                    size: result.size,
                    fill: result.fill
                };
                makeButtons(cat_id, result);
                loadIcons();
            });
        }
    }

    function makeButtons(cat, shapes) {
        var data = shapes.data;
        cur_lib.buttons = [];
        for(var id in data) {
            var path_d = data[id];
            var icon_btn = '<div class="tool_button svg_button" id="' + mode_id + '_' + id + '" title="' + id + '"><svg xmlns="http://www.w3.org/2000/svg">'+path_d+'<\/svg></div>';
            // Store for later use
            cur_lib.buttons.push(icon_btn);
        }
    }

    function loadIcons() {
        $('#svg_buttons').empty();
        // Show lib ones
        $('#svg_buttons').append(cur_lib.buttons);
    }


    return {
        svgicons: "extensions/ext-shapes.xml",
        buttons: [{
            id: "tool_svglib",
            type: "mode_flyout", // _flyout
            position: 6,
            title: "svg library",
            icon: "extensions/ext-shapes.png",
            events: {
                "click": function () {
                    canv.setMode(mode_id);
                }
            }
        }],
        callback: function () {
            var btn_div = $('<div id="svg_buttons">');
            $('#tools_svglib > *').wrapAll(btn_div);
            var shower = $('#tools_svglib_show');
            loadLibrary('wind');
            $('#svg_buttons').mouseup(function(evt) {
                var btn = $(evt.target).closest('div.tool_button');
                if(!btn.length) return;
                var copy = btn.children().clone().attr({width: 24, height: 24});
                shower.children(':not(.flyout_arrow_horiz)').remove();
                shower
                    .append(copy)
                    .attr('data-curopt', '#' + btn[0].id) // This sets the current mode
                    .mouseup();
                canv.setMode(mode_id);
                cur_shape_id = btn[0].id.substr((mode_id+'_').length);
                current_d = cur_lib.data[cur_shape_id];
                type = btn[0].title;
                $('.tools_flyout').fadeOut();
            });
            var svg_cats = $('<div id="svg_cats">');
            var cat_str = '';
            $.each(categories, function(id, label) {
                cat_str += '<div data-cat=' + id + '>' + label + '</div>';
            });
            svg_cats.html(cat_str).children().bind('mouseup', function() {
                var catlink = $(this);
                catlink.siblings().removeClass('current');
                catlink.addClass('current');
                loadLibrary(catlink.attr('data-cat'));
                // Get stuff
                return false;
            });
            svg_cats.children().eq(0).addClass('current');
            $('#tools_svglib').prepend(svg_cats);
            shower.mouseup(function() {
                canv.setMode(current_d ? mode_id : 'select');
            });
            $('#tool_svglib').remove();
            var h = $('#tools_svglib').height();
            $('#tools_svglib').css({
                'margin-top': -(h/2),
                'margin-left': 3
            });
        },
        mouseDown: function (opts) {
            var mode = canv.getMode();
            if(mode !== mode_id) return;

            var e = opts.event;
            var x = start_x = opts.start_x;
            var y = start_y = opts.start_y;
            var cur_style = canv.getStyle();
            cur_svg = canv.addSvgElementFromJson({
                "element": "g",
                "childData": current_d,
                "attr": {
                    "id": canv.getNextId(),
                    "opacity": cur_style.opacity / 2,
                    "style": "pointer-events:none",
                    "type": type
                }
            });
            cur_svg.setAttribute('transform', "translate(" + x + "," + y + ") scale(0.005) translate(" + -x + "," + -y + ")");
            canv.recalculateDimensions(cur_svg);
            var tlist = canv.getTransformList(cur_svg);
            lastBBox = cur_svg.getBBox();
            totalScale = {
                sx: 1,
                sy: 1
            };
            return {
                started: true
            }
        },
        mouseMove: function (opts) {
            var mode = canv.getMode();
            if(mode !== mode_id) return;

            var zoom = canv.getZoom();
            var evt = opts.event;

            var x = opts.mouse_x/zoom;
            var y = opts.mouse_y/zoom;
            var tlist = canv.getTransformList(cur_svg),
                box = cur_svg.getBBox(),
                left = box.x, top = box.y, width = box.width,
                height = box.height;
            var dx = (x-start_x), dy = (y-start_y);

            var newbox = {
                'x': Math.min(start_x,x),
                'y': Math.min(start_y,y),
                'width': Math.abs(x-start_x),
                'height': Math.abs(y-start_y)
            };

            var ts = null,
                tx = 0, ty = 0,
                sy = height ? (height+dy)/height : 1,
                sx = width ? (width+dx)/width : 1;

            var sx = newbox.width / lastBBox.width;
            var sy = newbox.height / lastBBox.height;

            sx = sx || 1;
            sy = sy || 1;

            if(x < start_x) {
                tx = lastBBox.width;
            }
            if(y < start_y) ty = lastBBox.height;

            var translateOrigin = svgroot.createSVGTransform(),
                scale = svgroot.createSVGTransform(),
                translateBack = svgroot.createSVGTransform();
            translateOrigin.setTranslate(-(left+tx), -(top+ty));
            if(evt.shiftKey) {
                replaced = true
                var max = Math.min(Math.abs(sx), Math.abs(sy));
                sx = max * (sx < 0 ? -1 : 1);
                sy = max * (sy < 0 ? -1 : 1);
                if (totalScale.sx != totalScale.sy) {
                    var multiplierX = (totalScale.sx > totalScale.sy) ? 1 : totalScale.sx/totalScale.sy;
                    var multiplierY = (totalScale.sy > totalScale.sx) ? 1 : totalScale.sy/totalScale.sx;
                    sx *= multiplierY
                    sy *= multiplierX
                }
            }
            totalScale.sx *= sx;
            totalScale.sy *= sy;
            scale.setScale(sx,sy);
            translateBack.setTranslate(left+tx, top+ty);
            var N = tlist.numberOfItems;
            tlist.appendItem(translateBack);
            tlist.appendItem(scale);
            tlist.appendItem(translateOrigin);

            canv.recalculateDimensions(cur_svg);
            lastBBox = cur_svg.getBBox();
        },
        mouseUp: function (opts) {
            var mode = canv.getMode();
            if(mode !== mode_id) return;

            if(opts.mouse_x == start_x && opts.mouse_y == start_y) {
                return {
                    keep: false,
                    element: cur_svg,
                    started: false
                }
            }
            canv.setMode("select")
            return {
                keep: true,
                element: cur_svg,
                started: false
            }
        },
        callBackSelect: function (data, type) {
            var arrType = {"HLX":"汇流箱", "NBQ":"逆变器", "NBQHLX":"逆变器汇流箱", "XB":"箱变", "windTurbine":"风电机组", "windTower":"测风塔", "videoImage":"监控点", "Meter":"电表"};
            var deviceId = $("#"+data.elem.id).attr("deviceId");
            var _parents = $("div[class='select_input_content'][type='"+ data.type +"']").parents(".select_box");
            updateSelLiData(data.type, deviceId);
            if (!deviceId){
                _parents.find(".select_input_content").text("选择"+arrType[data.type]);
                return;
            }
            _parents.find(".select_input_content").text(_parents.find(".select_sel li[data-id='"+deviceId+"']").text());
            _parents.find(".select_input_content").attr("data-id", deviceId);
        }
    }
});
