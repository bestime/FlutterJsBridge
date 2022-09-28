import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../goods_detail/index.dart';

const textStyle = TextStyle(
  decoration: TextDecoration.none,
  color: Colors.white,
  fontSize: 16,
);
class HelloWorld extends StatelessWidget {
  const HelloWorld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      color: Colors.pinkAccent,
      child: ListView(
        children: [
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed('/goods-detail');
          }, child: Text('再次跳转', style: textStyle)),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
          Text("你好世界", style: textStyle),
        ],
      ),
    ));
  }
}
