import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_diy_swiper_item.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_news_form_one.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_news_form_two.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart'; //刷新页面
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:tk_suixi_news/provide/home_news_info_provider.dart';

class HomeSpecialPage extends StatelessWidget {
  final GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  final GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  final GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  final String title; //获取当前页面的请求标题
  HomeSpecialPage({Key key, this.title}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    //请求网络数据
    Provider.of<HomeNewsInfoProvider>(context).requestFirstPageInfo(title);

    return Container(
        width: ScreenUtil().setWidth(750),
        child: EasyRefresh(
        key: _easyRefreshKey,
        refreshHeader: BezierCircleHeader(
          key: _headerKey,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        refreshFooter: BezierBounceFooter(
          key: _footerKey,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child:ListView(
          children: <Widget>[
              SpecialDiySwiperItem(), //显示一个Banner
              SpecialNewsFormatOneItem(), //显示一张照片
              SpecialNewsFormTwo(),
            ],
        ),
        onRefresh: () async {
          // await new Future.delayed(const Duration(seconds: 2), () {
          //   setState(() {
          //     str.clear();r
          //     str.addAll(addStr);
          //   });
          // });
        },
        loadMore: () async {
          // await new Future.delayed(const Duration(seconds: 1), () {
          //   if (str.length < 20) {
          //     setState(() {
          //       str.addAll(addStr);
          //     });
          //   }
          // });
        },));
  }
}
