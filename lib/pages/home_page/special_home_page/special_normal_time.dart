import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//首页的下方时间，观看数量和点赞
const style = TextStyle(color: Colors.black45); //通用的Style

class SpecialNormalTime extends StatelessWidget {
  final int time; //时间
  final int watchTimes; //观看数量
  final int goodLook; //点赞

  SpecialNormalTime({Key key, this.time, this.watchTimes, this.goodLook})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 17.0), //完成下面高度17
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          //显示时间
          Expanded(
            child: Text(
              '$time小时前',
              style: style,
            ),
          ),
          _newsNum(),
          Container(
            width: ScreenUtil().setWidth(50.0),
          ),
          //点赞数量
          _goodLook(),
        ],
      ),
    );
  }

  //观看新闻数量
  Widget _newsNum() {
    return Row(
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
          child: Text('$watchTimes', style: style),
        )
      ],
    );
  }

  //点赞的数量
  Widget _goodLook() {
    return InkWell(
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
            child: Text('$goodLook', style: style),
          )
        ],
      ),
    );
  }
}
