
(function(l, r) { if (!l || l.getElementById('livereloadscript')) return; r = l.createElement('script'); r.async = 1; r.src = '//' + (self.location.host || 'localhost').split(':')[0] + ':1500/livereload.js?snipver=1'; r.id = 'livereloadscript'; l.getElementsByTagName('head')[0].appendChild(r) })(self.document);
var FlutterJsBridge = (function () {
'use strict';

// @ts-nocheck
// 获取数据类型
function getType(data) {
    return Object.prototype.toString.call(data).split(' ')[1].slice(0, -1);
}
function Bus() {
    this.events = {}; // 事件存放中心
    this.autoId = 0; // 自动生成的 id
}
// 基础注册函数
Bus.prototype.create = function (customeid, name, handle, isOnce, onlyOne, type) {
    if (getType(handle) !== 'Function')
        return null;
    var useId = customeid ? customeid : this.autoId++;
    var oneHandle = {
        name: name,
        id: useId,
        handle: handle,
        isOnce: isOnce === true ? true : false,
        type: type
    };
    if (onlyOne) {
        this.events[name] = oneHandle;
    }
    else {
        getType(this.events[name]) !== 'Array' && (this.events[name] = []);
        var isFind = false;
        for (var a = 0; a < this.events[name].length; a++) {
            if (this.events[name][a].id === useId) {
                this.events[name][a] = oneHandle;
                isFind = true;
                break;
            }
        }
        !isFind && this.events[name].push(oneHandle);
    }
    return oneHandle;
};
// 事件触发
Bus.prototype.emit = function (name) {
    var data = [];
    for (var a = 1, len = arguments.length; a < len; a++) {
        data.push(arguments[a]);
    }
    switch (getType(this.events[name])) {
        case 'Object':
            if (!this.events[name].type
                || this.events[name].type === data[0]) {
                this.events[name].handle.apply(this.events[name], data);
                if (this.events[name].isOnce) {
                    delete this.events[name];
                }
                break;
            }
        case 'Array':
            for (var a = this.events[name].length - 1; a >= 0; a--) {
                var item = this.events[name][a];
                item.handle.apply(item, data);
                if (!item.type
                    || data[0] === item.type) {
                    if (item.isOnce) {
                        this.events[name].splice(a, 1);
                    }
                }
            }
            break;
    }
};
// 清空整个 bus
Bus.prototype.clearAll = function () {
    this.events = {};
    this.autoId = 0;
};
// 清空一个 bus 实例
Bus.prototype.clear = function (opt) {
    if (getType(opt) !== 'Object')
        return;
    switch (getType(this.events[opt.name])) {
        case 'Object':
            delete this.events[opt.name];
            break;
        case 'Array':
            for (var a = this.events[opt.name].length - 1; a >= 0; a--) {
                if (this.events[opt.name][a].id === opt.id) {
                    this.events[opt.name].splice(a, 1);
                }
            }
            break;
    }
};
// 【注册】 永久函数
Bus.prototype.on = function (name, handle, id) {
    return this.create(id, name, handle);
};
// 【注册】 一次性函数
Bus.prototype.once = function (name, handle, id) {
    return this.create(id, name, handle, true);
};
// 【注册】 永久唯一函数
Bus.prototype.one = function (name, handle) {
    return this.create(null, name, handle, false, true);
};
// 【注册】 一次性唯一函数
Bus.prototype.oneonce = function (name, handle) {
    return this.create(null, name, handle, true, true);
};

class FlutterJsBridge {
    _listen;
    _send;
    _count = 0;
    _bus = new Bus();
    constructor(options) {
        this._listen = options.onAppMessage;
        this._send = options.sendMessage;
        this.initListen();
    }
    initListen() {
        window[this._listen] = (message) => {
            let res;
            try {
                res = JSON.parse(message);
            }
            catch (err) {
                res = undefined;
            }
            res = res || {
                id: 'response message error',
                message
            };
            this.emit(res);
        };
    }
    emit(data) {
        this._bus.emit(data.id, data);
    }
    on(eventId, handle) {
        this._bus.on(eventId, handle);
    }
    send(message) {
        var sendToApp = window[this._send];
        return new Promise((resolve, reject) => {
            if (!sendToApp) {
                reject('app未提供与web通信的 "' + this._send + '" 方法');
                return;
            }
            this._count++;
            const messageId = 'auto-id-' + this._count;
            const msg = {
                id: messageId,
                message
            };
            this._bus.once(messageId, function (data) {
                resolve(data);
            });
            sendToApp.postMessage(JSON.stringify(msg));
        });
    }
}

return FlutterJsBridge;

})();
//# sourceMappingURL=index.js.map
