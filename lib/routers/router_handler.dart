import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:tk_suixi_news/pages/index_page.dart';
import 'package:tk_suixi_news/pages/login_page/login_page.dart';
import 'package:tk_suixi_news/pages/my_faovirte_page.dart';
import 'package:tk_suixi_news/pages/person_edit_page.dart';
import '../pages/news_detail_page.dart';
import '../pages/sign_up_page/sign_up_page.dart';
import '../pages/forget_pass_page/forget_pass_page.dart';

//新闻详情页面
Handler newsDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String news_id = params['news_id'].first;
  print('到达新闻详情页面的id是$news_id');
  return NewsDetailPage(
    news_id: news_id,
  );
});

//个人信息页面
Handler personEditHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PersonEditPage();
});

//我的收藏页面
Handler myFavoriteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyFavoritePage();
});

//登录页面
Handler myLoginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

//立即注册页面
Handler mySignInHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignUpPage();
});

//忘记密码
Handler mypasswordHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgetPasswordPage();
});

//应用首页
Handler indexPageHandlder = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IndexPage();
});
