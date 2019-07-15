import 'package:flutter/painting.dart';
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

  //发布V视频的接口
  // sendVVideoPort(String name, String video, String image, String time,
  //     VoidCallback block) {
  //   var formData = {'name': name, 'video': video, 'image': image, 'time': time};
  //   Http.request('uploadVideo', formData: formData).then((val) {
  //     //文件上传成功后的返回
  //     if (val['code'] == 1) {
  //       block();
  //     }
  //   });
  // }
  dispose() {
    _streamController.close();
  }
}
