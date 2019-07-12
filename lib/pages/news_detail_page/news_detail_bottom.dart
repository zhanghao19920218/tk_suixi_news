import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/news_detail_page/news_detail_comment_pop.dart';
import 'package:tk_suixi_news/pages/news_detail_page/news_detail_share.dart';

class NewsDetailBottom extends StatelessWidget {
  //显示按钮的标题
  final List<String> _titles = ['转发', '评论', '赞'];
  final List<IconData> _icons = [
    Icons.transit_enterexit,
    Icons.comment,
    Icons.favorite,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(98),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              offset: Offset(5.0, 5.0),
              blurRadius: 10.0,
              spreadRadius: 2.0),
        ],
      ),
      child: Row(
        children: <Widget>[
          _iconButton(context, 0),
          _iconButton(context, 1),
          _iconButton(context, 2)
        ],
      ),
    );
  }

  //设置按钮
  Widget _iconButton(context, index) {
    return Container(
      width: ScreenUtil().setWidth(250),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: _resendButton(context, index),
    );
  }

  //转发按钮
  Widget _resendButton(context, index) {
    return Container(
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.black26, width: 1))),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _icons[index],
              size: 16,
            ),
            Container(
              width: ScreenUtil().setWidth(16),
            ),
            Text(
              _titles[index],
              style: TextStyle(fontSize: ScreenUtil().setSp(28)),
            ),
          ],
        ),
        onTap: () {
          if (index == 1) {
            //评论
            
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return NewsDetailCommnetPopMenu();
                });
          } else if (index == 0) { //分享
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return NewsDetailShareInfo();
                });
          }
          print('点击了$index');
        },
      ),
    );
  }
}
