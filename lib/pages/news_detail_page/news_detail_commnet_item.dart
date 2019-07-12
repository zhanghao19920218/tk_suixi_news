import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//新闻详情下方的评论
class NewsDetailCommnetItem extends StatelessWidget {
  //获取评论照片
  final String avatar;
  //获取用户昵称
  final String nickname;
  //获取评论时间
  final String commnetDate;
  //获取评论内容
  final String commentDetail;

  NewsDetailCommnetItem(
      {Key key,
      @required this.avatar,
      @required this.nickname,
      @required this.commnetDate,
      @required this.commentDetail})
      : super(key: key);

  final TextStyle style = TextStyle(
      fontSize: ScreenUtil().setSp(26), color: Colors.black38); //观察的页面

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        color: Colors.white,
        // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _commentListViews(),
          _combineCommentUserDate(),
        ],
      ),
    );
  }

  //头像
  Widget _commentListViews() {
    return Container(
      width: ScreenUtil().setWidth(129),
      padding: const EdgeInsets.only(left: 13, top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: FadeInImage.assetNetwork(
          width: ScreenUtil().setWidth(84),
          height: ScreenUtil().setHeight(84),
          placeholder: 'lib/assets/place_holder_image.png',
          image: this.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //评论姓名和时间
  Widget _commentNameAndTime() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(nickname,
              style: TextStyle(fontSize: ScreenUtil().setSp(32))),
        ),
        Text(commnetDate, style: style)
      ],
    );
  }

  //显示评论的信息
  Widget _commentInfo() {
    return Container(
      padding: const EdgeInsets.only(top: 14),
      child: Text(
        commentDetail,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //用户昵称和时间,评论内容
  Widget _combineCommentUserDate() {
    return Container(
      width: ScreenUtil().setWidth(586),
      padding: const EdgeInsets.only(top: 13, left: 10, bottom: 15),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Column(
        children: <Widget>[
          _commentNameAndTime(),
          _commentInfo(),
        ],
      ),
    );
  }
}
