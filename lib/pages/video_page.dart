import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/model/video_list_item_model.dart';
import 'package:tk_suixi_news/provide/video_page_provider.dart';
import 'package:tk_suixi_news/config/fonts.dart';
import 'package:tk_suixi_news/pages/normal_page/bottom_alert_sheet.dart';
import 'package:tk_suixi_news/pages/video_page/video_page_list_item.dart';

//拍客
class VideoPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    //请求随手拍
    Provider.of<VideoPageProvider>(context).refreshVideoPage();


    return Scaffold(
      appBar: AppBar(
        title: ImageLogo.share.logo,
        centerTitle: true,
        actions: <Widget>[
          _sendButton(context),
        ],
      ),
      body: Container(
        child: Center(
          child: Container(
            width: ScreenUtil().setWidth(750.0),
            child: _listOrContainer(context),
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

  //设置返回到底是加载还是一个列表
  Widget _listOrContainer(BuildContext context){
    return StreamBuilder(
      stream: Provider.of<VideoPageProvider>(context).stream,
      builder: (BuildContext context, AsyncSnapshot<List<VideoDetailListItem>> snapshot){
        if (snapshot.hasData) {
          return _itemListView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //设置下方的列表
  Widget _itemListView(List<VideoDetailListItem> _lists) {
    return ListView.builder(
      itemCount: _lists.length,
      itemBuilder: (BuildContext context, int index){
        return VideoPageListItem(
          avatar_address: _lists[index].avatar,
          user_name: _lists[index].nickname,
          user_describe: _lists[index].name,
          images: _lists[index].images,
          time: _lists[index].time,
          watchTimes: _lists[index].visitNum,
          goodLook: _lists[index].likeNum,
          isVideo: _lists[index].images is List ? false : true,
        );
      },
    );
  }
}
