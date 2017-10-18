<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link type="text/css" href="${ctx}/theme/css/customAnimate.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/theme/js/wp/svgUtils.js"></script>
<script type="text/javascript" src="${ctx}/vendor/jquery/tmpl/jquery.tmpl.min.js"></script>
<style type="text/css">
    .layout-box{
        width: 245px;
        height:150px;
        float: left;
        margin: 1%;
    }
    .layout-box .layout-title{
        height: 25px;
        line-height: 25px;
        font-weight: bold;
    }
    .layout-box .layout-content{
        margin-top: 10px;
        margin-bottom: 10px;
        height: 75px;
    }
    .layout-box .layout-line{
        height: 25px;
        line-height: 25px;
    }
    .layout-box .layout-icon-box{
        padding-right: 20px;
    }
    .layout-box .layout-icon-box div{
        text-align: center;
    }
    .layout-box .layout-icon{
        height: 50px;
    }
    .layout-box .layout-text{
        height: 25px;
        line-height: 25px;
    }
    .color0{
        color: #3fad22;
    }
    .color1{
        color: #db412f;
    }
    .color2{
        color: #f90;
    }
    .border0{
        border: 1px solid #3fad22;
    }
    .border1{
        border: 1px solid #FB7561;
    }
    .border2{
        border: 1px solid #f90;
    }
    .backgroundColor0{
        background-color: #DFF3E2;
    }
    .backgroundColor1{
        background-color: #F2E0E0;
    }
    .backgroundColor2{
        background-color: #F1F5E0;
    }
