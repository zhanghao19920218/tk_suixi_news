import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/provide/found_password_page_provider.dart';

class ForgetPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          '忘记密码',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 38, right: 38),
        child: Column(
          children: <Widget>[
            _logo(),
            _phoneMobileL(context),
            _mobileCodeL(context),
            _passwordTextF(context),
            _confirmPasswordF(context),
            _changePasswordButton(context),
          ],
        ),
      ),
    );
  }


   //logo
  Widget _logo() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(330),
      child: Center(
        child: Image.asset(
          'lib/assets/login_assets/logo.png',
          width: ScreenUtil().setWidth(139),
          height: ScreenUtil().setHeight(117),
        ),
      ),
    );
  }

   //输入手机号码
  Widget _phoneMobileL(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color.fromRGBO(245, 245, 245, 1)),
      child: Center(
        child: CupertinoTextField(
          onChanged: (content) {
            Provider.of<FoundPasswordPageProvider>(context).changeMobileNumber(content);
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '输入手机号',
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          prefix: Icon(
            Icons.phone_iphone,
            size: 20,
            color: Color.fromRGBO(255, 74, 92, 1),
          ),
          suffix: Icon(
            Icons.offline_pin,
            color: Color.fromRGBO(255, 74, 92, 1),
          ),
        ),
      ),
    );
  }

  //手机验证码
  Widget _mobileCodeL(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 15),
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color.fromRGBO(245, 245, 245, 1)),
      child: Center(
        child: CupertinoTextField(
          onChanged: (content) {
            Provider.of<FoundPasswordPageProvider>(context).changeMobileCode(content);
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '请输入验证码',
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          prefix: Icon(
            Icons.verified_user,
            size: 20,
            color: Color.fromRGBO(255, 74, 92, 1),
          ),
          suffix: InkWell(
            onTap: () {
              Provider.of<FoundPasswordPageProvider>(context).sendMobileCode(context);
            },
            child: Text(
              '发送验证码',
              style: TextStyle(color: Color.fromRGBO(255, 74, 92, 1)),
            ),
          ),
        ),
      ),
    );
  }

  //请输入密码
  Widget _passwordTextF(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 15),
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color.fromRGBO(245, 245, 245, 1)),
      child: Center(
        child: CupertinoTextField(
          onChanged: (content) {
            Provider.of<FoundPasswordPageProvider>(context).changePassword(content);
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '请输入新密码',
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          prefix: Icon(
            Icons.lock_outline,
            color: Color.fromRGBO(255, 74, 92, 1),
          ),
        ),
      ),
    );
  }

  //请确认密码
  Widget _confirmPasswordF(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 15),
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color.fromRGBO(245, 245, 245, 1)),
      child: Center(
        child: CupertinoTextField(
          onChanged: (content) {
            Provider.of<FoundPasswordPageProvider>(context).confirmDetailPassword(content);
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '请确认新密码',
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          prefix: Icon(
            Icons.lock_outline,
            color: Color.fromRGBO(255, 74, 92, 1),
          ),
        ),
      ),
    );
  }

  //注册按钮
  Widget _changePasswordButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      height: 44,
      width: ScreenUtil().setWidth(600),
      child: RaisedButton(
        child: Text(
          '修 改 密 码',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
        ),
        color: Color.fromRGBO(255, 74, 92, 1),
        onPressed: () {
          Provider.of<FoundPasswordPageProvider>(context).changPasswordImmdiate(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
    );
  }

}