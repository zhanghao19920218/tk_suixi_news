import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/services/service_method.dart';
import 'dart:async';

//上传图文信息的资料的Provider
class SendImagesPageProvider {
  StreamController<List<String>> _streamController;
  Stream<List<String>> _stream;
  List<String> _images; //显示照片的数量

  List<String> get images => _images;

  Stream<List<String>> get stream => _stream;

  SendImagesPageProvider() {
    _streamController = StreamController<List<String>>.broadcast();
    _stream = _streamController.stream;
    _images = [];
  }

  void setImage(String imageName) {
    print('更新照片');
    if (_images.length >= 8) {
      Loading.alert('最多添加8张照片', 1);
      return;
    }

    if (!_images.contains(imageName)) {
      _images.add(imageName);
    }
    print('获取数据$_images');
    _streamController.sink.add(_images);
  }

  //清空照片
  void clearImages() {
    _images = [];
    _streamController.sink.add(_images);
  }

  //发布图文照片的接口
  sendVVideoPort(String name, BuildContext context, VoidCallback block, ) {
    List<String> lists = Provider.of<SendImagesPageProvider>(context).images;
    String jsonList = lists.join(',');
    var formData = {'name': name, 'images': jsonList};
    Http.request('sendArticles', formData: formData).then((val) {
      //文件上传成功后的返回
      if (val['code'] == 1) {
        block();
      }
    });
  }

  dispose() {
    _streamController.close();
  }
}
