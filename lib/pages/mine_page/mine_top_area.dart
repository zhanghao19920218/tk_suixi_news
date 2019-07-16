import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/routers/application.dart';

class MinePageTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(590),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _backgroundImage(),
          _topTitleButton(),
          _sendButton(context),
          _userAvatar(),
          _userName(),
          _userPhone(),
          _scoreInkWell()
        ],
      ),
    );
  }

  //设置背景图片
  Widget _backgroundImage() {
    return Image.asset(
      'lib/assets/mine_page_header.png',
      fit: BoxFit.fill,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(570),
    );
  }

  //上方的濉溪发布Text和按钮
  Widget _topTitleButton() {
    return Positioned(
      top: 35,
      child: Text(
        '濉溪发布',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(36),
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }

  //设置右侧的发布按钮
  //设置发布按钮
  Widget _sendButton(context) {
    return Positioned(
        right: 23,
        top: 35,
        child: InkWell(
          onTap: (){
            Application.router.navigateTo(context, '/personEditPage');
          },
          child: Icon(
            Icons.settings,
            color: Colors.white,
            size: 30.0,
          ),
        ));
  }

  //用户头像
  Widget _userAvatar() {
    return Positioned(
      top: 94,
      child: Container(
        width: 80,
        height: 80,
        child: CircleAvatar(
          backgroundImage: AssetImage('lib/assets/place_holder_image.png'),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://b-ssl.duitang.com/uploads/item/201703/31/20170331231807_BPdHz.thumb.700_0.jpeg'),
            radius: 40,
          ),
          // child: Image.network(
          //   'https://b-ssl.duitang.com/uploads/item/201703/31/20170331231807_BPdHz.thumb.700_0.jpeg',
          //   fit: BoxFit.cover,
          // ),
          // radius: ScreenUtil().setWidth(74),
        ),
        decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage('lib/assets/place_holder_image.png')),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                color: Color.fromRGBO(255, 105, 101, 1.0), width: 3)),
      ),
    );
  }

  //用户名称
  Widget _userName() {
    return Positioned(
      top: 189,
      child: Text(
        '用户名',
        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //手机号码
  Widget _userPhone() {
    return Positioned(
        top: 217,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 49, 78, 1),
              borderRadius: BorderRadius.circular(12.0)),
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(48),
          child: Center(
            child: Text('13812345678',
                style: TextStyle(
                    color: Color.fromRGBO(255, 158, 168, 1),
                    fontSize: ScreenUtil().setSp(24))),
          ),
        ));
  }

  //设置积分按钮
  Widget _scoreInkWell() {
    return Positioned(
      bottom: 0,
      child: RaisedButton(
        color: Colors.white,
        splashColor: Colors.white, // 波纹颜色
        onPressed: () {
          print('点击积分按钮');
        },
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0)),
        child: _scoresTitle(),
      ),
    );
  }

  //积分按钮的标题
  Widget _scoresTitle() {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.radio_button_checked,
            size: 30,
          ),
          Container(
            width: 6,
          ),
          Text('积分', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
          Container(
            width: 8,
          ),
          Text('132773',
              style: TextStyle(
                  color: Color.fromRGBO(153, 153, 153, 1),
                  fontSize: ScreenUtil().setSp(28))),
        ],
      ),
    );
  }
}
