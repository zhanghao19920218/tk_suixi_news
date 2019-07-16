import 'package:flutter/material.dart';
import '../../provide/index_page_provider.dart'; //首页的下标的状态管理
import 'package:provider/provider.dart';

//首页下面的TabBars
class IndexPageBottom extends StatelessWidget {
  //设置下方的BottomNavgationBars
  final List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.camera_alt), title: Text('拍客')),
    BottomNavigationBarItem(icon: Icon(Icons.fiber_new), title: Text('资讯')),
    BottomNavigationBarItem(icon: Icon(Icons.star), title: Text('服务')),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: 0,
      stream: Provider.of<IndexPageProvider>(context).stream,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _items,
          currentIndex: snapshot.data,
          onTap: (index) {
            Provider.of<IndexPageProvider>(context).changeIndexPage(index);
          },
        );
      },
    );
  }
}
