import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/normal_page/bottom_alert_sheet.dart';
import 'package:tk_suixi_news/pages/show_page/show_page_list_item.dart';

//V视
class ShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('濉溪发布'),
        centerTitle: true,
        actions: <Widget>[_sendButton(context)],
      ),
      body: _videoPlayList(),
    );
  }

  //设置右侧的发布按钮
  //设置发布按钮
  Widget _sendButton(context) {
    return Container(
        // margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.only(right: 23.0),
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return BottomAlertSheet();
                });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.videocam,
                color: Colors.white,
                size: 25,
              ),
              Text(
                '直播',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20.0), color: Colors.white),
              )
            ],
          ),
        ));
  }

  //显示视频播放的列表
  Widget _videoPlayList() {
    return ListView(
      children: <Widget>[
        ShowPageListItem(
          video_first_img:
              'http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/04/28/cffa590ca64b63ac4294886f823b449c.jpg',
          video_desc: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。濉溪县，隶属于安徽省淮北市。',
          video_length: '09:53',
          avatar:
              'https://b-ssl.duitang.com/uploads/item/201703/31/20170331231807_BPdHz.thumb.700_0.jpeg',
          nick_name: '濉溪记者 - 楚天舒',
          commentNum: 1265,
          goodLookNum: 1265,
        ),
        ShowPageListItem(
          video_first_img:
              'http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/04/28/cffa590ca64b63ac4294886f823b449c.jpg',
          video_desc: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。濉溪县，隶属于安徽省淮北市。',
          video_length: '09:53',
          avatar:
              'https://b-ssl.duitang.com/uploads/item/201703/31/20170331231807_BPdHz.thumb.700_0.jpeg',
          nick_name: '濉溪记者 - 楚天舒',
          commentNum: 1265,
          goodLookNum: 1265,
        ),
        ShowPageListItem(
          video_first_img:
              'http://pic.90sjimg.com/back_pic/qk/back_origin_pic/00/04/28/cffa590ca64b63ac4294886f823b449c.jpg',
          video_desc: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。濉溪县，隶属于安徽省淮北市。',
          video_length: '09:53',
          avatar:
              'https://b-ssl.duitang.com/uploads/item/201703/31/20170331231807_BPdHz.thumb.700_0.jpeg',
          nick_name: '濉溪记者 - 楚天舒',
          commentNum: 1265,
          goodLookNum: 1265,
        ),
      ],
    );
  }
}
