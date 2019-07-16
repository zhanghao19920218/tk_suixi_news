import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/mine_page/mine_pick_area.dart';
import 'package:tk_suixi_news/pages/mine_page/mine_top_area.dart';

//我的

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
