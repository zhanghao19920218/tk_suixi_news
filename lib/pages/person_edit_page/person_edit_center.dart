import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonEditCenter extends StatelessWidget {
  final style = TextStyle(fontSize: ScreenUtil().setSp(28));

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(245, 245, 245, 1),
      child: _containers(),
    );
  }

  //显示移动效果
  Widget _containers() {
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 15, right: 15),
      padding: const EdgeInsets.only(left: 16, right: 16),
      height: ScreenUtil().setHeight(420),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          _headerItem(),
          _nickNameItem(),
          _mobilePhoneItem(),
          _changePasswords(),
        ],
      ),
    );
  }

  //显示第一个头像Item
  Widget _headerItem() {
    return Container(
      height: ScreenUtil().setHeight(104),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(238, 238, 238, 1), width: 1))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '头像',
              style: style,
            ),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://b-ssl.duitang.com/uploads/item/201603/16/20160316192951_nF4jS.jpeg'),
            radius: ScreenUtil().setWidth(38),
          )
        ],
      ),
    );
  }

  //显示昵称
  Widget _nickNameItem() {
    return Container(
      height: ScreenUtil().setHeight(104),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(238, 238, 238, 1), width: 1))),
      child: Row(
        children: <Widget>[
          Text(
            '昵称',
            style: style,
          ),
          Expanded(
            child: CupertinoTextField(
              style: style,
              textAlign: TextAlign.right,
              placeholder: '输入昵称',
              maxLines: 1,
              decoration: BoxDecoration(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  //手机号
  Widget _mobilePhoneItem() {
    return Container(
      height: ScreenUtil().setHeight(104),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(238, 238, 238, 1), width: 1))),
      child: Row(
        children: <Widget>[
          Text(
            '手机号',
            style: style,
          ),
          Expanded(
            child: CupertinoTextField(
              style: style,
              textAlign: TextAlign.right,
              placeholder: '请绑定手机号码',
              maxLines: 1,
              decoration: BoxDecoration(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  //修改密码
  Widget _changePasswords() {
    return Container(
      height: ScreenUtil().setHeight(104),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(238, 238, 238, 1), width: 1))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '密码',
              style: style,
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(150),
            child: InkWell(
              onTap: () {
                print('点击了修改密码');
              },
              child: Text('修改密码',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 74, 92, 1),
                      fontSize: ScreenUtil().setSp(28))),
            ),
          ),
        ],
      ),
    );
  }
}
