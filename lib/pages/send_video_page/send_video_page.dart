import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart'; //直播列表的跳转
import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/provide/send_video_page_provider.dart';

const BaseUrl = 'http://medium.tklvyou.cn/'; //视频播放的基本地址

class SendVideoPage extends StatelessWidget {
  static const platform =
      const MethodChannel('com.example.tkSuixiNews/videoShow'); //获取平台的方法
  //视频地址
  final String videoUrl;
  //图像地址
  final String imageUrl;
  //视频长度
  final String videoLengthUrl;
  //修改里面的内容
  String name = '';

  SendVideoPage(
      {Key key,
      @required this.videoUrl,
      @required this.imageUrl,
      @required this.videoLengthUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titleBar(context),
                _describeText(),
                _videoFile()
              ],
            ),
          ),
        ),
      ),
    );
  }

  //取消按钮
  Widget _cancelButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Text('取消',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(30),
          )),
    );
  }

  //发表按钮
  Widget _sendButton(BuildContext context) {
    return RaisedButton(
        onPressed: () {
          print('点击了发表视频按钮');
          _pressedVVideoButton(context);
        },
        child: Text(
          '发表',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
        ),
        color: Color.fromRGBO(255, 74, 92, 1));
  }

  //扩展标题
  Widget _titleBar(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: _cancelButton(context),
          ),
          _sendButton(context)
        ],
      ),
    );
  }

  //发布内容的界面
  Widget _describeText() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 36),
      height: ScreenUtil().setHeight(230),
      child: CupertinoTextField(
        onChanged: (text) {
          //修改内容标题
          this.name = text;
        },
        decoration:
            BoxDecoration(border: Border.all(color: Colors.transparent)),
        placeholder: '发布内容...',
        // placeholderStyle: TextStyle(),
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //发布内容里面的Video
  Widget _videoFile() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 36),
      height: ScreenUtil().setHeight(416),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network('${BaseUrl + this.imageUrl}'),
          _playItem(),
        ],
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
      Map<String, dynamic> map = {"address": BaseUrl + this.videoUrl};
      final int result =
          await platform.invokeMethod('jumpVideoOnlineShow', map);
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'");
    }
  }

  //发布V视频的按钮
  _pressedVVideoButton(BuildContext context) {
    Provider.of<SendVideoPageProvider>(context).sendVVideoPort(
        this.name, this.videoUrl, this.imageUrl, this.videoLengthUrl, (){
          Loading.alert('发布V视频成功', 1);
          Navigator.of(context).pop();
        });
  }
}
