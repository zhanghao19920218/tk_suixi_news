import 'package:flutter/painting.dart';
import 'package:tk_suixi_news/services/service_method.dart';

//上传视频信息的资料的Provider
class SendVideoPageProvider {
  // StreamController<FoundPasswordModel> _streamController;
  // Stream<FoundPasswordModel> _stream;
  // FoundPasswordModel _model; //登录信息的model

  //发布V视频的接口
  sendVVideoPort(String name, String video, String image, String time,
      VoidCallback block) {
    var formData = {'name': name, 'video': video, 'image': image, 'time': time};
    Http.request('uploadVideo', formData: formData).then((val) {
      //文件上传成功后的返回
      if (val['code'] == 1) {
        block();
      }
    });
  }
}
