import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tk_suixi_news/pages/person_edit_page/person_edit_center.dart';
import 'package:tk_suixi_news/provide/profit_edit_page_provider.dart';

//用户个人编辑的页面
class PersonEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人资料'),
      ),
      body: Container(
        // color: Colors.white,
        child: Column(
          children: <Widget>[
            PersonEditCenter(),
            Expanded(
              child: Container(),
            ),
            _logOutButton(context),
          ],
        ),
      ),
    );
  }

  //退出登录
  Widget _logOutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        //注销token
        Provider.of<ProfitEidtPageProvider>(context).signOutPage(context);
      },
      child: Container(
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(100),
        color: Color.fromRGBO(255, 74, 92, 1),
        child: Center(
          child: Text('退 出 登 录',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(32))),
        ),
      ),
    );
  }
}
