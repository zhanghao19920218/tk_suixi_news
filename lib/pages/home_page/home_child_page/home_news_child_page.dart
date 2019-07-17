import 'package:flutter/material.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_diy_swiper_item.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_news_form_one.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_news_form_two.dart';

//新闻的子页面
class HomeNewsChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: <Widget>[
            SpecialDiySwiperItem(),
            SpecialNewsFormatOneItem(), //显示一张照片
            SpecialNewsFormTwo(),
            SpecialNewsFormatOneItem(), //显示一张照片
            SpecialNewsFormTwo(),
            SpecialNewsFormatOneItem(), //显示一张照片
            SpecialNewsFormTwo(),
          ],
        ),
      );
  }
}