import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/config/numbers_util.dart';
import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/routers/application.dart';
import 'package:tk_suixi_news/services/service_method.dart';
import 'package:tk_suixi_news/model/sign_in_member_model.dart';
import 'package:tk_suixi_news/config/share_prefrence.dart';

class SignUpPageModel {
  String mobile; //手机号码
  String code; //手机验证码
  String password; //密码
  String confirmPassword; //确认密码

  SignUpPageModel() {
    mobile = '';
    code = '';
    password = '';
    confirmPassword = '';
  }
}

class SignUpPageProvider {
  StreamController<SignUpPageModel> _streamController;
  Stream<SignUpPageModel> _stream;
  SignUpPageModel _model; //登录信息的model

  SignUpPageProvider() {
    _streamController = StreamController<SignUpPageModel>();
    _stream = _streamController.stream;
    _model = SignUpPageModel(); //默认首页
  }

  //获取stream
  Stream<SignUpPageModel> get stream => _stream;

  //获取当前页面的model
  SignUpPageModel get model => _model;

  //修改手机号码
  changeMobileNumber(String mobile) {
    _model.mobile = mobile;
    _streamController.sink.add(_model);
  }

  //修改验证码
  changeMobileCode(String code) {
    _model.code = code;
    _streamController.sink.add(_model);
  }

  //修改密码
  changePassword(String password) {
    _model.password = password;
    _streamController.sink.add(_model);
  }

  //确认密码
  confirmDetailPassword(String password) {
    _model.confirmPassword = password;
    _streamController.sink.add(_model);
  }

  //发送验证码
  sendMobileCode(BuildContext context) {
    String mobile = Provider.of<SignUpPageProvider>(context).model.mobile;
    print(mobile);
    if (NumberUtil.instance().isChinaPhoneLegal(mobile)) {
      var formData = {'mobile': mobile, 'event': 'register'};
      Http.request('sendCode', formData: formData);
    } else {
      Loading.alert('手机号码错误', 1);
    }
  }

  //立即注册按钮
  signInImmdiate(BuildContext context) {
    String mobile =
        Provider.of<SignUpPageProvider>(context).model.mobile; //手机号码
    String code = Provider.of<SignUpPageProvider>(context).model.code; //验证码
    String password =
        Provider.of<SignUpPageProvider>(context).model.password; //密码
    String confirmPass =
        Provider.of<SignUpPageProvider>(context).model.confirmPassword; //确认的密码

    if (mobile.isEmpty) {
      Loading.alert('手机号码不能为空', 1);
      return;
    }

    if (code.isEmpty) {
      Loading.alert('验证码不能为空', 1);
      return;
    }

    if (password.isEmpty) {
      Loading.alert('密码不能为空', 1);
      return;
    }

    if (confirmPass.isEmpty) {
      Loading.alert('确认密码不能为空', 1);
      return;
    }

    if (confirmPass != password) {
      Loading.alert('两次输入密码不一致', 1);
      return;
    }

    var formData = {
      'password': password,
      'captcha': code,
      'mobile': mobile
    };

    Http.request('registerUser', formData: formData).then((val) {
      MemberSignModel model = MemberSignModel.fromJson(val);
      //获取的数据
      print(val.toString());
      String token = model.data.userinfo.token;
      print('获取的token: $token');
      Prefenerce.share.changeToken(token, context);
      Application.router.navigateTo(context, '/indexPage', clearStack: true);
    });
  }

  dispose() {
    _streamController.close();
  }
}
