import 'package:flutter/material.dart';
import 'package:tk_suixi_news/pages/login_page/login_page.dart';
import 'package:tk_suixi_news/provide/found_password_page_provider.dart';
import 'package:tk_suixi_news/provide/home_news_info_provider.dart';
import 'package:tk_suixi_news/provide/passager_show_like_provider.dart';
import 'package:tk_suixi_news/provide/profit_edit_page_provider.dart';
import 'package:tk_suixi_news/provide/sign_up_page_provider.dart';
import 'pages/index_page.dart'; //首页
import 'package:provider/provider.dart'; //导入Provider状态管理
import 'provide/index_page_provider.dart'; //下面tabBar的状态管理
import 'provide/home_page_tab_provider.dart'; //首页的几个TabBar管理
import 'provide/login_page_provider.dart'; //登录页面的状态管理
import 'package:fluro/fluro.dart'; //路由管理
import 'routers/routers.dart'; //路由管理
import 'routers/application.dart'; //路由管理
import 'config/share_prefrence.dart'; //导入token确定

void main() {
  var indexPageProvider = new IndexPageProvider(); //首页的状态管理
  var homePageTabProvider = new HomePageTabProvider(); //首页的tabBar的点击
  var loginPageProvider = new LoginPageProvider(); //登录页面的Provider管理
  var profitEditPageProvider = new ProfitEidtPageProvider(); //用户编辑页面的Provider管理
  var signInPageProvider = new SignUpPageProvider(); //获取注册页面的Provider
  var foundpassProvider = new FoundPasswordPageProvider(); //获取重置密码的Provider
  var homeNewsPageProvider = new HomeNewsInfoProvider(); //专栏信息的Provider
  var passagerLikeShowProvider = new PassagesShowLikeProvider(); //喜欢文章的Provider

  //多重状态管理
  runApp(MultiProvider(
    providers: [
      Provider<IndexPageProvider>.value(
        value: indexPageProvider,
      ),
      Provider<HomePageTabProvider>.value(
        value: homePageTabProvider,
      ),
      Provider<LoginPageProvider>.value(
        value: loginPageProvider,
      ),
      Provider<ProfitEidtPageProvider>.value(
        value: profitEditPageProvider,
      ),
      Provider<SignUpPageProvider>.value(
        value: signInPageProvider,
      ),
      Provider<FoundPasswordPageProvider>.value(
        value: foundpassProvider,
      ),
      Provider<HomeNewsInfoProvider>.value(
        value: homeNewsPageProvider,
      ),
      Provider<PassagesShowLikeProvider>.value(
        value: passagerLikeShowProvider,
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //路由引入
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    //显示新闻类App
    return MaterialApp(
      title: '濉溪发布Flutter',
      debugShowCheckedModeBanner: false, //不显示debug状态
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 82, 84, 1.0), //设置主题的颜色
      ),
      home: FutureBuilder(
        future: Prefenerce.share.getToken(),
        builder: (context, AsyncSnapshot<String> snapshot){
          if (snapshot.hasData) { //如果有参数
            if (snapshot.data is String && (snapshot.data.isNotEmpty)) {
              return IndexPage();
            } else {
              return LoginPage();
            }
          } else {
            return LoginPage();
          }
        },
      ), //显示主要的页面
    );
  }
}
