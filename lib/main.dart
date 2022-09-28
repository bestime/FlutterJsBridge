import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_js_bridge/plugins/flutter_webview/index.dart';
import 'package:flutter_js_bridge/views/goods_detail/index.dart';
import 'package:flutter_js_bridge/views/h5_page/index.dart';
import 'package:flutter_js_bridge/views/hello_world/index.dart';
import 'package:flutter_js_bridge/views/home_page/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JsBridge测试',

      theme: ThemeData(
          primarySwatch: Colors.blue
      ),

      onGenerateRoute: (RouteSettings settings) {
        Widget ?toWidget;

        if(settings.name == '/') {
          toWidget = const HomePage();
        } else if(settings.name == '/hello-world') {
          toWidget = const HelloWorld();
        }else if(settings.name == '/goods-detail') {
          toWidget = const GoodsDetail();
        } else if(settings.name == '/h5') {
          toWidget = const H5page();
        } else {
          toWidget = const HomePage();
        }

        return CupertinoPageRoute(builder: (_) => toWidget!, settings: settings);
      },

      initialRoute: '/',
    );
  }
}