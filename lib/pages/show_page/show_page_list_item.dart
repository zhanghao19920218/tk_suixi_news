import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:flutter/services.dart'; //直播列表的跳转
//V视直播列表的Item

//首页的下方时间，观看数量和点赞
const style = TextStyle(color: Colors.black45); //通用的Style

class ShowPageListItem extends StatelessWidget {
  static const platform =
      const MethodChannel('com.example.tkSuixiNews/videoShow'); //获取平台的方法
  //显示第一帧照片的信息
  final String video_first_img;
  //显示视频信息
  final String video_desc;
  //视频长度
  final String video_length;
  //用户的头像地址
  final String avatar;
  //用户的昵称
  final String nick_name;
  //评论的数量
  final int commentNum;
  //点赞的数量
  final int goodLookNum;

  ShowPageListItem(
      {Key key,
      @required this.video_first_img,
      @required this.video_desc,
      @required this.video_length,
      @required this.avatar,
      @required this.nick_name,
      @required this.commentNum,
      @required this.goodLookNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              _newsImage(),
              _newsInfo(),
              _playItem(),
              _playTimeItem(),
            ],
          ),
          _bottomItem()
        ],
      ),
    );
  }

  //显示一个ImageView.上面还有新闻信息和地址
  Widget _newsImage() {
    return Image.network(
      video_first_img,
      colorBlendMode: BlendMode.darken,
      color: Colors.black38,
      fit: BoxFit.cover,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(375),
    );
  }

  //显示照片上面的信息
  Widget _newsInfo() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(13, 15, 13, 0),
        child: Text(
          this.video_desc,
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  //播放的item
  Widget _playItem() {
    return Positioned(
      top: 83,
      child: InkWell(
        onTap: _showOnlineTVPage,
        child: Icon(Icons.play_circle_filled, color: Colors.white, size: 50),
      ),
    );
  }

  //跳转直播的页面
  Future<Null> _showOnlineTVPage() async {
    print('点击了视频播放按钮'); //跳转直播的页面
    try {
      Map<String, dynamic> map = {
      "address": "https://hwapi.yunshicloud.com/m87oxo/251011.m3u8"
    };
      final int result = await platform.invokeMethod('jumpVideoOnlineShow', map);
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'");
    }
  }

  //显示播放时间的iTEM
  Widget _playTimeItem() {
    return Positioned(
      right: 21,
      bottom: 14,
      child: Text(
        video_length,
        style: TextStyle(fontSize: ScreenUtil().setSp(18), color: Colors.white),
      ),
    );
  }

  //显示下方的名称,评论量
  Widget _bottomItem() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(105),
      padding: const EdgeInsets.only(left: 13, right: 13),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _avatarName(),
          ),
          _newsNum(),
          Container(
            width: ScreenUtil().setWidth(50),
          ),
          _goodLook(),
        ],
      ),
    );
  }

  //显示头像和姓名
  Widget _avatarName() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(105),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(avatar),
            radius: 15,
          ),
          Container(
            width: ScreenUtil().setWidth(20),
          ),
          Text(
            nick_name,
            style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          )
        ],
      ),
    );
  }

  //评论数量
  Widget _newsNum() {
    return InkWell(
      onTap: () {
        print('点击了评论的按钮');
      },
      child: Row(
        children: <Widget>[
          //显示Icon,
          Icon(
            Icons.remove_red_eye,
            color: Colors.black12,
            size: 15.0,
          ),
          //显示数字
          Container(
            padding: const EdgeInsets.only(left: 6),
            child: Text('$commentNum', style: style),
          )
        ],
      ),
    );
  }

  //点赞的数量
  Widget _goodLook() {
    return InkWell(
      onTap: () {
        print('点击了点赞按钮');
      },
      child: Row(
        children: <Widget>[
          //显示Icon,
          Icon(
            Icons.favorite,
            size: 15.0,
            color: Colors.black12,
          ),
          //显示数字
          Container(
            padding: const EdgeInsets.only(left: 6),
            child: Text('$goodLookNum', style: style),
          )
        ],
      ),
    );
  }
}
