import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAlertSheet extends StatelessWidget {
  static const platform =
      const MethodChannel('com.example.tkSuixiNews/videoShow'); //获取平台的方法

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
            height: ScreenUtil().setHeight(10),
            color: Colors.black12,
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
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1)));
    }

    return Container(
        padding: const EdgeInsets.only(left: 13, right: 13),
        height: ScreenUtil().setHeight(100),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //如果是1拍摄就显示下个页面
              _shootVideoOrPhoto();
            }
          },
          child: Container(
            decoration: border,
            child: Center(
              child: Text(
                _list[index],
                style: TextStyle(fontSize: ScreenUtil().setSp(32)),
              ),
            ),
          ),
        ));
  }

  //跳转直播的页面
  Future<Null> _shootVideoOrPhoto() async {
    print('点击了录制视频按钮'); //点击录制视频
    try {
      //   Map<String, dynamic> map = {
      //   "address": "https://hwapi.yunshicloud.com/m87oxo/251011.m3u8"
      // };
      final int result = await platform.invokeMethod('jumpShootVideo');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'");
    }
  }
}
