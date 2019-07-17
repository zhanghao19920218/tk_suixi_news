import 'package:flutter/material.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/video_news_page/video_news_detail_item.dart';

class HomeVideoNewsChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: <Widget>[
            HomeChildVideoNewsPage(),
            HomeChildVideoNewsPage(),
            HomeChildVideoNewsPage(),
            HomeChildVideoNewsPage(),
            HomeChildVideoNewsPage(),
            HomeChildVideoNewsPage(),
          ],
        ),
      );
  }
}