import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const textStyle = TextStyle(
  decoration: TextDecoration.none,
  color: Colors.white,
  fontSize: 16,
);

class GoodsDetail extends StatelessWidget {
  const GoodsDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      color: Colors.red,
      child: ListView(
        children: [
          Hero(
              tag: 'goods-detail-image',
              child: Image.network(
                  'http://placekitten.com/g/200/300',
                  width:MediaQuery.of(context).size.width,
                  height: 400,
                  fit: BoxFit.fill
              )
          ),
          Text("桥思科技", style: textStyle),
        ],
      ),
    ));
  }
}