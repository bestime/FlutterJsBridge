declare namespace FlutterJsBridge {
  export interface Setting {
    onAppMessage: string
    sendMessage: string
  }

  export interface Message {
    id: string
    message: string
  }
}

declare class FlutterJsBridge {
  constructor (options: FlutterJsBridge.Setting)
}