import 'package:flutter/material.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_news_form_one.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_news_form_two.dart';

//问政
class HomeAskGovChildPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          children: <Widget>[
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