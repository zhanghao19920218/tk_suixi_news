import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/config/native_method.dart';
import 'package:tk_suixi_news/pages/news_detail_page/news_detail_bottom.dart';
import 'package:tk_suixi_news/pages/news_detail_page/news_detail_commnet_item.dart';
import 'package:tk_suixi_news/provide/video_detail_info_page_provider.dart';

class VideoDetailInfoPage extends StatelessWidget {
  static const platform = const MethodChannel(methodChannel); //获取平台的方法
  final TextStyle style = TextStyle(
      fontSize: ScreenUtil().setSp(26), color: Colors.black38); //观察的页面

  //获取新闻数据
  final Map _infos = {
    'time': '8',
    'watch': '1265',
    'commnetNum': '2368',
    'likes': '23'
  };

  //获取新闻的id
  final String video_id;

  //根据新闻id获取数据
  VideoDetailInfoPage({Key key, @required this.video_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //请求视频的数据接口
    Provider.of<VideoDetailInfoPageProvider>(context)
        .videoDetailRequests(video_id);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('视频'),
        ),
        body: StreamBuilder(
          stream: Provider.of<VideoDetailInfoPageProvider>(context).stream,
          builder: (BuildContext context,
              AsyncSnapshot<VideoDetailInfoPageModel> snapshot) {
            return _streamBuild(snapshot);
          },
        ));
  }

  //返回下方的Stream
  Widget _streamBuild(AsyncSnapshot<VideoDetailInfoPageModel> snapshot) {
    if (snapshot.hasData) {
      return Container(
          color: Color.fromRGBO(245, 245, 245, 1),
          child: Column(
            children: <Widget>[
              Expanded(
                child: _newsListView(snapshot.data),
              ),
              NewsDetailBottom()
            ],
          ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  //设置上方的ListView
  Widget _newsListView(VideoDetailInfoPageModel model) {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: ListView(
        children: <Widget>[
          _userNameAvatarTime(model.userAvatar, model.username, model.time),
          _detailTitleName(model.content),
          _playArea(model.videoImage, model.videoUrl),
          _shareContent(),
          _commentTitle(),
          NewsDetailCommnetItem(
            avatar:
                'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            nickname: '微信用户',
            commnetDate: '2019－09-09 23:00',
            commentDetail: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。',
          ),
          NewsDetailCommnetItem(
            avatar:
                'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            nickname: '微信用户',
            commnetDate: '2019－09-09 23:00',
            commentDetail: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。',
          ),
        ],
      ),
    );
  }

  //组合用户头像昵称时间
  Widget _userNameAvatarTime(String avatar, String nickname, String time) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _userAvatar(avatar),
          Expanded(
            child: _userName(nickname),
          ),
          _timesDate(time),
        ],
      ),
    );
  }

  //用户头像
  Widget _userAvatar(String avatar) {
    return Container(
      width: ScreenUtil().setWidth(124.0),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(top: 15.0, bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: FadeInImage.assetNetwork(
          width: ScreenUtil().setWidth(84),
          height: ScreenUtil().setHeight(84),
          placeholder: 'lib/assets/avatar_default.png',
          image: avatar,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  //用户名称
  Widget _userName(String nickname) {
    return Text(
      nickname,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(32),
      ),
    );
  }

  //小时的数量
  Widget _timesDate(String time) {
    return Container(
      padding: const EdgeInsets.only(right: 26),
      child: Text(
        time,
        style: style,
      ),
    );
  }

  //设置html的webView
  Widget _detailTitleName(String content) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(13, 25, 13, 0),
        width: ScreenUtil().setWidth(700),
        child: Text(
          content,
          style: style,
          overflow: TextOverflow.ellipsis,
        ));
  }

  //设置下面的播放器
  Widget _playArea(String imageUrl, String videoUrl) {
    return Container(
      padding: const EdgeInsets.only(top: 19, bottom: 27, left: 12, right: 12),
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setHeight(400),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _newsImage(imageUrl),
          _playItem(videoUrl),
          _playTimeItem(),
        ],
      ),
    );
  }

  //文章收藏按钮
  Widget _shareContent() {
    return Container(
      width: ScreenUtil().setHeight(142),
      color: Colors.white,
      padding: const EdgeInsets.only(left: 26, right: 25, bottom: 27),
      child: Row(
        children: <Widget>[
          //分享到
          Expanded(
            child: Text('分享到', style: style),
          ),

          InkWell(
            onTap: () {
              print('点击了微博');
            },
            child: Image.asset(
              'lib/assets/weibo.png',
              width: ScreenUtil().setWidth(46),
              height: ScreenUtil().setHeight(37),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
          ),
          InkWell(
            onTap: () {
              print('点击了微信');
            },
            child: Image.asset(
              'lib/assets/wechat.png',
              width: ScreenUtil().setWidth(44),
              height: ScreenUtil().setHeight(36),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
          ),
          InkWell(
            onTap: () {
              print('点击了朋友圈');
            },
            child: Image.asset(
              'lib/assets/circle.png',
              width: ScreenUtil().setWidth(44),
              height: ScreenUtil().setHeight(44),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
          ),
          //显示分享标题
          InkWell(
            onTap: () {
              print('点击了QQ');
            },
            child: Image.asset(
              'lib/assets/qq.png',
              width: ScreenUtil().setWidth(42),
              height: ScreenUtil().setHeight(44),
            ),
          ),
        ],
      ),
    );
  }

  //显示评论的数量
  Widget _commentTitle() {
    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(88),
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(left: 13, right: 14),
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black38, width: 1))),
        child: Row(
          children: <Widget>[
            //评论
            Text('评论', style: style),
            Container(
              width: ScreenUtil().setWidth(10),
            ),
            Expanded(
              child: Text(
                _infos['commnetNum'],
                style: style,
              ),
            ),

            //赞
            Text('赞', style: style),
            Container(
              width: ScreenUtil().setWidth(10),
            ),
            Text(_infos['likes'], style: style),
          ],
        ),
      ),
    );
  }

  //显示一个ImageView.上面还有新闻信息和地址
  Widget _newsImage(String imageUrl) {
    return Image.network(
      imageUrl,
      colorBlendMode: BlendMode.darken,
      color: Colors.black38,
      fit: BoxFit.cover,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(375),
    );
  }

  //显示播放时间的iTEM
  Widget _playTimeItem() {
    return Positioned(
      right: 21,
      bottom: 14,
      child: Text(
        '9.08',
        style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.white),
      ),
    );
  }

  //播放的item
  Widget _playItem(String videoUrl) {
    return Positioned(
      top: 83,
      child: InkWell(
        onTap: (){
          _showOnlineTVPage(videoUrl);
        },
        child: Icon(Icons.play_circle_filled, color: Colors.white, size: 50),
      ),
    );
  }

  //跳转直播的页面
  Future<Null> _showOnlineTVPage(String videoUrl) async {
    print('点击了视频播放按钮'); //跳转直播的页面
    try {
      Map<String, dynamic> map = {"address": videoUrl};
      final int result = await platform.invokeMethod(playMethod, map);
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'");
    }
  }

}
