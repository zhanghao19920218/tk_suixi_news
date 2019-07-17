import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/index_page_provider.dart'; //首页的下标的状态管理
import 'package:provider/provider.dart';

//首页下面的TabBars
class IndexPageBottom extends StatelessWidget {
  //设置下方的BottomNavgationBars
  final List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/assets/home_tab.png',
          width: ScreenUtil().setWidth(46),
          height: ScreenUtil().setHeight(44),
        ),
        title: Text('首页'),
        activeIcon: Image.asset(
          'lib/assets/home_selected_tab.png',
          width: ScreenUtil().setWidth(46),
          height: ScreenUtil().setHeight(44),
        )),
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/assets/camera_tab.png',
          width: ScreenUtil().setWidth(46),
          height: ScreenUtil().setHeight(38),
        ),
        title: Text('随手拍'),
        activeIcon: Image.asset(
          'lib/assets/camera_selected_tab.png',
          width: ScreenUtil().setWidth(46),
          height: ScreenUtil().setHeight(38),
        )),

    // BottomNavigationBarItem(icon: Icon(Icons.fiber_new), title: Text('资讯')),
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/assets/server_tab.png',
          width: ScreenUtil().setWidth(44),
          height: ScreenUtil().setHeight(40),
        ),
        title: Text('服务'),
        activeIcon: Image.asset(
          'lib/assets/server_tab_selected.png',
          width: ScreenUtil().setWidth(44),
          height: ScreenUtil().setHeight(40),
        )),
    BottomNavigationBarItem(
        icon: Image.asset(
          'lib/assets/mine_tab.png',
          width: ScreenUtil().setWidth(34),
          height: ScreenUtil().setHeight(42),
        ),
        title: Text('我的'),
        activeIcon: Image.asset(
          'lib/assets/mine_selected_tab.png',
          width: ScreenUtil().setWidth(34),
          height: ScreenUtil().setHeight(42),
        )),
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
