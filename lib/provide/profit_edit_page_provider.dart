import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tk_suixi_news/config/share_prefrence.dart';
import 'package:tk_suixi_news/routers/application.dart';

class ProfitEidtPageProvider {
  StreamController<String> _streamController;
  Stream<String> _stream;
  String _model; //登录信息的model

  ProfitEidtPageProvider() {
    _streamController = StreamController<String>();
    _stream = _streamController.stream;
    _model = ''; //默认首页
  }

  //获取stream
  Stream<String> get stream => _stream;

  //获取当前页面的model
  String get model => _model;

  //注销页面
  signOutPage(BuildContext context) {
    Prefenerce.share.clearToken(context);
    Application.router.navigateTo(context, '/userLoginPage',clearStack: true);
  }

  dispose() {
    _streamController.close();
  }
}
