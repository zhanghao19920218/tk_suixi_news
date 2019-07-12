import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tk_suixi_news/model/server_section_model.dart';
import 'package:tk_suixi_news/pages/server_page/server_page_section_item.dart';

//服务
class SerivcePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('服务'),
        centerTitle: true,
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            _scoresShop(),
            _serverListItem()
          ],
        )
      ),
    );
  }

  //第一个积分商城列表
  Widget _scoresShop() {
    return InkWell(
      onTap: () {
        print('点击了积分商城');
      },
      child: Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(222),
        child: Image.asset(
          'lib/assets/score_shop.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  //显示融媒体
  Widget _serverListItem() {
    List<ServerSectionModel> list = [
      ServerSectionModel('lib/assets/weibo.png', '看濉溪', '看濉溪'),
      ServerSectionModel('lib/assets/weibo.png', '看濉溪', '看濉溪'),
      ServerSectionModel('lib/assets/weibo.png', '看濉溪', '看濉溪'),
      ServerSectionModel('lib/assets/weibo.png', '看濉溪', '看濉溪'),
      ServerSectionModel('lib/assets/weibo.png', '看濉溪', '看濉溪'),
      ServerSectionModel('lib/assets/weibo.png', '看濉溪', '看濉溪'),
    ];

    return ServerPageSectionItem(
      model: ServerSectionListModel(list, ''),
    );
  }
}
