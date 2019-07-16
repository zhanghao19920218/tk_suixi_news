import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/provide/sign_up_page_provider.dart';

TextStyle style = TextStyle(
    fontSize: ScreenUtil().setSp(24), color: Color.fromRGBO(153, 153, 153, 1));

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '立即注册',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 38, right: 38),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _logo(),
                _phoneMobileL(context),
                _mobileCodeL(context),
                _passwordTextF(context),
                _confirmPasswordF(context),
                _signInButton(context),
                _combineBackLoginWidgets(),
              ],
            ),
          )),
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
          onChanged: (text) {
            Provider.of<SignUpPageProvider>(context).changeMobileNumber(text); //更改手机号码
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
          onChanged: (text){
            Provider.of<SignUpPageProvider>(context).changeMobileCode(text); //更改手机号码
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
            onTap: (){
              Provider.of<SignUpPageProvider>(context).sendMobileCode(context); //发送验证码
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
          onChanged: (text){
            Provider.of<SignUpPageProvider>(context).changePassword(text); //更改密码
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '请输入密码',
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
          onChanged: (text){
            Provider.of<SignUpPageProvider>(context).confirmDetailPassword(text); //更改确认密码
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '请确认密码',
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
  Widget _signInButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      height: 44,
      width: ScreenUtil().setWidth(600),
      child: RaisedButton(
        child: Text(
          '注 册',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
        ),
        color: Color.fromRGBO(255, 74, 92, 1),
        onPressed: () {
          print('注册按钮点击');
          Provider.of<SignUpPageProvider>(context).signInImmdiate(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
    );
  }

  //注册按钮的
  Widget _licenseInkWell() {
    return InkWell(
      onTap: (){
        // print('注册信息');
        // Provider.of(context)
      },
      child: Container(
        width: 26,
        height: 26,
        child: Center(
          child: Image.asset(
            'lib/assets/login_assets/unchoose.png',
            width: 13,
            height: 13,
          ),
        ),
      ),
    );
  }

  //注册的同意的内容
  Widget _licenseNormalL() {
    return Text(
      '注册即同意',
      style: style,
    );
  }

  //濉溪发布的协议
  Widget _detailLicensW() {
    return InkWell(
      child: Text('濉溪发布用户服务协议',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(24),
              color: Color.fromRGBO(61, 143, 234, 1))),
    );
  }

  //组合返回的控件
  Widget _combineBackLoginWidgets() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: Row(
        children: <Widget>[
          _licenseInkWell(),
          _licenseNormalL(),
          _detailLicensW(),
        ],
      ),
    );
  }
}