</style>
<div ng-controller="WpWindTowerLayout" id="svgView">
    <%--<div class="layout-box border0">--%>
        <%--<div class="layout-title backgroundColor0">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon">--%>
                    <%--<svg xmlns="http://www.w3.org/2000/svg">--%>
                        <%--<g id="svg_160" type="windTurbine" deviceId="2">--%>
                            <%--<path id="svg_2" fill="{{statusColor[0]}}" d="M22.11199951171875,20.864620208740234 C22.11199951171875,20.637819290161133 21.917600631713867,20.43263053894043 21.680009841918945,20.43263053894043 C21.453210830688477,20.43263053894043 21.215620040893555,20.627029418945312 21.215620040893555,20.864620208740234 L20.092479705810547,43.80329895019531 C20.092479705810547,43.868099212646484 20.092479705810547,43.9005012512207 20.092479705810547,43.965301513671875 C20.124879837036133,44.86167907714844 20.848468780517578,45.520469665527344 21.744850158691406,45.48807144165039 C22.608829498291016,45.45568084716797 23.267620086669922,44.69968032836914 23.235219955444336,43.80329895019531 L22.11199951171875,20.864620208740234 z"></path>--%>
                            <%--<g id="svg_3">--%>
                                <%--<g id="svg_4">--%>
                                    <%--<g id="svg_5">--%>
                                        <%--<path id="svg_6" fill="{{statusColor[0]}}" d="M21.777259826660156,18.089038848876953 C22.803239822387695,18.02423858642578 23.526830673217773,17.268260955810547 23.4620304107666,16.40427017211914 L22.176849365234375,1.9973399639129639 C22.14444923400879,1.7705399990081787 21.950050354003906,1.597749948501587 21.6800594329834,1.56535005569458 C21.377670288085938,1.5329500436782837 21.11846923828125,1.7273499965667725 21.086069107055664,1.9973399639129639 L19.80088996887207,16.40427017211914 C19.80088996887207,16.469070434570312 19.80088996887207,16.566269874572754 19.80088996887207,16.631070137023926 C19.898029327392578,17.52743911743164 20.783649444580078,18.153820037841797 21.777250289916992,18.089038848876953 L21.777259826660156,18.089038848876953 zM20.546070098876953,19.719810485839844 C19.973678588867188,18.86663055419922 18.958499908447266,18.618228912353516 18.245710372924805,19.104219436645508 L6.409130096435547,27.420059204101562 C6.22553014755249,27.56045913696289 6.182330131530762,27.819650650024414 6.279530048370361,28.068050384521484 C6.398329734802246,28.33803939819336 6.700719833374023,28.467639923095703 6.949120044708252,28.370439529418945 L20.07086944580078,22.27935028076172 C20.12487030029297,22.246950149536133 20.21126937866211,22.192949295043945 20.27606964111328,22.16054916381836 C20.999549865722656,21.631399154663086 21.09674072265625,20.551389694213867 20.546058654785156,19.71980094909668 L20.546070098876953,19.719810485839844 zM22.57645034790039,19.978979110717773 C22.122859954833984,20.89695930480957 22.41444969177246,21.912139892578125 23.192039489746094,22.279340744018555 L36.31378936767578,28.37042999267578 C36.52979278564453,28.456829071044922 36.77817916870117,28.37042999267578 36.92938232421875,28.154430389404297 C37.10218048095703,27.91683006286621 37.06977844238281,27.582040786743164 36.853782653808594,27.420040130615234 L25.017200469970703,19.10420036315918 C24.963199615478516,19.071800231933594 24.876800537109375,19.017799377441406 24.812000274658203,18.985401153564453 C24.00196075439453,18.629051208496094 23.008359909057617,19.082609176635742 22.576440811157227,19.978979110717773 L22.57645034790039,19.978979110717773 z"></path>--%>
                                    <%--</g>--%>
                                <%--</g>--%>
                            <%--</g>--%>
                            <%--<rect id="svg_7" x="6.2255" y="1.48975" fill="none" width="30.81182" height="43.99837"></rect>--%>
                        <%--</g>--%>
                    <%--</svg>--%>
                <%--</div>--%>
                <%--<div class="layout-text color0">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box border1">--%>
        <%--<div class="layout-title backgroundColor1">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">故障</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon">--%>
                    <%--<svg xmlns="http://www.w3.org/2000/svg">--%>
                        <%--<g id="svg_160" type="windTurbine" deviceId="2">--%>
                            <%--<path id="svg_2" fill="{{statusColor[1]}}" d="M22.11199951171875,20.864620208740234 C22.11199951171875,20.637819290161133 21.917600631713867,20.43263053894043 21.680009841918945,20.43263053894043 C21.453210830688477,20.43263053894043 21.215620040893555,20.627029418945312 21.215620040893555,20.864620208740234 L20.092479705810547,43.80329895019531 C20.092479705810547,43.868099212646484 20.092479705810547,43.9005012512207 20.092479705810547,43.965301513671875 C20.124879837036133,44.86167907714844 20.848468780517578,45.520469665527344 21.744850158691406,45.48807144165039 C22.608829498291016,45.45568084716797 23.267620086669922,44.69968032836914 23.235219955444336,43.80329895019531 L22.11199951171875,20.864620208740234 z"></path>--%>
                            <%--<g id="svg_3">--%>
                                <%--<g id="svg_4">--%>
                                    <%--<g id="svg_5">--%>
                                        <%--<path id="svg_6" fill="{{statusColor[1]}}" d="M21.777259826660156,18.089038848876953 C22.803239822387695,18.02423858642578 23.526830673217773,17.268260955810547 23.4620304107666,16.40427017211914 L22.176849365234375,1.9973399639129639 C22.14444923400879,1.7705399990081787 21.950050354003906,1.597749948501587 21.6800594329834,1.56535005569458 C21.377670288085938,1.5329500436782837 21.11846923828125,1.7273499965667725 21.086069107055664,1.9973399639129639 L19.80088996887207,16.40427017211914 C19.80088996887207,16.469070434570312 19.80088996887207,16.566269874572754 19.80088996887207,16.631070137023926 C19.898029327392578,17.52743911743164 20.783649444580078,18.153820037841797 21.777250289916992,18.089038848876953 L21.777259826660156,18.089038848876953 zM20.546070098876953,19.719810485839844 C19.973678588867188,18.86663055419922 18.958499908447266,18.618228912353516 18.245710372924805,19.104219436645508 L6.409130096435547,27.420059204101562 C6.22553014755249,27.56045913696289 6.182330131530762,27.819650650024414 6.279530048370361,28.068050384521484 C6.398329734802246,28.33803939819336 6.700719833374023,28.467639923095703 6.949120044708252,28.370439529418945 L20.07086944580078,22.27935028076172 C20.12487030029297,22.246950149536133 20.21126937866211,22.192949295043945 20.27606964111328,22.16054916381836 C20.999549865722656,21.631399154663086 21.09674072265625,20.551389694213867 20.546058654785156,19.71980094909668 L20.546070098876953,19.719810485839844 zM22.57645034790039,19.978979110717773 C22.122859954833984,20.89695930480957 22.41444969177246,21.912139892578125 23.192039489746094,22.279340744018555 L36.31378936767578,28.37042999267578 C36.52979278564453,28.456829071044922 36.77817916870117,28.37042999267578 36.92938232421875,28.154430389404297 C37.10218048095703,27.91683006286621 37.06977844238281,27.582040786743164 36.853782653808594,27.420040130615234 L25.017200469970703,19.10420036315918 C24.963199615478516,19.071800231933594 24.876800537109375,19.017799377441406 24.812000274658203,18.985401153564453 C24.00196075439453,18.629051208496094 23.008359909057617,19.082609176635742 22.576440811157227,19.978979110717773 L22.57645034790039,19.978979110717773 z"></path>--%>
                                    <%--</g>--%>
                                <%--</g>--%>
                            <%--</g>--%>
                            <%--<rect id="svg_7" x="6.2255" y="1.48975" fill="none" width="30.81182" height="43.99837"></rect>--%>
                        <%--</g>--%>
                    <%--</svg>--%>
                <%--</div>--%>
                <%--<div class="layout-text color1">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box border2">--%>
        <%--<div class="layout-title backgroundColor2">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">告警</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon">--%>
                    <%--<svg xmlns="http://www.w3.org/2000/svg">--%>
                        <%--<g id="svg_160" type="windTurbine" deviceId="2">--%>
                            <%--<path id="svg_2" fill="{{statusColor[2]}}" d="M22.11199951171875,20.864620208740234 C22.11199951171875,20.637819290161133 21.917600631713867,20.43263053894043 21.680009841918945,20.43263053894043 C21.453210830688477,20.43263053894043 21.215620040893555,20.627029418945312 21.215620040893555,20.864620208740234 L20.092479705810547,43.80329895019531 C20.092479705810547,43.868099212646484 20.092479705810547,43.9005012512207 20.092479705810547,43.965301513671875 C20.124879837036133,44.86167907714844 20.848468780517578,45.520469665527344 21.744850158691406,45.48807144165039 C22.608829498291016,45.45568084716797 23.267620086669922,44.69968032836914 23.235219955444336,43.80329895019531 L22.11199951171875,20.864620208740234 z"></path>--%>
                            <%--<g id="svg_3">--%>
                                <%--<g id="svg_4">--%>
                                    <%--<g id="svg_5">--%>
                                        <%--<path id="svg_6" fill="{{statusColor[2]}}" d="M21.777259826660156,18.089038848876953 C22.803239822387695,18.02423858642578 23.526830673217773,17.268260955810547 23.4620304107666,16.40427017211914 L22.176849365234375,1.9973399639129639 C22.14444923400879,1.7705399990081787 21.950050354003906,1.597749948501587 21.6800594329834,1.56535005569458 C21.377670288085938,1.5329500436782837 21.11846923828125,1.7273499965667725 21.086069107055664,1.9973399639129639 L19.80088996887207,16.40427017211914 C19.80088996887207,16.469070434570312 19.80088996887207,16.566269874572754 19.80088996887207,16.631070137023926 C19.898029327392578,17.52743911743164 20.783649444580078,18.153820037841797 21.777250289916992,18.089038848876953 L21.777259826660156,18.089038848876953 zM20.546070098876953,19.719810485839844 C19.973678588867188,18.86663055419922 18.958499908447266,18.618228912353516 18.245710372924805,19.104219436645508 L6.409130096435547,27.420059204101562 C6.22553014755249,27.56045913696289 6.182330131530762,27.819650650024414 6.279530048370361,28.068050384521484 C6.398329734802246,28.33803939819336 6.700719833374023,28.467639923095703 6.949120044708252,28.370439529418945 L20.07086944580078,22.27935028076172 C20.12487030029297,22.246950149536133 20.21126937866211,22.192949295043945 20.27606964111328,22.16054916381836 C20.999549865722656,21.631399154663086 21.09674072265625,20.551389694213867 20.546058654785156,19.71980094909668 L20.546070098876953,19.719810485839844 zM22.57645034790039,19.978979110717773 C22.122859954833984,20.89695930480957 22.41444969177246,21.912139892578125 23.192039489746094,22.279340744018555 L36.31378936767578,28.37042999267578 C36.52979278564453,28.456829071044922 36.77817916870117,28.37042999267578 36.92938232421875,28.154430389404297 C37.10218048095703,27.91683006286621 37.06977844238281,27.582040786743164 36.853782653808594,27.420040130615234 L25.017200469970703,19.10420036315918 C24.963199615478516,19.071800231933594 24.876800537109375,19.017799377441406 24.812000274658203,18.985401153564453 C24.00196075439453,18.629051208496094 23.008359909057617,19.082609176635742 22.576440811157227,19.978979110717773 L22.57645034790039,19.978979110717773 z"></path>--%>
                                    <%--</g>--%>
                                <%--</g>--%>
                            <%--</g>--%>
                            <%--<rect id="svg_7" x="6.2255" y="1.48975" fill="none" width="30.81182" height="43.99837"></rect>--%>
                        <%--</g>--%>
                    <%--</svg>--%>
                <%--</div>--%>
                <%--<div class="layout-text color2">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div class="layout-box">--%>
        <%--<div class="layout-title">--%>
            <%--<span class="col-sm-8 text-left">WT08050</span>--%>
            <%--<span class="col-sm-4 text-right">正常</span>--%>
        <%--</div>--%>
        <%--<div class="layout-content">--%>
            <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                <%--<div class="layout-icon"><img src="${ctx}/tpl/ledgerPage/stationLayout/1.png" /></div>--%>
                <%--<div class="layout-text">Y1-06</div>--%>
            <%--</div>--%>
            <%--<div class="col-sm-8 no-padding-left">--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">54.56</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">0.0</div>--%>
                <%--</div>--%>
                <%--<div class="layout-line">--%>
                    <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                    <%--<div class="col-sm-4 text-right no-padding-left-right">3.72</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--<div class="layout-time">--%>
            <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
            <%--<div class="col-sm-8 no-padding-left">2016-11-14 10:27:00</div>--%>
        <%--</div>--%>
    <%--</div>--%>

    <%--<div ng-repeat="data in realData" repeat-done="repeatFlushData()">--%>
        <%--<div class="layout-box border{{data.statusCom[0]}}">--%>
            <%--<div class="layout-title backgroundColor{{data.statusCom[0]}}">--%>
                <%--<span class="col-sm-8 text-left" ng-bind="data.name"></span>--%>
                <%--<span class="col-sm-4 text-right" ng-bind="data.statusCom[1]">--</span>--%>
            <%--</div>--%>
            <%--<div class="layout-content">--%>
                <%--<div class="col-sm-4 no-padding-right layout-icon-box">--%>
                    <%--<div class="layout-icon">--%>
                        <%--<svg xmlns="http://www.w3.org/2000/svg">--%>
                            <%--<g type="windTurbine" deviceId="{{data.did}}">--%>
                                <%--<path id="svg_2" fill="{{statusColor[data.statusCom[0]]}}" d="M22.11199951171875,20.864620208740234 C22.11199951171875,20.637819290161133 21.917600631713867,20.43263053894043 21.680009841918945,20.43263053894043 C21.453210830688477,20.43263053894043 21.215620040893555,20.627029418945312 21.215620040893555,20.864620208740234 L20.092479705810547,43.80329895019531 C20.092479705810547,43.868099212646484 20.092479705810547,43.9005012512207 20.092479705810547,43.965301513671875 C20.124879837036133,44.86167907714844 20.848468780517578,45.520469665527344 21.744850158691406,45.48807144165039 C22.608829498291016,45.45568084716797 23.267620086669922,44.69968032836914 23.235219955444336,43.80329895019531 L22.11199951171875,20.864620208740234 z"></path>--%>
                                <%--<g id="svg_3">--%>
                                    <%--<g id="svg_4">--%>
                                        <%--<g id="svg_5">--%>
                                            <%--<path id="svg_6" fill="{{statusColor[data.statusCom[0]]}}" d="M21.777259826660156,18.089038848876953 C22.803239822387695,18.02423858642578 23.526830673217773,17.268260955810547 23.4620304107666,16.40427017211914 L22.176849365234375,1.9973399639129639 C22.14444923400879,1.7705399990081787 21.950050354003906,1.597749948501587 21.6800594329834,1.56535005569458 C21.377670288085938,1.5329500436782837 21.11846923828125,1.7273499965667725 21.086069107055664,1.9973399639129639 L19.80088996887207,16.40427017211914 C19.80088996887207,16.469070434570312 19.80088996887207,16.566269874572754 19.80088996887207,16.631070137023926 C19.898029327392578,17.52743911743164 20.783649444580078,18.153820037841797 21.777250289916992,18.089038848876953 L21.777259826660156,18.089038848876953 zM20.546070098876953,19.719810485839844 C19.973678588867188,18.86663055419922 18.958499908447266,18.618228912353516 18.245710372924805,19.104219436645508 L6.409130096435547,27.420059204101562 C6.22553014755249,27.56045913696289 6.182330131530762,27.819650650024414 6.279530048370361,28.068050384521484 C6.398329734802246,28.33803939819336 6.700719833374023,28.467639923095703 6.949120044708252,28.370439529418945 L20.07086944580078,22.27935028076172 C20.12487030029297,22.246950149536133 20.21126937866211,22.192949295043945 20.27606964111328,22.16054916381836 C20.999549865722656,21.631399154663086 21.09674072265625,20.551389694213867 20.546058654785156,19.71980094909668 L20.546070098876953,19.719810485839844 zM22.57645034790039,19.978979110717773 C22.122859954833984,20.89695930480957 22.41444969177246,21.912139892578125 23.192039489746094,22.279340744018555 L36.31378936767578,28.37042999267578 C36.52979278564453,28.456829071044922 36.77817916870117,28.37042999267578 36.92938232421875,28.154430389404297 C37.10218048095703,27.91683006286621 37.06977844238281,27.582040786743164 36.853782653808594,27.420040130615234 L25.017200469970703,19.10420036315918 C24.963199615478516,19.071800231933594 24.876800537109375,19.017799377441406 24.812000274658203,18.985401153564453 C24.00196075439453,18.629051208496094 23.008359909057617,19.082609176635742 22.576440811157227,19.978979110717773 L22.57645034790039,19.978979110717773 z"></path>--%>
                                        <%--</g>--%>
                                    <%--</g>--%>
                                <%--</g>--%>
                                <%--<rect id="svg_7" x="6.2255" y="1.48975" fill="none" width="30.81182" height="43.99837"></rect>--%>
                            <%--</g>--%>
                        <%--</svg>--%>
                    <%--</div>--%>
                    <%--<div class="layout-text" ng-bind="data.did"></div>--%>
                <%--</div>--%>
                <%--<div class="col-sm-8 no-padding-left">--%>
                    <%--<div class="layout-line">--%>
                        <%--<div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>--%>
                        <%--<div class="col-sm-4 text-right no-padding-left-right" ng-bind="data.p|sDecimalFilter:'2'">0.00</div>--%>
                    <%--</div>--%>
                    <%--<div class="layout-line">--%>
                        <%--<div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>--%>
                        <%--<div class="col-sm-4 text-right no-padding-left-right" ng-bind="data.v|sDecimalFilter:'2'">0.00</div>--%>
                    <%--</div>--%>
                    <%--<div class="layout-line">--%>
                        <%--<div class="col-sm-8 c5 no-padding-left-right">风速</div>--%>
                        <%--<div class="col-sm-4 text-right no-padding-left-right" ng-bind="data.ws|sDecimalFilter:'2'">0.00</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="layout-time">--%>
                <%--<div class="col-sm-4 no-padding-right">数据时间</div>--%>
                <%--<div class="col-sm-8 no-padding-left" ng-bind="data.dtime|dateFormat:'yyyy-MM-dd hh:mm:ss'"></div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>

