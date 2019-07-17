import 'package:flutter/material.dart';
import '../home_page.dart'; //首页
import '../video_page.dart'; //拍客
// import '../show_page.dart'; //V视
import '../server_page.dart'; //服务
import '../mine_page.dart'; //我的
import '../../provide/index_page_provider.dart'; //首页的下标的状态管理
import 'package:provider/provider.dart';

class IndexPageBody extends StatelessWidget {

  //设置里面内容
  final List<Widget> bodies = <Widget>[
    HomePage(),
    VideoPage(),
    // ShowPage(),
    SerivcePage(),
    MinePage()
  ];

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: 0,
      stream: Provider.of<IndexPageProvider>(context).stream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return IndexedStack(
          children: bodies,
          index: snapshot.data,
        );
      },
    );
  }
}
