<%--
  User: GreenBook
  Date: 2017/5/26
  Time: 10:54
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<div class="form-group">
    <label class="col-lg-2 control-label">附件上传</label>
    <div class="col-lg-10">
        <div id="WebUploader" style="margin-left:10px"></div>
    </div>
</div>

<link rel="stylesheet" href="${ctx}/vendor/jquery/WebUploader/css/webuploader.css" type="text/css">
<script type="text/javascript" src="${ctx}/vendor/jquery/WebUploader/webuploader.min.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/WebUploader/MyWebUploader.0x00.js"></script>



<script type="text/javascript">
    $("#WebUploader").powerWebUpload({
        files: [],//加载已经上传文件
        innerOptions: {
            formData: {
                targetId: '193',//
                targetType: '',//Global.DOC_ATTACHMENT_MAP key(类型) 每个表一个值
            },
            fileNumLimit: 5,//验证文件总数量, 超出则不允许加入队列
        },
    });
</script>