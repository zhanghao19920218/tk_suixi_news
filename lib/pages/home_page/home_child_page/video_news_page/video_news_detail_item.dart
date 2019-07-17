import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/pages/home_page/special_home_page/special_normal_time.dart';

class HomeChildVideoNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //保证下面下划线
      child: InkWell(
          onTap: () {
            // Application.router.navigateTo(context, '/newsDetail?news_id=18');
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
                Expanded(
                  child: _videoImage(),
                ),
                _combineTimeTitle(),
              ],
            ),
          )),
    );
  }

  //显示一个ImageView和一个时间
  Widget _videoImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: Image.network(
        'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3882265467,3924971696&fm=27&gp=0.jpg',
        width: ScreenUtil().setWidth(228),
        height: ScreenUtil().setHeight(164),
        fit: BoxFit.cover,
      ),
    );
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
      padding: const EdgeInsets.only(left: 23, bottom: 0),
      width: ScreenUtil().setWidth(440),
      child: Column(
        children: <Widget>[
          _newsTitle(),
          Expanded(
            child: SpecialNormalTime(
              time: '2小时前',
              watchTimes: 1265,
              goodLook: 1265,
            ),
          ),
        ],
      ),
    );
  }
}
