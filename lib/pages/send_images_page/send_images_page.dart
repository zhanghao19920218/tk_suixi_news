import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/send_images_page/send_images_item.dart';
import 'package:tk_suixi_news/provide/send_images_page_provider.dart';

//发布图文的View

// const BaseUrl = 'http://medium.tklvyou.cn/'; //视频播放的基本地址

class SendImagesPage extends StatelessWidget {

  //用户的名称
  String name = '';

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
                SendImagesItem(),
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
        Provider.of<SendImagesPageProvider>(context).clearImages(); //清空相册
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
          // _pressedVVideoButton(context);
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
        autofocus: true,
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
}
