import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_js_bridge/plugins/flutter_webview/index.dart';

const String defaultUrl = 'http://192.168.3.99:99/git/FlutterJsBridge/html';

class H5page extends StatefulWidget {
  const H5page({Key? key}) : super(key: key);

  @override
  State<H5page> createState() => _H5page();
}

class _H5page extends State<H5page> {
  String appUrl = defaultUrl;

  final TextEditingController _controller = TextEditingController(text: defaultUrl);

  void jumpToWebView() {
    setState(() {
      appUrl = _controller.value.text;
    });
    print('跳转：' + appUrl);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                  ),
                ),
                MaterialButton(onPressed: jumpToWebView, color: Colors.blue, child: const Text('确定')),
              ],
            ),
            Expanded(child: FlutterWebview(url: appUrl)),
          ],
        ),
      ),
    );
  }
}
