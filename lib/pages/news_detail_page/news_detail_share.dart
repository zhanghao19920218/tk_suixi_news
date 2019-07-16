import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewsDetailShareInfo extends StatelessWidget {
  final List<String> _titles = ['新浪微博', '微信', '朋友圈', 'QQ'];
  final List<String> _imagesPath = [
    'lib/assets/weibo.png',
    'lib/assets/wechat.png',
    'lib/assets/circle.png',
    'lib/assets/qq.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(244, 244, 244, 1),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(401),
      // padding: const EdgeInsets.only(left: 35, right: 35),
      child: Column(
        children: <Widget>[
          _shareTitle(), //标题
          _shareRowsView(),
          _cancelButton()
        ],
      ),
    );
  }

  //取消按钮
  Widget _cancelButton() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.white,
      child: InkWell(
        child: Center(
          child: Text('取消',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
              )),
        ),
      ),
    );
  }

  //显示所有的选择
  Widget _shareRowsView() {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(219),
      child: Row(
        children: <Widget>[
          _shareSingleItem(0),
          _shareSingleItem(1),
          _shareSingleItem(2),
          _shareSingleItem(3),
        ],
      ),
    );
  }

  //分享的一个Item
  Widget _shareSingleItem(index) {
    return Container(
      width: ScreenUtil().setWidth(187),
      height: ScreenUtil().setHeight(219),
      child: Center(
        child: _itemName(index),
      ),
    );
  }

  //显示图标和名称·
  Widget _itemName(index) {
    return Container(
      width: ScreenUtil().setWidth(100),
      height: ScreenUtil().setHeight(140),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 1),
                borderRadius: BorderRadius.circular(10)),
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setWidth(100),
            child: Center(
              child: Image.asset(
                _imagesPath[index],
                width: ScreenUtil().setWidth(58),
                height: ScreenUtil().setHeight(47),
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(100),
            height: ScreenUtil().setHeight(10),
          ),
          Text(
            _titles[index],
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color.fromRGBO(
                  153,
                  153,
                  153,
                  1,
                ),
                fontSize: ScreenUtil().setSp(20)),
          )
        ],
      ),
    );
  }

  //分享到
  Widget _shareTitle() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(72),
      color: Colors.white,
      child: Center(
        child: Text('分享到',
            style: TextStyle(
                fontSize: ScreenUtil().setWidth(24),
                color: Color.fromRGBO(153, 153, 153, 1))),
      ),
    );
  }
}
