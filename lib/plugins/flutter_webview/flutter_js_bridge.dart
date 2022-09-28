import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';

class FlutterJsBridgeMessage {
  String id;
  String message;

  FlutterJsBridgeMessage({
    required this.id,
    required this.message
  });

}

class FlutterJsBridge {
  static parseMessage (String message) {
    dynamic res = jsonDecode(message);
    return FlutterJsBridgeMessage(
      id: res['id'],
      message: res['message']
    );
  }

  static send (WebViewController controller, FlutterJsBridgeMessage msg) {
    Map<String, dynamic> data = {
      'id': msg.id,
      'message': msg.message
    };

    String response = jsonEncode(data);


    String jsStr = "window.onAppMessage('${response}')";
    print("推送到web => $jsStr");
    controller.runJavascript(jsStr);
  }
}

