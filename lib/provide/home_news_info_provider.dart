import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tk_suixi_news/services/service_method.dart';

class HomeNewsInfoProvider {
  // StreamController<FoundPasswordModel> _streamController;
  // Stream<FoundPasswordModel> _stream;
  // FoundPasswordModel _model; //登录信息的model
  int page = 1;
  bool isFirstTime = true;
  String name = '';

  requestFirstPageInfo(String name) {
    //如果请求参数不同才会进行请求,同时请求完才会进行刷新
    if (this.name != name ) {
      this.name = name;
      isFirstTime = true;
    }

    if (isFirstTime) {
      //只有第一次才请求i
      isFirstTime = false;
      var formData = {'module': name, 'p': '${page}'};
      Http.request('articleIndex', formData: formData).then((val) {});
    }
  }
}
