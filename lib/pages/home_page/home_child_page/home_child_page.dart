import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/home_child_ask_gov_page.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/home_news_child_page.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/home_special_page.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/home_video_nchild_page.dart';
import '../../../provide/home_page_tab_provider.dart';

class HomeChildPage extends StatelessWidget {
  // final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Provider.of<HomePageTabProvider>(context)
        .changeTabTitles(['V视频', '新闻', '视讯', '问政']);
    //创建PageController
    Provider.of<HomePageTabProvider>(context)
        .setPageController(PageController(initialPage: 0));
    return PageView.builder(
      itemCount: Provider.of<HomePageTabProvider>(context).model.titles.length,
      itemBuilder: (context, index) {
        //新闻页面
        if (index == 1) {
          return HomeNewsChildPage();
        }

        //视讯
        if (index == 2) {
          return HomeVideoNewsChildPage();
        }

        //问政
        if (index == 3) {
          return HomeAskGovChildPage();
        }
        return HomeSpecialPage(title: Provider.of<HomePageTabProvider>(context).model.titles[index],);
      },
      controller:
          Provider.of<HomePageTabProvider>(context).model.pageController,
      onPageChanged: (int index) {
        Provider.of<HomePageTabProvider>(context)
            .changeIndexPage(index); //改变当前的index
      },
    );
  }
}
