import 'dart:async';

import 'package:flutter/cupertino.dart';

//设置首页获取标题进行更改
class HomePageTabProviderModel {
  int currentIndex; //当前页面的索引
  List<String> titles; //当前页面的标题
  PageController pageController;

  HomePageTabProviderModel() {
    currentIndex = 0;
    titles = ['专栏'];
  }
}

class HomePageTabProvider {
  StreamController<HomePageTabProviderModel> _streamController;
  Stream<HomePageTabProviderModel> _stream;
  HomePageTabProviderModel _model; //当前页面的索引

  HomePageTabProvider() {
    _streamController = StreamController<HomePageTabProviderModel>.broadcast();
    _stream = _streamController.stream;
    _model = HomePageTabProviderModel(); //默认首页
  }

  //获取stream
  Stream<HomePageTabProviderModel> get stream => _stream;

  //获取当前索引
  HomePageTabProviderModel get model => _model;

  //更改页面的首页index
  changeIndexPage(int index) {
    //更改的时候再更新
    if (_model.currentIndex != index) {
      _model.currentIndex = index;
      _streamController.sink.add(_model);
    }
  }

  //更改跳转的页面
  changeParentVC(int index) {
    print(_model.pageController);
    _model.currentIndex = index;
    _model.pageController.jumpToPage(index);
    _streamController.sink.add(_model);
  }

  //设置PageController
  setPageController(PageController pageController) {
    _model.pageController = pageController;
    print(_model.pageController);
    _streamController.sink.add(_model);
  }

  //获取到专栏的数据
  changeTabTitles(List<String> titles) {
    _model.titles = titles;
    _streamController.sink.add(_model);
  }

  dispose() {
    _streamController.close();
    _model.pageController.dispose();
  }
}
