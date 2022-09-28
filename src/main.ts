import CreateEventBus from './libs/event-bus'

export default class FlutterJsBridge {
  protected _listen: string
  protected _send: string
  protected _count = 0
  protected _bus = new (CreateEventBus as any)()

  constructor (options: FlutterJsBridge.Setting) {
    this._listen = options.onAppMessage
    this._send = options.sendMessage

    this.initListen()

       
  }

  protected initListen () {
    (window as any)[this._listen] = (message: string) => {
      let res: FlutterJsBridge.Message | undefined;
      try {
        res = JSON.parse(message)
      } catch(err){
        res = undefined
      }
      res = res || {
        id: 'response message error',
        message
      }

      this.emit(res)
    }
  }

  emit (data: FlutterJsBridge.Message) {
    this._bus.emit(data.id, data)
  }
  
  on (eventId: string, handle: (data: FlutterJsBridge.Message) => void) {
    this._bus.on(eventId, handle)
  }

  send (message: string) {
    var sendToApp = (window as any)[this._send]
    return new Promise((resolve, reject) => {
      if(!sendToApp) {
        reject('app未提供与web通信的 "'+ this._send + '" 方法')
        return;
      }
  
      this._count++
      const messageId = 'auto-id-' + this._count
  
      const msg:FlutterJsBridge.Message = {
        id: messageId,
        message
      }

      this._bus.once(messageId, function (data: FlutterJsBridge.Message) {
        resolve(data)
      })
      
      sendToApp.postMessage(JSON.stringify(msg));
    })
  }
}