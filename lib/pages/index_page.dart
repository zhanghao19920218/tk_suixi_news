import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/config/progress_hud.dart';
import 'index_page/index_page_bottom.dart'; //下方的tabBars
import 'index_page/index_page_body.dart'; //显示里面Pages

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //设置全局的适配750x1334
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    //初始化Loading的context
    Loading.ctx = context;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Scaffold(
      body: IndexPageBody(),
      bottomNavigationBar: IndexPageBottom(),
      resizeToAvoidBottomInset: false,
    ));
  }
}
