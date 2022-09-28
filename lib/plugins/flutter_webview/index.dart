
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_js_bridge/plugins/flutter_webview/flutter_js_bridge.dart';

import '../../views/goods_detail/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

const textStyle = TextStyle(
  decoration: TextDecoration.none,
  color: Colors.white,
  fontSize: 16,
);
class FlutterWebview extends StatefulWidget {
  final String url;

  const FlutterWebview({
    Key? key,
    required this.url
  }) : super(key: key);


  @override
  State<FlutterWebview> createState() => _FlutterWebview();
}


class _FlutterWebview extends State<FlutterWebview> {
  WebViewController? _controller;

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'sendMessage',
        onMessageReceived: (JavascriptMessage data) {
          if(_controller!=null) {
            FlutterJsBridgeMessage item = FlutterJsBridge.parseMessage(data.message);
            FlutterJsBridge.send(_controller!, item);
          }
        });
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("最新地址：" + widget.url);
    _controller?.loadUrl(widget.url);
    return WebView(
        backgroundColor: const Color(0x00000000),
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context)
        },
        onWebResourceError: (WebResourceError error) {
          print(
              "网页报错 ${error.errorCode} => ${error.description} => ${error.domain}");
        },
        onPageFinished: (String d) {

        },
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController v) {
          _controller = v;
          _controller?.loadUrl(widget.url);

        });
  }
}