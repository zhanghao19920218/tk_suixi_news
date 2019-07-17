//我的页面的Provider
import 'dart:async';

import 'package:tk_suixi_news/model/user_info_model.dart';
import 'package:tk_suixi_news/services/service_method.dart';

//个人信息的model
class UserInfomrationModel {
  String username; //用户名
  String mobile; //手机号码
  String avatar; //头像
  int scores; //积分

  UserInfomrationModel() {
    username = '';
    mobile = '';
    avatar = '';
    scores = 0;
  }
}

//请求个人页面
class UserMinedInfoProvider {
  StreamController<UserInfomrationModel> _streamController;
  Stream<UserInfomrationModel> _stream;
  UserInfomrationModel _model;

  UserMinedInfoProvider() {
    _streamController = StreamController<UserInfomrationModel>();
    _stream = _streamController.stream;
    _model = new UserInfomrationModel();
  }

  UserInfomrationModel get model => _model;
  Stream<UserInfomrationModel> get stream => _stream;

  requestMineInformation() {
    if (model.mobile.isEmpty) {
//请求个人信息
      Http.request('mineInfo').then((val) {
        //请求成功进行刷新
        if (val['code'] == 1) {
          UserInfoModel model = UserInfoModel.fromJson(val);
          _model.username = model.data.username; //用户名称
          _model.avatar = model.data.avatar; //用户头像
          _model.mobile = model.data.mobile; //用户手机
          _model.scores = model.data.score; //用户积分
          _streamController.sink.add(_model);
        }
      });
    }
  }

  dispose() {
    _streamController.close();
  }
}
