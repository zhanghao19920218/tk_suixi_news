import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_normal_time.dart';

//设置一个Item
class VideoPageListItem extends StatelessWidget {
  final String avatar_address; //头像的地址
  final String user_name; //用户名称
  final String user_describe; //用户描述
  final List<String> images; //用户的照片
  final String time; //时间前
  final int watchTimes; //观看数量
  final int goodLook; //点赞
  final String video_first_img; //视频第一帧的照片地址
  final bool isVideo; //是不是是哦

  VideoPageListItem(
      {Key key,
      this.avatar_address,
      this.user_name,
      this.user_describe,
      this.images,
      this.time,
      this.watchTimes,
      this.goodLook,
      this.isVideo,
      this.video_first_img})
      : super(key: key);

  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Container(
        margin: const EdgeInsets.fromLTRB(13.0, 0, 13.0, 0),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Color.fromRGBO(244, 244, 244, 1), width: 1))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _userAvatar(), //头像
            _judgeVideoOrPhotos(), //确定信息
          ],
        ),
      ),
    );
  }

  //设置头像
  Widget _userAvatar() {
    return Container(
      width: ScreenUtil().setWidth(104.0),
      padding: const EdgeInsets.only(top: 15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: FadeInImage.assetNetwork(
          width: ScreenUtil().setWidth(84),
          height: ScreenUtil().setHeight(84),
          placeholder: 'lib/assets/avatar_default.png',
          image: this.avatar_address,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //用户名称
  Widget _userName() {
    return Text(
      user_name,
      style: TextStyle(
        fontSize: ScreenUtil().setSp(32),
      ),
    );
  }

  //用户的状态
  Widget _userDescripe() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
      child: Text(
        user_describe,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28.0)),
      ),
    );
  }

  //显示照片的GridViews
  Widget _imagesGridViews() {
    //判断长度
    if (images.length != 0) {
      //完成里面的item
      List<Widget> listWidgetItems = images.map((val) {
        return InkWell(
          onTap: () {
            print('点击了照片');
          },
          child: Container(
              width: ScreenUtil().setWidth(180),
              height: ScreenUtil().setHeight(180),
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 10.0),
              margin: const EdgeInsets.only(bottom: 3.0),
              child: Image.network(
                val,
                fit: BoxFit.cover,
              )),
        );
      }).toList();

      //返回一个流式布局
      return Wrap(
        spacing: 3,
        runSpacing: 0.0,
        children: listWidgetItems,
      );
    } else {
      return Container();
    }
  }

  //判断是不是视频
  Widget _judgeVideoOrPhotos() {
    //如果是视屏
    if (this.isVideo) {
      //返回视频
      return Container(
        padding: const EdgeInsets.fromLTRB(5, 15.0, 0.0, 5.0),
        width: ScreenUtil().setWidth(590.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _userName(),
            _userDescripe(),
            _videoPlayItem(),
            SpecialNormalTime(
              time: this.time,
              watchTimes: this.watchTimes,
              goodLook: this.goodLook,
            )
          ],
        ),
      );
    } else {
      //返回图片
      return Container(
        padding: const EdgeInsets.fromLTRB(5, 15.0, 0.0, 5.0),
        width: ScreenUtil().setWidth(590.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _userName(),
            _userDescripe(),
            _imagesGridViews(),
            SpecialNormalTime(
              time: this.time,
              watchTimes: this.watchTimes,
              goodLook: this.goodLook,
            )
          ],
        ),
      );
    }
  }

  //创建视频的item
  Widget _videoPlayItem() {
    final playerWidget = Container(
      width: ScreenUtil().setWidth(596),
      height: ScreenUtil().setHeight(300),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _firstImg(),
          _playVideoInk(),
        ],
      ),
    );
    return playerWidget;
  }

  //显示第一帧照片
  Widget _firstImg() {
    return Image.network(
      video_first_img,
      colorBlendMode: BlendMode.darken,
      color: Colors.black38,
      fit: BoxFit.cover,
      width: ScreenUtil().setWidth(596),
      height: ScreenUtil().setHeight(300),
    );
  }

  //显示播放的按钮
  Widget _playVideoInk() {
    return InkWell(
      onTap: (){print('点击了视频播放地址');},
      child: Icon(
        Icons.play_circle_filled,
        size: 70,
        color: Colors.white,
      ),
    );
  }
}
