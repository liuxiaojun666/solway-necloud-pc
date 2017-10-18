(function ($) {
    function getRandomNum() {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    }

    function initWebUpload(element, options) {
        if (!WebUploader.Uploader.support()) {
            var error = "上传控件不支持您的浏览器！请尝试升级flash版本或者使用Chrome引擎的浏览器。<a $uploader='_blank' href='http://se.360.cn'>下载页面</a>";
            $(element).text(error);
            return;
        }
        //创建默认参数
        var defaults = {
            auto:true,
            url: '/FileUpload/addFile.htm',
            downloadUrl:'/FileUpload/download.htm',
            deleteUrl:'/FileUpload/deleteFile.htm',
            files: [],
            onAllComplete: function (event) { }, // 当所有file都上传后执行的回调函数
            onSuccess: function (data) { },// 每上传一个file的回调函数
            onDownload: function (data) { },//下载文件回调函数
            innerOptions: {
                duplicate:true,
                resize: false,
                fileNumLimit: undefined,//验证文件总数量, 超出则不允许加入队列
                fileSizeLimit: undefined,//验证文件总大小是否超出限制, 超出则不允许加入队列。
                fileSingleSizeLimit: undefined,//验证单个文件大小是否超出限制, 超出则不允许加入队列
                fileVal: 'file'
            },
        };
        var opts = $.extend(defaults, options);

        var pickerid = (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
        //WebUploader 参数
        var webUploaderOptions = $.extend({
                // swf文件路径
                swf: '/vendor/jquery/WebUploader/Uploader.swf',
                // 文件接收服务端。
                server: opts.url,
                // 选择文件的按钮。可选。
                // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                pick: '#' + pickerid,
                duplicate:true,
                //不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
                resize: false,
                accept: {
                    extensions: 'gif,jpg,jpeg,bmp,png,zip,rar,7z,doc,docx,xls,xlsx,ppt,pptx,txt,',
                }
            },
            opts.innerOptions);

        //外文容器
        var $uploader = $(element);

        //初始化上传组件布局
        setUploaderContainer();

        //保存文件序列
        var $list = $uploader.find('.uploader-list'),//文件序列
            $btn = $uploader.find('.webuploadbtn'),//手动上传按钮备用
            $hiddenInput = $uploader.find('.uploadHiddenInput'),
            state = 'pending',
            uploader;

        function getUploader(opts) {
            return WebUploader.create(opts);
        }

        var uploader = getUploader(webUploaderOptions);

        if (opts.auto) {
            uploader.on('fileQueued', function (file) {
                if (file.skipped) {//跳过初始化文件
                    addFile('已上传', file, true);
                    return;
                } else {
                    addFile('正在上传...', file, false);
                    uploader.upload();
                }
            });
        } else {
            uploader.on('fileQueued', function (file) {//队列事件
                addFile('等待上传...', file, false);
            });
        }
        
        uploader.on('uploadProgress', function (file, percentage) {//进度条事件
            var $li = $uploader.find('#' + $uploader.attr('id') + file.id),
                $percent = $li.find('.progress .progress-bar');

            // 避免重复创建
            if (!$percent.length) {
                $percent = $('<div class="progress">' +
                                '<div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="-45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">' +
                                    '<span class="sr-only text"></span>' +
                                '</div>' +
                            '</div>').appendTo($li).find('.progress-bar');
            }

            $li.find('span.webuploadstate').html('上传中');
            $li.find(".text").text(Math.round(percentage * 100) + '%');
            $percent.css('width', percentage * 100 + '%');
        });
        uploader.on('uploadSuccess', function (file, result) {//上传成功事件
            if (result.code != '0') {
                $uploader.find('#' + $uploader.attr('id') + file.id).find('span.webuploadstate').html(result.message);
            } else {
                $uploader.find('#' + $uploader.attr('id') + file.id).find('span.webuploadstate').html('已上传');
                setSuccessData(file, result.data);
            }
            opts.onSuccess(result.data);
        });

        uploader.on('uploadError', function (file) {
            $uploader.find('#' + $uploader.attr('id') + file.id).find('span.webuploadstate').html('上传出错');
        });

        uploader.on('uploadComplete', function (file) {//全部完成事件
            $uploader.find('#' + $uploader.attr('id') + file.id).find('.progress').fadeOut();
        });

        uploader.on('all', function (type) {
            if (type === 'startUpload') {
                state = 'uploading';
            } else if (type === 'stopUpload') {
                state = 'paused';
            } else if (type === 'uploadFinished') {
                state = 'done';
            }

            if (state === 'uploading') {
                $btn.text('暂停上传');
            } else {
                $btn.text('开始上传');
            }
        });

        //删除时执行的方法
        uploader.on('fileDequeued', function (file) {
            var obj = webUploaderOptions.formData;
            obj.id = $('#hiddenInput' + $uploader.attr('id') + file.id + '_id').val();
            obj.deleteFlag = true;
            console.info(obj);
            $.post(opts.deleteUrl, obj, function (data) {
                //alert(data.message);
                console.info(data);
            })

            $("#"+ $uploader.attr('id') + file.id).remove();
            $("#hiddenInput" + $uploader.attr('id') + file.id).remove();

        });
        uploader.on('error', function (code) {
            var text = '';
            switch( code ) {
                case  'F_DUPLICATE' : text = '该文件已经被选择了!' ;
                    break;
                case  'Q_EXCEED_NUM_LIMIT' : text = '上传文件数量超过限制!' ;
                    break;
                case  'F_EXCEED_SIZE' : text = '文件大小超过限制!';
                    break;
                case  'Q_EXCEED_SIZE_LIMIT' : text = '所有文件总大小超过限制!';
                    break;
                case 'Q_TYPE_DENIED' : text = '文件格式不支持!';
                    break;
                default : text = '未知错误!';
                    break;
            }
            alert( text );
        })

        //多文件点击上传的方法
        $btn.on('click', function () {
            if (state === 'uploading') {
                uploader.stop();
            } else {
                uploader.upload();
            }
        });

        //删除
        $list.on("click", ".webuploadDelbtn", function () {
            var $ele = $(this).parent();
            var parentId = $ele.attr("id");
            var id = parentId.replace($uploader.attr('id'), "");

            var file = uploader.getFile(id);
            uploader.removeFile(file, true);
        });

        //下载
        $list.on("click", ".webuploadDownloadbtn", function () {
            var $ele = $(this).parent();
            var obj = webUploaderOptions.formData;
            obj.id = $('#hiddenInput' + $ele.attr("id") + ' input[name="id"]').val();
            //$.post(opts.downloadUrl, obj);
            console.info(JSON.stringify(obj));
            window.open(opts.downloadUrl + '?' + JSON.stringify(obj))
            //opts.onDownload(obj);
        });

        //加载的时候，页面加载的时候模拟文件加入队列进行图片的编辑回显
        uploader.on('ready',function(){
            $.each(opts.files, function(i, v) {
                if(!v.id) {
                    v.id = i+1;
                }
                var obj = {
                    name: v.originalFileName,
                    size: v.fileSize,
                }
                //id, targetId, targetType, originalFileName, fileName, fileDirectory, filePath, fileSize, fileType, opTime, status
                var file = new WebUploader.File(obj);
                uploader.skipFile(file);
                uploader.addFile(file);
                //console.info(file)
                setSuccessData(file, v);
            });
        });

        function addFile(text, file, flag){
            if (flag) {
                $list.append('<div id="' + $uploader.attr('id') + file.id + '" class="uploader-item">' +
                    '<span class="webuploadinfo">' + file.name + '</span>' +
                    '<span class="webuploadstate">' + text + '</span>' +
                    '<span class="webuploadDelbtn"><i class="icon-trash"></i></span>'+
                    '<span class="webuploadDownloadbtn"><i class="fa fa-paperclip"></i></span>'+
                    '</div>');
            } else {
                $list.append('<div id="' + $uploader.attr('id') + file.id + '" class="uploader-item">' +
                    '<span class="webuploadinfo">' + file.name + '</span>' +
                    '<span class="webuploadstate">' + text + '</span>' +
                    '<span class="webuploadDelbtn"><i class="icon-trash"></i></span>'+
                    '</div>');
            }
        }
        function setUploaderContainer() {
            var uploaderStrDiv;
            if (opts.auto) {
                uploaderStrDiv =
                    '<div class="webuploader">' +
                    '<div id="uploaderList" class="uploader-list"></div>' +
                    '<div class="btns">' +
                    '<div id="' + pickerid + '">选择文件</div>' +
                    '</div>' +
                    '<div style="display:none" class="uploadHiddenInput" ></div>' +
                    '</div>';
            } else {
                uploaderStrDiv =
                    '<div class="webuploader">' +
                    '<div id="uploaderList" class="uploader-list"></div>' +
                    '<div class="btns">' +
                    '<div id="' + pickerid + '">选择文件</div>' +
                    '<a class="webuploadbtn">开始上传</a>' +
                    '</div>' +
                    '<div style="display:none" class="uploadHiddenInput" ></div>' +
                    '</div>';
            }
            $uploader.append(uploaderStrDiv);
        }
        //设置成功数据
        function setSuccessData(file, data){

            $hiddenInput.append('<div class="hiddenInputDiv" id="hiddenInput' + $uploader.attr('id') + file.id + '"></div>');
            var $hiddenInputDiv = $hiddenInput.find('#hiddenInput' + $uploader.attr('id') + file.id);

            $.each(data, function(i, v) {
                $hiddenInputDiv.append('<input type="text" id="hiddenInput' + $uploader.attr('id') + file.id + '_' + i + '" class="hiddenInput" name="' + i + '" value="' + v + '" />');
            });
        }

    }
    $.fn.extend({
        getFileData: function (options) {
            var ele = $(this);
            var resultData = [];
            var hiddenInputDivs = ele.find(".hiddenInputDiv");
            $.each(hiddenInputDivs, function () {
                var obj = {};
                $(this).find('input').each(function () {
                    obj[$(this).attr('name')] = $(this).val();
                })
                resultData.push(obj);
            })
            return resultData;

        },
        powerWebUpload : function (options) {
            var ele = this;
            initWebUpload(ele, options);
        }
    });
})(jQuery);