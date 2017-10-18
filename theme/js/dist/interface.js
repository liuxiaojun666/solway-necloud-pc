'use strict';

var i = document.getElementById('routerJS').getAttribute('param');
window.interface = {
        //获取当前电站基本信息
        GETgetCurrentInfoNew: i + "/UserAuthHandle/getCurrentInfoNew.htm",
        getBaseMessageList: i + "/BaseMessage/getBaseMessageList.htm",
        getCustomConfigByComId: i + "/Login/getCustomConfigByComId.htm",
        /**
         * [getRunTimeMonitor description]
         * @params {id:1
                    bidss:2001,2002,2003,2004,2005,2006,2007,2008,2009,
                    iidss:1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
                    jidss:146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,
                    quickSelect:false}
         */
        getStationFaultData2: i + '/RtmDeviceLayout/getStationFaultData2.htm',

        //工作票分页列表  ?pageIndex=0&pageSize=10
        rpdWorkTicketPage: i + '/rpdWorkTicket/page.htm',

        //组串阴影遮挡 分页  (Integer pageIndex, Integer pageSize, String keyWords, EqPaintMsgVo item)
        //EqPaintMsgVo (deviceId、 deviceType 、startDate、endDate)
        GETanalysisPage: i + '/analysis/eqPaint/msg/page.htm',

        //组串阴影遮挡 详情页  (Integer id, Integer stId, Integer deviceId)
        GETselectEqPaintingData: i + '/analysis/eqPaint/selectEqPaintingData.htm',

        //获取设备类型
        GETgetDeviceType: i + '/DeviceStation/getDeviceType.htm',

        //获取设备名称 汇流箱
        GETgetJunctionBox: i + '/HistoryData/getJunctionBox.htm',

        //获取设备名称 逆变器
        GETgetInverter: i + '/HistoryData/getInverter.htm',

        //获取设备名称 箱变
        GETgetBoxchange: i + '/HistoryData/getBoxchange.htm',

        //获取设备名称 电表
        GETgetAmmeter: i + '/HistoryData/getAmmeter.htm',

        //获取设备名称 气象站
        GETgetAerograph: i + '/HistoryData/getAerograph.htm'
};