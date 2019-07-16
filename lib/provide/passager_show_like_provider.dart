import 'package:tk_suixi_news/services/service_method.dart';

//文章点赞的类
class PassagesShowLikeProvider {
  // StreamController<FoundPasswordModel> _streamController;
  // Stream<FoundPasswordModel> _stream;
  // FoundPasswordModel _model; //登录信息的model

  passageerLikesGoods(String articleId) {
    var formData = {'article_id': articleId};
    Http.request('like', formData: formData).then((val){
      //文件上传成功后的返回
      print('文件上传成功: ${val.toString()}');
    });
  }

}