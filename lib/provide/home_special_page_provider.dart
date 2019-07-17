import 'dart:async';

import 'package:flutter/painting.dart';
import 'package:tk_suixi_news/model/video_show_model.dart';
import 'package:tk_suixi_news/services/service_method.dart';

//显示V视频列表页面的Provider
class HomeSpecialPageProvider {
  StreamController<List<VideoVPlayerListModel>> _streamController;
  Stream<List<VideoVPlayerListModel>> _stream;
  //当前的页面
  int page;

  // String name = '';

  //当前列表的list
  List<VideoVPlayerListModel> _dataSource;

  HomeSpecialPageProvider() {
    page = 1;
    _streamController =
        StreamController<List<VideoVPlayerListModel>>.broadcast();
    _stream = _streamController.stream;
    _dataSource = [];
  }

  List<VideoVPlayerListModel> get dataSource => _dataSource;

  Stream<List<VideoVPlayerListModel>> get stream => _stream; //返回列表stream

  //更新列表
  addListDataSources(List<VideoVPlayerListModel> lists) {
    _dataSource.addAll(lists);
    _streamController.sink.add(_dataSource);
  }

  //刷新列表
  refreshDataSources(List<VideoVPlayerListModel> lists) {
    _dataSource = [];
    _dataSource = lists;
    _streamController.sink.add(_dataSource);
  }

  //获取V视频列表的接口
  sendVVideoPort(String module, VoidCallback block) {
    //防止重绘
    // if (_dataSource.length > 0) {
    //   return;
    // }
    
    var formData = {'module': module, 'page': page};
    Http.request('articleIndex', formData: formData).then((val) {
      //文件上传成功后的返回
      if (val['code'] == 1) {
        List<VideoVPlayerListModel> lists =
            VideoShowModel.fromJson(val).data.data;
        refreshDataSources(lists);
      }
    });
  }

  dispose() {
    _streamController.close();
  }
}
