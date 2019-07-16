import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/model/server_section_model.dart';
import 'package:tk_suixi_news/pages/server_page/server_page_single_item.dart';

class ServerPageSectionItem extends StatelessWidget {
  //需要一个ListView
  final ServerSectionListModel model;

  ServerPageSectionItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      child: Column(
        children: <Widget>[
          _sectionImage(), 
          _sectionView(),
        ],
      ),
    );
  }

  //section上方的标题
  Widget _sectionImage() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 15),
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(750),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Image.asset('lib/assets/title_server_sec.png', fit:BoxFit.contain),
      // child: Image.asset(
      //   '',
      //   fit: BoxFit.cover,
      // ),
    );
  }

  //section里面的WrapView
  Widget _sectionView() {
    return Wrap(
      children: model.list.map((child) {
        return ServerPageSingleItem(
          model: child,
        );
      }).toList(),
      runSpacing: 15,
      spacing: 15,
    );
  }
}
