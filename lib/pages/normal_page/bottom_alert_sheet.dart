import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/config/share_prefrence.dart';
import 'package:tk_suixi_news/routers/application.dart';

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
          _alertViewItem(0, context),
          _alertViewItem(1, context),
          Container(
            height: ScreenUtil().setHeight(10),
            color: Colors.black12,
          ),
          _alertViewItem(2, context),
        ],
      ),
    );
  }

  //设置一个Item
  Widget _alertViewItem(int index, BuildContext context) {
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
              _shootVideoOrPhoto(context);
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
  Future<Null> _shootVideoOrPhoto(BuildContext context) async {
    print('点击了录制视频按钮'); //点击录制视频

    String token = await Prefenerce.share.getToken();

    try {
      //传递里面参数
      Map<String, dynamic> map = {"token": token};
      final result = await platform.invokeMethod('jumpShootVideo', map);
      /*
       * 获取不成功进行
       */
      if (result['isSuccess'] != 'success') {
        Loading.alert('上传视频失败', 1);
        Navigator.of(context).pop();
        return;
      }

      if (result['image'] == '1') {
        /*
         * 拍照成功进行照片刷新 
         */
        print('获取的照片的地址: ${result['imageUrl']}');

        Application.router.navigateTo(context, '/videoSendPage');
      } else {
        /*
        * 录取视频成功进行上传
        */
        print('拍照成功');
        String imageUrl = result['imageUrl'];
        String videoUrl = result['videoUrl'];
        String videoTimeLength = result['videoTimeLength'];
        Application.router.navigateTo(
            context,
            "/videoSendPage" +
                "?videoUrl=${Uri.encodeComponent(videoUrl)}&imageUrl=${Uri.encodeComponent(imageUrl)}&timeLength=${Uri.encodeComponent(videoTimeLength)}");
      }
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'");
    }
  }
}
