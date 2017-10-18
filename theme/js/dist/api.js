"use strict";

function _toConsumableArray(arr) { if (Array.isArray(arr)) { for (var i = 0, arr2 = Array(arr.length); i < arr.length; i++) { arr2[i] = arr[i]; } return arr2; } else { return Array.from(arr); } }

function _newArrowCheck(innerThis, boundThis) { if (innerThis !== boundThis) { throw new TypeError("Cannot instantiate an arrow function"); } }

app.factory("apiService", ["$http", "$q", function (d, b) {
    _newArrowCheck(void 0, void 0);

    var c = window.interface,
        a = {};

    a.getData = function (e) {
        _newArrowCheck(void 0, void 0);

        var f = b.defer(),
            j = e.name.startsWith('GET') ? 'GET' : 'POST';

        d({
            method: j,
            url: c[e.name],
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-Requested-With": "XMLHttpRequest"
            },
            params: j == 'GET' ? e.data : {},
            data: j == 'POST' ? e.data : {},
            transformRequest: function () {
                function transformRequest(g) {
                    return $.param(g);
                }

                return transformRequest;
            }()
        }).success(function (h) {
            _newArrowCheck(void 0, void 0);

            if (h.status >= 500) {
                promptObj("error", "", "error" + "\n" + c[e.name] + "\n" + "服务器错误，请稍后再试");
                console.error(e.name, c[e.name], h);
                return f.reject(h.status);
            }
            f.resolve(h);
        }.bind(void 0)).error(function (h, g) {
            _newArrowCheck(void 0, void 0);

            if (g == 404) {
                promptObj("error", "", "error" + "\n" + c[e.name] + "\n" + "您请求的资源不存在");
            } else if (g >= 500) {
                promptObj("error", "", "error" + "\n" + c[e.name] + "\n" + "服务器错误，请稍后再试");
            }
            console.error("error", c[e.name], g);
            f.reject(g);
        }.bind(void 0));
        return f.promise;
    }.bind(void 0);
    return a;
}.bind(void 0)]);
window.ajaxData = function (b, a) {
    _newArrowCheck(void 0, void 0);

    app.factory("myAjaxData", ["apiService", '$q', '$timeout', function (d, q, m) {
        _newArrowCheck(void 0, void 0);

        var i = {},
            j = {},
            c = {};

        c.init = function (b, a) {
            _newArrowCheck(void 0, void 0);

            i = {};
            j = {};
            c.isLoding = !0;
            for (var f in b) {
                i[b[f].name] = {};
                c[f] = {};
                c[f].isLoding = !0;
                c[f].res = null;
            }
            c.config = a;
            c.currentStationData = j;
        }.bind(void 0);
        c.setCurrentStationData = function (o) {
            _newArrowCheck(void 0, void 0);

            for (var key in o) {
                j[key] = o[key];
            }
        }.bind(void 0);
        c.timeout = function (t) {
            _newArrowCheck(void 0, void 0);

            var d = q.defer();
            m(function () {
                _newArrowCheck(void 0, void 0);

                return d.resolve();
            }.bind(void 0), t);
            return d.promise;
        }.bind(void 0);
        c.getData = function (o) {
            _newArrowCheck(void 0, void 0);

            if (!i[o.name]) return d.getData(o);
            for (var key in o.data) {
                i[o.name][key] = o.data[key];
            }return d.getData({
                name: o.name,
                data: i[o.name]
            });
        }.bind(void 0);
        c.setData = function (g, f, h) {
            _newArrowCheck(void 0, void 0);

            c[g].isLoding = f ? !1 : !0;
            c[g].res = f || c[g].res;
            c.isLoding = h;
        }.bind(void 0);
        return c;
    }.bind(void 0)]);
    return function (f, c, e) {
        _newArrowCheck(void 0, void 0);

        var d = function (N, Z, Y, X, W, V, U, T, S, R, Q, P, O, M, L, K, J, I, H, G, F, D, C, B, A, j) {
            _newArrowCheck(void 0, void 0);

            Z.init(b, a);
            var E = function () {
                _newArrowCheck(void 0, void 0);

                for (var key in b) {
                    if (N[key].isLoding) return !0;
                }return !1;
            }.bind(void 0);
            N.isLoding = !0;
            N.reload = function () {
                _newArrowCheck(void 0, void 0);

                for (var key in b) {
                    if (b[key].later) continue;
                    N[key].getData(b[key].data);
                }
            }.bind(void 0);
            N.getData = function (g, i) {
                _newArrowCheck(void 0, void 0);

                return Z.getData({
                    name: g,
                    data: i
                });
            }.bind(void 0);

            var _loop = function _loop(g) {
                N[g] = {};

                N[g].getData = function (k) {
                    _newArrowCheck(void 0, void 0);

                    var i = Z.getData({
                        name: b[g].name,
                        data: k
                    });
                    N[g].promise = i;
                    N[g].isLoding = !0;
                    N.isLoding = E();
                    Z.setData(g, null, N.isLoding);
                    i.then(function (l) {
                        _newArrowCheck(void 0, void 0);

                        N[g].res = l;
                        N[g].isLoding = !1;
                        N.isLoding = E();
                        Z.setData(g, l, N.isLoding);
                    }.bind(void 0), function (l) {
                        _newArrowCheck(void 0, void 0);

                        N[g].isLoding = !1;
                        N.isLoding = E();
                    }.bind(void 0));
                    return i;
                }.bind(void 0);
                N[g].isLoding = !0;
                if (b[g].later) return "continue";

                N[g].promise = N[g].getData(b[g].data);
            };

            for (var g in b) {
                var _ret = _loop(g);

                if (_ret === "continue") continue;
            }
            e(N, Z, Y, X, W, V, U, T, S, R, Q, P, O, M, L, K, J, I, H, G, F, D, C, B, A, j);
        }.bind(void 0);
        app.controller(f, [].concat(_toConsumableArray(c), [d]));
    }.bind(void 0);
}.bind(void 0);