<div repeat-single></div>
<div class="layoutBoxTmpl layout-box border{{data.statusCom[0]}}" style="display: none;">
    <div class="layout-title backgroundColor{{data.statusCom[0]}}">
        <span class="col-sm-8 text-left" ng-bind="data.name"></span>
        <span class="col-sm-4 text-right" ng-bind="data.statusCom[1]">--</span>
    </div>
    <div class="layout-content">
        <div class="col-sm-4 no-padding-right layout-icon-box">
            <div class="layout-icon">
                <svg xmlns="http://www.w3.org/2000/svg">
                    <g type="windTurbine" deviceId="">
                        <path fill="none" d="M23.537893295288086,24.917133331298828 C23.537893295288086,24.641748428344727 23.30213165283203,24.392786026000977 23.013538360595703,24.392786026000977 C22.738414764404297,24.392786026000977 22.449825286865234,24.62879180908203 22.449825286865234,24.917133331298828 L21.086139678955078,52.76771545410156 C21.086139678955078,52.846214294433594 21.086139678955078,52.885581970214844 21.086139678955078,52.9643440246582 C21.12552261352539,54.052650451660156 22.00372886657715,54.85261154174805 23.09227180480957,54.81324005126953 C24.141477584838867,54.77384948730469 24.940927505493164,53.856014251708984 24.901569366455078,52.76771545410156 L23.537893295288086,24.917133331298828 z"></path>
                        <g>
                            <g>
                                <g>
                                    <path fill="none" d="M23.131664276123047,21.547544479370117 C24.37722396850586,21.468799591064453 25.25595474243164,20.550905227661133 25.177200317382812,19.501951217651367 L23.616634368896484,2.010124683380127 C23.577268600463867,1.734992265701294 23.341506958007812,1.525156021118164 23.013538360595703,1.4857831001281738 C22.646697998046875,1.446401596069336 22.331693649291992,1.682410478591919 22.292306900024414,2.010124683380127 L20.732257843017578,19.501951217651367 C20.732257843017578,19.58077621459961 20.732257843017578,19.698583602905273 20.732257843017578,19.77739906311035 C20.849895477294922,20.865705490112305 21.925493240356445,21.62630271911621 23.131664276123047,21.547544479370117 L23.131664276123047,21.547544479370117 zM21.636905670166016,23.527536392211914 C20.942092895507812,22.491546630859375 19.709503173828125,22.190011978149414 18.843734741210938,22.78013801574707 L4.4727325439453125,32.876426696777344 C4.249940872192383,33.04689025878906 4.197622299194336,33.361663818359375 4.315739154815674,33.66318130493164 C4.45979118347168,33.99112319946289 4.827112674713135,34.14842224121094 5.128664493560791,34.03026580810547 L21.059730529785156,26.635177612304688 C21.12552261352539,26.595813751220703 21.23019027709961,26.5302791595459 21.308923721313477,26.49089241027832 C22.187660217285156,25.848182678222656 22.305280685424805,24.537076950073242 21.636905670166016,23.527536392211914 L21.636905670166016,23.527536392211914 L21.636905670166016,23.527536392211914 zM24.102102279663086,23.842021942138672 C23.551342010498047,24.956748962402344 23.90519905090332,26.189096450805664 24.849227905273438,26.63493537902832 L40.780792236328125,34.03026580810547 C41.042964935302734,34.13519287109375 41.34450149536133,34.03026580810547 41.52796173095703,33.76810836791992 C41.73775863647461,33.47951889038086 41.698421478271484,33.07305908203125 41.43620681762695,32.876426696777344 L27.06520652770996,22.77989959716797 C26.99989128112793,22.740766525268555 26.89476776123047,22.67498016357422 26.81599998474121,22.635848999023438 C25.832609176635742,22.202974319458008 24.626434326171875,22.753482818603516 24.102102279663086,23.842021942138672 L24.102102279663086,23.842021942138672 L24.102102279663086,23.842021942138672 z"></path>
                                    <circle fill="none" cx="22.92182858801628" cy="22.9896847151607" r="21.503910064697266"></circle>
                                </g>
                            </g>
                        </g>
                        <rect x="4.2499646918079685" y="1.3937830858421782" fill="none" fill-opacity="0" width="37.409279111620236" height="53.419350473168464"></rect>
                    </g>
                </svg>
            </div>
            <div class="layout-text" ng-bind="data.did"></div>
        </div>
        <div class="col-sm-8 no-padding-left">
            <div class="layout-line">
                <div class="col-sm-8 c5 no-padding-left-right">有功功率(Kw)</div>
                <div class="col-sm-4 text-right no-padding-left-right p" ng-bind="data.p|sDecimalFilter:'2'">0.00</div>
            </div>
            <div class="layout-line">
                <div class="col-sm-8 c5 no-padding-left-right">无功功率(KVar)</div>
                <div class="col-sm-4 text-right no-padding-left-right v" ng-bind="data.v|sDecimalFilter:'2'">0.00</div>
            </div>
            <div class="layout-line">
                <div class="col-sm-8 c5 no-padding-left-right">风速</div>
                <div class="col-sm-4 text-right no-padding-left-right ws" ng-bind="data.ws|sDecimalFilter:'2'">0.00</div>
            </div>
        </div>
    </div>
    <div class="layout-time">
        <div class="col-sm-4 no-padding-right">数据时间</div>
        <div class="col-sm-8 no-padding-left dtime" ng-bind="data.dtime|dateFormat:'yyyy-MM-dd hh:mm:ss'"></div>
    </div>
