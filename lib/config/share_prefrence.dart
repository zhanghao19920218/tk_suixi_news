//数据持久化的封装
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tk_suixi_news/config/progress_hud.dart';

const String K_JL_token = 'token';

class Prefenerce {
  static Prefenerce share = Prefenerce(); //静态数据
  //获取token
  String _token = '';
  
  //获取本地的token
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(K_JL_token) != null) {
      _token = prefs.getString(K_JL_token);
    } else {
      _token = '';
    }
    print('获取的token: $_token');

    return _token;
  }

  //设置token
  void changeToken(String newValue, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(K_JL_token, newValue);
    //进行登录
    if (prefs.getString(K_JL_token) != null) {
      Loading.alert('存储token成功', 1);
    
    } else {
      Loading.alert('存储token失败', 1);//返回错误
    }
  }

  //清空token
  void clearToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(K_JL_token); //删除key键
    if (prefs.getString(K_JL_token) == null) {
      Loading.alert('删除token成功', 1);
    } else {
      Loading.alert('删除token失败', 1);
    }
  }
}
