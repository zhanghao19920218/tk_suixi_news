import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/config/share_prefrence.dart';
import 'package:tk_suixi_news/routers/application.dart';
import 'package:tk_suixi_news/services/service_method.dart';
import 'package:tk_suixi_news/model/login_in_model.dart';

class LoginPageModel {
  String mobile; //手机号码
  String password; //密码

  LoginPageModel() {
    mobile = '';
    password = ''; //初始化两个参数
  }
}

class LoginPageProvider {
  StreamController<LoginPageModel> _streamController;
  Stream<LoginPageModel> _stream;
  LoginPageModel _model; //登录信息的model

  LoginPageProvider() {
    _streamController = StreamController<LoginPageModel>();
    _stream = _streamController.stream;
    _model = LoginPageModel(); //默认首页
  }

  //获取stream
  Stream<LoginPageModel> get stream => _stream;

  //获取当前页面的model
  LoginPageModel get model => _model;

  //更改用户的名称
  changeUsermobile(String str) {
    if (str is String && (str.isNotEmpty)) {
      _model.mobile = str;
      _streamController.sink.add(_model);
    }
  }

  //登录页面
  loginUserPageWith(BuildContext context) {
    //用户名称
    String username = Provider.of<LoginPageProvider>(context).model.mobile;
    String password = Provider.of<LoginPageProvider>(context).model.password;
    var formData = {'account': username, 'password': password};

    Http.request('userloginIn', formData: formData).then((val) {
      //获取的数据
      LoginInMemberModel model = LoginInMemberModel.fromJson(val);
      print('获取的token: ${model.data.userinfo.token}');
      Prefenerce.share.changeToken(model.data.userinfo.token, context);
      Application.router.navigateTo(context, '/indexPage', clearStack: true);
    });
  }

  //更改用户的密码
  changeUserpasswords(String str) {
    if (str is String && (str.isNotEmpty)) {
      _model.password = str;
      _streamController.sink.add(_model);
    }
  }

  dispose() {
    _streamController.close();
  }
}