</div>


</div>
<input type="hidden" id="rotateHidden" />
<script type="text/javascript">
    var ctx = "${ctx}";
    app.controller("WpWindTowerLayout", function ($scope, $http, $state, $document) {
        $document.on('screenfull.raw.fullscreenchange', function () {
            if(responseHeight){responseHeight();}
        });
        //过滤
        $scope.$on("filterPageBox", function (event, msg) {
            getWpWindTowerDataLayout($scope, $http);
        });

        $scope.$on('refreshViewDataForHead', function(event, data) {
            clearInterval($scope.bcTimer);
            getWpWindTowerDataLayout($scope, $http);
            $scope.bcTimer = setInterval(function() {
                getWpWindTowerDataLayout($scope, $http);
            }, 5000);
        });
        $scope.$on('$stateChangeStart', function(event) {
            clearInterval($scope.bcTimer);
        });

        $scope.statusColor = ["#3fad22", "#FB7561", "#f90"];

        $scope.bcTimer = setInterval(function() {
            getWpWindTowerDataLayout($scope, $http);
        }, 5000);

        $scope.startInit = function () {
            getWpWindTowerDataLayout($scope, $http);
        };
        $scope.startInit();
    });

    var windTowerflag = 0, elems = [];
    function getWpWindTowerDataLayout($scope, $http, callback) {
        if(windTowerflag == 0){
            $("#windTower-table").hide();
            CommonPerson.Base.LoadingPic.PartShow('windTower-table2');
        }
        $http({
            method : "POST",
            url : "${ctx}/WpDeviceStation/getRealtimeWindTurbineLayout.htm",
            params : {
                pstationid: 3000, //$scope.powerStationId,
                pageIndex: $('#curPage').text(),
                pageSize: $('#singleNum').val(),
                search: $('#searchWords').val()
            }
        }).success(function(result) {
            if (result.data == null) return;
            if(windTowerflag == 0){
                partHide('windTower-table2');
                $("#windTower-table").show();
            }

            var windTurbine;
            for (var i = 0; i < result.data.length; i++) {
                $scope["realBorder"+i] = result.data[i].statusCom[0];
                $scope["realBackgroundColor"+i] = result.data[i].statusCom[0];
                $scope["realName"+i] = result.data[i].name;
                $scope["realStatusCom"+i] = result.data[i].statusCom[1];
                $scope["statusColor"+i] = result.data[i].statusCom[0];
                $scope["realDid"+i] = result.data[i].did;
                $scope["realP"+i] = result.data[i].p;
                $scope["realV"+i] = result.data[i].v;
                $scope["realWs"+i] = result.data[i].ws;
                $scope["realDtime"+i] = parseInt(result.data[i].dtime)*1000;
                windTurbine = $("g[type='windTurbine'][index='"+i+"']");
                windTurbine.attr("deviceId", result.data[i].did);
                windTurbine.find("path").attr("fill", $scope.statusColor[result.data[i].statusCom[0]]);
            }
            SvgUtils.flushWindTurbine(result.data);
        });
    }

    app.directive("repeatSingle", function () {
        return {
            restrict: 'EA',
            template: function (tElement, tAttrs) {
            },
            compile: function (tEle, tAttrs, transcludeFn) {
                var statusColor = ["#3fad22", "#FB7561", "#f90"];
                $.ajax({
                    method : "POST",
                    url : ctx + "/WpDeviceStation/getRealtimeWindTurbineLayout.htm",
                    async: false,
                    success: function (result) {
                        var tmpl = $(".layoutBoxTmpl");
                        var t = tmpl.clone(true);
                        for (var i=0,ii=result.data.length;i<ii;i++){
                            t = tmpl.clone(true);
                            t.attr("class", "layout-box");
                            t.attr("ng-class", "{'0': 'border0', '1': 'border1', '2':'border2'}[realBorder"+i+"]");
                            var elem = t.find(".layout-title");
                            elem.attr("ng-class", "{'0':'backgroundColor0', '1':'backgroundColor1', '2':'backgroundColor2'}[realBackgroundColor"+i+"]");
                            elem = elem.find("span");
                            elem.eq(0).attr("ng-bind", "realName"+i);
                            elem.eq(1).attr("ng-bind", "realStatusCom"+i);
                            t.find(".layout-text").attr("ng-bind", "realDid" + i);
                            t.find("g[type='windTurbine']").attr("deviceId", result.data[i].did);
                            t.find("g[type='windTurbine'] path").attr("fill", statusColor[result.data[i].statusCom[0]]);
                            t.find(".p").attr("ng-bind", "realP" + i + "| sDecimalFilter:'2'");
                            t.find(".v").attr("ng-bind", "realV" + i + "| sDecimalFilter:'2'");
                            t.find(".ws").attr("ng-bind", "realWs" + i + "| sDecimalFilter:'2'");
                            t.find(".layout-time div").eq(1).attr("ng-bind", "realDtime"+i+"|dateFormat:'yyyy-MM-dd hh:mm:ss'");
                            t.show();
                            tEle.append(t);
                        }
                    }
                });
                return function(scope, element, attr) {
                };
            }
        }
    });
</script>