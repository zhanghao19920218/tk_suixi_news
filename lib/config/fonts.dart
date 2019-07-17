import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fonts {
  static Fonts share = Fonts();

  //服务页面的textStyle
  TextStyle style1 = TextStyle(fontSize: ScreenUtil().setSp(26));

  TextStyle style2 = TextStyle(fontSize: ScreenUtil().setSp(22), color: Color.fromRGBO(153, 153, 153, 1));
}

//导航栏上面的ImageView
class ImageLogo {
  static ImageLogo share = ImageLogo();

  //标题的logo
  Widget get logo {
    return Image.asset(
      'lib/assets/navigationBarTitle.png',
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(40),
    );
  }
}