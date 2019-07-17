import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_normal_time.dart';

//有三张图片的Row
class SpecialNewsFormTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15.0, 21.0, 15.0, 0.0),
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(374),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.black26, width: 1))),
        child: Column(
          children: <Widget>[
            _newsTitle(),
            Expanded(
              child: _threePictures(),
            ),
            SpecialNormalTime(
              time: '2小时前',
              watchTimes: 1265,
              goodLook: 1265,
            ),
          ],
        ),
      ),
    );
  }

  //显示标题
  Widget _newsTitle() {
    return Text(
      '安徽考生及家长注意！这6种高考骗局 千万不要被骗上当',
      style: TextStyle(fontSize: ScreenUtil().setSp(32)),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  //显示三张图片
  Widget _threePictures() {
    return Row(
      children: <Widget>[
        _singlePicture(),
        Container(
          width: ScreenUtil().setWidth(18),
        ),
        _singlePicture(),
        Container(
          width: ScreenUtil().setWidth(18),
        ),
        _singlePicture(),
      ],
    );
  }

  //显示一张图片
  Widget _singlePicture() {
    return Container(
        width: ScreenUtil().setWidth(210),
        height: ScreenUtil().setHeight(163),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1099457074,1485919230&fm=173&app=25&f=JPEG',
            fit: BoxFit.cover,
          ),
        ));
  }
}
