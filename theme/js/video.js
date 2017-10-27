var mcontent;
window.vframe = {
    api:'bmdehs6pbz0ps',
    token:function(phone){     
        $.post("http://www.workguide.net/index/index/token", {phone: phone}, function (data) {
            if (data.code == 200) {
                RongIMClient.connect(data.data, {
                    onSuccess: function (userId) {
                        console.log("Login successfully." + userId);
                    },
                    onTokenIncorrect: function () {
                        console.log('token无效');
                    },
                    onError: function (errorCode) {
                        var info = '';
                        switch (errorCode) {
                            case RongIMLib.ErrorCode.TIMEOUT:
                                info = '超时';
                                break;
                            case RongIMLib.ErrorCode.UNKNOWN_ERROR:
                                info = '未知错误';
                                break;
                            case RongIMLib.ErrorCode.UNACCEPTABLE_PaROTOCOL_VERSION:
                                info = '不可接受的协议版本';
                                break;
                            case RongIMLib.ErrorCode.IDENTIFIER_REJECTED:
                                info = 'appkey不正确';
                                break;
                            case RongIMLib.ErrorCode.SERVER_UNAVAILABLE:
                                info = '服务器不可用';
                                break;
                        }
                        console.log(errorCode);
                    }
                });
            }
            else {
                window.console.log("获取token失败");
            }
        }, 'json');
    },
    init:function(coopRequest){
        RongIMLib.RongIMClient.init(this.api);
        RongIMClient.setConnectionStatusListener({
            onChanged: function (status) {
                switch (status) {
                    case RongIMLib.ConnectionStatus.CONNECTED:
                        console.log('链接成功');
                        break;
                    case RongIMLib.ConnectionStatus.CONNECTING:
                        console.log('正在链接');
                        break;
                    case RongIMLib.ConnectionStatus.DISCONNECTED:
                        console.log('断开连接');
                        break;
                    case RongIMLib.ConnectionStatus.KICKED_OFFLINE_BY_OTHER_CLIENT:
                        console.log('其他设备登录');
                        break;
                    case RongIMLib.ConnectionStatus.DOMAIN_INCORRECT:
                        console.log('域名不正确');
                        break;
                    case RongIMLib.ConnectionStatus.NETWORK_UNAVAILABLE:
                        console.log('网络不可用');
                        break;
                }
            }});
        // 消息监听器
        RongIMClient.setOnReceiveMessageListener({
            // 接收到的消息
            onReceived: function (message) {
                // 判断消息类型
                switch (message.messageType) {
                    case RongIMClient.MessageType.TextMessage:
                        // message.content.content => 消息内容
                        window.console.log("内容:" + message.content.content);
                        var ar = message.content.content.split("#");
                        if (ar[0] == "open") {
                            $.post("http://www.workguide.net/index/index/uname", {id: message.senderUserId}, function (data) {
                                if (data.code == 200) {
                                //$('#cool_name').html(data.name);
                                coopRequest(data.name);
                            }
                            else {
                                coopRequest("获取失败，id" + message.senderUserId);
                                //$('#cool_name').html("获取失败，id" + message.senderUserId);
                            }
                        }, 'json');
                            $('#cool_name').html('');
                            mcontent = message;
                        }
                        break;
                    default:
                        break;
                }
            }
        });
        /*测试*/

        /*setInterval(function(){
            coopRequest("张三");
        },5000)*/

         /*测试*/
    },
    accept:function (phone) {
        //跳转到另一个界面
        var msg = new RongIMLib.TextMessage({content: "response#accept", extra: ""});
        var conversationtype = RongIMLib.ConversationType.PRIVATE; // 单聊,其他会话选择相应的消息类型即可。
        var targetId = mcontent.senderUserId; // 目标 Id
        RongIMClient.getInstance().sendMessage(conversationtype, targetId, msg, {
        onSuccess: function (message) {
            console.log("Send successfully");
            window.open ("https://www.workguide.net/index/index/video.html?phone="+phone+"&id=" + mcontent.senderUserId + "&task=" + mcontent.content.content.split("#")[1], '', 'height=500, width=1000, top=100, left=100, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no')
        },
        onError: function (errorCode, message) {
        }});
    },
    reject:function () {
        var msg = new RongIMLib.TextMessage({content: "response#reject", extra: ""});
        var conversationtype = RongIMLib.ConversationType.PRIVATE; // 单聊,其他会话选择相应的消息类型即可。
        var targetId = mcontent.senderUserId; // 目标 Id
        RongIMClient.getInstance().sendMessage(conversationtype, targetId, msg, {
            onSuccess: function (message) {
                console.log("Send successfully");
            },
            onError: function (errorCode, message) {
            }});
    }
};

        