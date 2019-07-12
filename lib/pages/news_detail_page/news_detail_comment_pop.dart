import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//评论底部弹窗
class NewsDetailCommnetPopMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: Container(
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(100),
          padding: const EdgeInsets.only(left: 13.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _textField(),
              Expanded(
                child: _sendButton(),
              )
            ],
          )),
    );
  }

  //显示里面的textField
  Widget _textField() {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(5)),
      width: ScreenUtil().setWidth(610.0),
      height: ScreenUtil().setHeight(70.0),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: CupertinoTextField(
        autofocus: true,
        placeholder: '发布评论...',
        decoration: BoxDecoration(color: Color.fromRGBO(245, 245, 245, 1),),
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //发布按钮
  Widget _sendButton() {
    return Container(
      child: InkWell(
        onTap: () {
          print('点击了发布按钮');
        },
        child: Center(
          child: Text(
            '发布',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: Color.fromRGBO(255, 74, 92, 1)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
