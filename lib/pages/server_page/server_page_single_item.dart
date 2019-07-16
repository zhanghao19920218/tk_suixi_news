import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/config/fonts.dart';
import 'package:tk_suixi_news/model/server_section_model.dart'; //导入UI界面的图

class ServerPageSingleItem extends StatelessWidget {
  final ServerSectionModel model;

  ServerPageSingleItem({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('点击了服务内容');
      },
      child: Container(
        width: ScreenUtil().setWidth(330),
        height: ScreenUtil().setHeight(150),
        padding: const EdgeInsets.fromLTRB(20, 18, 13, 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(245, 245, 245, 1), //圆角为10
        ),
        child: Row(
          children: <Widget>[_iconImage(), _titleAndSubTitle()],
        ),
      ),
    );
  }

  //里面显示的image
  Widget _iconImage() {
    return Image.asset(
      model.imageName,
      width: ScreenUtil().setWidth(80),
      height: ScreenUtil().setHeight(80),
    );
  }

  //显示标题信息
  Widget _titleAndSubTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            model.title,
            style: Fonts.share.style1,
          ),
          Container(
            height: ScreenUtil().setHeight(10),
          ),
          Text(model.subTitle, style: Fonts.share.style2),
        ],
      ),
    );
  }
}
