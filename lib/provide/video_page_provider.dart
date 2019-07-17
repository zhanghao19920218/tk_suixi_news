import 'dart:async';

import 'package:tk_suixi_news/model/video_list_item_model.dart';
import 'package:tk_suixi_news/services/service_method.dart';

class VideoPageProvider {
  StreamController<List<VideoDetailListItem>> _streamController;
  Stream<List<VideoDetailListItem>> _stream;
  List<VideoDetailListItem> _lists; //登录信息的model
  int page = 1;

  VideoPageProvider() {
    _streamController = StreamController<List<VideoDetailListItem>>();
    _stream = _streamController.stream;
    _lists = [];
  }

  Stream<List<VideoDetailListItem>> get stream => _stream;

  List<VideoDetailListItem> get lists => _lists;

  //请求随手拍
  refreshVideoPage() {
    if (_lists.length > 0 ){
      return;
    }

    var formData = {'module': '随手拍', 'p': '${page}'};
    Http.request('articleIndex', formData: formData).then((val){
      if (val['code'] == 1) {
        _lists = VideoListItemModel.fromJson(val).data.data;
        _streamController.sink.add(_lists);
      }
    });
  }

  dispose(){
    _streamController.close();
  }

}