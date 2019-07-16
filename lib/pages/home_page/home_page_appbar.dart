import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:tk_suixi_news/pages/normal_page/bottom_alert_sheet.dart';

//首页的搜索栏以及拍照按钮
class HomePageAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750.0),
      height: ScreenUtil().setHeight(100.0),
      color: Color.fromRGBO(255, 82, 84, 1.0),
      child: Row(
        children: <Widget>[_searchBar(), Expanded(child: _sendButton(context),)],
      ),
    );
  }

  //搜索栏
  Widget _searchBar() {
    return Container(
      //设置外边距
      margin: const EdgeInsets.only(left: 13.0),
      width: ScreenUtil().setWidth(600),
      height: ScreenUtil().setHeight(60.0),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10.0, right: 10.0), //距离每一个边都是10
      //设置周围的边
      decoration: BoxDecoration(
        //设置圆角为5.0
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.white,
      ),
      child: CupertinoTextField(
        prefix: Icon(Icons.search),
        maxLines: 1, //只有一个TextField
        placeholder: '安徽高考 : 6月23日放榜 | 濉溪县九大措施助力',
        style: TextStyle(fontSize: ScreenUtil().setSp(24.0)),
        decoration: BoxDecoration(color: Colors.white),
        autofocus: false,
        onChanged: (context) {},
      ),
    );
  }

  //设置发布按钮
  Widget _sendButton(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(0),
        // padding: const EdgeInsets.fromLTRB(20.0, 0, 10.0, 0),
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
}
