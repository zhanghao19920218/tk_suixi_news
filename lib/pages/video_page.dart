import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/normal_page/bottom_alert_sheet.dart';
import 'package:tk_suixi_news/pages/video_page/video_page_list_item.dart';

//拍客
class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('濉溪发布'),
        centerTitle: true,
        actions: <Widget>[
          _sendButton(context),
        ],
      ),
      body: Container(
        child: Center(
          child: Container(
            width: ScreenUtil().setWidth(750.0),
            child: _itemListView(),
          ),
        ),
      ),
    );
  }

  //设置右侧的发布按钮
  //设置发布按钮
  Widget _sendButton(context) {
    return Container(
        // margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.only(right: 23.0),
        child: InkWell(
          onTap: (){
            showModalBottomSheet(context:context, builder: (BuildContext context){
              return BottomAlertSheet();
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 25.0,
              ),
              Text(
                '发布',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20.0), color: Colors.white),
              )
            ],
          ),
        ));
  }

  //设置下方的列表
  Widget _itemListView() {
    return ListView(
      children: <Widget>[
        VideoPageListItem(
          avatar_address:
              'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
          user_name: '微信用户',
          user_describe: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。',
          images: [
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
          ],
          time: 8,
          watchTimes: 1265,
          goodLook: 1265,
          isVideo: false,
        ),
        VideoPageListItem(
          avatar_address:
              'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
          user_name: '微信用户',
          user_describe: '濉溪县，隶属于安徽省淮北市。位于安徽省北部，总面积1987平方公里。',
          images: [
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
            'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
          ],
          time: 8,
          watchTimes: 1265,
          goodLook: 1265,
          isVideo: true,
          video_first_img: 'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg',
        )
      ],
    );
  }
}
