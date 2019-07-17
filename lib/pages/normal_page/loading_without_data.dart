import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//暂无数据s
Widget emptyDataWidget() {
  return Container(
    child: Center(
      child: Image.asset(
        'lib/assets/no_data_contain.png',
        width: ScreenUtil().setWidth(374),
        height: ScreenUtil().setHeight(374),
      ),
    ),
  );
}
