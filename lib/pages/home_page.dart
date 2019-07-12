import 'package:flutter/material.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/home_child_page.dart';
import 'home_page/home_page_appbar.dart'; //首页上的搜索按钮
import 'home_page/home_page_indicator.dart';

//首页
class HomePage extends StatelessWidget {
  //防止返回首页刷新
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 82, 84, 1.0),
        child: SafeArea(
            child: Container(
              color: Colors.white,
          child: Column(
            children: <Widget>[
              HomePageAppBar(), //上面的tabBar
              HomePageIndicator(),
              Expanded(
                child: HomeChildPage(),
              ), //显示下面的子页面
            ],
          ),
        )),
      ),
    );
  }
}
