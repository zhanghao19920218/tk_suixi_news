import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SpecialDiySwiperItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750.0),
      height: ScreenUtil().setHeight(376.0),
      color: Colors.white,
      child: Swiper(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Image.network(
            'https://cdn.jiemodui.com/img/Public/Uploads/item/20190424/1556091557677850.png',
            fit: BoxFit.cover,
          );
        },
        // autoplay: true,
        pagination: SwiperPagination(alignment: Alignment.bottomRight),
      ),
    );
  }
}
