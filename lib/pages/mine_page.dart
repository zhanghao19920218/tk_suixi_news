import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/mine_page/mine_pick_area.dart';
import 'package:tk_suixi_news/pages/mine_page/mine_top_area.dart';
import 'package:tk_suixi_news/provide/mine_info_page.dart';

//我的

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //请求用户个人信息
    Provider.of<UserMinedInfoProvider>(context).requestMineInformation();

    return Scaffold(
      primary: false,
      body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[MinePageTopArea(), MinePickArea()],
            ),
          )),
    );
  }
}
