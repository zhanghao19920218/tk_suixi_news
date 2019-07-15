import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes {
   static String root = ''; //根目录
  static String detailsPage = '/newsDetail'; //详细信息的目录
  static String personEditPage = '/personEditPage'; //用户信息编辑
  static String personFavoritePage = '/personFavoritePage'; //用户收藏页面
  static String userLoginPage = '/userLoginPage'; //用户登录页面
  static String userSignInPage = '/userSignInPage'; //用户注册页面
  static String userForgetPassword = '/userForgetPassword'; //用户忘记密码
  static String indexPage = '/indexPage'; //应用首页
  static String sendVideoPage = '/videoSendPage'; //发送视频页面
  static void configureRoutes(Router router){
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR======>ROUTE WAS NOT FOUND');
      }
    );


    //配置路由
    router.define(detailsPage, handler:newsDetailHandler);
    router.define(personEditPage, handler:personEditHandler);
    router.define(personFavoritePage, handler:myFavoriteHandler);
    router.define(userLoginPage, handler: myLoginHandler);
    router.define(userSignInPage, handler: mySignInHandler);
    router.define(userForgetPassword, handler: mypasswordHandler);
    router.define(indexPage, handler: indexPageHandlder);
    router.define(sendVideoPage, handler: sendVideoPageHandler);
  }
}