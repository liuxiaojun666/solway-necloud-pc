webpackJsonp([6],{"/XM6":function(t,e){},BO80:function(t,e){},Pyuc:function(t,e,a){"use strict";Object.defineProperty(e,"__esModule",{value:!0});a("/XM6"),a("VRPH");var n=a("VosF"),o=a.n(n),r=(a("LX/e"),a("STLj")),i=a.n(r),s=(a("Auav"),a("e0Bm")),l=a.n(s),d=(a("0Hv4"),a("pkKZ")),c=a.n(d),f=(a("7oZF"),a("mtrD")),u=a.n(f),p=(a("9niM"),a("HJMx")),m=a.n(p),g=(a("sI00"),a("Mezo")),b=a.n(g),v=(a("evr2"),a("vqwl")),_=a.n(v),y=(a("YeOW"),a("2X9z")),h=a.n(y),D=a("Gu7T"),C=a.n(D),P=a("Dd8w"),I=a.n(P),x=a("FL0G"),k={data:function(){return{opFittingsRoomSelectByCondition:Object(x.v)({onlyLatest:!0,cacheParams:!0,res:{body:[]}}),opFittingsCategorySelectByCondition:Object(x.l)({res:{body:[]},mountedRes:function(t){return t.body=t.body.map(function(t){return{label:t.name,value:t.id}}),t.body.unshift({label:"全部",value:""}),t}}),opFittingsDictSelectCtg1:Object(x.q)({later:!0}),opFittingsDictSelectCtg2:Object(x.r)({later:!0}),opFittingsDictSelectCurrData:Object(x.s)({res:{body:[]},mountedRes:function(t,e,a){return a.firstData||(a.firstData=I()({},t)),t}}),opFittingsDictRoomValidFsn:Object(x.p)({later:!0}),opWorkFittingsInCreate:Object(x.y)({later:!0,sameTimeOnce:!0,beforeSend:function(t){var e=t.goods;return I()({},t,{goods:e.map(function(t){return{fdId:t.fdId,fdPt:t.fdPt,fsn:t.fsn,num:t.num,position:t.position}})})}}),formData:{sn:"",stationId:"",summary:"",goods:[{fdId:void 0,fdPt:0,fsn:"",num:void 0,position:"",edit:!0,spareParts:[]}]}}},created:function(){var t=this;this.opFittingsDictSelectCurrData.subscribe(function(e){t.formData.goods[0].spareParts[0]||(t.formData.goods[0].spareParts=[].concat(C()(e.body)))}),this.opWorkFittingsInCreate.subscribe(function(e){if(0!==e.code)return h.a.error(e.msg);h.a.success(e.msg),t.$route.query.menu?(t.formData.sn="",t.formData.stationId="",t.formData.summary="",t.formData.goods=[t.formData.goods[0]],t.formData.goods[0].fsn="",t.formData.goods[0].position="",t.formData.goods[0].edit=!0,t.$refs.form.resetFields(),t.$refs.spareParts0[0].resetFields()):t.$router.go(-1)})},methods:{lazyLoad:function(t,e){1===t.level?this.opFittingsDictSelectCtg1.getData({categoryId:t.value}).then(function(t){e([{value:"",label:"全部",leaf:!1}].concat(C()(t.body.map(function(t){return{value:t,label:t,leaf:!1}}))))}):2===t.level&&this.opFittingsDictSelectCtg2.getData({categoryId:t.path[0],ctg1:t.value}).then(function(t){e([{value:"",label:"全部",leaf:!0}].concat(C()(t.body.map(function(t){return{value:t,label:t,leaf:!0}}))))})},itemValidate:function(t,e,a){if(t){if(!e.fdPt)return e.edit=!1;for(var n=this.formData.goods,o=0;o<n.length;o++){var r=n[o];if(r.fsn&&r.fsn===e.fsn&&o!==a&&e.fdId===r.fdId)return void h.a.error("备件编号已存在, 与第"+(o+1)+"行备件编号重复，请检查")}this.opFittingsDictRoomValidFsn.getData({fsn:e.fsn}).then(function(t){if(!t.body.flag)return h.a.error("备件编号已存在,请检查！");e.edit=!1})}},allValidate:function(t,e){if(t)return e.goods.some(function(t){return t.edit})?h.a.info("请确认结束编辑状态！"):void this.opWorkFittingsInCreate.getData(e)},fdChange:function(t,e){t?(e.fdPt=+t.split("_")[0],e.fdId=+t.split("_")[1],e.num=e.fdPt?1:void 0):(e.fdPt=0,e.fdId="",e.num=void 0)}},components:{ElForm:_.a,ElFormItem:b.a,ElInput:m.a,ElButton:u.a,ElCascader:c.a,ElSelect:l.a,ElOption:i.a,ElPageHeader:o.a}},F={render:function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"put-in-storage-add"},[a("div",{staticClass:"content"},[t.$route.query.menu?t._e():a("el-page-header",{attrs:{content:"备件入库"},on:{back:function(e){return t.$router.go(-1)}}}),t._v(" "),a("el-form",{ref:"form",attrs:{inline:!0,model:t.formData,"label-width":"80px"}},[a("el-form-item",{attrs:{prop:"sn",rules:{required:!0,message:"入库单号不能为空"},label:"入库单号"}},[a("el-input",{attrs:{placeholder:"请输入入库单号"},model:{value:t.formData.sn,callback:function(e){t.$set(t.formData,"sn",e)},expression:"formData.sn"}})],1),t._v(" "),a("el-form-item",{attrs:{prop:"sn",rules:{required:!0,message:"库房不能为空"},label:"库房"}},[a("el-select",{attrs:{filterable:"",clearable:"",placeholder:"请选择库房"},model:{value:t.formData.stationId,callback:function(e){t.$set(t.formData,"stationId",e)},expression:"formData.stationId"}},t._l(t.opFittingsRoomSelectByCondition.res.body,function(t){return a("el-option",{key:t.id,attrs:{label:t.name,value:t.id}})}),1)],1),t._v(" "),a("el-form-item",{attrs:{label:"备注"}},[a("el-input",{attrs:{type:"textarea",placeholder:"请填写备注"},model:{value:t.formData.summary,callback:function(e){t.$set(t.formData,"summary",e)},expression:"formData.summary"}})],1)],1),t._v(" "),a("div",{staticClass:"sparePartEditList"},t._l(t.formData.goods,function(e,n){return a("el-form",{key:n,ref:"spareParts"+n,refInFor:!0,staticClass:"sparePart",attrs:{inline:!0,model:e,"label-width":"80px"}},[a("el-form-item",{attrs:{label:"备件分类"}},[a("el-cascader",{attrs:{disabled:!e.edit,placeholder:"备件分类",props:{lazy:!0,lazyLoad:t.lazyLoad},clearable:!0,options:t.opFittingsCategorySelectByCondition.res.body},on:{change:function(a){t.opFittingsDictSelectCurrData.getData({categoryId:a[0],ctg1:a[1],ctg2:a[2]}).then(function(t){e.spareParts=t.body,(e.fdId&&!e.spareParts.some(function(t){return t.id===e.fdId})||!e.fdId)&&(e.fdPt_fdId="")})}}})],1),t._v(" "),a("el-form-item",[a("el-select",{attrs:{disabled:!e.edit,filterable:"",clearable:"",placeholder:"分类编号"},on:{change:function(a){return t.fdChange(a,e)}},model:{value:e.fdPt_fdId,callback:function(a){t.$set(e,"fdPt_fdId",a)},expression:"item.fdPt_fdId"}},t._l(e.spareParts,function(t){return a("el-option",{key:t.id,attrs:{label:t.code,value:t.pt+"_"+t.id}})}),1)],1),t._v(" "),a("el-form-item",{attrs:{prop:"fdId",rules:{required:!0,message:"请选择备件"}}},[a("el-select",{attrs:{disabled:!e.edit,filterable:"",clearable:"",placeholder:"名称"},on:{change:function(a){return t.fdChange(a,e)}},model:{value:e.fdPt_fdId,callback:function(a){t.$set(e,"fdPt_fdId",a)},expression:"item.fdPt_fdId"}},t._l(e.spareParts,function(t){return a("el-option",{key:t.id,attrs:{label:t.name,value:t.pt+"_"+t.id}})}),1)],1),t._v(" "),a("el-form-item",[a("el-select",{attrs:{disabled:!e.edit,filterable:"",clearable:"",placeholder:"型号及规格"},on:{change:function(a){return t.fdChange(a,e)}},model:{value:e.fdPt_fdId,callback:function(a){t.$set(e,"fdPt_fdId",a)},expression:"item.fdPt_fdId"}},t._l(e.spareParts,function(t){return a("el-option",{key:t.id,attrs:{label:t.ft,value:t.pt+"_"+t.id}})}),1)],1),t._v(" "),1===e.fdPt?a("el-form-item",{attrs:{prop:"fsn",rules:{required:!0,message:"编号不能为空"}}},[a("el-input",{attrs:{disabled:!e.edit,placeholder:"备件编号"},model:{value:e.fsn,callback:function(a){t.$set(e,"fsn","string"==typeof a?a.trim():a)},expression:"item.fsn"}})],1):t._e(),t._v(" "),0===e.fdPt?a("el-form-item",{attrs:{prop:"num",rules:{required:!0,message:"数量不能为空"}}},[a("el-input",{attrs:{disabled:!e.edit,type:"number",placeholder:"数量"},model:{value:e.num,callback:function(a){t.$set(e,"num",t._n(a))},expression:"item.num"}})],1):t._e(),t._v(" "),a("el-form-item",{attrs:{prop:"position",rules:{required:!0,message:"库位不能为空"}}},[a("el-input",{attrs:{disabled:!e.edit,placeholder:"库位"},model:{value:e.position,callback:function(a){t.$set(e,"position","string"==typeof a?a.trim():a)},expression:"item.position"}})],1),t._v(" "),a("el-form-item",[a("el-button",{staticClass:"delete",attrs:{type:"text"},on:{click:function(){t.formData.goods[1]&&t.formData.goods.splice(n,1)}}},[a("i",{staticClass:"iconfont iconshanchu1",attrs:{title:"删除"}})]),t._v(" "),e.edit?t._e():a("el-button",{staticClass:"edit",attrs:{type:"text"},on:{click:function(t){e.edit=!0}}},[a("i",{staticClass:"iconfont iconbianji-copy",attrs:{title:"编辑"}})]),t._v(" "),e.edit?a("el-button",{staticClass:"confirm",attrs:{type:"text"},on:{click:function(a){t.$refs["spareParts"+n][0].validate(function(a){return t.itemValidate(a,e,n)})}}},[a("i",{staticClass:"iconfont iconqueding",attrs:{title:"确定"}})]):t._e()],1)],1)}),1),t._v(" "),t.formData.goods[0].spareParts?a("el-button",{staticStyle:{"margin-left":"80px"},attrs:{type:"b2"},on:{click:function(e){return t.formData.goods.push(Object.assign({},t.formData.goods[t.formData.goods.length-1],{edit:!0,fsn:"",num:void 0,position:""}))}}},[t._v("添加备件")]):t._e(),t._v(" "),a("el-button",{staticStyle:{"margin-left":"20px"},attrs:{type:"b1"},on:{click:function(e){t.$refs.form.validate(function(e){return t.allValidate(e,t.formData)})}}},[t._v("提交")])],1)])},staticRenderFns:[]};var S=a("VU/8")(k,F,!1,function(t){a("BO80"),a("al4a")},"data-v-351d1d9f",null);e.default=S.exports},VosF:function(t,e,a){t.exports=function(t){var e={};function a(n){if(e[n])return e[n].exports;var o=e[n]={i:n,l:!1,exports:{}};return t[n].call(o.exports,o,o.exports,a),o.l=!0,o.exports}return a.m=t,a.c=e,a.d=function(t,e,n){a.o(t,e)||Object.defineProperty(t,e,{enumerable:!0,get:n})},a.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},a.t=function(t,e){if(1&e&&(t=a(t)),8&e)return t;if(4&e&&"object"==typeof t&&t&&t.__esModule)return t;var n=Object.create(null);if(a.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:t}),2&e&&"string"!=typeof t)for(var o in t)a.d(n,o,function(e){return t[e]}.bind(null,o));return n},a.n=function(t){var e=t&&t.__esModule?function(){return t.default}:function(){return t};return a.d(e,"a",e),e},a.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},a.p="/dist/",a(a.s=86)}({0:function(t,e,a){"use strict";function n(t,e,a,n,o,r,i,s){var l,d="function"==typeof t?t.options:t;if(e&&(d.render=e,d.staticRenderFns=a,d._compiled=!0),n&&(d.functional=!0),r&&(d._scopeId="data-v-"+r),i?(l=function(t){(t=t||this.$vnode&&this.$vnode.ssrContext||this.parent&&this.parent.$vnode&&this.parent.$vnode.ssrContext)||"undefined"==typeof __VUE_SSR_CONTEXT__||(t=__VUE_SSR_CONTEXT__),o&&o.call(this,t),t&&t._registeredComponents&&t._registeredComponents.add(i)},d._ssrRegister=l):o&&(l=s?function(){o.call(this,this.$root.$options.shadowRoot)}:o),l)if(d.functional){d._injectStyles=l;var c=d.render;d.render=function(t,e){return l.call(e),c(t,e)}}else{var f=d.beforeCreate;d.beforeCreate=f?[].concat(f,l):[l]}return{exports:t,options:d}}a.d(e,"a",function(){return n})},20:function(t,e){t.exports=a("urW8")},86:function(t,e,a){"use strict";a.r(e);var n=function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"el-page-header"},[a("div",{staticClass:"el-page-header__left",on:{click:function(e){t.$emit("back")}}},[a("i",{staticClass:"el-icon-back"}),a("div",{staticClass:"el-page-header__title"},[t._t("title",[t._v(t._s(t.title))])],2)]),a("div",{staticClass:"el-page-header__content"},[t._t("content",[t._v(t._s(t.content))])],2)])};n._withStripped=!0;var o=a(20),r={name:"ElPageHeader",props:{title:{type:String,default:function(){return Object(o.t)("el.pageHeader.title")}},content:String}},i=a(0),s=Object(i.a)(r,n,[],!1,null,null,null);s.options.__file="packages/page-header/src/main.vue";var l=s.exports;l.install=function(t){t.component(l.name,l)};e.default=l}})},al4a:function(t,e){}});
//# sourceMappingURL=6.48757f1cdc9672593af2.js.map