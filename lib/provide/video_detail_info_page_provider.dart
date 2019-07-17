import 'dart:async';

import 'package:tk_suixi_news/model/video_detail_info_model.dart';
import 'package:tk_suixi_news/services/service_method.dart';

//视频详情的model
class VideoDetailInfoPageModel
{
  String userAvatar; //用户的头像
  String username; //用户名称
  String content; //新闻的内容
  String videoImage; //视频的第一帧照片
  String videoUrl; //播放视频的地址
  String time; //剩余时间

  VideoDetailInfoPageModel(){
    userAvatar = '';
    username = '';
    content = '';
    videoImage = '';
    videoUrl = '';
    time = '';
  }
}

//视频详情的Provider
class VideoDetailInfoPageProvider {
  
  StreamController<VideoDetailInfoPageModel> _streamController;
  Stream<VideoDetailInfoPageModel> _stream;
  VideoDetailInfoPageModel _model;  //视频详情的model

  VideoDetailInfoPageModel get model => _model;

  Stream<VideoDetailInfoPageModel> get stream => _stream;

  VideoDetailInfoPageProvider(){
    _streamController = StreamController<VideoDetailInfoPageModel>.broadcast();
    _stream = _streamController.stream;
    _model = VideoDetailInfoPageModel();
  }

  videoDetailRequests(String videoId) {
    var formData = {'id': videoId};
    Http.request('videoDetailInfo', formData: formData).then((val){
      //文件上传成功后的返回
      // print('文件上传成功: ${val.toString()}');
      if (val['code'] == 1) {
        VideoDetailInfoModel model = VideoDetailInfoModel.fromJson(val);
        _model.userAvatar = model.data.avatar;
        _model.username = model.data.nickname;
        _model.content = model.data.name;
        _model.videoImage = model.data.image;
        _model.videoUrl = model.data.video;
        _model.time = model.data.time;
        _streamController.sink.add(_model);
      }
    });
  }

  dispose() {
    _streamController.close();
  }

}