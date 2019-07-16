import 'package:flutter/material.dart';

Set dict = Set();
bool loadingStatus = false;

class Loading {
  static dynamic ctx;
  static void before(uri, text) {
    //使用Set有排重作用，比较使用用来管理并发请求地址。通过Set.length控制弹窗与关闭窗口。
    // 增加LoadingStatus判断是否已经有弹窗存在
    // 修改onRequest/onResponse/onError入参
    dict.add(uri); //放入set变量中
    // 已有弹窗, 则不再显示弹窗, dict.length >= 2 保证了又一个可执行弹窗即可,
    if (loadingStatus == true || dict.length >= 2) {
      return;
    }
    loadingStatus = true; //修改状态
    // 请求前显示弹窗
    showDialog(
      context: ctx,
      builder: (context) {
        return LoadingDialog(text: text);
      },
    );
  }

  static void complete(uri) {
    dict.remove(uri);
    //所有接口返回并有弹窗
    if (dict.length == 0 && loadingStatus == true) {
      loadingStatus = false; //修改状态
      //完成后关闭loading窗口
      Navigator.of(ctx, rootNavigator: true).pop();
    }
  }

  //设置一个提醒的弹窗
  static void alert(String text, int time) {
    showDialog(
      context: ctx,
      builder: (context) {
        return LoadingDialog(text: text);
      },
    );
    //延迟1.5秒关闭
    Future.delayed(Duration(seconds: time), () {
      Navigator.of(ctx, rootNavigator: true).pop();
    });
  }
}

class LoadingDialog extends Dialog {
  final String text; //获取是不是有文字参数

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.black38,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
