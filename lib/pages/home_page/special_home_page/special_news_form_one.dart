import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_normal_time.dart';
import '../../../routers/application.dart';

//首页专栏一张照片的新闻iten
class SpecialNewsFormatOneItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //保证下面下划线
      child: InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/newsDetail?news_id=18');
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(15.0, 21.0, 15.0, 0.0),
            width: ScreenUtil().setWidth(750),
            height: ScreenUtil().setHeight(220),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Colors.black26, width: 1))),
            child: Row(
              children: <Widget>[
                _combineTimeTitle(),
                Expanded(
                  child: _newsImage(),
                )
              ],
            ),
          )),
    );
  }

  //显示新闻图片
  Widget _newsImage() {
    return Container(
        width: ScreenUtil().setWidth(228),
        height: ScreenUtil().setHeight(163),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Image.network(
            'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1099457074,1485919230&fm=173&app=25&f=JPEG',
            fit: BoxFit.cover,
          ),
        ));
  }

  //显示标题
  Widget _newsTitle() {
    return Text(
      '最高8000元！7月15日起安徽省 贫困生可申请助学贷款',
      style: TextStyle(fontSize: ScreenUtil().setSp(32)),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  //组合标题和下方时间
  Widget _combineTimeTitle() {
    return Container(
      padding: const EdgeInsets.only(right: 23, bottom: 0),
      width: ScreenUtil().setWidth(440),
      child: Column(
        children: <Widget>[
          _newsTitle(),
          Expanded(
            child: SpecialNormalTime(
              time: 2,
              watchTimes: 1265,
              goodLook: 1265,
            ),
          ),
        ],
      ),
    );
  }
}
