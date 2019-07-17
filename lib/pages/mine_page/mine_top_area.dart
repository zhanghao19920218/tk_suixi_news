import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/config/fonts.dart';
import 'package:tk_suixi_news/routers/application.dart';
import 'package:tk_suixi_news/provide/mine_info_page.dart';

class MinePageTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _mineInfoPage(context);
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
    return Positioned(top: 35, child: ImageLogo.share.logo);
  }

  //设置右侧的发布按钮
  //设置发布按钮
  Widget _sendButton(context) {
    return Positioned(
        right: 23,
        top: 35,
        child: InkWell(
          onTap: () {
            // Application.router.navigateTo(context, '/personEditPage');
          },
          child: Icon(
            Icons.settings,
            color: Colors.white,
            size: 30.0,
          ),
        ));
  }

  //用户头像
  Widget _userAvatar(BuildContext context, String avatar) {
    return Positioned(
      top: 94,
      child: Container(
        width: 80,
        height: 80,
        child: InkWell(
          onTap: () {
            print('点击进入个人信息编辑');
            Application.router.navigateTo(context, '/personEditPage');
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage.assetNetwork(
              width: 40,
              height: 40,
              placeholder: 'lib/assets/avatar_default.png',
              image: avatar,
              fit: BoxFit.cover,
            ),
          ),
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
  Widget _userName(BuildContext context) {
    return Positioned(
      top: 189,
      child: Text(
        Provider.of<UserMinedInfoProvider>(context).model.username,
        style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //手机号码
  Widget _userPhone(BuildContext context, String mobile) {
    return Positioned(
        top: 217,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 49, 78, 1),
              borderRadius: BorderRadius.circular(12.0)),
          width: ScreenUtil().setWidth(200),
          height: ScreenUtil().setHeight(48),
          child: Center(
            child: Text(
                mobile,
                style: TextStyle(
                    color: Color.fromRGBO(255, 158, 168, 1),
                    fontSize: ScreenUtil().setSp(24))),
          ),
        ));
  }

  //设置积分按钮
  Widget _scoreInkWell(BuildContext context, int score) {
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
        child: _scoresTitle(context, score),
      ),
    );
  }

  //积分按钮的标题
  Widget _scoresTitle(BuildContext context, int score) {
    return Container(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Image.asset(
            'lib/assets/gold_coins.png',
            width: 13,
            height: 15,
          ),
          Container(
            width: 6,
          ),
          Text('积分', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
          Container(
            width: 8,
          ),
          Text('${score}',
              style: TextStyle(
                  color: Color.fromRGBO(153, 153, 153, 1),
                  fontSize: ScreenUtil().setSp(28))),
        ],
      ),
    );
  }

  //请求个人信息页面
  Widget _mineInfoPage(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(590),
      color: Colors.white,
      child: StreamBuilder(
        stream: Provider.of<UserMinedInfoProvider>(context).stream,
        builder: (BuildContext context,
            AsyncSnapshot<UserInfomrationModel> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                _backgroundImage(),
                _topTitleButton(),
                _sendButton(context),
                _userName(context),
                _userAvatar(context, snapshot.data.avatar),
                _userPhone(context, snapshot.data.mobile),
                _scoreInkWell(context, snapshot.data.scores)
              ],
            );
          } else {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                _backgroundImage(),
                _topTitleButton(),
                _sendButton(context),
                _userName(context),
                _userAvatar(context, ''),
                _userPhone(context, ''),
                _scoreInkWell(context, 0)
              ],
            );
          }
        },
      ),
    );
  }
}
