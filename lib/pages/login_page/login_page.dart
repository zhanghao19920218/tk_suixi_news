import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/config/progress_hud.dart';
import 'package:tk_suixi_news/routers/application.dart';
import 'package:tk_suixi_news/provide/login_page_provider.dart';

TextStyle style = TextStyle(
    fontSize: ScreenUtil().setSp(24), color: Color.fromRGBO(153, 153, 153, 1));

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //设置全局的适配750x1334
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    //初始化Loading的context
    Loading.ctx = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '登录',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 38, right: 38),
          child: Column(
            children: <Widget>[
              _loginLogo(),
              _phoneMobileL(context),
              Container(
                height: ScreenUtil().setHeight(30),
              ),
              _passwordTextF(context),
              _loginButton(context),
              _combineSignAndForget(context),
              Container(
                height: ScreenUtil().setHeight(183),
              ),
              _loginTitle(),
              _combineButton()
            ],
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  //登录的logo
  Widget _loginLogo() {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(350),
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
      height: ScreenUtil().setHeight(88),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color.fromRGBO(245, 245, 245, 1)),
      child: Center(
        child: CupertinoTextField(
          onChanged: (String text) {
            //手机号码的内容
            Provider.of<LoginPageProvider>(context).changeUsermobile(text);
          },
          decoration:
              BoxDecoration(border: Border.all(color: Colors.transparent)),
          placeholder: '输入手机号',
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
          prefix: Icon(
            Icons.phone_iphone,
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

  //输入密码
  Widget _passwordTextF(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: ScreenUtil().setHeight(88),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: Color.fromRGBO(245, 245, 245, 1)),
      child: Center(
        child: CupertinoTextField(
          onChanged: (String text) {
            //手机号码的内容
            Provider.of<LoginPageProvider>(context).changeUserpasswords(text);
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

  //登录按钮
  Widget _loginButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      height: ScreenUtil().setHeight(120),
      width: ScreenUtil().setWidth(600),
      child: RaisedButton(
        child: Text(
          '登录',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.white),
        ),
        color: Color.fromRGBO(255, 74, 92, 1),
        onPressed: () {
          Provider.of<LoginPageProvider>(context).loginUserPageWith(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
      ),
    );
  }

  //忘记密码
  Widget _forgetButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print('点击了忘记密码按钮');
        Application.router.navigateTo(context, '/userForgetPassword');
      },
      child: Text(
        '忘 记 密 码',
        style: style,
      ),
    );
  }

  //立即注册
  Widget _signInButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print('点击了立即注册按钮');
        Application.router.navigateTo(context, '/userSignInPage');
      },
      child: Text(
        '立 即 注 册',
        style: style,
      ),
    );
  }

  //组合立即注册和忘记密码按钮
  Widget _combineSignAndForget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _forgetButton(context),
          ),
          _signInButton(context)
        ],
      ),
    );
  }

  //第三方登录的按钮
  //QQ登录按钮
  Widget _qqLoginButton() {
    return InkWell(
      onTap: () {
        print('QQ登录');
      },
      child: Image.asset(
        'lib/assets/login_assets/1.png',
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(80),
      ),
    );
  }

  //微信登录按钮
  Widget _wechatButton() {
    return InkWell(
      onTap: () {
        print('微信登录');
      },
      child: Image.asset(
        'lib/assets/login_assets/2.png',
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(80),
      ),
    );
  }

  //微博登录
  Widget _sinaButton() {
    return InkWell(
      onTap: () {
        print('微博登录');
      },
      child: Image.asset(
        'lib/assets/login_assets/3.png',
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setHeight(80),
      ),
    );
  }

  //组合下方的按钮
  Widget _combineButton() {
    return Container(
      // height: ScreenUtil().setHeight(80),
      padding: const EdgeInsets.only(left: 38, right: 38, bottom: 50),
      child: Row(
        children: <Widget>[
          _qqLoginButton(),
          Expanded(
            child: Container(),
          ),
          _wechatButton(),
          Expanded(
            child: Container(),
          ),
          _sinaButton()
        ],
      ),
    );
  }

  //显示第三方登录标题
  Widget _loginTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Text(
        '第三方登录',
        style: style,
      ),
    );
  }
}
