import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAlertSheet extends StatelessWidget {
  final List<String> _list = ['拍摄', '从手机相册选择', '取消'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(311),
      width: ScreenUtil().setWidth(750),
      child: Column(
        children: <Widget>[
          _alertViewItem(0),
          _alertViewItem(1),
          Container(
            height: ScreenUtil().setHeight(10),color: Colors.black12,
          ),
          _alertViewItem(2),
        ],
      ),
    );
  }

  //设置一个Item
  Widget _alertViewItem(int index) {
    BoxDecoration border = null;
    if (index == 0) {
      border = BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color:Colors.black12, width: 1)));
    }

    return Container(
      padding: const EdgeInsets.only(left: 13, right: 13),
      height: ScreenUtil().setHeight(100),
      child: Container(
        decoration: border,
        child: Center(
          child: Text(
            _list[index],
            style: TextStyle(fontSize: ScreenUtil().setSp(32)),
          ),
        ),
      ),
    );
  }
}
