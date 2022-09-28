import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_js_bridge/views/goods_detail/index.dart';
import 'package:flutter_js_bridge/views/hello_world/index.dart';

const navigationList = [
  {
    'name': '欢迎页',
    'routeWidget': HelloWorld(),
    'routeName': '/hello-world',
    'hero-id': '',
    'image': 'http://placekitten.com/g/150/280',
  },
  {
    'name': '桥思科技',
    'routeWidget': GoodsDetail(),
    'routeName': '/goods-detail',
    'hero-id': 'goods-detail-image',
    'image': 'http://placekitten.com/g/200/300'

  }
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> naves = [];

    for(var item in navigationList) {
      naves.add(Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            String routeName = item['routeName'].toString();
            print('点击了2$item -> $routeName');
            
            // Navigator.of(context).push(CupertinoPageRoute(builder: (ctx) {
            //
            //
            //   return dd;
            // }));
            
            if(routeName == '/goods-detail') {
              Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                          opacity: animation,
                        child: const GoodsDetail(),
                      );
                    }
                )
              );
            } else {
              Navigator.of(context).pushNamed(routeName);  
            }
          },
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: MaterialStateProperty.all(Size(0, 0)),
            padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 20, 20, 20)),
          ),
          child: Row(
            children: [
              Hero(
                  tag: item['hero-id'].toString(),
                  child: Image.network(
                      item['image'].toString(),
                      // width:MediaQuery.of(context).size.width,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill
                  )
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text('${item['name']}'),
              )
            ],
          ),
        ),
      ));
    }

    return Material(
      child: SafeArea(
        child: Container(
          color: Colors.black12,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: ListView(
            children: naves,
          ),
        ),
      ),
    );
  }
}