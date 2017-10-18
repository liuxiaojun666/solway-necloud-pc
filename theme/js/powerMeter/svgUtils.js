$(function () {
    /****************公共*****************************/
    var titleFlag = true;
    function Common() {
        this._svgView = $("#svgView").length > 0 ? $("#svgView") : $(window.frames["svgView"].document.getElementsByTagName("svg"));
        this._rotateSpeed = 3;
        var _this = this, titleI = 0;
        if (titleFlag){
            titleFlag = false;
            var timerTitle = setInterval(function () {
                if (titleI > 50) clearInterval(timerTitle);
                _this.removeSvgTitle();
                titleI++;
            }, 100);
        }
    }
    Common.prototype.createIndexFlag = function (type, callBack) {
        if (this._indexFlag){
            var _thisP = this;
            var i = 0;
            _thisP._svgView.find("g[type='" + type + "']").each(function () {
                var _this = $(this);
                _this.attr("index", i);
                i++;
                if (callBack){
                    callBack(_this, _thisP, i);
                }
            });
            this._indexFlag = false;
        }
    };
    Common.prototype.removeSvgTitle = function () {
        this._svgView.find("title").remove();
    };
    Common.prototype.flushRemoveSvgTitle = function () {
        this._svgView.find("title").remove();
    };
    var common = null;
    function getCommon() {
        if (common == null){
            common = new Common();
        }
        return common;
    }

    /*******************电表**********************************/
    function Meter() {
        Common.call(this);
        //BREAK = "#999", ALERT = "#f90", ERROR = "#db412f", NORMAL = "#3fad22", SELECT = "#15575f";
        //0 normal 1 break 2 error 3 alert
        this.statusColor = ["#3fad22", "#999", "#db412f", "#f90"];
        this.data = [];
    }
    Meter.prototype = getCommon();
    Meter.prototype.changeMeterStatus = function ($obj, data) {
        $obj.find("rect").attr("stroke", this.statusColor[data.status]);
        $obj.find("line").attr("stroke", this.statusColor[data.status]);
    };
    Meter.prototype.flushMeter = function (data, callBack) {
        var _this = this;
        _this.data = data;
        $.each(_this.data, function(i, v){
            var $svgView = _this._svgView.find("g[type='Meter'][deviceid='" + v.deviceId + "']");
            if (!!callBack && !callBack($svgView, v)) true;
            _this.changeMeterStatus($svgView, v);
        });
    };
    Meter.prototype.selectMeterStatus = function (status) {
        var _this = this;
        $.each(_this.data, function(i, v){
            var $svgView = _this._svgView.find("g[type='Meter'][deviceid='" + v.deviceId + "']");
            if(status.contains(v.status)) {
                $svgView.show();
            } else {
                $svgView.hide();
            }
        });
    }
    /*******************风机************************************/
    function WindTurbine() {
        Common.call(this);
        this._objectTimes = {};
        this._rotateGlobal = 0;
        this._intervalTime = 8;
        this._indexFlag = true;
        this._rotateStatus = [];
    }
    WindTurbine.prototype = getCommon();
    WindTurbine.prototype.createWindTurbineIndexFlag = function () {
        this.createIndexFlag("windTurbine", function (_this, _thisP, index) {
            _thisP._rotateStatus[index] = 0;
        });
    };
    WindTurbine.prototype.startInterval = function ($obj) {
        var _this = this;
        var rotate = _this._rotateGlobal;
        return setInterval(function () {
            $obj.attr("transform", "rotate(" + rotate + ")");
            rotate += _this._rotateSpeed;
            rotate = rotate%360;
            _this._rotateGlobal = rotate;
        }, _this._intervalTime);
    };
    WindTurbine.prototype.startRequestAnimationFrame = function ($obj, index) {
        var _this = this;
        var rotate = _this._rotateGlobal;
        var sub = "windTurbine_" + index + "_Time";
        function fram(timestamp) {
            $obj.attr("transform", "rotate(" + rotate + ")");
            rotate += _this._rotateSpeed;
            rotate = rotate%360;
            _this._rotateGlobal = rotate;
            _this._objectTimes[sub] = window.requestAnimationFrame(fram);
        }
        _this._objectTimes[sub] = window.requestAnimationFrame(fram);
    };
    WindTurbine.prototype.initWindTurbine = function () {
        var _thisP = this;
        _thisP.createWindTurbineIndexFlag();
        _thisP._svgView.find("g[type='windTurbine']").each(function () {
            var _this = $(this);
            _thisP.rotateWindTurbine(_this, _this.attr("index"));
        });
    };
    WindTurbine.prototype.startRotateWindTurbine = function (data) {
        var _thisP = this;
        _thisP.stopRotateWindTurbine(data);
        $("g[type='windTurbine'][deviceid='" + data.id + "']").each(function () {
            var _this = $(this);
            _thisP.rotateWindTurbine(_this, _this.attr("index"));
        });
    };
    WindTurbine.prototype.stopRotateWindTurbine = function (data) {
        var _thisP = this;
        $("g[type='windTurbine'][deviceid='" + data.id + "']").each(function () {
            var sub = "windTurbine_" + $(this).attr("index") + "_Time";
            clearInterval(_thisP._objectTimes[sub]);
        });
    };
    WindTurbine.prototype.flushWindTurbine = function (data, callBack) {
        this.createWindTurbineIndexFlag();
        var flag = false;
        var windTurbines = this._svgView.find("g[type='windTurbine']");
        for (var i=0,ii=windTurbines.length;i<ii;i++){
            var index = windTurbines.eq(i).attr("index");
            if (!data[index]) continue;
            if (callBack){
                flag = callBack(data[index]);
            }else {
                flag = data[index].stat[0] == 0 && data[index].p[0] > 0;
            }
            if (flag){
                if (this._rotateStatus[index] == 0){
                    this.rotateWindTurbine(windTurbines.eq(i), windTurbines.eq(i).attr("index"));
                    this._rotateStatus[index] = 1;
                }
            }else {
                this._rotateStatus[index] = 0;
                var sub = "windTurbine_" + index + "_Time";
                window.cancelAnimationFrame(this._objectTimes[sub]);
            }
        }
    };
    WindTurbine.prototype.rotateWindTurbine = function (_this, index) {
        var _path = _this.find("path").eq(1);
        var _circle = _this.find("circle");
        var _x = _circle.attr("cx");
        var _y = _circle.attr("cy");
        _circle.attr("transform", "translate(-"+_x+", -"+_y+")");
        _path.attr("transform", "translate(-"+_x+", -"+_y+")");
        var _g1 = _circle.parent();
        var _g2 = _g1.parent();
        _g2.attr("transform", "translate("+_x+", "+_y+")");
        this.startRequestAnimationFrame(_g1, index);
    };

    /*******************开关**********************************/
    function Switchs() {
        Common.call(this);
        this._indexFlag = true;
        this._rotateStatus = [];
        this._startAngle = 170;
        this._endAngle = 200;
        this._rotateSpeed = 1;
    }
    Switchs.prototype = getCommon();
    Switchs.prototype.initSwitchData = function (_this, _thisP, index) {
        _thisP._rotateStatus[index] = 0;
        var line = _this.find("line");
        var _x1 = line.attr("x1");
        var _y1 = line.attr("y1");
        var _x2 = line.attr("x2");
        var _y2 = line.attr("y2");
        line.attr("transform", "translate(-" + _x1 + ", -" + _y1 + ")");
        var _g1 = line.parent();
        _g1.attr("transform", "rotate(" + _thisP._startAngle + ")");
        var _g2 = _g1.parent();
        _g2.attr("transform", "translate(" + _x2 + ", " + _y2 + ")");
    };
    Switchs.prototype.createSwitchIndexFlag = function () {
        this.createIndexFlag("switch", this.initSwitchData);
    };
    Switchs.prototype.flushSwitch = function (data) {
        this.createSwitchIndexFlag();
        var switchs = this._svgView.find("g[type='switch']");
        for (var i=0,ii=switchs.length;i<ii;i++){
            var index = switchs.eq(i).attr("index");
            if (!data[index]) continue;
            if (data[index].status == 1 && this._rotateStatus[index] == 0){
                //关闭开关
                this.closeSwitch(switchs.eq(i).find("g g"));
                this._rotateStatus[index] = 1;
            }else if (this._rotateStatus[index] == 1){
                //打开开关
                this.openSwitch(switchs.eq(i).find("g g"));
                this._rotateStatus[index] = 0;
            }
        }
    };
    Switchs.prototype.openSwitch = function ($obj) {
        var _this = this;
        var rotate = _this._endAngle;
        function fram(timestamp) {
            if(rotate <= _this._startAngle){
                window.cancelAnimationFrame(timer);
                $obj.attr("transform", "rotate(" + _this._startAngle + ")");
                return;
            }
            $obj.attr("transform", "rotate(" + rotate + ")");
            rotate -= _this._rotateSpeed;
            timer = window.requestAnimationFrame(fram);
        }
        var timer = window.requestAnimationFrame(fram);
    };
    Switchs.prototype.closeSwitch = function ($obj) {
        var _this = this;
        var rotate = _this._startAngle;
        function fram(timestamp) {
            if(rotate > _this._endAngle){
                window.cancelAnimationFrame(timer);
                $obj.attr("transform", "rotate(" + _this._endAngle + ")");
                return;
            }
            $obj.attr("transform", "rotate(" + rotate + ")");
            rotate += _this._rotateSpeed;
            timer = window.requestAnimationFrame(fram);
        }
        var timer = window.requestAnimationFrame(fram);
    };

    /*******************汇流箱**********************************/
    function Hlx() {
        Common.call(this);
        //BREAK = "#999", ALERT = "#f90", ERROR = "#db412f", NORMAL = "#3fad22", SELECT = "#15575f";
        //0 normal 1 break 2 error 3 alert
        this.statusColor = ["#3fad22", "#999", "#db412f", "#f90"];
        //0无效 1ERROR 2ALERT 3NORMAL
        this.statusBunchColor = ["", "#db412f", "#f90", "#3fad22"];
        this.shadowColor = ["none", "#CCCCCC"];
        this.collectionFlag = true;
        this.bunchFlag = true;
        this.hlxs = {};
    }
    Hlx.prototype = getCommon();
    Hlx.prototype.collectionHlx = function () {
        if (this.collectionFlag){
            var hlx = this._svgView.find("g[type='HLX']");
            var hlxOld = null, deviceId = null;
            for (var i=0,ii=hlx.length;i<ii;i++){
                deviceId = hlx.eq(i).attr("deviceId");
                hlxOld = this.hlxs['hlx_' + deviceId];
                if (!!hlxOld){
                    if (Object.prototype.toString.call(hlxOld) != "[object Array]"){
                        var o = hlxOld;
                        hlxOld = [];
                        hlxOld.push(o);
                        this.hlxs['hlx_' + deviceId] = hlxOld;
                    }
                    hlxOld.push(hlx.eq(i));
                }else {
                    this.hlxs['hlx_' + hlx.eq(i).attr("deviceId")] = hlx.eq(i);
                }
            }
            this.hlxs['len'] = hlx.length + 1;
            this.collectionFlag = false;
            this.flushRemoveSvgTitle();
        }
    };
    Hlx.prototype.createBunchNumber = function (data) {
        var len; _this = this;
        if (data == null || (len = data.length) == 0) return;
        if (!_this.bunchFlag) return;
        var _iThis, bunch, d, bLen;
        for(var i=0;i<len;i++){
            d = data[i];
            if ((bunch = d.bunch) == null || (bLen = bunch.length) == 0) continue;
            _iThis = _this.hlxs['hlx_' + d.deviceId];
            if(Object.prototype.toString.call(_iThis) == "[object Array]"){
                for(var j=0,jj=_iThis.length;j<jj;j++){
                    _this.dealSingleHlxBunch(_iThis[j], bunch);
                }
                continue;
            }
            _this.dealSingleHlxBunch(_iThis, bunch);
        }
        _this.bunchFlag = false;
    };
    Hlx.prototype.dealSingleHlxBunch = function (_this, bunch) {
        var $rects, bid;
        $rects = _this.find("rect");
        $rects.attr("rect-flag", "0");
        $rects.eq(0).removeAttr("rect-flag");
        $rects.eq(1).removeAttr("rect-flag");
        $rects.eq($rects.length-1).removeAttr("rect-flag");
        for (var j=0,jj=bunch.length;j<jj;j++){
            $rects.eq((bid = bunch[j].bid) * 2).attr("bid-status", bid).removeAttr("rect-flag");
            $rects.eq(bid * 2 + 1).attr("bid-shadow", bid).removeAttr("rect-flag");
        }
        _this.find("rect[rect-flag='0']").remove();
    };
    Hlx.prototype.changeStatus = function ($obj, data, callBackStatus) {
        var $rect = $obj.find("rect:eq(0)");
        data = !!callBackStatus?callBackStatus($rect, data):data;
        $rect.attr("fill", this.statusColor[data.status]);
        $rect.attr("stroke", this.statusColor[data.status]);
        var bunck;
        for (var k=0,kk=data.bunch.length;k<kk;k++){
            bunck = !!callBackStatus?callBackStatus($obj, data.bunch[k]):data.bunch[k];
            $obj.find("rect[bid-status='" + data.bunch[k].bid + "']").attr("fill", this.statusBunchColor[bunck.status]);
            $obj.find("rect[bid-status='" + data.bunch[k].bid + "']").attr("stroke", this.statusBunchColor[bunck.status]);
            $obj.find("rect[bid-shadow='" + data.bunch[k].bid + "']").attr("fill", this.shadowColor[bunck.shadow]);
        }
    };
    Hlx.prototype.flushHlx = function (hlx, callBackStatus, callBack) {
        // alert("this.collectionFlag:" + this.collectionFlag);
        var data = hlx.data;
        this.collectionHlx();
        this.createBunchNumber(data);
        var $obj = null;
        for (var i=0,ii=data.length;i<ii;i++){
            $obj = this.hlxs["hlx_" + data[i].deviceId];
            if (Object.prototype.toString.call($obj) == "[object Array]"){
                for (var j=0,jj=$obj.length;j<jj;j++){
                    if (!!callBack && !callBack($obj[j], data[i])) continue;
                    this.changeStatus($obj[j], data[i], callBackStatus);
                }
            }else {
                if (!!callBack && !callBack($obj, data[i])) continue;
                this.changeStatus($obj, data[i], callBackStatus);
            }
        }
    };

    /*******************逆变器**********************************/
    function Nbq() {
        Common.call(this);
        this.statusColor = ["#3fad22", "#999", "#db412f", "#f90"];
        this.collectionFlag = true;
        this.nbqs = {};
    }
    Nbq.prototype = getCommon();
    Nbq.prototype.collectionNbq = function () {
        if (this.collectionFlag){
            var nbq = this._svgView.find("g[type='NBQ']");
            var nbqOld = null, deviceId = null;
            for (var i=0,ii=nbq.length;i<ii;i++){
                deviceId = nbq.eq(i).attr("deviceId");
                nbqOld = this.nbqs['nbq_' + deviceId];
                if (!!nbqOld){
                    if (Object.prototype.toString.call(nbqOld) != "[object Array]"){
                        var o = nbqOld;
                        nbqOld = [];
                        nbqOld.push(o);
                        this.nbqs['nbq_' + deviceId] = nbqOld;
                    }
                    nbqOld.push(nbq.eq(i));
                }else {
                    this.nbqs['nbq_' + nbq.eq(i).attr("deviceId")] = nbq.eq(i);
                }
            }
            this.nbqs['len'] = nbq.length + 1;
            this.collectionFlag = false;
            this.flushRemoveSvgTitle();
        }
    };
    Nbq.prototype.flushNbq = function (data, callBackStatus, callBack) {
        this.collectionNbq();
        var $obj = null;
        for (var i=0,ii=data.length;i<ii;i++){
            $obj = this.nbqs["nbq_" + data[i].deviceId];
            if (Object.prototype.toString.call($obj) == "[object Array]"){
                for (var j=0,jj=$obj.length;j<jj;j++){
                    if (!!callBack && !callBack($obj[j], data[i])) continue;
                    $obj[j].find("rect").attr("fill", this.statusColor[!!callBackStatus?callBackStatus($obj[j]):data[i].status]);
                }
            }else {
                if (!!callBack && !callBack($obj, data[i])) continue;
                $obj.find("rect").attr("fill", this.statusColor[!!callBackStatus?callBackStatus($obj):data[i].status]);
            }
        }
    };

    /*******************箱变**********************************/
    function Xb() {
        Common.call(this);
        this.statusColor = ["#3fad22", "#999", "#db412f", "#f90"];
        this.collectionFlag = true;
        this.xbs = {};
    }
    Xb.prototype = getCommon();
    Xb.prototype.collectionXb = function () {
        if (this.collectionFlag){
            var xb = this._svgView.find("g[type='XB']");
            var xbOld = null, deviceId = null;
            for (var i=0,ii=xb.length;i<ii;i++){
                deviceId = xb.eq(i).attr("deviceId");
                xbOld = this.xbs['xb_' + deviceId];
                if (!!xbOld){
                    if (Object.prototype.toString.call(xbOld) != "[object Array]"){
                        var o = xbOld;
                        xbOld = [];
                        xbOld.push(o);
                        this.xbs['xb_' + deviceId] = xbOld;
                    }
                    xbOld.push(xb.eq(i));
                }else {
                    this.xbs['xb_' + xb.eq(i).attr("deviceId")] = xb.eq(i);
                }
            }
            this.xbs['len'] = xb.length + 1;
            this.collectionFlag = false;
            this.flushRemoveSvgTitle();
        }
    };
    Xb.prototype.flushXb = function (data, callBackStatus, callBack) {
        this.collectionXb();
        var $obj = null;
        for (var i=0,ii=data.length;i<ii;i++){
            $obj = this.xbs["xb_" + data[i].deviceId];
            if (Object.prototype.toString.call($obj) == "[object Array]"){
                for (var j=0,jj=$obj.length;j<jj;j++){
                    if (!!callBack && !callBack($obj[j], data[i])) continue;
                    $obj[j].find("rect").attr("fill", this.statusColor[!!callBackStatus?callBackStatus($obj[j]):data[i].status]);
                }
            }else {
                if (!!callBack && !callBack($obj, data[i])) continue;
                $obj.find("rect").attr("fill", this.statusColor[!!callBackStatus?callBackStatus($obj):data[i].status]);
            }
        }
    };

    window.SvgUtils = (function () {
        return {
            Meter: new Meter(),
            WindTurbine: new WindTurbine(),
            Switchs: new Switchs(),
            Hlx: new Hlx(),
            Nbq: new Nbq(),
            Xb: new Xb()
        }
    })();
});