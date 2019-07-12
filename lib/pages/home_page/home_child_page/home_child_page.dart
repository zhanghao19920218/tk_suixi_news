import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/home_page/home_child_page/home_special_page.dart';
import '../../../provide/home_page_tab_provider.dart';

class HomeChildPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    //创建PageController
    Provider.of<HomePageTabProvider>(context)
        .setPageController(_pageController);
    return StreamBuilder(
      stream: Provider.of<HomePageTabProvider>(context).stream,
      builder: (context, AsyncSnapshot<HomePageTabProviderModel> snapshot) {
        if (snapshot.hasData) {
          return PageView.builder(
            itemCount: snapshot.data.titles.length,
            itemBuilder: (context, index) {
              return HomeSpecialPage();
            },
            controller: _pageController,
            onPageChanged: (int index) {
              Provider.of<HomePageTabProvider>(context)
                  .changeIndexPage(index); //改变当前的index
            },
          );
        } else { //判断有没有数据
          //获取假数据
          Provider.of<HomePageTabProvider>(context)
              .changeTabTitles(['专栏', '视讯', '专栏', '视讯']);
          return Container();
        }
      },
    );
  }
}
