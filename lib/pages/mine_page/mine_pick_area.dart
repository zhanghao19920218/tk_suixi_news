import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/routers/application.dart';

class MinePickArea extends StatelessWidget {
  //标题名称
  final List<String> _list = <String>[
    '我的收藏',
    '最近浏览',
    '我的帖子',
    '问政记录',
    '我的消息',
    '兑换记录',
    '关注板块',
    '关于我们',
  ];

  //显示的图标的
  final List<String> _images = <String>[
    'lib/assets/mine_favo_icon.png',
    'lib/assets/mine_recen_icon.png',
    'lib/assets/mine_list_icon.png',
    'lib/assets/mine_ask_icon.png',
    'lib/assets/mine_message_icon.png',
    'lib/assets/mine_gift_icon.png',
    'lib/assets/mine_love_icon.png',
    'lib/assets/mine_building_icon.png',
  ];

  //显示数组
  final List<int> _nums = [0, 1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    //显示一个总的items
    List<Widget> _items = _nums.map((index) {
      return _singlePickItem(context, true, index);
    }).toList();

    //返回数组
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(390),
      child: Wrap(
        children: _items,
      ),
    );
  }

  //显示每一个子选择的界面
  Widget _singlePickItem(context, bool isShow, int index) {
    return Container(
      width: ScreenUtil().setWidth(185),
      height: ScreenUtil().setHeight(195),
      child: Center(
        child: Column(
          children: <Widget>[
            _singleImageItem(context,index),
            Container(
              height: ScreenUtil().setHeight(18),
            ),
            Text('${_list[index]}'),
          ],
        ),
      ),
    );
  }

  //显示一个角标的标题
  Widget _singleImageItem(context, int index) {
    if (index == 4) {
      return Badge(
        badgeContent: Text('3',
            style: TextStyle(
              color: Colors.white,
            )),
        badgeColor: Color.fromRGBO(254, 168, 65, 1),
        child: InkWell(
          onTap: () {
            print('点击了$index');
          },
          child: Container(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setHeight(100),
            // color: Colors.black38,
            child: Image.asset(_images[index]),
          ),
        ),
      );
    } else {
      return InkWell(
          onTap: () {
            if (index == 0) { //我的收藏
             Application.router.navigateTo(context, '/personFavoritePage');
            }
            print('点击了$index');
          },
          child: Container(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setHeight(100),
            // color: Colors.black38,
            child: Image.asset(_images[index]),
          ),
        );
    }
  }
}
